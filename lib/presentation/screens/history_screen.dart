import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../domain/models.dart';
import '../theme.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../viewmodels/history_viewmodel.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets.dart';
import 'order_detail_screen.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(historyTargetProvider);
    final historyAsync = ref.watch(historyProvider);
    final allOrders = ref.watch(allOrdersProvider).value ?? const [];
    final clients = ref.watch(clientsProvider).value ?? const [];

    final equipment = <int, String>{};
    for (final order in allOrders) {
      equipment.putIfAbsent(order.equipoId, () => order.equipoLabel);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Historial',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SectionCard(
                title: 'Consultar reparaciones anteriores',
                padding: 16,
                children: [
                  SegmentedButton<HistoryKind>(
                    segments: const [
                      ButtonSegment(
                        value: HistoryKind.equipo,
                        icon: Icon(Icons.devices_other_outlined, size: 16),
                        label: Text('Por equipo'),
                      ),
                      ButtonSegment(
                        value: HistoryKind.cliente,
                        icon: Icon(Icons.person_outline, size: 16),
                        label: Text('Por cliente'),
                      ),
                    ],
                    selected: {target?.kind ?? HistoryKind.equipo},
                    onSelectionChanged: (selection) {
                      ref.read(historyTargetProvider.notifier).select(
                            selection.first,
                            selection.first == HistoryKind.equipo
                                ? (equipment.keys.isNotEmpty
                                    ? equipment.keys.first
                                    : -1)
                                : (clients.isNotEmpty ? clients.first.id : -1),
                          );
                    },
                  ),
                  const SizedBox(height: 14),
                  _TargetSelector(
                    target: target,
                    equipment: equipment,
                    clients: clients,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: target == null
                  ? const EmptyState(
                      icon: Icons.history_rounded,
                      title: 'Selecciona un equipo o cliente',
                      subtitle: 'Elige un elemento para ver su historial.',
                    )
                  : historyAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, _) => Center(child: Text('Error: $error')),
                      data: (orders) => orders == null || orders.isEmpty
                          ? const EmptyState(
                              icon: Icons.search_off,
                              title: 'Sin historial',
                              subtitle: 'No hay órdenes para este elemento.',
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                              itemCount: orders.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) =>
                                  _HistoryTile(order: orders[index]),
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetSelector extends StatelessWidget {
  const _TargetSelector({
    required this.target,
    required this.equipment,
    required this.clients,
  });

  final HistoryTarget? target;
  final Map<int, String> equipment;
  final List<ClientOption> clients;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final kind = target?.kind ?? HistoryKind.equipo;
        final items = kind == HistoryKind.equipo
            ? equipment.entries
                .map((e) => DropdownMenuItem<int>(
                      value: e.key,
                      child: Text(e.value, overflow: TextOverflow.ellipsis),
                    ))
                .toList()
            : clients
                .map((c) => DropdownMenuItem<int>(
                      value: c.id,
                      child: Text(
                        '${c.nombre} · ${c.telefono}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList();

        if (items.isEmpty) {
          return const Text(
            'Aún no hay elementos disponibles.',
            style: TextStyle(fontSize: 13, color: AppColors.muted),
          );
        }

        return DropdownButtonFormField<int>(
          initialValue: target != null && target!.kind == kind ? target!.id : null,
          isExpanded: true,
          decoration: InputDecoration(
            labelText:
                kind == HistoryKind.equipo ? 'Selecciona equipo' : 'Selecciona cliente',
            prefixIcon: Icon(kind == HistoryKind.equipo
                ? Icons.devices_outlined
                : Icons.person_outline),
          ),
          items: items,
          onChanged: (value) {
            if (value != null) {
              ref.read(historyTargetProvider.notifier).select(kind, value);
            }
          },
        );
      },
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.order});

  final OrderSummary order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => OrderDetailScreen(orderId: order.id),
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.receipt_outlined, color: AppColors.primary, size: 18),
        ),
        title: Text(
          '#${order.id} · ${order.equipoLabel}',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        subtitle: Text(
          '${formatDate(order.fechaRecepcion)} · ${order.clienteNombre}',
          style: const TextStyle(fontSize: 11),
        ),
        trailing: StatusChip(order.status, dense: true),
      ),
    );
  }
}
