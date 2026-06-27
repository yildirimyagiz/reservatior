import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class OrganizationScreen extends ConsumerWidget {
  const OrganizationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.organization'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Text('mobile.auto.r'.tr(),
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Text('mobile.auto.reservatior_inc'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text('mobile.auto.premium_organization'.tr(),
                  style: TextStyle(color: colors.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _stat('Members', '24', colors),
                    Container(width: 1, height: 36, color: colors.border),
                    _stat('Properties', '156', colors),
                    Container(width: 1, height: 36, color: colors.border),
                    _stat('Revenue', '\$4.2M', colors),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1),
          SizedBox(height: 24),
          Text('mobile.auto.team_members'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._members.asMap().entries.map(
            (e) => _memberTile(e.value, colors, e.key),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.departments'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _departments
                .map(
                  (d) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: colors.card,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          d['icon'] as IconData,
                          color: d['color'] as Color,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          d['name'] as String,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
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

  Widget _memberTile(Map<String, dynamic> m, ThemeAwareColors c, int i) =>
      Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: c.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: c.border),
            ),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: (m['color'] as Color).withOpacity(0.15),
                child: Text(
                  (m['name'] as String)[0],
                  style: TextStyle(
                    color: m['color'] as Color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              title: Text(
                m['name'] as String,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                m['role'] as String,
                style: TextStyle(color: c.textSecondary, fontSize: 12),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('mobile.auto.active'.tr(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
          .animate()
          .fadeIn(delay: Duration(milliseconds: 60 * i))
          .slideX(begin: 0.03);

  static final _members = [
    {'name': 'mobile.leftovers.alex_morgan'.tr(), 'role': 'mobile.leftovers.ceo_founder'.tr(), 'color': Colors.blue},
    {'name': 'mobile.leftovers.sarah_chen'.tr(), 'role': 'CTO', 'color': Colors.purple},
    {'name': 'mobile.leftovers.james_wilson'.tr(), 'role': 'mobile.leftovers.head_of_sales'.tr(), 'color': Colors.green},
    {'name': 'mobile.leftovers.emily_davis'.tr(), 'role': 'mobile.leftovers.lead_agent'.tr(), 'color': Colors.orange},
  ];
  static final _departments = [
    {'name': 'Sales', 'icon': Icons.trending_up_rounded, 'color': Colors.green},
    {'name': 'Marketing', 'icon': Icons.campaign_rounded, 'color': Colors.blue},
    {'name': 'Engineering', 'icon': Icons.code_rounded, 'color': Colors.purple},
    {
      'name': 'Support',
      'icon': Icons.headset_mic_rounded,
      'color': Colors.orange,
    },
    {
      'name': 'Finance',
      'icon': Icons.account_balance_rounded,
      'color': Colors.teal,
    },
  ];
}
