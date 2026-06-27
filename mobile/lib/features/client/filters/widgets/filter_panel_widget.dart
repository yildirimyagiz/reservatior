import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class FilterPanelWidget extends StatelessWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;
  final VoidCallback onClose;

  const FilterPanelWidget({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('mobile.auto.filters'.tr(), style: theme.textTheme.titleLarge),
              IconButton(icon: Icon(Icons.close), onPressed: onClose),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                // Simplified filter options for stub
                ListTile(
                  title: Text('mobile.auto.reset_all'.tr()),
                  onTap: () => onApplyFilters({
                    'priceRange': {'min': 0.0, 'max': 5000000.0},
                    'currency': 'USD',
                    'propertyTypes': <String>[],
                    'bedrooms': null,
                    'bathrooms': null,
                    'facilities': <String>[],
                    'videoFreshness': 'all',
                    'agentVerified': false,
                    'listingAge': 'all',
                  }),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onClose,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 6.h),
            ),
            child: Text('mobile.auto.apply'.tr()),
          ),
        ],
      ),
    );
  }
}
