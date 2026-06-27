import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeNeuralHubWidget extends StatelessWidget {
  const HomeNeuralHubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.stacked_line_chart_rounded, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text('mobile.auto.market_intelligence'.tr(),
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      ).animate(onPlay: (controller) => controller.repeat()).fade(duration: 800.ms),
                      SizedBox(width: 6),
                      Text('mobile.auto.live'.tr(), style: GoogleFonts.outfit(color: Colors.green, fontSize: 10, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '+14.2%',
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, height: 1),
                ),
                SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('mobile.auto.yield_momentum'.tr(),
                    style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('mobile.auto.analyzing_1_2m_market_variants_in_your_targeted_areas_across_anatolia_bosphorus_high_probability_of_upcoming_surge_in_waterfront_properties'.tr(),
              style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.8), fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
    );
  }
}
