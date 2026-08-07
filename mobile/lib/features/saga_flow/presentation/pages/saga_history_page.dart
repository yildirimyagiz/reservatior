import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/providers/saga_flow_provider.dart';
import 'package:reservatior/features/saga_flow/domain/entities/saga_timeline.dart';

class SagaHistoryPage extends ConsumerStatefulWidget {
  const SagaHistoryPage({super.key});

  @override
  ConsumerState<SagaHistoryPage> createState() => _SagaHistoryPageState();
}

class _SagaHistoryPageState extends ConsumerState<SagaHistoryPage> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    final timelines = ref.watch(sagaTimelinesProvider);
    final sagaTypes = ref.watch(sagaTypesProvider);

    final filtered = timelines.whenData(
      (items) => _selectedType == null || _selectedType == 'ALL'
          ? items
          : items.where((t) => t.sagaType == _selectedType).toList(),
    );

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
        title: Text(
          'saga_flow.history'.tr(),
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
        onRefresh: () async =>
            ref.read(sagaTimelinesProvider.notifier).refresh(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: sagaTypes.when(
                  data: (types) => _TypeChips(
                    types: types,
                    selected: _selectedType,
                    onSelected: (t) => setState(() => _selectedType = t),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ),
            filtered.when(
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
              error: (err, __) => SliverFillRemaining(
                child: Center(
                  child: Text(
                    '$err',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ),
              ),
              data: (items) {
                if (items.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No saga history yet',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _HistoryCard(timeline: items[index]),
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

class _TypeChips extends StatelessWidget {
  final List<String> types;
  final String? selected;
  final ValueChanged<String> onSelected;

  const _TypeChips({
    required this.types,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final labels = ['ALL', ...types];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: labels.map((label) {
          final isSelected = (selected ?? 'ALL') == label;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelected(label),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.cardBg.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border.withOpacity(0.3),
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
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HistoryCard extends ConsumerWidget {
  final SagaTimeline timeline;

  const _HistoryCard({required this.timeline});

  Color get _statusColor {
    switch (timeline.status.toUpperCase()) {
      case 'RUNNING':
        return AppColors.success;
      case 'FAILED':
        return AppColors.error;
      case 'COMPENSATED':
        return AppColors.warning;
      default:
        return AppColors.info;
    }
  }

  String _formatDuration(int ms) {
    if (ms < 1000) return '${ms}ms';
    final seconds = ms ~/ 1000;
    if (seconds < 60) return '${seconds}s';
    return '${seconds ~/ 60}m ${seconds % 60}s';
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      isScrollControlled: true,
      builder: (context) => _TimelineDetailSheet(timeline: timeline),
    );
  }

  Future<void> _retry(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(sagaRepositoryProvider).retrySaga(timeline.sagaId);
      await ref.read(sagaTimelinesProvider.notifier).refresh();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saga retry scheduled')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Retry failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFailed = timeline.status.toUpperCase() == 'FAILED';

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
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeline.status.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: _statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  timeline.sagaType,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                timeline.sagaId.length <= 8
                    ? timeline.sagaId
                    : timeline.sagaId.substring(0, 8),
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
            '${timeline.currentStep} · ${timeline.steps.length} steps',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.timer, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                'Duration: ${_formatDuration(timeline.totalDurationMs)}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.account_tree, size: 14, color: Colors.white54),
              const SizedBox(width: 6),
              Text(
                '${timeline.steps.length} steps',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _HistoryActionButton(
                  label: 'View Details',
                  icon: Icons.visibility,
                  color: AppColors.primary,
                  onTap: () => _showDetails(context),
                ),
              ),
              const SizedBox(width: 8),
              if (isFailed)
                Expanded(
                  child: _HistoryActionButton(
                    label: 'Retry',
                    icon: Icons.refresh,
                    color: AppColors.warning,
                    onTap: () => _retry(context, ref),
                  ),
                ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }
}

class _TimelineDetailSheet extends StatelessWidget {
  final SagaTimeline timeline;

  const _TimelineDetailSheet({required this.timeline});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${timeline.sagaType} · ${timeline.status.toUpperCase()}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Saga ID: ${timeline.sagaId}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: timeline.steps.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final step = timeline.steps[index];
                    final color = switch (step.outcome) {
                      'SUCCESS' => AppColors.success,
                      'FAILED' => AppColors.error,
                      'COMPENSATED' => AppColors.warning,
                      'RETRY' => AppColors.warning,
                      _ => AppColors.border,
                    };
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step.step,
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                if (step.error != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    step.error!,
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (step.retryCount > 0)
                            Text(
                              '${step.retryCount}x retry',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: AppColors.warning,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HistoryActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _HistoryActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
