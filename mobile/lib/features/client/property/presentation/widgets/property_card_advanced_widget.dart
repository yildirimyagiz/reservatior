import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';

enum PropertyViewType { grid, list, map }

class PropertyCardAdvancedWidget extends ConsumerStatefulWidget {
  final Property property;
  final PropertyViewType viewType;
  final VoidCallback onTap;

  const PropertyCardAdvancedWidget({
    super.key,
    required this.property,
    required this.viewType,
    required this.onTap,
  });

  @override
  ConsumerState<PropertyCardAdvancedWidget> createState() =>
      _PropertyCardAdvancedWidgetState();
}

class _PropertyCardAdvancedWidgetState
    extends ConsumerState<PropertyCardAdvancedWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    switch (widget.viewType) {
      case PropertyViewType.grid:
        return _buildGridCard();
      case PropertyViewType.list:
        return _buildListCard();
      case PropertyViewType.map:
        return _buildMapCard();
    }
  }

  Widget _buildGridCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 200.ms,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageStack(aspectRatio: 4 / 3),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceAndStatus(),
                    const SizedBox(height: 12),
                    _buildPropertyName(fontSize: 16),
                    const SizedBox(height: 4),
                    _buildLocation(fontSize: 12),
                    const SizedBox(height: 16),
                    _buildFeaturesRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: _buildImageStack(borderRadius: 16),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPriceAndStatus(isCompact: true),
                      const SizedBox(height: 8),
                      _buildPropertyName(fontSize: 15),
                      const SizedBox(height: 4),
                      _buildLocation(fontSize: 11),
                      const SizedBox(height: 12),
                      _buildFeaturesRow(isCompact: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapCard() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: _buildImageStack(aspectRatio: 16 / 9),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceAndStatus(isCompact: true),
                const SizedBox(height: 4),
                _buildPropertyName(fontSize: 13),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageStack({double? aspectRatio, double borderRadius = 0}) {
    final photo = widget.property.propertyPhotos.isNotEmpty
        ? widget.property.propertyPhotos.first.url
        : null;

    Widget img = photo != null
        ? CachedNetworkImage(
            imageUrl: photo,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.05),
              highlightColor: Colors.white12,
              child: Container(color: Colors.white),
            ),
            errorWidget: (context, url, err) => Container(
              color: Colors.white.withOpacity(0.05),
              child: const Icon(
                Icons.broken_image_rounded,
                color: Colors.white10,
              ),
            ),
          )
        : Container(
            color: Colors.white.withOpacity(0.05),
            child: const Icon(Icons.home_work_rounded, color: Colors.white10),
          );

    if (aspectRatio != null)
      img = AspectRatio(aspectRatio: aspectRatio, child: img);
    if (borderRadius > 0)
      img = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: img,
      );

    return Stack(
      children: [
        Positioned.fill(child: img),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildPriceAndStatus({bool isCompact = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '₺${widget.property.listingPrice?.toStringAsFixed(0) ?? 'TBD'}',
          style: GoogleFonts.outfit(
            color: AppColors.primary,
            fontSize: isCompact ? 16 : 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.property.listingType?.name.toUpperCase() ?? 'NONE',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyName({required double fontSize}) {
    return Text(
      widget.property.name,
      style: GoogleFonts.outfit(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLocation({required double fontSize}) {
    return Row(
      children: [
        const Icon(Icons.location_on_rounded, size: 12, color: Colors.white24),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            widget.property.city,
            style: TextStyle(color: Colors.white38, fontSize: fontSize),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesRow({bool isCompact = false}) {
    return Row(
      children: [
        _feature(
          Icons.king_bed_rounded,
          widget.property.bedrooms?.toString() ?? '0',
        ),
        const SizedBox(width: 12),
        _feature(
          Icons.shower_rounded,
          widget.property.bathrooms?.toString() ?? '0',
        ),
        const SizedBox(width: 12),
        _feature(
          Icons.square_foot_rounded,
          '${widget.property.areaSqm?.toStringAsFixed(0) ?? '0'}m²',
        ),
      ],
    );
  }

  Widget _feature(IconData icon, String val) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white24),
        const SizedBox(width: 4),
        Text(
          val,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
