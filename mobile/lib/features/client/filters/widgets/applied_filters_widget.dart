import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppliedFiltersWidget extends StatelessWidget {
  final Map<String, dynamic> filters;
  final Function(String) onRemoveFilter;
  final VoidCallback onClearAll;

  const AppliedFiltersWidget({
    super.key,
    required this.filters,
    required this.onRemoveFilter,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> filterChips = [];

    // Property Types
    final propertyTypes = filters['propertyTypes'] as List<String>? ?? [];
    if (propertyTypes.isNotEmpty) {
      for (var type in propertyTypes) {
        filterChips.add(
          _buildFilterChip(context, theme, type, 'propertyTypes'),
        );
      }
    }

    // Bedrooms
    if (filters['bedrooms'] != null) {
      filterChips.add(
        _buildFilterChip(
          context,
          theme,
          '${filters['bedrooms']} Beds',
          'bedrooms',
        ),
      );
    }

    // Bathrooms
    if (filters['bathrooms'] != null) {
      filterChips.add(
        _buildFilterChip(
          context,
          theme,
          '${filters['bathrooms']} Baths',
          'bathrooms',
        ),
      );
    }

    // Facilities
    final facilities = filters['facilities'] as List<String>? ?? [];
    if (facilities.isNotEmpty) {
      for (var facility in facilities) {
        filterChips.add(
          _buildFilterChip(context, theme, facility, 'facilities'),
        );
      }
    }

    // Video Freshness
    final videoFreshness = filters['videoFreshness'] as String? ?? 'all';
    if (videoFreshness != 'all' && videoFreshness.isNotEmpty) {
      filterChips.add(
        _buildFilterChip(
          context,
          theme,
          'Video: ${videoFreshness[0].toUpperCase()}${videoFreshness.substring(1)}',
          'videoFreshness',
        ),
      );
    }

    // Agent Verified
    if (filters['agentVerified'] == true) {
      filterChips.add(
        _buildFilterChip(context, theme, 'mobile.leftovers.verified_agents'.tr(), 'agentVerified'),
      );
    }

    // Listing Age
    final listingAge = filters['listingAge'] as String? ?? 'all';
    if (listingAge != 'all' && listingAge.isNotEmpty) {
      filterChips.add(
        _buildFilterChip(
          context,
          theme,
          'Listed: ${listingAge[0].toUpperCase()}${listingAge.substring(1)}',
          'listingAge',
        ),
      );
    }

    if (filterChips.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 5.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...filterChips,
          // Clear All Button
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: ActionChip(
              label: Text('mobile.auto.clear_all'.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              avatar: Icon(
                Icons.clear_all,
                color: theme.colorScheme.error,
                size: 16,
              ),
              onPressed: onClearAll,
              backgroundColor: theme.colorScheme.error.withOpacity(0.1),
              side: BorderSide(color: theme.colorScheme.error, width: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    ThemeData theme,
    String label,
    String filterKey,
  ) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Chip(
        label: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: Icon(
          Icons.close,
          color: theme.colorScheme.onSurface,
          size: 16,
        ),
        onDeleted: () => onRemoveFilter(filterKey),
        backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
        side: BorderSide(color: theme.colorScheme.secondary, width: 1),
      ),
    );
  }
}
