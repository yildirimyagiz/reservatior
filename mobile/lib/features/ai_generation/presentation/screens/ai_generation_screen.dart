import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class AiGenerationScreen extends StatelessWidget {
  const AiGenerationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(backgroundColor: AppColors.darkBg,
          title: const Text('AiGeneration',
              style: TextStyle(color: AppColors.textPrimaryDark))),
      body: const Center(child: Text('Coming Soon',
          style: TextStyle(color: AppColors.textSecondaryDark))),
    );
  }
}
