import 'package:reservatior/features/admin/dynamic/dynamic_admin_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/features/client/account/presentation/pages/account_admin_page.dart';
// ai_lead_score removed: duplicate of ai_lead_scoring
import 'package:reservatior/features/client/booking/presentation/pages/booking_admin_page.dart';
import 'package:reservatior/features/client/favorite/presentation/pages/favorite_admin_page.dart';
import 'package:reservatior/features/client/guest/presentation/pages/guest_admin_page.dart';
import 'package:reservatior/features/client/guest_profile/presentation/pages/guest_profile_admin_page.dart';
import 'package:reservatior/features/language/presentation/pages/language_admin_page.dart';
import 'package:reservatior/features/client/listing/presentation/pages/listing_admin_page.dart';
import 'package:reservatior/features/client/location/presentation/pages/location_admin_page.dart';
import 'package:reservatior/features/client/message/presentation/pages/message_admin_page.dart';
import 'package:reservatior/features/client/notification/presentation/pages/notification_admin_page.dart';
import 'package:reservatior/features/client/payment/presentation/pages/payment_admin_page.dart';
import 'package:reservatior/features/client/photo/presentation/pages/photo_admin_page.dart';
import 'package:reservatior/features/client/property/presentation/pages/property_admin_page.dart';
import 'package:reservatior/features/client/reservation/presentation/pages/reservation_admin_page.dart';
import 'package:reservatior/features/client/review/presentation/pages/review_admin_page.dart';
import 'package:reservatior/features/client/tenant/presentation/pages/tenant_admin_page.dart';
import 'package:reservatior/features/client/user/presentation/pages/user_admin_page.dart';
import 'package:reservatior/features/client/video_content/presentation/pages/video_content_admin_page.dart';

List<RouteBase> getFeatureRoutes() {
  return [
    GoRoute(path: '/admin/account', builder: (_, __) => const AccountAdminPage()),
    GoRoute(path: '/admin/booking', builder: (_, __) => const BookingAdminPage()),
    GoRoute(path: '/admin/dynamic-contracts', builder: (_, __) => DynamicAdminScreen(modelName: 'Contracts')),
    GoRoute(path: '/admin/favorite', builder: (_, __) => const FavoriteAdminPage()),
    GoRoute(path: '/admin/guest', builder: (_, __) => const GuestAdminPage()),
    GoRoute(path: '/admin/guest_profile', builder: (_, __) => const GuestProfileAdminPage()),
    GoRoute(path: '/admin/language', builder: (_, __) => const LanguageAdminPage()),
    GoRoute(path: '/admin/listing', builder: (_, __) => const ListingAdminPage()),
    GoRoute(path: '/admin/location', builder: (_, __) => const LocationAdminPage()),
    GoRoute(path: '/admin/message', builder: (_, __) => const MessageAdminPage()),
    GoRoute(path: '/admin/notification', builder: (_, __) => const NotificationAdminPage()),
    GoRoute(path: '/admin/payment', builder: (_, __) => const PaymentAdminPage()),
    GoRoute(path: '/admin/photo', builder: (_, __) => const PhotoAdminPage()),
    GoRoute(path: '/admin/property', builder: (_, __) => const PropertyAdminPage()),
    GoRoute(path: '/admin/reservation', builder: (_, __) => const ReservationAdminPage()),
    GoRoute(path: '/admin/review', builder: (_, __) => const ReviewAdminPage()),
    GoRoute(path: '/admin/tenant', builder: (_, __) => const TenantAdminPage()),
    GoRoute(path: '/admin/user', builder: (_, __) => const UserAdminPage()),
    GoRoute(path: '/admin/video_content', builder: (_, __) => const VideoContentAdminPage()),
  ];
}
