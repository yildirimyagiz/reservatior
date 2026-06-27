import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CalendarTodayScreen extends ConsumerWidget {
  const CalendarTodayScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'mobile.calendar.today'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: _stat(
                  'mobile.calendar.meetings'.tr(),
                  '3',
                  Icons.groups_rounded,
                  Colors.blue,
                  colors,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _stat(
                  'mobile.calendar.viewings'.tr(),
                  '2',
                  Icons.visibility_rounded,
                  Colors.green,
                  colors,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _stat(
                  'mobile.calendar.tasks'.tr(),
                  '5',
                  Icons.check_circle_outline,
                  Colors.orange,
                  colors,
                ),
              ),
            ],
          ).animate().fadeIn(),
          SizedBox(height: 24),
          Text(
            'mobile.calendar.schedule'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._schedule.asMap().entries.map(
            (e) => _slot(e.value, colors, e.key),
          ),
        ],
      ),
    );
  }

  Widget _stat(String l, String v, IconData ic, Color c, ThemeAwareColors cl) =>
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cl.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cl.border),
        ),
        child: Column(
          children: [
            Icon(ic, color: c, size: 22),
            const SizedBox(height: 6),
            Text(
              v,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: cl.textPrimary,
              ),
            ),
            Text(l, style: TextStyle(color: cl.textSecondary, fontSize: 11)),
          ],
        ),
      );

  Widget _slot(Map<String, dynamic> s, ThemeAwareColors cl, int i) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 56,
          child: Text(
            s['time'] as String,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: cl.textSecondary,
            ),
          ),
        ),
        Container(
          width: 3,
          height: 60,
          decoration: BoxDecoration(
            color: s['color'] as Color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cl.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cl.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s['title'] as String,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    color: cl.textPrimary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s['desc'] as String,
                  style: TextStyle(color: cl.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).slideX(begin: 0.03);

  static final _schedule = [
    {
      'time': '09:00',
      'title': 'mobile.calendar.e1Title'.tr(),
      'desc': 'mobile.calendar.e1Desc'.tr(),
      'color': Colors.blue,
    },
    {
      'time': '10:30',
      'title': 'mobile.calendar.e2Title'.tr(),
      'desc': 'mobile.calendar.e2Desc'.tr(),
      'color': Colors.green,
    },
    {
      'time': '13:00',
      'title': 'mobile.calendar.e3Title'.tr(),
      'desc': 'mobile.calendar.e3Desc'.tr(),
      'color': Colors.orange,
    },
    {
      'time': '15:00',
      'title': 'mobile.calendar.e4Title'.tr(),
      'desc': 'mobile.calendar.e4Desc'.tr(),
      'color': Colors.purple,
    },
    {
      'time': '17:00',
      'title': 'mobile.calendar.e5Title'.tr(),
      'desc': 'mobile.calendar.e5Desc'.tr(),
      'color': Colors.teal,
    },
  ];
}
