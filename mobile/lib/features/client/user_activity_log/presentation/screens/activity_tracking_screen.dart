import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class ActivityTrackingScreen extends ConsumerWidget {
  const ActivityTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(backgroundColor: colors.background, elevation: 0, title: Text('mobile.auto.activity'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: colors.textPrimary))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStatsRow(colors),
          SizedBox(height: 24),
          Text('mobile.auto.recent_activity'.tr(), style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700, color: colors.textPrimary)),
          const SizedBox(height: 12),
          ..._mockActivities.asMap().entries.map((e) => _buildActivityTile(e.value, colors, e.key)),
        ],
      ),
    );
  }

  Widget _buildStatsRow(ThemeAwareColors colors) {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Views', '2,847', Icons.visibility_rounded, Colors.blue, colors)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Actions', '156', Icons.touch_app_rounded, Colors.green, colors)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Time', '4.2h', Icons.timer_rounded, Colors.orange, colors)),
      ],
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(16), border: Border.all(color: colors.border)),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800, color: colors.textPrimary)),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildActivityTile(Map<String, dynamic> activity, ThemeAwareColors colors, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: colors.border)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: (activity['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(activity['icon'] as IconData, color: activity['color'] as Color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['title'] as String, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: colors.textPrimary, fontSize: 14)),
                const SizedBox(height: 2),
                Text(activity['desc'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(activity['time'] as String, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 80 * index)).slideX(begin: 0.05);
  }

  static final _mockActivities = [
    {'title': 'mobile.leftovers.property_viewed'.tr(), 'desc': 'mobile.leftovers.luxury_downtown_apartment'.tr(), 'time': 'mobile.leftovers.2m_ago'.tr(), 'icon': Icons.visibility, 'color': Colors.blue},
    {'title': 'mobile.leftovers.listing_created'.tr(), 'desc': 'mobile.leftovers.waterfront_villa_45'.tr(), 'time': 'mobile.leftovers.15m_ago'.tr(), 'icon': Icons.add_circle_outline, 'color': Colors.green},
    {'title': 'mobile.leftovers.message_sent'.tr(), 'desc': 'mobile.leftovers.to_buyer_john_smith'.tr(), 'time': 'mobile.leftovers.1h_ago'.tr(), 'icon': Icons.send_rounded, 'color': Colors.purple},
    {'title': 'mobile.leftovers.document_uploaded'.tr(), 'desc': 'mobile.leftovers.property_deed_scan_pdf'.tr(), 'time': 'mobile.leftovers.2h_ago'.tr(), 'icon': Icons.upload_file_rounded, 'color': Colors.orange},
    {'title': 'mobile.leftovers.ai_valuation_run'.tr(), 'desc': 'mobile.leftovers.manhattan_property_analysis'.tr(), 'time': 'mobile.leftovers.3h_ago'.tr(), 'icon': Icons.auto_awesome, 'color': AppColors.primary},
    {'title': 'mobile.leftovers.booking_confirmed'.tr(), 'desc': 'mobile.leftovers.viewing_for_45_park_ave'.tr(), 'time': 'mobile.leftovers.5h_ago'.tr(), 'icon': Icons.event_available, 'color': Colors.teal},
    {'title': 'mobile.leftovers.lead_assigned'.tr(), 'desc': 'mobile.leftovers.new_lead_from_web_form'.tr(), 'time': 'mobile.leftovers.6h_ago'.tr(), 'icon': Icons.person_add, 'color': Colors.indigo},
    {'title': 'mobile.leftovers.price_updated'.tr(), 'desc': 'Brooklyn Loft — \$2.1M', 'time': 'mobile.leftovers.8h_ago'.tr(), 'icon': Icons.price_change, 'color': Colors.amber},
  ];
}
