import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/os_dashboard_providers.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

/// Rental Finance OS — live data from /api/v1/rental-finance-os/dashboard.
class RentalFinanceOsDashboardPage extends ConsumerWidget {
  const RentalFinanceOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final orgId = authState.user?.organizationId ?? '';
    final statsAsync = ref.watch(rentalFinanceOsStatsProvider(orgId));

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
                'Rental Finance OS',
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
                  error: (e, _) => OsLiveErrorCard(message: 'Failed to load Rental Finance OS data: $e'),
                  data: (stats) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OsLiveKpiGrid(
                        items: [
                          OsKpiData('Active Plans', stats.kpi('activePlans').toStringAsFixed(0), Icons.shield_outlined, AppColors.success),
                          OsKpiData('Escrow Balance', osFormatCompact(stats.kpi('escrowBalance'), prefix: r'$'), Icons.account_balance, AppColors.warning),
                          OsKpiData('Held Amount', osFormatCompact(stats.kpi('heldAmount'), prefix: r'$'), Icons.lock_outline, AppColors.error),
                          OsKpiData('Avg Reliability', stats.kpi('averageReliabilityScore').toStringAsFixed(0), Icons.trending_up, AppColors.primary),
                          OsKpiData('Late Payments', stats.kpi('latePayments').toStringAsFixed(0), Icons.report_problem_outlined, AppColors.error),
                          OsKpiData('Landlords', stats.kpi('landlords').toStringAsFixed(0), Icons.business_outlined, AppColors.info),
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
