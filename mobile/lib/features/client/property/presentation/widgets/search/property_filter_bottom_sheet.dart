import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:reservatior/shared/enums/listing_type.dart';
import 'package:reservatior/features/client/property/presentation/providers/property_search_provider.dart';

class PropertyFilterBottomSheet extends ConsumerWidget {
  const PropertyFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(propertySearchFiltersProvider);
    final notifier = ref.read(propertySearchFiltersProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, notifier),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('mobile.leftovers.property_type'.tr()),
                  const SizedBox(height: 12),
                  _buildChipList<PropertyType>(
                    values: PropertyType.values,
                    selectedValues: filters.propertyTypes,
                    onToggle: (v) => notifier.togglePropertyType(v),
                    labelProvider: (v) => v.name.replaceAll('_', ' '),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('mobile.leftovers.price_range'.tr()),
                  _buildPriceSlider(filters, notifier),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Bedrooms'),
                  _buildBedroomSlider(filters, notifier),
                  const SizedBox(height: 24),
                  _buildSectionTitle('mobile.leftovers.listing_type'.tr()),
                  _buildChipList<ListingType>(
                    values: ListingType.values,
                    selectedValues: filters.listingTypes,
                    onToggle: (v) => {}, // Implement similar toggles if needed
                    labelProvider: (v) => v.name,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('mobile.leftovers.other_filters'.tr()),
                  _buildSwitchRow(
                    'mobile.leftovers.featured_only'.tr(),
                    filters.featuredOnly,
                    (v) => {},
                  ),
                  _buildSwitchRow(
                    'mobile.leftovers.verified_only'.tr(),
                    filters.verifiedOnly,
                    (v) => {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PropertySearchNotifier notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('mobile.auto.filters'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () => notifier.clearFilters(),
          child: Text('mobile.auto.clear_all'.tr(),
            style: GoogleFonts.outfit(
              color: AppColors.primaryLight,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildChipList<T>({
    required List<T> values,
    required List<T> selectedValues,
    required Function(T) onToggle,
    required String Function(T) labelProvider,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: values.map((value) {
        final isSelected = selectedValues.contains(value);
        return FilterChip(
          selected: isSelected,
          label: Text(
            labelProvider(value),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : Colors.white60,
            ),
          ),
          backgroundColor: AppColors.darkMuted.withOpacity(0.3),
          selectedColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? AppColors.primaryLight : Colors.white10,
            ),
          ),
          onSelected: (_) => onToggle(value),
          showCheckmark: false,
        );
      }).toList(),
    );
  }

  Widget _buildPriceSlider(
    PropertySearchFilters filters,
    PropertySearchNotifier notifier,
  ) {
    return Column(
      children: [
        RangeSlider(
          values: RangeValues(filters.minPrice, filters.maxPrice),
          min: 0,
          max: 10000000,
          divisions: 100,
          activeColor: AppColors.primaryLight,
          inactiveColor: AppColors.darkMuted,
          onChanged: (values) =>
              notifier.setPriceRange(values.start, values.end),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${(filters.minPrice / 1000).toStringAsFixed(0)}k',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
            Text(
              '\$${(filters.maxPrice / 1000000).toStringAsFixed(1)}M',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBedroomSlider(
    PropertySearchFilters filters,
    PropertySearchNotifier notifier,
  ) {
    return Column(
      children: [
        RangeSlider(
          values: RangeValues(
            filters.minBedrooms.toDouble(),
            filters.maxBedrooms.toDouble(),
          ),
          min: 0,
          max: 10,
          divisions: 10,
          activeColor: AppColors.primaryLight,
          inactiveColor: AppColors.darkMuted,
          onChanged: (values) => notifier.setBedroomRange(
            values.start.round(),
            values.end.round(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${filters.minBedrooms}',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
            Text(
              '${filters.maxBedrooms}+',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchRow(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.primaryLight,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),
      child: Text('mobile.auto.show_results'.tr(),
        style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
