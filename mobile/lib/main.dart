import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reservatior/features/admin/shared/widgets/command_center_modal.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reservatior/core/theme/app_theme.dart';

// Providers
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/google_auth_provider.dart';
import 'package:reservatior/shared/services/geo_init_service.dart';
import 'package:reservatior/core/network/dio_client.dart';

// Routes
import 'package:reservatior/core/navigation/feature_routes.dart';

// Screens
import 'package:reservatior/features/splash/presentation/screens/splash_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/welcome_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/login_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/register_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/change_password_screen.dart';

// Main Shell
import 'package:reservatior/shared/widgets/main_shell.dart';

// Feature Pages
import 'package:reservatior/features/client/home/presentation/pages/home_admin_page.dart';
import 'package:reservatior/features/client/home/presentation/screens/home_screen.dart';
import 'package:reservatior/features/client/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:reservatior/features/client/home/presentation/screens/explore_screen.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_feed.dart';
import 'package:reservatior/features/client/property/presentation/screens/search_screen.dart';
import 'package:reservatior/features/navigation/presentation/screens/features_overview_screen.dart';
import 'package:reservatior/features/navigation/presentation/screens/not_found_screen.dart';

import 'package:reservatior/more.dart';
import 'package:reservatior/features/admin/admin_hub_screen.dart';
import 'package:reservatior/features/client/marketplace/presentation/pages/marketplace_page.dart';

// Feature Admin Pages
import 'package:reservatior/features/client/property/presentation/pages/property_admin_page.dart';
import 'package:reservatior/features/client/agent/presentation/pages/agent_admin_page.dart';
import 'package:reservatior/features/client/booking/presentation/pages/neural_booking_center.dart';
import 'package:reservatior/features/settings/presentation/pages/settings_page.dart';
import 'package:reservatior/features/client/notification/presentation/screens/notifications_screen.dart';
import 'package:reservatior/features/client/lease/presentation/screens/leasecare_screen.dart';
import 'package:reservatior/features/client/property_valuation/presentation/pages/property_valuation_list_page.dart';
import 'package:reservatior/features/client/video_content/presentation/pages/video_recording_studio_page.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_details_screen.dart';

// New Feature Screens
import 'package:reservatior/features/client/message/presentation/screens/messages_screen.dart';
import 'package:reservatior/features/settings/presentation/screens/profile_screen.dart';
import 'package:reservatior/features/client/user_activity_log/presentation/screens/activity_tracking_screen.dart';
import 'package:reservatior/features/client/event/presentation/screens/events_screen.dart';
import 'package:reservatior/features/client/document/presentation/screens/file_management_screen.dart';
import 'package:reservatior/features/client/ai_model/presentation/screens/ai_studio_screen.dart';
import 'package:reservatior/features/client/ai_recommendation/presentation/screens/ai_recommendations_screen.dart';
import 'package:reservatior/features/client/deal/presentation/screens/deals_screen.dart';
import 'package:reservatior/features/client/communication_log/presentation/screens/communication_center_screen.dart';
import 'package:reservatior/features/client/financial_record/presentation/screens/financial_dashboard_screen.dart';
import 'package:reservatior/features/client/calendar_event/presentation/screens/calendar_today_screen.dart';
import 'package:reservatior/features/client/ticket/presentation/screens/support_screen.dart';
import 'package:reservatior/features/client/api_integration/presentation/screens/integrations_screen.dart';
import 'package:reservatior/features/client/organization/presentation/screens/organization_screen.dart';
import 'package:reservatior/features/client/dashboard_widget/presentation/screens/dashboard_widgets_screen.dart';
import 'package:reservatior/features/client/contact/presentation/screens/contact_screen.dart';
import 'package:reservatior/features/client/plan/presentation/screens/pricing_screen.dart';
import 'package:reservatior/features/client/home/presentation/screens/legal_screen.dart';
import 'package:reservatior/features/client/listing_channel/presentation/screens/channel_distribution_screen.dart';
import 'package:reservatior/features/client/property_promotion/presentation/screens/listing_doping_screen.dart';
import 'package:reservatior/features/client/agent/presentation/screens/agent_profile_screen.dart';
import 'package:reservatior/features/client/escrow_account/presentation/pages/escrow_account_admin_page.dart';
import 'package:reservatior/features/client/compliance_record/presentation/pages/compliance_record_admin_page.dart';
import 'package:reservatior/features/client/listing/presentation/screens/listings_screen.dart';
import 'package:reservatior/features/client/report/presentation/screens/analytics_screen.dart';
import 'package:reservatior/features/client/lead/presentation/screens/leads_screen.dart';
import 'package:reservatior/features/client/property_viewing/presentation/screens/viewings_screen.dart';







