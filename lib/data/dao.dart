import 'dart:async';

import 'package:drift/drift.dart';

import '../domain/models.dart';
import '../domain/order_status.dart';
import '../domain/repository.dart';
import 'database.dart';
import 'tables.dart';

part 'dao.g.dart';

/// Consultas de lectura (streams) usadas por los ViewModels.
@DriftAccessor(tables: [
  Clientes,
  Equipos,
  Ordenes,
  Tecnicos,
  Trabajos,
  Repuestos,
  RepuestosUsados,
])
class WorkshopDao extends DatabaseAccessor<AppDatabase> with _$WorkshopDaoMixin {
  WorkshopDao(super.db);

  JoinedSelectStatement orderJoinQuery() => select(ordenes).join([
        innerJoin(equipos, equipos.id.equalsExp(ordenes.equipoId)),
        innerJoin(clientes, clientes.id.equalsExp(equipos.clienteId)),
        leftOuterJoin(
          tecnicos,
          tecnicos.id.equalsExp(ordenes.tecnicoResponsableId),
        ),
      ]);

  Stream<List<OrderSummary>> watchOrders({
    OrderStatus? status,
    int? tecnicoId,
    bool openOnly = false,
    int? equipoId,
    int? clienteId,
  }) {
    final query = orderJoinQuery();

    final filters = <Expression<bool>>[];
    if (status != null) {
      filters.add(ordenes.estado.equals(status.dbName));
    }
    if (tecnicoId != null) {
      filters.add(ordenes.tecnicoResponsableId.equals(tecnicoId));
    }
    if (equipoId != null) {
      filters.add(equipos.id.equals(equipoId));
    }
    if (clienteId != null) {
      filters.add(clientes.id.equals(clienteId));
    }
    if (openOnly) {
      filters.add(
        ordenes.estado.isIn(
          OrderStatus.values.where((s) => s.isOpen).map((s) => s.dbName).toList(),
        ),
      );
    }
    if (filters.isNotEmpty) {
      query.where(filters.reduce((a, b) => a & b));
    }
    // Orden del flujo (recibida primero), no alfabético por el texto del estado.
    final statusOrder = CaseWhenExpression<int>(cases: [
      for (final s in OrderStatus.values)
        CaseWhen(ordenes.estado.equals(s.dbName), then: Constant(s.index)),
    ]);
    query.orderBy([
      OrderingTerm.asc(statusOrder),
      OrderingTerm.desc(ordenes.fechaRecepcion),
    ]);

    return query.watch().map((rows) => rows.map(_toSummary).toList());
  }

  OrderSummary _toSummary(TypedResult row) {
    final orden = row.readTable(ordenes);
    final equipo = row.readTable(equipos);
    final cliente = row.readTable(clientes);
    final tecnico = row.readTableOrNull(tecnicos);
    return OrderSummary(
      id: orden.id,
      equipoId: equipo.id,
      fallaReportada: orden.fallaReportada,
      estado: orden.estado,
      notas: orden.notas,
      fechaRecepcion: orden.fechaRecepcion,
      fechaCierre: orden.fechaCierre,
      tecnicoId: tecnico?.id,
      tecnicoNombre: tecnico?.nombre,
      clienteNombre: cliente.nombre,
      clienteTelefono: cliente.telefono,
      tipo: equipo.tipo,
      marca: equipo.marca,
      modelo: equipo.modelo,
      numeroSerie: equipo.numeroSerie,
    );
  }

