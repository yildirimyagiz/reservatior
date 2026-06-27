import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_discovery_screen.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_details_screen.dart';
import 'package:reservatior/shared/providers/property_provider.dart';

class PropertyPage extends ConsumerWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PropertyDiscoveryScreen();
  }
}

class PropertyDetailsPage extends ConsumerWidget {
  final String propertyId;

  const PropertyDetailsPage({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PropertyDetailsScreen(propertyId: propertyId);
  }
}

// Property Management Page (Admin)
class PropertyAdminPage extends ConsumerWidget {
  const PropertyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mobile.auto.feature_property_title'.tr()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNewProperty(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Cards
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'mobile.leftovers.total_properties'.tr(),
                    '128',
                    Icons.home,
                    Colors.blue,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'mobile.leftovers.active_listings'.tr(),
                    '89',
                    Icons.list,
                    Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Pending',
                    '12',
                    Icons.pending,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Property List with Admin Actions
          Expanded(
            child: ref
                .watch(propertyListProvider)
                .when(
                  loading: () =>
                      Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('${'admin.shared.connectionError'.tr()}: $error')),
                  data: (properties) => ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return PropertyAdminTile(
                        property: property,
                        onEdit: () => _editProperty(context, property),
                        onDelete: () => _deleteProperty(context, property),
                        onView: () => _viewProperty(context, property),
                      );
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewProperty(BuildContext context) {
    // Navigate to add property form
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('mobile.auto.add_property_functionality_coming_soon'.tr())),
    );
  }

  void _editProperty(BuildContext context, dynamic property) {
    // Navigate to edit property form
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${'mobile.admin.edit'.tr()} ${property.name ?? 'property'}")),
    );
  }

  void _deleteProperty(BuildContext context, dynamic property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('mobile.auto.delete_property'.tr()),
        content: Text(
          'Are you sure you want to delete "${property.name ?? 'this property'}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('mobile.auto.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              // Delete property logic
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('mobile.auto.property_deleted'.tr())));
            },
            child: Text('mobile.auto.delete'.tr(), style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _viewProperty(BuildContext context, dynamic property) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${'mobile.admin.view'.tr()} ${property.name ?? 'property'}")),
    );
  }
}

class PropertyAdminTile extends StatelessWidget {
  final dynamic property;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onView;

  const PropertyAdminTile({
    super.key,
    required this.property,
    required this.onEdit,
    required this.onDelete,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.home),
        ),
        title: Text(property.name ?? 'mobile.leftovers.unknown_property'.tr()),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(property.addressLine1 ?? 'mobile.leftovers.no_address'.tr()),
            SizedBox(height: 4),
            Row(
              children: [
                Chip(
                  label: Text(property.listingStatus ?? 'Unknown'),
                  backgroundColor: _getStatusColor(property.listingStatus),
                ),
                SizedBox(width: 8),
                Text(
                  '\$${property.listingPrice?.toStringAsFixed(0) ?? 'N/A'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility),
                  SizedBox(width: 8),
                  Text('mobile.auto.view'.tr()),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('mobile.auto.edit'.tr()),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('mobile.auto.delete'.tr(), style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'view':
                onView();
                break;
              case 'edit':
                onEdit();
                break;
              case 'delete':
                onDelete();
                break;
            }
          },
        ),
        onTap: onView,
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'available':
        return Colors.green.shade100;
      case 'pending':
        return Colors.orange.shade100;
      case 'sold':
        return Colors.red.shade100;
      case 'rented':
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
}
