import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Change Password',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Change Password',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
