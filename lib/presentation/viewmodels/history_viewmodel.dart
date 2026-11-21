import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models.dart';
import '../providers.dart';

enum HistoryKind { equipo, cliente }

class HistoryTarget {
  const HistoryTarget(this.kind, this.id);

  final HistoryKind kind;
  final int id;

  @override
  bool operator ==(Object other) =>
      other is HistoryTarget && other.kind == kind && other.id == id;

  @override
  int get hashCode => Object.hash(kind, id);
}

class HistoryTargetNotifier extends Notifier<HistoryTarget?> {
  @override
  HistoryTarget? build() => null;

  void select(HistoryKind kind, int id) => state = HistoryTarget(kind, id);
}

final historyTargetProvider =
    NotifierProvider<HistoryTargetNotifier, HistoryTarget?>(HistoryTargetNotifier.new);

/// Historial de reparaciones del equipo o cliente seleccionado.
class HistoryViewModel extends StreamNotifier<List<OrderSummary>?> {
  @override
  Stream<List<OrderSummary>?> build() {
    final target = ref.watch(historyTargetProvider);
    if (target == null) return Stream.value(null);
    final repo = ref.watch(repositoryProvider);
    return target.kind == HistoryKind.equipo
        ? repo.watchHistory(equipoId: target.id)
        : repo.watchHistory(clienteId: target.id);
  }
}

final historyProvider =
    StreamNotifierProvider<HistoryViewModel, List<OrderSummary>?>(HistoryViewModel.new);
