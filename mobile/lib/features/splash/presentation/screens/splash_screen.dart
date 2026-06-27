import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Neural Glow effect behind the logo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.15),
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                 .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 2.seconds)
                 .fade(begin: 0.8, end: 0.1, duration: 2.seconds),
                
                // App Logo Placeholder (using Icon for now)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.real_estate_agent_rounded,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ).animate()
                 .scale(curve: Curves.easeOutBack, duration: 800.ms)
                 .shimmer(delay: 800.ms, duration: 1.5.seconds, color: Colors.white54),
              ],
            ),
            
            SizedBox(height: 32),
            
            // Brand Text
            Text(
              'mobile.welcome.brand'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ).animate()
             .fadeIn(delay: 400.ms, duration: 600.ms)
             .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
             
            SizedBox(height: 8),
            
            // Subtitle
            Text('mobile.auto.intelligent_proptech_ecosystem'.tr(),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
                letterSpacing: 1,
              ),
            ).animate()
             .fadeIn(delay: 800.ms, duration: 600.ms),
             
            const SizedBox(height: 48),
            
            // Loading Indicator
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 2,
              ),
            ).animate().fadeIn(delay: 1.2.seconds),
          ],
        ),
      ),
    );
  }
}
