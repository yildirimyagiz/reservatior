import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'ai_valuation_screen.dart';
import 'ai_tool_details_screen.dart';

class AiStudioScreen extends ConsumerWidget {
  const AiStudioScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.ai_studio'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 130),
        children: [
          _buildHero(colors),
          SizedBox(height: 24),
          Text('mobile.auto.ai_tools'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._tools.asMap().entries.map(
            (e) => _buildToolCard(e.value, colors, e.key, context),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
              SizedBox(width: 10),
              Text('mobile.auto.neural_engine'.tr(),
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text('mobile.auto.powered_by_advanced_ai_models_for_property_analysis_valuation_and_content_generation'.tr(),
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildChip('mobile.leftovers.gpt_4o'.tr(), Colors.white),
              const SizedBox(width: 8),
              _buildChip('SDXL', Colors.white),
              const SizedBox(width: 8),
              _buildChip('mobile.leftovers.phi_3'.tr(), Colors.white),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildChip(String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
    ),
  );

  Widget _buildToolCard(
    Map<String, dynamic> tool,
    ThemeAwareColors colors,
    int index,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (tool['title'] == 'mobile.leftovers.property_valuation'.tr()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AiValuationScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AiToolDetailsScreen(tool: tool),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (tool['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  tool['icon'] as IconData,
                  color: tool['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool['title'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool['desc'] as String,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 80 * index))
        .slideX(begin: 0.05);
  }

  static final _tools = [
    {
      'title': 'mobile.leftovers.property_valuation'.tr(),
      'desc': 'mobile.leftovers.ai_powered_market_price_estimation'.tr(),
      'icon': Icons.price_change_rounded,
      'color': Colors.green,
    },
    {
      'title': 'mobile.leftovers.image_enhancement'.tr(),
      'desc': 'mobile.leftovers.upscale_enhance_property_photos'.tr(),
      'icon': Icons.auto_fix_high_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'mobile.leftovers.virtual_staging'.tr(),
      'desc': 'mobile.leftovers.ai_furniture_placement_staging'.tr(),
      'icon': Icons.chair_rounded,
      'color': Colors.purple,
    },
    {
      'title': 'mobile.leftovers.description_generator'.tr(),
      'desc': 'mobile.leftovers.auto_generate_listing_descriptions'.tr(),
      'icon': Icons.article_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'mobile.leftovers.video_producer'.tr(),
      'desc': 'mobile.leftovers.cinematic_property_tour_videos'.tr(),
      'icon': Icons.videocam_rounded,
      'color': Colors.red,
    },
    {
      'title': 'mobile.leftovers.market_analysis'.tr(),
      'desc': 'mobile.leftovers.neighborhood_trend_insights'.tr(),
      'icon': Icons.analytics_rounded,
      'color': Colors.teal,
    },
    {
      'title': 'mobile.leftovers.lead_scoring'.tr(),
      'desc': 'mobile.leftovers.ai_buyer_intent_prediction'.tr(),
      'icon': Icons.person_search_rounded,
      'color': Colors.indigo,
    },
    {
      'title': 'mobile.leftovers.fraud_detection'.tr(),
      'desc': 'mobile.leftovers.document_identity_verification'.tr(),
      'icon': Icons.shield_rounded,
      'color': Colors.amber,
    },
    {
      'title': 'Sentiment Analysis',
      'desc': 'Real-time review sentiment and emotion tracking',
      'icon': Icons.mood_rounded,
      'color': Colors.pink,
    },
    {
      'title': 'Investment Analysis',
      'desc': 'ROI, NPV, and IRR investment cashflow predictor',
      'icon': Icons.monetization_on_rounded,
      'color': Colors.lightGreen,
    },
    {
      'title': 'Predictive Maintenance',
      'desc': 'HVAC, plumbing, and structural wear predictions',
      'icon': Icons.build_rounded,
      'color': Colors.blueGrey,
    },
    {
      'title': 'ML Model Manager',
      'desc': 'Manage valuations models, lead scoring models, deployments and predictions',
      'icon': Icons.settings_suggest_rounded,
      'color': Colors.deepPurple,
    },
  ];
}
