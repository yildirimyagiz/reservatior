import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/features/client/home/presentation/screens/home_screen.dart';

/// Legacy Home Page - Now redirects to the new modular HomeScreen
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
