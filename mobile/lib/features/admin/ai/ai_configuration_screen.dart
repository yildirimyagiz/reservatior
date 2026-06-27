import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class AiConfigurationScreen extends StatelessWidget {
  const AiConfigurationScreen({super.key});
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
                'mobile.auto.ai_configuration'.tr(),
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
                    'mobile.leftovers.yield_optimization'.tr(),
                    'Active',
                    Icons.auto_awesome,
                    Colors.orangeAccent,
                  ),
                  _tile(
                    'mobile.leftovers.tenant_screening_ai'.tr(),
                    'Active',
                    Icons.person_search,
                    Colors.blueAccent,
                  ),
                  _tile(
                    'mobile.leftovers.fraud_detection'.tr(),
                    'Active',
                    Icons.security,
                    Colors.redAccent,
                  ),
                  _tile(
                    'mobile.leftovers.smart_pricing_engine'.tr(),
                    'Active',
                    Icons.trending_up,
                    Colors.greenAccent,
                  ),
                  _tile(
                    'mobile.leftovers.sentiment_analysis'.tr(),
                    'Paused',
                    Icons.psychology,
                    Colors.purpleAccent,
                  ),
                  _tile(
                    'mobile.leftovers.predictive_maintenance'.tr(),
                    'Active',
                    Icons.build_circle,
                    Colors.cyanAccent,
                  ),
                  _tile(
                    'mobile.leftovers.image_analysis'.tr(),
                    'Active',
                    Icons.image_search,
                    Colors.amber,
                  ),
                  _tile(
                    'mobile.leftovers.contract_ai_gemini'.tr(),
                    'Active',
                    Icons.description,
                    Colors.tealAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(String t, String v, IconData i, Color c) => Container(
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
            color: c.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(i, color: c, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            t,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: v == 'Active'
                ? Colors.greenAccent.withOpacity(0.15)
                : Colors.orangeAccent.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            v,
            style: GoogleFonts.outfit(
              color: v == 'Active' ? Colors.greenAccent : Colors.orangeAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ).animate().fadeIn().slideX(begin: 0.05, end: 0);
}
