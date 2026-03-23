import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Profile',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Profile',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