  Stream<OrderDetail?> watchOrderDetail(int orderId) {
    final summaryStream = (orderJoinQuery()
          ..where(ordenes.id.equals(orderId)))
        .watch()
        .map((rows) => rows.isEmpty ? null : _toSummary(rows.first));

    final workStream = (select(trabajos)
          ..where((t) => t.ordenId.equals(orderId))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .watch()
        .map(
          (rows) => rows
              .map(
                (t) => WorkItem(
                  id: t.id,
                  descripcion: t.descripcion,
                  costoManoObra: t.costoManoObra,
                ),
              )
              .toList(),
        );

    final partsQuery = select(repuestosUsados).join([
      innerJoin(repuestos, repuestos.id.equalsExp(repuestosUsados.repuestoId)),
    ])
      ..where(repuestosUsados.ordenId.equals(orderId))
      ..orderBy([OrderingTerm.asc(repuestosUsados.id)]);

    final partsStream = partsQuery.watch().map(
          (rows) => rows
              .map((row) {
                final used = row.readTable(repuestosUsados);
                final part = row.readTable(repuestos);
                return UsedPartItem(
                  id: used.id,
                  repuestoId: part.id,
                  nombre: part.nombre,
                  codigo: part.codigo,
                  cantidad: used.cantidad,
                  precioUnitario: used.precioUnitario,
                );
              })
              .toList(),
        );

    return combine3(
      summaryStream,
      workStream,
      partsStream,
      (summary, trabajos, usados) => summary == null
          ? null
          : OrderDetail(
              summary: summary,
              trabajos: trabajos,
              repuestosUsados: usados,
            ),
    );
  }

  Stream<List<Part>> watchParts() {
    final query = select(repuestos)
      ..orderBy([(p) => OrderingTerm.asc(p.nombre)]);
    return query.watch().map(
          (rows) => rows
              .map(
                (p) => Part(
                  id: p.id,
                  nombre: p.nombre,
                  codigo: p.codigo,
                  precio: p.precio,
                  existencias: p.existencias,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Part>> watchLowStockParts() => watchParts().map(
        (parts) => parts.where((p) => p.isLow).toList(),
      );

  Stream<List<TechnicianWorkload>> watchWorkload() {
    return combine2(select(tecnicos).watch(), select(ordenes).watch(), (
      techRows,
      orderRows,
    ) {
      return techRows.map((tech) {
        final own = orderRows.where((o) => o.tecnicoResponsableId == tech.id);
        int count(String dbName) => own.where((o) => o.estado == dbName).length;
        return TechnicianWorkload(
          id: tech.id,
          nombre: tech.nombre,
          abiertas: count(OrderStatus.recibida.dbName),
          enReparacion: count(OrderStatus.enReparacion.dbName),
          listas: count(OrderStatus.lista.dbName),
          entregadas: count(OrderStatus.entregada.dbName),
        );
      }).toList();
    });
  }

  Stream<List<Technician>> watchTechnicians() => select(tecnicos)
      .watch()
      .map((rows) => rows.map((t) => Technician(t.id, t.nombre)).toList());

  Stream<List<ClientOption>> watchClients() {
    final query = select(clientes).join([
      leftOuterJoin(equipos, equipos.clienteId.equalsExp(clientes.id)),
    ])
      ..orderBy([OrderingTerm.asc(clientes.nombre)]);
    return query.watch().map((rows) {
      final byId = <int, ClientOption>{};
      for (final row in rows) {
        final cliente = row.readTable(clientes);
        final hasEquipo = row.readTableOrNull(equipos) != null;
        final existing = byId[cliente.id];
        if (existing == null) {
          byId[cliente.id] = ClientOption(
            id: cliente.id,
            nombre: cliente.nombre,
            telefono: cliente.telefono,
            equiposCount: hasEquipo ? 1 : 0,
          );
        } else if (hasEquipo) {
          byId[cliente.id] = ClientOption(
            id: cliente.id,
            nombre: cliente.nombre,
            telefono: cliente.telefono,
            equiposCount: existing.equiposCount + 1,
          );
        }
      }
      return byId.values.toList();
    });
  }
}

Stream<R> combine2<A, B, R>(
  Stream<A> a,
  Stream<B> b,
  R Function(A, B) combine,
) {
  late final StreamController<R> controller;
  A? valueA;
  B? valueB;
  var hasA = false;
  var hasB = false;
  StreamSubscription<A>? subA;
  StreamSubscription<B>? subB;

  void emit() {
    if (hasA && hasB && !controller.isClosed) {
      controller.add(combine(valueA as A, valueB as B));
    }
  }

  controller = StreamController<R>(
    onListen: () {
      subA = a.listen((v) { valueA = v; hasA = true; emit(); },
          onError: controller.addError);
      subB = b.listen((v) { valueB = v; hasB = true; emit(); },
          onError: controller.addError);
    },
    onCancel: () async {
      await subA?.cancel();
      await subB?.cancel();
    },
  );
  return controller.stream;
}

Stream<R> combine3<A, B, C, R>(
  Stream<A> a,
  Stream<B> b,
  Stream<C> c,
  R Function(A, B, C) combine,
) {
  late final StreamController<R> controller;
  A? valueA;
  B? valueB;
  C? valueC;
  var hasA = false;
  var hasB = false;
  var hasC = false;
  StreamSubscription<A>? subA;
  StreamSubscription<B>? subB;
  StreamSubscription<C>? subC;

  void emit() {
    if (hasA && hasB && hasC && !controller.isClosed) {
      controller.add(combine(valueA as A, valueB as B, valueC as C));
    }
  }

  controller = StreamController<R>(
    onListen: () {
      subA = a.listen((v) { valueA = v; hasA = true; emit(); },
          onError: controller.addError);
      subB = b.listen((v) { valueB = v; hasB = true; emit(); },
          onError: controller.addError);
      subC = c.listen((v) { valueC = v; hasC = true; emit(); },
          onError: controller.addError);
    },
    onCancel: () async {
      await subA?.cancel();
      await subB?.cancel();
      await subC?.cancel();
    },
  );
  return controller.stream;
}
