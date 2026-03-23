import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import './core/theme/app_theme.dart';

// ─── Splash / Welcome / Home ────────────────────────────────────────────────
import './features/splash/presentation/screens/splash_screen.dart';
import './features/welcome/presentation/screens/welcome_screen.dart';
import './features/home/presentation/screens/home_screen.dart';

// ─── Navigation ─────────────────────────────────────────────────────────────
import './features/navigation/presentation/screens/main_navigation_screen.dart';
import './features/navigation/presentation/screens/features_overview_screen.dart';

// ─── Auth ───────────────────────────────────────────────────────────────────
import './features/auth/presentation/screens/login_screen.dart';
import './features/auth/presentation/screens/register_screen.dart';
import './features/auth/presentation/screens/forgot_password_screen.dart';
import './features/auth/presentation/screens/profile_screen.dart';
import './features/auth/presentation/screens/change_password_screen.dart';

// ─── Core Features ──────────────────────────────────────────────────────────
import './features/dashboard/presentation/screens/dashboard_screen.dart';
import './features/properties/presentation/screens/property_list_screen.dart';
import './features/properties/presentation/screens/property_detail_screen.dart';
import './features/analytics/presentation/screens/analytics_screen.dart';
import './features/analytics/presentation/screens/business_analytics_screen.dart';
import './features/contacts/presentation/screens/contacts_screen.dart';
import './features/deals/presentation/screens/deals_screen.dart';
import './features/payments/presentation/screens/payments_screen.dart';
import './features/listings/presentation/screens/listings_screen.dart';

// ─── Tasks ──────────────────────────────────────────────────────────────────
import './features/tasks/presentation/screens/tasks_screen.dart';
import './features/tasks/presentation/screens/task_list_screen.dart';
import './features/tasks/presentation/screens/task_detail_screen.dart';

// ─── Agents / Agencies ──────────────────────────────────────────────────────
import './features/agents/presentation/screens/agents_screen.dart';
import './features/agents/presentation/screens/agent_list_screen.dart';
import './features/agents/presentation/screens/agent_performance_screen.dart';
import './features/agency/presentation/pages/agency_admin_page.dart';
import './features/agency/presentation/screens/agency_screen.dart';

// ─── AI Features ────────────────────────────────────────────────────────────
import './features/ai/presentation/screens/ai_screen.dart';
import './features/ai/presentation/screens/ai_chat_screen.dart';
import './features/ai/presentation/screens/ai_video_generation_screen.dart';
import './features/ai/presentation/screens/ai_listing_screen.dart';
import './features/ai_generation/presentation/screens/ai_generation_screen.dart';

// ─── Video ──────────────────────────────────────────────────────────────────
import './features/video/presentation/screens/video_screen.dart';
import './features/video/editor/presentation/screens/video_editor_screen.dart';

// ─── Reservations ───────────────────────────────────────────────────────────
import './features/reservation/presentation/screens/reservation_list_screen.dart';
import './features/reservation/presentation/screens/reservation_detail_screen.dart';

// ─── Communication ──────────────────────────────────────────────────────────
import './features/search/presentation/screens/search_screen.dart';
import './features/favorites/presentation/screens/favorites_screen.dart';
import './features/communication/presentation/screens/communication_screen.dart';
import './features/messages/presentation/screens/messages_screen.dart';
import './features/messages/presentation/screens/message_detail_screen.dart';
import './features/messages/presentation/screens/compose_message_screen.dart';
import './features/notifications/presentation/screens/notifications_screen.dart';
import './features/communication_logs/presentation/screens/communication_logs_screen.dart';

// ─── Management ─────────────────────────────────────────────────────────────
import './features/appointments/presentation/screens/appointments_screen.dart';
import './features/bookings/presentation/screens/bookings_screen.dart';
import './features/documents/presentation/screens/documents_screen.dart';
import './features/contracts/presentation/screens/contracts_screen.dart';
import './features/projects/presentation/screens/projects_screen.dart';
import './features/marketing/presentation/screens/marketing_screen.dart';
import './features/reports/presentation/screens/reports_screen.dart';
import './features/attachments/presentation/screens/attachments_screen.dart';
import './features/signatures/presentation/screens/signatures_screen.dart';

// ─── Finance ────────────────────────────────────────────────────────────────
import './features/financials/presentation/screens/financials_screen.dart';
import './features/escrow/presentation/screens/escrow_screen.dart';

// ─── System ─────────────────────────────────────────────────────────────────
import './features/settings/presentation/screens/settings_screen.dart';
import './features/user/presentation/screens/user_screen.dart';
import './features/admin/presentation/screens/admin_screen.dart';
import './features/achievements/presentation/screens/achievements_screen.dart';
import './features/brand/presentation/screens/brand_screen.dart';
import './features/email_queue/presentation/screens/email_queue_screen.dart';
import './features/mobile_devices/presentation/screens/mobile_devices_screen.dart';
import './features/property_inventory/presentation/screens/property_inventory_screen.dart';
import './features/system_metrics/presentation/screens/system_metrics_screen.dart';
import './features/locations/presentation/screens/locations_screen.dart';
import './features/advanced/presentation/screens/advanced_features_screen.dart';

// ─── More (has MoreScreen + VideoCardWidget) ────────────────────────────────
import './more.dart';

// ─── Providers ──────────────────────────────────────────────────────────────
import './shared/providers/auth_provider.dart';

void main() {
  runApp(const ProviderScope(child: ReservatiorApp()));
}

class ReservatiorApp extends ConsumerWidget {
  const ReservatiorApp({super.key});

