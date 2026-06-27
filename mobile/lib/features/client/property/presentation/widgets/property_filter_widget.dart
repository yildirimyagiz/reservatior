import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/enums/property_category.dart';
import 'package:reservatior/shared/enums/listing_type.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyFilterWidget extends ConsumerStatefulWidget {
  const PropertyFilterWidget({super.key});

  @override
  ConsumerState<PropertyFilterWidget> createState() =>
      _PropertyFilterWidgetState();
}

class _PropertyFilterWidgetState extends ConsumerState<PropertyFilterWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Filter Header
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('mobile.auto.filters'.tr()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: _resetFilters,
                  child: Text('mobile.auto.reset'.tr()),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                ),
              ],
            ),
          ),

          // Expandable Filter Content
          if (_isExpanded) ...[
            Divider(height: 1),
            Container(
              height: 200,
              padding: EdgeInsets.all(16),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicFilters(),
                  _buildPriceFilters(),
                  _buildFeatureFilters(),
                ],
              ),
            ),
          ],

          // Active Filter Chips
          if (_isExpanded) _buildActiveFilters(),
        ],
      ),
    );
  }

  Widget _buildBasicFilters() {
    return Column(
      children: [
        // Property Type
        Text('mobile.auto.property_type'.tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PropertyCategory.values.map((category) {
            return FilterChip(
              label: Text(category.name),
              selected: ref.watch(propertyFilterProvider).category == category,
              onSelected: (selected) {
                ref.read(propertyFilterProvider.notifier).updateCategory(selected ? category : null);
              },
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        // Listing Type
        Text('mobile.auto.listing_type'.tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ListingType.values.map((type) {
            return FilterChip(
              label: Text(type.name),
              selected: ref.watch(propertyFilterProvider).listingType == type,
              onSelected: (selected) {
                ref.read(propertyFilterProvider.notifier).updateListingType(selected ? type : null);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceFilters() {
    final filterState = ref.watch(propertyFilterProvider);

    return Column(
      children: [
        Text('mobile.auto.price_range'.tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'mobile.auto.min_price'.tr(),
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final minPrice = double.tryParse(value);
                  ref
                      .read(propertyFilterProvider.notifier)
                      .updatePriceRange(minPrice, filterState.maxPrice);
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'mobile.auto.max_price'.tr(),
                  border: OutlineInputBorder(),
                  prefixText: '\$',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final maxPrice = double.tryParse(value);
                  ref
                      .read(propertyFilterProvider.notifier)
                      .updatePriceRange(filterState.minPrice, maxPrice);
                },
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        // Price Range Slider
        Text('mobile.auto.quick_select'.tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildPriceChip('mobile.auto.under_100k'.tr(), 0, 100000),
            _buildPriceChip('mobile.auto.100k_250k'.tr(), 100000, 250000),
            _buildPriceChip('mobile.auto.250k_500k'.tr(), 250000, 500000),
            _buildPriceChip('mobile.auto.500k_1m'.tr(), 500000, 1000000),
            _buildPriceChip('mobile.auto.over_1m'.tr(), 1000000, null),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureFilters() {
    return Column(
      children: [
        Text('mobile.auto.bedrooms'.tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Any', '1+', '2+', '3+', '4+', '5+'].map((bedrooms) {
            return FilterChip(
              label: Text(bedrooms == 'Any' ? 'mobile.auto.any'.tr() : bedrooms),
              selected: ref.watch(propertyFilterProvider).bedrooms == bedrooms,
              onSelected: (selected) {
                ref
                    .read(propertyFilterProvider.notifier)
                    .updateBedrooms(selected ? bedrooms : null);
              },
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        Text('mobile.auto.bathrooms'.tr(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Any', '1+', '2+', '3+'].map((bathrooms) {
            return FilterChip(
              label: Text(bathrooms == 'Any' ? 'mobile.auto.any'.tr() : bathrooms),
              selected:
                  ref.watch(propertyFilterProvider).bathrooms == bathrooms,
              onSelected: (selected) {
                ref
                    .read(propertyFilterProvider.notifier)
                    .updateBathrooms(selected ? bathrooms : null);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceChip(String label, double? min, double? max) {
    return FilterChip(
      label: Text(label),
      selected:
          ref.watch(propertyFilterProvider).minPrice == min &&
          ref.watch(propertyFilterProvider).maxPrice == max,
      onSelected: (selected) {
        ref.read(propertyFilterProvider.notifier).updatePriceRange(min, max);
      },
    );
  }

  Widget _buildActiveFilters() {
    final filterState = ref.watch(propertyFilterProvider);
    final activeFilters = <Widget>[];

    if (filterState.minPrice != null || filterState.maxPrice != null) {
      final min = filterState.minPrice ?? 0;
      final max = filterState.maxPrice ?? 9999999;
      activeFilters.add(
        Chip(
          label: Text('\$${min.toStringAsFixed(0)} - \$$max'),
          onDeleted: () => ref
              .read(propertyFilterProvider.notifier)
              .updatePriceRange(null, null),
        ),
      );
    }

    if (filterState.bedrooms != null) {
      activeFilters.add(
        Chip(
          label: Text(tr('mobile.auto.n_bedrooms_exact', namedArgs: {'count': filterState.bedrooms.toString()})),
          onDeleted: () =>
              ref.read(propertyFilterProvider.notifier).updateBedrooms(null),
        ),
      );
    }

    if (filterState.bathrooms != null) {
      activeFilters.add(
        Chip(
          label: Text(tr('mobile.auto.n_bathrooms_exact', namedArgs: {'count': filterState.bathrooms.toString()})),
          onDeleted: () =>
              ref.read(propertyFilterProvider.notifier).updateBathrooms(null),
        ),
      );
    }

    if (filterState.category != null) {
      activeFilters.add(
        Chip(
          label: Text(filterState.category!.name),
          onDeleted: () =>
              ref.read(propertyFilterProvider.notifier).updateCategory(null),
        ),
      );
    }

    if (filterState.listingType != null) {
      activeFilters.add(
        Chip(
          label: Text(filterState.listingType!.name),
          onDeleted: () =>
              ref.read(propertyFilterProvider.notifier).updateListingType(null),
        ),
      );
    }

    if (activeFilters.isEmpty) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(spacing: 8, runSpacing: 8, children: activeFilters),
    );
  }

  void _resetFilters() {
    ref.read(propertyFilterProvider.notifier).resetFilters();
  }
}
