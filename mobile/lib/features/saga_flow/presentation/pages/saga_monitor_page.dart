import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/providers/saga_flow_provider.dart';
import 'package:reservatior/features/saga_flow/domain/entities/saga_timeline.dart';

class SagaMonitorPage extends ConsumerStatefulWidget {
  const SagaMonitorPage({super.key});

  @override
  ConsumerState<SagaMonitorPage> createState() => _SagaMonitorPageState();
}

class _SagaMonitorPageState extends ConsumerState<SagaMonitorPage> {
  String? _selectedStatus;

  void _onFilter(String? status) {
    setState(() => _selectedStatus = status);
    ref.read(sagaTimelinesProvider.notifier).filterByStatus(status);
  }

  @override
  Widget build(BuildContext context) {
    final timelines = ref.watch(sagaTimelinesProvider);
    final stats = ref.watch(sagaStatsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'saga_flow.monitor'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white70),
            onPressed: () => ref.read(sagaTimelinesProvider.notifier).refresh(),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.cardBg,
        onRefresh: () async {
          await ref.read(sagaTimelinesProvider.notifier).refresh();
          ref.invalidate(sagaStatsProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: stats.when(
                  data: (s) => _StatsRow(stats: s),
                  loading: () => const _StatsLoading(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _FilterChips(
                  selected: _selectedStatus,
                  onSelected: _onFilter,
                ),
              ),
            ),
            timelines.when(
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              error: (err, __) => SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline,
                            size: 40, color: AppColors.error),
                        const SizedBox(height: 12),
                        Text(
                          'Saga workflows could not be loaded',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$err',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No saga workflows yet',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _SagaTimelineCard(timeline: items[index]),
                      childCount: items.length,
                    ),
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final dynamic stats;

  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatTile(label: 'Total', value: stats.totalSagas, color: AppColors.info),
        _StatTile(label: 'Running', value: stats.running, color: AppColors.success),
        _StatTile(label: 'Failed', value: stats.failed, color: AppColors.error),
        _StatTile(label: 'Done', value: stats.completed, color: AppColors.primary),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBg.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              '$value',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsLoading extends StatelessWidget {
  const _StatsLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _FilterChips({required this.selected, required this.onSelected});

  static const _statuses = ['ALL', 'RUNNING', 'FAILED', 'COMPLETED', 'COMPENSATED'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _statuses.map((status) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterChip(
              label: status,
              isSelected: (selected ?? 'ALL') == status,
              onTap: () => onSelected(status == 'ALL' ? null : status),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppColors.cardBg.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _SagaTimelineCard extends StatelessWidget {
  final SagaTimeline timeline;

  const _SagaTimelineCard({required this.timeline});

  Color get _statusColor {
    switch (timeline.status.toUpperCase()) {
      case 'RUNNING':
        return AppColors.success;
      case 'FAILED':
        return AppColors.error;
      case 'COMPENSATED':
        return AppColors.warning;
      case 'COMPLETED':
        return AppColors.info;
      default:
        return AppColors.warning;
    }
  }

  String _formatDuration(int ms) {
    if (ms < 1000) return '${ms}ms';
    final seconds = ms ~/ 1000;
    if (seconds < 60) return '${seconds}s';
    return '${seconds ~/ 60}m ${seconds % 60}s';
  }

  @override
  Widget build(BuildContext context) {
    final failedSteps = timeline.steps.where((s) => s.outcome == 'FAILED').length;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  timeline.status.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: _statusColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  timeline.sagaType,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ID: ${timeline.sagaId.length <= 8 ? timeline.sagaId : timeline.sagaId.substring(0, 8)}',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            timeline.currentStep,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.account_tree, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                '${timeline.steps.length} steps${failedSteps > 0 ? ' · $failedSteps failed' : ''}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.timer, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                _formatDuration(timeline.totalDurationMs),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (timeline.status.toUpperCase() == 'RUNNING') ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: timeline.progress,
                backgroundColor: AppColors.cardBg.withValues(alpha: 0.5),
                valueColor: AlwaysStoppedAnimation<Color>(_statusColor),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 12),
          ],
          _StepBars(steps: timeline.steps),
        ],
      ),
    ).animate().fadeIn().slideX();
  }
}

class _StepBars extends StatelessWidget {
  final List<SagaStep> steps;

  const _StepBars({required this.steps});

  @override
  Widget build(BuildContext context) {
    final visible = steps.length > 6 ? steps.sublist(steps.length - 6) : steps;
    return Row(
      children: visible.map((step) {
        final color = switch (step.outcome) {
          'SUCCESS' => AppColors.success,
          'FAILED' => AppColors.error,
          'COMPENSATED' => AppColors.warning,
          'RETRY' => AppColors.warning,
          _ => AppColors.border,
        };
        return Expanded(
          child: Tooltip(
            message: '${step.step}: ${step.outcome}',
            child: Container(
              height: 6,
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
