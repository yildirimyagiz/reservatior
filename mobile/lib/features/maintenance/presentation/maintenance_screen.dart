import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/priority.dart';
import 'package:reservatior/shared/enums/work_order_status.dart';
import 'package:reservatior/shared/models/maintenance_work_order.dart';
import 'package:reservatior/shared/providers/maintenance_work_order_provider.dart';

class MaintenanceScreen extends ConsumerStatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  ConsumerState<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends ConsumerState<MaintenanceScreen> {
  WorkOrderStatus? _statusFilter;

  @override
  Widget build(BuildContext context) {
    final asyncOrders = ref.watch(maintenanceWorkOrderListProvider);
    final orders = asyncOrders.value ?? <MaintenanceWorkOrder>[];

    final visible = _statusFilter == null
        ? orders
        : orders.where((o) => o.status == _statusFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Maintenance',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: _statusFilter == null,
                      onTap: () => setState(() => _statusFilter = null),
                    ),
                    ...WorkOrderStatus.values.map((s) => _FilterChip(
                          label: s.name.replaceAll('_', ' '),
                          selected: _statusFilter == s,
                          onTap: () => setState(() => _statusFilter = s),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                asyncOrders.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load work orders',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (visible.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.build_outlined, color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No work orders here',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: visible
                          .map((o) => _OrderTile(order: o))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.darkBorder,
        ),
        labelStyle: GoogleFonts.outfit(
          color: selected ? Colors.white : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final MaintenanceWorkOrder order;
  const _OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order.status);
    final priorityColor = _priorityColor(order.priority);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.build_outlined, color: statusColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      '${order.property.name} · ${order.category}',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  order.status.name.replaceAll('_', ' '),
                  style: GoogleFonts.outfit(
                      color: statusColor, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (order.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              order.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.flag_outlined, color: priorityColor, size: 13),
              const SizedBox(width: 4),
              Text(
                order.priority.name,
                style: GoogleFonts.outfit(
                    color: priorityColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              if (order.assignedToUser != null)
                Text(
                  order.assignedToUser!.name ?? order.assignedToUser!.email,
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              const SizedBox(width: 8),
              Icon(Icons.payments_outlined, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                order.estimatedCost != null
                    ? '${order.estimatedCost!.toStringAsFixed(0)}'
                    : '—',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.event, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                order.dueDate != null
                    ? 'Due ${DateFormat.yMMMd().add_Hm().format(order.dueDate!)}'
                    : 'No due date',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _statusColor(WorkOrderStatus status) {
    switch (status) {
      case WorkOrderStatus.OPEN:
        return AppColors.info;
      case WorkOrderStatus.ASSIGNED:
        return AppColors.warning;
      case WorkOrderStatus.IN_PROGRESS:
        return AppColors.primary;
      case WorkOrderStatus.COMPLETED:
        return AppColors.success;
      case WorkOrderStatus.CANCELLED:
        return Colors.white38;
    }
  }

  Color _priorityColor(Priority priority) {
    switch (priority) {
      case Priority.LOW:
        return AppColors.info;
      case Priority.MEDIUM:
        return AppColors.warning;
      case Priority.HIGH:
        return AppColors.error;
      case Priority.URGENT:
        return Colors.redAccent;
    }
  }
}
