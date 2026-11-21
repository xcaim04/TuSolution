import 'package:drift/drift.dart';
import 'package:drift/native.dart' show SqliteException;

import '../domain/exceptions.dart';
import '../domain/models.dart';
import '../domain/order_status.dart';
import '../domain/repository.dart';
import 'dao.dart';
import 'database.dart';

/// Implementación Drift del repositorio. Todas las operaciones que tocan
/// varias tablas se ejecutan dentro de [AppDatabase.transaction].
class WorkshopRepositoryImpl implements WorkshopRepository {
  WorkshopRepositoryImpl(this.db) : dao = db.workshopDao;

  final AppDatabase db;
  final WorkshopDao dao;

  @override
  Stream<List<OrderSummary>> watchOrders({
    OrderStatus? status,
    int? tecnicoId,
    bool openOnly = false,
  }) =>
      dao.watchOrders(status: status, tecnicoId: tecnicoId, openOnly: openOnly);

  @override
  Stream<OrderDetail?> watchOrderDetail(int orderId) =>
      dao.watchOrderDetail(orderId);

  @override
  Stream<List<Part>> watchParts() => dao.watchParts();

  @override
  Stream<List<Part>> watchLowStockParts() => dao.watchLowStockParts();

  @override
  Stream<List<TechnicianWorkload>> watchWorkload() => dao.watchWorkload();

  @override
  Stream<List<ClientOption>> watchClients() => dao.watchClients();

  @override
  Stream<List<OrderSummary>> watchHistory({int? equipoId, int? clienteId}) =>
      dao.watchOrders(equipoId: equipoId, clienteId: clienteId);

  @override
  Stream<List<Technician>> watchTechnicians() => dao.watchTechnicians();

  Future<Orden> _order(int id) async {
    final order = await (db.select(db.ordenes)..where((o) => o.id.equals(id)))
        .getSingleOrNull();
    if (order == null) throw const NotFoundException('la orden');
    return order;
  }

  @override
  Future<int> createOrder({
    required String clienteNombre,
    required String clienteTelefono,
    required int? clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String fallaReportada,
  }) async {
    if (clienteNombre.trim().isEmpty || fallaReportada.trim().isEmpty) {
      throw const ValidationException('Nombre del cliente y falla son obligatorios.');
    }
    return db.transaction(() async {
      final resolvedClientId = clienteId ??
          await _findOrCreateClient(clienteNombre.trim(), clienteTelefono.trim());

      final equipoId = await db.into(db.equipos).insert(
            EquiposCompanion.insert(
              clienteId: resolvedClientId,
              tipo: tipo.trim(),
              marca: marca.trim(),
              modelo: modelo.trim(),
              numeroSerie: Value(numeroSerie.trim().isEmpty ? null : numeroSerie.trim()),
            ),
          );

      return db.into(db.ordenes).insert(
            OrdenesCompanion.insert(
              equipoId: equipoId,
              fallaReportada: fallaReportada.trim(),
              estado: Value(OrderStatus.recibida.dbName),
              fechaRecepcion: Value(DateTime.now()),
            ),
          );
    });
  }

  Future<int> _findOrCreateClient(String nombre, String telefono) async {
    if (telefono.isNotEmpty) {
      final found = await (db.select(db.clientes)
            ..where((c) => c.telefono.equals(telefono))
            ..limit(1))
          .getSingleOrNull();
      if (found != null) return found.id;
    }
    return db.into(db.clientes).insert(
          ClientesCompanion.insert(nombre: nombre, telefono: telefono),
        );
  }

  @override
  Future<void> takeOrder(int orderId, int tecnicoId) async {
    await db.transaction(() async {
      final order = await _order(orderId);
      if (order.tecnicoResponsableId != null) {
        throw const AlreadyAssignedException();
      }
      _ensureTransition(parseOrderStatus(order.estado), OrderStatus.enReparacion);

      // UPDATE condicional: aunque dos técnicos pulsasen a la vez, solo uno
      // logra cambiar la fila. No existe ventana de carrera.
      final updated = await (db.update(db.ordenes)
            ..where(
              (o) => o.id.equals(orderId) &
                  o.tecnicoResponsableId.isNull() &
                  o.estado.equals(OrderStatus.recibida.dbName),
            ))
          .write(
        OrdenesCompanion(
          tecnicoResponsableId: Value(tecnicoId),
          estado: Value(OrderStatus.enReparacion.dbName),
        ),
      );
      if (updated != 1) throw const AlreadyAssignedException();
    });
  }

