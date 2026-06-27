import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:reservatior/features/client/filters/widgets/applied_filters_widget.dart';
import 'package:reservatior/features/client/filters/widgets/filter_panel_widget.dart';
import 'package:reservatior/features/client/filters/widgets/list_view_widget.dart';
import 'package:reservatior/features/client/filters/widgets/location_search_widget.dart';
import 'package:reservatior/features/client/filters/widgets/map_view_widget.dart';

class SearchAndFilters extends StatefulWidget {
  const SearchAndFilters({Key? key}) : super(key: key);

  @override
  State<SearchAndFilters> createState() => _SearchAndFiltersState();
}

class _SearchAndFiltersState extends State<SearchAndFilters> {
  final TextEditingController _searchController = TextEditingController();
  bool _isMapView = true;
  bool _showFilterPanel = false;

  // Filter state
  Map<String, dynamic> _appliedFilters = {
    'priceRange': {'min': 0.0, 'max': 5000000.0},
    'currency': 'USD',
    'propertyTypes': <String>[],
    'bedrooms': null,
    'bathrooms': null,
    'facilities': <String>[],
    'videoFreshness': 'all',
    'agentVerified': false,
    'listingAge': 'all',
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleView() {
    setState(() {
      _isMapView = !_isMapView;
    });
  }

  void _toggleFilterPanel() {
    setState(() {
      _showFilterPanel = !_showFilterPanel;
    });
  }

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _appliedFilters = filters;
      _showFilterPanel = false;
    });
  }

  void _removeFilter(String filterKey) {
    setState(() {
      if (filterKey == 'propertyTypes' || filterKey == 'facilities') {
        _appliedFilters[filterKey] = <String>[];
      } else if (filterKey == 'bedrooms' || filterKey == 'bathrooms') {
        _appliedFilters[filterKey] = null;
      } else if (filterKey == 'priceRange') {
        _appliedFilters[filterKey] = {'min': 0.0, 'max': 5000000.0};
      } else {
        _appliedFilters[filterKey] = filterKey == 'agentVerified'
            ? false
            : 'all';
      }
    });
  }

  void _clearAllFilters() {
    setState(() {
      _appliedFilters = {
        'priceRange': {'min': 0.0, 'max': 5000000.0},
        'currency': 'USD',
        'propertyTypes': <String>[],
        'bedrooms': null,
        'bathrooms': null,
        'facilities': <String>[],
        'videoFreshness': 'all',
        'agentVerified': false,
        'listingAge': 'all',
      };
    });
  }

  void _onSearchChanged(String query) {
    // Debounced search implementation would go here
    // For now, just update the UI
    setState(() {});
  }

  void _onPropertyTap(Map<String, dynamic> property) {
    Navigator.of(context, rootNavigator: true).pushNamed('/property-details');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar with Search
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LocationSearchWidget(
                          controller: _searchController,
                          onSearchChanged: _onSearchChanged,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      // Map/List Toggle Button
                      Container(
                        width: 12.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(
                            _isMapView ? Icons.list : Icons.map,
                            color: theme.colorScheme.onPrimary,
                            size: 24,
                          ),
                          onPressed: _toggleView,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      // Filter Button
                      Container(
                        width: 12.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.tune,
                            color: theme.colorScheme.onSecondary,
                            size: 24,
                          ),
                          onPressed: _toggleFilterPanel,
                        ),
                      ),
                    ],
                  ),
                  // Applied Filters
                  if (_appliedFilters['propertyTypes'].isNotEmpty ||
                      _appliedFilters['bedrooms'] != null ||
                      _appliedFilters['bathrooms'] != null ||
                      _appliedFilters['facilities'].isNotEmpty ||
                      _appliedFilters['videoFreshness'] != 'all' ||
                      _appliedFilters['agentVerified'] == true ||
                      _appliedFilters['listingAge'] != 'all')
                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: AppliedFiltersWidget(
                        filters: _appliedFilters,
                        onRemoveFilter: _removeFilter,
                        onClearAll: _clearAllFilters,
                      ),
                    ),
                ],
              ),
            ),
            // Content Area
            Expanded(
              child: Stack(
                children: [
                  // Map or List View
                  _isMapView
                      ? MapViewWidget(
                          filters: _appliedFilters,
                          onPropertyTap: _onPropertyTap,
                        )
                      : ListViewWidget(
                          filters: _appliedFilters,
                          onPropertyTap: _onPropertyTap,
                        ),
                  // Filter Panel
                  if (_showFilterPanel)
                    FilterPanelWidget(
                      currentFilters: _appliedFilters,
                      onApplyFilters: _applyFilters,
                      onClose: () => setState(() => _showFilterPanel = false),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
