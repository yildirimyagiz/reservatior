import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class RevenueDagScreen extends ConsumerWidget {
  const RevenueDagScreen({super.key});

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
                    'revenue.dag.title'.tr(),
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
              child: _DagOverview(
                totalRevenue: '\$4,230,000',
                averageYield: '8.4%',
                projectedGrowth: '+12.3%',
                activeContracts: 24,
                revenuePerUnit: '\$176,250',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                _DagFlowVisualization(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'revenue.dag.commission_evolution'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'revenue.dag.uplift_format'.tr(namedArgs: {'percent': '3.2'}),
                        style: GoogleFonts.outfit(
                          color: AppColors.success,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(8, (i) => _CommissionEvolutionTile(
                  contractName: ['Bodrum Luxury Villas', 'Istanbul PM', 'Antalya Retreats', 'Ankara Portfolio', 'Izmar Marina', 'Fethiye Homes', 'Cappadocia Cave', 'Trabzon Highland'][i],
                  currentRate: '${(5.0 + i * 0.8).toStringAsFixed(1)}%',
                  initialRate: '${(3.0 + i * 0.5).toStringAsFixed(1)}%',
                  uplift: '+${(2.0 + i * 0.3).toStringAsFixed(1)}%',
                  revenueGenerated: '\$${(89000 + i * 34000).toStringAsFixed(0)}',
                  lifecycleStage: i < 2 ? 'Growth' : i < 4 ? 'Mature' : i < 6 ? 'Optimizing' : 'Legacy',
                  behaviorScore: 95 - i * 5,
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DagOverview extends StatelessWidget {
  final String totalRevenue;
  final String averageYield;
  final String projectedGrowth;
  final int activeContracts;
  final String revenuePerUnit;

  const _DagOverview({
    required this.totalRevenue,
    required this.averageYield,
    required this.projectedGrowth,
    required this.activeContracts,
    required this.revenuePerUnit,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.account_tree, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'revenue.dag.graph_title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'revenue.dag.description'.tr(),
                    style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DagMetric(label: 'revenue.dag.total_revenue'.tr(), value: totalRevenue, color: AppColors.primary),
              _DagMetric(label: 'revenue.dag.avg_yield'.tr(), value: averageYield, color: AppColors.success),
              _DagMetric(label: 'revenue.dag.growth'.tr(), value: projectedGrowth, color: AppColors.info),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.darkBorder),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _DagMetricSmall(label: 'revenue.dag.active_contracts'.tr(), value: '$activeContracts'),
              _DagMetricSmall(label: 'revenue.dag.rev_per_unit'.tr(), value: revenuePerUnit),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _DagMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _DagMetric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 20, color: color),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
    );
  }
}

class _DagMetricSmall extends StatelessWidget {
  final String label;
  final String value;
  const _DagMetricSmall({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
    );
  }
}

class _DagFlowVisualization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nodes = [
      _DagNode('revenue.dag.listing_os'.tr(), 'revenue.dag.exposure_score'.tr(), AppColors.primary),
      _DagNode('revenue.dag.booking_os'.tr(), 'revenue.dag.conversion_prob'.tr(), AppColors.success),
      _DagNode('revenue.dag.agent_os_dag'.tr(), 'revenue.dag.behavior_score'.tr(), AppColors.warning),
      _DagNode('revenue.dag.finance_os_dag'.tr(), 'revenue.dag.time_decay'.tr(), AppColors.info),
      _DagNode('revenue.dag.revenue_dag'.tr(), 'revenue.dag.yield_optimized'.tr(), AppColors.error),
    ];

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
            'revenue.dag.data_flow_graph'.tr(),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(nodes.length, (i) {
                final n = nodes[i];
                final isLast = i == nodes.length - 1;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: n.color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: n.color.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            n.label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              color: n.color,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            n.metric,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              color: AppColors.textSecondaryDark,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(Icons.arrow_forward, color: AppColors.darkBorder, size: 14),
                      ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sync, color: AppColors.error, size: 14),
                const SizedBox(width: 6),
                Text(
                  'revenue.dag.closed_loop'.tr(),
                  style: GoogleFonts.outfit(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 200));
  }
}

class _DagNode {
  final String label;
  final String metric;
  final Color color;
  const _DagNode(this.label, this.metric, this.color);
}

class _CommissionEvolutionTile extends StatelessWidget {
  final String contractName;
  final String currentRate;
  final String initialRate;
  final String uplift;
  final String revenueGenerated;
  final String lifecycleStage;
  final int behaviorScore;

  const _CommissionEvolutionTile({
    required this.contractName,
    required this.currentRate,
    required this.initialRate,
    required this.uplift,
    required this.revenueGenerated,
    required this.lifecycleStage,
    required this.behaviorScore,
  });

  Color _stageColor() {
    switch (lifecycleStage) {
      case 'Growth':
        return AppColors.info;
      case 'Mature':
        return AppColors.success;
      case 'Optimizing':
        return AppColors.warning;
      case 'Legacy':
        return AppColors.textSecondaryDark;
      default:
        return AppColors.primary;
    }
  }

  String _translatedStage() {
    switch (lifecycleStage) {
      case 'Growth':
        return 'revenue.dag.growth_label'.tr();
      case 'Mature':
        return 'revenue.dag.mature'.tr();
      case 'Optimizing':
        return 'revenue.dag.optimizing'.tr();
      case 'Legacy':
        return 'revenue.dag.legacy'.tr();
      default:
        return lifecycleStage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
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
              Expanded(
                child: Text(
                  contractName,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _stageColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _translatedStage(),
                  style: GoogleFonts.outfit(
                    color: _stageColor(),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _CommissionMetric(label: 'revenue.dag.current_label'.tr(), value: currentRate, color: AppColors.success),
              const SizedBox(width: 16),
              _CommissionMetric(label: 'revenue.dag.initial_label'.tr(), value: initialRate, color: AppColors.textSecondaryDark),
              const SizedBox(width: 16),
              _CommissionMetric(label: 'revenue.dag.uplift_label'.tr(), value: uplift, color: AppColors.primary),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    revenueGenerated,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'revenue.dag.behavior_format'.tr(namedArgs: {'score': '$behaviorScore'}),
                    style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: behaviorScore / 100,
              backgroundColor: AppColors.darkBorder,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
              minHeight: 4,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}

class _CommissionMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _CommissionMetric({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 10),
        ),
      ],
    );
  }
}
