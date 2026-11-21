import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../domain/models.dart';
import '../../domain/order_status.dart';
import '../theme.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../viewmodels/inventory_viewmodel.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});

  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(orderDetailProvider(orderId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #$orderId'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (detail) {
          if (detail == null) {
            return const EmptyState(
              icon: Icons.search_off,
              title: 'Orden no encontrada',
              subtitle: 'Puede que haya sido eliminada.',
            );
          }
          return _DetailBody(detail: detail, orderId: orderId);
        },
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail, required this.orderId});

  final OrderDetail detail;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    final s = detail.summary;
    final status = s.status;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StatusChip(status),
                      const Spacer(),
                      Text(
                        'Recibida ${formatDate(s.fechaRecepcion)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    s.equipoLabel,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${s.tipo}${s.numeroSerie != null && s.numeroSerie!.isNotEmpty ? ' · S/N ${s.numeroSerie}' : ''}',
                    style: const TextStyle(fontSize: 12, color: AppColors.muted),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  _InfoRow(Icons.person_outline, 'Cliente', s.clienteNombre),
                  const SizedBox(height: 10),
                  _InfoRow(Icons.phone_outlined, 'Teléfono', s.clienteTelefono),
                  const SizedBox(height: 10),
                  _InfoRow(
                    Icons.engineering_outlined,
                    'Responsable',
                    s.tecnicoNombre ?? 'Sin asignar (nadie la ha tomado)',
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7FAFB),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FALLA REPORTADA',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .8,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          s.fallaReportada,
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  if (s.notas != null && s.notas!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    _InfoRow(Icons.notes_outlined, 'Notas', s.notas!),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _Actions(status: status, orderId: orderId),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Trabajos realizados',
            action: status.allowsChanges
                ? TextButton.icon(
                    onPressed: () => _showAddWorkDialog(context, orderId),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Agregar'),
                  )
                : null,
            children: detail.trabajos.isEmpty
                ? const [
                    Text(
                      'Sin trabajos registrados.',
                      style: TextStyle(fontSize: 13, color: AppColors.muted),
                    ),
                  ]
                : [
                    for (final work in detail.trabajos) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.build_outlined,
                              size: 17, color: AppColors.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              work.descripcion,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          Text(
                            money(work.costoManoObra),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if (work != detail.trabajos.last)
                        const Divider(height: 18),
                    ],
                  ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Repuestos usados',
            action: status.allowsChanges
                ? TextButton.icon(
                    onPressed: () => _showAddPartDialog(context, orderId),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Agregar'),
                  )
                : null,
            children: detail.repuestosUsados.isEmpty
                ? const [
                    Text(
                      'Sin repuestos registrados.',
                      style: TextStyle(fontSize: 13, color: AppColors.muted),
                    ),
                  ]
                : [
                    for (final used in detail.repuestosUsados) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.inventory_2_outlined,
                              size: 17, color: AppColors.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  used.nombre,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '${used.cantidad} × ${money(used.precioUnitario)} · ${used.codigo}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            money(used.subtotal),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if (used != detail.repuestosUsados.last)
                        const Divider(height: 18),
                    ],
                  ],
          ),
          const SizedBox(height: 16),
          _TotalCard(detail: detail),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.muted),
        const SizedBox(width: 10),
        Text('$label: ', style: const TextStyle(fontSize: 13, color: AppColors.muted)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.detail});

  final OrderDetail detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'TOTAL DE LA ORDEN',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Mano de obra', style: TextStyle(color: Colors.white)),
              Text(money(detail.manoDeObra),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Repuestos', style: TextStyle(color: Colors.white)),
              Text(money(detail.costoRepuestos),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                money(detail.total),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Actions extends ConsumerWidget {
  const _Actions({required this.status, required this.orderId});

  final OrderStatus status;
  final int orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> run(Future<String?> Function() action, String success) async {
      final error = await action();
      if (!context.mounted) return;
      if (error != null) {
        showErrorSnack(context, error);
      } else {
        showSuccessSnack(context, success);
      }
    }

    if (status == OrderStatus.recibida) {
      return Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () => _showTakeOrderDialog(context, ref, orderId),
              icon: const Icon(Icons.handshake_outlined),
              label: const Text('Tomar orden'),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () => _confirmCancel(context, ref, orderId),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFB42318),
              side: const BorderSide(color: Color(0xFFF3B4AE)),
              minimumSize: const Size(48, 48),
            ),
            child: const Icon(Icons.cancel_outlined),
          ),
        ],
      );
    }

    if (status == OrderStatus.enReparacion) {
      return Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () => run(
                () => ref
                    .read(orderDetailProvider(orderId).notifier)
                    .changeStatus(OrderStatus.lista),
                'Orden marcada como lista',
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Marcar lista'),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: () => _confirmCancel(context, ref, orderId),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFB42318),
              side: const BorderSide(color: Color(0xFFF3B4AE)),
              minimumSize: const Size(48, 48),
            ),
            child: const Icon(Icons.cancel_outlined),
          ),
        ],
      );
    }

    if (status == OrderStatus.lista) {
      return FilledButton.icon(
        onPressed: () => run(
          () => ref
              .read(orderDetailProvider(orderId).notifier)
              .changeStatus(OrderStatus.entregada),
          'Orden entregada al cliente',
        ),
        icon: const Icon(Icons.local_shipping_outlined),
        label: const Text('Entregar al cliente'),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: statusColor(status).withValues(alpha: .08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18, color: statusColor(status)),
          const SizedBox(width: 10),
          Text(
            status == OrderStatus.entregada
                ? 'Esta orden ya fue entregada. Su historial queda disponible.'
                : 'Esta orden fue cancelada.',
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

void _showTakeOrderDialog(BuildContext context, WidgetRef ref, int orderId) {
  final technicians = ref.read(techniciansProvider).value ?? const [];
  if (technicians.isEmpty) {
    showErrorSnack(context, 'No hay técnicos registrados.');
    return;
  }
  int? selected = technicians.first.id;

  showDialog<void>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (innerContext, setState) => AlertDialog(
        title: const Text('Tomar orden'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecciona quién se hace responsable. Si otro técnico ya la tomó, verás un aviso.',
                style: TextStyle(fontSize: 13, color: AppColors.muted),
              ),
              const SizedBox(height: 12),
              RadioGroup<int>(
                groupValue: selected,
                onChanged: (value) {
                  if (value != null) setState(() => selected = value);
                },
                child: Column(
                  children: [
                    for (final tech in technicians)
                      RadioListTile<int>(
                        value: tech.id,
                        title: Text(tech.nombre),
                        secondary: Avatar(tech.nombre, size: 30),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              if (selected == null) return;
              final error = await ref
                  .read(orderDetailProvider(orderId).notifier)
                  .takeOrder(selected!);
              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext);
              if (error != null) {
                showErrorSnack(context, error);
              } else {
                showSuccessSnack(context, 'Orden asignada correctamente');
              }
            },
            child: const Text('Asignar'),
          ),
        ],
      ),
    ),
  );
}

void _confirmCancel(BuildContext context, WidgetRef ref, int orderId) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Cancelar orden'),
      content: const Text(
        '¿Seguro que deseas cancelar esta orden? Esta acción no se puede deshacer.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Volver'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFFB42318)),
          onPressed: () async {
            final error = await ref
                .read(orderDetailProvider(orderId).notifier)
                .changeStatus(OrderStatus.cancelada);
            if (!dialogContext.mounted) return;
            Navigator.pop(dialogContext);
            showErrorSnack(context, error);
            if (error == null) showSuccessSnack(context, 'Orden cancelada');
          },
          child: const Text('Cancelar orden'),
        ),
      ],
    ),
  );
}

