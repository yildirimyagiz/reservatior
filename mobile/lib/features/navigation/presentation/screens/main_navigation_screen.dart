import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: Text('mobile.auto.navigation'.tr(),
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
      ),
      body: Center(
        child: Text('mobile.auto.navigation'.tr(),
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
      ),
    );
  }
}
