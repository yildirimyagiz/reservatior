import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/property_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:easy_localization/easy_localization.dart';

class AdvancedSearchWidget extends ConsumerWidget {
  const AdvancedSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(propertyFilterProvider);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
            child: Row(
              children: [
                Icon(
                  Icons.tune_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
                SizedBox(width: 12),
                Text('mobile.auto.neural_filters'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () =>
                      ref.read(propertyFilterProvider.notifier).resetFilters(),
                  child: Text('mobile.auto.reset'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(color: Colors.white.withOpacity(0.05)),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('mobile.leftovers.property_type'.tr()),
                  SizedBox(height: 16),
                  _buildPropertyTypeGrid(ref, (filterState as dynamic).propertyType),

                  SizedBox(height: 32),
                  _buildSectionLabel('mobile.leftovers.price_range'.tr()),
                  SizedBox(height: 16),
                  _buildPriceSection(
                    ref,
                    filterState.minPrice,
                    filterState.maxPrice,
                  ),

                  SizedBox(height: 32),
                  _buildSectionLabel('CONFIGURATION'),
                  SizedBox(height: 16),
                  _buildCounterSection(
                    ref,
                    (filterState as dynamic).minBedrooms,
                    (filterState as dynamic).minBathrooms,
                  ),

                  SizedBox(height: 32),
                  _buildSectionLabel('mobile.leftovers.location_insights'.tr()),
                  SizedBox(height: 16),
                  _buildLocationSearch(),

                  SizedBox(height: 40),

                  // Apply Button
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text('mobile.auto.activate_filters'.tr(),
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.outfit(
        color: Colors.white38,
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildPropertyTypeGrid(WidgetRef ref, PropertyType? selectedType) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: PropertyType.values.map((type) {
        final isSelected = selectedType == type;
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.darkSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.05),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home,
                  size: 14,
                  color: isSelected ? AppColors.primary : Colors.white54,
                ),
                SizedBox(width: 8),
                Text(
                  type.name,
                  style: GoogleFonts.outfit(
                    color: isSelected ? Colors.white : Colors.white54,
                    fontSize: 12,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceSection(WidgetRef ref, double? min, double? max) {
    return Row(
      children: [
        Expanded(
          child: _buildPriceInput(
            'MIN',
            (val) {},
            min?.toString() ?? '',
          ),
        ),
        SizedBox(width: 16),
        Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white10,
          size: 16,
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildPriceInput(
            'MAX',
            (val) {},
            max?.toString() ?? '',
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInput(
    String label,
    Function(String) onChanged,
    String initialValue,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white24,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: '0',
              hintStyle: TextStyle(color: Colors.white10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterSection(WidgetRef ref, int? beds, int? baths) {
    return Row(
      children: [
        Expanded(
          child: _buildCounter(
            'BEDS',
            beds ?? 0,
            (v) {},
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildCounter(
            'BATHS',
            (baths ?? 0).toInt(),
            (v) {},
          ),
        ),
      ],
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              _counterBtn(
                Icons.remove,
                () => value > 0 ? onChanged(value - 1) : null,
              ),
              SizedBox(width: 12),
              Text(
                value.toString(),
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12),
              _counterBtn(Icons.add, () => onChanged(value + 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _counterBtn(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: Colors.white70),
      ),
    );
  }

  Widget _buildLocationSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.map_rounded, color: AppColors.primary, size: 18),
          SizedBox(width: 12),
          Text('Select Target Radius',
            style: GoogleFonts.outfit(color: Colors.white24, fontSize: 14),
          ),
          Spacer(),
          Icon(Icons.chevron_right_rounded, color: Colors.white24),
        ],
      ),
    );
  }

  IconData _getTypeIcon(PropertyType type) {
    switch (type) {
      case PropertyType.APARTMENT:
        return Icons.apartment_rounded;
      case PropertyType.VILLA:
        return Icons.villa_rounded;
      default:
        return Icons.business_rounded;
    }
  }
}
