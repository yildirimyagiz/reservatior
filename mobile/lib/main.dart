import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import './core/theme/app_theme.dart';
import './features/properties/presentation/screens/property_detail_screen.dart';
import './features/dashboard/presentation/screens/dashboard_screen.dart';
import './features/home/presentation/screens/home_screen.dart';
import './features/splash/presentation/screens/splash_screen.dart';
import './features/welcome/presentation/screens/welcome_screen.dart';
import './features/navigation/presentation/screens/features_overview_screen.dart';
import './features/navigation/presentation/screens/main_navigation_screen.dart';
import './features/search/presentation/screens/search_screen.dart';
import './features/favorite/presentation/pages/favorite_admin_page.dart';
import './features/message/presentation/pages/messages_page.dart';
import './features/communication/presentation/screens/communication_screen.dart';
import './features/notification/presentation/pages/notifications_page.dart';
import './features/auth/presentation/screens/login_screen.dart';
import './features/auth/presentation/screens/register_screen.dart';
import './features/auth/presentation/screens/forgot_password_screen.dart';
import './features/auth/presentation/screens/profile_screen.dart';
import './features/auth/presentation/screens/change_password_screen.dart';
import './features/properties/presentation/screens/property_list_screen.dart';
import './features/properties/presentation/screens/property_detail_screen.dart';
<<<<<<< /Users/os2026/Downloads/echosystem/reservatior main/mobile/lib/main.dart
import './features/analytics/presentation/pages/analytics_admin_page.dart';
import './features/task/presentation/pages/task_admin_page.dart';
import './features/agencies/presentation/screens/agency_dashboard_screen.dart';
import './features/agent/presentation/pages/agent_admin_page.dart';
import './features/ai_chat/presentation/screens/ai_chat_screen.dart';
=======
import './features/analytics/presentation/screens/analytics_screen.dart';
import './features/analytics/presentation/screens/business_analytics_screen.dart';
import './features/tasks/presentation/screens/task_list_screen.dart';
import './features/tasks/presentation/screens/task_detail_screen.dart';
import './features/agency/presentation/pages/agency_admin_page.dart';
import './features/agents/presentation/screens/agent_list_screen.dart';
import './features/agents/presentation/screens/agent_performance_screen.dart';
import './features/ai/presentation/screens/ai_chat_screen.dart';
>>>>>>> /Users/os2026/.windsurf/worktrees/reservatior main/reservatior main-d839815a/mobile/lib/main.dart
import './features/ai/presentation/screens/ai_video_generation_screen.dart';
import './features/ai/listing/presentation/screens/ai_listing_screen.dart';
import './features/video/editor/presentation/screens/video_editor_screen.dart';
import './features/reservation/presentation/pages/reservation_admin_page.dart';
// More screen removed - using navigation instead
import './shared/providers/auth_provider.dart';

