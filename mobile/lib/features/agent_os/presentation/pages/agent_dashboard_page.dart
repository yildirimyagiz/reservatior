import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class AgentDashboardPage extends ConsumerWidget {
  const AgentDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                _AgentMetricRow(
                  leadsActive: 14,
                  conversionRate: 8.4,
                  responseLatency: '2.3m',
                  avgRating: 4.7,
                ),
                const SizedBox(height: 24),
                _AgentModuleCard(
                  title: 'agent.os.compliance'.tr(),
                  subtitle: 'agent.os.compliance_sub'.tr(),
                  icon: Icons.gavel,
                  color: AppColors.primary,
                  onTap: () => context.push('/agent-compliance'),
                ),
                const SizedBox(height: 12),
                _AgentModuleCard(
                  title: 'agent.os.verification'.tr(),
                  subtitle: 'agent.os.verification_sub'.tr(),
                  icon: Icons.verified_user,
                  color: AppColors.success,
                  onTap: () => context.push('/agent-verification'),
                ),
                const SizedBox(height: 12),
                _AgentModuleCard(
                  title: 'agent.os.scoring'.tr(),
                  subtitle: 'agent.os.scoring_sub'.tr(),
                  icon: Icons.insights,
                  color: AppColors.warning,
                  onTap: () => context.push('/agent-scoring'),
                ),
                const SizedBox(height: 24),
                Text(
                  'agent.os.opportunities'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(5, (i) => _AgentOpportunityTile(
                  title: i == 0 ? 'Luxury Villa - Bodrum' : 'Apartment #${2400 + i}',
                  value: '\$${(1250000 - i * 180000).toStringAsFixed(0)}',
                  probability: '${88 - i * 7}%',
                  daysOnMarket: 12 + i * 3,
                  client: i.isEven ? 'John & Sarah M.' : 'Ali Y.',
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentMetricRow extends StatelessWidget {
  final int leadsActive;
  final double conversionRate;
  final String responseLatency;
  final double avgRating;

  const _AgentMetricRow({
    required this.leadsActive,
    required this.conversionRate,
    required this.responseLatency,
    required this.avgRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'agent.os.data_intake'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'agent.os.telemetry_desc'.tr(),
            style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _AgentMetric(label: 'agent.os.active_leads'.tr(), value: '$leadsActive', color: AppColors.primary),
              _AgentMetric(label: 'agent.os.conversion'.tr(), value: '$conversionRate%', color: AppColors.success),
              _AgentMetric(label: 'agent.os.response'.tr(), value: responseLatency, color: AppColors.warning),
              _AgentMetric(label: 'agent.os.rating'.tr(), value: '$avgRating', color: AppColors.info),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _AgentMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _AgentMetric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            fontSize: 20,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
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
