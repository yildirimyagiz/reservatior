import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Header
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.darkBg,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.darkBg,
                        ],
                      ),
                    ),
                  ),
                  // Neural glow
                  Positioned(
                    top: -80,
                    right: -60,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.08),
                      ),
                    ),
                  ),
                  // Profile content
                  Positioned(
                    bottom: 30,
                    left: 24,
                    right: 24,
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 3),
                            boxShadow: [
                              BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, spreadRadius: 2),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.darkCard,
                            child: Text(
                              user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                              style: GoogleFonts.outfit(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ).animate().scale(delay: 200.ms, duration: 600.ms, curve: Curves.elasticOut),
                        SizedBox(height: 16),
                        Text(
                          user?.name ?? 'mobile.profile.guestUser'.tr(),
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ).animate().fadeIn(delay: 300.ms),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                          ),
                          child: Text(
                            (user?.role ?? 'mobile.profile.tenant'.tr()).toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                              letterSpacing: 2,
                            ),
                          ),
                        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stats Bar
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('12', 'mobile.profile.properties'.tr()),
                  Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                  _buildStat('48', 'mobile.profile.bookings'.tr()),
                  Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                  _buildStat('4.9', 'mobile.profile.rating'.tr()),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
          ),

          // Menu Sections
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  _buildSectionTitle('mobile.profile.account'.tr()),
                  _buildMenuItem(Icons.person_outline_rounded, 'mobile.profile.editProfile'.tr(), 'mobile.profile.editProfileDesc'.tr(), colors),
                  _buildMenuItem(Icons.lock_outline_rounded, 'mobile.profile.security'.tr(), 'mobile.profile.securityDesc'.tr(), colors),
                  _buildMenuItem(Icons.credit_card_rounded, 'mobile.profile.billing'.tr(), 'mobile.profile.billingDesc'.tr(), colors),

                  SizedBox(height: 24),
                  _buildSectionTitle('mobile.profile.preferences'.tr()),
                  _buildMenuItem(Icons.notifications_none_rounded, 'mobile.profile.notifications'.tr(), 'mobile.profile.notificationsDesc'.tr(), colors),
                  _buildMenuItem(Icons.language_rounded, 'mobile.profile.language'.tr(), 'mobile.profile.languageDesc'.tr(), colors),
                  _buildMenuItem(Icons.palette_outlined, 'mobile.profile.theme'.tr(), 'mobile.profile.themeDesc'.tr(), colors),

                  SizedBox(height: 24),
                  _buildSectionTitle('mobile.profile.more'.tr()),
                  _buildMenuItem(Icons.help_outline_rounded, 'mobile.profile.helpCenter'.tr(), 'mobile.profile.helpCenterDesc'.tr(), colors),
                  _buildMenuItem(Icons.info_outline_rounded, 'mobile.profile.about'.tr(), 'mobile.profile.aboutDesc'.tr(), colors),

                  SizedBox(height: 24),
                  // Logout button
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 120),
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                            backgroundColor: AppColors.darkCard,
                            title: Text(
                              'mobile.profile.logout'.tr(),
                              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            content: Text('mobile.auto.are_you_sure_you_want_to_end_your_session'.tr(),
                              style: GoogleFonts.outfit(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(c, false),
                                child: Text('mobile.auto.cancel'.tr(),
                                  style: GoogleFonts.outfit(color: Colors.white30),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(c, true),
                                child: Text(
                                  'mobile.profile.logout'.tr(),
                                  style: GoogleFonts.outfit(color: Colors.redAccent, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await ref.read(authProvider.notifier).logout();
                          context.go('/auth/login');
                        }
                      },
                      icon: Icon(Icons.logout_rounded, color: Colors.redAccent, size: 18),
                      label: Text(
                        'mobile.profile.logout'.tr(),
                        style: GoogleFonts.outfit(color: Colors.redAccent, fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.redAccent.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
        SizedBox(height: 4),
        Text(label, style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white38, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 3, height: 14, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
          SizedBox(width: 10),
          Text(title, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white38, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, ThemeAwareColors colors) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
        subtitle: Text(subtitle, style: GoogleFonts.outfit(fontSize: 11, color: Colors.white38)),
        trailing: Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
      ),
    );
  }
}
