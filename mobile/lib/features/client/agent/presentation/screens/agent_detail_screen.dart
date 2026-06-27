import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sizer/sizer.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/providers/agent_provider.dart';

class AgentDetailScreen extends ConsumerWidget {
  final Agent agent;
  const AgentDetailScreen({super.key, required this.agent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final performance = ref.watch(agentPerformanceProvider(agent.id));
    final assignments = ref.watch(agentAssignmentsProvider(agent.id));

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 32),
                  _buildPerformanceBrief(performance),
                  const SizedBox(height: 32),
                  _buildActiveAssignments(assignments),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 30.h,
      pinned: true,
      backgroundColor: AppColors.darkBg,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.gold.withOpacity(0.3), AppColors.darkBg],
                ),
              ),
            ),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.darkSurface,
                child: Icon(Icons.person, size: 80, color: AppColors.gold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.id.toUpperCase(), // Mocking name as ID for now
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text('mobile.auto.senior_real_estate_advisor'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: AppColors.textSecondaryDark,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Text('mobile.auto.active'.tr(),
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildStatItem('120+', 'mobile.leftovers.deals_done'.tr()),
            _buildDivider(),
            _buildStatItem('4.9', 'Rating'),
            _buildDivider(),
            _buildStatItem('mobile.leftovers.8_yrs'.tr(), 'Experience'),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildStatItem(String val, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            val,
            style: const TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Container(width: 1, height: 30, color: Colors.white10);

  Widget _buildPerformanceBrief(AsyncValue<Map<String, dynamic>> perf) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.key_performance_metrics'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        perf.when(
          data: (data) => Column(
            children: [
              _buildMetricRow(
                'Efficiency',
                (data['efficiency'] ?? 0).toString() + '%',
              ),
              _buildMetricRow(
                'mobile.leftovers.response_time'.tr(),
                (data['responseTime'] ?? '0').toString() + 'mobile.leftovers._min'.tr(),
              ),
              _buildMetricRow(
                'mobile.leftovers.success_rate'.tr(),
                (data['successRate'] ?? 0).toString() + '%',
              ),
            ],
          ),
          loading: () => Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          ),
          error: (_, __) => Text('mobile.auto.metric_sync_pending'.tr(),
            style: TextStyle(color: Colors.white38),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondaryDark),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveAssignments(
    AsyncValue<List<AgentAssignment>> assignments,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.strategic_portfolio'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        assignments.when(
          data: (data) => Column(
            children: data
                .take(3)
                .map(
                  (a) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.darkBorder),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.home_work, color: AppColors.gold),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text('mobile.auto.listing'.tr().split('').first +
                                a.listingId.split('-').first,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white24,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (_, __) => Text('mobile.auto.no_records_found'.tr(),
            style: TextStyle(color: Colors.white38),
          ),
        ),
      ],
    );
  }
}
