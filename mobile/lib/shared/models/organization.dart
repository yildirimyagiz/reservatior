import 'package:reservatior/shared/enums/compliance_type.dart';
import 'package:reservatior/shared/enums/management_fee_scope.dart';
import 'package:reservatior/shared/enums/management_fee_type.dart';
import 'package:reservatior/shared/enums/org_type.dart';
import 'package:reservatior/shared/enums/region.dart';
import 'achievement.dart';
import 'agency.dart';
import 'agent_assignment.dart';
import 'agent_team.dart';
import 'ai_chat_handoff.dart';
import 'ai_chat_message.dart';
import 'ai_chatbot_session.dart';
import 'ai_fraud_detection.dart';
import 'ai_image_analysis.dart';
import 'ai_investment_analysis.dart';
import 'ai_lead_score.dart';
import 'ai_lead_scoring.dart';
import 'ai_market_analysis.dart';
import 'ai_model.dart';
import 'ai_model_deployment.dart';
import 'ai_prediction.dart';
import 'ai_predictive_maintenance.dart';
import 'ai_price_optimization.dart';
import 'ai_property_description.dart';
import 'ai_property_valuation.dart';
import 'ai_recommendation.dart';
import 'ai_sentiment_analysis.dart';
import 'ai_tenant_screening.dart';
import 'ai_valuation_model.dart';
import 'ambassador_campaign.dart';
import 'ambassador_contract.dart';
import 'amenity.dart';
import 'analysis_job.dart';
import 'api_integration.dart';
import 'api_key.dart';
import 'appointment.dart';
import 'attachment.dart';
import 'attorney_management.dart';
import 'audit_log.dart';
import 'automation_execution.dart';
import 'automation_rule.dart';
import 'booking.dart';
import 'brand_ambassador.dart';
import 'budget.dart';
import 'calendar_event.dart';
import 'commission.dart';
import 'communication_template.dart';
import 'contact.dart';
import 'contract.dart';
import 'contract_version.dart';
import 'dashboard_configuration.dart';
import 'dashboard_widget.dart';
import 'deal.dart';
import 'deposit_protection.dart';
import 'document.dart';
import 'document_analysis.dart';
import 'document_template.dart';
import 'earning.dart';
import 'escrow_account.dart';
import 'escrow_dispute.dart';
import 'escrow_release.dart';
import 'escrow_status_history.dart';
import 'event.dart';
import 'event_attendee.dart';
import 'exchange_rate.dart';
import 'export_file.dart';
import 'export_job.dart';
import 'external_rental_listing.dart';
import 'facility.dart';
import 'financial_record.dart';
import 'floor_plan.dart';
import 'gift_card.dart';
import 'government_integration.dart';
import 'health_check.dart';
import 'home_information_pack.dart';
import 'immigration_status_check.dart';
import 'integration_log.dart';
import 'investor_portfolio.dart';
import 'key_management.dart';
import 'lead.dart';
import 'lead_source.dart';
import 'lease.dart';
import 'lease_renewal.dart';
import 'ledger_entry.dart';
import 'listing.dart';
import 'listing_channel.dart';
import 'listing_status_history.dart';
import 'listing_tag.dart';
import 'location.dart';
import 'loyalty_account.dart';
import 'maintenance_block.dart';
import 'maintenance_work_order.dart';
import 'map_layer.dart';
import 'marketing_campaign.dart';
import 'message.dart';
import 'mls_connection.dart';
import 'mls_data_mapping.dart';
import 'mls_external_listing.dart';
import 'mls_listing_enhancement.dart';
import 'mls_sync_job.dart';
import 'mobile_device.dart';
import 'mortgage_offer.dart';
import 'mortgage_pre_approval.dart';
import 'negotiation_offer.dart';
import 'neighborhood.dart';
import 'notification.dart';
import 'offline_sync_queue.dart';
import 'org_subscription.dart';
import 'payment_installment.dart';
import 'payment_negotiation.dart';
import 'payout.dart';
import 'performance_alert.dart';
import 'predictive_model.dart';
import 'project.dart';
import 'property.dart';
import 'property_amenity.dart';
import 'property_compliance.dart';
import 'property_disclosure.dart';
import 'property_document.dart';
import 'property_inventory.dart';
import 'property_offer.dart';
import 'property_photo.dart';
import 'property_viewing.dart';
import 'queue_configuration.dart';
import 'queue_message.dart';
import 'quote.dart';
import 'recommendation_result.dart';
import 'referral.dart';
import 'rent_arrears.dart';
import 'rent_schedule.dart';
import 'rental_sync_job.dart';
import 'report.dart';
import 'report_execution.dart';
import 'reservation.dart';
import 'review.dart';
import 'right_to_rent_check.dart';
import 'role.dart';
import 'route.dart';
import 'security_deposit_protection.dart';
import 'signature_request.dart';
import 'signature_signer.dart';
import 'social_impact_counter.dart';
import 'social_impact_record.dart';
import 'solicitor_management.dart';
import 'subscription.dart';
import 'system_metrics.dart';
import 'tag.dart';
import 'task.dart';
import 'tax1099_form.dart';
import 'tax_depreciation.dart';
import 'tax_record.dart';
import 'tenant_application.dart';
import 'user_activity_log.dart';
import 'user_preference.dart';
import 'vacation_rental.dart';
import 'vendor_profile.dart';
import 'video_content.dart';
import 'virtual_tour.dart';
import 'webhook.dart';
import 'webhook_delivery.dart';

