import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationSearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSearchChanged;

  const LocationSearchWidget({
    super.key,
    required this.controller,
    required this.onSearchChanged,
  });

  @override
  State<LocationSearchWidget> createState() => _LocationSearchWidgetState();
}

class _LocationSearchWidgetState extends State<LocationSearchWidget> {
  bool _showSuggestions = false;
  final List<Map<String, dynamic>> _recentSearches = [
    {'location': 'mobile.leftovers.downtown_dubai'.tr(), 'type': 'Area', 'icon': Icons.location_city},
    {'location': 'mobile.leftovers.marina_bay'.tr(), 'type': 'District', 'icon': Icons.water_drop},
    {'location': 'mobile.leftovers.palm_jumeirah'.tr(), 'type': 'Island', 'icon': Icons.beach_access},
  ];

  final List<Map<String, dynamic>> _suggestions = [
    {
      'location': 'mobile.leftovers.business_bay_dubai'.tr(),
      'type': 'Area',
      'icon': Icons.location_city,
      'distance': 'mobile.leftovers.2_3_km'.tr(),
    },
    {
      'location': 'mobile.leftovers.dubai_marina'.tr(),
      'type': 'District',
      'icon': Icons.water_drop,
      'distance': 'mobile.leftovers.5_1_km'.tr(),
    },
    {
      'location': 'mobile.leftovers.jumeirah_beach_residence'.tr(),
      'type': 'Area',
      'icon': Icons.beach_access,
      'distance': 'mobile.leftovers.6_8_km'.tr(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: 6.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline, width: 1),
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {
                _showSuggestions = value.isNotEmpty;
              });
              widget.onSearchChanged(value);
            },
            onTap: () {
              setState(() {
                _showSuggestions = true;
              });
            },
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'mobile.auto.search_location'.tr(),
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(2.w),
                child: Icon(
                  Icons.search,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      onPressed: () {
                        widget.controller.clear();
                        setState(() {
                          _showSuggestions = false;
                        });
                        widget.onSearchChanged('');
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Icon(
                        Icons.my_location,
                        color: theme.colorScheme.secondary,
                        size: 20,
                      ),
                    ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 1.5.h,
              ),
            ),
          ),
        ),
        if (_showSuggestions)
          Container(
            margin: EdgeInsets.only(top: 1.h),
            constraints: BoxConstraints(maxHeight: 40.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 1.h),
              children: [
                if (widget.controller.text.isEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    child: Text('mobile.auto.recent_searches'.tr(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  ..._recentSearches.map(
                    (search) => _buildSearchItem(
                      context,
                      theme,
                      search['location'] as String,
                      search['type'] as String,
                      search['icon'] as IconData,
                      null,
                      true,
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    child: Text('mobile.auto.suggestions'.tr(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  ..._suggestions.map(
                    (suggestion) => _buildSearchItem(
                      context,
                      theme,
                      suggestion['location'] as String,
                      suggestion['type'] as String,
                      suggestion['icon'] as IconData,
                      suggestion['distance'] as String?,
                      false,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSearchItem(
    BuildContext context,
    ThemeData theme,
    String location,
    String type,
    IconData icon,
    String? distance,
    bool isRecent,
  ) {
    return InkWell(
      onTap: () {
        widget.controller.text = location;
        setState(() {
          _showSuggestions = false;
        });
        widget.onSearchChanged(location);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, color: theme.colorScheme.secondary, size: 20),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    type,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (distance != null)
              Text(
                distance,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            if (isRecent)
              Icon(
                Icons.history,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
