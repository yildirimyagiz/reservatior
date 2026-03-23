import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Navigation',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Navigation',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
