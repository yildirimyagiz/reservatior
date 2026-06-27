import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class PropertyResult {
  final String id;
  final String title;
  final String location;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int size;
  final String image;
  final String alt;
  final String propertyType;
  final String listingType;
  final bool featured;

  PropertyResult({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.image,
    required this.alt,
    required this.propertyType,
    required this.listingType,
    required this.featured,
  });
}

class PropertyResultCardWidget extends StatelessWidget {
  final PropertyResult property;
  final VoidCallback? onTap;

  const PropertyResultCardWidget({
    super.key,
    required this.property,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildImageSection(), _buildContentSection()],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Stack(
        children: [
          Container(
            height: 192,
            width: double.infinity,
            color: AppColors.darkSurface,
            child: Image.network(
              property.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.darkSurface,
                  child: Icon(
                    Icons.home,
                    size: 48,
                    color: AppColors.textSecondaryDark,
                  ),
                );
              },
            ),
          ),

          if (property.featured)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text('mobile.auto.featured'.tr(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.darkCard.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.darkBorder.withOpacity(0.3),
                ),
              ),
              child: Text(
                property.listingType,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndPrice(),
          const SizedBox(height: 8),
          _buildLocation(),
          const SizedBox(height: 12),
          _buildSpecifications(),
        ],
      ),
    );
  }

  Widget _buildTitleAndPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            property.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$${property.price.toString()}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: AppColors.textSecondaryDark),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            property.location,
            style: TextStyle(fontSize: 14, color: AppColors.textSecondaryDark),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecifications() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          _buildSpecItem(Icons.bed, '${property.bedrooms} bed'),
          const SizedBox(width: 16),
          _buildSpecItem(Icons.bathtub, '${property.bathrooms} bath'),
          const SizedBox(width: 16),
          _buildSpecItem(Icons.square_foot, '${property.size} sqft'),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondaryDark),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: AppColors.textPrimaryDark),
        ),
      ],
    );
  }
}
