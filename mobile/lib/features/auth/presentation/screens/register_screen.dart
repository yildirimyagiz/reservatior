import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Register',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Register',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
