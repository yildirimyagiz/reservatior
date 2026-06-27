import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PropertyAdminPage extends ConsumerWidget {
  const PropertyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          'mobile.auto.admin_property_control'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      body: Column(
        children: [
          // Stats Nodes (Neural Hub Style)
          _buildNeuralStats(),

          Expanded(
            child: ref
                .watch(propertyListProvider)
                .when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text('${'admin.error.connection'.tr()}: $error'),
                  ),
                  data: (properties) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      final property = properties[index];
                      return _buildAdminNode(context, property, index);
                    },
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralStats() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _statNode('128', 'admin.property.total'.tr(), Colors.blueAccent),
          SizedBox(width: 12),
          _statNode('89', 'admin.property.active'.tr(), Colors.greenAccent),
          SizedBox(width: 12),
          _statNode('12', 'admin.property.pending'.tr(), Colors.orangeAccent),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1);
  }

  Widget _statNode(String val, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Text(
              val,
              style: GoogleFonts.outfit(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: Colors.white24,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminNode(BuildContext context, Property property, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          property.name,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          property.addressLine1 ?? 'admin.property.noAddress'.tr(),
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
        trailing: const Icon(Icons.more_vert, color: Colors.white38),
        onTap: () {},
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.05);
  }

  void _addNewProperty(BuildContext context) {
    // Add logic
  }
}
