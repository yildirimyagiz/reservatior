// API Endpoints configuration for Elysia Server Integration
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // Base URL - Development - Loads from .env file
  static String get baseUrl {
    if (dotenv.isInitialized) {
      return dotenv.env['API_BASE_URL'] ?? 
             const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');
    }
    return const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');
  }
  
  static String get _apiPrefix => '$baseUrl/api/v1';
  
  // Health check (public endpoint - no auth required)
  static String get health => '$baseUrl/health';
  
  // Auth endpoints
  static String get auth => '$_apiPrefix/auth';
  static String get register => '$auth/register';
  static String get login => '$auth/login';
  static String get logout => '$auth/logout';
  static String get me => '$auth/me';
  static String get changePassword => '$auth/change-password';
  static String get tokens => '$auth/tokens';
  static String get verifications => '$auth/verifications';
  static String get attachments => '$auth/attachments';
  
  // Core Business endpoints
  static String get organizations => '$_apiPrefix/organization';
  static String get users => '$_apiPrefix/user';
  static String get contacts => '$_apiPrefix/contact';
  static String get leads => '$_apiPrefix/lead';
  static String get deals => '$_apiPrefix/deal';
  static String get commissions => '$_apiPrefix/commission';
  
  // Property & Listing endpoints
  static String get properties => '$_apiPrefix/property';
  static String get listings => '$_apiPrefix/listing';
  static String get listingChannels => '$listings/channels';
  static String get listingTags => '$_apiPrefix/listing-tag';
  static String get mlsEnhancements => '$listings/mls-enhancements';
  static String get bookings => '$_apiPrefix/booking';
  static String get leases => '$_apiPrefix/lease';
  static String get reservations => '$_apiPrefix/reservation';
  static String get contracts => '$_apiPrefix/contract';
  static String get accounts => '$_apiPrefix/accounts';
  static String get roles => '$_apiPrefix/roles';
  static String get amenities => '$_apiPrefix/amenities';
  static String get propertyDocuments => '$_apiPrefix/property-document';
  static String get clientRelationships => '$_apiPrefix/client-relationships';
  static String get propertyFeatures => '$_apiPrefix/property-features';
  static String get categories => '$_apiPrefix/categories';
  static String get marketIntelligence => '$_apiPrefix/market-intelligence';
  static String get triggerAiService => '$marketIntelligence/trigger-ai-service';
  
  // New Property Valuation endpoints
  static String get valuations => '$_apiPrefix/valuations';
  static String get ownershipVerifications => '$_apiPrefix/ownership-verifications';
  
  // Agent & Agency endpoints
  static String get agencies => '$_apiPrefix/agencies';
  static String get agents => '$_apiPrefix/agents';
  static String get agentAssignments => '$_apiPrefix/agent-assignments';
  static String agentById(String id) => '$agents/$id';
  static String agentPerformanceRel(String id) => '$agents/$id/performance';
  static String agentAssignmentsRel(String id) => '$agents/$id/assignments';
  static String get agentTeams => '$_apiPrefix/agent-teams';
  static String agencyById(String id) => '$agencies/$id';
  static String agencyAgents(String id) => '$agencies/$id/agents';
  static String agencyStats(String id) => '$agencies/$id/stats';
  static String agencyListings(String id) => '$agencies/$id/listings';
  
  // Dynamic Helpers
  static String analyticsDashboard(String orgId) => '$analytics/dashboard/$orgId';
  static String propertyById(String id) => '$properties/$id';
  static String bookingById(String id) => '$bookings/$id';
  static String bookingGuestReview(String id) => '$bookings/$id/guest-review';
  static String listingById(String id) => '$listings/$id';
  
  // Getters for analytics
  static String get analytics => '$_apiPrefix/analytics';
  
  // Additional endpoints needed by services
  static String get videoContents => '$_apiPrefix/video-contents';
  static String get virtualTours => '$_apiPrefix/virtual-tours';
  static String get webhooks => '$_apiPrefix/webhooks';
  static String get webhookDeliveries => '$_apiPrefix/webhook-deliveries';
  static String get tickets => '$_apiPrefix/tickets';
  static String get userActivityLogs => '$_apiPrefix/user-activity-logs';
  static String get userFinancialProfiles => '$_apiPrefix/user-financial-profiles';
  static String get userPreferences => '$_apiPrefix/user-preferences';
  static String get vacationRentalPlatforms => '$_apiPrefix/vacation-rental-platforms';
  static String get vacationRentals => '$_apiPrefix/vacation-rentals';
  static String get vendorProfiles => '$_apiPrefix/vendor-profiles';
  static String get taxDepreciations => '$_apiPrefix/tax-depreciations';
  static String get taxRecords => '$_apiPrefix/tax-record';
  static String get tenants => '$_apiPrefix/tenants';
  static String get tenantApplications => '$_apiPrefix/tenant-applications';
  static String get tax1099Forms => '$_apiPrefix/tax-1099-forms';
  
  // AI endpoints
  static String get ai => '$_apiPrefix/ai';
  static String get aiTranslate => '$ai/translate';
  static String get aiChatbotSessions => '$_apiPrefix/ai-chatbot-sessions';
  static String get aiChatHandoffs => '$_apiPrefix/ai-chat-handoffs';
  static String get aiChatMessages => '$_apiPrefix/ai-chat-messages';
  static String get aiFraudDetections => '$_apiPrefix/ai-fraud-detections';
  static String get aiImageAnalyses => '$_apiPrefix/ai-ext/image-analyses';
  static String get aiInvestmentAnalyses => '$_apiPrefix/ai-investment-analyses';
  static String get aiLeadScores => '$_apiPrefix/ai-lead-scores';
  static String get aiMarketAnalyses => '$_apiPrefix/ai-market-analyses';
  static String get aiModelDeployments => '$_apiPrefix/ai-model-deployments';
  static String get aiModels => '$_apiPrefix/ai-models';
  static String get aiPredictions => '$_apiPrefix/ai-predictions';
  static String get aiPredictiveMaintenances => '$_apiPrefix/ai-predictive-maintenances';
  static String get aiPriceOptimizations => '$_apiPrefix/ai-price-optimizations';
  static String get aiPropertyDescriptions => '$_apiPrefix/ai-property-descriptions';
  static String get aiPropertyValuations => '$_apiPrefix/ai-property-valuations';
  static String get aiRecommendations => '$_apiPrefix/ai-recommendations';
  static String get aiSentimentAnalyses => '$_apiPrefix/ai-sentiment-analyses';
  static String get aiTenantScreenings => '$_apiPrefix/ai-tenant-screenings';
  static String get aiValuationModels => '$_apiPrefix/ai-valuation-models';
  static String get aiVideos => '$_apiPrefix/video';
  
  // B2B Hotel Aggregator endpoints
  static String get b2bHotels => '$_apiPrefix/b2b-hotels';
  static String get b2bHotelSearch => '$b2bHotels/search';
  static String get b2bHotelBook => '$b2bHotels/book';
  
  // Hotel Booking Sync (B2B + Own Inventory Alternatives)
  static String get hotelBookingSync => '$_apiPrefix/hotel-booking-sync';
  static String get hotelBookingAlternatives => '$hotelBookingSync/alternatives';
  
  // AI Arbitrage & Upsell endpoints
  static String get aiArbitrage => '$_apiPrefix/ai-arbitrage';
  static String get aiArbitrageUpsell => '$aiArbitrage/upsell';
  
  // Communication endpoints
  static String get communications => '$_apiPrefix/communications';
  static String get messages => '$_apiPrefix/message';
  static String get threads => '$_apiPrefix/message/threads';
  static String get channels => '$communications/channels';
  static String get unreadCount => '$communications/unread-count';
  
  // Management endpoints
  static String get adminModeration => '$_apiPrefix/admin-moderation';
  static String get agentPerformances => '$_apiPrefix/agent-performances';
  static String get achievements => '$_apiPrefix/achievements';
  static String get ambassadorCampaigns => '$_apiPrefix/ambassador-campaigns';
  static String get ambassadorContracts => '$_apiPrefix/ambassador-contracts';
  
  // Financial endpoints
  static String get financials => '$_apiPrefix/financials';
  static String get commissionRules => '$financials/commission-rules';
  static String get earnings => '$financials/earnings';
  static String get payments => '$_apiPrefix/payments';
  static String get escrowAccounts => '$_apiPrefix/escrow-account';
  static String get escrowDisputes => '$_apiPrefix/escrow-dispute';
  static String get escrowReleases => '$_apiPrefix/escrow-release';
  static String get escrowStatusHistories => '$_apiPrefix/escrow-status-history';
  
  // Legal endpoints
  static String get legal => '$_apiPrefix/legal';
  static String get signers => '$legal/signers';
  static String get solicitors => '$legal/solicitors';
  static String get documents => '$legal/documents';
  
  // System endpoints
  static String get system => '$_apiPrefix/system';
  static String get automationExecutions => '$system/automation-executions';
  static String get automationTasks => '$system/automation-tasks';
  static String get languages => '$system/languages';
  static String get systemHealth => '$system/health';
  static String get auditLogs => '$_apiPrefix/audit-logs';
  static String get systemMetrics => '$_apiPrefix/system-metrics';
  static String get geoConfig => '$_apiPrefix/config/geo';
  
  // Most used endpoints
  static String get notifications => '$_apiPrefix/notification';
  static String get realtimeWs => '$_apiPrefix/ws';
  static String get wsToken => '$realtimeWs/token';
  static String get apiIntegrations => '$_apiPrefix/api-integration';
  static String get subscriptions => '$_apiPrefix/subscription';
  static String get analyticsEndpoint => '$_apiPrefix/analytics';
  
  // Additional frequently used endpoints
  static String get exchangeRates => '$_apiPrefix/exchange-rates';
  static String get documentAnalyses => '$_apiPrefix/document-analyses';
  static String get plans => '$_apiPrefix/plans';
  static String get rentSchedules => '$_apiPrefix/rent-schedules';
  static String get rentArrears => '$_apiPrefix/rent-arrears';
  static String get rentalSyncJobs => '$_apiPrefix/rental-sync-jobs';
  static String get referrals => '$_apiPrefix/referrals';
  static String get referenceSources => '$_apiPrefix/reference-sources';
  static String get recommendationResults => '$_apiPrefix/recommendation-results';
  static String get quotes => '$_apiPrefix/quotes';
  static String get queueMessages => '$_apiPrefix/queue-messages';
  static String get queueConfigurations => '$_apiPrefix/queue-configurations';
  static String get propertyViewings => '$_apiPrefix/property-viewing';
  static String get propertyPromotions => '$_apiPrefix/property-promotion';
  static String get propertyPhotos => '$_apiPrefix/property-photo';
  static String get propertyOffers => '$_apiPrefix/property-offer';
  static String get propertyInventories => '$_apiPrefix/property-inventory';
  static String get propertyDisclosures => '$_apiPrefix/property-disclosure';
  static String get propertyCompliances => '$_apiPrefix/property-compliance';
  static String get propertyAmenities => '$_apiPrefix/property-amenity';
  static String get projects => '$_apiPrefix/projects';
  static String get projectReports => '$_apiPrefix/project-reports';
  static String get projectAnalyticses => '$_apiPrefix/project-analyticses';
  static String get projectAlerts => '$_apiPrefix/project-alerts';
  static String get pricingRules => '$_apiPrefix/pricing-rules';
  static String get predictiveModels => '$_apiPrefix/predictive-models';
  static String get posts => '$_apiPrefix/posts';
  static String get photos => '$_apiPrefix/photos';
  static String get permissions => '$_apiPrefix/permissions';
  static String get performanceAlerts => '$_apiPrefix/performance-alerts';
  static String get payouts => '$_apiPrefix/payout';
  static String get paymentNegotiations => '$_apiPrefix/payment-negotiations';
  static String get paymentInstallments => '$_apiPrefix/payment-installments';
  static String get orgSubscriptions => '$_apiPrefix/org-subscriptions';
  static String get offlineSyncQueues => '$_apiPrefix/offline-sync-queues';
  static String get offers => '$_apiPrefix/offers';
  static String get neighborhoods => '$_apiPrefix/neighborhoods';
  static String get negotiationOffers => '$_apiPrefix/negotiation-offers';
  static String get mortgages => '$_apiPrefix/mortgages';
  static String get mortgagePreApprovals => '$_apiPrefix/mortgage-pre-approvals';
  static String get mortgageOffers => '$_apiPrefix/mortgage-offers';
  static String get mobileDevices => '$_apiPrefix/mobile-devices';
  static String get mlsSyncJobs => '$_apiPrefix/mls-sync-jobs';
  static String get mlsListingEnhancements => '$_apiPrefix/mls-listing-enhancements';
  static String get mlsExternalListings => '$_apiPrefix/mls-external-listings';
  static String get mlsDataMappings => '$_apiPrefix/mls-data-mappings';
  static String get mlsConnections => '$_apiPrefix/mls-connections';
  static String get mlModels => '$_apiPrefix/ml-models';
  static String get mlConfigurations => '$_apiPrefix/ml-configurations';
  static String get mentions => '$_apiPrefix/mentions';
  static String get marketingCampaigns => '$_apiPrefix/marketing-campaigns';
  static String get mapLayers => '$_apiPrefix/map-layers';
  static String get mapDatas => '$_apiPrefix/map-datas';
  static String get maintenanceWorkOrders => '$_apiPrefix/maintenance-work-orders';
  static String get maintenanceBlocks => '$_apiPrefix/maintenance-blocks';
  static String get loyaltyAccounts => '$_apiPrefix/loyalty-accounts';
  static String get locations => '$_apiPrefix/locations';
  static String get listingStatusHistories => '$_apiPrefix/listing-status-histories';
  static String get ledgerEntries => '$_apiPrefix/ledger-entries';
  static String get leaseRenewals => '$_apiPrefix/lease-renewals';
  static String get leadSources => '$_apiPrefix/lead-sources';
  static String get keyManagements => '$_apiPrefix/key-managements';
  static String get jobs => '$_apiPrefix/jobs';
  static String get investorProperties => '$_apiPrefix/investor-properties';
  static String get investorPortfolios => '$_apiPrefix/investor-portfolios';
  static String get integrationLogs => '$_apiPrefix/integration-logs';
  static String get increases => '$_apiPrefix/increases';
  static String get includedServices => '$_apiPrefix/included-services';
  static String get immigrationStatusChecks => '$_apiPrefix/immigration-status-checks';
  static String get homeInformationPacks => '$_apiPrefix/home-information-pack';
  static String get healthChecks => '$_apiPrefix/health-checks';
  static String get hashtags => '$_apiPrefix/hashtags';
  static String get guests => '$_apiPrefix/guests';
  static String get guestReviews => '$_apiPrefix/guest-reviews';
  static String get guestProfiles => '$_apiPrefix/guest-profiles';
  static String get governmentIntegrations => '$_apiPrefix/government-integrations';
  static String get giftCards => '$_apiPrefix/gift-cards';
  static String get floorPlans => '$_apiPrefix/floor-plan';
  static String get financialRecords => '$_apiPrefix/financial-record';
  static String get favorites => '$_apiPrefix/favorites';
  static String get facilityBlocks => '$_apiPrefix/facility-block';
  static String get facilities => '$_apiPrefix/facility';
  static String get extraCharges => '$_apiPrefix/extra-charge';
  static String get externalRentalListings => '$_apiPrefix/external-rental-listings';
  static String get exportJobs => '$_apiPrefix/export-jobs';
  static String get exportFiles => '$_apiPrefix/export-files';
  static String get expenses => '$_apiPrefix/expense';
  static String get events => '$_apiPrefix/events';
  static String get eventAttendees => '$_apiPrefix/event-attendees';
  static String get documentTemplates => '$_apiPrefix/document-templates';
  static String get discounts => '$_apiPrefix/discounts';
  static String get depositProtections => '$_apiPrefix/deposit-protections';
  static String get dashboardWidgets => '$_apiPrefix/dashboard-widgets';
  static String get dashboardConfigurations => '$_apiPrefix/dashboard-configurations';
  static String get currencies => '$_apiPrefix/currencies';
  static String get contractVersions => '$_apiPrefix/contract-versions';
  static String get complianceRecords => '$_apiPrefix/compliance-record';
  static String get communicationTemplates => '$_apiPrefix/communication-templates';
  static String get communicationLogs => '$_apiPrefix/communication-logs';
  static String get calendarEvents => '$_apiPrefix/calendar-events';
  static String get budgets => '$_apiPrefix/budget';
  static String get brandAmbassadors => '$_apiPrefix/brand-ambassadors';
  static String get availabilities => '$_apiPrefix/availabilities';
  static String get automationRules => '$_apiPrefix/automation-rules';
  static String get attorneyManagements => '$_apiPrefix/attorney-managements';
  static String get appointments => '$_apiPrefix/appointments';
  static String get apiTokens => '$_apiPrefix/api-tokens';
  static String get apiKeys => '$_apiPrefix/api-keys';
  static String get analysisJobs => '$_apiPrefix/analysis-jobs';
  static String get agentTeamMembers => '$_apiPrefix/agent-team-members';
  static String get reviews => '$_apiPrefix/reviews';
  static String get reports => '$_apiPrefix/reports';
  static String get reportExecutions => '$_apiPrefix/report-executions';
  static String get sharedAmenities => '$_apiPrefix/shared-amenities';
  static String get sessions => '$_apiPrefix/sessions';
  static String get securityDepositProtections => '$_apiPrefix/security-deposit-protections';
  static String get scrapingJobs => '$_apiPrefix/scraping-jobs';
  static String get routes => '$_apiPrefix/routes';
  static String get rolePermissions => '$_apiPrefix/role-permissions';
  static String get rightToRentChecks => '$_apiPrefix/right-to-rent-checks';
  static String get signatureSigners => '$_apiPrefix/signature-signers';
  static String get signatureRequests => '$_apiPrefix/signature-requests';
  static String get socialImpactRecords => '$_apiPrefix/social-impact-records';
  static String get socialImpactCounters => '$_apiPrefix/social-impact-counters';
  static String get solicitorManagements => '$_apiPrefix/solicitor-managements';
  static String get tax => '$_apiPrefix/tax';
  static String get tasks => '$_apiPrefix/tasks';
  static String get tags => '$_apiPrefix/tags';
  static String get systemExt => '$_apiPrefix/system-ext';
}

// Endpoint paths for relative construction
class EndpointPaths {
  static const String auth = '/auth';
  static const String users = '/users';
  static const String properties = '/properties';
  static const String listings = '/listings';
  static const String agents = '/agents';
  static const String agencies = '/agencies';
  static const String bookings = '/bookings';
  static const String leads = '/leads';
  static const String deals = '/deals';
  static const String tasks = '/tasks';
  static const String notifications = '/notifications';
  static const String analytics = '/analytics';
  static const String payments = '/payments';
  static const String financials = '/financials';
  static const String maintenance = '/maintenance';
  static const String messages = '/messages';
  static const String ai = '/ai';
}
