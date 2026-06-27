import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_list_screen.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_details_screen.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/enums/listing_status.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyAdminPage extends ConsumerWidget {
  const PropertyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(propertyListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'mobile.property_admin.title'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.primary,
            ),
            onPressed: () => _addNewProperty(context),
          ),
        ],
      ),
      body: propertiesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stack) => Center(
          child: Text(
            '${'mobile.property_admin.syncError'.tr()}$error',
            style: const TextStyle(color: Colors.white54),
          ),
        ),
        data: (properties) {
          // Calculate Real Stats
          final activeCount = properties
              .where((p) => p.listingStatus == ListingStatus.AVAILABLE)
              .length;
          final pendingCount = properties
              .where((p) => p.listingStatus == ListingStatus.RESERVED)
              .length;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Stats Grid
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'mobile.property_admin.total'.tr(),
                          properties.length.toString(),
                          Icons.inventory_2_rounded,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'mobile.property_admin.active'.tr(),
                          activeCount.toString(),
                          Icons.bolt_rounded,
                          Colors.green,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'mobile.property_admin.reserved'.tr(),
                          pendingCount.toString(),
                          Icons.timer_rounded,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Property List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final property = properties[index];
                    return PropertyAdminTile(
                          property: property,
                          onEdit: () => _editProperty(context, property),
                          onDelete: () =>
                              _deleteProperty(context, ref, property),
                          onView: () =>
                              context.push('/property/${property.id}'),
                        )
                        .animate()
                        .fadeIn(delay: (index * 50).ms)
                        .slideX(begin: 0.05);
                  }, childCount: properties.length),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.white24,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  void _addNewProperty(BuildContext context) {
    context.push('/property/create');
  }

  void _editProperty(BuildContext context, Property property) {
    context.push('/property/edit/${property.id}');
  }

  void _deleteProperty(BuildContext context, WidgetRef ref, Property property) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        title: Text(
          'mobile.property_admin.decommission'.tr(),
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        content: Text(
          'mobile.property_admin.decommissionPrompt'.tr(),
          style: const TextStyle(color: Colors.white60),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('mobile.property_admin.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement actual delete call via provider
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('mobile.property_admin.decommissionSent'.tr())),
              );
            },
            child: Text('mobile.property_admin.delete'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class PropertyAdminTile extends StatelessWidget {
  final Property property;
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onView,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.darkBg,
                    borderRadius: BorderRadius.circular(16),
                    image: property.propertyPhotos.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              property.propertyPhotos.first.url,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: property.propertyPhotos.isEmpty
                      ? const Icon(
                          Icons.home_work_rounded,
                          color: Colors.white10,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.name,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        property.addressLine1,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                property.listingStatus,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              property.listingStatus.name,
                              style: TextStyle(
                                color: _getStatusColor(property.listingStatus),
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '₺${property.listingPrice?.toStringAsFixed(0) ?? 'N/A'}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white54,
                  ),
                  color: AppColors.darkSurface,
                  itemBuilder: (ctx) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_rounded,
                            color: Colors.white70,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text('mobile.property_admin.edit'.tr(), style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_rounded,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'mobile.property_admin.deleteMenu'.tr(),
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (val) {
                    if (val == 'edit') onEdit();
                    if (val == 'delete') onDelete();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ListingStatus status) {
    switch (status) {
      case ListingStatus.AVAILABLE:
        return Colors.green;
      case ListingStatus.RESERVED:
        return Colors.orange;
      case ListingStatus.SOLD:
        return Colors.red;
      case ListingStatus.RENTED:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
