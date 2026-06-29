import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class FailoverInventoryScreen extends ConsumerWidget {
  const FailoverInventoryScreen({super.key});

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
                    'failover.title'.tr(),
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
              child: _FailoverStats(
                totalFailovers: 48,
                successfulReroutes: 42,
                recoveryRate: 87.5,
                activeTriggers: 6,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Text(
                  'failover.decision_flow'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                _DecisionFlow(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'failover.active_events'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'failover.active_count'.tr(namedArgs: {'count': '6'}),
                        style: GoogleFonts.outfit(
                          color: AppColors.warning,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(6, (i) {
                  final original = 'failover.main_hotel'.tr();
                  final fallback = i.isEven ? 'failover.serviced_apartment'.tr() : 'failover.nearby_hotel'.tr();
                  final reason = i < 2 ? 'failover.overbooked_label'.tr() : i < 4 ? 'failover.maintenance_label'.tr() : 'failover.price_surge_label'.tr();
                  return _FailoverEventTile(
                    propertyName: ['Bodrum Beach Villa', 'Taksim Penthouse', 'Antalya Resort', 'Marina Suite', 'Mountain Cabin', 'City Loft'][i],
                    originalInventory: original,
                    fallbackOption: fallback,
                    price: '\$${(450 + i * 80).toStringAsFixed(0)}/night',
                    savings: '-${(12 + i * 3).toStringAsFixed(0)}%',
                    confidenceScore: 94 - i * 4,
                    reason: reason,
                  );
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FailoverStats extends StatelessWidget {
  final int totalFailovers;
  final int successfulReroutes;
  final double recoveryRate;
  final int activeTriggers;

  const _FailoverStats({
    required this.totalFailovers,
    required this.successfulReroutes,
    required this.recoveryRate,
    required this.activeTriggers,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatCircle(label: 'failover.total_events'.tr(), value: '$totalFailovers', color: AppColors.primary),
              _StatCircle(label: 'failover.rerouted'.tr(), value: '$successfulReroutes', color: AppColors.success),
              _StatCircle(label: 'failover.recovery'.tr(), value: '$recoveryRate%', color: AppColors.info),
              _StatCircle(label: 'failover.active'.tr(), value: '$activeTriggers', color: AppColors.warning),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _StatCircle extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCircle({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.1),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Center(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
        ),
      ],
    );
  }
}

class _DecisionFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          _FlowStep(
            icon: Icons.search,
            label: 'failover.check_avail'.tr(),
            detail: 'failover.check_avail_detail'.tr(),
            color: AppColors.info,
            isLast: false,
          ),
          _FlowStep(
            icon: Icons.check_circle,
            label: 'failover.book_hotel'.tr(),
            detail: 'failover.book_hotel_detail'.tr(),
            color: AppColors.success,
            isLast: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'failover.or_fallback'.tr(),
                    style: GoogleFonts.outfit(
                      color: AppColors.warning,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _FlowStep(
            icon: Icons.swap_horiz,
            label: 'failover.search_alt'.tr(),
            detail: 'failover.search_alt_detail'.tr(),
            color: AppColors.warning,
            isLast: false,
          ),
          _FlowStep(
            icon: Icons.sort,
            label: 'failover.rank_options'.tr(),
            detail: 'failover.rank_detail'.tr(),
            color: AppColors.primary,
            isLast: false,
          ),
          _FlowStep(
            icon: Icons.task_alt,
            label: 'failover.offer_best'.tr(),
            detail: 'failover.offer_detail'.tr(),
            color: AppColors.success,
            isLast: true,
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 150));
  }
}

class _FlowStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final String detail;
  final Color color;
  final bool isLast;

  const _FlowStep({
    required this.icon,
    required this.label,
    required this.detail,
    required this.color,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.replaceAll('\n', ' '),
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  detail,
                  style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        if (!isLast) const SizedBox(height: 8),
      ],
    );
  }
}

class _FailoverEventTile extends StatelessWidget {
  final String propertyName;
  final String originalInventory;
  final String fallbackOption;
  final String price;
  final String savings;
  final int confidenceScore;
  final String reason;

  const _FailoverEventTile({
    required this.propertyName,
    required this.originalInventory,
    required this.fallbackOption,
    required this.price,
    required this.savings,
    required this.confidenceScore,
    required this.reason,
  });

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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.swap_horiz, color: AppColors.warning, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      propertyName,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'failover.reroute_format'.tr(namedArgs: {'original': originalInventory, 'fallback': fallbackOption}),
                      style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    savings,
                    style: GoogleFonts.outfit(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  reason,
                  style: GoogleFonts.outfit(
                    color: AppColors.error,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: confidenceScore / 100,
                    backgroundColor: AppColors.darkBorder,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'failover.confidence_format'.tr(namedArgs: {'score': '$confidenceScore'}),
                style: GoogleFonts.outfit(
                  color: AppColors.success,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}
