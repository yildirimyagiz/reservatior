import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/agent_os_providers.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_live_widgets.dart';

class AgentDashboardPage extends ConsumerWidget {
  const AgentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final vacancyAsync = ref.watch(agentVacancyAlertsProvider(orgId));
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'agent.os.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.35)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.real_estate_agent, color: Color(0xFF60A5FA), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Realtor Advantage: Close listings 4x faster via Reservatior\'s 2% Rent Guarantee Fund & guaranteed escrow commission payouts.',
                          style: GoogleFonts.outfit(color: const Color(0xFFDBEAFE), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const _AgentKPICard(),
                const SizedBox(height: 24),
                _AgentModuleCard(
                  title: 'agent_os.commissions'.tr(),
                  subtitle: 'agent_os.commissions_sub'.tr(),
                  icon: Icons.payments,
                  color: AppColors.primary,
                  onTap: () => context.push('/agent-commissions'),
                ),
                const SizedBox(height: 12),
                _AgentModuleCard(
                  title: 'agent_os.compliance'.tr(),
                  subtitle: 'agent_os.compliance_sub'.tr(),
                  icon: Icons.gavel,
                  color: AppColors.success,
                  onTap: () => context.push('/agent-compliance'),
                ),
                const SizedBox(height: 12),
                _AgentModuleCard(
                  title: 'agent_os.verification'.tr(),
                  subtitle: 'agent_os.verification_sub'.tr(),
                  icon: Icons.verified_user,
                  color: AppColors.warning,
                  onTap: () => context.push('/agent-verification'),
                ),
                const SizedBox(height: 12),
                _AgentModuleCard(
                  title: 'agent_os.scoring'.tr(),
                  subtitle: 'agent_os.scoring_sub'.tr(),
                  icon: Icons.insights,
                  color: AppColors.info,
                  onTap: () => context.push('/agent-scoring'),
                ),
                const SizedBox(height: 24),
                Text(
                  'agent_os.opportunities'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...vacancyAsync.when(
                  loading: () => [const OsLiveLoading()],
                  error: (e, _) => [OsLiveErrorCard(message: 'Failed to load vacancy alerts: $e')],
                  data: (alerts) => alerts.take(5).map((a) => _AgentOpportunityTile(
                    title: a.listingTitle,
                    value: '${a.currency == 'USD' ? r'$' : a.currency + ' '}${a.currentPrice.toStringAsFixed(0)}',
                    probability: '${a.projectedOccupancy.round()}%',
                    daysOnMarket: a.vacancyDays,
                    client: a.marketPosition,
                  )).toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentKPICard extends ConsumerWidget {
  const _AgentKPICard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgId = ref.watch(authProvider).user?.organizationId ?? '';
    final statsAsync = ref.watch(agentOsStatsProvider(orgId));
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.3)),
      ),
      child: statsAsync.when(
        loading: () => const OsLiveLoading(),
        error: (e, _) => OsLiveErrorCard(message: 'Failed to load agent OS data: $e'),
        data: (s) {
          final closedDeals = s.kpi('closedDeals');
          final totalLeads = s.kpi('totalLeads');
          final conversion = s.kpi('avgConversionRate');
          final revenue = s.kpi('totalCommissionValue');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'agent_os.kpi_title'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _AgentKPI(
                      label: 'Closed Deals',
                      value: '${closedDeals.round()}',
                      trend: 'last 30d',
                      color: AppColors.success,
                      icon: Icons.people,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AgentKPI(
                      label: 'agent_os.active_leads'.tr(),
                      value: '${totalLeads.round()}',
                      trend: 'active',
                      color: AppColors.primary,
                      icon: Icons.person_search,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _AgentKPI(
                      label: 'agent_os.avg_conversion'.tr(),
                      value: '${conversion.toStringAsFixed(1)}%',
                      trend: 'rate',
                      color: AppColors.warning,
                      icon: Icons.trending_up,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AgentKPI(
                      label: 'Total Commission',
                      value: osFormatCompact(revenue, prefix: r'$'),
                      trend: '30d',
                      color: AppColors.info,
                      icon: Icons.attach_money,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ).animate().fadeIn().slideY();
  }
}

class _AgentKPI extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final Color color;
  final IconData icon;

  const _AgentKPI({
    required this.label,
    required this.value,
    required this.trend,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 12, color: color),
              const SizedBox(width: 4),
              Text(
                trend,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AgentModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AgentModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: AppColors.textSecondaryDark, size: 14),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.05);
  }
}

class _AgentOpportunityTile extends StatelessWidget {
  final String title;
  final String value;
  final String probability;
  final int daysOnMarket;
  final String client;

  const _AgentOpportunityTile({
    required this.title,
    required this.value,
    required this.probability,
    required this.daysOnMarket,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary.withValues(alpha: 0.2), AppColors.primary.withValues(alpha: 0.05)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.home_work, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'agent.os.opportunity_format'.tr(namedArgs: {'client': client, 'days': '$daysOnMarket'}),
                  style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'agent.os.probability_match'.tr(namedArgs: {'probability': probability}),
                  style: GoogleFonts.outfit(
                    color: AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}
