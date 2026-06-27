import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeroWidget extends StatelessWidget {
  const HomeHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2563EB).withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          image: DecorationImage(
            image: const NetworkImage('https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(const Color(0xFF0F172A).withOpacity(0.7), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.blur_on_rounded, color: Color(0xFF60A5FA), size: 14),
                  SizedBox(width: 6),
                  Text('mobile.auto.neural_hub_v1_0_4_active'.tr(),
                    style: GoogleFonts.outfit(color: const Color(0xFF60A5FA), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ],
              ),
            ).animate().fadeIn().slideX(begin: -0.2),
            const SizedBox(height: 24),
            Text(
              'mobile.leftovers.discover_future_ninvestments'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                height: 1.1,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            SizedBox(height: 16),
            Text('mobile.auto.ai_powered_insights_for_premium_real_estate'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 15,
                color: Colors.white70,
              ),
            ).animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
