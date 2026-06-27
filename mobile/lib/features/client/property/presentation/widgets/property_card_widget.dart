import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';

enum PropertyViewType { grid, list, map }

class PropertyCardWidget extends ConsumerWidget {
  final Property property;
  final PropertyViewType viewType;
  final VoidCallback onTap;
  final VoidCallback? onSave;
  final VoidCallback? onShare;
  final VoidCallback? onHide;
  final VoidCallback? onReport;

  const PropertyCardWidget({
    super.key,
    required this.property,
    required this.viewType,
    required this.onTap,
    this.onSave,
    this.onShare,
    this.onHide,
    this.onReport,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref
        .watch(propertyFavoritesProvider.notifier)
        .isFavorite(property.id);

    switch (viewType) {
      case PropertyViewType.grid:
        return _buildGridCard(context, ref, isFavorite);
      case PropertyViewType.list:
        return _buildListCard(context, ref, isFavorite);
      case PropertyViewType.map:
        return _buildMapCard(context, ref, isFavorite);
    }
  }

  Widget _buildGridCard(BuildContext context, WidgetRef ref, bool isFavorite) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      color: Colors.grey[200],
                    ),
                    child:
                        property.photos != null && property.photos!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              property.photos!.first.url ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.home,
                                    color: Colors.grey,
                                    size: 48,
                                  ),
                                );
                              },
                            ),
                          )
                        : const Icon(Icons.home, color: Colors.grey, size: 48),
                  ),

                  // Status Badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(property.listingStatus?.name),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        property.listingStatus?.name ?? 'Available',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 20,
                        ),
                        onPressed: () => _toggleFavorite(ref),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.name ?? 'Property',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      property.addressLine1 ?? 'Address',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    if (property.listingPrice != null)
                      Text(
                        '\$${property.listingPrice!.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (property.bedrooms != null)
                          _buildFeatureIcon(Icons.bed, '${property.bedrooms}'),
                        if (property.bathrooms != null)
                          _buildFeatureIcon(
                            Icons.bathtub,
                            '${property.bathrooms}',
                          ),
                        if (property.areaSqm != null)
                          _buildFeatureIcon(
                            Icons.square_foot,
                            '${property.areaSqm}m²',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context, WidgetRef ref, bool isFavorite) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: property.photos != null && property.photos!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          property.photos!.first.url ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.home,
                              color: Colors.grey,
                              size: 48,
                            );
                          },
                        ),
                      )
                    : const Icon(Icons.home, color: Colors.grey, size: 48),
              ),

              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            property.name ?? 'Property',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => _toggleFavorite(ref),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      property.addressLine1 ?? 'Address',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    if (property.listingPrice != null)
                      Text(
                        '\$${property.listingPrice!.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    const Spacer(),
                    Row(
                      children: [
                        if (property.bedrooms != null)
                          _buildFeatureIcon(Icons.bed, '${property.bedrooms}'),
                        if (property.bathrooms != null)
                          _buildFeatureIcon(
                            Icons.bathtub,
                            '${property.bathrooms}',
                          ),
                        if (property.areaSqm != null)
                          _buildFeatureIcon(
                            Icons.square_foot,
                            '${property.areaSqm}m²',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapCard(BuildContext context, WidgetRef ref, bool isFavorite) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      property.name ?? 'Property',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                    onPressed: () => _toggleFavorite(ref),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                property.addressLine1 ?? 'Address',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (property.listingPrice != null) ...[
                const SizedBox(height: 4),
                Text(
                  '\$${property.listingPrice!.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'sold':
        return Colors.red;
      case 'rented':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _toggleFavorite(WidgetRef ref) {
    ref.read(propertyFavoritesProvider.notifier).toggleFavorite(property.id);
  }
}
