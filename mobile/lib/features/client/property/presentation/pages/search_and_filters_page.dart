import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/property/presentation/widgets/active_filters_bar_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/filter_section_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/location_filter_widget.dart' hide Location;
import 'package:reservatior/features/client/property/presentation/widgets/map_view_toggle_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/price_range_slider_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_result_card_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_specs_filter_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/saved_searches_widget.dart';
import 'package:reservatior/shared/widgets/property_map_view.dart';
import 'package:reservatior/shared/providers/listing_provider.dart';
import 'package:reservatior/shared/models/models.dart';

class SearchAndFiltersPage extends ConsumerStatefulWidget {
  const SearchAndFiltersPage({super.key});

  @override
  ConsumerState<SearchAndFiltersPage> createState() =>
      _SearchAndFiltersPageState();
}

class _SearchAndFiltersPageState extends ConsumerState<SearchAndFiltersPage> {
  bool _isHydrated = false;
  String _viewMode = 'grid'; // 'grid', 'list', 'map'
  String _sortBy = 'relevance';

  // Filter States
  List<String> _propertyTypes = [];
  List<String> _listingTypes = [];
  List<String> _selectedLocations = [];
  int _priceMin = 0;
  int _priceMax = 5000000;
  int _bedrooms = 0;
  int _bathrooms = 1;
  int _sizeMin = 0;
  int _sizeMax = 10000;
  List<String> _furnishing = [];
  List<String> _amenities = [];
  List<String> _propertyStatus = [];

  // Mock Data
  final List<FilterOption> _propertyTypeOptions = [
    FilterOption(id: 'residential', label: 'mobile.auto.residential'.tr(), value: 'residential'),
    FilterOption(id: 'commercial', label: 'mobile.auto.commercial'.tr(), value: 'commercial'),
    FilterOption(id: 'land', label: 'mobile.auto.land'.tr(), value: 'land'),
    FilterOption(id: 'hospitality', label: 'mobile.auto.hospitality'.tr(), value: 'hospitality'),
  ];

  final List<FilterOption> _listingTypeOptions = [
    FilterOption(id: 'sale', label: 'mobile.auto.for_sale'.tr(), value: 'sale'),
    FilterOption(id: 'rent', label: 'mobile.auto.for_rent'.tr(), value: 'rent'),
    FilterOption(id: 'booking', label: 'mobile.auto.for_booking'.tr(), value: 'booking'),
  ];

  final List<Location> _locations = [];

  final List<FilterOption> _amenityOptions = [
    FilterOption(id: 'parking', label: 'mobile.auto.parking'.tr(), value: 'parking'),
    FilterOption(id: 'gym', label: 'mobile.auto.gym'.tr(), value: 'gym'),
    FilterOption(id: 'pool', label: 'mobile.auto.swimming_pool'.tr(), value: 'pool'),
    FilterOption(id: 'security', label: 'mobile.auto.24_7_security'.tr(), value: 'security'),
    FilterOption(id: 'elevator', label: 'mobile.auto.elevator'.tr(), value: 'elevator'),
    FilterOption(id: 'garden', label: 'mobile.auto.garden'.tr(), value: 'garden'),
  ];

  final List<FilterOption> _statusOptions = [
    FilterOption(id: 'available', label: 'mobile.auto.available'.tr(), value: 'available'),
    FilterOption(id: 'reserved', label: 'mobile.auto.reserved'.tr(), value: 'reserved'),
    FilterOption(
      id: 'ready-to-move',
      label: 'mobile.auto.ready_to_move'.tr(),
      value: 'ready-to-move',
    ),
    FilterOption(
      id: 'under-construction',
      label: 'mobile.auto.under_construction'.tr(),
      value: 'under-construction',
    ),
  ];

