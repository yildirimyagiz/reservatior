import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Background Immersive Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=2070&auto=format&fit=crop', // Luxury Villa
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay for readability
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  // Logo / App Name
                  Text(
                    'mobile.welcome.brand'.tr(),
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.gold,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                    ),
                  ).animate().fadeIn(duration: 1.seconds).slideY(begin: -0.2),

                  const Spacer(),

                  // Value Proposition
                  Text(
                    'mobile.welcome.title'.tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

                  SizedBox(height: 16),

                  Text(
                    'mobile.welcome.subtitle'.tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ).animate().fadeIn(delay: 800.ms),

                  const SizedBox(height: 60),

                  // Call to Action
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () => context.go('/auth/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 10,
                        shadowColor: AppColors.gold.withOpacity(0.3),
                      ),
                      child: Text(
                        'mobile.welcome.button'.tr(),
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 1.2.seconds).scale(),

                  SizedBox(height: 32),

                  // Terms
                  Text(
                    'mobile.welcome.footer'.tr(),
                    style: GoogleFonts.outfit(
                      color: AppColors.gold.withOpacity(0.6),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ).animate().fadeIn(delay: 1.5.seconds),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
