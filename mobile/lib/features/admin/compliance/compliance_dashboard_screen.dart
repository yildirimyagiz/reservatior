import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class ComplianceDashboardScreen extends StatelessWidget {
  const ComplianceDashboardScreen({super.key});
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
                'mobile.auto.compliance'.tr(),
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
                    'mobile.leftovers.gdpr_compliance'.tr(),
                    '98%',
                    Icons.privacy_tip,
                    Colors.greenAccent,
                  ),
                  _tile(
                    'mobile.leftovers.kyc_verification'.tr(),
                    '85%',
                    Icons.verified_user,
                    Colors.blueAccent,
                  ),
                  _tile(
                    'mobile.leftovers.aml_screening'.tr(),
                    '100%',
                    Icons.gpp_good,
                    Colors.cyanAccent,
                  ),
                  _tile(
                    'mobile.leftovers.data_retention_policy'.tr(),
                    'Active',
                    Icons.storage,
                    Colors.purpleAccent,
                  ),
                  _tile(
                    'mobile.leftovers.regulatory_reporting'.tr(),
                    'mobile.leftovers.up_to_date'.tr(),
                    Icons.assessment,
                    Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(String title, String value, IconData icon, Color color) =>
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
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
            Text(
              value,
              style: GoogleFonts.outfit(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ).animate().fadeIn().slideX(begin: 0.05, end: 0);
}
