import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class BehavioralScoringPage extends ConsumerWidget {
  const BehavioralScoringPage({super.key});

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
                    'agent.scoring.title'.tr(),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ScoreOverview(
                overallScore: 84,
                responseLatency: 2.3,
                conversionRate: 8.4,
                avgRating: 4.7,
                dealsClosed: 28,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'agent.scoring.rankings'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ...List.generate(10, (i) => _AgentScoreTile(
                  rank: i + 1,
                  name: ['Sarah Johnson', 'Michael Chen', 'Anna Williams', 'James Rodriguez', 'Emma Thompson', 'Robert Kim', 'Lisa Anderson', 'David Miller', 'Olivia Brown', 'Daniel Wilson'][i],
                  score: (95 - i * 4 - (i % 3) * 2),
                  deals: 42 - i * 3,
                  responseTime: '${(1.2 + i * 0.4).toStringAsFixed(1)}m',
                  trend: i < 3 ? 'up' : i < 7 ? 'stable' : 'down',
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreOverview extends StatelessWidget {
  final int overallScore;
  final double responseLatency;
  final double conversionRate;
  final double avgRating;
  final int dealsClosed;

  const _ScoreOverview({
    required this.overallScore,
    required this.responseLatency,
    required this.conversionRate,
    required this.avgRating,
    required this.dealsClosed,
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
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.success, width: 3),
                  color: AppColors.success.withValues(alpha: 0.08),
                ),
                child: Center(
                  child: Text(
                    '$overallScore',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'agent.scoring.tenant_score'.tr(),
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'agent.scoring.above_avg'.tr(),
                      style: GoogleFonts.outfit(color: AppColors.success, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.darkBorder),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ScoreMetric(label: 'agent.scoring.response'.tr(), value: '${responseLatency}m', icon: Icons.timer, color: AppColors.warning),
              _ScoreMetric(label: 'agent.scoring.conversion'.tr(), value: '$conversionRate%', icon: Icons.trending_up, color: AppColors.success),
              _ScoreMetric(label: 'agent.scoring.rating'.tr(), value: '$avgRating', icon: Icons.star, color: AppColors.info),
              _ScoreMetric(label: 'agent.scoring.deals'.tr(), value: '$dealsClosed', icon: Icons.handshake, color: AppColors.primary),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _ScoreMetric extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ScoreMetric({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
    );
  }
}

class _AgentScoreTile extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final int deals;
  final String responseTime;
  final String trend;

  const _AgentScoreTile({
    required this.rank,
    required this.name,
    required this.score,
    required this.deals,
    required this.responseTime,
    required this.trend,
  });

  Color _scoreColor() {
    if (score >= 90) return AppColors.success;
    if (score >= 75) return AppColors.primary;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  IconData _trendIcon() {
    switch (trend) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _trendColor() {
    switch (trend) {
      case 'up':
        return AppColors.success;
      case 'down':
        return AppColors.error;
      default:
        return AppColors.textSecondaryDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '#$rank',
              style: GoogleFonts.outfit(
                color: rank <= 3 ? AppColors.primary : AppColors.textSecondaryDark,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Icon(_trendIcon(), color: _trendColor(), size: 18),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _scoreColor().withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '$score',
              style: GoogleFonts.outfit(
                color: _scoreColor(),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'agent.scoring.deals_format'.tr(namedArgs: {'count': '$deals'}),
            style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
          ),
          const SizedBox(width: 8),
          Text(
            responseTime,
            style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 30 * rank));
  }
}
