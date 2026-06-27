import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final user = ref.read(authProvider).user;

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context, colors),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMarketingHeader(colors),
                  const SizedBox(height: 32),
                  _buildPrimaryMetrics(colors),
                  const SizedBox(height: 32),
                  _buildRevenueAnalytics(colors),
                  const SizedBox(height: 32),
                  _buildLeadFunnel(colors),
                  const SizedBox(height: 32),
                  _buildChannelPerformance(colors),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ThemeAwareColors colors) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 16),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('mobile.auto.this_month'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded, color: colors.textSecondary.withOpacity(0.5), size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketingHeader(ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 12),
              SizedBox(width: 6),
              Text('mobile.auto.neural_analytics_engine'.tr(),
                style: GoogleFonts.outfit(
                  color: AppColors.primary,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text('mobile.auto.corporate_analytics'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        Text('mobile.auto.track_your_revenue_stream_and_operational_efficiency'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryMetrics(ThemeAwareColors colors) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildMetricCard('mobile.leftovers.monthly_revenue'.tr(), '\$242,500', '+12.5%', Icons.payments_outlined, Colors.green, colors),
        _buildMetricCard('mobile.leftovers.avg_rental'.tr(), '\$2,450', '+4.3%', Icons.home_outlined, Colors.blue, colors),
        _buildMetricCard('mobile.leftovers.active_clients'.tr(), '1,284', '+8.1%', Icons.people_outline, Colors.purple, colors),
        _buildMetricCard('mobile.leftovers.ai_prediction_score'.tr(), '98.4%', '+1.2%', Icons.psychology_outlined, Colors.amber, colors),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, String change, IconData icon, Color color, ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 18),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(change, style: const TextStyle(color: Colors.green, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Spacer(),
          Text(label, style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRevenueAnalytics(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.revenue_trend'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('mobile.auto.weekly_cumulative_growth'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12)),
                ],
              ),
              const Icon(Icons.query_stats_rounded, color: AppColors.primary, size: 24),
            ],
          ),
          const SizedBox(height: 40),
          // Placeholder for Area Chart
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(12, (i) {
                final height = 30 + (i * 7);
                return Container(
                  width: 14,
                  height: height.toDouble(),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primary.withOpacity(0.3)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('mobile.auto.year_to_date_goal'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12)),
              Text('mobile.auto.68_completed'.tr(), style: GoogleFonts.outfit(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.68,
              minHeight: 8,
              backgroundColor: colors.background,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadFunnel(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.sales_funnel'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildFunnelStep('mobile.leftovers.new_leads'.tr(), '2,482', 1.0, Colors.blue, colors),
          _buildFunnelStep('Contacted', '1,120', 0.65, Colors.indigo, colors),
          _buildFunnelStep('Proposaled', '480', 0.35, Colors.purple, colors),
          _buildFunnelStep('Closed', '142', 0.15, Colors.green, colors),
        ],
      ),
    );
  }

  Widget _buildFunnelStep(String label, String count, double width, Color color, ThemeAwareColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12)),
              Text(count, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: (width * 100).toInt(),
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.4)),
                  ),
                ),
              ),
              Expanded(
                flex: ((1 - width) * 100).toInt(),
                child: const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelPerformance(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.channel_performance'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildChannelItem('Airbnb', 0.85, colors),
          _buildChannelItem('mobile.leftovers.booking_com'.tr(), 0.72, colors),
          _buildChannelItem('mobile.leftovers.direct_sales'.tr(), 0.45, colors),
          _buildChannelItem('mobile.leftovers.instagram_reels'.tr(), 0.92, colors),
        ],
      ),
    );
  }

  Widget _buildChannelItem(String channel, double val, ThemeAwareColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(channel, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
              Text('${(val * 100).toInt()}%', style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: val,
              minHeight: 4,
              backgroundColor: colors.background,
              valueColor: AlwaysStoppedAnimation(AppColors.primary.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }
}
