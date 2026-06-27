import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class AgentProfileScreen extends ConsumerWidget {
  const AgentProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: colors.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.indigo, colors.background],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text('mobile.auto.jw'.tr(),
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text('mobile.auto.james_wilson'.tr(),
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text('mobile.auto.senior_property_agent'.tr(),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: i < 4 ? Colors.amber : Colors.white30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _stat('Deals', '47', colors),
                        Container(width: 1, height: 36, color: colors.border),
                        _stat('Revenue', '\$8.2M', colors),
                        Container(width: 1, height: 36, color: colors.border),
                        _stat('Rating', '4.8', colors),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1),
                  SizedBox(height: 24),
                  _section('Specializations', [
                    _chip('mobile.leftovers.luxury_residential'.tr(), Colors.blue, colors),
                    _chip('Commercial', Colors.green, colors),
                    _chip('Investment', Colors.purple, colors),
                    _chip('Waterfront', Colors.teal, colors),
                  ], colors),
                  SizedBox(height: 24),
                  _section('mobile.leftovers.recent_transactions'.tr(), [
                    _txRow(
                      'mobile.leftovers.manhattan_penthouse'.tr(),
                      '\$8.5M',
                      'Sold',
                      Colors.green,
                      colors,
                    ),
                    _txRow(
                      'mobile.leftovers.brooklyn_loft'.tr(),
                      '\$2.1M',
                      'Sold',
                      Colors.green,
                      colors,
                    ),
                    _txRow(
                      'mobile.leftovers.queens_family_home'.tr(),
                      '\$1.8M',
                      'Active',
                      Colors.blue,
                      colors,
                    ),
                  ], colors),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.chat_rounded, size: 18),
                          label: Text('mobile.auto.message'.tr()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.phone_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          label: Text('mobile.auto.call'.tr(),
                            style: TextStyle(color: AppColors.primary),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String l, String v, ThemeAwareColors c) => Column(
    children: [
      Text(
        v,
        style: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: c.textPrimary,
        ),
      ),
      Text(l, style: TextStyle(color: c.textSecondary, fontSize: 11)),
    ],
  );

  Widget _section(String title, List<Widget> children, ThemeAwareColors c) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: c.textPrimary,
            ),
          ),
          SizedBox(height: 12),
          ...children,
        ],
      );

  Widget _chip(String label, Color color, ThemeAwareColors c) => Container(
    margin: EdgeInsets.only(bottom: 8),
    child: Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _txRow(
    String prop,
    String price,
    String status,
    Color col,
    ThemeAwareColors c,
  ) => Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: c.card,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: c.border),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            prop,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          price,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: col.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: col,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
