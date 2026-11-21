import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/exceptions.dart';
import '../../domain/models.dart';
import '../../domain/order_status.dart';
import '../providers.dart';

class OrdersFilter {
  const OrdersFilter({
    this.status,
    this.tecnicoId,
    this.openOnly = true,
  });

  final OrderStatus? status;
  final int? tecnicoId;
  final bool openOnly;

  OrdersFilter copyWith({
    OrderStatus? status,
    bool clearStatus = false,
    int? tecnicoId,
    bool clearTecnico = false,
    bool? openOnly,
  }) {
    return OrdersFilter(
      status: clearStatus ? null : (status ?? this.status),
      tecnicoId: clearTecnico ? null : (tecnicoId ?? this.tecnicoId),
      openOnly: openOnly ?? this.openOnly,
    );
  }
}

/// Estado de UI de los filtros (ViewModel de intención del usuario).
class OrdersFilterNotifier extends Notifier<OrdersFilter> {
  @override
  OrdersFilter build() => const OrdersFilter();

  void setStatus(OrderStatus? status) =>
      state = status == null
          ? state.copyWith(clearStatus: true)
          : state.copyWith(status: status);

  void setTecnico(int? id) => state = id == null
      ? state.copyWith(clearTecnico: true)
      : state.copyWith(tecnicoId: id);

  void setOpenOnly(bool value) => state = state.copyWith(openOnly: value);
}

final ordersFilterProvider =
    NotifierProvider<OrdersFilterNotifier, OrdersFilter>(OrdersFilterNotifier.new);

/// ViewModel del listado filtrado de órdenes.
class OrdersViewModel extends StreamNotifier<List<OrderSummary>> {
  @override
  Stream<List<OrderSummary>> build() {
    final filter = ref.watch(ordersFilterProvider);
    return ref.watch(repositoryProvider).watchOrders(
          status: filter.status,
          tecnicoId: filter.tecnicoId,
          openOnly: filter.openOnly,
        );
  }

  Future<String?> takeOrder(int orderId, int tecnicoId) =>
      _run(() => ref.read(repositoryProvider).takeOrder(orderId, tecnicoId));

  Future<String?> changeStatus(int orderId, OrderStatus status) =>
      _run(() => ref.read(repositoryProvider).changeStatus(orderId, status));

  Future<String?> addWork(int orderId, String desc, double costo) =>
      _run(() => ref.read(repositoryProvider).addWork(orderId, desc, costo));

  Future<String?> addUsedPart(int orderId, int partId, int cantidad) =>
      _run(() => ref.read(repositoryProvider).addUsedPart(orderId, partId, cantidad));
}

final ordersProvider =
    StreamNotifierProvider<OrdersViewModel, List<OrderSummary>>(OrdersViewModel.new);

/// Todas las órdenes (para el panel y el historial).
class AllOrdersViewModel extends StreamNotifier<List<OrderSummary>> {
  @override
  Stream<List<OrderSummary>> build() =>
      ref.watch(repositoryProvider).watchOrders();
}

final allOrdersProvider =
    StreamNotifierProvider<AllOrdersViewModel, List<OrderSummary>>(
        AllOrdersViewModel.new);

/// Órdenes abiertas del panel.
class PendingOrdersViewModel extends StreamNotifier<List<OrderSummary>> {
  @override
  Stream<List<OrderSummary>> build() =>
      ref.watch(repositoryProvider).watchOrders(openOnly: true);
}

final pendingOrdersProvider =
    StreamNotifierProvider<PendingOrdersViewModel, List<OrderSummary>>(
        PendingOrdersViewModel.new);

/// ViewModel del detalle de una orden (family por id).
class OrderDetailViewModel extends StreamNotifier<OrderDetail?> {
  OrderDetailViewModel(this.orderId);

  final int orderId;

  @override
  Stream<OrderDetail?> build() =>
      ref.watch(repositoryProvider).watchOrderDetail(orderId);

  Future<String?> takeOrder(int tecnicoId) => _run(
        () => ref.read(repositoryProvider).takeOrder(orderId, tecnicoId),
      );

  Future<String?> changeStatus(OrderStatus status) => _run(
        () => ref.read(repositoryProvider).changeStatus(orderId, status),
      );

  Future<String?> addWork(String desc, double costo) => _run(
        () => ref.read(repositoryProvider).addWork(orderId, desc, costo),
      );

  Future<String?> addUsedPart(int partId, int cantidad) => _run(
        () => ref.read(repositoryProvider).addUsedPart(orderId, partId, cantidad),
      );
}

final orderDetailProvider = StreamNotifierProvider.family<
    OrderDetailViewModel, OrderDetail?, int>(
  (orderId) => OrderDetailViewModel(orderId),
);

Future<String?> _run(Future<void> Function() action) async {
  try {
    await action();
    return null;
  } on WorkshopException catch (e) {
    return e.message;
  } catch (e) {
    return 'No se pudo completar la operación: $e';
  }
}