  @override
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
    // ─── Splash ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/splash',
      builder: (_, __) => const SplashScreen(),
    ),

    // ─── Welcome ─────────────────────────────────────────────────────────
    GoRoute(
      path: '/welcome',
      builder: (_, __) => const WelcomeScreen(),
    ),

    // ─── Auth ────────────────────────────────────────────────────────────
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

    // ─── Navigation ──────────────────────────────────────────────────────
    GoRoute(
      path: '/main',
      builder: (_, __) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/features',
      builder: (_, __) => const FeaturesOverviewScreen(),
    ),

    // ─── Dashboard ───────────────────────────────────────────────────────
    GoRoute(
      path: '/dashboard',
      builder: (_, __) => const DashboardScreen(),
    ),

    // ─── Core Features ───────────────────────────────────────────────────
    GoRoute(
      path: '/properties',
      builder: (_, __) => const PropertyListScreen(),
    ),
    GoRoute(
      path: '/properties/:id',
      builder: (_, state) =>
          PropertyDetailScreen(propertyId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/contacts',
      builder: (_, __) => const ContactsScreen(),
    ),
    GoRoute(
      path: '/deals',
      builder: (_, __) => const DealsScreen(),
    ),
    GoRoute(
      path: '/payments',
      builder: (_, __) => const PaymentsScreen(),
    ),
    GoRoute(
      path: '/agents',
      builder: (_, __) => const AgentsScreen(),
    ),
    GoRoute(
      path: '/analytics',
      builder: (_, __) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/listings',
      builder: (_, __) => const ListingsScreen(),
    ),
    GoRoute(
      path: '/tasks',
      builder: (_, __) => const TasksScreen(),
    ),
    GoRoute(
      path: '/tasks/:id',
      builder: (_, state) =>
          TaskDetailScreen(taskId: state.pathParameters['id']!),
    ),

    // ─── AI ──────────────────────────────────────────────────────────────
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
      path: '/ai/listing',
      builder: (_, __) => const AiListingScreen(),
    ),
    GoRoute(
      path: '/ai/video',
      builder: (_, __) => const AiVideoGenerationScreen(),
    ),

    // ─── Video ───────────────────────────────────────────────────────────
    GoRoute(
      path: '/video',
      builder: (_, __) => const VideoScreen(),
    ),
    GoRoute(
      path: '/video/editor',
      builder: (_, __) => const VideoEditorScreen(),
    ),

    // ─── Management ──────────────────────────────────────────────────────
    GoRoute(
      path: '/appointments',
      builder: (_, __) => const AppointmentsScreen(),
    ),
    GoRoute(
      path: '/bookings',
      builder: (_, __) => const BookingsScreen(),
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
    GoRoute(
      path: '/reports',
      builder: (_, __) => const ReportsScreen(),
    ),
    GoRoute(
      path: '/attachments',
      builder: (_, __) => const AttachmentsScreen(),
    ),
    GoRoute(
      path: '/signatures',
      builder: (_, __) => const SignaturesScreen(),
    ),

    // ─── Reservations ────────────────────────────────────────────────────
    GoRoute(
      path: '/reservations',
      builder: (_, __) => const ReservationListScreen(),
    ),
    GoRoute(
      path: '/reservations/:id',
      builder: (_, state) =>
          ReservationDetailScreen(),
    ),

    // ─── Finance ─────────────────────────────────────────────────────────
    GoRoute(
      path: '/financials',
      builder: (_, __) => const FinancialsScreen(),
    ),
    GoRoute(
      path: '/escrow',
      builder: (_, __) => const EscrowScreen(),
    ),

    // ─── Communication ───────────────────────────────────────────────────
    GoRoute(
      path: '/search',
      builder: (_, __) => const SearchScreen(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (_, __) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/communication',
      builder: (_, __) => const CommunicationScreen(),
    ),
    GoRoute(
      path: '/messages',
      builder: (_, __) => const MessagesScreen(),
    ),
    GoRoute(
      path: '/messages/compose',
      builder: (_, __) => const ComposeMessageScreen(),
    ),
    GoRoute(
      path: '/messages/:id',
      builder: (_, state) =>
          MessageDetailScreen(messageId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/notifications',
      builder: (_, __) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/communication_logs',
      builder: (_, __) => const CommunicationLogsScreen(),
    ),

    // ─── Agencies / Agents ───────────────────────────────────────────────
    GoRoute(
      path: '/agency',
      builder: (_, __) => const AgencyScreen(),
    ),
    GoRoute(
      path: '/agent-dashboard',
      builder: (_, __) => const AgencyDashboardScreen(),
    ),

    // ─── System ──────────────────────────────────────────────────────────
    GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/user',
      builder: (_, __) => const UserScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (_, __) => const AdminScreen(),
    ),
    GoRoute(
      path: '/achievements',
      builder: (_, __) => const AchievementsScreen(),
    ),
    GoRoute(
      path: '/email-queue',
      builder: (_, __) => const EmailQueueScreen(),
    ),
    GoRoute(
      path: '/mobile-devices',
      builder: (_, __) => const MobileDevicesScreen(),
    ),
    GoRoute(
      path: '/property-inventory',
      builder: (_, __) => const PropertyInventoryScreen(),
    ),
    GoRoute(
      path: '/system-metrics',
      builder: (_, __) => const SystemMetricsScreen(),
    ),
    GoRoute(
      path: '/locations',
      builder: (_, __) => const LocationsScreen(),
    ),
    GoRoute(
      path: '/advanced',
      builder: (_, __) => const AdvancedFeaturesScreen(),
    ),

    // ─── More ────────────────────────────────────────────────────────────
    GoRoute(
      path: '/more',
      builder: (_, __) => const MoreScreen(),
    ),

    // ─── Legacy / Login shortcut ─────────────────────────────────────────
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(),
    ),

    // ─── Fallback ────────────────────────────────────────────────────────
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
  ],
);
