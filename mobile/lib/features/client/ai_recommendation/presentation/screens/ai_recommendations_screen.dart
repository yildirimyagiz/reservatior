import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class AiRecommendationsScreen extends ConsumerWidget {
  const AiRecommendationsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'mobile.ai.studio.title'.tr(),
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.white, size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'mobile.ai.studio.smart'.tr(),
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'mobile.ai.studio.smartDesc'.tr(),
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 20),
          ..._recommendations.asMap().entries.map(
            (e) => _card(e.value, colors, e.key),
          ),
        ],
      ),
    );
  }

  Widget _card(Map<String, dynamic> r, ThemeAwareColors c, int i) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: c.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: c.border),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (r['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                r['icon'] as IconData,
                color: r['color'] as Color,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r['title'] as String,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: c.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    r['category'] as String,
                    style: TextStyle(color: c.textSecondary, fontSize: 11),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: (r['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${r['confidence']}%',
                style: TextStyle(
                  color: r['color'] as Color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          r['desc'] as String,
          style: TextStyle(color: c.textSecondary, fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: c.textSecondary,
                  side: BorderSide(color: c.border),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: Text('mobile.ai.studio.dismiss'.tr()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 0,
                ),
                child: Text('mobile.ai.studio.apply'.tr()),
              ),
            ),
          ],
        ),
      ],
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 80 * i)).slideY(begin: 0.05);

  static final _recommendations = [
    {
      'title': 'mobile.ai.studio.r1.title'.tr(),
      'category': 'mobile.ai.studio.r1.cat'.tr(),
      'desc': 'mobile.ai.studio.r1.desc'.tr(),
      'confidence': 92,
      'icon': Icons.price_change_rounded,
      'color': Colors.green,
    },
    {
      'title': 'mobile.ai.studio.r2.title'.tr(),
      'category': 'mobile.ai.studio.r2.cat'.tr(),
      'desc': 'mobile.ai.studio.r2.desc'.tr(),
      'confidence': 87,
      'icon': Icons.phone_callback_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'mobile.ai.studio.r3.title'.tr(),
      'category': 'mobile.ai.studio.r3.cat'.tr(),
      'desc': 'mobile.ai.studio.r3.desc'.tr(),
      'confidence': 78,
      'icon': Icons.camera_enhance_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'mobile.ai.studio.r4.title'.tr(),
      'category': 'mobile.ai.studio.r4.cat'.tr(),
      'desc': 'mobile.ai.studio.r4.desc'.tr(),
      'confidence': 84,
      'icon': Icons.campaign_rounded,
      'color': Colors.purple,
    },
  ];
}
