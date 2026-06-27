import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/core/navigation/feature_helper.dart';

class HomeFeaturesGridWidget extends StatelessWidget {
  const HomeFeaturesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ecosystemModules = [
      {
        'icon': Icons.handshake_rounded,
        'title': 'mobile.auto.eco_dynamic_lease'.tr(),
        'desc': 'mobile.auto.eco_dynamic_lease_desc'.tr(),
        'color': const Color(0xFF10B981),
        'bg': const Color(0xFF064E3B),
        'route': 'checkout',
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'title': 'mobile.auto.eco_ai_neural'.tr(),
        'desc': 'mobile.auto.eco_ai_neural_desc'.tr(),
        'color': const Color(0xFF3B82F6),
        'bg': const Color(0xFF1E3A8A),
        'route': '/ai-studio',
      },
      {
        'icon': Icons.account_balance_wallet_rounded,
        'title': 'mobile.auto.eco_escrow_finance'.tr(),
        'desc': 'mobile.auto.eco_escrow_finance_desc'.tr(),
        'color': const Color(0xFFEC4899),
        'bg': const Color(0xFF831843),
        'route': '/escrow',
      },
      {
        'icon': Icons.public_rounded,
        'title': 'mobile.auto.eco_channel_dist'.tr(),
        'desc': 'mobile.auto.eco_channel_dist_desc'.tr(),
        'color': const Color(0xFFF59E0B),
        'bg': const Color(0xFF78350F),
        'route': '/channels',
      },
      {
        'icon': Icons.gavel_rounded,
        'title': 'mobile.auto.eco_legal_comp'.tr(),
        'desc': 'mobile.auto.eco_legal_comp_desc'.tr(),
        'color': const Color(0xFF8B5CF6),
        'bg': const Color(0xFF4C1D95),
        'route': '/legal',
      },
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text('mobile.auto.platform_ecosystem'.tr(),
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/features'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('mobile.auto.all_200_modules'.tr(),
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 190,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: ecosystemModules.length,
                itemBuilder: (context, index) {
                  final mod = ecosystemModules[index];
                  return GestureDetector(
                    onTap: () {
                      final title = mod['title'] as String;
                      final color = mod['color'] as Color;
                      final bg = mod['bg'] as Color;
                      
                      String category;
                      if (index == 0) {
                        category = 'Property';
                      } else if (index == 1) {
                        category = 'AI & ML';
                      } else if (index == 2) {
                        category = 'Financial';
                      } else if (index == 3) {
                        category = 'Property';
                      } else {
                        category = 'Legal';
                      }
                      
                      FeatureHelper.showCategoryBottomSheet(
                        context: context,
                        category: category,
                        title: title,
                        lightColor: color,
                        primaryColor: color,
                        darkBgColor: bg,
                      );
                    },
                    child: Container(
                      width: 280,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                        boxShadow: [
                          BoxShadow(
                            color: (mod['bg'] as Color).withOpacity(0.25),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: mod['bg'] as Color,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(mod['icon'] as IconData, color: mod['color'] as Color, size: 28),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            mod['title'] as String,
                            style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mod['desc'] as String,
                            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12, height: 1.4),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.1),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