void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  // Initialize Google Sign-In with error handling
  try {
    await GoogleSignIn(clientId: '851507782363-4favlf24174r6572rdc158ochos8t4f8.apps.googleusercontent.com').signInSilently();
  } catch (e) {
    debugPrint('Google Sign-In initialization failed: $e');
  }
  
  // Custom Error Catcher
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: SelectableText(
                'CRITICAL ERROR: ${details.exception}\n\nSTACK TRACE: ${details.stack}',
                style: const TextStyle(color: Colors.red, fontSize: 10),
              ),
            ),
          ),
        ),
      ),
    );
  };

  try {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
      EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('tr'),
          Locale('ar'),
          Locale('de'),
          Locale('es'),
          Locale('fr'),
          Locale('it'),
          Locale('ja'),
          Locale('ko'),
          Locale('ru'),
          Locale('zh'),
          Locale('pt'),
          Locale('nl'),
          Locale('pl'),
          Locale('fi'),
          Locale('no'),
          Locale('da'),
          Locale('se'),
          Locale('hi'),
          Locale('gr'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('tr'),
        child: const ProviderScope(child: ReservatiorApp()),
      ),
    );
  } catch (e, stack) {
    debugPrint('Initialization error: $e');
    debugPrint(stack.toString());
  }
}

final GoRouter _router = GoRouter(
  errorBuilder: (context, state) => NotFoundScreen(path: state.uri.path),
  initialLocation: '/splash',
  redirect: (context, state) {
    try {
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authProvider);
      final user = authState.user;
      final path = state.uri.path;

      // Restrict access to admin routes
      if (path.startsWith('/admin')) {
        if (user == null) {
          return '/login'; // Not logged in -> Redirect to login
        }
        
        final role = user.role?.toLowerCase() ?? '';
        final hasAdminAccess = ['admin', 'super_admin', 'agency_admin', 'agent', 'owner'].contains(role);
        
        if (!hasAdminAccess) {
          return '/home'; // Unauthorized -> Redirect to Home
        }
      }
    } catch (_) {
      // Gracefully handle initialization phases where ProviderScope might not be fully ready
    }
    return null;
  },
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/auth/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/auth/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/auth/forgot-password', builder: (_, __) => const ForgotPasswordScreen()),
    GoRoute(path: '/auth/change-password', builder: (_, __) => const ChangePasswordScreen()),
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home', 
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/dashboard', 
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/explore', 
          builder: (context, state) => const ExploreScreen(),
        ),
        GoRoute(path: '/reels', builder: (_, __) => const PropertyFeed()),
        GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
        GoRoute(path: '/features', builder: (_, __) => const FeaturesOverviewScreen()),
        GoRoute(path: '/more', builder: (_, __) => const MoreScreen()),
        GoRoute(path: '/admin-hub', builder: (_, __) => const AdminHubScreen()),
        GoRoute(path: '/messages', builder: (_, __) => const MessagesScreen()),
        GoRoute(
          path: '/notifications', 
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: '/tasks', 
          builder: (context, state) => Consumer(
            builder: (context, ref, _) {
              final role = ref.watch(authProvider).user?.role?.toLowerCase();
              final isWorker = ['admin', 'super_admin', 'owner', 'agency_admin', 'agent', 'maintenance'].contains(role);
              if (isWorker) return const AgentAdminPage();
              return Scaffold(body: Center(child: Text('mobile.auto.unauthorized_agent_admin_access_only'.tr())));
            },
          ),
        ),
        GoRoute(
          path: '/calendar', 
          builder: (context, state) => Consumer(
            builder: (context, ref, _) {
              final role = ref.watch(authProvider).user?.role?.toLowerCase();
              final canBook = ['admin', 'super_admin', 'owner', 'org_admin', 'agency_admin', 'agent', 'vendor_manager'].contains(role);
              if (canBook) return const NeuralBookingCenter();
              return Scaffold(body: Center(child: Text('mobile.auto.unauthorized_admin_access_only'.tr())));
            },
          ),
        ),
        GoRoute(path: '/booking-center', builder: (_, __) => const NeuralBookingCenter()),
        GoRoute(path: '/ai-valuation', builder: (_, __) => const PropertyValuationListPage()),
        GoRoute(path: '/market-intel', builder: (_, __) => const AiStudioScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
        GoRoute(
          path: '/properties', 
          builder: (context, state) => Consumer(
            builder: (context, ref, _) {
              final role = ref.watch(authProvider).user?.role?.toLowerCase();
              final isEditor = ['admin', 'super_admin', 'owner', 'org_admin', 'agency_admin', 'agent'].contains(role);
              if (isEditor) return const PropertyAdminPage();
              return Scaffold(body: Center(child: Text('mobile.auto.unauthorized_staff_only'.tr())));
            },
          ),
        ),
        GoRoute(path: '/marketplace', builder: (_, __) => const MarketplacePage()),
        GoRoute(
          path: '/properties/:id',
          builder: (context, state) => PropertyDetailsScreen(
            propertyId: state.pathParameters['id'] ?? '',
          ),
        ),
        GoRoute(path: '/video-recording-studio', builder: (_, __) => const VideoRecordingStudioPage()),
        // New feature routes
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/activity', builder: (_, __) => const ActivityTrackingScreen()),
        GoRoute(path: '/events', builder: (_, __) => const EventsScreen()),
        GoRoute(path: '/files', builder: (_, __) => const FileManagementScreen()),
        GoRoute(path: '/ai-studio', builder: (_, __) => const AiStudioScreen()),
        GoRoute(path: '/ai-recommendations', builder: (_, __) => const AiRecommendationsScreen()),
        GoRoute(path: '/deals', builder: (_, __) => const DealsScreen()),
        GoRoute(path: '/communications', builder: (_, __) => const CommunicationCenterScreen()),
        GoRoute(path: '/financial', builder: (_, __) => const FinancialDashboardScreen()),
        GoRoute(path: '/escrow', builder: (_, __) => const EscrowAccountAdminPage()),
        GoRoute(path: '/legal', builder: (_, __) => const ComplianceRecordAdminPage()),
        GoRoute(path: '/today', builder: (_, __) => const CalendarTodayScreen()),
        GoRoute(path: '/support', builder: (_, __) => const SupportScreen()),
        GoRoute(path: '/integrations', builder: (_, __) => const IntegrationsScreen()),
        GoRoute(path: '/organization', builder: (_, __) => const OrganizationScreen()),
        GoRoute(path: '/dashboard-widgets', builder: (_, __) => const DashboardWidgetsScreen()),
        GoRoute(path: '/contact', builder: (_, __) => const ContactScreen()),
        GoRoute(path: '/pricing', builder: (_, __) => const PricingScreen()),
        GoRoute(path: '/privacy', builder: (_, __) => LegalScreen(title: 'mobile.auto.privacy_policy'.tr(), type: 'privacy')),
        GoRoute(path: '/terms', builder: (_, __) => LegalScreen(title: 'mobile.auto.terms_of_service'.tr(), type: 'terms')),
        GoRoute(path: '/trust-center', builder: (_, __) => LegalScreen(title: 'mobile.auto.trust_center'.tr(), type: 'trust')),
        GoRoute(path: '/channels', builder: (_, __) => const ChannelDistributionScreen()),
        GoRoute(path: '/listing-promotion', builder: (_, __) => const ListingDopingScreen()),
        GoRoute(path: '/agent-profile', builder: (_, __) => const AgentProfileScreen()),
        GoRoute(path: '/listings', builder: (_, __) => const ListingsScreen()),
        GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsScreen()),
        GoRoute(path: '/leads', builder: (_, __) => const LeadsScreen()),
        GoRoute(path: '/viewings', builder: (_, __) => const ViewingsScreen()),
        GoRoute(path: '/leasecare', builder: (_, __) => const LeaseCareScreen()),
        ...getFeatureRoutes(),
      ],
    ),
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
  ],
);

