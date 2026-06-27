import 'package:flutter/material.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/enums/listing_status.dart';
import 'package:reservatior/shared/enums/property_type.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PropertyCardWidget extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  final bool isList;

  const PropertyCardWidget({
    super.key,
    required this.property,
    required this.onTap,
    this.isList = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.darkSurface.withOpacity(0.4),
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.darkBorder.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isList ? _buildListLayout(context) : _buildGridLayout(context),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildListLayout(BuildContext context) {
    return Row(
      children: [
        // Property Image
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            children: [
              Hero(
                tag: 'prop_image_${property.id}',
                child: Image.network(
                  property.photos.isNotEmpty
                      ? property.photos.first.url
                      : 'https://picsum.photos/400',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: AppColors.darkMuted,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white24,
                    ),
                  ),
                ),
              ),
              Positioned(top: 4, left: 4, child: _buildStatusBadge()),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      property.name,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  if (false == true)
                    const Icon(Icons.verified, color: Colors.blue, size: 14),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.white38,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${property.city}, ${property.country}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white38,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${property.currency} ${property.listingPrice?.toStringAsFixed(0) ?? 'mobile.auto.n_a'.tr()}',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  _buildPropertyFeatures(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGridLayout(BuildContext context) {
    // Basic grid implementation
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Image.network(
            property.photos.isNotEmpty
                ? property.photos.first.url
                : 'https://picsum.photos/400',
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          property.name,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatusBadge() {
    Color color = Colors.grey;
    switch (property.listingStatus) {
      case ListingStatus.AVAILABLE:
        color = Colors.green;
        break;
      case ListingStatus.RESERVED:
        color = Colors.yellow;
        break;
      case ListingStatus.SOLD:
        color = Colors.red;
        break;
      case ListingStatus.RENTED:
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: color.withOpacity(0.5), width: 0.5),
      ),
      child: Text(
        'mobile.auto.status_${property.listingStatus.name.toLowerCase()}'.tr(),
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPropertyFeatures() {
    return Row(
      children: [
        _featureIcon(Icons.bed, property.bedrooms?.toString() ?? '0'),
        const SizedBox(width: 8),
        _featureIcon(
          Icons.bathtub,
          property.bathrooms?.toStringAsFixed(0) ?? '0',
        ),
        const SizedBox(width: 8),
        _featureIcon(
          Icons.square_foot,
          '${property.areaSqm?.toStringAsFixed(0) ?? '0'}',
        ),
      ],
    );
  }

  Widget _featureIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white24, size: 10),
        const SizedBox(width: 2),
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 10, color: Colors.white60),
        ),
      ],
    );
  }
}
