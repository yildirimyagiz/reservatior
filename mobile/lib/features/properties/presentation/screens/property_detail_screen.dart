import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PropertyDetailScreen extends StatelessWidget {
  final String propertyId;
  const PropertyDetailScreen({super.key, required this.propertyId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(backgroundColor: AppColors.darkBg,
          title: const Text('Property Detail', style: TextStyle(color: AppColors.textPrimaryDark))),
      body: Center(child: Text('Property: ${propertyId}', style: const TextStyle(color: AppColors.textSecondaryDark))),
    );
  }
}
