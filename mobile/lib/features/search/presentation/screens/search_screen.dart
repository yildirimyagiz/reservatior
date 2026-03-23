import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: const Text('Search',
            style: TextStyle(color: AppColors.textPrimaryDark)),
      ),
      body: const Center(
        child: Text('Search',
            style: TextStyle(color: AppColors.textSecondaryDark)),
      ),
    );
  }
}
