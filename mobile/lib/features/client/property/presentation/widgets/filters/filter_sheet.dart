import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:reservatior/features/client/property/presentation/providers/property_filter_provider.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(propertyFilterProvider);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 12.w,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('mobile.auto.filters'.tr(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () =>
                    ref.read(propertyFilterProvider.notifier).clear(),
                child: Text('mobile.auto.reset'.tr(), style: TextStyle(color: AppColors.gold)),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: ListView(
              children: [
                _buildSectionTitle('mobile.leftovers.property_type'.tr()),
                SizedBox(height: 1.5.h),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: PropertyType.values.map((type) {
                    final isSelected = filters.types.contains(type);
                    return GestureDetector(
                      onTap: () => ref
                          .read(propertyFilterProvider.notifier)
                          .toggleType(type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.gold
                              : AppColors.darkSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.gold
                                : AppColors.darkBorder,
                          ),
                        ),
                        child: Text(
                          type.name.toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 4.h),
                _buildSectionTitle('mobile.leftovers.price_range'.tr()),
                SizedBox(height: 2.h),
                RangeSlider(
                  values: RangeValues(
                    filters.minPrice ?? 0,
                    filters.maxPrice ?? 10000000,
                  ),
                  min: 0,
                  max: 10000000,
                  divisions: 100,
                  activeColor: AppColors.gold,
                  inactiveColor: Colors.white10,
                  labels: RangeLabels(
                    '\$${(filters.minPrice ?? 0).toInt()}',
                    '\$${(filters.maxPrice ?? 10000000).toInt()}',
                  ),
                  onChanged: (values) {
                    ref
                        .read(propertyFilterProvider.notifier)
                        .setPriceRange(values.start, values.end);
                  },
                ),
                SizedBox(height: 4.h),
                _buildSectionTitle('Bedrooms'),
                SizedBox(height: 1.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final beds = index == 5 ? null : index;
                    final label = index == 5
                        ? 'Any'
                        : (index == 0 ? 'Studio' : '$index');
                    final isSelected = filters.minBedrooms == beds;
                    return GestureDetector(
                      onTap: () => ref
                          .read(propertyFilterProvider.notifier)
                          .setBedrooms(beds),
                      child: Container(
                        width: 14.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.gold
                              : AppColors.darkSurface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.gold
                                : AppColors.darkBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text('mobile.auto.apply_filters'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.outfit(
        color: Colors.white54,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 2.0,
      ),
    );
  }
}
