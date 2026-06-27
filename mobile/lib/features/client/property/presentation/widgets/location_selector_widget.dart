import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/property/presentation/providers/property_filter_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/filters/filter_sheet.dart';

class LocationSelectorWidget extends ConsumerWidget {
  const LocationSelectorWidget({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => const FilterSheet(),
      ),
    );
  }

  void _showLocationPicker(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(propertyFilterProvider);
    final locations = [
      'mobile.leftovers.dubai_marina'.tr(),
      'mobile.leftovers.downtown_dubai'.tr(),
      'mobile.leftovers.palm_jumeirah'.tr(),
      'mobile.leftovers.business_bay'.tr(),
      'mobile.leftovers.arabian_ranches'.tr(),
      'mobile.leftovers.dubai_hills'.tr(),
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        title: Text('mobile.auto.select_location'.tr(),
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final loc = locations[index];
              final isSelected = filters.location == loc;
              return ListTile(
                title: Text(
                  loc,
                  style: TextStyle(
                    color: isSelected ? AppColors.gold : Colors.white70,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: AppColors.gold)
                    : null,
                onTap: () {
                  ref.read(propertyFilterProvider.notifier).setLocation(loc);
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(propertyFilterProvider);
    final theme = Theme.of(context);

    int filterCount = 0;
    if (filters.types.isNotEmpty) filterCount++;
    if (filters.minPrice != null || filters.maxPrice != null) filterCount++;
    if (filters.minBedrooms != null) filterCount++;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        border: Border(
          bottom: BorderSide(color: AppColors.darkBorder.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showLocationPicker(context, ref),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  border: Border.all(color: AppColors.darkBorder),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.gold,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        filters.location ?? 'mobile.leftovers.select_location'.tr(),
                        style: GoogleFonts.outfit(
                          color: filters.location != null
                              ? Colors.white
                              : Colors.white38,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white24,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          GestureDetector(
            onTap: () => _showFilterSheet(context),
            child: Container(
              padding: EdgeInsets.all(1.2.h),
              decoration: BoxDecoration(
                color: filterCount > 0 ? AppColors.gold : AppColors.darkSurface,
                border: Border.all(
                  color: filterCount > 0
                      ? AppColors.gold
                      : AppColors.darkBorder,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.tune,
                    color: filterCount > 0 ? Colors.black : Colors.white,
                    size: 20,
                  ),
                  if (filterCount > 0)
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$filterCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
}
