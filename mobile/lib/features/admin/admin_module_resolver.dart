import 'package:flutter/material.dart';
import 'package:reservatior/features/admin/account/account_management_screen.dart';
import 'package:reservatior/features/admin/booking/booking_management_screen.dart';
import 'package:reservatior/features/admin/dashboard/dashboard_management_screen.dart';
import 'package:reservatior/features/admin/dynamic/dynamic_admin_screen.dart';
import 'package:reservatior/features/admin/favorite/favorite_management_screen.dart';
import 'package:reservatior/features/admin/guest/guest_management_screen.dart';
import 'package:reservatior/features/admin/guest_profile/guest_profile_management_screen.dart';
import 'package:reservatior/features/admin/home/home_management_screen.dart';
import 'package:reservatior/features/admin/listing/listing_management_screen.dart';
import 'package:reservatior/features/admin/location/location_management_screen.dart';
import 'package:reservatior/features/admin/marketplace/marketplace_management_screen.dart';
import 'package:reservatior/features/admin/message/message_management_screen.dart';
import 'package:reservatior/features/admin/notification/notification_management_screen.dart';
import 'package:reservatior/features/admin/payment/payment_management_screen.dart';
import 'package:reservatior/features/admin/photo/photo_management_screen.dart';
import 'package:reservatior/features/admin/property/property_management_screen.dart';
import 'package:reservatior/features/admin/reservation/reservation_management_screen.dart';
import 'package:reservatior/features/admin/review/review_management_screen.dart';
import 'package:reservatior/features/admin/user/user_management_screen.dart';
import 'package:reservatior/features/admin/video_content/video_content_management_screen.dart';
import 'package:reservatior/features/client/tenant/presentation/pages/tenant_admin_page.dart';

/// Resolves `/admin/:model` routes to the canonical admin screen.
///
/// Two tiers:
/// 1. Models with a dedicated management screen under `features/admin/*`
///    map directly to that widget.
/// 2. Everything else falls back to `DynamicAdminScreen`, which renders a
///    generic CRUD view backed by `GET /admin/dynamic/schema|data/:model`.
class AdminModuleResolver {
  AdminModuleResolver._();

  static final Map<String, Widget Function()> _dedicatedScreens = {
    'account': () => const AccountManagementScreen(),
    'booking': () => const BookingManagementScreen(),
    'dashboard': () => const DashboardManagementScreen(),
    'favorite': () => const FavoriteManagementScreen(),
    'guest': () => const GuestManagementScreen(),
    'guest-profile': () => const GuestProfileManagementScreen(),
    'home': () => const HomeManagementScreen(),
    'listing': () => const ListingManagementScreen(),
    'location': () => const LocationManagementScreen(),
    'marketplace': () => const MarketplaceManagementScreen(),
    'message': () => const MessageManagementScreen(),
    'notification': () => const NotificationManagementScreen(),
    'payment': () => const PaymentManagementScreen(),
    'photo': () => const PhotoManagementScreen(),
    'property': () => const PropertyManagementScreen(),
    'reservation': () => const ReservationManagementScreen(),
    'review': () => const ReviewManagementScreen(),
    'user': () => const UserManagementScreen(),
    'video-content': () => const VideoContentManagementScreen(),
    'tenants': () => const TenantAdminPage(),
  };

  /// `escrow-account` -> `EscrowAccount`, `api-key` -> `ApiKey`.
  static String kebabToPascal(String model) {
    final parts = model.split('-').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'Model';
    return parts
        .map((p) => p[0].toUpperCase() + p.substring(1))
        .join();
  }

  static Widget resolve(String model) {
    final key = model.toLowerCase().replaceAll('_', '-');
    final dedicated = _dedicatedScreens[key];
    if (dedicated != null) return dedicated();
    return DynamicAdminScreen(modelName: kebabToPascal(key));
  }
}