  final List<SavedSearch> _savedSearches = [
    SavedSearch(
      id: '1',
      name: 'mobile.leftovers.2_bhk_in_manhattan'.tr(),
      filters: 'Manhattan • 2 Bedrooms • \$2K-\$4K',
      resultCount: 45,
      createdAt: '2026-01-15',
      notificationsEnabled: true,
    ),
    SavedSearch(
      id: '2',
      name: 'mobile.leftovers.luxury_penthouses'.tr(),
      filters: 'Brooklyn • 4+ Bedrooms • \$5M+',
      resultCount: 12,
      createdAt: '2026-01-20',
      notificationsEnabled: false,
    ),
  ];

  
  PropertyResult _mapListingToResult(Listing l) {
    return PropertyResult(
      id: l.id,
      title: l.title ?? 'Untitled',
      location: 'Location', // We can improve this if location obj exists
      price: (l.price ?? 0).toInt(),
      bedrooms: (l.property?.bedrooms ?? 0).toInt(),
      bathrooms: (l.property?.bathrooms ?? 0).toInt(),
      size: (l.property?.lotSizeSqFt ?? 0).toInt(),
      image: 'https://img.rocket.new/generatedImages/rocket_gen_img_18c6d33c5-1769432645647.png', // Placeholder
      alt: l.title ?? 'Image',
      propertyType: 'residential',
      listingType: l.type.name,
      featured: false,
    );
  }


  @override
  void initState() {
    super.initState();
    _isHydrated = true;
  }

  List<ActiveFilter> _getActiveFilters() {
    final filters = <ActiveFilter>[];

    _propertyTypes.forEach((type) {
      final option = _propertyTypeOptions.firstWhere((o) => o.value == type);
      filters.add(
        ActiveFilter(
          id: 'pt-$type',
          label: option.label,
          category: 'propertyType',
        ),
      );
    });

    _listingTypes.forEach((type) {
      final option = _listingTypeOptions.firstWhere((o) => o.value == type);
      filters.add(
        ActiveFilter(
          id: 'lt-$type',
          label: option.label,
          category: 'listingType',
        ),
      );
    });

    _selectedLocations.forEach((loc) {
      final location = _locations.firstWhere((l) => l.id == loc);
      filters.add(
        ActiveFilter(
          id: 'loc-$loc',
          label: location.addressLine1,
          category: 'location',
        ),
      );
    });

    if (_priceMin > 0 || _priceMax < 5000000) {
      filters.add(
        ActiveFilter(
          id: 'price',
          label:
              '\$${(_priceMin / 1000).toStringAsFixed(0)}K - \$${(_priceMax / 1000000).toStringAsFixed(1)}M',
          category: 'price',
        ),
      );
    }

    if (_bedrooms > 0) {
      filters.add(
        ActiveFilter(
          id: 'bedrooms',
          label: tr('mobile.auto.n_bedrooms', namedArgs: {'count': _bedrooms.toString()}),
          category: 'bedrooms',
        ),
      );
    }

    if (_bathrooms > 1) {
      filters.add(
        ActiveFilter(
          id: 'bathrooms',
          label: tr('mobile.auto.n_bathrooms', namedArgs: {'count': _bathrooms.toString()}),
          category: 'bathrooms',
        ),
      );
    }

    _furnishing.forEach((f) {
      filters.add(
        ActiveFilter(
          id: 'furn-$f',
          label: f.replaceAll('-', ' '),
          category: 'furnishing',
        ),
      );
    });

    _amenities.forEach((a) {
      final option = _amenityOptions.firstWhere((o) => o.value == a);
      filters.add(
        ActiveFilter(id: 'amen-$a', label: option.label, category: 'amenities'),
      );
    });

    _propertyStatus.forEach((s) {
      final option = _statusOptions.firstWhere((o) => o.value == s);
      filters.add(
        ActiveFilter(id: 'stat-$s', label: option.label, category: 'status'),
      );
    });

    return filters;
  }

  void _handleRemoveFilter(String filterId) {
    final parts = filterId.split('-');
    final category = parts[0];
    final value = parts.length > 1 ? parts[1] : '';

    switch (category) {
      case 'pt':
        setState(() => _propertyTypes.remove(value));
        break;
      case 'lt':
        setState(() => _listingTypes.remove(value));
        break;
      case 'loc':
        setState(() => _selectedLocations.remove(value));
        break;
      case 'price':
        setState(() {
          _priceMin = 0;
          _priceMax = 5000000;
        });
        break;
      case 'bedrooms':
        setState(() => _bedrooms = 0);
        break;
      case 'bathrooms':
        setState(() => _bathrooms = 1);
        break;
      case 'furn':
        setState(() => _furnishing.remove(value));
        break;
      case 'amen':
        setState(() => _amenities.remove(value));
        break;
      case 'stat':
        setState(() => _propertyStatus.remove(value));
        break;
    }
  }

