import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../domain/order_status.dart';
import '../../domain/models.dart';
import '../theme.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../viewmodels/orders_viewmodel.dart';
import '../widgets.dart';
import '../../app.dart' show navIndexProvider;

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(pendingOrdersProvider).value ?? const [];
    final workload = ref.watch(workloadProvider).value ?? const [];
    final lowStock = ref.watch(lowStockProvider).value ?? const [];

    final enReparacion = orders.where((o) => o.status == OrderStatus.enReparacion).length;
    final listas = orders.where((o) => o.status == OrderStatus.lista).length;
    final sinAsignar = orders.where((o) => o.tecnicoId == null).length;
    final maxLoad = workload.fold<int>(
      1,
      (max, w) => w.activas > max ? w.activas : max,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Panel del taller',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          'Resumen de hoy · ${formatDate(DateTime.now())}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.build_circle_outlined,
                        color: AppColors.primary, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.42,
                children: [
                  MetricCard(
                    icon: Icons.pending_actions_outlined,
                    label: 'Órdenes abiertas',
                    value: '${orders.length}',
                    color: const Color(0xFF2563EB),
                    onTap: () => ref.read(navIndexProvider.notifier).select(1),
                  ),
                  MetricCard(
                    icon: Icons.build_outlined,
                    label: 'En reparación',
                    value: '$enReparacion',
                    color: const Color(0xFFD97706),
                    onTap: () => ref.read(navIndexProvider.notifier).select(1),
                  ),
                  MetricCard(
                    icon: Icons.check_circle_outline,
                    label: 'Listas para entregar',
                    value: '$listas',
                    color: const Color(0xFF0D9488),
                    onTap: () => ref.read(navIndexProvider.notifier).select(1),
                  ),
                  MetricCard(
                    icon: Icons.inventory_2_outlined,
                    label: 'Repuestos críticos',
                    value: '${lowStock.length}',
                    color: const Color(0xFFDC2626),
                    onTap: () => ref.read(navIndexProvider.notifier).select(2),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: 'Carga de trabajo por técnico',
                action: const Icon(Icons.groups_outlined,
                    size: 18, color: AppColors.muted),
                children: workload.isEmpty
                    ? const [
                        EmptyState(
                          icon: Icons.person_off_outlined,
                          title: 'Sin técnicos',
                          subtitle: 'No hay técnicos registrados.',
                        ),
                      ]
                    : [
                        for (final tech in workload) ...[
                          _WorkloadRow(tech: tech, max: maxLoad),
                          if (tech != workload.last) const SizedBox(height: 16),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          '$sinAsignar orden(es) todavía sin responsable',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: 'Repuestos por agotarse',
                action: TextButton(
                  onPressed: () => ref.read(navIndexProvider.notifier).select(2),
                  child: const Text('Ver inventario'),
                ),
                children: lowStock.isEmpty
                    ? const [
                        EmptyState(
                          icon: Icons.check_circle_outline,
                          title: 'Todo en orden',
                          subtitle: 'Ningún repuesto está por agotarse.',
                        ),
                      ]
                    : [
                        for (final part in lowStock) ...[
                          _LowStockRow(part: part),
                          if (part != lowStock.last) const Divider(height: 18),
                        ],
                      ],
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: 'Órdenes recientes',
                action: TextButton(
                  onPressed: () => ref.read(navIndexProvider.notifier).select(1),
                  child: const Text('Ver todas'),
                ),
                children: orders.isEmpty
                    ? const [
                        EmptyState(
                          icon: Icons.receipt_long_outlined,
                          title: 'Sin órdenes abiertas',
                          subtitle: 'Registra una orden para comenzar.',
                        ),
                      ]
                    : [
                        for (final order in orders.take(3)) ...[
                          _RecentOrderRow(order: order),
                          if (order != orders.take(3).last)
                            const Divider(height: 18),
                        ],
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkloadRow extends StatelessWidget {
  const _WorkloadRow({required this.tech, required this.max});

  final TechnicianWorkload tech;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(tech.nombre),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      tech.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${tech.activas} activas',
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: tech.activas / max,
                  minHeight: 7,
                  backgroundColor: const Color(0xFFE9EFF1),
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LowStockRow extends StatelessWidget {
  const _LowStockRow({required this.part});

  final Part part;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: const Color(0xFFFEE2E2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.warning_amber_rounded,
              color: Color(0xFFDC2626), size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(part.nombre,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              Text(
                part.codigo,
                style: const TextStyle(fontSize: 11, color: AppColors.muted),
              ),
            ],
          ),
        ),
        Text(
          '${part.existencias} und.',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFFDC2626),
          ),
        ),
      ],
    );
  }
}

class _RecentOrderRow extends StatelessWidget {
  const _RecentOrderRow({required this.order});

  final OrderSummary order;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusChip(order.status, dense: true),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${order.id} · ${order.equipoLabel}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              Text(
                '${order.clienteNombre} · ${relativeDate(order.fechaRecepcion)}',
                style: const TextStyle(fontSize: 11, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
