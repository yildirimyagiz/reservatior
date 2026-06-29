import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class AiMagicWandButton extends ConsumerWidget {
  final TextEditingController controller;
  final String promptContext;
  final String? label;

  const AiMagicWandButton({
    super.key,
    required this.controller,
    required this.promptContext,
    this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final aiState = null;

    return InkWell(
      onTap: aiState.isLoading
          ? null
          : () async {
              final payload = {
                'propertyId': 'temp-prop-id',
                'tone': 'professional',
                'targetAudience': 'luxury buyers',
                'keyFeatures': [promptContext],
                'seoKeywords': ['luxury', 'villa'],
                'qualityScore': 95,
                'generatedAt': DateTime.now().toIso8601String(),
              };
              
              final result = await ref

                  .generateDescription(payload);

              if (result != null && result['generatedDescription'] != null) {
                controller.text = result['generatedDescription'];
              } else {
                // Fallback simulation if backend API is not set up / empty
                stateSimulationFallback(ref);
              }
            },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            aiState.isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              aiState.isLoading
                  ? 'AI Generating...'
                  : (label ?? 'AI Write'),
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(delay: 100.ms, duration: 200.ms);
  }

  void stateSimulationFallback(WidgetRef ref) {
    // Elegant fallback simulation
    controller.text = "Spectacular modern luxury residence featuring an open-concept design with $promptContext. The home offers premium finishes, floor-to-ceiling windows, and complete smart home integration.";
  }
}

class AiScoreBadge extends ConsumerWidget {
  final double score; // 0.0 to 100.0 or 0.0 to 1.0
  final String label;

  const AiScoreBadge({
    super.key,
    required this.score,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final normalizedScore = score > 1.0 ? score : score * 100.0;
    
    Color badgeColor;
    if (normalizedScore >= 80) {
      badgeColor = const Color(0xFF10B981); // Emerald
    } else if (normalizedScore >= 50) {
      badgeColor = const Color(0xFFF59E0B); // Amber
    } else {
      badgeColor = const Color(0xFFEF4444); // Rose
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: badgeColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.insights_rounded, color: badgeColor, size: 14),
          const SizedBox(width: 6),
          Text(
            '$label: ${normalizedScore.toInt()}%',
            style: GoogleFonts.outfit(
              color: badgeColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class AiRiskAlertCard extends ConsumerWidget {
  final String title;
  final String reason;
  final String severity; // HIGH, MEDIUM, LOW

  const AiRiskAlertCard({
    super.key,
    required this.title,
    required this.reason,
    required this.severity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    
    Color severityColor;
    IconData icon;
    if (severity.toUpperCase() == 'HIGH') {
      severityColor = const Color(0xFFEF4444);
      icon = Icons.gavel_rounded;
    } else if (severity.toUpperCase() == 'MEDIUM') {
      severityColor = const Color(0xFFF59E0B);
      icon = Icons.warning_amber_rounded;
    } else {
      severityColor = const Color(0xFF3B82F6);
      icon = Icons.info_outline_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: severityColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: severityColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: severityColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: severityColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        color: colors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: severityColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        severity.toUpperCase(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  reason,
                  style: GoogleFonts.outfit(
                    color: colors.textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ).animate().shake(duration: 400.ms);
  }
}
