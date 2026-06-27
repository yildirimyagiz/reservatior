import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AIInsightsWidget extends StatelessWidget {
  const AIInsightsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final insights = [
      {
        'title': 'mobile.leftovers.market_trend_alert'.tr(),
        'description':
            'mobile.leftovers.property_prices_in_dubai_marina_increase'.tr(),
        'icon': Icons.trending_up,
        'color': Colors.green,
        'time': 'mobile.leftovers.2_hours_ago'.tr(),
      },
      {
        'title': 'mobile.leftovers.investment_opportunity'.tr(),
        'description':
            'mobile.leftovers.3_undervalued_properties_detected_in_you'.tr(),
        'icon': Icons.lightbulb,
        'color': Colors.orange,
        'time': 'mobile.leftovers.5_hours_ago'.tr(),
      },
      {
        'title': 'mobile.leftovers.lead_quality_score'.tr(),
        'description': 'mobile.leftovers.your_lead_conversion_rate_improved_by_15'.tr(),
        'icon': Icons.assessment,
        'color': Colors.blue,
        'time': 'mobile.leftovers.1_day_ago'.tr(),
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('mobile.auto.ai_insights'.tr(),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.psychology, size: 16, color: Colors.purple),
                    SizedBox(width: 4),
                    Text('mobile.auto.ai_powered'.tr(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...insights.map(
            (insight) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildInsightCard(insight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(Map<String, dynamic> insight) {
    final color = insight['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(insight['icon'] as IconData, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight['title'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  insight['description'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  insight['time'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
