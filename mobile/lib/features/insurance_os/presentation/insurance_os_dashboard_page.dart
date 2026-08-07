import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/os_dashboard_providers.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

/// Insurance Integration OS — live data from /api/v1/insurance-os/dashboard.
class InsuranceOsDashboardPage extends ConsumerWidget {
  const InsuranceOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final orgId = authState.user?.organizationId ?? '';
    final statsAsync = ref.watch(insuranceOsStatsProvider(orgId));

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
              title: Text(
                'Insurance OS',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                statsAsync.when(
                  loading: () => const OsLiveLoading(),
                  error: (e, _) => OsLiveErrorCard(message: 'Failed to load Insurance OS data: $e'),
                  data: (stats) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.verified_user, color: AppColors.primary, size: 22),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Global 2% Rent Guarantee Underwriting Pool & Zero-Deposit Surety Bonds active across all lease agreements.',
                                style: GoogleFonts.outfit(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      OsLiveKpiGrid(
                        items: [
                          OsKpiData('Active Policies', stats.kpi('activePolicies').toStringAsFixed(0), Icons.shield_outlined, AppColors.success),
                          OsKpiData('Premium Revenue', osFormatCompact(stats.kpi('premiumRevenue'), prefix: r'$'), Icons.attach_money, AppColors.warning),
                          OsKpiData('Total Policies', stats.kpi('totalPolicies').toStringAsFixed(0), Icons.description_outlined, AppColors.info),
                          OsKpiData('Active Claims', stats.kpi('activeClaims').toStringAsFixed(0), Icons.report_problem_outlined, AppColors.error),
                          OsKpiData('Providers', stats.kpi('providers').toStringAsFixed(0), Icons.business_outlined, AppColors.primary),
                          OsKpiData('Products', stats.kpi('products').toStringAsFixed(0), Icons.inventory_2_outlined, AppColors.info),
                        ],
                      ),
                      if (stats.recentActivity.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        OsLiveActivityList(
                          label: 'Recent Activity',
                          items: stats.recentActivity.map(osActivityFromJson).toList(),
                        ),
                      ],
                      if (stats.alerts.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        OsLiveAlertList(items: stats.alerts),
                      ],
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
