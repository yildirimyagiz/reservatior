import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.darkBg.withOpacity(0.95),
            elevation: 0,
            toolbarHeight: 80,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mobile.contact.support'.tr(),
                  style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary, letterSpacing: 2),
                ),
                Text(
                  'mobile.contact.title'.tr(),
                  style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ).animate().fadeIn(delay: 100.ms),
          ),

          // Contact methods
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 8),
                // AI Concierge card
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.primary.withOpacity(0.2), AppColors.primary.withOpacity(0.05)]),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 60, height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 30),
                      ),
                      SizedBox(height: 16),
                      Text('mobile.contact.aiConcierge'.tr(), style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                      SizedBox(height: 8),
                      Text('mobile.contact.aiConciergeDesc'.tr(), textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white38, height: 1.4)),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.chat_rounded, size: 18),
                          label: Text('mobile.contact.startChat'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

                SizedBox(height: 20),

                // Contact methods grid
                _buildContactCard(Icons.email_outlined, 'mobile.leftovers.e_posta'.tr(), 'info@reservatior.com', colors, 0),
                _buildContactCard(Icons.phone_outlined, 'mobile.contact.phone'.tr(), 'mobile.leftovers._90_212_555_0000'.tr(), colors, 1),
                _buildContactCard(Icons.location_on_outlined, 'mobile.contact.office'.tr(), 'mobile.leftovers.levent_i_stanbul'.tr(), colors, 2),
                _buildContactCard(Icons.schedule_outlined, 'mobile.contact.hours'.tr(), 'mobile.leftovers.09_00_18_00_gmt_3'.tr(), colors, 3),

                SizedBox(height: 24),

                // Contact Form
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.darkCard,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 3, height: 14, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                          SizedBox(width: 10),
                          Text('mobile.contact.sendMessage'.tr(), style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white38, letterSpacing: 1.5)),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildField('mobile.contact.nameField'.tr()),
                      SizedBox(height: 12),
                      _buildField('mobile.contact.emailField'.tr()),
                      SizedBox(height: 12),
                      _buildField('mobile.contact.subjectField'.tr()),
                      SizedBox(height: 12),
                      _buildField('mobile.contact.messageField'.tr(), maxLines: 4),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.send_rounded, size: 16),
                          label: Text('mobile.contact.send'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.w700, letterSpacing: 1)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 500.ms),

                SizedBox(height: 120),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String value, ThemeAwareColors colors, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.08), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white38, letterSpacing: 1)),
                SizedBox(height: 2),
                Text(value, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
              ],
            ),
          ),
          Icon(Icons.open_in_new_rounded, size: 16, color: Colors.white24),
        ],
      ),
    ).animate().fadeIn(delay: (300 + index * 80).ms).slideX(begin: 0.05);
  }

  Widget _buildField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withOpacity(0.05))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withOpacity(0.05))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5))),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
