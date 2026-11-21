/// Estados posibles de una orden de reparación.
enum OrderStatus {
  recibida,
  enReparacion,
  lista,
  entregada,
  cancelada;
}

/// Traducción entre el enum de dominio y la columna TEXT legible de SQLite.
extension OrderStatusX on OrderStatus {
  String get dbName => switch (this) {
        OrderStatus.recibida => 'recibida',
        OrderStatus.enReparacion => 'en_reparacion',
        OrderStatus.lista => 'lista',
        OrderStatus.entregada => 'entregada',
        OrderStatus.cancelada => 'cancelada',
      };

  String get label => switch (this) {
        OrderStatus.recibida => 'Recibida',
        OrderStatus.enReparacion => 'En reparación',
        OrderStatus.lista => 'Lista',
        OrderStatus.entregada => 'Entregada',
        OrderStatus.cancelada => 'Cancelada',
      };

  /// Abiertas = todavía requieren trabajo del taller.
  bool get isOpen => this == OrderStatus.recibida ||
      this == OrderStatus.enReparacion ||
      this == OrderStatus.lista;

  bool get isFinal => this == OrderStatus.entregada ||
      this == OrderStatus.cancelada;

  bool get allowsChanges => this == OrderStatus.enReparacion;
}

OrderStatus parseOrderStatus(String value) => switch (value) {
      'recibida' => OrderStatus.recibida,
      'en_reparacion' => OrderStatus.enReparacion,
      'lista' => OrderStatus.lista,
      'entregada' => OrderStatus.entregada,
      'cancelada' => OrderStatus.cancelada,
      _ => throw ArgumentError('Estado de orden desconocido: $value'),
    };

/// Transiciones permitidas, validadas en dominio y en el repositorio.
///
/// `en_reparacion -> cancelada` se permite únicamente si aún no se registraron
/// trabajos ni repuestos usados (ver [WorkshopRepository.changeStatus]).
const Map<OrderStatus, Set<OrderStatus>> allowedTransitions = {
  OrderStatus.recibida: {OrderStatus.enReparacion, OrderStatus.cancelada},
  OrderStatus.enReparacion: {OrderStatus.lista, OrderStatus.cancelada},
  OrderStatus.lista: {OrderStatus.entregada},
  OrderStatus.entregada: {},
  OrderStatus.cancelada: {},
};

bool canTransition(OrderStatus from, OrderStatus to) =>
    allowedTransitions[from]?.contains(to) ?? false;
