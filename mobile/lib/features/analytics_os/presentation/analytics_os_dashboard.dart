import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/report.dart';
import 'package:reservatior/shared/models/report_execution.dart';
import 'package:reservatior/shared/providers/project_report_provider.dart';
import 'package:reservatior/shared/providers/report_execution_provider.dart';
import 'package:reservatior/shared/providers/report_provider.dart';

class AnalyticsOsDashboardPage extends ConsumerWidget {
  const AnalyticsOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncReports = ref.watch(reportListProvider);
    final asyncProjectReports = ref.watch(projectReportListProvider);
    final asyncExecutions = ref.watch(reportExecutionListProvider);
    final reports = asyncReports.value ?? <Report>[];
    final executions = asyncExecutions.value ?? <ReportExecution>[];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Analytics OS',
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
                Text(
                  'Reports, analytics and project insights.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                _KpiGrid(
                  items: [
                    (
                      'Reports',
                      '${reports.length}',
                      Icons.analytics_outlined,
                      AppColors.primary,
                    ),
                    (
                      'Active',
                      '${reports.where((r) => r.isActive).length}',
                      Icons.toggle_on_outlined,
                      AppColors.success,
                    ),
                    (
                      'Project',
                      '${asyncProjectReports.value?.length ?? 0}',
                      Icons.apartment_outlined,
                      AppColors.info,
                    ),
                    (
                      'Runs',
                      '${executions.length}',
                      Icons.play_circle_outline,
                      AppColors.warning,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Recent executions',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                const SizedBox(height: 12),
                asyncExecutions.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load executions',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (executions) {
                    if (executions.isEmpty) {
                      return Text('No executions yet',
                          style: GoogleFonts.outfit(color: Colors.white38));
                    }
                    final sorted = [...executions]
                      ..sort((a, b) => b.executedAt.compareTo(a.executedAt));
                    return Column(
                      children: sorted
                          .take(5)
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

class _ExecutionTile extends StatelessWidget {
  final ReportExecution execution;
  const _ExecutionTile({required this.execution});

  @override
  Widget build(BuildContext context) {
    final ok = execution.status.toUpperCase() == 'SUCCESS' ||
        execution.status.toUpperCase() == 'COMPLETED';
    final color = ok ? AppColors.success : AppColors.error;
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
            child: Icon(
              ok ? Icons.check_circle_outline : Icons.error_outline,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  execution.reportId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  'by ${execution.executedBy} · ${DateFormat.yMMMd().add_Hm().format(execution.executedAt)}',
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
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  final List<(String, String, IconData, Color)> items;
  const _KpiGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: items
          .map((e) => Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(e.$3, color: e.$4, size: 20),
                    const SizedBox(height: 8),
                    Text(
                      e.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    Text(e.$1,
                        style: GoogleFonts.outfit(
                            color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
