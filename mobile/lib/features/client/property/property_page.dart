import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_discovery_screen.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_details_screen.dart';

class PropertyPage extends ConsumerWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PropertyDiscoveryScreen();
  }
}

class PropertyDetailsPage extends ConsumerWidget {
  final String propertyId;

  const PropertyDetailsPage({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PropertyDetailsScreen(propertyId: propertyId);
  }
}
