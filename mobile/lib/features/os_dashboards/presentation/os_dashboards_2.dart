import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/os_dashboard_providers.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

// ---------------------------------------------------------------------------
// DEVELOPER OS
// ---------------------------------------------------------------------------
class DeveloperOsDashboard extends ConsumerWidget {
  const DeveloperOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(developerOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Developer OS',
      subtitle: 'Internal tooling, CI/CD pipelines, and deploy management.',
      icon: Icons.code_outlined,
      accentColor: const Color(0xFF06B6D4),
      stats: statsAsync,
      activityLabel: 'Recent Logs',
      kpiBuilder: (s) => [
        OsKpiData('API Keys', s.kpi('totalApiKeys').toStringAsFixed(0), Icons.key_outlined, AppColors.primary),
        OsKpiData('Integrations', s.kpi('activeIntegrations').toStringAsFixed(0), Icons.hub_outlined, AppColors.info),
        OsKpiData('Webhooks', s.kpi('totalWebhooks').toStringAsFixed(0), Icons.webhook_outlined, AppColors.success),
        OsKpiData('Failed Deliveries', s.kpi('failedDeliveries').toStringAsFixed(0), Icons.error_outline, AppColors.error),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// GOVERNANCE OS
// ---------------------------------------------------------------------------
class GovernanceOsDashboard extends ConsumerWidget {
  const GovernanceOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(governanceOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Governance OS',
      subtitle: 'Policies, audit trails, role management, and compliance.',
      icon: Icons.account_balance_outlined,
      accentColor: const Color(0xFF8B5CF6),
      stats: statsAsync,
      activityLabel: 'Recent Audits',
      kpiBuilder: (s) => [
        OsKpiData('Automation Rules', s.kpi('rules').toStringAsFixed(0), Icons.rule_outlined, AppColors.primary),
        OsKpiData('Active Compliance', s.kpi('activeCompliance').toStringAsFixed(0), Icons.verified_outlined, AppColors.success),
        OsKpiData('Pending Approvals', s.kpi('pendingApprovals').toStringAsFixed(0), Icons.pending_outlined, AppColors.warning),
        OsKpiData('Compliance Types', s.kpi('complianceByType').toStringAsFixed(0), Icons.shield_outlined, AppColors.info),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// NOTIFICATION OS
// ---------------------------------------------------------------------------
class NotificationOsDashboard extends ConsumerWidget {
  const NotificationOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(notificationOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Notification OS',
      subtitle: 'Push, email, SMS, and in-app notification orchestration.',
      icon: Icons.notifications_outlined,
      accentColor: const Color(0xFFF97316),
      stats: statsAsync,
      activityLabel: 'Recent Notifications',
      kpiBuilder: (s) => [
        OsKpiData('Notifications', s.kpi('totalNotifications').toStringAsFixed(0), Icons.send_outlined, AppColors.primary),
        OsKpiData('Queued', s.kpi('unreadCount').toStringAsFixed(0), Icons.schedule_outlined, AppColors.warning),
        OsKpiData('Messages', s.kpi('totalMessages').toStringAsFixed(0), Icons.chat_bubble_outline, AppColors.info),
        OsKpiData('Channels', s.kpi('channelStats').toStringAsFixed(0), Icons.hub_outlined, AppColors.success),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// PARTNER OS
// ---------------------------------------------------------------------------
class PartnerOsDashboard extends ConsumerWidget {
  const PartnerOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(partnerOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Partner OS',
      subtitle: 'Channel partners, revenue sharing, and API access tiers.',
      icon: Icons.handshake_outlined,
      accentColor: const Color(0xFF10B981),
      stats: statsAsync,
      activityLabel: 'Top Vendors',
      kpiBuilder: (s) => [
        OsKpiData('Partners', s.kpi('totalPartners').toStringAsFixed(0), Icons.business_outlined, AppColors.primary),
        OsKpiData('Active Agreements', s.kpi('activeAgreements').toStringAsFixed(0), Icons.check_circle_outline, AppColors.success),
        OsKpiData('Pending Agreements', s.kpi('pendingAgreements').toStringAsFixed(0), Icons.pending_outlined, AppColors.warning),
        OsKpiData('Revenue Share', osFormatCompact(s.kpi('totalRevenue'), prefix: r'$'), Icons.attach_money, AppColors.info),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECURITY OS
// ---------------------------------------------------------------------------
class SecurityOsDashboard extends ConsumerWidget {
  const SecurityOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(securityOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Security OS',
      subtitle: 'Threat monitoring, access control, and incident response.',
      icon: Icons.security_outlined,
      accentColor: const Color(0xFFEF4444),
      stats: statsAsync,
      activityLabel: 'Recent Audits',
      kpiBuilder: (s) => [
        OsKpiData('Security Score', s.kpi('securityScore').toStringAsFixed(0), Icons.radar, AppColors.success),
        OsKpiData('Active Threats', s.kpi('activeThreats').toStringAsFixed(0), Icons.warning_amber_outlined, AppColors.error),
        OsKpiData('Resolved Incidents', s.kpi('resolvedIncidents').toStringAsFixed(0), Icons.verified_outlined, AppColors.info),
        OsKpiData('Compliance', '${s.kpi('compliance').toStringAsFixed(0)}%', Icons.shield_outlined, AppColors.warning),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TRUST OS
// ---------------------------------------------------------------------------
class TrustOsDashboard extends ConsumerWidget {
  const TrustOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(trustOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Trust OS',
      subtitle: 'User verification, fraud prevention, and reputation scores.',
      icon: Icons.verified_user_outlined,
      accentColor: const Color(0xFF3B82F6),
      stats: statsAsync,
      activityLabel: 'Recent Trust Events',
      kpiBuilder: (s) => [
        OsKpiData('Total Scores', s.kpi('totalScores').toStringAsFixed(0), Icons.verified_outlined, AppColors.success),
        OsKpiData('Active', s.kpi('activeScores').toStringAsFixed(0), Icons.toggle_on_outlined, AppColors.primary),
        OsKpiData('Avg Score', s.kpi('avgScore').toStringAsFixed(1), Icons.stars_outlined, AppColors.warning),
        OsKpiData('Events Today', s.kpi('eventsToday').toStringAsFixed(0), Icons.bolt, AppColors.info),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// USER OS
// ---------------------------------------------------------------------------
class UserOsDashboard extends ConsumerWidget {
  const UserOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userId = authState.user?.id ?? '';
    final statsAsync = ref.watch(userOsStatsProvider(userId));
    return OsLiveDashboardScaffold(
      title: 'User OS',
      subtitle: 'User accounts, roles, permissions, and profile management.',
      icon: Icons.manage_accounts_outlined,
      accentColor: const Color(0xFF6366F1),
      stats: statsAsync,
      activityLabel: 'Recent Activity',
      kpiBuilder: (s) => [
        OsKpiData('Unread Notifications', s.kpi('unreadCount').toStringAsFixed(0), Icons.notifications_outlined, AppColors.warning),
        OsKpiData('Journey Stage', _nonEmpty(s.kpiString('journey.currentStage')), Icons.route_outlined, AppColors.primary),
        OsKpiData('Days Since Creation', s.kpi('journey.daysSinceCreation').toStringAsFixed(0), Icons.calendar_today_outlined, AppColors.info),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// LOCALIZATION OS
// ---------------------------------------------------------------------------
class LocalizationOsDashboard extends ConsumerWidget {
  const LocalizationOsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(localizationOsStatsProvider(orgId));
    return OsLiveDashboardScaffold(
      title: 'Localization OS',
      subtitle: 'Multi-language content, translation status, and region config.',
      icon: Icons.language_outlined,
      accentColor: const Color(0xFF14B8A6),
      stats: statsAsync,
      activityLabel: 'Recent Compliance',
      kpiBuilder: (s) => [
        OsKpiData('Countries', s.kpi('totalCountries').toStringAsFixed(0), Icons.public_outlined, AppColors.primary),
        OsKpiData('Currencies', s.kpi('totalCurrencies').toStringAsFixed(0), Icons.currency_exchange_outlined, AppColors.info),
        OsKpiData('Languages', s.kpi('totalLanguages').toStringAsFixed(0), Icons.translate_outlined, AppColors.success),
        OsKpiData('Exchange Rates', s.kpi('totalExchangeRates').toStringAsFixed(0), Icons.swap_horiz_outlined, AppColors.warning),
      ],
    );
  }
}

String _nonEmpty(String v) => v.isEmpty ? '—' : v;