class Organization {
  final String id;
  final String name;
  final OrgType type;
  final Region region;
  final String defaultCurrency;
  final String defaultLocale;
  final String? legalName;
  final String? taxId;
  final String? addres;
  final String? contactEmail;
  final ManagementFeeType? managementFeeType;
  final double? managementFeeRate;
  final double? managementFeeAmount;
  final ManagementFeeScope? managementFeeScope;
  final bool taxReportingEnabled;
  final bool complianceTracking;
  final List<ComplianceType> requiredInspections;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<AiChatbotSession> aiChatbotSessions;
  final List<AiFraudDetection> aiFraudDetections;
  final List<AiImageAnalysis> aiImageAnalyses;
  final List<AiInvestmentAnalysis> aiInvestmentAnalyses;
  final List<AiLeadScore> aiLeadScores;
  final List<AiLeadScoring> aiLeadScoringModels;
  final List<AiMarketAnalysis> aiMarketAnalyses;
  final List<AiModel> aiModels;
  final List<AiModelDeployment> aiModelDeployments;
  final List<AiPrediction> aiPredictions;
  final List<AiPredictiveMaintenance> aiPredictiveMaintenance;
  final List<AiPriceOptimization> aiPriceOptimizations;
  final List<AiPropertyDescription> aiPropertyDescriptions;
  final List<AiPropertyValuation> aiPropertyValuations;
  final List<AiRecommendation> aiRecommendations;
  final List<AiSentimentAnalysis> aiSentimentAnalyses;
  final List<AiTenantScreening> aiTenantScreenings;
  final List<AiValuationModel> aiValuationModels;
  final List<APIIntegration> integrations;
  final List<Achievement> achievements;
  final List<Agency> agencies;
  final List<Agency> agencyRelations;
  final List<Agency> organizationAgencies;
  final List<AgentAssignment> agentAssignments;
  final List<AgentTeam> agentTeams;
  final List<Amenity> amenities;
  final List<APIIntegration> apiIntegrations;
  final List<ApiKey> apiKeys;
  final List<Appointment> appointments;
  final List<Attachment> attachments;
  final List<AttorneyManagement> attorneyCases;
  final List<AuditLog> auditLogs;
  final List<AutomationExecution> automationExecutions;
  final List<AutomationRule> automationRules;
  final List<Booking> bookings;
  final List<Budget> budgets;
  final List<CalendarEvent> calendarEvents;
  final List<Commission> commissions;
  final List<CommunicationTemplate> communicationTemplates;
  final List<Contact> contacts;
  final List<Contract> contracts;
  final List<ContractVersion> contractVersions;
  final List<DashboardConfiguration> dashboardConfigurations;
  final List<DashboardWidget> dashboardWidgets;
  final List<Deal> deals;
  final List<DepositProtection> depositProtections;
  final List<Document> documents;
  final List<DocumentTemplate> documentTemplates;
  final List<Earning> earnings;
  final List<Event> events;
  final List<EventAttendee> eventAttendees;
  final List<ExchangeRate> exchangeRates;
  final List<ExportFile> exportFiles;
  final List<ExportJob> exportJobs;
  final List<ExternalRentalListing> externalRentalListings;
  final List<Facility> facilities;
  final List<FinancialRecord> financialRecords;
  final List<FloorPlan> floorPlans;
  final List<GiftCard> giftCards;
  final List<GovernmentIntegration> govtIntegrations;
  final List<HealthCheck> healthChecks;
  final List<HomeInformationPack> homeInformationPacks;
  final List<ImmigrationStatusCheck> immigrationStatusChecks;
  final List<IntegrationLog> integrationLogs;
  final List<InvestorPortfolio> investorPortfolios;
  final List<KeyManagement> keys;
  final List<Lead> leads;
  final List<LeadSource> leadSources;
  final List<Lease> leases;
  final List<LeaseRenewal> leaseRenewals;
  final List<LedgerEntry> ledgerEntries;
  final List<Listing> listings;
  final List<ListingChannel> listingChannels;
  final List<ListingStatusHistory> listingStatusHistories;
  final List<ListingTag> listingTags;
  final List<Location> locations;
  final List<LoyaltyAccount> loyaltyAccounts;
  final List<MlsConnection> mlsConnections;
  final List<MlsExternalListing> mlsexternalListings;
  final List<MlsSyncJob> mlssyncJobs;
  final List<MaintenanceBlock> maintenanceBlocks;
  final List<MaintenanceWorkOrder> workOrders;
  final List<MapLayer> mapLayers;
  final List<MarketingCampaign> marketingCampaigns;
  final List<Message> messages;
  final List<MlsDataMapping> mlsDataMappings;
  final List<MlsListingEnhancement> mlsListingEnhancements;
  final List<MobileDevice> mobileDevices;
  final List<MortgageOffer> mortgageOffers;
  final List<MortgagePreApproval> mortgagePreApprovals;
  final List<Neighborhood> neighborhoods;
  final List<Notification> notifications;
  final List<OfflineSyncQueue> offlineSyncQueues;
  final OrgSubscription? orgSubscription;
  final List<Payout> payouts;
  final List<PerformanceAlert> performanceAlerts;
  final List<PredictiveModel> predictiveModels;
  final List<Project> projects;
  final List<Property> properties;
  final List<PropertyAmenity> propertyAmenities;
  final List<PropertyCompliance> propertyCompliance;
  final List<PropertyDisclosure> propertyDisclosures;
  final List<PropertyDocument> propertyDocuments;
  final List<PropertyInventory> inventories;
  final List<PropertyOffer> propertyOffers;
  final List<PropertyPhoto> propertyPhotos;
  final List<PropertyViewing> propertyViewings;
  final List<QueueConfiguration> queueConfigurations;
  final List<QueueMessage> queueMessages;
  final List<Quote> quotes;
  final List<RecommendationResult> recommendationResults;
  final List<Referral> referrals;
  final List<RentArrears> rentArrears;
  final List<RentSchedule> rentSchedules;
  final List<RentalSyncJob> rentalSyncJobs;
  final List<Report> reports;
  final List<ReportExecution> reportExecutions;
  final List<Reservation> reservations;
  final List<Review> reviews;
  final List<RightToRentCheck> rightToRentChecks;
  final List<Role> roles;
  final List<Route> routes;
  final List<SecurityDepositProtection> securityDepositProtections;
  final List<SignatureRequest> signatureRequests;
  final List<SignatureSigner> signatureSigners;
  final List<SolicitorManagement> solicitorManagements;
  final List<Subscription> subscriptions;
  final List<SystemMetrics> systemMetrics;
  final List<Tag> tags;
  final List<Task> tasks;
  final List<Tax1099Form> tax1099Forms;
  final List<TaxDepreciation> taxDepreciations;
  final List<TaxRecord> taxRecords;
  final List<TenantApplication> tenantApplications;
  final List<UserActivityLog> userActivityLogs;
  final List<UserPreference> userPreferences;
  final List<VacationRental> vacationRentals;
  final List<VendorProfile> vendors;
  final List<VirtualTour> virtualTours;
  final List<Webhook> webhooks;
  final List<WebhookDelivery> webhookDeliveries;
  final List<EscrowAccount> escrowAccounts;
  final List<EscrowRelease> escrowReleases;
  final List<EscrowDispute> escrowDisputes;
  final List<PaymentNegotiation> paymentNegotiations;
  final List<PaymentInstallment> paymentInstallments;
  final List<VideoContent> videoContents;
  final List<BrandAmbassador> brandAmbassadors;
  final List<AmbassadorCampaign> ambassadorCampaigns;
  final List<SocialImpactCounter> socialImpactCounters;
  final List<SocialImpactRecord> socialImpactRecords;
  final List<NegotiationOffer> negotiationOffers;
  final List<AmbassadorContract> ambassadorContracts;
  final List<EscrowStatusHistory> escrowStatusHistories;
  final List<AiChatMessage> aiChatMessages;
  final List<AiChatHandoff> aiChatHandoffs;
  final List<DocumentAnalysis> analyses;
  final List<AnalysisJob> analysisJobs;

