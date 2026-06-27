import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SystemMonitoringScreen extends StatelessWidget {
  const SystemMonitoringScreen({super.key});

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
                'mobile.auto.system_monitoring'.tr(),
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
                  _serviceStatus(
                    'mobile.leftovers.database_cluster'.tr(),
                    'Operational',
                    Colors.greenAccent,
                  ),
                  _serviceStatus(
                    'mobile.leftovers.redis_cache'.tr(),
                    'Operational',
                    Colors.greenAccent,
                  ),
                  _serviceStatus(
                    'mobile.leftovers.storage_bucket'.tr(),
                    'Degraded',
                    Colors.orangeAccent,
                  ),
                  _serviceStatus(
                    'mobile.leftovers.email_service'.tr(),
                    'Operational',
                    Colors.greenAccent,
                  ),
                  _serviceStatus(
                    'mobile.leftovers.payment_gateway'.tr(),
                    'Operational',
                    Colors.greenAccent,
                  ),
                  _serviceStatus(
                    'mobile.leftovers.ai_engine'.tr(),
                    'Operational',
                    Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceStatus(String service, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.circle, color: color, size: 8),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: GoogleFonts.outfit(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}