void _showAddWorkDialog(BuildContext context, int orderId) {
  final descController = TextEditingController();
  final costController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showDialog<void>(
    context: context,
    builder: (dialogContext) => Consumer(
      builder: (innerContext, ref, _) => AlertDialog(
        title: const Text('Registrar trabajo'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: descController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Escribe una descripción'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: costController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Costo de mano de obra',
                  prefixText: 'Q ',
                ),
                validator: (v) {
                  final value = double.tryParse(v ?? '');
                  if (value == null || value <= 0) return 'Ingresa un costo válido';
                  return null;
                },
              ),
            ],
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
              final error = await ref
                  .read(orderDetailProvider(orderId).notifier)
                  .addWork(
                    descController.text,
                    double.parse(costController.text),
                  );
              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext);
              showErrorSnack(context, error);
              if (error == null) showSuccessSnack(context, 'Trabajo agregado');
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    ),
  );
}

void _showAddPartDialog(BuildContext context, int orderId) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => Consumer(
      builder: (innerContext, ref, _) {
        final partsAsync = ref.watch(allPartsProvider);
        return AlertDialog(
          title: const Text('Usar repuesto'),
          content: partsAsync.when(
            loading: () => const SizedBox(
              height: 120,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => Text('Error: $error'),
            data: (parts) {
              if (parts.isEmpty) {
                return const Text('Primero agrega repuestos al inventario.');
              }
              return _AddPartForm(
                  parts: parts,
                  orderId: orderId,
                  snackContext: context,
                );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    ),
  );
}

class _AddPartForm extends StatefulWidget {
  const _AddPartForm({
    required this.parts,
    required this.orderId,
    required this.snackContext,
  });

  final List<Part> parts;
  final int orderId;
  final BuildContext snackContext;

  @override
  State<_AddPartForm> createState() => _AddPartFormState();
}

class _AddPartFormState extends State<_AddPartForm> {
  late Part _selected = widget.parts.first;
  final _quantityController = TextEditingController(text: '1');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<Part>(
            initialValue: _selected,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Repuesto'),
            items: [
              for (final part in widget.parts)
                DropdownMenuItem<Part>(
                  value: part,
                  child: Text(
                    '${part.nombre} (${part.existencias} und.)',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _selected = value);
            },
          ),
          const SizedBox(height: 8),
          Text(
            'Precio unitario: ${money(_selected.precio)} · Stock: ${_selected.existencias}',
            style: const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad'),
            validator: (v) {
              final value = int.tryParse(v ?? '');
              if (value == null || value <= 0) return 'Cantidad inválida';
              if (value > _selected.existencias) {
                return 'Solo hay ${_selected.existencias} unidades';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, _) => FilledButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final error = await ref
                    .read(orderDetailProvider(widget.orderId).notifier)
                    .addUsedPart(
                      _selected.id,
                      int.parse(_quantityController.text),
                    );
                if (!context.mounted) return;
                Navigator.pop(context);
                showErrorSnack(widget.snackContext, error);
                if (error == null) {
                  showSuccessSnack(widget.snackContext, 'Repuesto descontado del inventario');
                }
              },
              child: const Text('Usar repuesto'),
            ),
          ),
        ],
      ),
    );
  }
}
