import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RevenueIntelligenceScreen extends ConsumerWidget {
  const RevenueIntelligenceScreen({super.key});

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
                        'Revenue Intelligence',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Revenue optimization, revenue share & forecasting',
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
                _sectionHeader('NOI Optimization', Icons.psychology_outlined, AppColors.primaryLight),
                const SizedBox(height: 12),
                _buildNoiAnalysis(),
                const SizedBox(height: 20),
                _sectionHeader('Revenue Streams', Icons.ssid_chart_outlined, AppColors.info),
                const SizedBox(height: 12),
                ..._buildRevenueStreams(),
                const SizedBox(height: 20),
                _sectionHeader('Optimization Opportunities', Icons.bolt_outlined, AppColors.warning),
                const SizedBox(height: 12),
                ..._buildOpportunities(),
                const SizedBox(height: 20),
                _sectionHeader('Predictive Insights', Icons.calendar_month_outlined, AppColors.primaryLight),
                const SizedBox(height: 12),
                _buildPredictiveInsights(),
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
      ('Total Revenue', '\$1.2M', Icons.payments_outlined, AppColors.info, 0),
      ('Net Operating Income', '\$845K', Icons.trending_up, AppColors.info, 60),
      ('Yield Arbitrage', '8.5%', Icons.ads_click, AppColors.primaryLight, 120),
      ('Revenue Attribution', '22.3%', Icons.bar_chart_outlined, AppColors.warning, 180),
      ('Avg Occupancy', '86.4%', Icons.apartment_outlined, AppColors.primaryLight, 240),
      ('Revenue Growth', '18.7%', Icons.show_chart_outlined, const Color(0xFFEC4899), 300),
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

  Widget _buildNoiAnalysis() {
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
            children: [
              Expanded(
                child: _statBox('Current NOI', '\$845K', AppColors.info),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statBox('Optimization Potential', '12.4%', AppColors.info),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _recommendationBox(
            'Dynamic Pricing Adjustment',
            'Increase weekend rates by 15% based on demand models',
            Icons.bolt_outlined,
            AppColors.primaryLight,
          ),
          const SizedBox(height: 10),
          _recommendationBox(
            'Expense Optimization',
            'Reduce maintenance costs by 8% with predictive planning',
            Icons.ads_click,
            AppColors.info,
          ),
        ],
      ),
    );
  }

  Widget _statBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
          const SizedBox(height: 6),
          Text(value, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  Widget _recommendationBox(String title, String desc, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
                const SizedBox(height: 3),
                Text(desc, style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRevenueStreams() {
    final streams = [
      ('Direct Bookings', '45%', '+12%', AppColors.info),
      ('Channel Partners', '32%', '+8%', AppColors.info),
      ('Corporate Contracts', '15%', '+15%', AppColors.primaryLight),
      ('Long-term Rentals', '8%', '+5%', AppColors.warning),
    ];
    return streams.map((s) {
      final (name, value, trend, color) = s;
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
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(name, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
            ),
            Text(value, style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondaryDark)),
            const SizedBox(width: 14),
            Text(trend, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.info)),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildOpportunities() {
    final opps = [
      ('Dynamic Pricing', '+18%', 'High', 'Medium'),
      ('Channel Optimization', '+12%', 'Medium', 'Low'),
      ('Yield Arbitrage', '+8%', 'High', 'High'),
      ('Occupancy Boost', '+6%', 'Medium', 'Medium'),
    ];
    return opps.map((o) {
      final (name, potential, impact, effort) = o;
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _chip(impact, 'impact', AppColors.error),
                      const SizedBox(width: 6),
                      _chip(effort, 'effort', AppColors.info),
                    ],
                  ),
                ],
              ),
            ),
            Text(potential, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.info)),
          ],
        ),
      );
    }).toList();
  }

  Widget _chip(String text, String type, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$text $type',
        style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }

  Widget _buildPredictiveInsights() {
    final insights = [
      ('Next Month Revenue', '\$102K', 92),
      ('Q3 Forecast', '\$306K', 87),
      ('Annual Projection', '\$1.22M', 81),
    ];
    return Row(
      children: insights.map((ins) {
        final (metric, predicted, confidence) = ins;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(metric, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
                const SizedBox(height: 6),
                Text(predicted, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primaryLight)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: confidence / 100,
                    minHeight: 5,
                    backgroundColor: AppColors.darkMuted,
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text('$confidence% confidence', style: GoogleFonts.outfit(fontSize: 9, color: AppColors.primaryLight)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
