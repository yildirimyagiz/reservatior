import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenueChartWidget extends StatelessWidget {
  const RevenueChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(16),
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset:  Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.auto.revenue_overview'.tr(),
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // Chart Placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_chart, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('mobile.auto.revenue_chart'.tr(), style: TextStyle(color: Colors.grey)),
                  Text('mobile.auto.chart_integration_coming_soon'.tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

           SizedBox(height: 16),

          // Weekly Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeekStat('mobile.leftovers.this_week'.tr(), '\$12,450', Colors.green),
              _buildWeekStat('mobile.leftovers.last_week'.tr(), '\$11,230', Colors.grey),
              _buildWeekStat('Change', '+10.9%', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
