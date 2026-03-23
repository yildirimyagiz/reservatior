import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class EmailQueueScreen extends StatelessWidget {
  const EmailQueueScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(backgroundColor: AppColors.darkBg,
          title: const Text('EmailQueue',
              style: const TextStyle(color: AppColors.textPrimaryDark))),
      body: const Center(child: Text('Coming Soon',
          style: TextStyle(color: AppColors.textSecondaryDark))),
    );
  }
}
