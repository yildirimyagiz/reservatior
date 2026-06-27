import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class DiscoveryCategoriesWidget extends StatelessWidget {
  const DiscoveryCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'mobile.leftovers.luxury_homes'.tr(),
        'icon': Icons.diamond,
        'color': Colors.purple,
        'count': 234,
      },
      {
        'name': 'Apartments',
        'icon': Icons.apartment,
        'color': Colors.blue,
        'count': 567,
      },
      {
        'name': 'Villas',
        'icon': Icons.villa,
        'color': Colors.green,
        'count': 123,
      },
      {
        'name': 'Townhouses',
        'icon': Icons.home,
        'color': Colors.orange,
        'count': 89,
      },
      {
        'name': 'Penthouses',
        'icon': Icons.location_city,
        'color': Colors.red,
        'count': 45,
      },
      {
        'name': 'Waterfront',
        'icon': Icons.beach_access,
        'color': Colors.cyan,
        'count': 78,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.explore_categories'.tr(),
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Categories Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(category);
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Navigate to category page
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                (category['color'] as Color).withOpacity(0.1),
                (category['color'] as Color).withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (category['color'] as Color).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (category['color'] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  category['icon'] as IconData,
                  size: 24,
                  color: category['color'] as Color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category['name'] as String,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${category['count']} properties',
                style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
