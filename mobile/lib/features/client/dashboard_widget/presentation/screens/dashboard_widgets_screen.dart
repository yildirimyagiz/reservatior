import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class DashboardWidgetsScreen extends ConsumerWidget {
  const DashboardWidgetsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.widgets'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('mobile.auto.active_widgets'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.textSecondary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          ..._activeWidgets.asMap().entries.map(
            (e) => _widgetCard(e.value, colors, e.key, true),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.available_widgets'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.textSecondary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          ..._availableWidgets.asMap().entries.map(
            (e) => _widgetCard(e.value, colors, e.key, false),
          ),
        ],
      ),
    );
  }

  Widget _widgetCard(
    Map<String, dynamic> w,
    ThemeAwareColors c,
    int i,
    bool active,
  ) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: c.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: c.border),
    ),
    child: Row(
      children: [
        if (active)
          Icon(Icons.drag_indicator_rounded, color: c.textSecondary, size: 20),
        if (active) const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (w['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            w['icon'] as IconData,
            color: w['color'] as Color,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                w['title'] as String,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                  fontSize: 14,
                ),
              ),
              Text(
                w['desc'] as String,
                style: TextStyle(color: c.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: active,
          onChanged: (_) {},
          activeColor: AppColors.primary,
        ),
      ],
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).slideX(begin: 0.03);

  static final _activeWidgets = [
    {
      'title': 'mobile.leftovers.revenue_chart'.tr(),
      'desc': 'mobile.leftovers.monthly_income_overview'.tr(),
      'icon': Icons.show_chart_rounded,
      'color': Colors.green,
    },
    {
      'title': 'mobile.leftovers.recent_leads'.tr(),
      'desc': 'mobile.leftovers.latest_lead_activity'.tr(),
      'icon': Icons.person_add_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'mobile.leftovers.occupancy_rate'.tr(),
      'desc': 'mobile.leftovers.property_fill_percentage'.tr(),
      'icon': Icons.pie_chart_rounded,
      'color': Colors.orange,
    },
  ];
  static final _availableWidgets = [
    {
      'title': 'mobile.leftovers.task_progress'.tr(),
      'desc': 'mobile.leftovers.team_task_completion'.tr(),
      'icon': Icons.check_circle_rounded,
      'color': Colors.purple,
    },
    {
      'title': 'mobile.leftovers.maintenance_queue'.tr(),
      'desc': 'mobile.leftovers.pending_work_orders'.tr(),
      'icon': Icons.build_rounded,
      'color': Colors.red,
    },
    {
      'title': 'mobile.leftovers.calendar_preview'.tr(),
      'desc': 'mobile.leftovers.upcoming_appointments'.tr(),
      'icon': Icons.calendar_today_rounded,
      'color': Colors.teal,
    },
    {
      'title': 'mobile.leftovers.ai_insights'.tr(),
      'desc': 'mobile.leftovers.market_predictions'.tr(),
      'icon': Icons.auto_awesome,
      'color': AppColors.primary,
    },
  ];
}
