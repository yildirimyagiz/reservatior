import 'package:reservatior/features/admin/dynamic/dynamic_admin_screen.dart';
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
import 'package:reservatior/core/navigation/deep_link_service.dart';

// Screens
import 'package:reservatior/features/splash/presentation/screens/splash_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/welcome_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/login_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/register_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:reservatior/features/auth/presentation/screens/change_password_screen.dart';

// Main Shell
import 'package:reservatior/shared/widgets/main_shell.dart';

// Feature Pages
import 'package:reservatior/features/client/home/presentation/pages/home_admin_page.dart';
import 'package:reservatior/features/commerce_os/presentation/products_screen.dart';
import 'package:reservatior/features/commerce_os/presentation/suppliers_screen.dart';
import 'package:reservatior/features/commerce_os/presentation/bundles_screen.dart';
import 'package:reservatior/features/commerce_os/presentation/campaigns_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/property_passport_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/market_passport_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/user_passport_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/agent_passport_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/intelligence_graph_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/content_publisher_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/decision_engine_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/feedback_loop_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/revenue_intelligence_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/seo_generator_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/certificates_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/edevlet_contract_wizard_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/hybrid_rental_os_module_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/hybrid_rental_engine_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/global_hybrid_rental_os_screen.dart';
import 'package:reservatior/features/intelligence_os/presentation/gmsi_tax_report_screen.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_dashboards.dart';
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
import 'package:reservatior/features/client/home/presentation/screens/legal_screen.dart' as policy;
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
import 'package:reservatior/features/ai_studio/presentation/ai_studio_screen.dart';
import 'package:reservatior/features/ai_studio/presentation/ai_chat_screen.dart';
import 'package:reservatior/features/investment/presentation/roi_calculator_screen.dart';
import 'package:reservatior/features/investment/presentation/rental_yield_screen.dart';
import 'package:reservatior/features/investment/presentation/compare_screen.dart';
import 'package:reservatior/features/crm/presentation/leads_screen.dart';
import 'package:reservatior/features/crm/presentation/deals_screen.dart';
import 'package:reservatior/features/client/calendar/presentation/calendar_screen.dart';
import 'package:reservatior/features/client/financial/presentation/financial_screen.dart';
import 'package:reservatior/features/client/legal/presentation/legal_screen.dart';
import 'package:reservatior/features/client/tenant/presentation/rent_management_screen.dart';
import 'package:reservatior/features/client/communications/presentation/communications_screen.dart';
import 'package:reservatior/features/investment/presentation/investment_os_dashboard.dart';
import 'package:reservatior/features/crm/presentation/crm_os_dashboard.dart';
import 'package:reservatior/features/client/communications/presentation/marketing_os_dashboard.dart';
import 'package:reservatior/features/document_os/presentation/document_os_dashboard.dart';
import 'package:reservatior/features/document_os/presentation/contract_generator_page.dart';
import 'package:reservatior/features/identity_os/presentation/identity_os_dashboard.dart';
import 'package:reservatior/features/analytics_os/presentation/analytics_os_dashboard.dart';
import 'package:reservatior/features/ai_valuation/presentation/ai_valuation_screen.dart';
import 'package:reservatior/features/client/tasks/presentation/tasks_screen.dart';
import 'package:reservatior/features/client/appointments/presentation/appointments_screen.dart';
import 'package:reservatior/features/investment/presentation/portfolio_screen.dart';
import 'package:reservatior/features/channels/presentation/channels_screen.dart';
import 'package:reservatior/features/listing/presentation/listing_promotion_screen.dart';
import 'package:reservatior/features/membership/presentation/loyalty_screen.dart';
import 'package:reservatior/features/facilities/presentation/facilities_screen.dart';
import 'package:reservatior/features/maintenance/presentation/maintenance_screen.dart';
import 'package:reservatior/features/operations_os/presentation/operations_os_dashboard.dart';

// Faz E — Group 1: Client UI screens
import 'package:reservatior/features/client/compare_list/presentation/compare_list_screen.dart';
import 'package:reservatior/features/client/mls_integrations/presentation/mls_integrations_screen.dart';
import 'package:reservatior/features/client/reports/presentation/reports_suite_screen.dart';

