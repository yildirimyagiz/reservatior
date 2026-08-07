import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/os_dashboard_providers.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

// ---------------------------------------------------------------------------
// ADS OS
// ---------------------------------------------------------------------------
class AdsOsDashboard extends ConsumerWidget {
  const AdsOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(adsOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Ads OS',
      subtitle: 'Campaign management, spend, and performance tracking.',
      icon: Icons.campaign_outlined,
      accentColor: const Color(0xFFFF6B6B),
      stats: statsAsync,
      activityLabel: 'Campaign Events',
      kpiBuilder: (s) => [
        OsKpiData('Active Campaigns', s.kpi('campaignStats.total').toStringAsFixed(0), Icons.play_circle_outline, AppColors.success),
        OsKpiData('Channels', s.kpi('channels').toStringAsFixed(0), Icons.hub_outlined, AppColors.info),
        OsKpiData('Segments', s.kpi('segments').toStringAsFixed(0), Icons.groups_outlined, AppColors.warning),
        OsKpiData('Events Today', s.kpi('recentEvents.totalEvents').toStringAsFixed(0), Icons.ads_click, AppColors.primary),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// AI OS
// ---------------------------------------------------------------------------
class AiOsDashboard extends ConsumerWidget {
  const AiOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(aiOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'AI OS',
      subtitle: 'AI service orchestration, model usage, and task queues.',
      icon: Icons.auto_awesome_outlined,
      accentColor: const Color(0xFF8B5CF6),
      stats: statsAsync,
      activityLabel: 'Recent AI Tasks',
      kpiBuilder: (s) => [
        OsKpiData('Total Tasks', s.kpi('totalTasks').toStringAsFixed(0), Icons.memory, AppColors.primary),
        OsKpiData('Processing', s.kpi('processing').toStringAsFixed(0), Icons.bolt, AppColors.warning),
        OsKpiData('Completed', s.kpi('completed').toStringAsFixed(0), Icons.check_circle_outline, AppColors.success),
        OsKpiData('Failed', s.kpi('failed').toStringAsFixed(0), Icons.error_outline, AppColors.error),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// COMMERCE OS
// ---------------------------------------------------------------------------
class CommerceOsDashboard extends ConsumerWidget {
  const CommerceOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(commerceOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Commerce OS',
      subtitle: 'Marketplace transactions, orders, and storefront management.',
      icon: Icons.storefront_outlined,
      accentColor: const Color(0xFF10B981),
      stats: statsAsync,
      activityLabel: 'Recent Orders',
      kpiBuilder: (s) => [
        OsKpiData('Products', s.kpi('totalProducts').toStringAsFixed(0), Icons.inventory_2_outlined, AppColors.primary),
        OsKpiData('Orders', s.kpi('totalOrders').toStringAsFixed(0), Icons.receipt_long_outlined, AppColors.info),
        OsKpiData('Revenue (Month)', osFormatCompact(s.kpi('totalRevenue'), prefix: r'$'), Icons.trending_up, AppColors.success),
        OsKpiData('Active Campaigns', s.kpi('activeCampaigns').toStringAsFixed(0), Icons.campaign_outlined, AppColors.warning),
        OsKpiData('Pending Orders', s.kpi('pendingOrders').toStringAsFixed(0), Icons.hourglass_top_outlined, AppColors.error),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// CONSENT OS
// ---------------------------------------------------------------------------
class ConsentOsDashboard extends ConsumerWidget {
  const ConsentOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(consentOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Consent OS',
      subtitle: 'Privacy consent, GDPR compliance, and data subject rights.',
      icon: Icons.privacy_tip_outlined,
      accentColor: const Color(0xFF3B82F6),
      stats: statsAsync,
      activityLabel: 'Consent Activity',
      kpiBuilder: (s) => [
        OsKpiData('Total Consents', s.kpi('totalConsents').toStringAsFixed(0), Icons.check_circle_outline, AppColors.success),
        OsKpiData('Active', s.kpi('activeConsents').toStringAsFixed(0), Icons.toggle_on_outlined, AppColors.primary),
        OsKpiData('Revoked', s.kpi('revokedConsents').toStringAsFixed(0), Icons.do_not_disturb_on_outlined, AppColors.error),
        OsKpiData('GDPR Compliant', s.kpi('gdprCompliant').toStringAsFixed(0), Icons.shield_outlined, AppColors.info),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// DEVAPI OS
// ---------------------------------------------------------------------------
class DevApiOsDashboard extends ConsumerWidget {
  const DevApiOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(devApiOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'DevAPI OS',
      subtitle: 'External API gateway, rate limits, and key management.',
      icon: Icons.api_outlined,
      accentColor: const Color(0xFFF59E0B),
      stats: statsAsync,
      activityLabel: 'Recent Integration Logs',
      kpiBuilder: (s) => [
        OsKpiData('API Keys', s.kpi('apiKeys').toStringAsFixed(0), Icons.key_outlined, AppColors.primary),
        OsKpiData('Integrations', s.kpi('integrations').toStringAsFixed(0), Icons.hub_outlined, AppColors.info),
        OsKpiData('Webhooks', s.kpi('webhooks').toStringAsFixed(0), Icons.webhook_outlined, AppColors.success),
        OsKpiData('Failed Deliveries', s.kpi('failedDeliveries').toStringAsFixed(0), Icons.error_outline, AppColors.error),
      ],
    );
  }
}
