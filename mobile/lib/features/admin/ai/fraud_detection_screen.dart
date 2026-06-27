import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class FraudDetectionScreen extends StatelessWidget {
  const FraudDetectionScreen({super.key});
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
                'mobile.auto.fraud_detection'.tr(),
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
              child: Row(
                children: [
                  Expanded(
                    child: _kpi(
                      'mobile.leftovers.threats_blocked'.tr(),
                      '0',
                      Icons.block,
                      Colors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _kpi(
                      'mobile.leftovers.risk_score'.tr(),
                      '0%',
                      Icons.warning,
                      Colors.orangeAccent,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _kpi(
                      'Safe',
                      '100%',
                      Icons.check_circle,
                      Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text(
                'mobile.auto.no_fraud_alerts'.tr(),
                style: GoogleFonts.outfit(color: Colors.white30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kpi(String l, String v, IconData i, Color c) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.darkSurface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: c.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(i, color: c.withOpacity(0.6), size: 20),
        const SizedBox(height: 8),
        Text(
          v,
          style: GoogleFonts.outfit(
            color: c,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        Text(
          l,
          style: GoogleFonts.outfit(
            color: Colors.white30,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ).animate().fadeIn();
}
