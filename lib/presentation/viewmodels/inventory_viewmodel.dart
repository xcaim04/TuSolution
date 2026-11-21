import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/exceptions.dart';
import '../../domain/models.dart';
import '../providers.dart';

class PartsFilterNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setLowOnly(bool value) => state = value;
}

final lowStockOnlyProvider =
    NotifierProvider<PartsFilterNotifier, bool>(PartsFilterNotifier.new);

/// ViewModel del inventario; expone la lista y las acciones de alta/edición.
class InventoryViewModel extends StreamNotifier<List<Part>> {
  @override
  Stream<List<Part>> build() {
    final lowOnly = ref.watch(lowStockOnlyProvider);
    final repo = ref.watch(repositoryProvider);
    return lowOnly ? repo.watchLowStockParts() : repo.watchParts();
  }

  Future<String?> savePart({
    int? id,
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
  }) =>
      _run(
        () => ref.read(repositoryProvider).savePart(
              id: id,
              nombre: nombre,
              codigo: codigo,
              precio: precio,
              existencias: existencias,
            ),
      );

  Future<String?> deletePart(int id) =>
      _run(() => ref.read(repositoryProvider).deletePart(id));
}

final inventoryProvider =
    StreamNotifierProvider<InventoryViewModel, List<Part>>(InventoryViewModel.new);

/// Lista completa (sin filtrar) para selectores y sumatorias.
class AllPartsViewModel extends StreamNotifier<List<Part>> {
  @override
  Stream<List<Part>> build() => ref.watch(repositoryProvider).watchParts();
}

final allPartsProvider =
    StreamNotifierProvider<AllPartsViewModel, List<Part>>(AllPartsViewModel.new);

Future<String?> _run(Future<void> Function() action) async {
  try {
    await action();
    return null;
  } on WorkshopException catch (e) {
    return e.message;
  } catch (e) {
    return 'No se pudo guardar el repuesto: $e';
  }
}
