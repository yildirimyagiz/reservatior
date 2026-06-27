import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class PropertyOverviewWidget extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyOverviewWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Description'),
          SizedBox(height: 1.5.h),
          Text(
            property['description'] ??
                'mobile.leftovers.no_description_available_for_this_proper'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white70,
              height: 1.6,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4.h),
          _buildSectionHeader('mobile.leftovers.key_features'.tr()),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: (property['features'] as List<dynamic>? ?? []).map((
              feature,
            ) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Text(
                  feature,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.outfit(
        color: AppColors.gold,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 2.0,
      ),
    );
  }
}
