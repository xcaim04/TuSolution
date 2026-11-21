import '../core/constants.dart';
import 'order_status.dart';

/// Fila resumida para listados e historial (sin depender de tipos Drift).
class OrderSummary {
  const OrderSummary({
    required this.id,
    required this.equipoId,
    required this.fallaReportada,
    required this.estado,
    this.notas,
    required this.fechaRecepcion,
    this.fechaCierre,
    this.tecnicoId,
    this.tecnicoNombre,
    required this.clienteNombre,
    required this.clienteTelefono,
    required this.tipo,
    required this.marca,
    required this.modelo,
    this.numeroSerie,
  });

  final int id;
  final int equipoId;
  final String fallaReportada;
  final String estado;
  final String? notas;
  final DateTime fechaRecepcion;
  final DateTime? fechaCierre;
  final int? tecnicoId;
  final String? tecnicoNombre;
  final String clienteNombre;
  final String clienteTelefono;
  final String tipo;
  final String marca;
  final String modelo;
  final String? numeroSerie;

  OrderStatus get status => parseOrderStatus(estado);
  bool get isOpen => status.isOpen;

  String get equipoLabel => '$marca $modelo'.trim();

  @override
  String toString() => 'Orden #$id · $estado · $equipoLabel';
}

class WorkItem {
  const WorkItem({
    required this.id,
    required this.descripcion,
    required this.costoManoObra,
  });

  final int id;
  final String descripcion;
  final double costoManoObra;
}

class UsedPartItem {
  const UsedPartItem({
    required this.id,
    required this.repuestoId,
    required this.nombre,
    required this.codigo,
    required this.cantidad,
    required this.precioUnitario,
  });

  final int id;
  final int repuestoId;
  final String nombre;
  final String codigo;
  final int cantidad;
  final double precioUnitario;

  double get subtotal => cantidad * precioUnitario;
}

/// Detalle completo de una orden, con total calculado al vuelo.
class OrderDetail {
  const OrderDetail({
    required this.summary,
    required this.trabajos,
    required this.repuestosUsados,
  });

  final OrderSummary summary;
  final List<WorkItem> trabajos;
  final List<UsedPartItem> repuestosUsados;

  double get manoDeObra =>
      trabajos.fold(0.0, (sum, item) => sum + item.costoManoObra);

  double get costoRepuestos =>
      repuestosUsados.fold(0.0, (sum, item) => sum + item.subtotal);

  /// Total = Σ mano de obra + Σ(cantidad × precio congelado).
  double get total => manoDeObra + costoRepuestos;
}

class Part {
  const Part({
    required this.id,
    required this.nombre,
    required this.codigo,
    required this.precio,
    required this.existencias,
  });

  final int id;
  final String nombre;
  final String codigo;
  final double precio;
  final int existencias;

  bool get isLow => existencias <= lowStockThreshold;
}

class TechnicianWorkload {
  const TechnicianWorkload({
    required this.id,
    required this.nombre,
    required this.abiertas,
    required this.enReparacion,
    required this.listas,
    required this.entregadas,
  });

  final int id;
  final String nombre;
  final int abiertas;
  final int enReparacion;
  final int listas;
  final int entregadas;

  /// Carga activa: recibidas + en reparación + listas por entregar.
  int get activas => abiertas + enReparacion + listas;
  int get total => activas + entregadas;
}

class ClientOption {
  const ClientOption({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.equiposCount,
  });

  final int id;
  final String nombre;
  final String telefono;
  final int equiposCount;
}