// Import all new UI modules
import './features/achievement/presentation/pages/achievements_list_page.dart';
import './features/admin/presentation/screens/admin_screen.dart';
import './features/attachment/presentation/pages/attachment_admin_page.dart';
import './features/signatures/presentation/screens/signatures_screen.dart';
import './features/reports/presentation/screens/reports_screen.dart';
// Removed duplicate tasks import - using task/presentation/pages/task_admin_page.dart
import './features/contact/presentation/pages/contact_admin_page.dart';
import './features/deal/presentation/pages/deal_admin_page.dart';
import './features/payments/presentation/screens/payments_screen.dart';
// Removed duplicate - using agent/presentation/pages/agent_admin_page.dart
// Removed duplicate - using analytics/presentation/pages/analytics_admin_page.dart
import './features/listings/presentation/screens/listings_screen.dart';
import './features/dashboard/presentation/screens/dashboard_screen.dart';
import './features/communication_log/presentation/pages/communication_log_admin_page.dart';
import './features/settings/presentation/screens/settings_screen.dart';
// Removed duplicate - using message/presentation/pages/messages_page.dart
import './features/video/presentation/screens/video_screen.dart';
import './features/user/presentation/pages/user_admin_page.dart';
import './features/financials/presentation/screens/financials_screen.dart';
import './features/escrow/presentation/screens/escrow_screen.dart';
import './features/agency/presentation/pages/agency_admin_page.dart';
import './features/ai/presentation/screens/ai_screen.dart';
import './features/ai_chat/presentation/screens/ai_chat_screen.dart';
import './features/ai_generation/presentation/screens/ai_generation_screen.dart';
import './features/ai/listing/presentation/screens/ai_listing_screen.dart';
// Note: Using appointment (singular) module instead of appointments (plural)
import './features/booking/presentation/pages/booking_admin_page.dart';
import './features/appointment/presentation/pages/appointment_admin_page.dart';
import './features/brand/presentation/screens/brand_screen.dart';
import './features/documents/presentation/screens/documents_screen.dart';
import './features/contracts/presentation/screens/contracts_screen.dart';
import './features/projects/presentation/screens/projects_screen.dart';
import './features/marketing/presentation/screens/marketing_screen.dart';
import './features/email_queue/presentation/screens/email_queue_screen.dart';
import './features/mobile_devices/presentation/screens/mobile_devices_screen.dart';
import './features/property_inventory/presentation/pages/property_inventory_admin_page.dart';
import './features/system_metrics/presentation/pages/system_metrics_admin_page.dart';
import './features/location/presentation/pages/location_admin_page.dart';
import './features/advanced/presentation/screens/advanced_features_screen.dart';
import './more.dart';

void main() {
  runApp(const ProviderScope(child: ReservatiorApp()));
}

