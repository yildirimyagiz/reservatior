import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'dart:ui' as ui;

class AiMarketAnalysisListWidget extends StatelessWidget {
  final List<AiMarketAnalysis> items;
  const AiMarketAnalysisListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.blur_on_rounded,
                color: Colors.white10,
                size: 80,
              ).animate().rotate(duration: 3.seconds),
              SizedBox(height: 24),
              Text('mobile.auto.no_neural_signals'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.white24,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemBuilder: (context, i) {
        final item = items[i];
        String title = 'mobile.leftovers.neural_signal'.tr();
        try {
          title =
              (item as dynamic).name ??
              (item as dynamic).title ??
              'mobile.leftovers.market_telemetry'.tr();
        } catch (_) {}

        final isBullish = i % 3 == 0;
        final isBearish = i % 3 == 1;

        return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 40,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildNeuralSignal(isBullish, isBearish),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title.toUpperCase(),
                                    style: GoogleFonts.outfit(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Text(
                                          'NODE: ${item.id.substring(0, 8).toUpperCase()}',
                                          style: GoogleFonts.outfit(
                                            color: AppColors.primary,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      _buildIntelligenceTag(
                                        isBullish,
                                        isBearish,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white24,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Quick Stats Floor
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildQuickStat(
                              'VOLATILITY',
                              'LOW',
                              Colors.greenAccent,
                            ),
                            _buildQuickStat(
                              'CONFIDENCE',
                              '98.4%',
                              AppColors.primary,
                            ),
                            _buildQuickStat(
                              'TREND',
                              isBullish
                                  ? '+12.4%'
                                  : isBearish
                                  ? '-4.2%'
                                  : 'STABLE',
                              isBullish
                                  ? Colors.greenAccent
                                  : isBearish
                                  ? Colors.redAccent
                                  : Colors.white24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms, delay: (i * 150).ms)
            .slideX(begin: 0.1, end: 0)
            .shimmer(
              duration: 3.seconds,
              color: Colors.white.withOpacity(0.02),
            );
      },
    );
  }

  Widget _buildNeuralSignal(bool isBullish, bool isBearish) {
    final color = isBullish
        ? Colors.greenAccent
        : isBearish
        ? Colors.redAccent
        : AppColors.primary;
    return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Center(
            child: Icon(
              isBullish
                  ? Icons.trending_up_rounded
                  : isBearish
                  ? Icons.trending_down_rounded
                  : Icons.radar_rounded,
              color: color,
              size: 28,
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2.seconds, color: color.withOpacity(0.1));
  }

  Widget _buildIntelligenceTag(bool isBullish, bool isBearish) {
    final label = isBullish
        ? 'BULLISH'
        : isBearish
        ? 'BEARISH'
        : 'NEUTRAL';
    final color = isBullish
        ? Colors.greenAccent
        : isBearish
        ? Colors.redAccent
        : Colors.white24;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            color: Colors.white24,
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSignalIndicator(int strength) {
    Color color = strength > 2
        ? Colors.green
        : (strength > 1 ? Colors.blue : Colors.orange);
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.sensors_rounded, color: color, size: 24),
          Positioned(
            bottom: 12,
            right: 12,
            child:
                Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.darkSurface,
                          width: 2,
                        ),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat())
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.3, 1.3),
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeOut(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(int i) {
    final statuses = [
      {'label': 'STABLE', 'color': Colors.green},
      {'label': 'ANALYZING', 'color': Colors.blue},
      {'label': 'VOLATILE', 'color': Colors.orange},
    ];
    final status = statuses[i % statuses.length];
    final color = status['color'] as Color;

    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          status['label'] as String,
          style: GoogleFonts.outfit(
            color: color,
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
