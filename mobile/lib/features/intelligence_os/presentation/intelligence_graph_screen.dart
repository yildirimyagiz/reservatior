import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntelligenceGraphScreen extends ConsumerWidget {
  const IntelligenceGraphScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'Intelligence Graph',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.hub_outlined, size: 64, color: AppColors.primaryLight),
                        _buildOrbitingNode(Alignment.topLeft, Icons.home_outlined, AppColors.success, delay: 0),
                        _buildOrbitingNode(Alignment.topRight, Icons.person_outline, AppColors.warning, delay: 200),
                        _buildOrbitingNode(Alignment.bottomLeft, Icons.trending_up, AppColors.info, delay: 400),
                        _buildOrbitingNode(Alignment.bottomRight, Icons.gavel_outlined, AppColors.error, delay: 600),
                      ],
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 0.95, end: 1.05, duration: 3.seconds, curve: Curves.easeInOut),
                  const SizedBox(height: 48),
                  Text(
                    'Mapping Ecosystem Relations...',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondaryDark,
                      letterSpacing: 1.2,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).fade(duration: 1.5.seconds),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrbitingNode(Alignment alignment, IconData icon, Color color, {int delay = 0}) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.8)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    ).animate().fadeIn(delay: delay.ms).scale();
  }
}