class ReservatiorApp extends ConsumerWidget {
  const ReservatiorApp({super.key});

  
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Reservatior',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      locale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
      ],
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    // ─── Splash ────────────────────────────────────────────────────────
    GoRoute(
      path: '/splash',
      builder: (_, __) => const SplashScreen(),
    ),

    // ─── Welcome ────────────────────────────────────────────────────────
    GoRoute(
      path: '/welcome',
      builder: (_, __) => const WelcomeScreen(),
    ),

    // ─── Auth Routes ─────────────────────────────────────────────────────
    GoRoute(
      path: '/auth/login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/auth/forgot-password',
      builder: (_, __) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/auth/change-password',
      builder: (_, __) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (_, __) => const ProfileScreen(),
    ),

    // ─── Main Navigation (Authenticated User) ───────────────────────────────
    GoRoute(
      path: '/main',
      builder: (_, __) => const MainNavigationScreen(),
    ),

    // ─── Home (Instagram Style) ───────────────────────────────────────────
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),

    // ─── Dashboard (Business) ────────────────────────────────────────────
    GoRoute(
      path: '/dashboard',
      builder: (_, __) => const DashboardScreen(),
    ),

    // ─── Features Overview ───────────────────────────────────────────────
    GoRoute(
      path: '/features',
      builder: (_, __) => const FeaturesOverviewScreen(),
    ),

    // ─── Core Features ───────────────────────────────────────────────────
    GoRoute(
      path: '/properties',
      builder: (_, __) => const PropertyListScreen(),
    ),
    GoRoute(
      path: '/properties/:id',
      builder: (_, state) => PropertyDetailScreen(propertyId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/contacts',
      builder: (_, __) => const ContactAdminPage(),
    ),
    GoRoute(
      path: '/deals',
      builder: (_, __) => const DealAdminPage(),
    ),
    GoRoute(
      path: '/payments',
      builder: (_, __) => const PaymentsScreen(),
    ),
    GoRoute(
      path: '/agents',
      builder: (_, __) => const AgentAdminPage(),
    ),
    GoRoute(
      path: '/Analytics',
      builder: (_, __) => const AnalyticsAdminPage(),
    ),
    GoRoute(
      path: '/listings',
      builder: (_, __) => const ListingsScreen(),
    ),
    GoRoute(
      path: '/tasks',
      builder: (_, __) => const TaskAdminPage(),
    ),
    GoRoute(
      path: '/tasks/:id',
      builder: (_, __) => const TaskAdminPage(), // Detail view - TODO: implement detail page
    ),

    // ─── AI Features ───────────────────────────────────────────────────────
    GoRoute(
      path: '/ai',
      builder: (_, __) => const AiScreen(),
    ),
    GoRoute(
      path: '/ai/chat',
      builder: (_, __) => const AiChatScreen(),
    ),
    GoRoute(
      path: '/ai/generation',
      builder: (_, __) => const AiGenerationScreen(),
    ),
    GoRoute(
      path: '/ai/Listing',
      builder: (_, __) => const AiListingScreen(),
    ),

    // ─── Management Features ───────────────────────────────────────────────
    GoRoute(
      path: '/appointments',
      builder: (_, __) => const AppointmentAdminPage(),
    ),
    GoRoute(
      path: '/bookings',
      builder: (_, __) => const BookingAdminPage(),
    ),
    GoRoute(
      path: '/brand',
      builder: (_, __) => const BrandScreen(),
    ),
    GoRoute(
      path: '/documents',
      builder: (_, __) => const DocumentsScreen(),
    ),
    GoRoute(
      path: '/contracts',
      builder: (_, __) => const ContractsScreen(),
    ),
    GoRoute(
      path: '/projects',
      builder: (_, __) => const ProjectsScreen(),
    ),
    GoRoute(
      path: '/marketing',
      builder: (_, __) => const MarketingScreen(),
    ),

    // ─── System Features ───────────────────────────────────────────────────
    GoRoute(
      path: '/email_queue',
      builder: (_, __) => const EmailQueueScreen(),
    ),
    GoRoute(
      path: '/mobile_devices',
      builder: (_, __) => const MobileDevicesScreen(),
    ),
    GoRoute(
      path: '/property_inventory',
      builder: (_, __) => const PropertyInventoryAdminPage(),
    ),
    GoRoute(
      path: '/system_metrics',
      builder: (_, __) => const SystemMetricsAdminPage(),
    ),
    GoRoute(
      path: '/locations',
      builder: (_, __) => const LocationAdminPage(),
    ),

    // ─── Additional Features ───────────────────────────────────────────────
    GoRoute(
      path: '/achievements',
      builder: (_, __) => const AchievementsListPage(),
    ),
    GoRoute(
      path: '/admin',
      builder: (_, __) => const AdminScreen(),
    ),
    GoRoute(
      path: '/attachments',
      builder: (_, __) => const AttachmentAdminPage(),
    ),
    GoRoute(
      path: '/signatures',
      builder: (_, __) => const SignaturesScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (_, __) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/communication_logs',
      builder: (_, __) => const CommunicationLogAdminPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/video',
      builder: (_, __) => const VideoScreen(),
    ),
    GoRoute(
      path: '/User',
      builder: (_, __) => const UserAdminPage(),
    ),
    GoRoute(
      path: '/financials',
      builder: (_, __) => const FinancialsScreen(),
    ),
    GoRoute(
      path: '/escrow',
      builder: (_, __) => const EscrowScreen(),
    ),
    GoRoute(
      path: '/Agency',
      builder: (_, __) => const AgencyAdminPage(),
    ),

    // ─── Communication ───────────────────────────────────────────────────────
    GoRoute(
      path: '/search',
      builder: (_, __) => const SearchScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (_, __) => const FavoriteAdminPage(),
    ),
    GoRoute(
      path: '/communication',
      builder: (_, __) => const CommunicationScreen(),
    ),
    GoRoute(
      path: '/messages',
      builder: (_, __) => const MessagesPage(),
    ),
    GoRoute(
      path: '/messages/:id',
      builder: (_, __) => const MessagesPage(), // Detail view - TODO: implement detail page
    ),
    GoRoute(
      path: '/messages/compose',
      builder: (_, __) => const MessagesPage(), // Compose view - TODO: implement compose page
    ),
    GoRoute(
      path: '/notifications',
      builder: (_, __) => const NotificationsPage(),
    ),

    // ─── Legacy Routes ───────────────────────────────────────────────────────
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/more',
      builder: (_, __) => const MoreScreen(),
    ),

    // ─── Advanced Features ───────────────────────────────────────────────
    GoRoute(
      path: '/advanced',
      builder: (_, __) => const AdvancedFeaturesScreen(),
    ),

    // ─── Fallback ────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
  ],
);
