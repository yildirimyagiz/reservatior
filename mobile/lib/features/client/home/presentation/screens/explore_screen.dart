import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/utils/formatters.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    
    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(colors),
          SliverToBoxAdapter(child: _buildHeroSection(colors)),
          SliverToBoxAdapter(child: _buildStatsSection(colors)),
          SliverToBoxAdapter(child: _buildFeaturesSection(colors)),
          SliverToBoxAdapter(child: _buildTrustSection(colors)),
          SliverToBoxAdapter(child: _buildCTASection(colors)),
          const SliverToBoxAdapter(child: SizedBox(height: 120)), // Bottom padding for navbar
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemeAwareColors colors) {
    return SliverAppBar(
      floating: true,
      backgroundColor: colors.background.withOpacity(0.9),
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
          SizedBox(width: 8),
          Text('mobile.auto.reservatior'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (c) => c.repeat()).fade(duration: 1.seconds),
                SizedBox(width: 8),
                Text(
                  'mobile.explore.aiPowered'.tr(),
                  style: GoogleFonts.outfit(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
          SizedBox(height: 24),
          Text(
            'mobile.explore.heroTitle1'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: colors.textPrimary,
              height: 1.1,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
          Text(
            'mobile.explore.heroTitle2'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              height: 1.1,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
          SizedBox(height: 16),
          Text(
            'mobile.explore.heroDesc'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: colors.textSecondary,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push('/reels'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'mobile.explore.viewListings'.tr(),
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colors.border),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: IconButton(
                  onPressed: () => context.push('/reels'),
                  icon: const Icon(Icons.play_arrow_rounded),
                  color: colors.textPrimary,
                  iconSize: 32,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2),
          const SizedBox(height: 48),
          
          // Floating Card Image
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: const DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('mobile.explore.sample_title'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white70, size: 12),
                              SizedBox(width: 4),
                              Text('mobile.explore.sample_location'.tr(), style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Text(AppFormatters.formatPrice(context, 28500000), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildStatsSection(ThemeAwareColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem('50K+', 'mobile.explore.stats.managedProps'.tr(), Icons.business_rounded, colors),
          _buildStatItem('99.9%', 'mobile.explore.stats.uptime'.tr(), Icons.speed_rounded, colors),
          _buildStatItem('150+', 'mobile.explore.stats.countries'.tr(), Icons.public_rounded, colors),
        ],
      ),
    ).animate().fadeIn(delay: 1200.ms);
  }

  Widget _buildStatItem(String value, String label, IconData icon, ThemeAwareColors colors) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary.withOpacity(0.7), size: 28),
        const SizedBox(height: 8),
        Text(value, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w900, color: colors.textPrimary)),
        Text(label, style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, color: colors.textSecondary, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildFeaturesSection(ThemeAwareColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('mobile.explore.features.title'.tr(), style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: colors.textPrimary)),
          SizedBox(height: 16),
          _buildFeatureCard(
            'mobile.explore.features.valuationTitle'.tr(),
            'mobile.explore.features.valuationDesc'.tr(),
            Icons.smart_toy_rounded,
            Colors.blue,
            colors,
          ),
          SizedBox(height: 12),
          _buildFeatureCard(
            'mobile.explore.features.videoTitle'.tr(),
            'mobile.explore.features.videoDesc'.tr(),
            Icons.movie_creation_rounded,
            Colors.purple,
            colors,
          ),
          SizedBox(height: 12),
          _buildFeatureCard(
            'mobile.explore.features.blockchainTitle'.tr(),
            'mobile.explore.features.blockchainDesc'.tr(),
            Icons.security_rounded,
            Colors.orange,
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String desc, IconData icon, Color iconColor, ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16, color: colors.textPrimary)),
                const SizedBox(height: 4),
                Text(desc, style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrustSection(ThemeAwareColors colors) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.shield_rounded, color: Colors.blueAccent, size: 48),
          SizedBox(height: 16),
          Text(
            'mobile.explore.security.title'.tr(),
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'mobile.explore.security.desc'.tr(),
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTrustBadge('mobile.leftovers.aes_256'.tr()),
              const SizedBox(width: 8),
              _buildTrustBadge('mobile.leftovers.iso_27001'.tr()),
              const SizedBox(width: 8),
              _buildTrustBadge('mobile.leftovers.soc_2_type_ii'.tr()),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTrustBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(text, style: GoogleFonts.outfit(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
    );
  }

  Widget _buildCTASection(ThemeAwareColors colors) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'mobile.explore.cta.title'.tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, color: colors.textPrimary),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push('/pricing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Text(
                'mobile.explore.cta.button'.tr(),
                style: GoogleFonts.outfit(color: colors.background, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