  const Organization({
    required this.id,
    required this.name,
    required this.type,
    required this.region,
    required this.defaultCurrency,
    required this.defaultLocale,
    this.legalName,
    this.taxId,
    this.addres,
    this.contactEmail,
    this.managementFeeType,
    this.managementFeeRate,
    this.managementFeeAmount,
    this.managementFeeScope,
    required this.taxReportingEnabled,
    required this.complianceTracking,
    this.requiredInspections = const [],
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.aiChatbotSessions = const [],
    this.aiFraudDetections = const [],
    this.aiImageAnalyses = const [],
    this.aiInvestmentAnalyses = const [],
    this.aiLeadScores = const [],
    this.aiLeadScoringModels = const [],
    this.aiMarketAnalyses = const [],
    this.aiModels = const [],
    this.aiModelDeployments = const [],
    this.aiPredictions = const [],
    this.aiPredictiveMaintenance = const [],
    this.aiPriceOptimizations = const [],
    this.aiPropertyDescriptions = const [],
    this.aiPropertyValuations = const [],
    this.aiRecommendations = const [],
    this.aiSentimentAnalyses = const [],
    this.aiTenantScreenings = const [],
    this.aiValuationModels = const [],
    this.integrations = const [],
    this.achievements = const [],
    this.agencies = const [],
    this.agencyRelations = const [],
    this.organizationAgencies = const [],
    this.agentAssignments = const [],
    this.agentTeams = const [],
    this.amenities = const [],
    this.apiIntegrations = const [],
    this.apiKeys = const [],
    this.appointments = const [],
    this.attachments = const [],
    this.attorneyCases = const [],
    this.auditLogs = const [],
    this.automationExecutions = const [],
    this.automationRules = const [],
    this.bookings = const [],
    this.budgets = const [],
    this.calendarEvents = const [],
    this.commissions = const [],
    this.communicationTemplates = const [],
    this.contacts = const [],
    this.contracts = const [],
    this.contractVersions = const [],
    this.dashboardConfigurations = const [],
    this.dashboardWidgets = const [],
    this.deals = const [],
    this.depositProtections = const [],
    this.documents = const [],
    this.documentTemplates = const [],
    this.earnings = const [],
    this.events = const [],
    this.eventAttendees = const [],
    this.exchangeRates = const [],
    this.exportFiles = const [],
    this.exportJobs = const [],
    this.externalRentalListings = const [],
    this.facilities = const [],
    this.financialRecords = const [],
    this.floorPlans = const [],
    this.giftCards = const [],
    this.govtIntegrations = const [],
    this.healthChecks = const [],
    this.homeInformationPacks = const [],
    this.immigrationStatusChecks = const [],
    this.integrationLogs = const [],
    this.investorPortfolios = const [],
    this.keys = const [],
    this.leads = const [],
    this.leadSources = const [],
    this.leases = const [],
    this.leaseRenewals = const [],
    this.ledgerEntries = const [],
    this.listings = const [],
    this.listingChannels = const [],
    this.listingStatusHistories = const [],
    this.listingTags = const [],
    this.locations = const [],
    this.loyaltyAccounts = const [],
    this.mlsConnections = const [],
    this.mlsexternalListings = const [],
    this.mlssyncJobs = const [],
    this.maintenanceBlocks = const [],
    this.workOrders = const [],
    this.mapLayers = const [],
    this.marketingCampaigns = const [],
    this.messages = const [],
    this.mlsDataMappings = const [],
    this.mlsListingEnhancements = const [],
    this.mobileDevices = const [],
    this.mortgageOffers = const [],
    this.mortgagePreApprovals = const [],
    this.neighborhoods = const [],
    this.notifications = const [],
    this.offlineSyncQueues = const [],
    this.orgSubscription,
    this.payouts = const [],
    this.performanceAlerts = const [],
    this.predictiveModels = const [],
    this.projects = const [],
    this.properties = const [],
    this.propertyAmenities = const [],
    this.propertyCompliance = const [],
    this.propertyDisclosures = const [],
    this.propertyDocuments = const [],
    this.inventories = const [],
    this.propertyOffers = const [],
    this.propertyPhotos = const [],
    this.propertyViewings = const [],
    this.queueConfigurations = const [],
    this.queueMessages = const [],
    this.quotes = const [],
    this.recommendationResults = const [],
    this.referrals = const [],
    this.rentArrears = const [],
    this.rentSchedules = const [],
    this.rentalSyncJobs = const [],
    this.reports = const [],
    this.reportExecutions = const [],
    this.reservations = const [],
    this.reviews = const [],
    this.rightToRentChecks = const [],
    this.roles = const [],
    this.routes = const [],
    this.securityDepositProtections = const [],
    this.signatureRequests = const [],
    this.signatureSigners = const [],
    this.solicitorManagements = const [],
    this.subscriptions = const [],
    this.systemMetrics = const [],
    this.tags = const [],
    this.tasks = const [],
    this.tax1099Forms = const [],
    this.taxDepreciations = const [],
    this.taxRecords = const [],
    this.tenantApplications = const [],
    this.userActivityLogs = const [],
    this.userPreferences = const [],
    this.vacationRentals = const [],
    this.vendors = const [],
    this.virtualTours = const [],
    this.webhooks = const [],
    this.webhookDeliveries = const [],
    this.escrowAccounts = const [],
    this.escrowReleases = const [],
    this.escrowDisputes = const [],
    this.paymentNegotiations = const [],
    this.paymentInstallments = const [],
    this.videoContents = const [],
    this.brandAmbassadors = const [],
    this.ambassadorCampaigns = const [],
    this.socialImpactCounters = const [],
    this.socialImpactRecords = const [],
    this.negotiationOffers = const [],
    this.ambassadorContracts = const [],
    this.escrowStatusHistories = const [],
    this.aiChatMessages = const [],
    this.aiChatHandoffs = const [],
    this.analyses = const [],
    this.analysisJobs = const [],
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      type: (() {
        final valUpper = json['type']?.toString().toUpperCase() ?? '';
        return OrgType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => OrgType.AGENCY,
        );
      })(),
      region: (() {
        final valUpper = json['region']?.toString().toUpperCase() ?? '';
        return Region.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => Region.USA_NORTHEAST,
        );
      })(),
      defaultCurrency: json['defaultCurrency'] as String,
      defaultLocale: json['defaultLocale'] as String,
      legalName: json['legalName'] as String?,
      taxId: json['taxId'] as String?,
      addres: json['Addres'] as String?,
      contactEmail: json['contactEmail'] as String?,
      managementFeeType: json['managementFeeType'] != null ? (() {
        final valUpper = json['managementFeeType'].toString().toUpperCase();
        return ManagementFeeType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => ManagementFeeType.PERCENTAGE_RENT,
        );
      })() : null,
      managementFeeRate: (json['managementFeeRate'] as num?)?.toDouble(),
      managementFeeAmount: (json['managementFeeAmount'] as num?)?.toDouble(),
      managementFeeScope: json['managementFeeScope'] != null ? (() {
        final valUpper = json['managementFeeScope'].toString().toUpperCase();
        return ManagementFeeScope.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => ManagementFeeScope.FULL_SERVICE,
        );
      })() : null,
      taxReportingEnabled: json['taxReportingEnabled'] as bool,
      complianceTracking: json['complianceTracking'] as bool,
      requiredInspections: (json['requiredInspections'] as List<dynamic>?)?.map((e) {
        final valUpper = e.toString().toUpperCase();
        return ComplianceType.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => ComplianceType.FIRE_SAFETY,
        );
      }).toList() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      aiChatbotSessions: (json['aiChatbotSessions'] as List<dynamic>?)?.map((e) => AiChatbotSession.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiFraudDetections: (json['aiFraudDetections'] as List<dynamic>?)?.map((e) => AiFraudDetection.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiImageAnalyses: (json['aiImageAnalyses'] as List<dynamic>?)?.map((e) => AiImageAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiInvestmentAnalyses: (json['aiInvestmentAnalyses'] as List<dynamic>?)?.map((e) => AiInvestmentAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiLeadScores: (json['aiLeadScores'] as List<dynamic>?)?.map((e) => AiLeadScore.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiLeadScoringModels: (json['aiLeadScoringModels'] as List<dynamic>?)?.map((e) => AiLeadScoring.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiMarketAnalyses: (json['aiMarketAnalyses'] as List<dynamic>?)?.map((e) => AiMarketAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiModels: (json['aiModels'] as List<dynamic>?)?.map((e) => AiModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiModelDeployments: (json['aiModelDeployments'] as List<dynamic>?)?.map((e) => AiModelDeployment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiPredictions: (json['aiPredictions'] as List<dynamic>?)?.map((e) => AiPrediction.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiPredictiveMaintenance: (json['aiPredictiveMaintenance'] as List<dynamic>?)?.map((e) => AiPredictiveMaintenance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiPriceOptimizations: (json['aiPriceOptimizations'] as List<dynamic>?)?.map((e) => AiPriceOptimization.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiPropertyDescriptions: (json['aiPropertyDescriptions'] as List<dynamic>?)?.map((e) => AiPropertyDescription.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiPropertyValuations: (json['aiPropertyValuations'] as List<dynamic>?)?.map((e) => AiPropertyValuation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiRecommendations: (json['aiRecommendations'] as List<dynamic>?)?.map((e) => AiRecommendation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiSentimentAnalyses: (json['aiSentimentAnalyses'] as List<dynamic>?)?.map((e) => AiSentimentAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiTenantScreenings: (json['aiTenantScreenings'] as List<dynamic>?)?.map((e) => AiTenantScreening.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiValuationModels: (json['aiValuationModels'] as List<dynamic>?)?.map((e) => AiValuationModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      integrations: (json['integrations'] as List<dynamic>?)?.map((e) => APIIntegration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      achievements: (json['achievements'] as List<dynamic>?)?.map((e) => Achievement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencyRelations: (json['agencyRelations'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      organizationAgencies: (json['organizationAgencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentAssignments: (json['agentAssignments'] as List<dynamic>?)?.map((e) => AgentAssignment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agentTeams: (json['agentTeams'] as List<dynamic>?)?.map((e) => AgentTeam.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      amenities: (json['amenities'] as List<dynamic>?)?.map((e) => Amenity.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      apiIntegrations: (json['apiIntegrations'] as List<dynamic>?)?.map((e) => APIIntegration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      apiKeys: (json['apiKeys'] as List<dynamic>?)?.map((e) => ApiKey.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      appointments: (json['appointments'] as List<dynamic>?)?.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      attorneyCases: (json['attorneyCases'] as List<dynamic>?)?.map((e) => AttorneyManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      auditLogs: (json['auditLogs'] as List<dynamic>?)?.map((e) => AuditLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      automationExecutions: (json['automationExecutions'] as List<dynamic>?)?.map((e) => AutomationExecution.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      automationRules: (json['automationRules'] as List<dynamic>?)?.map((e) => AutomationRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      bookings: (json['bookings'] as List<dynamic>?)?.map((e) => Booking.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      budgets: (json['budgets'] as List<dynamic>?)?.map((e) => Budget.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      calendarEvents: (json['calendarEvents'] as List<dynamic>?)?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      commissions: (json['commissions'] as List<dynamic>?)?.map((e) => Commission.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      communicationTemplates: (json['communicationTemplates'] as List<dynamic>?)?.map((e) => CommunicationTemplate.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contacts: (json['contacts'] as List<dynamic>?)?.map((e) => Contact.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contracts: (json['contracts'] as List<dynamic>?)?.map((e) => Contract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contractVersions: (json['contractVersions'] as List<dynamic>?)?.map((e) => ContractVersion.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      dashboardConfigurations: (json['dashboardConfigurations'] as List<dynamic>?)?.map((e) => DashboardConfiguration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      dashboardWidgets: (json['dashboardWidgets'] as List<dynamic>?)?.map((e) => DashboardWidget.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      deals: (json['deals'] as List<dynamic>?)?.map((e) => Deal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      depositProtections: (json['depositProtections'] as List<dynamic>?)?.map((e) => DepositProtection.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      documents: (json['documents'] as List<dynamic>?)?.map((e) => Document.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      documentTemplates: (json['documentTemplates'] as List<dynamic>?)?.map((e) => DocumentTemplate.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      earnings: (json['earnings'] as List<dynamic>?)?.map((e) => Earning.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      events: (json['events'] as List<dynamic>?)?.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      eventAttendees: (json['eventAttendees'] as List<dynamic>?)?.map((e) => EventAttendee.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      exchangeRates: (json['exchangeRates'] as List<dynamic>?)?.map((e) => ExchangeRate.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      exportFiles: (json['exportFiles'] as List<dynamic>?)?.map((e) => ExportFile.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      exportJobs: (json['exportJobs'] as List<dynamic>?)?.map((e) => ExportJob.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      externalRentalListings: (json['externalRentalListings'] as List<dynamic>?)?.map((e) => ExternalRentalListing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      facilities: (json['facilities'] as List<dynamic>?)?.map((e) => Facility.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      financialRecords: (json['financialRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      floorPlans: (json['floorPlans'] as List<dynamic>?)?.map((e) => FloorPlan.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      giftCards: (json['giftCards'] as List<dynamic>?)?.map((e) => GiftCard.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      govtIntegrations: (json['govtIntegrations'] as List<dynamic>?)?.map((e) => GovernmentIntegration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      healthChecks: (json['healthChecks'] as List<dynamic>?)?.map((e) => HealthCheck.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      homeInformationPacks: (json['homeInformationPacks'] as List<dynamic>?)?.map((e) => HomeInformationPack.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      immigrationStatusChecks: (json['immigrationStatusChecks'] as List<dynamic>?)?.map((e) => ImmigrationStatusCheck.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      integrationLogs: (json['integrationLogs'] as List<dynamic>?)?.map((e) => IntegrationLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      investorPortfolios: (json['investorPortfolios'] as List<dynamic>?)?.map((e) => InvestorPortfolio.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      keys: (json['keys'] as List<dynamic>?)?.map((e) => KeyManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leadSources: (json['leadSources'] as List<dynamic>?)?.map((e) => LeadSource.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leases: (json['leases'] as List<dynamic>?)?.map((e) => Lease.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leaseRenewals: (json['leaseRenewals'] as List<dynamic>?)?.map((e) => LeaseRenewal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      ledgerEntries: (json['ledgerEntries'] as List<dynamic>?)?.map((e) => LedgerEntry.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      listings: (json['listings'] as List<dynamic>?)?.map((e) => Listing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      listingChannels: (json['listingChannels'] as List<dynamic>?)?.map((e) => ListingChannel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      listingStatusHistories: (json['listingStatusHistories'] as List<dynamic>?)?.map((e) => ListingStatusHistory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      listingTags: (json['listingTags'] as List<dynamic>?)?.map((e) => ListingTag.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      locations: (json['locations'] as List<dynamic>?)?.map((e) => Location.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      loyaltyAccounts: (json['loyaltyAccounts'] as List<dynamic>?)?.map((e) => LoyaltyAccount.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mlsConnections: (json['mlsConnections'] as List<dynamic>?)?.map((e) => MlsConnection.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mlsexternalListings: (json['mlsexternalListings'] as List<dynamic>?)?.map((e) => MlsExternalListing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mlssyncJobs: (json['mlssyncJobs'] as List<dynamic>?)?.map((e) => MlsSyncJob.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      maintenanceBlocks: (json['maintenanceBlocks'] as List<dynamic>?)?.map((e) => MaintenanceBlock.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      workOrders: (json['workOrders'] as List<dynamic>?)?.map((e) => MaintenanceWorkOrder.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mapLayers: (json['mapLayers'] as List<dynamic>?)?.map((e) => MapLayer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      marketingCampaigns: (json['marketingCampaigns'] as List<dynamic>?)?.map((e) => MarketingCampaign.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      messages: (json['messages'] as List<dynamic>?)?.map((e) => Message.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mlsDataMappings: (json['mlsDataMappings'] as List<dynamic>?)?.map((e) => MlsDataMapping.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mlsListingEnhancements: (json['mlsListingEnhancements'] as List<dynamic>?)?.map((e) => MlsListingEnhancement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mobileDevices: (json['mobileDevices'] as List<dynamic>?)?.map((e) => MobileDevice.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgageOffers: (json['mortgageOffers'] as List<dynamic>?)?.map((e) => MortgageOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgagePreApprovals: (json['mortgagePreApprovals'] as List<dynamic>?)?.map((e) => MortgagePreApproval.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      neighborhoods: (json['neighborhoods'] as List<dynamic>?)?.map((e) => Neighborhood.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      notifications: (json['notifications'] as List<dynamic>?)?.map((e) => Notification.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      offlineSyncQueues: (json['offlineSyncQueues'] as List<dynamic>?)?.map((e) => OfflineSyncQueue.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      orgSubscription: json['orgSubscription'] != null ? OrgSubscription.fromJson(json['orgSubscription'] as Map<String, dynamic>) : null,
      payouts: (json['payouts'] as List<dynamic>?)?.map((e) => Payout.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      performanceAlerts: (json['performanceAlerts'] as List<dynamic>?)?.map((e) => PerformanceAlert.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      predictiveModels: (json['predictiveModels'] as List<dynamic>?)?.map((e) => PredictiveModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      projects: (json['projects'] as List<dynamic>?)?.map((e) => Project.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      properties: (json['properties'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyAmenities: (json['propertyAmenities'] as List<dynamic>?)?.map((e) => PropertyAmenity.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyCompliance: (json['propertyCompliance'] as List<dynamic>?)?.map((e) => PropertyCompliance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyDisclosures: (json['propertyDisclosures'] as List<dynamic>?)?.map((e) => PropertyDisclosure.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyDocuments: (json['propertyDocuments'] as List<dynamic>?)?.map((e) => PropertyDocument.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      inventories: (json['inventories'] as List<dynamic>?)?.map((e) => PropertyInventory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyOffers: (json['propertyOffers'] as List<dynamic>?)?.map((e) => PropertyOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyPhotos: (json['propertyPhotos'] as List<dynamic>?)?.map((e) => PropertyPhoto.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyViewings: (json['propertyViewings'] as List<dynamic>?)?.map((e) => PropertyViewing.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      queueConfigurations: (json['queueConfigurations'] as List<dynamic>?)?.map((e) => QueueConfiguration.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      queueMessages: (json['queueMessages'] as List<dynamic>?)?.map((e) => QueueMessage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      quotes: (json['quotes'] as List<dynamic>?)?.map((e) => Quote.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      recommendationResults: (json['recommendationResults'] as List<dynamic>?)?.map((e) => RecommendationResult.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      referrals: (json['referrals'] as List<dynamic>?)?.map((e) => Referral.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rentArrears: (json['rentArrears'] as List<dynamic>?)?.map((e) => RentArrears.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rentSchedules: (json['rentSchedules'] as List<dynamic>?)?.map((e) => RentSchedule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rentalSyncJobs: (json['rentalSyncJobs'] as List<dynamic>?)?.map((e) => RentalSyncJob.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reports: (json['reports'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reportExecutions: (json['reportExecutions'] as List<dynamic>?)?.map((e) => ReportExecution.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservations: (json['reservations'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reviews: (json['reviews'] as List<dynamic>?)?.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rightToRentChecks: (json['rightToRentChecks'] as List<dynamic>?)?.map((e) => RightToRentCheck.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      roles: (json['roles'] as List<dynamic>?)?.map((e) => Role.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      routes: (json['routes'] as List<dynamic>?)?.map((e) => Route.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      securityDepositProtections: (json['securityDepositProtections'] as List<dynamic>?)?.map((e) => SecurityDepositProtection.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      signatureRequests: (json['signatureRequests'] as List<dynamic>?)?.map((e) => SignatureRequest.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      signatureSigners: (json['signatureSigners'] as List<dynamic>?)?.map((e) => SignatureSigner.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      solicitorManagements: (json['solicitorManagements'] as List<dynamic>?)?.map((e) => SolicitorManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      subscriptions: (json['subscriptions'] as List<dynamic>?)?.map((e) => Subscription.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      systemMetrics: (json['systemMetrics'] as List<dynamic>?)?.map((e) => SystemMetrics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => Tag.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tax1099Forms: (json['tax1099Forms'] as List<dynamic>?)?.map((e) => Tax1099Form.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      taxDepreciations: (json['taxDepreciations'] as List<dynamic>?)?.map((e) => TaxDepreciation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      taxRecords: (json['taxRecords'] as List<dynamic>?)?.map((e) => TaxRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenantApplications: (json['tenantApplications'] as List<dynamic>?)?.map((e) => TenantApplication.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      userActivityLogs: (json['userActivityLogs'] as List<dynamic>?)?.map((e) => UserActivityLog.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      userPreferences: (json['userPreferences'] as List<dynamic>?)?.map((e) => UserPreference.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      vacationRentals: (json['vacationRentals'] as List<dynamic>?)?.map((e) => VacationRental.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      vendors: (json['vendors'] as List<dynamic>?)?.map((e) => VendorProfile.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      virtualTours: (json['virtualTours'] as List<dynamic>?)?.map((e) => VirtualTour.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      webhooks: (json['webhooks'] as List<dynamic>?)?.map((e) => Webhook.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      webhookDeliveries: (json['webhookDeliveries'] as List<dynamic>?)?.map((e) => WebhookDelivery.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      escrowAccounts: (json['escrowAccounts'] as List<dynamic>?)?.map((e) => EscrowAccount.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      escrowReleases: (json['escrowReleases'] as List<dynamic>?)?.map((e) => EscrowRelease.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      escrowDisputes: (json['escrowDisputes'] as List<dynamic>?)?.map((e) => EscrowDispute.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      paymentNegotiations: (json['paymentNegotiations'] as List<dynamic>?)?.map((e) => PaymentNegotiation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      paymentInstallments: (json['paymentInstallments'] as List<dynamic>?)?.map((e) => PaymentInstallment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      videoContents: (json['videoContents'] as List<dynamic>?)?.map((e) => VideoContent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      brandAmbassadors: (json['brandAmbassadors'] as List<dynamic>?)?.map((e) => BrandAmbassador.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      ambassadorCampaigns: (json['ambassadorCampaigns'] as List<dynamic>?)?.map((e) => AmbassadorCampaign.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      socialImpactCounters: (json['socialImpactCounters'] as List<dynamic>?)?.map((e) => SocialImpactCounter.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      socialImpactRecords: (json['socialImpactRecords'] as List<dynamic>?)?.map((e) => SocialImpactRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      negotiationOffers: (json['negotiationOffers'] as List<dynamic>?)?.map((e) => NegotiationOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      ambassadorContracts: (json['ambassadorContracts'] as List<dynamic>?)?.map((e) => AmbassadorContract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      escrowStatusHistories: (json['escrowStatusHistories'] as List<dynamic>?)?.map((e) => EscrowStatusHistory.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiChatMessages: (json['aiChatMessages'] as List<dynamic>?)?.map((e) => AiChatMessage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      aiChatHandoffs: (json['aiChatHandoffs'] as List<dynamic>?)?.map((e) => AiChatHandoff.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analyses: (json['analyses'] as List<dynamic>?)?.map((e) => DocumentAnalysis.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analysisJobs: (json['analysisJobs'] as List<dynamic>?)?.map((e) => AnalysisJob.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'region': region.name,
      'defaultCurrency': defaultCurrency,
      'defaultLocale': defaultLocale,
      'legalName': legalName,
      'taxId': taxId,
      'Addres': addres,
      'contactEmail': contactEmail,
      'managementFeeType': managementFeeType?.name,
      'managementFeeRate': managementFeeRate,
      'managementFeeAmount': managementFeeAmount,
      'managementFeeScope': managementFeeScope?.name,
      'taxReportingEnabled': taxReportingEnabled,
      'complianceTracking': complianceTracking,
      'requiredInspections': requiredInspections.map((e) => e.name).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'aiChatbotSessions': aiChatbotSessions.map((e) => e.toJson()).toList(),
      'aiFraudDetections': aiFraudDetections.map((e) => e.toJson()).toList(),
      'aiImageAnalyses': aiImageAnalyses.map((e) => e.toJson()).toList(),
      'aiInvestmentAnalyses': aiInvestmentAnalyses.map((e) => e.toJson()).toList(),
      'aiLeadScores': aiLeadScores.map((e) => e.toJson()).toList(),
      'aiLeadScoringModels': aiLeadScoringModels.map((e) => e.toJson()).toList(),
      'aiMarketAnalyses': aiMarketAnalyses.map((e) => e.toJson()).toList(),
      'aiModels': aiModels.map((e) => e.toJson()).toList(),
      'aiModelDeployments': aiModelDeployments.map((e) => e.toJson()).toList(),
      'aiPredictions': aiPredictions.map((e) => e.toJson()).toList(),
      'aiPredictiveMaintenance': aiPredictiveMaintenance.map((e) => e.toJson()).toList(),
      'aiPriceOptimizations': aiPriceOptimizations.map((e) => e.toJson()).toList(),
      'aiPropertyDescriptions': aiPropertyDescriptions.map((e) => e.toJson()).toList(),
      'aiPropertyValuations': aiPropertyValuations.map((e) => e.toJson()).toList(),
      'aiRecommendations': aiRecommendations.map((e) => e.toJson()).toList(),
      'aiSentimentAnalyses': aiSentimentAnalyses.map((e) => e.toJson()).toList(),
      'aiTenantScreenings': aiTenantScreenings.map((e) => e.toJson()).toList(),
      'aiValuationModels': aiValuationModels.map((e) => e.toJson()).toList(),
      'integrations': integrations.map((e) => e.toJson()).toList(),
      'achievements': achievements.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'agencyRelations': agencyRelations.map((e) => e.toJson()).toList(),
      'organizationAgencies': organizationAgencies.map((e) => e.toJson()).toList(),
      'agentAssignments': agentAssignments.map((e) => e.toJson()).toList(),
      'agentTeams': agentTeams.map((e) => e.toJson()).toList(),
      'amenities': amenities.map((e) => e.toJson()).toList(),
      'apiIntegrations': apiIntegrations.map((e) => e.toJson()).toList(),
      'apiKeys': apiKeys.map((e) => e.toJson()).toList(),
      'appointments': appointments.map((e) => e.toJson()).toList(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'attorneyCases': attorneyCases.map((e) => e.toJson()).toList(),
      'auditLogs': auditLogs.map((e) => e.toJson()).toList(),
      'automationExecutions': automationExecutions.map((e) => e.toJson()).toList(),
      'automationRules': automationRules.map((e) => e.toJson()).toList(),
      'bookings': bookings.map((e) => e.toJson()).toList(),
      'budgets': budgets.map((e) => e.toJson()).toList(),
      'calendarEvents': calendarEvents.map((e) => e.toJson()).toList(),
      'commissions': commissions.map((e) => e.toJson()).toList(),
      'communicationTemplates': communicationTemplates.map((e) => e.toJson()).toList(),
      'contacts': contacts.map((e) => e.toJson()).toList(),
      'contracts': contracts.map((e) => e.toJson()).toList(),
      'contractVersions': contractVersions.map((e) => e.toJson()).toList(),
      'dashboardConfigurations': dashboardConfigurations.map((e) => e.toJson()).toList(),
      'dashboardWidgets': dashboardWidgets.map((e) => e.toJson()).toList(),
      'deals': deals.map((e) => e.toJson()).toList(),
      'depositProtections': depositProtections.map((e) => e.toJson()).toList(),
      'documents': documents.map((e) => e.toJson()).toList(),
      'documentTemplates': documentTemplates.map((e) => e.toJson()).toList(),
      'earnings': earnings.map((e) => e.toJson()).toList(),
      'events': events.map((e) => e.toJson()).toList(),
      'eventAttendees': eventAttendees.map((e) => e.toJson()).toList(),
      'exchangeRates': exchangeRates.map((e) => e.toJson()).toList(),
      'exportFiles': exportFiles.map((e) => e.toJson()).toList(),
      'exportJobs': exportJobs.map((e) => e.toJson()).toList(),
      'externalRentalListings': externalRentalListings.map((e) => e.toJson()).toList(),
      'facilities': facilities.map((e) => e.toJson()).toList(),
      'financialRecords': financialRecords.map((e) => e.toJson()).toList(),
      'floorPlans': floorPlans.map((e) => e.toJson()).toList(),
      'giftCards': giftCards.map((e) => e.toJson()).toList(),
      'govtIntegrations': govtIntegrations.map((e) => e.toJson()).toList(),
      'healthChecks': healthChecks.map((e) => e.toJson()).toList(),
      'homeInformationPacks': homeInformationPacks.map((e) => e.toJson()).toList(),
      'immigrationStatusChecks': immigrationStatusChecks.map((e) => e.toJson()).toList(),
      'integrationLogs': integrationLogs.map((e) => e.toJson()).toList(),
      'investorPortfolios': investorPortfolios.map((e) => e.toJson()).toList(),
      'keys': keys.map((e) => e.toJson()).toList(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'leadSources': leadSources.map((e) => e.toJson()).toList(),
      'leases': leases.map((e) => e.toJson()).toList(),
      'leaseRenewals': leaseRenewals.map((e) => e.toJson()).toList(),
      'ledgerEntries': ledgerEntries.map((e) => e.toJson()).toList(),
      'listings': listings.map((e) => e.toJson()).toList(),
      'listingChannels': listingChannels.map((e) => e.toJson()).toList(),
      'listingStatusHistories': listingStatusHistories.map((e) => e.toJson()).toList(),
      'listingTags': listingTags.map((e) => e.toJson()).toList(),
      'locations': locations.map((e) => e.toJson()).toList(),
      'loyaltyAccounts': loyaltyAccounts.map((e) => e.toJson()).toList(),
      'mlsConnections': mlsConnections.map((e) => e.toJson()).toList(),
      'mlsexternalListings': mlsexternalListings.map((e) => e.toJson()).toList(),
      'mlssyncJobs': mlssyncJobs.map((e) => e.toJson()).toList(),
      'maintenanceBlocks': maintenanceBlocks.map((e) => e.toJson()).toList(),
      'workOrders': workOrders.map((e) => e.toJson()).toList(),
      'mapLayers': mapLayers.map((e) => e.toJson()).toList(),
      'marketingCampaigns': marketingCampaigns.map((e) => e.toJson()).toList(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'mlsDataMappings': mlsDataMappings.map((e) => e.toJson()).toList(),
      'mlsListingEnhancements': mlsListingEnhancements.map((e) => e.toJson()).toList(),
      'mobileDevices': mobileDevices.map((e) => e.toJson()).toList(),
      'mortgageOffers': mortgageOffers.map((e) => e.toJson()).toList(),
      'mortgagePreApprovals': mortgagePreApprovals.map((e) => e.toJson()).toList(),
      'neighborhoods': neighborhoods.map((e) => e.toJson()).toList(),
      'notifications': notifications.map((e) => e.toJson()).toList(),
      'offlineSyncQueues': offlineSyncQueues.map((e) => e.toJson()).toList(),
      'orgSubscription': orgSubscription?.toJson(),
      'payouts': payouts.map((e) => e.toJson()).toList(),
      'performanceAlerts': performanceAlerts.map((e) => e.toJson()).toList(),
      'predictiveModels': predictiveModels.map((e) => e.toJson()).toList(),
      'projects': projects.map((e) => e.toJson()).toList(),
      'properties': properties.map((e) => e.toJson()).toList(),
      'propertyAmenities': propertyAmenities.map((e) => e.toJson()).toList(),
      'propertyCompliance': propertyCompliance.map((e) => e.toJson()).toList(),
      'propertyDisclosures': propertyDisclosures.map((e) => e.toJson()).toList(),
      'propertyDocuments': propertyDocuments.map((e) => e.toJson()).toList(),
      'inventories': inventories.map((e) => e.toJson()).toList(),
      'propertyOffers': propertyOffers.map((e) => e.toJson()).toList(),
      'propertyPhotos': propertyPhotos.map((e) => e.toJson()).toList(),
      'propertyViewings': propertyViewings.map((e) => e.toJson()).toList(),
      'queueConfigurations': queueConfigurations.map((e) => e.toJson()).toList(),
      'queueMessages': queueMessages.map((e) => e.toJson()).toList(),
      'quotes': quotes.map((e) => e.toJson()).toList(),
      'recommendationResults': recommendationResults.map((e) => e.toJson()).toList(),
      'referrals': referrals.map((e) => e.toJson()).toList(),
      'rentArrears': rentArrears.map((e) => e.toJson()).toList(),
      'rentSchedules': rentSchedules.map((e) => e.toJson()).toList(),
      'rentalSyncJobs': rentalSyncJobs.map((e) => e.toJson()).toList(),
      'reports': reports.map((e) => e.toJson()).toList(),
      'reportExecutions': reportExecutions.map((e) => e.toJson()).toList(),
      'reservations': reservations.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'rightToRentChecks': rightToRentChecks.map((e) => e.toJson()).toList(),
      'roles': roles.map((e) => e.toJson()).toList(),
      'routes': routes.map((e) => e.toJson()).toList(),
      'securityDepositProtections': securityDepositProtections.map((e) => e.toJson()).toList(),
      'signatureRequests': signatureRequests.map((e) => e.toJson()).toList(),
      'signatureSigners': signatureSigners.map((e) => e.toJson()).toList(),
      'solicitorManagements': solicitorManagements.map((e) => e.toJson()).toList(),
      'subscriptions': subscriptions.map((e) => e.toJson()).toList(),
      'systemMetrics': systemMetrics.map((e) => e.toJson()).toList(),
      'tags': tags.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'tax1099Forms': tax1099Forms.map((e) => e.toJson()).toList(),
      'taxDepreciations': taxDepreciations.map((e) => e.toJson()).toList(),
      'taxRecords': taxRecords.map((e) => e.toJson()).toList(),
      'tenantApplications': tenantApplications.map((e) => e.toJson()).toList(),
      'userActivityLogs': userActivityLogs.map((e) => e.toJson()).toList(),
      'userPreferences': userPreferences.map((e) => e.toJson()).toList(),
      'vacationRentals': vacationRentals.map((e) => e.toJson()).toList(),
      'vendors': vendors.map((e) => e.toJson()).toList(),
      'virtualTours': virtualTours.map((e) => e.toJson()).toList(),
      'webhooks': webhooks.map((e) => e.toJson()).toList(),
      'webhookDeliveries': webhookDeliveries.map((e) => e.toJson()).toList(),
      'escrowAccounts': escrowAccounts.map((e) => e.toJson()).toList(),
      'escrowReleases': escrowReleases.map((e) => e.toJson()).toList(),
      'escrowDisputes': escrowDisputes.map((e) => e.toJson()).toList(),
      'paymentNegotiations': paymentNegotiations.map((e) => e.toJson()).toList(),
      'paymentInstallments': paymentInstallments.map((e) => e.toJson()).toList(),
      'videoContents': videoContents.map((e) => e.toJson()).toList(),
      'brandAmbassadors': brandAmbassadors.map((e) => e.toJson()).toList(),
      'ambassadorCampaigns': ambassadorCampaigns.map((e) => e.toJson()).toList(),
      'socialImpactCounters': socialImpactCounters.map((e) => e.toJson()).toList(),
      'socialImpactRecords': socialImpactRecords.map((e) => e.toJson()).toList(),
      'negotiationOffers': negotiationOffers.map((e) => e.toJson()).toList(),
      'ambassadorContracts': ambassadorContracts.map((e) => e.toJson()).toList(),
      'escrowStatusHistories': escrowStatusHistories.map((e) => e.toJson()).toList(),
      'aiChatMessages': aiChatMessages.map((e) => e.toJson()).toList(),
      'aiChatHandoffs': aiChatHandoffs.map((e) => e.toJson()).toList(),
      'analyses': analyses.map((e) => e.toJson()).toList(),
      'analysisJobs': analysisJobs.map((e) => e.toJson()).toList(),
    };
  }

  Organization copyWith({
    String? id,
    String? name,
    OrgType? type,
    Region? region,
    String? defaultCurrency,
    String? defaultLocale,
    String? legalName,
    String? taxId,
    String? addres,
    String? contactEmail,
    ManagementFeeType? managementFeeType,
    double? managementFeeRate,
    double? managementFeeAmount,
    ManagementFeeScope? managementFeeScope,
    bool? taxReportingEnabled,
    bool? complianceTracking,
    List<ComplianceType>? requiredInspections,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<AiChatbotSession>? aiChatbotSessions,
    List<AiFraudDetection>? aiFraudDetections,
    List<AiImageAnalysis>? aiImageAnalyses,
    List<AiInvestmentAnalysis>? aiInvestmentAnalyses,
    List<AiLeadScore>? aiLeadScores,
    List<AiLeadScoring>? aiLeadScoringModels,
    List<AiMarketAnalysis>? aiMarketAnalyses,
    List<AiModel>? aiModels,
    List<AiModelDeployment>? aiModelDeployments,
    List<AiPrediction>? aiPredictions,
    List<AiPredictiveMaintenance>? aiPredictiveMaintenance,
    List<AiPriceOptimization>? aiPriceOptimizations,
    List<AiPropertyDescription>? aiPropertyDescriptions,
    List<AiPropertyValuation>? aiPropertyValuations,
    List<AiRecommendation>? aiRecommendations,
    List<AiSentimentAnalysis>? aiSentimentAnalyses,
    List<AiTenantScreening>? aiTenantScreenings,
    List<AiValuationModel>? aiValuationModels,
    List<APIIntegration>? integrations,
    List<Achievement>? achievements,
    List<Agency>? agencies,
    List<Agency>? agencyRelations,
    List<Agency>? organizationAgencies,
    List<AgentAssignment>? agentAssignments,
    List<AgentTeam>? agentTeams,
    List<Amenity>? amenities,
    List<APIIntegration>? apiIntegrations,
    List<ApiKey>? apiKeys,
    List<Appointment>? appointments,
    List<Attachment>? attachments,
    List<AttorneyManagement>? attorneyCases,
    List<AuditLog>? auditLogs,
    List<AutomationExecution>? automationExecutions,
    List<AutomationRule>? automationRules,
    List<Booking>? bookings,
    List<Budget>? budgets,
    List<CalendarEvent>? calendarEvents,
    List<Commission>? commissions,
    List<CommunicationTemplate>? communicationTemplates,
    List<Contact>? contacts,
    List<Contract>? contracts,
    List<ContractVersion>? contractVersions,
    List<DashboardConfiguration>? dashboardConfigurations,
    List<DashboardWidget>? dashboardWidgets,
    List<Deal>? deals,
    List<DepositProtection>? depositProtections,
    List<Document>? documents,
    List<DocumentTemplate>? documentTemplates,
    List<Earning>? earnings,
    List<Event>? events,
    List<EventAttendee>? eventAttendees,
    List<ExchangeRate>? exchangeRates,
    List<ExportFile>? exportFiles,
    List<ExportJob>? exportJobs,
    List<ExternalRentalListing>? externalRentalListings,
    List<Facility>? facilities,
    List<FinancialRecord>? financialRecords,
    List<FloorPlan>? floorPlans,
    List<GiftCard>? giftCards,
    List<GovernmentIntegration>? govtIntegrations,
    List<HealthCheck>? healthChecks,
    List<HomeInformationPack>? homeInformationPacks,
    List<ImmigrationStatusCheck>? immigrationStatusChecks,
    List<IntegrationLog>? integrationLogs,
    List<InvestorPortfolio>? investorPortfolios,
    List<KeyManagement>? keys,
    List<Lead>? leads,
    List<LeadSource>? leadSources,
    List<Lease>? leases,
    List<LeaseRenewal>? leaseRenewals,
    List<LedgerEntry>? ledgerEntries,
    List<Listing>? listings,
    List<ListingChannel>? listingChannels,
    List<ListingStatusHistory>? listingStatusHistories,
    List<ListingTag>? listingTags,
    List<Location>? locations,
    List<LoyaltyAccount>? loyaltyAccounts,
    List<MlsConnection>? mlsConnections,
    List<MlsExternalListing>? mlsexternalListings,
    List<MlsSyncJob>? mlssyncJobs,
    List<MaintenanceBlock>? maintenanceBlocks,
    List<MaintenanceWorkOrder>? workOrders,
    List<MapLayer>? mapLayers,
    List<MarketingCampaign>? marketingCampaigns,
    List<Message>? messages,
    List<MlsDataMapping>? mlsDataMappings,
    List<MlsListingEnhancement>? mlsListingEnhancements,
    List<MobileDevice>? mobileDevices,
    List<MortgageOffer>? mortgageOffers,
    List<MortgagePreApproval>? mortgagePreApprovals,
    List<Neighborhood>? neighborhoods,
    List<Notification>? notifications,
    List<OfflineSyncQueue>? offlineSyncQueues,
    OrgSubscription? orgSubscription,
    List<Payout>? payouts,
    List<PerformanceAlert>? performanceAlerts,
    List<PredictiveModel>? predictiveModels,
    List<Project>? projects,
    List<Property>? properties,
    List<PropertyAmenity>? propertyAmenities,
    List<PropertyCompliance>? propertyCompliance,
    List<PropertyDisclosure>? propertyDisclosures,
    List<PropertyDocument>? propertyDocuments,
    List<PropertyInventory>? inventories,
    List<PropertyOffer>? propertyOffers,
    List<PropertyPhoto>? propertyPhotos,
    List<PropertyViewing>? propertyViewings,
    List<QueueConfiguration>? queueConfigurations,
    List<QueueMessage>? queueMessages,
    List<Quote>? quotes,
    List<RecommendationResult>? recommendationResults,
    List<Referral>? referrals,
    List<RentArrears>? rentArrears,
    List<RentSchedule>? rentSchedules,
    List<RentalSyncJob>? rentalSyncJobs,
    List<Report>? reports,
    List<ReportExecution>? reportExecutions,
    List<Reservation>? reservations,
    List<Review>? reviews,
    List<RightToRentCheck>? rightToRentChecks,
    List<Role>? roles,
    List<Route>? routes,
    List<SecurityDepositProtection>? securityDepositProtections,
    List<SignatureRequest>? signatureRequests,
    List<SignatureSigner>? signatureSigners,
    List<SolicitorManagement>? solicitorManagements,
    List<Subscription>? subscriptions,
    List<SystemMetrics>? systemMetrics,
    List<Tag>? tags,
    List<Task>? tasks,
    List<Tax1099Form>? tax1099Forms,
    List<TaxDepreciation>? taxDepreciations,
    List<TaxRecord>? taxRecords,
    List<TenantApplication>? tenantApplications,
    List<UserActivityLog>? userActivityLogs,
    List<UserPreference>? userPreferences,
    List<VacationRental>? vacationRentals,
    List<VendorProfile>? vendors,
    List<VirtualTour>? virtualTours,
    List<Webhook>? webhooks,
    List<WebhookDelivery>? webhookDeliveries,
    List<EscrowAccount>? escrowAccounts,
    List<EscrowRelease>? escrowReleases,
    List<EscrowDispute>? escrowDisputes,
    List<PaymentNegotiation>? paymentNegotiations,
    List<PaymentInstallment>? paymentInstallments,
    List<VideoContent>? videoContents,
    List<BrandAmbassador>? brandAmbassadors,
    List<AmbassadorCampaign>? ambassadorCampaigns,
    List<SocialImpactCounter>? socialImpactCounters,
    List<SocialImpactRecord>? socialImpactRecords,
    List<NegotiationOffer>? negotiationOffers,
    List<AmbassadorContract>? ambassadorContracts,
    List<EscrowStatusHistory>? escrowStatusHistories,
    List<AiChatMessage>? aiChatMessages,
    List<AiChatHandoff>? aiChatHandoffs,
    List<DocumentAnalysis>? analyses,
    List<AnalysisJob>? analysisJobs,
  }) {
    return Organization(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      region: region ?? this.region,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      defaultLocale: defaultLocale ?? this.defaultLocale,
      legalName: legalName ?? this.legalName,
      taxId: taxId ?? this.taxId,
      addres: addres ?? this.addres,
      contactEmail: contactEmail ?? this.contactEmail,
      managementFeeType: managementFeeType ?? this.managementFeeType,
      managementFeeRate: managementFeeRate ?? this.managementFeeRate,
      managementFeeAmount: managementFeeAmount ?? this.managementFeeAmount,
      managementFeeScope: managementFeeScope ?? this.managementFeeScope,
      taxReportingEnabled: taxReportingEnabled ?? this.taxReportingEnabled,
      complianceTracking: complianceTracking ?? this.complianceTracking,
      requiredInspections: requiredInspections ?? this.requiredInspections,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      aiChatbotSessions: aiChatbotSessions ?? this.aiChatbotSessions,
      aiFraudDetections: aiFraudDetections ?? this.aiFraudDetections,
      aiImageAnalyses: aiImageAnalyses ?? this.aiImageAnalyses,
      aiInvestmentAnalyses: aiInvestmentAnalyses ?? this.aiInvestmentAnalyses,
      aiLeadScores: aiLeadScores ?? this.aiLeadScores,
      aiLeadScoringModels: aiLeadScoringModels ?? this.aiLeadScoringModels,
      aiMarketAnalyses: aiMarketAnalyses ?? this.aiMarketAnalyses,
      aiModels: aiModels ?? this.aiModels,
      aiModelDeployments: aiModelDeployments ?? this.aiModelDeployments,
      aiPredictions: aiPredictions ?? this.aiPredictions,
      aiPredictiveMaintenance: aiPredictiveMaintenance ?? this.aiPredictiveMaintenance,
      aiPriceOptimizations: aiPriceOptimizations ?? this.aiPriceOptimizations,
      aiPropertyDescriptions: aiPropertyDescriptions ?? this.aiPropertyDescriptions,
      aiPropertyValuations: aiPropertyValuations ?? this.aiPropertyValuations,
      aiRecommendations: aiRecommendations ?? this.aiRecommendations,
      aiSentimentAnalyses: aiSentimentAnalyses ?? this.aiSentimentAnalyses,
      aiTenantScreenings: aiTenantScreenings ?? this.aiTenantScreenings,
      aiValuationModels: aiValuationModels ?? this.aiValuationModels,
      integrations: integrations ?? this.integrations,
      achievements: achievements ?? this.achievements,
      agencies: agencies ?? this.agencies,
      agencyRelations: agencyRelations ?? this.agencyRelations,
      organizationAgencies: organizationAgencies ?? this.organizationAgencies,
      agentAssignments: agentAssignments ?? this.agentAssignments,
      agentTeams: agentTeams ?? this.agentTeams,
      amenities: amenities ?? this.amenities,
      apiIntegrations: apiIntegrations ?? this.apiIntegrations,
      apiKeys: apiKeys ?? this.apiKeys,
      appointments: appointments ?? this.appointments,
      attachments: attachments ?? this.attachments,
      attorneyCases: attorneyCases ?? this.attorneyCases,
      auditLogs: auditLogs ?? this.auditLogs,
      automationExecutions: automationExecutions ?? this.automationExecutions,
      automationRules: automationRules ?? this.automationRules,
      bookings: bookings ?? this.bookings,
      budgets: budgets ?? this.budgets,
      calendarEvents: calendarEvents ?? this.calendarEvents,
      commissions: commissions ?? this.commissions,
      communicationTemplates: communicationTemplates ?? this.communicationTemplates,
      contacts: contacts ?? this.contacts,
      contracts: contracts ?? this.contracts,
      contractVersions: contractVersions ?? this.contractVersions,
      dashboardConfigurations: dashboardConfigurations ?? this.dashboardConfigurations,
      dashboardWidgets: dashboardWidgets ?? this.dashboardWidgets,
      deals: deals ?? this.deals,
      depositProtections: depositProtections ?? this.depositProtections,
      documents: documents ?? this.documents,
      documentTemplates: documentTemplates ?? this.documentTemplates,
      earnings: earnings ?? this.earnings,
      events: events ?? this.events,
      eventAttendees: eventAttendees ?? this.eventAttendees,
      exchangeRates: exchangeRates ?? this.exchangeRates,
      exportFiles: exportFiles ?? this.exportFiles,
      exportJobs: exportJobs ?? this.exportJobs,
      externalRentalListings: externalRentalListings ?? this.externalRentalListings,
      facilities: facilities ?? this.facilities,
      financialRecords: financialRecords ?? this.financialRecords,
      floorPlans: floorPlans ?? this.floorPlans,
      giftCards: giftCards ?? this.giftCards,
      govtIntegrations: govtIntegrations ?? this.govtIntegrations,
      healthChecks: healthChecks ?? this.healthChecks,
      homeInformationPacks: homeInformationPacks ?? this.homeInformationPacks,
      immigrationStatusChecks: immigrationStatusChecks ?? this.immigrationStatusChecks,
      integrationLogs: integrationLogs ?? this.integrationLogs,
      investorPortfolios: investorPortfolios ?? this.investorPortfolios,
      keys: keys ?? this.keys,
      leads: leads ?? this.leads,
      leadSources: leadSources ?? this.leadSources,
      leases: leases ?? this.leases,
      leaseRenewals: leaseRenewals ?? this.leaseRenewals,
      ledgerEntries: ledgerEntries ?? this.ledgerEntries,
      listings: listings ?? this.listings,
      listingChannels: listingChannels ?? this.listingChannels,
      listingStatusHistories: listingStatusHistories ?? this.listingStatusHistories,
      listingTags: listingTags ?? this.listingTags,
      locations: locations ?? this.locations,
      loyaltyAccounts: loyaltyAccounts ?? this.loyaltyAccounts,
      mlsConnections: mlsConnections ?? this.mlsConnections,
      mlsexternalListings: mlsexternalListings ?? this.mlsexternalListings,
      mlssyncJobs: mlssyncJobs ?? this.mlssyncJobs,
      maintenanceBlocks: maintenanceBlocks ?? this.maintenanceBlocks,
      workOrders: workOrders ?? this.workOrders,
      mapLayers: mapLayers ?? this.mapLayers,
      marketingCampaigns: marketingCampaigns ?? this.marketingCampaigns,
      messages: messages ?? this.messages,
      mlsDataMappings: mlsDataMappings ?? this.mlsDataMappings,
      mlsListingEnhancements: mlsListingEnhancements ?? this.mlsListingEnhancements,
      mobileDevices: mobileDevices ?? this.mobileDevices,
      mortgageOffers: mortgageOffers ?? this.mortgageOffers,
      mortgagePreApprovals: mortgagePreApprovals ?? this.mortgagePreApprovals,
      neighborhoods: neighborhoods ?? this.neighborhoods,
      notifications: notifications ?? this.notifications,
      offlineSyncQueues: offlineSyncQueues ?? this.offlineSyncQueues,
      orgSubscription: orgSubscription ?? this.orgSubscription,
      payouts: payouts ?? this.payouts,
      performanceAlerts: performanceAlerts ?? this.performanceAlerts,
      predictiveModels: predictiveModels ?? this.predictiveModels,
      projects: projects ?? this.projects,
      properties: properties ?? this.properties,
      propertyAmenities: propertyAmenities ?? this.propertyAmenities,
      propertyCompliance: propertyCompliance ?? this.propertyCompliance,
      propertyDisclosures: propertyDisclosures ?? this.propertyDisclosures,
      propertyDocuments: propertyDocuments ?? this.propertyDocuments,
      inventories: inventories ?? this.inventories,
      propertyOffers: propertyOffers ?? this.propertyOffers,
      propertyPhotos: propertyPhotos ?? this.propertyPhotos,
      propertyViewings: propertyViewings ?? this.propertyViewings,
      queueConfigurations: queueConfigurations ?? this.queueConfigurations,
      queueMessages: queueMessages ?? this.queueMessages,
      quotes: quotes ?? this.quotes,
      recommendationResults: recommendationResults ?? this.recommendationResults,
      referrals: referrals ?? this.referrals,
      rentArrears: rentArrears ?? this.rentArrears,
      rentSchedules: rentSchedules ?? this.rentSchedules,
      rentalSyncJobs: rentalSyncJobs ?? this.rentalSyncJobs,
      reports: reports ?? this.reports,
      reportExecutions: reportExecutions ?? this.reportExecutions,
      reservations: reservations ?? this.reservations,
      reviews: reviews ?? this.reviews,
      rightToRentChecks: rightToRentChecks ?? this.rightToRentChecks,
      roles: roles ?? this.roles,
      routes: routes ?? this.routes,
      securityDepositProtections: securityDepositProtections ?? this.securityDepositProtections,
      signatureRequests: signatureRequests ?? this.signatureRequests,
      signatureSigners: signatureSigners ?? this.signatureSigners,
      solicitorManagements: solicitorManagements ?? this.solicitorManagements,
      subscriptions: subscriptions ?? this.subscriptions,
      systemMetrics: systemMetrics ?? this.systemMetrics,
      tags: tags ?? this.tags,
      tasks: tasks ?? this.tasks,
      tax1099Forms: tax1099Forms ?? this.tax1099Forms,
      taxDepreciations: taxDepreciations ?? this.taxDepreciations,
      taxRecords: taxRecords ?? this.taxRecords,
      tenantApplications: tenantApplications ?? this.tenantApplications,
      userActivityLogs: userActivityLogs ?? this.userActivityLogs,
      userPreferences: userPreferences ?? this.userPreferences,
      vacationRentals: vacationRentals ?? this.vacationRentals,
      vendors: vendors ?? this.vendors,
      virtualTours: virtualTours ?? this.virtualTours,
      webhooks: webhooks ?? this.webhooks,
      webhookDeliveries: webhookDeliveries ?? this.webhookDeliveries,
      escrowAccounts: escrowAccounts ?? this.escrowAccounts,
      escrowReleases: escrowReleases ?? this.escrowReleases,
      escrowDisputes: escrowDisputes ?? this.escrowDisputes,
      paymentNegotiations: paymentNegotiations ?? this.paymentNegotiations,
      paymentInstallments: paymentInstallments ?? this.paymentInstallments,
      videoContents: videoContents ?? this.videoContents,
      brandAmbassadors: brandAmbassadors ?? this.brandAmbassadors,
      ambassadorCampaigns: ambassadorCampaigns ?? this.ambassadorCampaigns,
      socialImpactCounters: socialImpactCounters ?? this.socialImpactCounters,
      socialImpactRecords: socialImpactRecords ?? this.socialImpactRecords,
      negotiationOffers: negotiationOffers ?? this.negotiationOffers,
      ambassadorContracts: ambassadorContracts ?? this.ambassadorContracts,
      escrowStatusHistories: escrowStatusHistories ?? this.escrowStatusHistories,
      aiChatMessages: aiChatMessages ?? this.aiChatMessages,
      aiChatHandoffs: aiChatHandoffs ?? this.aiChatHandoffs,
      analyses: analyses ?? this.analyses,
      analysisJobs: analysisJobs ?? this.analysisJobs,
    );
  }
}
