import 'package:flutter/material.dart';
import '../../domain/entities/mls_entity.dart';
import '../bloc/mls_bloc.dart';
import './mls_property_card_widget.dart';

class MLSPropertyListWidget extends StatelessWidget {
  final List<MLSProperty> properties;
  final Future<void> Function() onRefresh;
  final Function(MLSProperty) onEdit;
  final Function(MLSProperty) onDelete;
  final Function(MLSProperty) onSyndicate;
  final Function(MLSProperty) onToggleStatus;

  const MLSPropertyListWidget({
    Key? key,
    required this.properties,
    required this.onRefresh,
    required this.onEdit,
    required this.onDelete,
    required this.onSyndicate,
    required this.onToggleStatus,
  }) : super(key: key);

  
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_work,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No MLS properties found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your first MLS Property to get started',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final Property = properties[index];
          return MLSPropertyCardWidget(
            Property: Property,
            onEdit: () => onEdit(Property),
            onDelete: () => onDelete(Property),
            onSyndicate: () => onSyndicate(Property),
            onToggleStatus: () => onToggleStatus(Property),
            onTap: () => _showPropertyDetails(context, Property),
          );
        },
      ),
    );
  }

  void _showPropertyDetails(BuildContext context, MLSProperty Property) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Property Details',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Address', Property.address),
                      _buildDetailRow('Type', Property.type.displayName),
                      _buildDetailRow('Status', Property.status.displayName),
                      _buildDetailRow('Price', Property.displayPrice),
                      _buildDetailRow('Bedrooms', '${Property.bedrooms}'),
                      _buildDetailRow('Bathrooms', '${Property.bathrooms}'),
                      _buildDetailRow('Square Feet', '${Property.squareFeet}'),
                      _buildDetailRow('Days on Market', Property.displayDaysOnMarket),
                      _buildDetailRow('Listing Date', Property.listingDate.toString().split(' ')[0]),
                      _buildDetailRow('Views', '${Property.views}'),
                      _buildDetailRow('Leads', '${Property.leads}'),
                      _buildDetailRow('Syndicated', Property.isSyndicated ? 'Yes' : 'No'),
                      if (Property.platforms.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Platforms:',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          children: Property.platforms.map((platform) {
                            return Chip(
                              label: Text(platform.displayName),
                              backgroundColor: platform.color.withOpacity(0.1),
                              side: BorderSide(color: platform.color.withOpacity(0.3)),
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Text(
                        'Metadata:',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          Property.metadata.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onSyndicate(Property);
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Syndicate'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onToggleStatus(Property);
                      },
                      icon: Icon(Property.isActive ? Icons.pause : Icons.play_arrow),
                      label: Text(Property.isActive ? 'Deactivate' : 'Activate'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onEdit(Property);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onDelete(Property);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