// Faz E — Group 2: Lifestyle screens
import 'package:reservatior/features/client/concierge/presentation/concierge_screen.dart';
import 'package:reservatior/features/client/experiences/presentation/experiences_screen.dart';
import 'package:reservatior/features/client/hoa/presentation/hoa_screen.dart';
import 'package:reservatior/features/client/hospitality_standards/presentation/hospitality_standards_screen.dart';
import 'package:reservatior/features/client/smart_devices/presentation/smart_devices_screen.dart';
import 'package:reservatior/features/client/ambassadors/presentation/ambassadors_screen.dart';
import 'package:reservatior/features/client/b2b_hotels/presentation/b2b_hotels_screen.dart';

// Faz E — Group 3: OS Dashboards
import 'package:reservatior/features/os_dashboards/presentation/os_dashboards.dart';
import 'package:reservatior/features/os_dashboards/presentation/os_dashboards_2.dart';
import 'package:reservatior/features/insurance_os/presentation/insurance_os_dashboard_page.dart';
import 'package:reservatior/features/rental_finance_os/presentation/rental_finance_os_dashboard_page.dart';

// Faz F — Global Hybrid Rental OS
import 'package:reservatior/features/global_rental_os/presentation/pages/global_rental_os_dashboard_page.dart';
import 'package:reservatior/features/global_rental_os/presentation/pages/country_intelligence_page.dart';
import 'package:reservatior/features/global_rental_os/presentation/pages/global_hybrid_rental_saga_page.dart';
import 'package:reservatior/features/global_rental_os/presentation/pages/global_revenue_simulation_page.dart';
import 'package:reservatior/features/global_rental_os/presentation/pages/global_partner_network_page.dart';




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
    final deepLinkService = DeepLinkService(router: _router);
    await deepLinkService.init();
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
    GoRoute(path: '/verify-email', builder: (_, __) => const VerifyEmailScreen()),
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
          builder: (_, __) => const TasksScreen(),
        ),
        GoRoute(
          path: '/calendar', 
          builder: (_, __) => const CalendarScreen(),
        ),
        GoRoute(path: '/booking-center', builder: (_, __) => const NeuralBookingCenter()),
        GoRoute(path: '/ai-valuation', builder: (_, __) => const AiValuationScreen()),
        GoRoute(path: '/appointments', builder: (_, __) => const AppointmentsScreen()),
        GoRoute(path: '/portfolio', builder: (_, __) => const PortfolioScreen()),
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
        // Commerce OS explicit routes
        GoRoute(path: '/products', builder: (_, __) => const ProductsScreen()),
        GoRoute(path: '/suppliers', builder: (_, __) => const SuppliersScreen()),
        GoRoute(path: '/bundles', builder: (_, __) => const BundlesScreen()),
        GoRoute(path: '/campaigns', builder: (_, __) => const CampaignsScreen()),
        // Intelligence Passports explicit routes
        GoRoute(path: '/property-passport', builder: (_, __) => const PropertyPassportScreen()),
        GoRoute(path: '/market-passport', builder: (_, __) => const MarketPassportScreen()),
        GoRoute(path: '/user-passport', builder: (_, __) => const UserPassportScreen()),
        GoRoute(path: '/agent-passport', builder: (_, __) => const AgentPassportScreen()),
        GoRoute(path: '/intelligence-graph', builder: (_, __) => const IntelligenceGraphScreen()),
        GoRoute(path: '/content-publisher', builder: (_, __) => const ContentPublisherScreen()),
        GoRoute(path: '/decision-engine', builder: (_, __) => const DecisionEngineScreen()),
        GoRoute(path: '/feedback-loop', builder: (_, __) => const FeedbackLoopScreen()),
        GoRoute(path: '/revenue-intelligence', builder: (_, __) => const RevenueIntelligenceScreen()),
        GoRoute(path: '/seo-generator', builder: (_, __) => const SEOGeneratorScreen()),
        GoRoute(path: '/certificates', builder: (_, __) => const CertificatesScreen()),
        GoRoute(path: '/edevlet-contract', builder: (_, __) => const EDevletContractWizard()),
        GoRoute(path: '/hybrid-rental-os', builder: (_, __) => const HybridRentalOSModuleScreen()),
        GoRoute(path: '/hybrid-rental-engine', builder: (_, __) => const HybridRentalEngineScreen()),
        GoRoute(path: '/global-hybrid-rental-os', builder: (_, __) => const GlobalHybridRentalOSScreen()),
        GoRoute(path: '/gmsi-tax-report', builder: (_, __) => const GMSITaxReportScreen()),
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
        GoRoute(path: '/ai-studio', builder: (_, __) => const AIStudioScreen()),
        GoRoute(path: '/ai-chat', builder: (_, __) => const AiChatScreen()),
        GoRoute(path: '/ai-recommendations', builder: (_, __) => DynamicAdminScreen(modelName: 'AiRecommendations')),
        GoRoute(path: '/invest/roi', builder: (_, __) => const RoiCalculatorScreen()),
        GoRoute(path: '/invest/yield', builder: (_, __) => const RentalYieldScreen()),
        GoRoute(path: '/invest/compare', builder: (_, __) => const CompareScreen()),
        GoRoute(path: '/deals', builder: (_, __) => const DealsScreen()),
        GoRoute(path: '/communications', builder: (_, __) => const CommunicationsScreen()),
        GoRoute(path: '/communication-templates', builder: (_, __) => const CommunicationsScreen(initialTab: 1)),
        GoRoute(path: '/financial', builder: (_, __) => const FinancialScreen()),
        GoRoute(path: '/invoices', builder: (_, __) => const FinancialScreen()),
        GoRoute(path: '/transactions', builder: (_, __) => const FinancialScreen()),
        GoRoute(path: '/escrow', builder: (_, __) => const FinancialScreen(initialTab: 1)),
        GoRoute(path: '/legal', builder: (_, __) => const LegalScreen()),
        GoRoute(path: '/documents', builder: (_, __) => const LegalScreen()),
        GoRoute(path: '/signatures', builder: (_, __) => const LegalScreen(initialTab: 1)),
        GoRoute(path: '/today', builder: (_, __) => const CalendarScreen(todayFocus: true)),
        GoRoute(path: '/rent-schedule', builder: (_, __) => const RentManagementScreen()),
        GoRoute(path: '/rent-arrears', builder: (_, __) => const RentManagementScreen(initialTab: 1)),
        GoRoute(path: '/support', builder: (_, __) => DynamicAdminScreen(modelName: 'Support')),
        GoRoute(path: '/integrations', builder: (_, __) => DynamicAdminScreen(modelName: 'Integrations')),
        GoRoute(path: '/organization', builder: (_, __) => DynamicAdminScreen(modelName: 'Organization')),
        GoRoute(path: '/dashboard-widgets', builder: (_, __) => DynamicAdminScreen(modelName: 'DashboardWidgets')),
        GoRoute(path: '/contact', builder: (_, __) => DynamicAdminScreen(modelName: 'Contact')),
        GoRoute(path: '/pricing', builder: (_, __) => DynamicAdminScreen(modelName: 'Pricing')),
        GoRoute(path: '/privacy', builder: (_, __) => policy.LegalScreen(title: 'mobile.auto.privacy_policy'.tr(), type: 'privacy')),
        GoRoute(path: '/terms', builder: (_, __) => policy.LegalScreen(title: 'mobile.auto.terms_of_service'.tr(), type: 'terms')),
        GoRoute(path: '/trust-center', builder: (_, __) => policy.LegalScreen(title: 'mobile.auto.trust_center'.tr(), type: 'trust')),
        GoRoute(path: '/channels', builder: (_, __) => const ChannelsScreen()),
        GoRoute(path: '/listing-promotion', builder: (_, __) => const ListingPromotionScreen()),
        GoRoute(path: '/membership', builder: (_, __) => const LoyaltyScreen()),
        GoRoute(path: '/loyalty', builder: (_, __) => const LoyaltyScreen()),
        GoRoute(path: '/facilities', builder: (_, __) => const FacilitiesScreen()),
        GoRoute(path: '/maintenance', builder: (_, __) => const MaintenanceScreen()),
        GoRoute(path: '/agent-profile', builder: (_, __) => DynamicAdminScreen(modelName: 'AgentProfile')),
        GoRoute(path: '/listings', builder: (_, __) => const ListingsScreen()),
        GoRoute(path: '/analytics', builder: (_, __) => DynamicAdminScreen(modelName: 'Analytics')),
        GoRoute(path: '/leads', builder: (_, __) => const LeadsScreen()),
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
        GoRoute(path: '/investment-os', builder: (_, __) => const InvestmentOsDashboardPage()),
        GoRoute(path: '/crm-os', builder: (_, __) => const CrmOsDashboardPage()),
        GoRoute(path: '/marketing-os', builder: (_, __) => const MarketingOsDashboardPage()),
        GoRoute(path: '/document-os', builder: (_, __) => const DocumentOsDashboardPage()),
        GoRoute(path: '/contract-generator', builder: (_, __) => const ContractGeneratorPage()),
        GoRoute(path: '/identity-os', builder: (_, __) => const IdentityOsDashboardPage()),
        GoRoute(path: '/analytics-os', builder: (_, __) => const AnalyticsOsDashboardPage()),
        GoRoute(path: '/operations-os', builder: (_, __) => const OperationsOsDashboard()),
        // Faz E — Group 1: Client UI screens
        GoRoute(path: '/compare-list', builder: (_, __) => const CompareListScreen()),
        GoRoute(path: '/mls-integrations', builder: (_, __) => const MlsIntegrationsScreen()),
        GoRoute(path: '/reports', builder: (_, __) => const ReportsSuiteScreen()),
        // Faz E — Group 2: Lifestyle screens
        GoRoute(path: '/concierge', builder: (_, __) => const ConciergeScreen()),
        GoRoute(path: '/experiences', builder: (_, __) => const ExperiencesScreen()),
        GoRoute(path: '/hoa', builder: (_, __) => const HoaScreen()),
        GoRoute(path: '/hospitality-standards', builder: (_, __) => const HospitalityStandardsScreen()),
        GoRoute(path: '/smart-devices', builder: (_, __) => const SmartDevicesScreen()),
        GoRoute(path: '/ambassadors', builder: (_, __) => const AmbassadorsScreen()),
        GoRoute(path: '/b2b-hotels', builder: (_, __) => const B2bHotelsScreen()),
        // Faz E — Group 3: OS Dashboards
        GoRoute(path: '/ads-os', builder: (_, __) => const AdsOsDashboard()),
        GoRoute(path: '/ai-os', builder: (_, __) => const AiOsDashboard()),
        GoRoute(path: '/commerce-os', builder: (_, __) => const CommerceOsDashboard()),
        GoRoute(path: '/consent-os', builder: (_, __) => const ConsentOsDashboard()),
        GoRoute(path: '/devapi-os', builder: (_, __) => const DevApiOsDashboard()),
        GoRoute(path: '/developer-os', builder: (_, __) => const DeveloperOsDashboard()),
        GoRoute(path: '/governance-os', builder: (_, __) => const GovernanceOsDashboard()),
        GoRoute(path: '/notification-os', builder: (_, __) => const NotificationOsDashboard()),
        GoRoute(path: '/partner-os', builder: (_, __) => const PartnerOsDashboard()),
        GoRoute(path: '/security-os', builder: (_, __) => const SecurityOsDashboard()),
        GoRoute(path: '/trust-os', builder: (_, __) => const TrustOsDashboard()),
        GoRoute(path: '/user-os', builder: (_, __) => const UserOsDashboard()),
        GoRoute(path: '/localization-os', builder: (_, __) => const LocalizationOsDashboard()),
        GoRoute(path: '/insurance-os', builder: (_, __) => const InsuranceOsDashboardPage()),
        GoRoute(path: '/rental-finance-os', builder: (_, __) => const RentalFinanceOsDashboardPage()),
        // Global Hybrid Rental OS
        GoRoute(path: '/global-rental-os', builder: (_, __) => const GlobalRentalOsDashboardPage()),
        GoRoute(path: '/global-rental-os/countries', builder: (_, __) => const CountryIntelligencePage()),
        GoRoute(path: '/global-rental-os/saga', builder: (_, __) => const GlobalHybridRentalSagaPage()),
        GoRoute(path: '/global-rental-os/revenue', builder: (_, __) => const GlobalRevenueSimulationPage()),
        GoRoute(path: '/global-rental-os/partners', builder: (_, __) => const GlobalPartnerNetworkPage()),
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
