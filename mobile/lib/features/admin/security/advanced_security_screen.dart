import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class AdvancedSecurityScreen extends StatelessWidget {
  const AdvancedSecurityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withOpacity(0.8),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
              title: Text(
                'mobile.auto.advanced_security'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _tile(
                    'mobile.leftovers.two_factor_authentication'.tr(),
                    Icons.security,
                    Colors.greenAccent,
                    true,
                  ),
                  _tile(
                    'mobile.leftovers.ip_whitelisting'.tr(),
                    Icons.dns,
                    Colors.blueAccent,
                    false,
                  ),
                  _tile(
                    'mobile.leftovers.session_timeout_min'.tr(),
                    Icons.timer,
                    Colors.orangeAccent,
                    true,
                  ),
                  _tile(
                    'mobile.leftovers.brute_force_protection'.tr(),
                    Icons.shield,
                    Colors.redAccent,
                    true,
                  ),
                  _tile(
                    'mobile.leftovers.data_encryption_at_rest'.tr(),
                    Icons.lock,
                    Colors.purpleAccent,
                    true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(String title, IconData icon, Color color, bool enabled) =>
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Switch(value: enabled, onChanged: (_) {}, activeColor: color),
          ],
        ),
      ).animate().fadeIn().slideX(begin: 0.05, end: 0);
}
