import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants.dart';
import '../../core/format.dart';
import '../../domain/models.dart';
import '../theme.dart';
import '../viewmodels/inventory_viewmodel.dart';
import '../widgets.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partsAsync = ref.watch(inventoryProvider);
    final lowOnly = ref.watch(lowStockOnlyProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inventario',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          'Umbral crítico: $lowStockThreshold unidades o menos',
                          style: TextStyle(fontSize: 12, color: AppColors.muted),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Solo críticos',
                    onPressed: () => ref
                        .read(lowStockOnlyProvider.notifier)
                        .setLowOnly(!lowOnly),
                    icon: Icon(
                      lowOnly ? Icons.filter_alt : Icons.filter_alt_outlined,
                      color: lowOnly ? AppColors.primary : AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: partsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
                data: (parts) => parts.isEmpty
                    ? EmptyState(
                        icon: lowOnly
                            ? Icons.check_circle_outline
                            : Icons.inventory_2_outlined,
                        title: lowOnly ? 'Sin repuestos críticos' : 'Inventario vacío',
                        subtitle: lowOnly
                            ? 'Todos los repuestos tienen stock suficiente.'
                            : 'Registra tu primer repuesto con el botón +.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                        itemCount: parts.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            _PartCard(part: parts[index]),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPartDialog(context, ref),
        heroTag: 'inventory-fab',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PartCard extends ConsumerWidget {
  const _PartCard({required this.part});

  final Part part;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: part.isLow
                ? const Color(0xFFFEE2E2)
                : AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.inventory_2_outlined,
            color: part.isLow ? const Color(0xFFDC2626) : AppColors.primary,
            size: 20,
          ),
        ),
        title: Text(
          part.nombre,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        subtitle: Text(
          '${part.codigo} · ${money(part.precio)} c/u',
          style: const TextStyle(fontSize: 11),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: part.isLow
                    ? const Color(0xFFFEE2E2)
                    : const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${part.existencias} und.',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: part.isLow
                      ? const Color(0xFFB42318)
                      : const Color(0xFF047857),
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') _showPartDialog(context, ref, part: part);
                if (value == 'delete') _confirmDelete(context, ref, part);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'edit', child: Text('Editar')),
                PopupMenuItem(value: 'delete', child: Text('Eliminar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showPartDialog(BuildContext context, WidgetRef ref, {Part? part}) {
  final nombreController = TextEditingController(text: part?.nombre ?? '');
  final codigoController = TextEditingController(text: part?.codigo ?? '');
  final precioController =
      TextEditingController(text: part?.precio.toStringAsFixed(2) ?? '');
  final stockController =
      TextEditingController(text: part?.existencias.toString() ?? '');
  final formKey = GlobalKey<FormState>();

  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(part == null ? 'Nuevo repuesto' : 'Editar repuesto'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nombreController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Requerido'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: codigoController,
                decoration: const InputDecoration(labelText: 'Código'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Requerido'
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: precioController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Precio unitario',
                  prefixText: 'Q ',
                ),
                validator: (v) {
                  final value = double.tryParse(v ?? '');
                  if (value == null || value <= 0) return 'Precio inválido';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Existencias'),
                validator: (v) {
                  final value = int.tryParse(v ?? '');
                  if (value == null || value < 0) return 'Stock inválido';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
            final error = await ref.read(inventoryProvider.notifier).savePart(
                  id: part?.id,
                  nombre: nombreController.text.trim(),
                  codigo: codigoController.text.trim(),
                  precio: double.parse(precioController.text),
                  existencias: int.parse(stockController.text),
                );
            if (!dialogContext.mounted) return;
            Navigator.pop(dialogContext);
            showErrorSnack(context, error);
            if (error == null) {
              showSuccessSnack(
                context,
                part == null ? 'Repuesto registrado' : 'Repuesto actualizado',
              );
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}

void _confirmDelete(BuildContext context, WidgetRef ref, Part part) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Eliminar repuesto'),
      content: Text(
        '¿Eliminar "${part.nombre}" del inventario? No se puede deshacer.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Volver'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB42318)),
          onPressed: () async {
            final error =
                await ref.read(inventoryProvider.notifier).deletePart(part.id);
            if (!dialogContext.mounted) return;
            Navigator.pop(dialogContext);
            showErrorSnack(context, error);
            if (error == null) showSuccessSnack(context, 'Repuesto eliminado');
          },
          child: const Text('Eliminar'),
        ),
      ],
    ),
  );
}
