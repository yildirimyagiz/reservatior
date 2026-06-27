import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/features/client/presentation/widgets/hero_section_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/quick_search_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/services_grid_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/stats_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/video_feed_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/features_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/cta_section_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/tech_highlight_widget.dart';

class ClientHomeScreen extends ConsumerWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.darkBg.withOpacity(0.95),
            elevation: 0,
            toolbarHeight: 70,
            title: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 12, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Icon(Icons.home_work_rounded, color: Colors.white, size: 22),
                ).animate().scale(delay: 100.ms, duration: 500.ms, curve: Curves.elasticOut),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('mobile.auto.reservatior'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'mobile.home.tagline'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
              ],
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Icon(Icons.search_rounded, color: Colors.white, size: 20),
                ),
                onPressed: () => context.push('/search'),
              ).animate().fadeIn(delay: 250.ms),
              IconButton(
                icon: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 20),
                    ),
                    Positioned(
                      right: 4, top: 4,
                      child: Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle, border: Border.all(color: AppColors.darkBg, width: 1.5)),
                      ),
                    ),
                  ],
                ),
                onPressed: () => context.push('/notifications'),
              ).animate().fadeIn(delay: 300.ms),
              SizedBox(width: 8),
            ],
          ),

          // Hero Section
          const SliverToBoxAdapter(child: HeroSectionWidget()),

          // Quick Search
          const SliverToBoxAdapter(child: QuickSearchWidget()),

          // Mode Selector (Stays / Rent / Buy)
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  _buildModeTab('mobile.home.stays'.tr(), true),
                  _buildModeTab('mobile.home.rent'.tr(), false),
                  _buildModeTab('mobile.home.buy'.tr(), false),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
          ),

          // Services Grid
          const SliverToBoxAdapter(child: ServicesGridWidget()),

          // Stats Banner
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.12), AppColors.primary.withOpacity(0.04)],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('50,000+', 'mobile.home.managedProperties'.tr()),
                  Container(width: 1, height: 36, color: AppColors.primary.withOpacity(0.2)),
                  _buildStatItem('12,000+', 'mobile.home.activeUsers'.tr()),
                  Container(width: 1, height: 36, color: AppColors.primary.withOpacity(0.2)),
                  _buildStatItem('98%', 'mobile.home.satisfaction'.tr()),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
          ),

          // Video Feed
          const SliverToBoxAdapter(child: VideoFeedWidget()),

          // Features
          const SliverToBoxAdapter(child: FeaturesWidget()),

          // Tech Highlight
          const SliverToBoxAdapter(child: TechHighlightWidget()),

          // CTA Section
          const SliverToBoxAdapter(child: CTASectionWidget()),

          // Premium Footer
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.home_work_rounded, color: Colors.white, size: 16),
                      ),
                      SizedBox(width: 10),
                      Text('mobile.auto.reservatior'.tr(), style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'mobile.home.footerDesc'.tr(),
                    style: GoogleFonts.outfit(fontSize: 12, color: Colors.white30, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.language_rounded),
                      SizedBox(width: 16),
                      _buildSocialIcon(Icons.alternate_email_rounded),
                      SizedBox(width: 16),
                      _buildSocialIcon(Icons.camera_alt_rounded),
                      SizedBox(width: 16),
                      _buildSocialIcon(Icons.play_arrow_rounded),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '© 2024 Reservatior. ${'mobile.home.allRights'.tr()}',
                    style: GoogleFonts.outfit(fontSize: 10, color: Colors.white.withOpacity(0.15), letterSpacing: 1),
                  ),
                  SizedBox(height: 80), // Space for navbar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(String label, bool isActive) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isActive ? Colors.white : Colors.white38,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
        SizedBox(height: 4),
        Text(label, style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white38, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Icon(icon, color: Colors.white30, size: 18),
    );
  }
}
