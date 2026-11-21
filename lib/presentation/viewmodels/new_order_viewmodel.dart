import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/exceptions.dart';
import '../providers.dart';

class NewOrderState {
  const NewOrderState({
    this.submitting = false,
    this.error,
    this.createdOrderId,
  });

  final bool submitting;
  final String? error;
  final int? createdOrderId;

  NewOrderState copyWith({
    bool? submitting,
    String? error,
    bool clearError = false,
    int? createdOrderId,
  }) {
    return NewOrderState(
      submitting: submitting ?? this.submitting,
      error: clearError ? null : (error ?? this.error),
      createdOrderId: createdOrderId ?? this.createdOrderId,
    );
  }
}

class NewOrderViewModel extends Notifier<NewOrderState> {
  @override
  NewOrderState build() => const NewOrderState();

  void clearError() => state = state.copyWith(clearError: true);

  void reset() => state = const NewOrderState();

  Future<int?> submit({
    required String clienteNombre,
    required String clienteTelefono,
    required int? clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
    required String fallaReportada,
  }) async {
    state = state.copyWith(submitting: true, clearError: true);
    try {
      final id = await ref.read(repositoryProvider).createOrder(
            clienteNombre: clienteNombre,
            clienteTelefono: clienteTelefono,
            clienteId: clienteId,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
            fallaReportada: fallaReportada,
          );
      state = state.copyWith(submitting: false, createdOrderId: id);
      return id;
    } on WorkshopException catch (e) {
      state = state.copyWith(submitting: false, error: e.message);
      return null;
    } catch (e) {
      state = state.copyWith(submitting: false, error: 'No se pudo guardar: $e');
      return null;
    }
  }
}

final newOrderProvider =
    NotifierProvider<NewOrderViewModel, NewOrderState>(NewOrderViewModel.new);
