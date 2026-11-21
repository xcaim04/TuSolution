import 'models.dart';
import 'order_status.dart';

/// Contrato de persistencia del dominio (lo implementa Drift en /data).
abstract interface class WorkshopRepository {
  Stream<List<OrderSummary>> watchOrders({
    OrderStatus? status,
    int? tecnicoId,
    bool openOnly = false,
  });

  Stream<OrderDetail?> watchOrderDetail(int orderId);
  Stream<List<Part>> watchParts();
  Stream<List<Part>> watchLowStockParts();
  Stream<List<TechnicianWorkload>> watchWorkload();
  Stream<List<ClientOption>> watchClients();
  Stream<List<OrderSummary>> watchHistory({int? equipoId, int? clienteId});
  Stream<List<Technician>> watchTechnicians();

  Future<int> createOrder({
    required String clienteNombre,
    required String clienteTelefono,
    required int? clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String fallaReportada,
  });

  /// Toma la orden de forma atómica: solo puede ganar un técnico.
  Future<void> takeOrder(int orderId, int tecnicoId);

  Future<void> changeStatus(int orderId, OrderStatus next);
  Future<void> addWork(int orderId, String descripcion, double costo);

  /// Descuenta existencias y congela el precio en la misma transacción.
  Future<void> addUsedPart(int orderId, int repuestoId, int cantidad);

  Future<void> savePart({
    int? id,
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
  });

  Future<void> deletePart(int id);
}

class Technician {
  const Technician(this.id, this.nombre);

  final int id;
  final String nombre;
}
