import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/automation_execution.dart';
import 'package:reservatior/shared/models/automation_task.dart';
import 'package:reservatior/shared/models/system_metrics.dart';
import 'package:reservatior/features/operations_os/presentation/operations_provider.dart';

class OperationsOsDashboard extends ConsumerWidget {
  const OperationsOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMetrics = ref.watch(operationsSystemMetricsListProvider);
    final asyncTasks = ref.watch(operationsAutomationTasksProvider);
    final asyncExecutions = ref.watch(operationsAutomationExecutionsProvider);

    final metrics = asyncMetrics.value ?? <SystemMetrics>[];
    final tasks = asyncTasks.value ?? <AutomationTask>[];
    final executions = asyncExecutions.value ?? <AutomationExecution>[];

    final okTasks = tasks.where((t) => t.status == 'SUCCESS').length;
    final okRuns = executions.where((e) => e.status == 'SUCCESS').length;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Operations OS',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    _MetricCard(
                      label: 'Automation tasks',
                      value: '${tasks.length}',
                      sub: '$okTasks active',
                      color: AppColors.primary,
                      icon: Icons.memory,
                    ),
                    const SizedBox(width: 12),
                    _MetricCard(
                      label: 'Executions',
                      value: '${executions.length}',
                      sub: '$okRuns succeeded',
                      color: AppColors.success,
                      icon: Icons.play_circle_outline,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'System metrics',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(height: 10),
                asyncMetrics.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load metrics',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (metrics.isEmpty) {
                      return _EmptyCard(message: 'No metrics recorded');
                    }
                    return Column(
                      children: metrics
                          .map((m) => _MetricTile(metric: m))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Automation tasks',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(height: 10),
                asyncTasks.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load tasks',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (tasks.isEmpty) {
                      return _EmptyCard(message: 'No automation tasks');
                    }
                    return Column(
                      children: tasks
                          .map((t) => _TaskTile(task: t))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Recent executions',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(height: 10),
                asyncExecutions.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load executions',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (executions.isEmpty) {
                      return _EmptyCard(message: 'No executions yet');
                    }
                    return Column(
                      children: executions
                          .take(10)
                          .map((e) => _ExecutionTile(execution: e))
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

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color color;
  final IconData icon;
  const _MetricCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 22),
            ),
            Text(
              label,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
            ),
            Text(
              sub,
              style: GoogleFonts.outfit(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String message;
  const _EmptyCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Text(
        message,
        style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final SystemMetrics metric;
  const _MetricTile({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.query_stats, color: AppColors.info, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.metricName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                Text(
                  metric.metricType,
                  style:
                      GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            '${metric.value.toStringAsFixed(2)} ${metric.unit}',
            style: GoogleFonts.outfit(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 14),
          ),
        ],
      ).animate().fadeIn(),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final AutomationTask task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(task.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.memory, color: color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  task.taskType,
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  task.status,
                  style: GoogleFonts.outfit(
                      color: color, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (task.command != null) ...[
            const SizedBox(height: 8),
            Text(
              task.command!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                  color: Colors.white54,
                  fontSize: 12),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              if (task.persona != null) ...[
                Icon(Icons.person_outline, color: Colors.white24, size: 13),
                const SizedBox(width: 4),
                Text(
                  task.persona!,
                  style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
                ),
                const SizedBox(width: 12),
              ],
              if (task.schedule != null) ...[
                Icon(Icons.schedule, color: Colors.white24, size: 13),
                const SizedBox(width: 4),
                Text(
                  task.schedule!,
                  style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
                ),
              ],
              const Spacer(),
              if (task.lastRun != null)
                Text(
                  DateFormat.yMMMd().add_Hm().format(task.lastRun!),
                  style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
                ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _statusColor(String status) {
    final upper = status.toUpperCase();
    if (upper == 'SUCCESS' || upper == 'RUNNING') return AppColors.success;
    if (upper == 'FAILED' || upper == 'ERROR') return AppColors.error;
    return AppColors.warning;
  }
}

class _ExecutionTile extends StatelessWidget {
  final AutomationExecution execution;
  const _ExecutionTile({required this.execution});

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(execution.status);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.play_circle_outline, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  execution.rule.ruleName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                Text(
                  '${execution.processingTimeMs ?? 0} ms',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Text(
              execution.status,
              style: GoogleFonts.outfit(
                  color: color, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _statusColor(String status) {
    final upper = status.toUpperCase();
    if (upper == 'SUCCESS') return AppColors.success;
    if (upper == 'FAILED' || upper == 'ERROR') return AppColors.error;
    return AppColors.warning;
  }
}
