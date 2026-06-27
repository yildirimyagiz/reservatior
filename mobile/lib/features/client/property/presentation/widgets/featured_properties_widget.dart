import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'property_card_advanced_widget.dart';

class FeaturedPropertiesWidget extends ConsumerWidget {
  final List<Property> properties;

  const FeaturedPropertiesWidget({super.key, required this.properties});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredProperties = properties.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('mobile.auto.featured_properties'.tr(),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () {
                // View all featured properties
              },
              child: Text('mobile.auto.view_all'.tr(),
                style: GoogleFonts.inter(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Featured Properties Carousel
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: featuredProperties.length,
            itemBuilder: (context, index) {
              final property = featuredProperties[index];
              return Container(
                width: 320,
                margin: const EdgeInsets.only(right: 16),
                child: PropertyCardAdvancedWidget(
                  property: property,
                  viewType: PropertyViewType.grid,
                  onTap: () => _navigateToProperty(context, property),
                ),
              );
            },
          ),
        ),

        // Featured Badge
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
              SizedBox(width: 8),
              Text('mobile.auto.handpicked_by_our_experts_based_on_location_amenities_and_value'.tr(),
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToProperty(BuildContext context, Property property) {
    // Navigate to property details
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${'mobile.admin.viewing'.tr()} ${property.name}")));
  }
}
