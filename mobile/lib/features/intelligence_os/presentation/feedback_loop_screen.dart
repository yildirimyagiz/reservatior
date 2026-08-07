import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FeedbackLoopScreen extends ConsumerWidget {
  const FeedbackLoopScreen({super.key});

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
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feedback Loop',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Guest reviews, satisfaction & AI learning loop',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildKpiGrid(),
                const SizedBox(height: 20),
                _sectionHeader('Prediction Accuracy', Icons.track_changes_outlined, AppColors.info),
                const SizedBox(height: 12),
                _buildAccuracyGauges(),
                const SizedBox(height: 20),
                _sectionHeader('Revenue: Predicted vs Actual', Icons.payments_outlined, AppColors.success),
                const SizedBox(height: 12),
                _buildRevenueComparison(),
                const SizedBox(height: 20),
                _sectionHeader('Recent Calibrations', Icons.show_chart, AppColors.primaryLight),
                const SizedBox(height: 12),
                ..._buildCalibrations(),
                const SizedBox(height: 20),
                _sectionHeader('Learning Loop', Icons.sync_alt_outlined, AppColors.warning),
                const SizedBox(height: 12),
                _buildLearningLoop(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildKpiGrid() {
    final kpis = [
      ('Total Calibrations', '247', Icons.show_chart, AppColors.primaryLight, 0),
      ('Prediction Accuracy', '87.3%', Icons.ads_click, AppColors.info, 60),
      ('Model Health', '94%', Icons.psychology_outlined, AppColors.info, 120),
      ('Content Refreshes', '23', Icons.refresh_outlined, AppColors.warning, 180),
      ('Upward', '142', Icons.arrow_upward, AppColors.info, 240),
      ('Downward', '78', Icons.arrow_downward, AppColors.error, 300),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.9,
      ),
      itemCount: kpis.length,
      itemBuilder: (context, index) {
        final (title, value, icon, color, delay) = kpis[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkCard.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.05, end: 0);
      },
    );
  }

  Widget _buildAccuracyGauges() {
    final gauges = [
      ('Price Prediction', 89, '+2.1%', AppColors.info),
      ('Rental Yield', 84, '+3.5%', const Color(0xFF6366F1)),
      ('Days on Market', 78, '-1.2%', AppColors.warning),
    ];
    return Row(
      children: gauges.map((g) {
        final (label, acc, trend, color) = g;
        final isPositive = trend.startsWith('+');
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.darkCard.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Column(
              children: [
                Text(label, textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
                const SizedBox(height: 10),
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: acc / 100,
                        strokeWidth: 8,
                        backgroundColor: AppColors.darkMuted,
                        color: color,
                      ),
                      Center(
                        child: Text('$acc%', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(trend, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: isPositive ? AppColors.info : AppColors.error)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRevenueComparison() {
    final boxes = [
      ('Predicted Commission', '£2.4M', AppColors.info),
      ('Actual Commission', '£2.1M', AppColors.info),
      ('Predicted Rental', '£890K', AppColors.primaryLight),
      ('Actual Rental', '£920K', AppColors.info),
    ];
    return Row(
      children: boxes.map((b) {
        final (label, value, color) = b;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.outfit(fontSize: 9, color: AppColors.textSecondaryDark)),
                const SizedBox(height: 6),
                Text(value, style: GoogleFonts.outfit(fontSize: 17, fontWeight: FontWeight.w800, color: color)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List<Widget> _buildCalibrations() {
    final cals = [
      ('Kensington 3BR', 'UPWARD', 0.08, 'Sold 12% above predicted price', '1h ago'),
      ('Chelsea Penthouse', 'DOWNWARD', -0.05, 'DOM 45% longer than predicted', '3h ago'),
      ('Shoreditch Loft', 'UPWARD', 0.03, 'Rental yield 8% above forecast', '5h ago'),
      ('Canary Wharf Studio', 'DOWNWARD', -0.11, 'Price reduction needed after 60 days', '8h ago'),
      ('Notting Hill Town', 'NEUTRAL', 0.02, 'Within tolerance range', '12h ago'),
      ('Manchester Waterfront', 'UPWARD', 0.15, 'Investment return 20% above prediction', '1d ago'),
    ];
    return cals.map((c) {
      final (prop, dir, delta, reason, time) = c;
      final color = dir == 'UPWARD' ? AppColors.info : dir == 'DOWNWARD' ? AppColors.error : AppColors.textSecondaryDark;
      final icon = dir == 'UPWARD' ? Icons.arrow_upward : dir == 'DOWNWARD' ? Icons.arrow_downward : Icons.show_chart;
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prop, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 3),
                  Text(reason, style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${delta > 0 ? '+' : ''}${(delta * 100).toStringAsFixed(1)}%', style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w800, color: color)),
                Text(time, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildLearningLoop() {
    final steps = ['Prediction', 'Outcome', 'Feedback', 'Calibration', 'Better Prediction'];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (i) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: i.isEven ? AppColors.info.withValues(alpha: 0.15) : AppColors.primaryLight.withValues(alpha: 0.12),
                ),
                child: Text(steps[i], style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w700, color: i.isEven ? AppColors.info : AppColors.primaryLight)),
              );
            }),
          ),
        ],
      ),
    );
  }
}
