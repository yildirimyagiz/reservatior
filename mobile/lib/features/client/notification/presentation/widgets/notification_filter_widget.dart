import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationFilterWidget extends StatelessWidget {
  final String selectedFilter;
  final String searchQuery;
  final Function(String) onFilterChanged;
  final Function(String) onSearchChanged;

  const NotificationFilterWidget({
    super.key,
    required this.selectedFilter,
    required this.searchQuery,
    required this.onFilterChanged,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        border: Border(
          bottom: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'mobile.auto.search_notifications'.tr(),
              hintStyle: const TextStyle(color: AppColors.darkMuted),
              prefixIcon: Icon(Icons.search, color: AppColors.darkMuted),
              filled: true,
              fillColor: AppColors.darkSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(color: AppColors.textPrimaryDark),
          ),
          SizedBox(height: 12),

          // Filter Chips
          Text('mobile.auto.filter_by_type'.tr(),
            style: TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip('all', 'All'),
              _buildFilterChip('message', 'Messages'),
              _buildFilterChip('property', 'Properties'),
              _buildFilterChip('booking', 'Bookings'),
              _buildFilterChip('payment', 'Payments'),
              _buildFilterChip('document', 'Documents'),
              _buildFilterChip('system', 'System'),
              _buildFilterChip('alert', 'Alerts'),
              _buildFilterChip('task', 'Tasks'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = selectedFilter == value;

    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.darkBg : AppColors.textSecondaryDark,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          onFilterChanged(value);
        }
      },
      backgroundColor: AppColors.darkSurface,
      selectedColor: AppColors.gold,
      checkmarkColor: AppColors.darkBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.gold : AppColors.darkBorder,
          width: 1,
        ),
      ),
    );
  }
}
