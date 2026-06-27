import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class ListingDopingScreen extends ConsumerWidget {
  const ListingDopingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.promote_listing'.tr(),
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
              gradient: LinearGradient(
                colors: [Colors.amber.shade700, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.rocket_launch_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Text('mobile.auto.boost_visibility'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('mobile.auto.promote_your_listings_to_reach_10x_more_potential_buyers_and_tenants'.tr(),
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1),
          SizedBox(height: 24),
          Text('mobile.auto.promotion_packages'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._packages.asMap().entries.map(
            (e) => _packageCard(e.value, colors, e.key),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.active_promotions'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._activePromos.asMap().entries.map(
            (e) => _promoCard(e.value, colors, e.key),
          ),
        ],
      ),
    );
  }

  Widget _packageCard(Map<String, dynamic> p, ThemeAwareColors c, int i) =>
      Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: c.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: c.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (p['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    p['icon'] as IconData,
                    color: p['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['name'] as String,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: c.textPrimary,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        p['desc'] as String,
                        style: TextStyle(color: c.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      p['price'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      p['duration'] as String,
                      style: TextStyle(color: c.textSecondary, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          )
          .animate()
          .fadeIn(delay: Duration(milliseconds: 60 * i))
          .slideX(begin: 0.03);

  Widget _promoCard(
    Map<String, dynamic> p,
    ThemeAwareColors c,
    int i,
  ) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: c.card,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: c.border),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p['property'] as String,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  color: c.textPrimary,
                  fontSize: 14,
                ),
              ),
              Text(
                '${p['views']} views • ${p['leads']} leads',
                style: TextStyle(color: c.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '${p['daysLeft']}d left',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).slideX(begin: 0.03);

  static final _packages = [
    {
      'name': 'Spotlight',
      'desc': 'mobile.leftovers.featured_badge_top_placement'.tr(),
      'price': '\$49',
      'duration': 'mobile.leftovers.7_days'.tr(),
      'icon': Icons.star_rounded,
      'color': Colors.amber,
    },
    {
      'name': 'mobile.leftovers.premium_boost'.tr(),
      'desc': 'mobile.leftovers.homepage_banner_social_ads'.tr(),
      'price': '\$99',
      'duration': 'mobile.leftovers.14_days'.tr(),
      'icon': Icons.trending_up_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'mobile.leftovers.neural_campaign'.tr(),
      'desc': 'mobile.leftovers.ai_optimized_multi_channel_ads'.tr(),
      'price': '\$199',
      'duration': 'mobile.leftovers.30_days'.tr(),
      'icon': Icons.auto_awesome,
      'color': Colors.purple,
    },
  ];
  static final _activePromos = [
    {
      'property': 'mobile.leftovers.manhattan_penthouse'.tr(),
      'views': '4,521',
      'leads': '23',
      'daysLeft': 5,
    },
    {
      'property': 'mobile.leftovers.brooklyn_townhouse'.tr(),
      'views': '2,180',
      'leads': '11',
      'daysLeft': 12,
    },
  ];
}
