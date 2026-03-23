import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Forgot Password',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Forgot Password',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
