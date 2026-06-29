import 'package:reservatior/features/admin/dynamic/dynamic_admin_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reservatior/features/admin/shared/widgets/command_center_modal.dart';
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
// missing import removed: features/client/marketplace/presentation/pages/marketplace_page.dart

// Feature Admin Pages
import 'package:reservatior/features/client/property/presentation/pages/property_admin_page.dart';
// missing import removed: features/client/agent/presentation/pages/agent_admin_page.dart
import 'package:reservatior/features/client/booking/presentation/pages/neural_booking_center.dart';
import 'package:reservatior/features/settings/presentation/pages/settings_page.dart';
import 'package:reservatior/features/client/notification/presentation/screens/notifications_screen.dart';
// missing import removed: features/client/lease/presentation/screens/leasecare_screen.dart
import 'package:reservatior/features/client/video_content/presentation/pages/video_recording_studio_page.dart';
import 'package:reservatior/features/client/property/presentation/screens/property_details_screen.dart';

// New Feature Screens
import 'package:reservatior/features/client/message/presentation/screens/messages_screen.dart';
import 'package:reservatior/features/settings/presentation/screens/profile_screen.dart';
// missing import removed: features/client/user_activity_log/presentation/screens/activity_tracking_screen.dart
// missing import removed: features/client/document/presentation/screens/file_management_screen.dart
// missing import removed: features/client/ai_recommendation/presentation/screens/ai_recommendations_screen.dart
// missing import removed: features/client/communication_log/presentation/screens/communication_center_screen.dart
// missing import removed: features/client/calendar_event/presentation/screens/calendar_today_screen.dart
// missing import removed: features/client/api_integration/presentation/screens/integrations_screen.dart
// missing import removed: features/client/dashboard_widget/presentation/screens/dashboard_widgets_screen.dart
// missing import removed: features/client/plan/presentation/screens/pricing_screen.dart
import 'package:reservatior/features/client/home/presentation/screens/legal_screen.dart';
// missing import removed: features/client/listing_channel/presentation/screens/channel_distribution_screen.dart
// missing import removed: features/client/agent/presentation/screens/agent_profile_screen.dart
// missing import removed: features/client/compliance_record/presentation/pages/compliance_record_admin_page.dart
import 'package:reservatior/features/client/listing/presentation/screens/listings_screen.dart';
// missing import removed: features/client/report/presentation/screens/analytics_screen.dart
// missing import removed: features/client/property_viewing/presentation/screens/viewings_screen.dart
import 'package:reservatior/features/agent_os/presentation/pages/agent_dashboard_page.dart';
import 'package:reservatior/features/agent_os/presentation/pages/compliance_page.dart';
import 'package:reservatior/features/agent_os/presentation/pages/verification_page.dart';
import 'package:reservatior/features/agent_os/presentation/pages/behavioral_scoring_page.dart';
import 'package:reservatior/features/finance_os/presentation/pages/finance_dashboard_page.dart';
import 'package:reservatior/features/finance_os/presentation/pages/escrow_vault_page.dart';
import 'package:reservatior/features/finance_os/presentation/pages/ledger_page.dart';
import 'package:reservatior/features/finance_os/presentation/pages/payout_page.dart';
import 'package:reservatior/features/finance_os/presentation/pages/settlement_page.dart';
import 'package:reservatior/features/admin/contract/contract_state_machine_screen.dart';
import 'package:reservatior/features/admin/commission/revenue_dag_screen.dart';
import 'package:reservatior/features/admin/failover/failover_inventory_screen.dart';
import 'package:reservatior/features/admin/payment_routing/payment_routing_screen.dart';







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
              if (isWorker) return DynamicAdminScreen(modelName: 'Agent');
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
        GoRoute(path: '/ai-valuation', builder: (_, __) => DynamicAdminScreen(modelName: 'PropertyValuationList')),
        GoRoute(path: '/market-intel', builder: (_, __) => DynamicAdminScreen(modelName: 'AiStudio')),
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
        GoRoute(path: '/marketplace', builder: (_, __) => DynamicAdminScreen(modelName: 'Marketplace')),
        GoRoute(
          path: '/properties/:id',
          builder: (context, state) => PropertyDetailsScreen(
            propertyId: state.pathParameters['id'] ?? '',
          ),
        ),
        GoRoute(path: '/video-recording-studio', builder: (_, __) => const VideoRecordingStudioPage()),
        // New feature routes
        GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/activity', builder: (_, __) => DynamicAdminScreen(modelName: 'ActivityTracking')),
        GoRoute(path: '/events', builder: (_, __) => DynamicAdminScreen(modelName: 'Events')),
        GoRoute(path: '/files', builder: (_, __) => DynamicAdminScreen(modelName: 'FileManagement')),
        GoRoute(path: '/ai-studio', builder: (_, __) => DynamicAdminScreen(modelName: 'AiStudio')),
        GoRoute(path: '/ai-recommendations', builder: (_, __) => DynamicAdminScreen(modelName: 'AiRecommendations')),
        GoRoute(path: '/deals', builder: (_, __) => DynamicAdminScreen(modelName: 'Deals')),
        GoRoute(path: '/communications', builder: (_, __) => DynamicAdminScreen(modelName: 'CommunicationCenter')),
        GoRoute(path: '/financial', builder: (_, __) => DynamicAdminScreen(modelName: 'FinancialDashboard')),
        GoRoute(path: '/escrow', builder: (_, __) => DynamicAdminScreen(modelName: 'EscrowAccount')),
        GoRoute(path: '/legal', builder: (_, __) => DynamicAdminScreen(modelName: 'ComplianceRecord')),
        GoRoute(path: '/today', builder: (_, __) => DynamicAdminScreen(modelName: 'CalendarToday')),
        GoRoute(path: '/support', builder: (_, __) => DynamicAdminScreen(modelName: 'Support')),
        GoRoute(path: '/integrations', builder: (_, __) => DynamicAdminScreen(modelName: 'Integrations')),
        GoRoute(path: '/organization', builder: (_, __) => DynamicAdminScreen(modelName: 'Organization')),
        GoRoute(path: '/dashboard-widgets', builder: (_, __) => DynamicAdminScreen(modelName: 'DashboardWidgets')),
        GoRoute(path: '/contact', builder: (_, __) => DynamicAdminScreen(modelName: 'Contact')),
        GoRoute(path: '/pricing', builder: (_, __) => DynamicAdminScreen(modelName: 'Pricing')),
        GoRoute(path: '/privacy', builder: (_, __) => LegalScreen(title: 'mobile.auto.privacy_policy'.tr(), type: 'privacy')),
        GoRoute(path: '/terms', builder: (_, __) => LegalScreen(title: 'mobile.auto.terms_of_service'.tr(), type: 'terms')),
        GoRoute(path: '/trust-center', builder: (_, __) => LegalScreen(title: 'mobile.auto.trust_center'.tr(), type: 'trust')),
        GoRoute(path: '/channels', builder: (_, __) => DynamicAdminScreen(modelName: 'ChannelDistribution')),
        GoRoute(path: '/listing-promotion', builder: (_, __) => DynamicAdminScreen(modelName: 'ListingDoping')),
        GoRoute(path: '/agent-profile', builder: (_, __) => DynamicAdminScreen(modelName: 'AgentProfile')),
        GoRoute(path: '/listings', builder: (_, __) => const ListingsScreen()),
        GoRoute(path: '/analytics', builder: (_, __) => DynamicAdminScreen(modelName: 'Analytics')),
        GoRoute(path: '/leads', builder: (_, __) => DynamicAdminScreen(modelName: 'Leads')),
        GoRoute(path: '/viewings', builder: (_, __) => DynamicAdminScreen(modelName: 'Viewings')),
        GoRoute(path: '/leasecare', builder: (_, __) => DynamicAdminScreen(modelName: 'LeaseCare')),
        GoRoute(path: '/agent-os', builder: (_, __) => const AgentDashboardPage()),
        GoRoute(path: '/agent-compliance', builder: (_, __) => const CompliancePage()),
        GoRoute(path: '/agent-verification', builder: (_, __) => const VerificationPage()),
        GoRoute(path: '/agent-scoring', builder: (_, __) => const BehavioralScoringPage()),
        GoRoute(path: '/finance-os', builder: (_, __) => const FinanceDashboardPage()),
        GoRoute(path: '/finance-escrow', builder: (_, __) => const EscrowVaultPage()),
        GoRoute(path: '/finance-ledger', builder: (_, __) => const LedgerPage()),
        GoRoute(path: '/finance-payouts', builder: (_, __) => const PayoutPage()),
        GoRoute(path: '/finance-settlements', builder: (_, __) => const SettlementPage()),
        GoRoute(path: '/contract-state-machine', builder: (_, __) => const ContractStateMachineScreen()),
        GoRoute(path: '/revenue-dag', builder: (_, __) => const RevenueDagScreen()),
        GoRoute(path: '/failover-engine', builder: (_, __) => const FailoverInventoryScreen()),
        GoRoute(path: '/payment-routing', builder: (_, __) => const PaymentRoutingScreen()),
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
