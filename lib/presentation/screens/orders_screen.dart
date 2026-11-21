import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../domain/models.dart';
import '../../domain/order_status.dart';
import '../theme.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);
    final technicians = ref.watch(techniciansProvider).value ?? const [];
    final filter = ref.watch(ordersFilterProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'Órdenes de reparación',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _FilterChip(
                              label: 'Abiertas',
                              selected: filter.status == null && filter.openOnly,
                              onSelected: (_) {
                                final notifier = ref.read(ordersFilterProvider.notifier);
                                notifier.setStatus(null);
                                notifier.setOpenOnly(true);
                              },
                            ),
                            _FilterChip(
                              label: 'Todas',
                              selected: filter.status == null && !filter.openOnly,
                              onSelected: (_) {
                                final notifier = ref.read(ordersFilterProvider.notifier);
                                notifier.setStatus(null);
                                notifier.setOpenOnly(false);
                              },
                            ),
                            for (final status in OrderStatus.values)
                              _FilterChip(
                                label: status.label,
                                selected: filter.status == status,
                                onSelected: (_) =>
                                    ref.read(ordersFilterProvider.notifier)
                                        .setStatus(status),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person_search_outlined,
                              size: 18, color: AppColors.muted),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButton<int?>(
                              value: filter.tecnicoId,
                              isExpanded: true,
                              underline: const SizedBox(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.ink,
                              ),
                              items: [
                                const DropdownMenuItem<int?>(
                                  value: null,
                                  child: Text('Todos los técnicos'),
                                ),
                                for (final tech in technicians)
                                  DropdownMenuItem<int?>(
                                    value: tech.id,
                                    child: Text(tech.nombre),
                                  ),
                              ],
                              onChanged: (value) =>
                                  ref.read(ordersFilterProvider.notifier)
                                      .setTecnico(value),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ordersAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
                data: (orders) => orders.isEmpty
                    ? const EmptyState(
                        icon: Icons.receipt_long_outlined,
                        title: 'Sin órdenes',
                        subtitle: 'No hay órdenes con estos filtros.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                        itemCount: orders.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) =>
                            _OrderCard(order: orders[index]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: TextStyle(fontSize: 12)),
        selected: selected,
        showCheckmark: false,
        selectedColor: AppColors.primaryLight,
        onSelected: onSelected,
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderSummary order;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => OrderDetailScreen(orderId: order.id),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  StatusChip(order.status, dense: true),
                  const Spacer(),
                  Text(
                    '#${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      order.tipo.toLowerCase().contains('laptop')
                          ? Icons.laptop_mac
                          : order.tipo.toLowerCase().contains('tablet')
                              ? Icons.tablet_mac
                              : Icons.smartphone,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.equipoLabel,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${order.clienteNombre} · ${relativeDate(order.fechaRecepcion)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.muted),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                order.fallaReportada,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, color: Color(0xFF45545E)),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  if (order.tecnicoNombre == null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Sin tomar',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFB45309),
                        ),
                      ),
                    )
                  else ...[
                    Avatar(order.tecnicoNombre!, size: 26),
                    const SizedBox(width: 8),
                    Text(
                      order.tecnicoNombre!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    formatDate(order.fechaRecepcion),
                    style: const TextStyle(fontSize: 11, color: AppColors.muted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
