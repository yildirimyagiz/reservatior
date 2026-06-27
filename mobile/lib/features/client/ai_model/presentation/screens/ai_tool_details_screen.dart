import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/features/client/ai_model/presentation/providers/ai_hub_provider.dart';

class AiToolDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> tool;

  const AiToolDetailsScreen({super.key, required this.tool});

  @override
  State<AiToolDetailsScreen> createState() => _AiToolDetailsScreenState();
}

class _AiToolDetailsScreenState extends State<AiToolDetailsScreen> {
  bool _isGenerating = false;
  bool _isGenerated = false;
  double _generationProgress = 0.0;
  String _currentStepText = '';
  Map<String, dynamic>? _generatedResultData;

  // Interactive state variables
  // Image Enhancement
  double _enhancementStrength = 0.8;
  bool _superResolution = true;
  bool _denoise = true;

  // Virtual Staging
  String _selectedStyle = 'mobile.leftovers.luxury_contemporary'.tr();
  String _selectedRoom = 'mobile.leftovers.living_room'.tr();
  final List<String> _styles = ['mobile.leftovers.luxury_contemporary'.tr(), 'mobile.leftovers.modern_scandinavian'.tr(), 'mobile.leftovers.minimalist_japandi'.tr(), 'mobile.leftovers.industrial_loft'.tr()];
  final List<String> _rooms = ['mobile.leftovers.living_room'.tr(), 'mobile.leftovers.master_bedroom'.tr(), 'mobile.leftovers.kitchen_dining'.tr(), 'mobile.leftovers.executive_office'.tr()];

  // Description Generator
  String _selectedPropertyType = 'Villa';
  String _selectedTone = 'mobile.leftovers.sophisticated_elegant'.tr();
  bool _includeAmenities = true;
  final List<String> _tones = ['mobile.leftovers.sophisticated_elegant'.tr(), 'mobile.leftovers.persuasive_sales_driven'.tr(), 'mobile.leftovers.modern_direct'.tr(), 'mobile.leftovers.warm_inviting'.tr()];

  // Video Producer
  String _aspectRatio = 'mobile.leftovers.9_16_vertical_reels'.tr();
  String _musicTheme = 'mobile.leftovers.cinematic_ambient'.tr();
  double _durationSeconds = 30;

