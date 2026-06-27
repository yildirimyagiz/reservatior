import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class AiValuationScreen extends ConsumerWidget {
  const AiValuationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('mobile.auto.ai_valuations'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 130),
        children: [
          _buildSummaryStats(colors),
          SizedBox(height: 32),
          Text('mobile.auto.latest_valuations'.tr(),
            style: GoogleFonts.outfit(
              color: colors.textPrimary.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ..._mockValuations.asMap().entries.map((e) => _buildValuationCard(e.value, colors, e.key)),
        ],
      ),
    );
  }

  Widget _buildSummaryStats(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('mobile.leftovers.avg_confidence'.tr(), '92%', Colors.greenAccent, colors),
          Container(width: 1, height: 40, color: colors.border),
          _buildStatItem('mobile.leftovers.market_trend'.tr(), 'Rising', Colors.blueAccent, colors),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, ThemeAwareColors colors) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.outfit(
            color: colors.textSecondary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildValuationCard(Map<String, dynamic> v, ThemeAwareColors colors, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  v['propertyName'] as String,
                  style: GoogleFonts.outfit(
                    color: colors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (v['trend'] == 'RISING' ? Colors.green : Colors.orange).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  v['trend'] as String,
                  style: GoogleFonts.outfit(
                    color: v['trend'] == 'RISING' ? Colors.green : Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMetric('mobile.leftovers.est_value'.tr(), '\$${v['value']}', colors),
              const Spacer(),
              _buildMetric('CONFIDENCE', '${v['confidence']}%', colors),
              const Spacer(),
              _buildMetric('mobile.leftovers.p_sqft'.tr(), '\$${v['psqft']}', colors),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.history_rounded, size: 14, color: colors.textSecondary),
              const SizedBox(width: 4),
              Text(
                'Valued on ${v['date']}',
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 11),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text('mobile.auto.re_valuate'.tr(),
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideX(begin: 0.1);
  }

  Widget _buildMetric(String label, String value, ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: colors.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  static final _mockValuations = [
    {
      'propertyName': 'mobile.leftovers.sunset_villa'.tr(),
      'value': '892,000',
      'confidence': 91,
      'trend': 'RISING',
      'date': 'mobile.leftovers.jan_10_2025'.tr(),
      'psqft': 445,
    },
    {
      'propertyName': 'mobile.leftovers.oak_street_12'.tr(),
      'value': '445,000',
      'confidence': 87,
      'trend': 'STABLE',
      'date': 'mobile.leftovers.jan_09_2025'.tr(),
      'psqft': 320,
    },
    {
      'propertyName': 'mobile.leftovers.central_studio'.tr(),
      'value': '198,000',
      'confidence': 78,
      'trend': 'STABLE',
      'date': 'mobile.leftovers.jan_08_2025'.tr(),
      'psqft': 280,
    },
  ];
}