  void _handleClearAllFilters() {
    setState(() {
      _propertyTypes = [];
      _listingTypes = [];
      _selectedLocations = [];
      _priceMin = 0;
      _priceMax = 5000000;
      _bedrooms = 0;
      _bathrooms = 1;
      _sizeMin = 0;
      _sizeMax = 10000;
      _furnishing = [];
      _amenities = [];
      _propertyStatus = [];
    });
  }

  void _handleLoadSearch(String searchId) {
    setState(() => _isHydrated = false);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isHydrated = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('mobile.search.saved_search_loaded'.tr())),
        );
      }
    });
  }

  void _handleDeleteSearch(String searchId) {
    setState(() {
      _savedSearches.removeWhere((search) => search.id == searchId);
    });
  }

  void _handleToggleNotifications(String searchId) {
    setState(() {
      final search = _savedSearches.firstWhere((s) => s.id == searchId);
      // search.notificationsEnabled =  !search.notificationsEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return Scaffold(
        backgroundColor: AppColors.darkBg,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 48, color: AppColors.gold),
              SizedBox(height: 16),
              Text('mobile.auto.loading_search'.tr(),
                style: TextStyle(
                  color: AppColors.textSecondaryDark,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final activeFilters = _getActiveFilters();
    final listingsAsync = ref.watch(listingListProvider);
    final resultCount = listingsAsync.when(
      data: (data) => data.length,
      loading: () => 0,
      error: (_, __) => 0,
    );
    final properties = listingsAsync.when(
      data: (data) => data.map(_mapListingToResult).toList(),
      loading: () => <PropertyResult>[],
      error: (_, __) => <PropertyResult>[],
    );

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text('mobile.auto.feature_property_title'.tr()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1024) {
            return _buildDesktopLayout(activeFilters, resultCount, properties);
          } else {
            return _buildMobileLayout(activeFilters, resultCount, properties);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(
    List<ActiveFilter> activeFilters,
    int resultCount,
    List<PropertyResult> properties,
  ) {
    return Row(
      children: [
        // Filters Sidebar
        SizedBox(
          width: 320,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterHeader(activeFilters),
                  SizedBox(height: 16),
                  SavedSearchesWidget(
                    searches: _savedSearches,
                    onLoadSearch: _handleLoadSearch,
                    onDeleteSearch: _handleDeleteSearch,
                    onToggleNotifications: _handleToggleNotifications,
                  ),
                  SizedBox(height: 16),
                  FilterSectionWidget(
                    title: 'mobile.auto.property_type'.tr(),
                    icon: Icons.home_work,
                    options: _propertyTypeOptions,
                    selectedValues: _propertyTypes,
                    onSelectionChange: (values) =>
                        setState(() => _propertyTypes = values),
                  ),
                  SizedBox(height: 16),
                  FilterSectionWidget(
                    title: 'mobile.auto.listing_type'.tr(),
                    icon: Icons.tag,
                    options: _listingTypeOptions,
                    selectedValues: _listingTypes,
                    onSelectionChange: (values) =>
                        setState(() => _listingTypes = values),
                  ),
                  SizedBox(height: 16),
                  PriceRangeSliderWidget(
                    minPrice: 0,
                    maxPrice: 5000000,
                    currentMin: _priceMin,
                    currentMax: _priceMax,
                    onRangeChange: (min, max) => setState(() {
                      _priceMin = min;
                      _priceMax = max;
                    }),
                  ),
                  SizedBox(height: 16),
                  LocationFilterWidget(
                    locations: const [],
                    selectedLocations: _selectedLocations,
                    onLocationChange: (locations) =>
                        setState(() => _selectedLocations = locations),
                  ),
                  SizedBox(height: 16),
                  PropertySpecsFilterWidget(
                    bedrooms: _bedrooms,
                    bathrooms: _bathrooms,
                    minSize: _sizeMin,
                    maxSize: _sizeMax,
                    furnishing: _furnishing,
                    onBedroomsChange: (value) =>
                        setState(() => _bedrooms = value),
                    onBathroomsChange: (value) =>
                        setState(() => _bathrooms = value),
                    onSizeChange: (min, max) => setState(() {
                      _sizeMin = min;
                      _sizeMax = max;
                    }),
                    onFurnishingChange: (values) =>
                        setState(() => _furnishing = values),
                  ),
                  SizedBox(height: 16),
                  FilterSectionWidget(
                    title: 'mobile.auto.amenities'.tr(),
                    icon: Icons.star,
                    options: _amenityOptions,
                    selectedValues: _amenities,
                    onSelectionChange: (values) =>
                        setState(() => _amenities = values),
                  ),
                  SizedBox(height: 16),
                  FilterSectionWidget(
                    title: 'mobile.auto.property_status'.tr(),
                    icon: Icons.check_circle,
                    options: _statusOptions,
                    selectedValues: _propertyStatus,
                    onSelectionChange: (values) =>
                        setState(() => _propertyStatus = values),
                  ),
                  SizedBox(height: 16),
                  _buildSaveSearchButton(),
                ],
              ),
            ),
          ),
        ),

        // Results Section
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ActiveFiltersBarWidget(
                  filters: activeFilters,
                  onRemoveFilter: _handleRemoveFilter,
                  onClearAll: _handleClearAllFilters,
                  resultCount: resultCount,
                ),
                SizedBox(height: 16),
                _buildResultsHeader(resultCount),
                SizedBox(height: 16),
                if (_viewMode == 'map') _buildMapView(properties),
                if (_viewMode == 'list') Expanded(
                  child: ListView.builder(
                    itemCount: properties.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildListCard(properties[index]),
                    ),
                  ),
                ),
                if (_viewMode == 'grid') Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: properties.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) => PropertyResultCardWidget(
                      property: properties[index],
                      onTap: () => context.push('/properties/${properties[index].id}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(List<ActiveFilter> activeFilters, int resultCount, List<PropertyResult> properties) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildFilterHeader(activeFilters),
          SizedBox(height: 16),
          SavedSearchesWidget(
            searches: _savedSearches,
            onLoadSearch: _handleLoadSearch,
            onDeleteSearch: _handleDeleteSearch,
            onToggleNotifications: _handleToggleNotifications,
          ),
          SizedBox(height: 16),
          FilterSectionWidget(
            title: 'mobile.auto.property_type'.tr(),
            icon: Icons.home_work,
            options: _propertyTypeOptions,
            selectedValues: _propertyTypes,
            onSelectionChange: (values) =>
                setState(() => _propertyTypes = values),
          ),
          SizedBox(height: 16),
          FilterSectionWidget(
            title: 'mobile.auto.listing_type'.tr(),
            icon: Icons.tag,
            options: _listingTypeOptions,
            selectedValues: _listingTypes,
            onSelectionChange: (values) =>
                setState(() => _listingTypes = values),
          ),
          SizedBox(height: 16),
          PriceRangeSliderWidget(
            minPrice: 0,
            maxPrice: 5000000,
            currentMin: _priceMin,
            currentMax: _priceMax,
            onRangeChange: (min, max) => setState(() {
              _priceMin = min;
              _priceMax = max;
            }),
          ),
          SizedBox(height: 16),
          LocationFilterWidget(
            locations: const [],
            selectedLocations: _selectedLocations,
            onLocationChange: (locations) =>
                setState(() => _selectedLocations = locations),
          ),
          SizedBox(height: 16),
          PropertySpecsFilterWidget(
            bedrooms: _bedrooms,
            bathrooms: _bathrooms,
            minSize: _sizeMin,
            maxSize: _sizeMax,
            furnishing: _furnishing,
            onBedroomsChange: (value) => setState(() => _bedrooms = value),
            onBathroomsChange: (value) => setState(() => _bathrooms = value),
            onSizeChange: (min, max) => setState(() {
              _sizeMin = min;
              _sizeMax = max;
            }),
            onFurnishingChange: (values) =>
                setState(() => _furnishing = values),
          ),
          SizedBox(height: 16),
          FilterSectionWidget(
            title: 'mobile.auto.amenities'.tr(),
            icon: Icons.star,
            options: _amenityOptions,
            selectedValues: _amenities,
            onSelectionChange: (values) => setState(() => _amenities = values),
          ),
          SizedBox(height: 16),
          FilterSectionWidget(
            title: 'mobile.auto.property_status'.tr(),
            icon: Icons.check_circle,
            options: _statusOptions,
            selectedValues: _propertyStatus,
            onSelectionChange: (values) =>
                setState(() => _propertyStatus = values),
          ),
          SizedBox(height: 16),
          _buildSaveSearchButton(),
          SizedBox(height: 16),
          ActiveFiltersBarWidget(
            filters: activeFilters,
            onRemoveFilter: _handleRemoveFilter,
            onClearAll: _handleClearAllFilters,
            resultCount: resultCount,
          ),
          SizedBox(height: 16),
          _buildResultsHeader(resultCount),
          SizedBox(height: 16),
          if (_viewMode == 'map') _buildMapView(properties),
          if (_viewMode == 'list')
            ...properties.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildListCard(p),
            )),
          if (_viewMode == 'grid')
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: properties.length,
              itemBuilder: (context, index) => PropertyResultCardWidget(
                property: properties[index],
                onTap: () => context.push('/properties/${properties[index].id}'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterHeader(List<ActiveFilter> activeFilters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('mobile.auto.filters'.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryDark,
          ),
        ),
        if (activeFilters.isNotEmpty)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _handleClearAllFilters,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text('mobile.auto.clear_all'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.gold,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSaveSearchButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('mobile.search.search_saved'.tr())),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gold.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bookmark, size: 20, color: AppColors.gold),
              SizedBox(width: 8),
              Text('mobile.auto.save_this_search'.tr(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsHeader(int resultCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              tr('mobile.auto.n_results', namedArgs: {'count': resultCount.toString()}),
              style: TextStyle(
                color: AppColors.textPrimaryDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 16),
            _buildViewToggle(Icons.grid_view_rounded, 'grid'),
            SizedBox(width: 6),
            _buildViewToggle(Icons.format_list_bulleted_rounded, 'list'),
            SizedBox(width: 6),
            _buildViewToggle(Icons.map_outlined, 'map'),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.darkBorder.withOpacity(0.3),
            ),
          ),
          child: DropdownButton<String>(
            value: _sortBy,
            underline: SizedBox.shrink(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondaryDark,
            ),
            items: [
              DropdownMenuItem(value: 'relevance', child: Text('mobile.auto.relevance'.tr())),
              DropdownMenuItem(
                value: 'price-low',
                child: Text('mobile.auto.price_low_to_high'.tr()),
              ),
              DropdownMenuItem(
                value: 'price-high',
                child: Text('mobile.auto.price_high_to_low'.tr()),
              ),
              DropdownMenuItem(value: 'newest', child: Text('mobile.auto.newest_first'.tr())),
              DropdownMenuItem(
                value: 'size-large',
                child: Text('mobile.auto.size_largest_first'.tr()),
              ),
            ],
            onChanged: (value) => setState(() => _sortBy = value!),
            style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildViewToggle(IconData icon, String mode) {
    final isActive = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.darkCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive
                ? AppColors.primary
                : AppColors.darkBorder.withOpacity(0.3),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isActive ? Colors.white : AppColors.textSecondaryDark,
        ),
      ),
    );
  }

  Widget _buildMapView(List<PropertyResult> properties) {
    return Container(
      height: 400,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: PropertyMapView(
          propertyMarkers: properties.map((p) => PropertyMarker(
            id: p.id,
            title: p.title,
            price: p.price.toString(),
            latitude: 41.0082, // Placeholder
            longitude: 28.9784, // Placeholder
            propertyType: p.propertyType,
            imageUrl: p.image,
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildListCard(PropertyResult property) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Left: Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: SizedBox(
              width: 130,
              height: 130,
              child: Image.network(
                property.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.darkSurface,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Right: Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (property.featured)
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('mobile.auto.featured'.tr(),
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  Text(
                    property.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondaryDark,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property.location,
                          style: TextStyle(
                            color: AppColors.textSecondaryDark,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildSpecBadge(
                        Icons.bed_rounded,
                        '${property.bedrooms}',
                      ),
                      SizedBox(width: 8),
                      _buildSpecBadge(
                        Icons.bathtub_outlined,
                        '${property.bathrooms}',
                      ),
                      SizedBox(width: 8),
                      _buildSpecBadge(
                        Icons.square_foot_rounded,
                        '${property.size} sqft',
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${(property.price.toInt() / 1000000).toStringAsFixed(2)}M',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecBadge(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textSecondaryDark),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: AppColors.textSecondaryDark, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
