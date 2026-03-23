import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CommunicationScreen extends StatelessWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Communication',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Communication',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
