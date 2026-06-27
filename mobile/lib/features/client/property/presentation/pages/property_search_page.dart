import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/features/client/property/presentation/providers/property_search_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/search/property_card_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/search/property_filter_bottom_sheet.dart';
import 'package:reservatior/features/client/property/presentation/widgets/ai_upsell_banner_widget.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:reservatior/features/client/hotel/presentation/widgets/hotel_alternatives_widget.dart';
import 'property_search_map_page.dart';

class PropertySearchPage extends ConsumerStatefulWidget {
  const PropertySearchPage({super.key});

  @override
  ConsumerState<PropertySearchPage> createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends ConsumerState<PropertySearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isList = true;
  
  // B2B & AI Arbitrage state
  Map<String, dynamic>? _upsellData;
  bool _isUpsellDismissed = false;
  bool _isLoadingUpsell = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  /// Fetch AI Upsell recommendation when search term changes
  Future<void> _fetchAIUpsell(String destination) async {
    if (destination.length < 3 || _isUpsellDismissed) return;
    
    setState(() => _isLoadingUpsell = true);
    
    try {
      final dio = Dio();
      final now = DateTime.now();
      final checkIn = now.toIso8601String().split('T')[0];
      final checkOut = now.add(const Duration(days: 5)).toIso8601String().split('T')[0];
      
      final response = await dio.get(
        ApiEndpoints.aiArbitrageUpsell,
        queryParameters: {
          'destination': destination,
          'checkIn': checkIn,
          'checkOut': checkOut,
          'guests': '2',
        },
      );
      
      if (response.data['success'] == true && response.data['data']?['hasUpsell'] == true) {
        setState(() {
          _upsellData = response.data['data']['upsell'];
        });
      }
    } catch (e) {
      debugPrint('[AI-UPSELL] Error fetching upsell: $e');
    } finally {
      setState(() => _isLoadingUpsell = false);
    }
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) => const PropertyFilterBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertySearchResultsProvider);
    final filters = ref.watch(propertySearchFiltersProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildToolbar(context, filters),
            _buildQuickStats(properties.length),
            Expanded(
              child: properties.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: properties.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          if (_upsellData != null && !_isUpsellDismissed) {
                            return AIUpsellBannerWidget(
                              upsellData: _upsellData!,
                              onTap: () {},
                              onDismiss: () {
                                setState(() => _isUpsellDismissed = true);
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        }
                        
                        if (index == 1) {
                          if (_searchController.text.length >= 3) {
                            final now = DateTime.now();
                            final checkIn = now.toIso8601String().split('T')[0];
                            final checkOut = now.add(const Duration(days: 5)).toIso8601String().split('T')[0];
                            return HotelAlternativesWidget(
                              destination: _searchController.text,
                              checkIn: checkIn,
                              checkOut: checkOut,
                              guests: 2,
                            );
                          }
                          return const SizedBox.shrink();
                        }
                        
                        return PropertyCardWidget(
                          property: properties[index - 2],
                          onTap: () {},
                          isList: _isList,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PropertySearchMapPage(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.map, color: Colors.white),
        label: Text('mobile.auto.map_view'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildToolbar(BuildContext context, PropertySearchFilters filters) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.darkBorder.withOpacity(0.3),
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'mobile.auto.search_city_neighborhood'.tr(),
                  hintStyle: const TextStyle(
                    color: Colors.white24,
                    fontSize: 13,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white38,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close, size: 16),
                          onPressed: () {
                            _searchController.clear();
                            ref
                                .read(propertySearchFiltersProvider.notifier)
                                .setSearch('');
                          },
                        )
                      : null,
                ),
                onSubmitted: (val) {
                  ref
                      .read(propertySearchFiltersProvider.notifier)
                      .setSearch(val);
                  // Trigger AI Upsell evaluation
                  _fetchAIUpsell(val);
                },
              ),
            ),
          ),
          SizedBox(width: 12),
          _buildToolButton(
            icon: Icons.tune,
            onTap: _showFilters,
            hasBadge: filters.propertyTypes.isNotEmpty || filters.minPrice > 0,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
        ),
        if (hasBadge)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickStats(int count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count properties found',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white38,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              _buildToggleIcon(
                Icons.grid_view,
                !_isList,
                () => setState(() => _isList = false),
              ),
              SizedBox(width: 8),
              _buildToggleIcon(
                Icons.list,
                _isList,
                () => setState(() => _isList = true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleIcon(IconData icon, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: active ? AppColors.primaryLight : Colors.white24,
        size: 20,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.darkSurface.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 48,
              color: Colors.white10,
            ),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.no_properties_found'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text('mobile.auto.try_adjusting_your_filters_or_search_area'.tr(),
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),
          SizedBox(height: 24),
          OutlinedButton(
            onPressed: () =>
                ref.read(propertySearchFiltersProvider.notifier).clearFilters(),
            child: Text('mobile.auto.reset_all_filters'.tr()),
          ),
        ],
      ),
    );
  }
}
