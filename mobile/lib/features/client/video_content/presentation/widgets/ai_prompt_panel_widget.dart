import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class AIPromptPanelWidget extends StatefulWidget {
  final String currentChapter;
  final VoidCallback onNextPrompt;
  final VoidCallback onSkipPrompt;

  const AIPromptPanelWidget({
    super.key,
    required this.currentChapter,
    required this.onNextPrompt,
    required this.onSkipPrompt,
  });

  @override
  State<AIPromptPanelWidget> createState() => _AIPromptPanelWidgetState();
}

class _AIPromptPanelWidgetState extends State<AIPromptPanelWidget>
    with SingleTickerProviderStateMixin {
  bool _isHydrated = false;
  int _currentPromptIndex = 0;
  bool _showTips = false;
  late AnimationController _tipsAnimationController;
  late Animation<double> _tipsAnimation;

  @override
  void initState() {
    super.initState();
    _isHydrated = true;
    _tipsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _tipsAnimation = CurvedAnimation(
      parent: _tipsAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _tipsAnimationController.dispose();
    super.dispose();
  }

  Map<String, PromptData> get promptsData => {
    'exterior': PromptData(
      chapter: 'Exterior',
      title: 'mobile.auto.showcase_the_property_exterior'.tr(),
      prompts: [
        'mobile.leftovers.start_with_a_wide_shot_of_the_entire_pro'.tr(),
        'mobile.leftovers.highlight_the_architectural_style_and_un'.tr(),
        'mobile.leftovers.show_the_front_entrance_driveway_and_par'.tr(),
        'mobile.leftovers.capture_any_outdoor_amenities_like_garde'.tr(),
      ],
      tips: [
        'mobile.leftovers.film_during_golden_hour_for_best_lightin'.tr(),
        'mobile.leftovers.walk_slowly_and_keep_the_camera_steady'.tr(),
        'mobile.leftovers.mention_the_neighborhood_and_nearby_amen'.tr(),
        'mobile.leftovers.point_out_security_features_and_accessib'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.2_3_minutes'.tr(),
    ),
    'entrance': PromptData(
      chapter: 'Entrance',
      title: 'mobile.auto.welcome_viewers_inside'.tr(),
      prompts: [
        'mobile.leftovers.open_the_door_and_provide_a_warm_welcome'.tr(),
        'mobile.leftovers.show_the_entryway_foyer_or_reception_are'.tr(),
        'mobile.leftovers.highlight_storage_spaces_like_closets_or'.tr(),
        'mobile.leftovers.mention_the_flooring_material_and_ceilin'.tr(),
      ],
      tips: [
        'mobile.leftovers.ensure_good_lighting_in_the_entrance_are'.tr(),
        'mobile.leftovers.mention_first_impressions_and_ambiance'.tr(),
        'mobile.leftovers.show_any_security_systems_or_smart_featu'.tr(),
        'mobile.leftovers.keep_the_area_tidy_and_welcoming'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.1_2_minutes'.tr(),
    ),
    'living': PromptData(
      chapter: 'mobile.leftovers.living_areas'.tr(),
      title: 'mobile.auto.tour_the_main_living_spaces'.tr(),
      prompts: [
        'mobile.leftovers.show_the_living_room_layout_and_seating'.tr(),
        'mobile.leftovers.highlight_natural_light_sources_and_wind'.tr(),
        'mobile.leftovers.demonstrate_the_flow_between_living_and'.tr(),
        'mobile.leftovers.showcase_any_entertainment_systems_or_fi'.tr(),
      ],
      tips: [
        'mobile.leftovers.open_curtains_to_maximize_natural_light'.tr(),
        'mobile.leftovers.mention_room_dimensions_and_ceiling_feat'.tr(),
        'mobile.leftovers.show_how_furniture_fits_in_the_space'.tr(),
        'mobile.leftovers.highlight_any_built_in_features_or_stora'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.3_4_minutes'.tr(),
    ),
    'bedrooms': PromptData(
      chapter: 'Bedrooms',
      title: 'mobile.auto.present_the_private_spaces'.tr(),
      prompts: [
        'mobile.leftovers.start_with_the_master_bedroom_and_its_fe'.tr(),
        'mobile.leftovers.show_closet_space_and_storage_solutions'.tr(),
        'mobile.leftovers.highlight_en_suite_bathrooms_if_availabl'.tr(),
        'mobile.leftovers.tour_additional_bedrooms_and_their_uniqu'.tr(),
      ],
      tips: [
        'mobile.leftovers.ensure_beds_are_made_and_rooms_are_tidy'.tr(),
        'mobile.leftovers.mention_room_sizes_and_window_orientatio'.tr(),
        'mobile.leftovers.show_closet_organization_and_capacity'.tr(),
        'mobile.leftovers.highlight_any_special_features_like_balc'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.4_5_minutes'.tr(),
    ),
    'kitchen': PromptData(
      chapter: 'Kitchen',
      title: 'mobile.auto.showcase_the_heart_of_the_home'.tr(),
      prompts: [
        'mobile.leftovers.show_the_kitchen_layout_and_work_triangl'.tr(),
        'mobile.leftovers.highlight_appliances_and_their_brands_mo'.tr(),
        'mobile.leftovers.demonstrate_cabinet_and_storage_space'.tr(),
        'mobile.leftovers.show_countertop_materials_and_backsplash'.tr(),
      ],
      tips: [
        'mobile.leftovers.clear_countertops_of_clutter'.tr(),
        'mobile.leftovers.open_cabinets_to_show_storage_capacity'.tr(),
        'mobile.leftovers.mention_any_recent_renovations_or_upgrad'.tr(),
        'mobile.leftovers.highlight_energy_efficient_appliances'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.2_3_minutes'.tr(),
    ),
    'bathrooms': PromptData(
      chapter: 'Bathrooms',
      title: 'mobile.auto.tour_the_bathroom_facilities'.tr(),
      prompts: [
        'mobile.leftovers.show_the_layout_and_fixture_placement'.tr(),
        'mobile.leftovers.highlight_vanity_sink_and_storage_areas'.tr(),
        'mobile.leftovers.demonstrate_shower_tub_features_and_qual'.tr(),
        'mobile.leftovers.mention_ventilation_and_lighting'.tr(),
      ],
      tips: [
        'mobile.leftovers.ensure_bathrooms_are_spotlessly_clean'.tr(),
        'mobile.leftovers.show_water_pressure_if_possible'.tr(),
        'mobile.leftovers.highlight_any_luxury_features_like_heate'.tr(),
        'mobile.leftovers.mention_recent_updates_or_renovations'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.2_3_minutes'.tr(),
    ),
    'extras': PromptData(
      chapter: 'mobile.leftovers.extra_spaces'.tr(),
      title: 'mobile.auto.highlight_additional_features'.tr(),
      prompts: [
        'mobile.leftovers.show_any_bonus_rooms_like_offices_or_gym'.tr(),
        'mobile.leftovers.tour_basement_or_attic_spaces'.tr(),
        'mobile.leftovers.highlight_laundry_facilities_and_utility'.tr(),
        'mobile.leftovers.showcase_outdoor_spaces_garages_or_stora'.tr(),
      ],
      tips: [
        'mobile.leftovers.mention_potential_uses_for_flexible_spac'.tr(),
        'mobile.leftovers.show_storage_capacity_and_organization'.tr(),
        'mobile.leftovers.highlight_any_smart_home_features'.tr(),
        'mobile.leftovers.mention_energy_efficiency_and_utilities'.tr(),
      ],
      estimatedTime: 'mobile.leftovers.3_4_minutes'.tr(),
    ),
  };

  PromptData get currentData =>
      promptsData[widget.currentChapter] ?? promptsData['exterior']!;

  void handleNextPrompt() {
    if (_currentPromptIndex < currentData.prompts.length - 1) {
      setState(() {
        _currentPromptIndex++;
      });
    } else {
      widget.onNextPrompt();
      setState(() {
        _currentPromptIndex = 0;
      });
    }
  }

  void toggleTips() {
    setState(() {
      _showTips = !_showTips;
    });
    if (_showTips) {
      _tipsAnimationController.forward();
    } else {
      _tipsAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return _buildShimmerLoading();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Column(children: [_buildHeader(), _buildContent()]),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity * 0.8,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.auto_awesome, size: 24, color: AppColors.gold),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentData.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBg,
                    ),
                  ),
                  Text(
                    '${currentData.chapter} • ${currentData.estimatedTime}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkBg.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: toggleTips,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentPrompt(),
          const SizedBox(height: 16),
          _buildProgressIndicator(),
          const SizedBox(height: 16),
          _buildTipsSection(),
          const SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCurrentPrompt() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.gold,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${_currentPromptIndex + 1}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBg,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            currentData.prompts[_currentPromptIndex],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryDark,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: currentData.prompts.asMap().entries.map((entry) {
        final index = entry.key;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index < currentData.prompts.length - 1 ? 8 : 0,
            ),
            height: 4,
            decoration: BoxDecoration(
              color: index <= _currentPromptIndex
                  ? AppColors.gold
                  : AppColors.darkSurface,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTipsSection() {
    if (!_showTips) return const SizedBox.shrink();

    return SizeTransition(
      sizeFactor: _tipsAnimation,
      child: FadeTransition(
        opacity: _tipsAnimation,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, size: 20, color: AppColors.gold),
                  SizedBox(width: 8),
                  Text('mobile.auto.pro_tips'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...currentData.tips.map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryDark,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onSkipPrompt,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.darkBorder.withOpacity(0.3),
                  ),
                ),
                child: Text('mobile.auto.skip_section'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: handleNextPrompt,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentPromptIndex < currentData.prompts.length - 1
                          ? 'mobile.leftovers.next_prompt'.tr()
                          : 'mobile.leftovers.next_section'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBg,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: AppColors.darkBg,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PromptData {
  final String chapter;
  final String title;
  final List<String> prompts;
  final List<String> tips;
  final String estimatedTime;

  PromptData({
    required this.chapter,
    required this.title,
    required this.prompts,
    required this.tips,
    required this.estimatedTime,
  });
}