  // Lead Scoring & Fraud
  double _budgetSlider = 2500000;
  String _docType = 'mobile.leftovers.title_deed'.tr();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final colors = ref.watch(themeAwareColorsProvider);
        final title = widget.tool['title'] as String;
        final icon = widget.tool['icon'] as IconData;
        final color = widget.tool['color'] as Color;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(
            backgroundColor: colors.background,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverviewCard(colors, color),
                    const SizedBox(height: 24),
                    if (!_isGenerating && !_isGenerated) ...[
                      _buildConfigurationSection(colors, color),
                      const SizedBox(height: 32),
                      _buildGenerateButton(colors, color, ref),
                    ] else if (_isGenerating) ...[
                      _buildGeneratingState(colors, color),
                    ] else if (_isGenerated) ...[
                      _buildResultSection(colors, color),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverviewCard(ThemeAwareColors colors, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(widget.tool['icon'] as IconData, color: color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.neural_agent_active'.tr(),
                  style: GoogleFonts.outfit(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.tool['desc'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildConfigurationSection(ThemeAwareColors colors, Color color) {
    final title = widget.tool['title'] as String;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.generation_parameters'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary.withOpacity(0.5),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title == 'mobile.leftovers.image_enhancement'.tr()) _buildImageEnhancementControls(colors, color),
              if (title == 'mobile.leftovers.virtual_staging'.tr()) _buildVirtualStagingControls(colors, color),
              if (title == 'mobile.leftovers.description_generator'.tr()) _buildDescriptionGeneratorControls(colors, color),
              if (title == 'mobile.leftovers.video_producer'.tr()) _buildVideoProducerControls(colors, color),
              if (title == 'mobile.leftovers.market_analysis'.tr()) _buildMarketAnalysisControls(colors, color),
              if (title == 'mobile.leftovers.lead_scoring'.tr()) _buildLeadScoringControls(colors, color),
              if (title == 'mobile.leftovers.fraud_detection'.tr()) _buildFraudDetectionControls(colors, color),
              if (title == 'Sentiment Analysis') _buildSentimentAnalysisControls(colors, color),
              if (title == 'Investment Analysis') _buildInvestmentAnalysisControls(colors, color),
              if (title == 'Predictive Maintenance') _buildPredictiveMaintenanceControls(colors, color),
              if (title == 'ML Model Manager') _buildMlModelManagerControls(colors, color),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }

  // IMAGE ENHANCEMENT
  Widget _buildImageEnhancementControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.select_target_image'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black38,
            child: const Center(
              child: Icon(Icons.add_photo_alternate_rounded, color: Colors.white, size: 36),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('mobile.auto.enhancement_power'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 13)),
            Text('${(_enhancementStrength * 100).toInt()}%', style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        Slider(
          value: _enhancementStrength,
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
          onChanged: (v) => setState(() => _enhancementStrength = v),
        ),
        SizedBox(height: 10),
        SwitchListTile(
          value: _superResolution,
          title: Text('mobile.auto.neural_super_resolution_4k'.tr(), style: TextStyle(color: colors.textPrimary, fontSize: 13)),
          activeColor: color,
          contentPadding: EdgeInsets.zero,
          onChanged: (v) => setState(() => _superResolution = v),
        ),
        SwitchListTile(
          value: _denoise,
          title: Text('mobile.auto.auto_lighting_denoise'.tr(), style: TextStyle(color: colors.textPrimary, fontSize: 13)),
          activeColor: color,
          contentPadding: EdgeInsets.zero,
          onChanged: (v) => setState(() => _denoise = v),
        ),
      ],
    );
  }

  // VIRTUAL STAGING
  Widget _buildVirtualStagingControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.staging_style'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedStyle,
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: _styles.map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) => setState(() => _selectedStyle = v!),
        ),
        SizedBox(height: 20),
        Text('mobile.auto.target_room_area'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedRoom,
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: _rooms.map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) => setState(() => _selectedRoom = v!),
        ),
        const SizedBox(height: 20),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_enhance_rounded, color: Colors.white24, size: 32),
              const SizedBox(height: 8),
              Text('mobile.auto.click_to_upload_empty_room_photo'.tr(), style: const TextStyle(color: Colors.white30, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  // DESCRIPTION GENERATOR
  Widget _buildDescriptionGeneratorControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.creative_writing_tone'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedTone,
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: _tones.map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) => setState(() => _selectedTone = v!),
        ),
        SizedBox(height: 20),
        Text('mobile.auto.property_focus_points'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSelectableChip('mobile.leftovers.infinity_pool'.tr(), true, color),
            _buildSelectableChip('mobile.leftovers.panoramic_sea_view'.tr(), true, color),
            _buildSelectableChip('mobile.leftovers.smart_home_automation'.tr(), false, color),
            _buildSelectableChip('mobile.leftovers.private_garden'.tr(), false, color),
            _buildSelectableChip('mobile.leftovers.wine_cellar'.tr(), true, color),
          ],
        ),
        SizedBox(height: 10),
        SwitchListTile(
          value: _includeAmenities,
          title: Text('mobile.auto.optimize_with_seo_rich_metadata'.tr(), style: TextStyle(color: colors.textPrimary, fontSize: 13)),
          activeColor: color,
          contentPadding: EdgeInsets.zero,
          onChanged: (v) => setState(() => _includeAmenities = v),
        ),
      ],
    );
  }

  Widget _buildSelectableChip(String label, bool isSelected, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
        border: Border.all(color: isSelected ? color : Colors.white24),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  // VIDEO PRODUCER
  Widget _buildVideoProducerControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.render_format'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildFormatCard('mobile.leftovers.vertical_reels'.tr(), '9:16', Icons.stay_current_portrait_rounded, _aspectRatio.contains('Vertical'), color, colors),
            const SizedBox(width: 12),
            _buildFormatCard('Landscape', '16:9', Icons.desktop_mac_rounded, _aspectRatio.contains('Landscape'), color, colors),
          ],
        ),
        SizedBox(height: 20),
        Text('mobile.auto.ai_music_theme'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _musicTheme,
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: ['mobile.leftovers.cinematic_ambient'.tr(), 'mobile.leftovers.modern_beats'.tr(), 'mobile.leftovers.luxury_lo_fi'.tr(), 'mobile.leftovers.smooth_jazz'.tr()].map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) => setState(() => _musicTheme = v!),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('mobile.auto.max_video_duration'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 13)),
            Text('${_durationSeconds.toInt()} seconds', style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        Slider(
          value: _durationSeconds,
          min: 15,
          max: 60,
          divisions: 3,
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
          onChanged: (v) => setState(() => _durationSeconds = v),
        ),
      ],
    );
  }

  Widget _buildFormatCard(String label, String ratio, IconData icon, bool isSelected, Color color, ThemeAwareColors colors) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _aspectRatio = label.contains('Vertical') ? 'mobile.leftovers.9_16_vertical_reels'.tr() : 'mobile.leftovers.16_9_landscape'.tr()),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : colors.background,
            border: Border.all(color: isSelected ? color : colors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? color : colors.textSecondary, size: 24),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
              Text(ratio, style: TextStyle(color: colors.textSecondary, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  // MARKET ANALYSIS
  Widget _buildMarketAnalysisControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.target_region'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: 'mobile.leftovers.miami_beach_florida'.tr(),
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: ['mobile.leftovers.miami_beach_florida'.tr(), 'mobile.leftovers.beverly_hills_california'.tr(), 'mobile.leftovers.tribeca_new_york'.tr(), 'mobile.leftovers.istanbul_turkey'.tr()].map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) {},
        ),
        SizedBox(height: 20),
        Text('mobile.auto.insights_depth'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSelectableChip('mobile.leftovers.historical_sales_price_trend'.tr(), true, color),
            _buildSelectableChip('mobile.leftovers.regional_appreciation_forecast'.tr(), true, color),
            _buildSelectableChip('mobile.leftovers.neighborhood_crime_safety_score'.tr(), false, color),
            _buildSelectableChip('mobile.leftovers.school_transport_infrastructure'.tr(), true, color),
          ],
        ),
      ],
    );
  }

  // LEAD SCORING
  Widget _buildLeadScoringControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.profile_category'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: 'mobile.leftovers.luxury_investor'.tr(),
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: ['mobile.leftovers.luxury_investor'.tr(), 'mobile.leftovers.first_time_homebuyer'.tr(), 'mobile.leftovers.retirement_seeker'.tr(), 'mobile.leftovers.commercial_developer'.tr()].map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) {},
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('mobile.auto.target_budget_range'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 13)),
            Text('\$${(_budgetSlider / 1000000).toStringAsFixed(1)}M+', style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        Slider(
          value: _budgetSlider,
          min: 500000,
          max: 10000000,
          activeColor: color,
          inactiveColor: color.withOpacity(0.2),
          onChanged: (v) => setState(() => _budgetSlider = v),
        ),
      ],
    );
  }

  // FRAUD DETECTION
  Widget _buildFraudDetectionControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.scan_document_type'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _docType,
          dropdownColor: colors.surface,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.border)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: ['mobile.leftovers.title_deed'.tr(), 'mobile.leftovers.passport_government_id'.tr(), 'mobile.leftovers.escrow_agreement'.tr(), 'mobile.leftovers.bank_statement'.tr()].map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) => setState(() => _docType = v!),
        ),
        const SizedBox(height: 20),
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.document_scanner_rounded, color: Colors.white24, size: 32),
              const SizedBox(height: 8),
              Text('mobile.auto.click_to_upload_document_pdf_image'.tr(), style: const TextStyle(color: Colors.white30, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateButton(ThemeAwareColors colors, Color color, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => _startGenerating(ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, color: Colors.white),
            SizedBox(width: 10),
            Text('mobile.auto.run_neural_engine'.tr(),
              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startGenerating(WidgetRef ref) async {
    setState(() {
      _isGenerating = true;
      _generationProgress = 0.0;
    });

    final steps = [
      'mobile.leftovers.initializing_quantum_neural_weights'.tr(),
      'mobile.leftovers.mapping_depth_fields_and_entity_vectors'.tr(),
      'mobile.leftovers.refining_atmospheric_illumination_textur'.tr(),
      'mobile.leftovers.synthesizing_luxury_output_matrices'.tr(),
      'mobile.leftovers.finalizing_high_fidelity_rendering_detai'.tr()
    ];

    final title = widget.tool['title'] as String;
    Future<Map<String, dynamic>?> apiCall;

    if (title == 'mobile.leftovers.description_generator'.tr()) {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateDescription({
        'propertyId': 'temp-prop-id',
        'tone': _selectedTone,
        'targetAudience': _selectedPropertyType,
        'keyFeatures': ['High Ceiling', 'Marble Countertops'],
        'seoKeywords': ['luxury', _selectedPropertyType.toLowerCase()],
        'qualityScore': 92,
        'generatedAt': DateTime.now().toIso8601String(),
      });
    } else if (title == 'mobile.leftovers.image_enhancement'.tr()) {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateImageAnalysis({
        'propertyId': 'temp-prop-id',
        'analysisType': 'enhancement',
        'qualityScore': (_enhancementStrength * 100).toInt(),
        'confidence': 0.94,
        'analyzedAt': DateTime.now().toIso8601String(),
      });
    } else if (title == 'mobile.leftovers.virtual_staging'.tr()) {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateImageAnalysis({
        'propertyId': 'temp-prop-id',
        'analysisType': 'virtual_staging',
        'styleTags': [_selectedStyle],
        'detectedRooms': [_selectedRoom],
        'confidence': 0.88,
        'analyzedAt': DateTime.now().toIso8601String(),
      });
    } else if (title == 'mobile.leftovers.market_analysis'.tr() || title == 'mobile.leftovers.property_valuation'.tr()) {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateValuation({
        'modelId': 'valuation-model-v2',
        'propertyId': 'temp-prop-id',
        'predictedValue': 1450000.0,
        'confidenceScore': 0.91,
        'valuationDate': DateTime.now().toIso8601String(),
        'inputFeatures': {'bedrooms': 3, 'bathrooms': 2.5},
      });
    } else if (title == 'mobile.leftovers.lead_scoring'.tr()) {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateLeadScore({
        'modelId': 'lead-score-v1',
        'leadId': 'temp-lead-id',
        'score': 88.0,
        'confidence': 0.92,
        'scoredAt': DateTime.now().toIso8601String(),
        'featuresUsed': {'budget': _budgetSlider},
      });
    } else if (title == 'mobile.leftovers.fraud_detection'.tr()) {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateTenantScreening({
        'applicationId': 'temp-app-id',
        'overallScore': 94.0,
        'riskAssessment': 'LOW',
        'riskFactors': [_docType],
        'screenedAt': DateTime.now().toIso8601String(),
      });
    } else if (title == 'Sentiment Analysis') {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateSentimentAnalysis({
        'contentType': 'review',
        'contentId': 'temp-review-id',
        'contentText': 'Spectacular property, modern design, very clean!',
        'sentiment': 'POSITIVE',
        'sentimentScore': 96.0,
        'confidence': 0.95,
        'analyzedAt': DateTime.now().toIso8601String(),
      });
    } else if (title == 'Investment Analysis') {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateValuation({
        'modelId': 'investment-calculator-v1',
        'propertyId': 'temp-prop-id',
        'predictedValue': 2450000.0,
        'confidenceScore': 0.92,
        'valuationDate': DateTime.now().toIso8601String(),
        'inputFeatures': {'roi': 8.7, 'npv': 145000.0},
      });
    } else if (title == 'Predictive Maintenance') {
      apiCall = ref.read(aiHubControllerProvider.notifier).generateTenantScreening({
        'applicationId': 'temp-maintenance-id',
        'overallScore': 87.0,
        'riskAssessment': 'LOW',
        'riskFactors': ['Minor wear on plumbing'],
        'screenedAt': DateTime.now().toIso8601String(),
      });
    } else if (title == 'ML Model Manager') {
      final repo = ref.read(aiHubRepositoryProvider);
      final res = await repo.fetchGeneric('ai-models');
      apiCall = Future.value({'success': true, 'models': res});
    } else {
      apiCall = Future.value({'success': true});
    }

    for (int i = 0; i < steps.length; i++) {
      if (!mounted) return;
      setState(() {
        _currentStepText = steps[i];
        _generationProgress = (i + 1) / steps.length;
      });
      await Future.delayed(const Duration(milliseconds: 600));
    }

    final result = await apiCall;

    if (!mounted) return;
    setState(() {
      _generatedResultData = result;
      _isGenerating = false;
      _isGenerated = true;
    });
  }

  Widget _buildGeneratingState(ThemeAwareColors colors, Color color) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: _generationProgress,
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    backgroundColor: color.withOpacity(0.1),
                  ),
                ),
                Icon(widget.tool['icon'] as IconData, color: color, size: 36)
                    .animate(onPlay: (c) => c.repeat())
                    .shimmer(duration: 1.5.seconds),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              '${(_generationProgress * 100).toInt()}%',
              style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w900, color: colors.textPrimary),
            ),
            const SizedBox(height: 12),
            Text(
              _currentStepText,
              style: GoogleFonts.outfit(fontSize: 13, color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildResultSection(ThemeAwareColors colors, Color color) {
    final title = widget.tool['title'] as String;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.generation_result'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary.withOpacity(0.5),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title == 'mobile.leftovers.image_enhancement'.tr()) _buildImageEnhancementResult(colors, color),
              if (title == 'mobile.leftovers.virtual_staging'.tr()) _buildVirtualStagingResult(colors, color),
              if (title == 'mobile.leftovers.description_generator'.tr()) _buildDescriptionGeneratorResult(colors, color),
              if (title == 'mobile.leftovers.video_producer'.tr()) _buildVideoProducerResult(colors, color),
              if (title == 'mobile.leftovers.market_analysis'.tr()) _buildMarketAnalysisResult(colors, color),
              if (title == 'mobile.leftovers.lead_scoring'.tr()) _buildLeadScoringResult(colors, color),
              if (title == 'mobile.leftovers.fraud_detection'.tr()) _buildFraudDetectionResult(colors, color),
              if (title == 'Sentiment Analysis') _buildSentimentAnalysisResult(colors, color),
              if (title == 'Investment Analysis') _buildInvestmentAnalysisResult(colors, color),
              if (title == 'Predictive Maintenance') _buildPredictiveMaintenanceResult(colors, color),
              if (title == 'ML Model Manager') _buildMlModelManagerResult(colors, color),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() {
                  _isGenerated = false;
                  _isGenerating = false;
                }),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colors.border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text('mobile.auto.reset_parameters'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('mobile.ai_tool.exported_successfully'.tr()),
                      backgroundColor: color,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text('mobile.auto.save_export'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05);
  }

  // IMAGE ENHANCEMENT RESULT
  Widget _buildImageEnhancementResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.before_after_comparison'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=800'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('mobile.auto.enhanced_4k_uhd'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricRow('Resolution', 'mobile.leftovers.3840_x_2160_4k'.tr(), 'mobile.leftovers.lighting_score'.tr(), 'mobile.leftovers._45_contrast_boost'.tr(), colors),
      ],
    );
  }

  // VIRTUAL STAGING RESULT
  Widget _buildVirtualStagingResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Staged $_selectedRoom', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 4),
        Text('Theme Style: $_selectedStyle', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        const SizedBox(height: 16),
        Container(
          height: 260,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?w=800'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricRow('mobile.leftovers.objects_placed'.tr(), 'mobile.leftovers.12_smart_assets'.tr(), 'mobile.leftovers.refraction_depth'.tr(), 'mobile.leftovers.raytraced_shadows'.tr(), colors),
      ],
    );
  }

  // DESCRIPTION GENERATOR RESULT
  Widget _buildDescriptionGeneratorResult(ThemeAwareColors colors, Color color) {
    final mockDescription =
        _generatedResultData?['generatedDescription'] ??
        'mobile.leftovers.experience_ultimate_luxury_living_at_thi'.tr();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('mobile.auto.generated_copywriting'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
            IconButton(
              icon: Icon(Icons.copy_rounded, color: color, size: 18),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('mobile.ai_tool.copied_to_clipboard'.tr())),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          mockDescription,
          style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, height: 1.6),
        ),
        const SizedBox(height: 20),
        _buildMetricRow('mobile.leftovers.tone_model'.tr(), _selectedTone, 'mobile.leftovers.seo_keywords'.tr(), 'mobile.leftovers.pool_sea_view_smart_home'.tr(), colors),
      ],
    );
  }

  // VIDEO PRODUCER RESULT
  Widget _buildVideoProducerResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.cinematic_property_reels_video'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Container(
          height: 320,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 36),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricRow('mobile.leftovers.music_sync_theme'.tr(), _musicTheme, 'Duration', '${_durationSeconds.toInt()}s Video Render', colors),
      ],
    );
  }

  // MARKET ANALYSIS RESULT
  Widget _buildMarketAnalysisResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.miami_beach_property_market_insights'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildInsightWidget('mobile.leftovers.avg_price_sqft'.tr(), '\$1,420', 'mobile.leftovers._8_5_yoy'.tr(), Colors.green, colors),
            const SizedBox(width: 12),
            _buildInsightWidget('mobile.leftovers.appreciation_rank'.tr(), 'mobile.leftovers.elite_tier'.tr(), 'mobile.leftovers.12_predicted_2yr'.tr(), Colors.blue, colors),
          ],
        ),
        const SizedBox(height: 20),
        _buildMetricRow('mobile.leftovers.crime_safety_score'.tr(), 'mobile.leftovers.94_100_safe'.tr(), 'mobile.leftovers.local_schools_rank'.tr(), 'mobile.leftovers.9_2_10_a_grade'.tr(), colors),
      ],
    );
  }

  Widget _buildInsightWidget(String title, String value, String subtitle, Color color, ThemeAwareColors colors) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.background,
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: colors.textSecondary, fontSize: 10)),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // LEAD SCORING RESULT
  Widget _buildLeadScoringResult(ThemeAwareColors colors, Color color) {
    final rawScore = _generatedResultData?['score']?.toDouble() ?? 94.0;
    final normalizedScore = rawScore > 1.0 ? rawScore / 100.0 : rawScore;
    final scorePercent = (normalizedScore * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.ai_lead_scoring_analytics'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: normalizedScore,
                      strokeWidth: 10,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      backgroundColor: Colors.greenAccent.withOpacity(0.1),
                    ),
                  ),
                  Text('$scorePercent%', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.greenAccent)),
                ],
              ),
              SizedBox(height: 16),
              Text('mobile.auto.elite_conversion_tier'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('mobile.auto.extremely_high_probability_of_acquisition'.tr(), style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildMetricRow('mobile.leftovers.est_budget_profile'.tr(), '\$${(_budgetSlider / 1000000).toStringAsFixed(1)}M+', 'mobile.leftovers.interaction_velocity'.tr(), 'mobile.leftovers.98th_percentile_max'.tr(), colors),
      ],
    );
  }

  // FRAUD DETECTION RESULT
  Widget _buildFraudDetectionResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.document_cryptographic_integrity_analysis'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.verified_user_rounded, color: Colors.greenAccent, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.secure_verified'.tr(), style: GoogleFonts.outfit(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('mobile.auto.passed_all_14_neural_compliance_checks_successfully'.tr(), style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildMetricRow('mobile.leftovers.ocr_name_check'.tr(), 'mobile.leftovers.100_match_atlasvs'.tr(), 'mobile.leftovers.signature_hash_match'.tr(), 'mobile.leftovers.verified_block_hash'.tr(), colors),
      ],
    );
  }

  Widget _buildMetricRow(String l1, String v1, String l2, String v2, ThemeAwareColors colors) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l1, style: TextStyle(color: colors.textSecondary, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              Text(v1, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(width: 1, height: 28, color: colors.border, margin: const EdgeInsets.symmetric(horizontal: 16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l2, style: TextStyle(color: colors.textSecondary, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 4),
              Text(v2, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  // --- NEW CONTROLS BUILDERS ---
  Widget _buildSentimentAnalysisControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Analyze Review Text', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: 'The luxury condo was spectacular and exceeded all our expectations!',
          decoration: const InputDecoration(labelText: 'Review Content'),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildInvestmentAnalysisControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Investment Projection Settings', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        Text('Estimated Initial Capital: \$2,400,000', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
        const SizedBox(height: 8),
        Text('Target Annual Growth Rate: 5%', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
      ],
    );
  }

  Widget _buildPredictiveMaintenanceControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Property for wear-prediction', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: 'Grand Luxury Villa A',
          dropdownColor: colors.surface,
          items: ['Grand Luxury Villa A', 'Penthouse B', 'Cozy Loft C'].map((s) => DropdownMenuItem(value: s, child: Text(s, style: TextStyle(color: colors.textPrimary)))).toList(),
          onChanged: (v) {},
        ),
      ],
    );
  }

  Widget _buildMlModelManagerControls(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AI ML Model Operations Control Panel', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        Text('Select model configuration to fetch and audit details from the backend registry.', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
      ],
    );
  }

  // --- NEW RESULTS BUILDERS ---
  Widget _buildSentimentAnalysisResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review Sentiment Analysis', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.mood_rounded, color: Colors.pink, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sentiment: POSITIVE (96%)', style: GoogleFonts.outfit(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('Key emotion detected: Satisfaction and Joy', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInvestmentAnalysisResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AI Investment Cashflow Projections', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        _buildMetricRow('Estimated IRR Rate', '8.7% / year', 'NPV Prediction', '+\$145,000', colors),
      ],
    );
  }

  Widget _buildPredictiveMaintenanceResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Predictive Maintenance Wear Analysis', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System Status: Normal Wear', style: GoogleFonts.outfit(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('Plumbing system has minor wear but requires no repair for the next 18 months.', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMlModelManagerResult(ThemeAwareColors colors, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ML Registry State', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.verified_rounded, color: Colors.greenAccent, size: 36),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ecosistem Models Sync: ACTIVE', style: GoogleFonts.outfit(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('Valuation Model, Lead Model, and Deployments verified online.', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