  @override
  Future<void> changeStatus(int orderId, OrderStatus next) async {
    await db.transaction(() async {
      final order = await _order(orderId);
      final current = parseOrderStatus(order.estado);
      _ensureTransition(current, next);

      if (current == OrderStatus.enReparacion && next == OrderStatus.cancelada) {
        final hasWork = await (db.select(db.trabajos)
              ..where((t) => t.ordenId.equals(orderId))
              ..limit(1))
            .getSingleOrNull();
        final hasParts = await (db.select(db.repuestosUsados)
              ..where((u) => u.ordenId.equals(orderId))
              ..limit(1))
            .getSingleOrNull();
        if (hasWork != null || hasParts != null) {
          throw const CannotCancelStartedException();
        }
      }

      await (db.update(db.ordenes)..where((o) => o.id.equals(orderId))).write(
        OrdenesCompanion(
          estado: Value(next.dbName),
          fechaCierre:
              next.isFinal ? Value(DateTime.now()) : const Value.absent(),
        ),
      );
    });
  }

  void _ensureTransition(OrderStatus from, OrderStatus to) {
    if (!canTransition(from, to)) {
      throw InvalidTransitionException(from.label, to.label);
    }
  }

  @override
  Future<void> addWork(int orderId, String descripcion, double costo) async {
    if (descripcion.trim().isEmpty || costo <= 0) {
      throw const ValidationException('Describe el trabajo y usa un costo mayor a cero.');
    }
    await db.transaction(() async {
      final order = await _order(orderId);
      _ensureEditable(order);
      await db.into(db.trabajos).insert(
            TrabajosCompanion.insert(
              ordenId: orderId,
              descripcion: descripcion.trim(),
              costoManoObra: costo,
            ),
          );
    });
  }

  void _ensureEditable(Orden order) {
    final status = parseOrderStatus(order.estado);
    if (!status.allowsChanges) {
      throw OrderNotEditableException(status.label);
    }
  }

  @override
  Future<void> addUsedPart(int orderId, int repuestoId, int cantidad) async {
    if (cantidad <= 0) {
      throw const ValidationException('La cantidad debe ser mayor a cero.');
    }
    await db.transaction(() async {
      final order = await _order(orderId);
      _ensureEditable(order);

      final part = await (db.select(db.repuestos)
            ..where((r) => r.id.equals(repuestoId)))
          .getSingleOrNull();
      if (part == null) throw const NotFoundException('el repuesto');
      if (part.existencias < cantidad) {
        throw InsufficientStockException(
          part.nombre,
          part.existencias,
          cantidad,
        );
      }

      // Descuento condicional dentro de la transacción: nunca queda negativo.
      final updated = await (db.update(db.repuestos)
            ..where(
              (r) => r.id.equals(repuestoId) &
                  r.existencias.isBiggerOrEqualValue(cantidad),
            ))
          .write(RepuestosCompanion(existencias: Value(part.existencias - cantidad)));
      if (updated != 1) {
        throw InsufficientStockException(part.nombre, part.existencias, cantidad);
      }

      await db.into(db.repuestosUsados).insert(
            RepuestosUsadosCompanion.insert(
              ordenId: orderId,
              repuestoId: repuestoId,
              cantidad: cantidad,
              precioUnitario: part.precio,
            ),
          );
    });
  }

  @override
  Future<void> savePart({
    int? id,
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
  }) async {
    if (nombre.trim().isEmpty || codigo.trim().isEmpty) {
      throw const ValidationException('Nombre y código son obligatorios.');
    }
    if (precio <= 0 || existencias < 0) {
      throw const ValidationException('Precio debe ser positivo y stock no negativo.');
    }
    try {
      if (id == null) {
        await db.into(db.repuestos).insert(
              RepuestosCompanion.insert(
                nombre: nombre.trim(),
                codigo: codigo.trim().toUpperCase(),
                precio: precio,
                existencias: existencias,
              ),
            );
      } else {
        await (db.update(db.repuestos)..where((r) => r.id.equals(id))).write(
          RepuestosCompanion(
            nombre: Value(nombre.trim()),
            codigo: Value(codigo.trim().toUpperCase()),
            precio: Value(precio),
            existencias: Value(existencias),
          ),
        );
      }
    } on SqliteException {
      throw const ValidationException('Ya existe un repuesto con ese código.');
    }
  }

  @override
  Future<void> deletePart(int id) async {
    try {
      await (db.delete(db.repuestos)..where((r) => r.id.equals(id))).go();
    } on SqliteException {
      throw const ValidationException(
        'No se puede eliminar: el repuesto ya aparece en una orden.',
      );
    }
  }
}