class ReservatiorApp extends ConsumerStatefulWidget {
  const ReservatiorApp({super.key});
  
  @override
  ConsumerState<ReservatiorApp> createState() => _ReservatiorAppState();
}

class _ReservatiorAppState extends ConsumerState<ReservatiorApp> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }
  
  Future<void> _initializeApp() async {
    await _loadEnv();
    
    // Auto-detect and set initial region via IP
    try {
      final dioClient = DioClient();
      await GeoInitService(dioClient).initializeGeo();
    } catch (e) {
      debugPrint('Error initializing geo service: $e');
    }

    // Initialize Google Auth when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(googleAuthProvider.notifier).initialize();
    });
  }
  
  Future<void> _loadEnv() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      print('Error loading .env file: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'mobile.auto.reservatior'.tr(),
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return FocusableActionDetector(
              autofocus: true,
              shortcuts: {
                LogicalKeySet(defaultTargetPlatform == TargetPlatform.macOS ? LogicalKeyboardKey.meta : LogicalKeyboardKey.control, LogicalKeyboardKey.keyK): const CommandCenterIntent(),
              },
              actions: {
                CommandCenterIntent: CallbackAction<CommandCenterIntent>(
                  onInvoke: (intent) {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black54,
                      builder: (_) => const CommandCenterModal(),
                    );
                    return null;
                  },
                ),
              },
              child: child!,
            );
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}

class CommandCenterIntent extends Intent {
  const CommandCenterIntent();
}
