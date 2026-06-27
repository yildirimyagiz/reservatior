import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:go_router/go_router.dart';

class ListingManagementModal extends ConsumerWidget {
  const ListingManagementModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ListingManagementModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(color: colors.border),
      ),
      child: Stack(
        children: [
          // Subtle Background Glow
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ).animate().fadeIn(duration: 1200.ms),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppColors.primary, size: 24),
                    SizedBox(width: 12),
                    Text('mobile.auto.global_visibility_hub'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text('mobile.auto.register_your_property_and_manage_global_visibility_airbnb_booking_etc_from_a_single_mission_control'.tr(),
                  style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, height: 1.5),
                ),
              ),
              
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildOptionCard(
                      context,
                      icon: Icons.public_rounded,
                      title: 'mobile.auto.connect_existing_listings'.tr(),
                      desc: 'mobile.leftovers.import_from_airbnb_vrbo_or_booking_com_i'.tr(),
                      color: Colors.blue,
                      onTap: () {},
                    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
                    
                    SizedBox(height: 24),
                    
                    Text('mobile.auto.our_success_strategy'.tr(),
                      style: GoogleFonts.outfit(
                        color: colors.textSecondary.withOpacity(0.5),
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildServiceCard(
                            Icons.videocam_rounded,
                            'mobile.leftovers.ai_viral_video'.tr(),
                            'mobile.leftovers.tiktok_reels_content'.tr(),
                            Colors.purple,
                            () => context.push('/video-recording-studio'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildServiceCard(
                            Icons.description_rounded,
                            'mobile.leftovers.smart_brochure'.tr(),
                            'mobile.leftovers.seo_friendly_catalogs'.tr(),
                            Colors.blue,
                            () => _showSmartBrochureModal(context, colors),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildServiceCard(
                            Icons.verified_user_rounded,
                            'mobile.leftovers.legal_protection'.tr(),
                            'mobile.leftovers.tax_law_compliance'.tr(),
                            Colors.green,
                            () => _showLegalProtectionModal(context, colors),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildServiceCard(
                            Icons.trending_up_rounded,
                            'mobile.leftovers.price_optimization'.tr(),
                            'mobile.leftovers.ai_powered_yields'.tr(),
                            Colors.orange,
                            () => _showPriceOptimizationModal(context, colors),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 40),
                    
                    ElevatedButton(
                      onPressed: () => context.push('/video-recording-studio'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('mobile.auto.create_new_listing'.tr(),
                            style: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: 1),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.bolt_rounded, size: 20),
                        ],
                      ),
                    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
                    
                    SizedBox(height: 12),
                    Center(
                      child: Text('mobile.auto.list_your_property_in_just_5_minutes_backed_by_ai'.tr(),
                        style: TextStyle(color: colors.textSecondary.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Positioned(
            top: 12,
            right: 12,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded, color: Colors.white24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        desc,
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text('mobile.auto.start_managing_now'.tr(),
                            style: GoogleFonts.outfit(
                              color: color.withOpacity(0.8),
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward_rounded, color: color.withOpacity(0.8), size: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String desc, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color.withOpacity(0.8), size: 22),
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.outfit(color: AppColors.primaryLight, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(color: Colors.white30, fontSize: 9),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showSmartBrochureModal(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.description_rounded, color: Colors.blue, size: 24),
                  SizedBox(width: 12),
                  Text('mobile.auto.ai_smart_brochure_generator'.tr(),
                    style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text('mobile.auto.generate_an_seo_optimized_luxury_digital_catalog_brochure_for_your_property_automatically_formats_layout_with_floor_plans_and_highlights_neighborhood_scores'.tr(),
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('mobile.listing.pdf_compiled'.tr()),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('mobile.auto.generate_brochure'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLegalProtectionModal(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: Colors.green, size: 24),
                  SizedBox(width: 12),
                  Text('mobile.auto.ai_legal_compliance_scanner'.tr(),
                    style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text('mobile.auto.auto_scan_rental_and_sale_lease_agreements_against_international_tax_safety_and_local_municipality_laws_protects_you_against_administrative_liabilities'.tr(),
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('mobile.listing.compliance_passed'.tr()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('mobile.auto.run_compliance_scan'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPriceOptimizationModal(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.trending_up_rounded, color: Colors.orange, size: 24),
                  SizedBox(width: 12),
                  Text('mobile.auto.ai_dynamic_yield_optimizer'.tr(),
                    style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text('mobile.auto.optimize_pricing_configurations_across_portals_airbnb_booking_com_etc_using_live_hotel_indexes_local_booking_density_and_seasonal_appreciation_vectors'.tr(),
                style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('mobile.listing.yield_increased'.tr()),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text('mobile.auto.optimize_portfolio_yield'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
