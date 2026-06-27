import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/navigation/role_based_router.dart';
import 'package:reservatior/core/navigation/feature_groups.dart';
import 'package:reservatior/shared/enums/member_role_key.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/features/auth/presentation/screens/login_screen.dart';
import 'package:reservatior/features/client/home/presentation/screens/home_screen.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/features/client/booking/presentation/screens/checkout_screen.dart';
import 'package:reservatior/features/admin/escrow/presentation/screens/escrow_dashboard_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Admin routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminUsers = '/admin/users';
  static const String adminOrganizations = '/admin/organizations';
  static const String adminSystem = '/admin/system';
  static const String adminAI = '/admin/ai';
  static const String adminFinancial = '/admin/financial';
  static const String adminReports = '/admin/reports';

  // Generated Admin Routes
  static const String adminAccount = '/admin/account';
  static const String adminAchievement = '/admin/achievement';
  static const String adminAmbassadorContract = '/admin/ambassador-contract';
  static const String adminAmenity = '/admin/amenity';
  static const String adminAnalysisJob = '/admin/analysis-job';
  static const String adminAnalytics = '/admin/analytics';
  static const String adminApiIntegration = '/admin/api-integration';
  static const String adminApiKey = '/admin/api-key';
  static const String adminAppointment = '/admin/appointment';
  static const String adminAttachment = '/admin/attachment';
  static const String adminAttorneyManagement = '/admin/attorney-management';
  static const String adminAutomationExecution = '/admin/automation-execution';
  static const String adminAutomationRule = '/admin/automation-rule';
  static const String adminBooking = '/admin/booking';
  static const String adminBrandAmbassador = '/admin/brand-ambassador';
  static const String adminCalendarEvent = '/admin/calendar-event';
  static const String adminChannel = '/admin/channel';
  static const String adminClientRelationship = '/admin/client-relationship';
  static const String adminContract = '/admin/contract';
  static const String adminContractVersion = '/admin/contract-version';
  static const String adminCoupons = '/admin/coupons';
  static const String adminCurrency = '/admin/currency';

  static const String adminDashboardConfiguration =
      '/admin/dashboard-configuration';
  static const String adminDashboardWidget = '/admin/dashboard-widget';
  static const String adminDeal = '/admin/deal';
  static const String adminDepositProtection = '/admin/deposit-protection';
  static const String adminDiscount = '/admin/discount';
  static const String adminEarning = '/admin/earning';
  static const String adminEvent = '/admin/event';
  static const String adminEventAttendee = '/admin/event-attendee';
  static const String adminExchangeRate = '/admin/exchange-rate';
  static const String adminExportFile = '/admin/export-file';
  static const String adminExportJob = '/admin/export-job';
  static const String adminExternalRentalListing =
      '/admin/external-rental-listing';
  static const String adminExtraCharge = '/admin/extra-charge';
  static const String adminFavorite = '/admin/favorite';
  static const String adminFilters = '/admin/filters';
  static const String adminFloorPlan = '/admin/floor-plan';
  static const String adminGiftCard = '/admin/gift-card';
  static const String adminGovernmentIntegration =
      '/admin/government-integration';
  static const String adminGuest = '/admin/guest';
  static const String adminGuestProfile = '/admin/guest-profile';
  static const String adminGuestReview = '/admin/guest-review';
  static const String adminHashtag = '/admin/hashtag';
  static const String adminHealthCheck = '/admin/health-check';
  static const String adminHome = '/admin/home';
  static const String adminHomeInformationPack = '/admin/home-information-pack';
  static const String adminImmigrationStatusCheck =
      '/admin/immigration-status-check';
  static const String adminIncludedService = '/admin/included-service';
  static const String adminIncrease = '/admin/increase';
  static const String adminIntegrationLog = '/admin/integration-log';
  static const String adminInvestorPortfolio = '/admin/investor-portfolio';
  static const String adminJob = '/admin/job';
  static const String adminKeyManagement = '/admin/key-management';
  static const String adminLead = '/admin/lead';
  static const String adminLeadSource = '/admin/lead-source';
  static const String adminLedgerEntry = '/admin/ledger-entry';
  static const String adminListing = '/admin/listing';
  static const String adminListingChannel = '/admin/listing-channel';
  static const String adminListingStatusHistory =
      '/admin/listing-status-history';
  static const String adminListingTag = '/admin/listing-tag';
  static const String adminLocation = '/admin/location';
  static const String adminLoyaltyAccount = '/admin/loyalty-account';
  static const String adminMapData = '/admin/map-data';
  static const String adminMapLayer = '/admin/map-layer';
  static const String adminMarketplace = '/admin/marketplace';
  static const String adminMention = '/admin/mention';
  static const String adminMessage = '/admin/message';
  static const String adminMlConfiguration = '/admin/ml-configuration';
  static const String adminMlModel = '/admin/ml-model';
  static const String adminMlsConnection = '/admin/mls-connection';
  static const String adminMlsDataMapping = '/admin/mls-data-mapping';
  static const String adminMlsExternalListing = '/admin/mls-external-listing';
  static const String adminMlsListingEnhancement =
      '/admin/mls-listing-enhancement';
  static const String adminMlsSyncJob = '/admin/mls-sync-job';
  static const String adminMobileDevice = '/admin/mobile-device';
  static const String adminMore = '/admin/more';
  static const String adminNegotiationOffer = '/admin/negotiation-offer';
  static const String adminNeighborhood = '/admin/neighborhood';
  static const String adminNotification = '/admin/notification';
  static const String adminOffer = '/admin/offer';
  static const String adminOfflineSyncQueue = '/admin/offline-sync-queue';
  static const String adminOrgSubscription = '/admin/org-subscription';
  static const String adminPerformanceAlert = '/admin/performance-alert';
  static const String adminPermission = '/admin/permission';
  static const String adminPhoto = '/admin/photo';
  static const String adminPlan = '/admin/plan';
  static const String adminPost = '/admin/post';
  static const String adminPredictiveModel = '/admin/predictive-model';
  static const String adminPricingRule = '/admin/pricing-rule';
  static const String adminProject = '/admin/project';
  static const String adminProjectAlert = '/admin/project-alert';
  static const String adminProjectAnalytics = '/admin/project-analytics';
  static const String adminProjectReport = '/admin/project-report';
  static const String adminQueueConfiguration = '/admin/queue-configuration';
  static const String adminQueueMessage = '/admin/queue-message';
  static const String adminQuote = '/admin/quote';
  static const String adminRecommendationResult =
      '/admin/recommendation-result';
  static const String adminReferenceSource = '/admin/reference-source';
  static const String adminReferral = '/admin/referral';
  static const String adminRentArrears = '/admin/rent-arrears';
  static const String adminRentSchedule = '/admin/rent-schedule';
  static const String adminRentalSyncJob = '/admin/rental-sync-job';
  static const String adminReport = '/admin/report';
  static const String adminReportExecution = '/admin/report-execution';
  static const String adminReview = '/admin/review';
  static const String adminRightToRentCheck = '/admin/right-to-rent-check';
  static const String adminRoute = '/admin/route';
  static const String adminScrapingJob = '/admin/scraping-job';
  static const String adminSession = '/admin/session';
  static const String adminSharedAmenity = '/admin/shared-amenity';
  static const String adminSignatureRequest = '/admin/signature-request';
  static const String adminSignatureSigner = '/admin/signature-signer';
  static const String adminSocialImpactCounter = '/admin/social-impact-counter';
  static const String adminSocialImpactRecord = '/admin/social-impact-record';
  static const String adminSolicitorManagement = '/admin/solicitor-management';
  static const String adminSubscription = '/admin/subscription';
  static const String adminTag = '/admin/tag';
  static const String adminTicket = '/admin/ticket';
  static const String adminUser = '/admin/user';
  static const String adminUserActivityLog = '/admin/user-activity-log';
  static const String adminUserPreference = '/admin/user-preference';
  static const String adminVacationRental = '/admin/vacation-rental';
  static const String adminVacationRentalPlatform =
      '/admin/vacation-rental-platform';
  static const String adminVerification = '/admin/verification';
  static const String adminVideoContent = '/admin/video-content';
  static const String adminVirtualTour = '/admin/virtual-tour';
  static const String adminWebhook = '/admin/webhook';
  static const String adminWebhookDelivery = '/admin/webhook-delivery';
  static const String adminWelcome = '/admin/welcome';

  // Client routes
  static const String clientDashboard = '/client/dashboard';
  static const String propertySearch = '/client/properties';
  static const String bookings = '/client/bookings';
  static const String reservations = '/client/reservations';
  static const String payments = '/client/payments';
  static const String documents = '/client/documents';
  static const String neighborhoodDNA = '/client/neighborhood-dna';

  static GoRouter createRouter({required MemberRoleKey userRole}) {
    return GoRouter(
      initialLocation: login,
      routes: [
        // Authentication routes
        GoRoute(
          path: splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(path: login, builder: (context, state) => const LoginScreen()),

        // Main routes based on role
        if (RoleBasedRouter.isAdminRole(userRole)) ...[
          // Admin routes
          GoRoute(
            path: adminDashboard,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('dashboard', userRole),
          ),
          GoRoute(
            path: adminUsers,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('users', userRole),
          ),
          GoRoute(
            path: adminOrganizations,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('organizations', userRole),
          ),
          GoRoute(
            path: adminSystem,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('system_settings', userRole),
          ),
          GoRoute(
            path: adminAI,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('ai_config', userRole),
          ),
          GoRoute(
            path: adminFinancial,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'financial_management',
              userRole,
            ),
          ),
          GoRoute(
            path: adminReports,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('reports', userRole),
          ),

          // Generated Admin Routes
          GoRoute(
            path: '/admin/escrow',
            builder: (context, state) => const EscrowDashboardScreen(),
          ),
          GoRoute(
            path: adminAccount,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('account', userRole),
          ),
          GoRoute(
            path: adminAchievement,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('achievement', userRole),
          ),
          GoRoute(
            path: adminAmbassadorContract,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'ambassador_contract',
              userRole,
            ),
          ),
          GoRoute(
            path: adminAmenity,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('amenity', userRole),
          ),
          GoRoute(
            path: adminAnalysisJob,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('analysis_job', userRole),
          ),
          GoRoute(
            path: adminAnalytics,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('analytics', userRole),
          ),
          GoRoute(
            path: adminApiIntegration,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('api_integration', userRole),
          ),
          GoRoute(
            path: adminApiKey,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('api_key', userRole),
          ),
          GoRoute(
            path: adminAppointment,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('appointment', userRole),
          ),
          GoRoute(
            path: adminAttachment,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('attachment', userRole),
          ),
          GoRoute(
            path: adminAttorneyManagement,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'attorney_management',
              userRole,
            ),
          ),
          GoRoute(
            path: adminAutomationExecution,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'automation_execution',
              userRole,
            ),
          ),
          GoRoute(
            path: adminAutomationRule,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('automation_rule', userRole),
          ),
          GoRoute(
            path: adminBooking,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('booking', userRole),
          ),
          GoRoute(
            path: adminBrandAmbassador,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('brand_ambassador', userRole),
          ),
          GoRoute(
            path: adminCalendarEvent,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('calendar_event', userRole),
          ),
          GoRoute(
            path: adminChannel,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('channel', userRole),
          ),
          GoRoute(
            path: adminClientRelationship,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'client_relationship',
              userRole,
            ),
          ),
          GoRoute(
            path: adminContract,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('contract', userRole),
          ),
          GoRoute(
            path: adminContractVersion,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('contract_version', userRole),
          ),
          GoRoute(
            path: adminCoupons,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('coupons', userRole),
          ),
          GoRoute(
            path: adminCurrency,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('currency', userRole),
          ),
          GoRoute(
            path: adminDashboard,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('dashboard', userRole),
          ),
          GoRoute(
            path: adminDashboardConfiguration,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'dashboard_configuration',
              userRole,
            ),
          ),
          GoRoute(
            path: adminDashboardWidget,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('dashboard_widget', userRole),
          ),
          GoRoute(
            path: adminDeal,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('deal', userRole),
          ),
          GoRoute(
            path: adminDepositProtection,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'deposit_protection',
              userRole,
            ),
          ),
          GoRoute(
            path: adminDiscount,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('discount', userRole),
          ),
          GoRoute(
            path: adminEarning,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('earning', userRole),
          ),
          GoRoute(
            path: adminEvent,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('event', userRole),
          ),
          GoRoute(
            path: adminEventAttendee,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('event_attendee', userRole),
          ),
          GoRoute(
            path: adminExchangeRate,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('exchange_rate', userRole),
          ),
          GoRoute(
            path: adminExportFile,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('export_file', userRole),
          ),
          GoRoute(
            path: adminExportJob,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('export_job', userRole),
          ),
          GoRoute(
            path: adminExternalRentalListing,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'external_rental_listing',
              userRole,
            ),
          ),
          GoRoute(
            path: adminExtraCharge,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('extra_charge', userRole),
          ),
          GoRoute(
            path: adminFavorite,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('favorite', userRole),
          ),
          GoRoute(
            path: adminFilters,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('filters', userRole),
          ),
          GoRoute(
            path: adminFloorPlan,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('floor_plan', userRole),
          ),
          GoRoute(
            path: adminGiftCard,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('gift_card', userRole),
          ),
          GoRoute(
            path: adminGovernmentIntegration,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'government_integration',
              userRole,
            ),
          ),
          GoRoute(
            path: adminGuest,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('guest', userRole),
          ),
          GoRoute(
            path: adminGuestProfile,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('guest_profile', userRole),
          ),
          GoRoute(
            path: adminGuestReview,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('guest_review', userRole),
          ),
          GoRoute(
            path: adminHashtag,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('hashtag', userRole),
          ),
          GoRoute(
            path: adminHealthCheck,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('health_check', userRole),
          ),
          GoRoute(
            path: adminHome,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('home', userRole),
          ),
          GoRoute(
            path: adminHomeInformationPack,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'home_information_pack',
              userRole,
            ),
          ),
          GoRoute(
            path: adminImmigrationStatusCheck,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'immigration_status_check',
              userRole,
            ),
          ),
          GoRoute(
            path: adminIncludedService,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('included_service', userRole),
          ),
          GoRoute(
            path: adminIncrease,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('increase', userRole),
          ),
          GoRoute(
            path: adminIntegrationLog,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('integration_log', userRole),
          ),
          GoRoute(
            path: adminInvestorPortfolio,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'investor_portfolio',
              userRole,
            ),
          ),
          GoRoute(
            path: adminJob,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('job', userRole),
          ),
          GoRoute(
            path: adminKeyManagement,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('key_management', userRole),
          ),
          GoRoute(
            path: adminLead,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('lead', userRole),
          ),
          GoRoute(
            path: adminLeadSource,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('lead_source', userRole),
          ),
          GoRoute(
            path: adminLedgerEntry,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('ledger_entry', userRole),
          ),
          GoRoute(
            path: adminListing,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('listing', userRole),
          ),
          GoRoute(
            path: adminListingChannel,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('listing_channel', userRole),
          ),
          GoRoute(
            path: adminListingStatusHistory,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'listing_status_history',
              userRole,
            ),
          ),
          GoRoute(
            path: adminListingTag,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('listing_tag', userRole),
          ),
          GoRoute(
            path: adminLocation,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('location', userRole),
          ),
          GoRoute(
            path: adminLoyaltyAccount,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('loyalty_account', userRole),
          ),
          GoRoute(
            path: adminMapData,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('map_data', userRole),
          ),
          GoRoute(
            path: adminMapLayer,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('map_layer', userRole),
          ),
          GoRoute(
            path: adminMarketplace,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('marketplace', userRole),
          ),
          GoRoute(
            path: adminMention,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('mention', userRole),
          ),
          GoRoute(
            path: adminMessage,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('message', userRole),
          ),
          GoRoute(
            path: adminMlConfiguration,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('ml_configuration', userRole),
          ),
          GoRoute(
            path: adminMlModel,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('ml_model', userRole),
          ),
          GoRoute(
            path: adminMlsConnection,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('mls_connection', userRole),
          ),
          GoRoute(
            path: adminMlsDataMapping,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('mls_data_mapping', userRole),
          ),
          GoRoute(
            path: adminMlsExternalListing,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'mls_external_listing',
              userRole,
            ),
          ),
          GoRoute(
            path: adminMlsListingEnhancement,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'mls_listing_enhancement',
              userRole,
            ),
          ),
          GoRoute(
            path: adminMlsSyncJob,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('mls_sync_job', userRole),
          ),
          GoRoute(
            path: adminMobileDevice,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('mobile_device', userRole),
          ),
          GoRoute(
            path: adminMore,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('more', userRole),
          ),
          GoRoute(
            path: adminNegotiationOffer,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('negotiation_offer', userRole),
          ),
          GoRoute(
            path: adminNeighborhood,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('neighborhood', userRole),
          ),
          GoRoute(
            path: adminNotification,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('notification', userRole),
          ),
          GoRoute(
            path: adminOffer,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('offer', userRole),
          ),
          GoRoute(
            path: adminOfflineSyncQueue,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'offline_sync_queue',
              userRole,
            ),
          ),
          GoRoute(
            path: adminOrgSubscription,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('org_subscription', userRole),
          ),
          GoRoute(
            path: adminPerformanceAlert,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('performance_alert', userRole),
          ),
          GoRoute(
            path: adminPermission,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('permission', userRole),
          ),
          GoRoute(
            path: adminPhoto,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('photo', userRole),
          ),
          GoRoute(
            path: adminPlan,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('plan', userRole),
          ),
          GoRoute(
            path: adminPost,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('post', userRole),
          ),
          GoRoute(
            path: adminPredictiveModel,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('predictive_model', userRole),
          ),
          GoRoute(
            path: adminPricingRule,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('pricing_rule', userRole),
          ),
          GoRoute(
            path: adminProject,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('project', userRole),
          ),
          GoRoute(
            path: adminProjectAlert,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('project_alert', userRole),
          ),
          GoRoute(
            path: adminProjectAnalytics,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('project_analytics', userRole),
          ),
          GoRoute(
            path: adminProjectReport,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('project_report', userRole),
          ),
          GoRoute(
            path: adminQueueConfiguration,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'queue_configuration',
              userRole,
            ),
          ),
          GoRoute(
            path: adminQueueMessage,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('queue_message', userRole),
          ),
          GoRoute(
            path: adminQuote,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('quote', userRole),
          ),
          GoRoute(
            path: adminRecommendationResult,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'recommendation_result',
              userRole,
            ),
          ),
          GoRoute(
            path: adminReferenceSource,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('reference_source', userRole),
          ),
          GoRoute(
            path: adminReferral,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('referral', userRole),
          ),
          GoRoute(
            path: adminRentArrears,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('rent_arrears', userRole),
          ),
          GoRoute(
            path: adminRentSchedule,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('rent_schedule', userRole),
          ),
          GoRoute(
            path: adminRentalSyncJob,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('rental_sync_job', userRole),
          ),
          GoRoute(
            path: adminReport,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('report', userRole),
          ),
          GoRoute(
            path: adminReportExecution,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('report_execution', userRole),
          ),
          GoRoute(
            path: adminReview,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('review', userRole),
          ),
          GoRoute(
            path: adminRightToRentCheck,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'right_to_rent_check',
              userRole,
            ),
          ),
          GoRoute(
            path: adminRoute,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('route', userRole),
          ),
          GoRoute(
            path: adminScrapingJob,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('scraping_job', userRole),
          ),
          GoRoute(
            path: adminSession,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('session', userRole),
          ),
          GoRoute(
            path: adminSharedAmenity,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('shared_amenity', userRole),
          ),
          GoRoute(
            path: adminSignatureRequest,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('signature_request', userRole),
          ),
          GoRoute(
            path: adminSignatureSigner,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('signature_signer', userRole),
          ),
          GoRoute(
            path: adminSocialImpactCounter,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'social_impact_counter',
              userRole,
            ),
          ),
          GoRoute(
            path: adminSocialImpactRecord,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'social_impact_record',
              userRole,
            ),
          ),
          GoRoute(
            path: adminSolicitorManagement,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'solicitor_management',
              userRole,
            ),
          ),
          GoRoute(
            path: adminSubscription,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('subscription', userRole),
          ),
          GoRoute(
            path: adminTag,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('tag', userRole),
          ),
          GoRoute(
            path: adminTicket,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('ticket', userRole),
          ),
          GoRoute(
            path: adminUser,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('user', userRole),
          ),
          GoRoute(
            path: adminUserActivityLog,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('user_activity_log', userRole),
          ),
          GoRoute(
            path: adminUserPreference,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('user_preference', userRole),
          ),
          GoRoute(
            path: adminVacationRental,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('vacation_rental', userRole),
          ),
          GoRoute(
            path: adminVacationRentalPlatform,
            builder: (context, state) => RoleBasedRouter.getRoleBasedPage(
              'vacation_rental_platform',
              userRole,
            ),
          ),
          GoRoute(
            path: adminVerification,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('verification', userRole),
          ),
          GoRoute(
            path: adminVideoContent,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('video_content', userRole),
          ),
          GoRoute(
            path: adminVirtualTour,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('virtual_tour', userRole),
          ),
          GoRoute(
            path: adminWebhook,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('webhook', userRole),
          ),
          GoRoute(
            path: adminWebhookDelivery,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('webhook_delivery', userRole),
          ),
          GoRoute(
            path: adminWelcome,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('welcome', userRole),
          ),
        ] else ...[
          // Client routes
          GoRoute(
            path: clientDashboard,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('dashboard', userRole),
          ),
          GoRoute(
            path: propertySearch,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('property_search', userRole),
          ),
          GoRoute(
            path: bookings,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('bookings', userRole),
          ),
          GoRoute(
            path: reservations,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('reservations', userRole),
          ),
          GoRoute(
            path: payments,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('payments', userRole),
          ),
          GoRoute(
            path: documents,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('documents', userRole),
          ),
          GoRoute(
            path: neighborhoodDNA,
            builder: (context, state) =>
                RoleBasedRouter.getRoleBasedPage('neighborhood_dna', userRole),
          ),
        ],

        // Common routes
        GoRoute(
          path: profile,
          builder: (context, state) =>
              RoleBasedRouter.getRoleBasedPage('profile', userRole),
        ),
        GoRoute(
          path: settings,
          builder: (context, state) =>
              RoleBasedRouter.getRoleBasedPage('settings', userRole),
        ),
        GoRoute(
          path: '/checkout/:id',
          builder: (context, state) {
            final propertyId = state.pathParameters['id']!;
            final property = state.extra as Property;
            return CheckoutScreen(propertyId: propertyId, property: property);
          },
        ),
      ],
      redirect: (context, state) {
        // Add authentication logic here
        return null;
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            Text(
              'mobile.auto.reservatior'.tr(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
