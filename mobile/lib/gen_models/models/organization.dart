
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'org_type.dart';
import 'region.dart';
import 'management_fee_type.dart';
import 'management_fee_scope.dart';
import 'compliance_type.dart';
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
import 'api_integration.dart';
import 'achievement.dart';
import 'agency.dart';
import 'agent_assignment.dart';
import 'agent_team.dart';
import 'amenity.dart';
import 'api_integration.dart';
import 'api_key.dart';
import 'appointment.dart';
import 'attachment.dart';
import 'attorney_management.dart';
import 'audit_log.dart';
import 'automation_execution.dart';
import 'automation_rule.dart';
import 'booking.dart';
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
import 'document_template.dart';
import 'earning.dart';
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
import 'm_l_s_connection.dart';
import 'm_l_s_external_listing.dart';
import 'm_l_s_sync_job.dart';
import 'maintenance_block.dart';
import 'maintenance_work_order.dart';
import 'map_layer.dart';
import 'marketing_campaign.dart';
import 'message.dart';
import 'mls_data_mapping.dart';
import 'mls_listing_enhancement.dart';
import 'mobile_device.dart';
import 'mortgage_offer.dart';
import 'mortgage_pre_approval.dart';
import 'neighborhood.dart';
import 'notification.dart';
import 'offline_sync_queue.dart';
import 'org_subscription.dart';
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
import 'virtual_tour.dart';
import 'webhook.dart';
import 'webhook_delivery.dart';
import 'escrow_account.dart';
import 'escrow_release.dart';
import 'escrow_dispute.dart';
import 'payment_negotiation.dart';
import 'payment_installment.dart';
import 'video_content.dart';
import 'brand_ambassador.dart';
import 'ambassador_campaign.dart';
import 'social_impact_counter.dart';
import 'social_impact_record.dart';
import 'negotiation_offer.dart';
import 'ambassador_contract.dart';
import 'escrow_status_history.dart';
import 'ai_chat_message.dart';
import 'ai_chat_handoff.dart';
import 'document_analysis.dart';
import 'analysis_job.dart';


class Organization implements PrismaModel<String, Organization> , Id<String> {
    @override
String? id;
	String? name;
	OrgType? type;
	Region? region;
	String? defaultCurrency;
	String? defaultLocale;
	String? legalName;
	String? taxId;
	String? address;
	String? contactEmail;
	ManagementFeeType? managementFeeType;
	double? managementFeeRate;
	double? managementFeeAmount;
	ManagementFeeScope? managementFeeScope;
	bool? taxReportingEnabled;
	bool? complianceTracking;
	List<ComplianceType>? requiredInspections;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<AIChatbotSession>? aiChatbotSessions;
	List<AIFraudDetection>? aiFraudDetections;
	List<AIImageAnalysis>? aiImageAnalyses;
	List<AIInvestmentAnalysis>? aiInvestmentAnalyses;
	List<AILeadScore>? aiLeadScores;
	List<AILeadScoring>? aiLeadScoringModels;
	List<AIMarketAnalysis>? aiMarketAnalyses;
	List<AIModel>? aiModels;
	List<AIModelDeployment>? aiModelDeployments;
	List<AIPrediction>? aiPredictions;
	List<AIPredictiveMaintenance>? aiPredictiveMaintenance;
	List<AIPriceOptimization>? aiPriceOptimizations;
	List<AIPropertyDescription>? aiPropertyDescriptions;
	List<AIPropertyValuation>? aiPropertyValuations;
	List<AIRecommendation>? aiRecommendations;
	List<AISentimentAnalysis>? aiSentimentAnalyses;
	List<AITenantScreening>? aiTenantScreenings;
	List<AIValuationModel>? aiValuationModels;
	List<APIIntegration>? integrations;
	List<Achievement>? achievements;
	List<Agency>? agencies;
	List<Agency>? agencyRelations;
	List<Agency>? organizationAgencies;
	List<AgentAssignment>? agentAssignments;
	List<AgentTeam>? agentTeams;
	List<Amenity>? amenities;
	List<ApiIntegration>? apiIntegrations;
	List<ApiKey>? apiKeys;
	List<Appointment>? appointments;
	List<Attachment>? attachments;
	List<AttorneyManagement>? attorneyCases;
	List<AuditLog>? auditLogs;
	List<AutomationExecution>? automationExecutions;
	List<AutomationRule>? automationRules;
	List<Booking>? bookings;
	List<Budget>? budgets;
	List<CalendarEvent>? calendarEvents;
	List<Commission>? commissions;
	List<CommunicationTemplate>? communicationTemplates;
	List<Contact>? contacts;
	List<Contract>? contracts;
	List<ContractVersion>? contractVersions;
	List<DashboardConfiguration>? dashboardConfigurations;
	List<DashboardWidget>? dashboardWidgets;
	List<Deal>? deals;
	List<DepositProtection>? depositProtections;
	List<Document>? documents;
	List<DocumentTemplate>? documentTemplates;
	List<Earning>? earnings;
	List<Event>? events;
	List<EventAttendee>? eventAttendees;
	List<ExchangeRate>? exchangeRates;
	List<ExportFile>? exportFiles;
	List<ExportJob>? exportJobs;
	List<ExternalRentalListing>? externalRentalListings;
	List<Facility>? facilities;
	List<FinancialRecord>? financialRecords;
	List<FloorPlan>? floorPlans;
	List<GiftCard>? giftCards;
	List<GovernmentIntegration>? govtIntegrations;
	List<HealthCheck>? healthChecks;
	List<HomeInformationPack>? homeInformationPacks;
	List<ImmigrationStatusCheck>? immigrationStatusChecks;
	List<IntegrationLog>? integrationLogs;
	List<InvestorPortfolio>? investorPortfolios;
	List<KeyManagement>? keys;
	List<Lead>? leads;
	List<LeadSource>? leadSources;
	List<Lease>? leases;
	List<LeaseRenewal>? leaseRenewals;
	List<LedgerEntry>? ledgerEntries;
	List<Listing>? listings;
	List<ListingChannel>? listingChannels;
	List<ListingStatusHistory>? listingStatusHistories;
	List<ListingTag>? listingTags;
	List<Location>? locations;
	List<LoyaltyAccount>? loyaltyAccounts;
	List<MLSConnection>? mlsConnections;
	List<MLSExternalListing>? mlsexternalListings;
	List<MLSSyncJob>? mlssyncJobs;
	List<MaintenanceBlock>? maintenanceBlocks;
	List<MaintenanceWorkOrder>? workOrders;
	List<MapLayer>? mapLayers;
	List<MarketingCampaign>? marketingCampaigns;
	List<Message>? messages;
	List<MlsDataMapping>? mlsDataMappings;
	List<MlsListingEnhancement>? mlsListingEnhancements;
	List<MobileDevice>? mobileDevices;
	List<MortgageOffer>? mortgageOffers;
	List<MortgagePreApproval>? mortgagePreApprovals;
	List<Neighborhood>? neighborhoods;
	List<Notification>? notifications;
	List<OfflineSyncQueue>? offlineSyncQueues;
	OrgSubscription? orgSubscription;
	List<Payout>? payouts;
	List<PerformanceAlert>? performanceAlerts;
	List<PredictiveModel>? predictiveModels;
	List<Project>? projects;
	List<Property>? properties;
	List<PropertyAmenity>? propertyAmenities;
	List<PropertyCompliance>? propertyCompliance;
	List<PropertyDisclosure>? propertyDisclosures;
	List<PropertyDocument>? propertyDocuments;
	List<PropertyInventory>? inventories;
	List<PropertyOffer>? propertyOffers;
	List<PropertyPhoto>? propertyPhotos;
	List<PropertyViewing>? propertyViewings;
	List<QueueConfiguration>? queueConfigurations;
	List<QueueMessage>? queueMessages;
	List<Quote>? quotes;
	List<RecommendationResult>? recommendationResults;
	List<Referral>? referrals;
	List<RentArrears>? rentArrears;
	List<RentSchedule>? rentSchedules;
	List<RentalSyncJob>? rentalSyncJobs;
	List<Report>? reports;
	List<ReportExecution>? reportExecutions;
	List<Reservation>? reservations;
	List<Review>? reviews;
	List<RightToRentCheck>? rightToRentChecks;
	List<Role>? roles;
	List<Route>? routes;
	List<SecurityDepositProtection>? securityDepositProtections;
	List<SignatureRequest>? signatureRequests;
	List<SignatureSigner>? signatureSigners;
	List<SolicitorManagement>? solicitorManagements;
	List<Subscription>? subscriptions;
	List<SystemMetrics>? systemMetrics;
	List<Tag>? tags;
	List<Task>? tasks;
	List<Tax1099Form>? tax1099Forms;
	List<TaxDepreciation>? taxDepreciations;
	List<TaxRecord>? taxRecords;
	List<TenantApplication>? tenantApplications;
	List<UserActivityLog>? userActivityLogs;
	List<UserPreference>? userPreferences;
	List<VacationRental>? vacationRentals;
	List<VendorProfile>? vendors;
	List<VirtualTour>? virtualTours;
	List<Webhook>? webhooks;
	List<WebhookDelivery>? webhookDeliveries;
	List<EscrowAccount>? escrowAccounts;
	List<EscrowRelease>? escrowReleases;
	List<EscrowDispute>? escrowDisputes;
	List<PaymentNegotiation>? paymentNegotiations;
	List<PaymentInstallment>? paymentInstallments;
	List<VideoContent>? videoContents;
	List<BrandAmbassador>? brandAmbassadors;
	List<AmbassadorCampaign>? ambassadorCampaigns;
	List<SocialImpactCounter>? socialImpactCounters;
	List<SocialImpactRecord>? socialImpactRecords;
	List<NegotiationOffer>? negotiationOffers;
	List<AmbassadorContract>? ambassadorContracts;
	List<EscrowStatusHistory>? escrowStatusHistories;
	List<AIChatMessage>? aiChatMessages;
	List<AIChatHandoff>? aiChatHandoffs;
	List<DocumentAnalysis>? analyses;
	List<AnalysisJob>? analysisJobs;
	int? $requiredInspectionsCount;
	int? $aiChatbotSessionsCount;
	int? $aiFraudDetectionsCount;
	int? $aiImageAnalysesCount;
	int? $aiInvestmentAnalysesCount;
	int? $aiLeadScoresCount;
	int? $aiLeadScoringModelsCount;
	int? $aiMarketAnalysesCount;
	int? $aiModelsCount;
	int? $aiModelDeploymentsCount;
	int? $aiPredictionsCount;
	int? $aiPredictiveMaintenanceCount;
	int? $aiPriceOptimizationsCount;
	int? $aiPropertyDescriptionsCount;
	int? $aiPropertyValuationsCount;
	int? $aiRecommendationsCount;
	int? $aiSentimentAnalysesCount;
	int? $aiTenantScreeningsCount;
	int? $aiValuationModelsCount;
	int? $integrationsCount;
	int? $achievementsCount;
	int? $agenciesCount;
	int? $agencyRelationsCount;
	int? $organizationAgenciesCount;
	int? $agentAssignmentsCount;
	int? $agentTeamsCount;
	int? $amenitiesCount;
	int? $apiIntegrationsCount;
	int? $apiKeysCount;
	int? $appointmentsCount;
	int? $attachmentsCount;
	int? $attorneyCasesCount;
	int? $auditLogsCount;
	int? $automationExecutionsCount;
	int? $automationRulesCount;
	int? $bookingsCount;
	int? $budgetsCount;
	int? $calendarEventsCount;
	int? $commissionsCount;
	int? $communicationTemplatesCount;
	int? $contactsCount;
	int? $contractsCount;
	int? $contractVersionsCount;
	int? $dashboardConfigurationsCount;
	int? $dashboardWidgetsCount;
	int? $dealsCount;
	int? $depositProtectionsCount;
	int? $documentsCount;
	int? $documentTemplatesCount;
	int? $earningsCount;
	int? $eventsCount;
	int? $eventAttendeesCount;
	int? $exchangeRatesCount;
	int? $exportFilesCount;
	int? $exportJobsCount;
	int? $externalRentalListingsCount;
	int? $facilitiesCount;
	int? $financialRecordsCount;
	int? $floorPlansCount;
	int? $giftCardsCount;
	int? $govtIntegrationsCount;
	int? $healthChecksCount;
	int? $homeInformationPacksCount;
	int? $immigrationStatusChecksCount;
	int? $integrationLogsCount;
	int? $investorPortfoliosCount;
	int? $keysCount;
	int? $leadsCount;
	int? $leadSourcesCount;
	int? $leasesCount;
	int? $leaseRenewalsCount;
	int? $ledgerEntriesCount;
	int? $listingsCount;
	int? $listingChannelsCount;
	int? $listingStatusHistoriesCount;
	int? $listingTagsCount;
	int? $locationsCount;
	int? $loyaltyAccountsCount;
	int? $mlsConnectionsCount;
	int? $mlsexternalListingsCount;
	int? $mlssyncJobsCount;
	int? $maintenanceBlocksCount;
	int? $workOrdersCount;
	int? $mapLayersCount;
	int? $marketingCampaignsCount;
	int? $messagesCount;
	int? $mlsDataMappingsCount;
	int? $mlsListingEnhancementsCount;
	int? $mobileDevicesCount;
	int? $mortgageOffersCount;
	int? $mortgagePreApprovalsCount;
	int? $neighborhoodsCount;
	int? $notificationsCount;
	int? $offlineSyncQueuesCount;
	int? $payoutsCount;
	int? $performanceAlertsCount;
	int? $predictiveModelsCount;
	int? $projectsCount;
	int? $propertiesCount;
	int? $propertyAmenitiesCount;
	int? $propertyComplianceCount;
	int? $propertyDisclosuresCount;
	int? $propertyDocumentsCount;
	int? $inventoriesCount;
	int? $propertyOffersCount;
	int? $propertyPhotosCount;
	int? $propertyViewingsCount;
	int? $queueConfigurationsCount;
	int? $queueMessagesCount;
	int? $quotesCount;
	int? $recommendationResultsCount;
	int? $referralsCount;
	int? $rentArrearsCount;
	int? $rentSchedulesCount;
	int? $rentalSyncJobsCount;
	int? $reportsCount;
	int? $reportExecutionsCount;
	int? $reservationsCount;
	int? $reviewsCount;
	int? $rightToRentChecksCount;
	int? $rolesCount;
	int? $routesCount;
	int? $securityDepositProtectionsCount;
	int? $signatureRequestsCount;
	int? $signatureSignersCount;
	int? $solicitorManagementsCount;
	int? $subscriptionsCount;
	int? $systemMetricsCount;
	int? $tagsCount;
	int? $tasksCount;
	int? $tax1099FormsCount;
	int? $taxDepreciationsCount;
	int? $taxRecordsCount;
	int? $tenantApplicationsCount;
	int? $userActivityLogsCount;
	int? $userPreferencesCount;
	int? $vacationRentalsCount;
	int? $vendorsCount;
	int? $virtualToursCount;
	int? $webhooksCount;
	int? $webhookDeliveriesCount;
	int? $escrowAccountsCount;
	int? $escrowReleasesCount;
	int? $escrowDisputesCount;
	int? $paymentNegotiationsCount;
	int? $paymentInstallmentsCount;
	int? $videoContentsCount;
	int? $brandAmbassadorsCount;
	int? $ambassadorCampaignsCount;
	int? $socialImpactCountersCount;
	int? $socialImpactRecordsCount;
	int? $negotiationOffersCount;
	int? $ambassadorContractsCount;
	int? $escrowStatusHistoriesCount;
	int? $aiChatMessagesCount;
	int? $aiChatHandoffsCount;
	int? $analysesCount;
	int? $analysisJobsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Organization({ this.id,
	 this.name,
	 this.type,
	 this.region,
	 this.defaultCurrency = "USD",
	 this.defaultLocale = "en-US",
	 this.legalName,
	 this.taxId,
	 this.address,
	 this.contactEmail,
	 this.managementFeeType,
	 this.managementFeeRate,
	 this.managementFeeAmount,
	 this.managementFeeScope,
	 this.taxReportingEnabled = false,
	 this.complianceTracking = true,
	 this.requiredInspections,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.aiChatbotSessions,
	 this.aiFraudDetections,
	 this.aiImageAnalyses,
	 this.aiInvestmentAnalyses,
	 this.aiLeadScores,
	 this.aiLeadScoringModels,
	 this.aiMarketAnalyses,
	 this.aiModels,
	 this.aiModelDeployments,
	 this.aiPredictions,
	 this.aiPredictiveMaintenance,
	 this.aiPriceOptimizations,
	 this.aiPropertyDescriptions,
	 this.aiPropertyValuations,
	 this.aiRecommendations,
	 this.aiSentimentAnalyses,
	 this.aiTenantScreenings,
	 this.aiValuationModels,
	 this.integrations,
	 this.achievements,
	 this.agencies,
	 this.agencyRelations,
	 this.organizationAgencies,
	 this.agentAssignments,
	 this.agentTeams,
	 this.amenities,
	 this.apiIntegrations,
	 this.apiKeys,
	 this.appointments,
	 this.attachments,
	 this.attorneyCases,
	 this.auditLogs,
	 this.automationExecutions,
	 this.automationRules,
	 this.bookings,
	 this.budgets,
	 this.calendarEvents,
	 this.commissions,
	 this.communicationTemplates,
	 this.contacts,
	 this.contracts,
	 this.contractVersions,
	 this.dashboardConfigurations,
	 this.dashboardWidgets,
	 this.deals,
	 this.depositProtections,
	 this.documents,
	 this.documentTemplates,
	 this.earnings,
	 this.events,
	 this.eventAttendees,
	 this.exchangeRates,
	 this.exportFiles,
	 this.exportJobs,
	 this.externalRentalListings,
	 this.facilities,
	 this.financialRecords,
	 this.floorPlans,
	 this.giftCards,
	 this.govtIntegrations,
	 this.healthChecks,
	 this.homeInformationPacks,
	 this.immigrationStatusChecks,
	 this.integrationLogs,
	 this.investorPortfolios,
	 this.keys,
	 this.leads,
	 this.leadSources,
	 this.leases,
	 this.leaseRenewals,
	 this.ledgerEntries,
	 this.listings,
	 this.listingChannels,
	 this.listingStatusHistories,
	 this.listingTags,
	 this.locations,
	 this.loyaltyAccounts,
	 this.mlsConnections,
	 this.mlsexternalListings,
	 this.mlssyncJobs,
	 this.maintenanceBlocks,
	 this.workOrders,
	 this.mapLayers,
	 this.marketingCampaigns,
	 this.messages,
	 this.mlsDataMappings,
	 this.mlsListingEnhancements,
	 this.mobileDevices,
	 this.mortgageOffers,
	 this.mortgagePreApprovals,
	 this.neighborhoods,
	 this.notifications,
	 this.offlineSyncQueues,
	 this.orgSubscription,
	 this.payouts,
	 this.performanceAlerts,
	 this.predictiveModels,
	 this.projects,
	 this.properties,
	 this.propertyAmenities,
	 this.propertyCompliance,
	 this.propertyDisclosures,
	 this.propertyDocuments,
	 this.inventories,
	 this.propertyOffers,
	 this.propertyPhotos,
	 this.propertyViewings,
	 this.queueConfigurations,
	 this.queueMessages,
	 this.quotes,
	 this.recommendationResults,
	 this.referrals,
	 this.rentArrears,
	 this.rentSchedules,
	 this.rentalSyncJobs,
	 this.reports,
	 this.reportExecutions,
	 this.reservations,
	 this.reviews,
	 this.rightToRentChecks,
	 this.roles,
	 this.routes,
	 this.securityDepositProtections,
	 this.signatureRequests,
	 this.signatureSigners,
	 this.solicitorManagements,
	 this.subscriptions,
	 this.systemMetrics,
	 this.tags,
	 this.tasks,
	 this.tax1099Forms,
	 this.taxDepreciations,
	 this.taxRecords,
	 this.tenantApplications,
	 this.userActivityLogs,
	 this.userPreferences,
	 this.vacationRentals,
	 this.vendors,
	 this.virtualTours,
	 this.webhooks,
	 this.webhookDeliveries,
	 this.escrowAccounts,
	 this.escrowReleases,
	 this.escrowDisputes,
	 this.paymentNegotiations,
	 this.paymentInstallments,
	 this.videoContents,
	 this.brandAmbassadors,
	 this.ambassadorCampaigns,
	 this.socialImpactCounters,
	 this.socialImpactRecords,
	 this.negotiationOffers,
	 this.ambassadorContracts,
	 this.escrowStatusHistories,
	 this.aiChatMessages,
	 this.aiChatHandoffs,
	 this.analyses,
	 this.analysisJobs,
	this.$requiredInspectionsCount,
	this.$aiChatbotSessionsCount,
	this.$aiFraudDetectionsCount,
	this.$aiImageAnalysesCount,
	this.$aiInvestmentAnalysesCount,
	this.$aiLeadScoresCount,
	this.$aiLeadScoringModelsCount,
	this.$aiMarketAnalysesCount,
	this.$aiModelsCount,
	this.$aiModelDeploymentsCount,
	this.$aiPredictionsCount,
	this.$aiPredictiveMaintenanceCount,
	this.$aiPriceOptimizationsCount,
	this.$aiPropertyDescriptionsCount,
	this.$aiPropertyValuationsCount,
	this.$aiRecommendationsCount,
	this.$aiSentimentAnalysesCount,
	this.$aiTenantScreeningsCount,
	this.$aiValuationModelsCount,
	this.$integrationsCount,
	this.$achievementsCount,
	this.$agenciesCount,
	this.$agencyRelationsCount,
	this.$organizationAgenciesCount,
	this.$agentAssignmentsCount,
	this.$agentTeamsCount,
	this.$amenitiesCount,
	this.$apiIntegrationsCount,
	this.$apiKeysCount,
	this.$appointmentsCount,
	this.$attachmentsCount,
	this.$attorneyCasesCount,
	this.$auditLogsCount,
	this.$automationExecutionsCount,
	this.$automationRulesCount,
	this.$bookingsCount,
	this.$budgetsCount,
	this.$calendarEventsCount,
	this.$commissionsCount,
	this.$communicationTemplatesCount,
	this.$contactsCount,
	this.$contractsCount,
	this.$contractVersionsCount,
	this.$dashboardConfigurationsCount,
	this.$dashboardWidgetsCount,
	this.$dealsCount,
	this.$depositProtectionsCount,
	this.$documentsCount,
	this.$documentTemplatesCount,
	this.$earningsCount,
	this.$eventsCount,
	this.$eventAttendeesCount,
	this.$exchangeRatesCount,
	this.$exportFilesCount,
	this.$exportJobsCount,
	this.$externalRentalListingsCount,
	this.$facilitiesCount,
	this.$financialRecordsCount,
	this.$floorPlansCount,
	this.$giftCardsCount,
	this.$govtIntegrationsCount,
	this.$healthChecksCount,
	this.$homeInformationPacksCount,
	this.$immigrationStatusChecksCount,
	this.$integrationLogsCount,
	this.$investorPortfoliosCount,
	this.$keysCount,
	this.$leadsCount,
	this.$leadSourcesCount,
	this.$leasesCount,
	this.$leaseRenewalsCount,
	this.$ledgerEntriesCount,
	this.$listingsCount,
	this.$listingChannelsCount,
	this.$listingStatusHistoriesCount,
	this.$listingTagsCount,
	this.$locationsCount,
	this.$loyaltyAccountsCount,
	this.$mlsConnectionsCount,
	this.$mlsexternalListingsCount,
	this.$mlssyncJobsCount,
	this.$maintenanceBlocksCount,
	this.$workOrdersCount,
	this.$mapLayersCount,
	this.$marketingCampaignsCount,
	this.$messagesCount,
	this.$mlsDataMappingsCount,
	this.$mlsListingEnhancementsCount,
	this.$mobileDevicesCount,
	this.$mortgageOffersCount,
	this.$mortgagePreApprovalsCount,
	this.$neighborhoodsCount,
	this.$notificationsCount,
	this.$offlineSyncQueuesCount,
	this.$payoutsCount,
	this.$performanceAlertsCount,
	this.$predictiveModelsCount,
	this.$projectsCount,
	this.$propertiesCount,
	this.$propertyAmenitiesCount,
	this.$propertyComplianceCount,
	this.$propertyDisclosuresCount,
	this.$propertyDocumentsCount,
	this.$inventoriesCount,
	this.$propertyOffersCount,
	this.$propertyPhotosCount,
	this.$propertyViewingsCount,
	this.$queueConfigurationsCount,
	this.$queueMessagesCount,
	this.$quotesCount,
	this.$recommendationResultsCount,
	this.$referralsCount,
	this.$rentArrearsCount,
	this.$rentSchedulesCount,
	this.$rentalSyncJobsCount,
	this.$reportsCount,
	this.$reportExecutionsCount,
	this.$reservationsCount,
	this.$reviewsCount,
	this.$rightToRentChecksCount,
	this.$rolesCount,
	this.$routesCount,
	this.$securityDepositProtectionsCount,
	this.$signatureRequestsCount,
	this.$signatureSignersCount,
	this.$solicitorManagementsCount,
	this.$subscriptionsCount,
	this.$systemMetricsCount,
	this.$tagsCount,
	this.$tasksCount,
	this.$tax1099FormsCount,
	this.$taxDepreciationsCount,
	this.$taxRecordsCount,
	this.$tenantApplicationsCount,
	this.$userActivityLogsCount,
	this.$userPreferencesCount,
	this.$vacationRentalsCount,
	this.$vendorsCount,
	this.$virtualToursCount,
	this.$webhooksCount,
	this.$webhookDeliveriesCount,
	this.$escrowAccountsCount,
	this.$escrowReleasesCount,
	this.$escrowDisputesCount,
	this.$paymentNegotiationsCount,
	this.$paymentInstallmentsCount,
	this.$videoContentsCount,
	this.$brandAmbassadorsCount,
	this.$ambassadorCampaignsCount,
	this.$socialImpactCountersCount,
	this.$socialImpactRecordsCount,
	this.$negotiationOffersCount,
	this.$ambassadorContractsCount,
	this.$escrowStatusHistoriesCount,
	this.$aiChatMessagesCount,
	this.$aiChatHandoffsCount,
	this.$analysesCount,
	this.$analysisJobsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Organization, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"region": (m) => m.region,

	"defaultCurrency": (m) => m.defaultCurrency,

	"defaultLocale": (m) => m.defaultLocale,

	"legalName": (m) => m.legalName,

	"taxId": (m) => m.taxId,

	"address": (m) => m.address,

	"contactEmail": (m) => m.contactEmail,

	"managementFeeType": (m) => m.managementFeeType,

	"managementFeeRate": (m) => m.managementFeeRate,

	"managementFeeAmount": (m) => m.managementFeeAmount,

	"managementFeeScope": (m) => m.managementFeeScope,

	"taxReportingEnabled": (m) => m.taxReportingEnabled,

	"complianceTracking": (m) => m.complianceTracking,

	"requiredInspections": (m) => m.requiredInspections,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"aiChatbotSessions": (m) => m.aiChatbotSessions,

	"aiFraudDetections": (m) => m.aiFraudDetections,

	"aiImageAnalyses": (m) => m.aiImageAnalyses,

	"aiInvestmentAnalyses": (m) => m.aiInvestmentAnalyses,

	"aiLeadScores": (m) => m.aiLeadScores,

	"aiLeadScoringModels": (m) => m.aiLeadScoringModels,

	"aiMarketAnalyses": (m) => m.aiMarketAnalyses,

	"aiModels": (m) => m.aiModels,

	"aiModelDeployments": (m) => m.aiModelDeployments,

	"aiPredictions": (m) => m.aiPredictions,

	"aiPredictiveMaintenance": (m) => m.aiPredictiveMaintenance,

	"aiPriceOptimizations": (m) => m.aiPriceOptimizations,

	"aiPropertyDescriptions": (m) => m.aiPropertyDescriptions,

	"aiPropertyValuations": (m) => m.aiPropertyValuations,

	"aiRecommendations": (m) => m.aiRecommendations,

	"aiSentimentAnalyses": (m) => m.aiSentimentAnalyses,

	"aiTenantScreenings": (m) => m.aiTenantScreenings,

	"aiValuationModels": (m) => m.aiValuationModels,

	"integrations": (m) => m.integrations,

	"achievements": (m) => m.achievements,

	"agencies": (m) => m.agencies,

	"agencyRelations": (m) => m.agencyRelations,

	"organizationAgencies": (m) => m.organizationAgencies,

	"agentAssignments": (m) => m.agentAssignments,

	"agentTeams": (m) => m.agentTeams,

	"amenities": (m) => m.amenities,

	"apiIntegrations": (m) => m.apiIntegrations,

	"apiKeys": (m) => m.apiKeys,

	"appointments": (m) => m.appointments,

	"attachments": (m) => m.attachments,

	"attorneyCases": (m) => m.attorneyCases,

	"auditLogs": (m) => m.auditLogs,

	"automationExecutions": (m) => m.automationExecutions,

	"automationRules": (m) => m.automationRules,

	"bookings": (m) => m.bookings,

	"budgets": (m) => m.budgets,

	"calendarEvents": (m) => m.calendarEvents,

	"commissions": (m) => m.commissions,

	"communicationTemplates": (m) => m.communicationTemplates,

	"contacts": (m) => m.contacts,

	"contracts": (m) => m.contracts,

	"contractVersions": (m) => m.contractVersions,

	"dashboardConfigurations": (m) => m.dashboardConfigurations,

	"dashboardWidgets": (m) => m.dashboardWidgets,

	"deals": (m) => m.deals,

	"depositProtections": (m) => m.depositProtections,

	"documents": (m) => m.documents,

	"documentTemplates": (m) => m.documentTemplates,

	"earnings": (m) => m.earnings,

	"events": (m) => m.events,

	"eventAttendees": (m) => m.eventAttendees,

	"exchangeRates": (m) => m.exchangeRates,

	"exportFiles": (m) => m.exportFiles,

	"exportJobs": (m) => m.exportJobs,

	"externalRentalListings": (m) => m.externalRentalListings,

	"facilities": (m) => m.facilities,

	"financialRecords": (m) => m.financialRecords,

	"floorPlans": (m) => m.floorPlans,

	"giftCards": (m) => m.giftCards,

	"govtIntegrations": (m) => m.govtIntegrations,

	"healthChecks": (m) => m.healthChecks,

	"homeInformationPacks": (m) => m.homeInformationPacks,

	"immigrationStatusChecks": (m) => m.immigrationStatusChecks,

	"integrationLogs": (m) => m.integrationLogs,

	"investorPortfolios": (m) => m.investorPortfolios,

	"keys": (m) => m.keys,

	"leads": (m) => m.leads,

	"leadSources": (m) => m.leadSources,

	"leases": (m) => m.leases,

	"leaseRenewals": (m) => m.leaseRenewals,

	"ledgerEntries": (m) => m.ledgerEntries,

	"listings": (m) => m.listings,

	"listingChannels": (m) => m.listingChannels,

	"listingStatusHistories": (m) => m.listingStatusHistories,

	"listingTags": (m) => m.listingTags,

	"locations": (m) => m.locations,

	"loyaltyAccounts": (m) => m.loyaltyAccounts,

	"mlsConnections": (m) => m.mlsConnections,

	"mlsexternalListings": (m) => m.mlsexternalListings,

	"mlssyncJobs": (m) => m.mlssyncJobs,

	"maintenanceBlocks": (m) => m.maintenanceBlocks,

	"workOrders": (m) => m.workOrders,

	"mapLayers": (m) => m.mapLayers,

	"marketingCampaigns": (m) => m.marketingCampaigns,

	"messages": (m) => m.messages,

	"mlsDataMappings": (m) => m.mlsDataMappings,

	"mlsListingEnhancements": (m) => m.mlsListingEnhancements,

	"mobileDevices": (m) => m.mobileDevices,

	"mortgageOffers": (m) => m.mortgageOffers,

	"mortgagePreApprovals": (m) => m.mortgagePreApprovals,

	"neighborhoods": (m) => m.neighborhoods,

	"notifications": (m) => m.notifications,

	"offlineSyncQueues": (m) => m.offlineSyncQueues,

	"orgSubscription": (m) => m.orgSubscription,

	"payouts": (m) => m.payouts,

	"performanceAlerts": (m) => m.performanceAlerts,

	"predictiveModels": (m) => m.predictiveModels,

	"projects": (m) => m.projects,

	"properties": (m) => m.properties,

	"propertyAmenities": (m) => m.propertyAmenities,

	"propertyCompliance": (m) => m.propertyCompliance,

	"propertyDisclosures": (m) => m.propertyDisclosures,

	"propertyDocuments": (m) => m.propertyDocuments,

	"inventories": (m) => m.inventories,

	"propertyOffers": (m) => m.propertyOffers,

	"propertyPhotos": (m) => m.propertyPhotos,

	"propertyViewings": (m) => m.propertyViewings,

	"queueConfigurations": (m) => m.queueConfigurations,

	"queueMessages": (m) => m.queueMessages,

	"quotes": (m) => m.quotes,

	"recommendationResults": (m) => m.recommendationResults,

	"referrals": (m) => m.referrals,

	"rentArrears": (m) => m.rentArrears,

	"rentSchedules": (m) => m.rentSchedules,

	"rentalSyncJobs": (m) => m.rentalSyncJobs,

	"reports": (m) => m.reports,

	"reportExecutions": (m) => m.reportExecutions,

	"reservations": (m) => m.reservations,

	"reviews": (m) => m.reviews,

	"rightToRentChecks": (m) => m.rightToRentChecks,

	"roles": (m) => m.roles,

	"routes": (m) => m.routes,

	"securityDepositProtections": (m) => m.securityDepositProtections,

	"signatureRequests": (m) => m.signatureRequests,

	"signatureSigners": (m) => m.signatureSigners,

	"solicitorManagements": (m) => m.solicitorManagements,

	"subscriptions": (m) => m.subscriptions,

	"systemMetrics": (m) => m.systemMetrics,

	"tags": (m) => m.tags,

	"tasks": (m) => m.tasks,

	"tax1099Forms": (m) => m.tax1099Forms,

	"taxDepreciations": (m) => m.taxDepreciations,

	"taxRecords": (m) => m.taxRecords,

	"tenantApplications": (m) => m.tenantApplications,

	"userActivityLogs": (m) => m.userActivityLogs,

	"userPreferences": (m) => m.userPreferences,

	"vacationRentals": (m) => m.vacationRentals,

	"vendors": (m) => m.vendors,

	"virtualTours": (m) => m.virtualTours,

	"webhooks": (m) => m.webhooks,

	"webhookDeliveries": (m) => m.webhookDeliveries,

	"escrowAccounts": (m) => m.escrowAccounts,

	"escrowReleases": (m) => m.escrowReleases,

	"escrowDisputes": (m) => m.escrowDisputes,

	"paymentNegotiations": (m) => m.paymentNegotiations,

	"paymentInstallments": (m) => m.paymentInstallments,

	"videoContents": (m) => m.videoContents,

	"brandAmbassadors": (m) => m.brandAmbassadors,

	"ambassadorCampaigns": (m) => m.ambassadorCampaigns,

	"socialImpactCounters": (m) => m.socialImpactCounters,

	"socialImpactRecords": (m) => m.socialImpactRecords,

	"negotiationOffers": (m) => m.negotiationOffers,

	"ambassadorContracts": (m) => m.ambassadorContracts,

	"escrowStatusHistories": (m) => m.escrowStatusHistories,

	"aiChatMessages": (m) => m.aiChatMessages,

	"aiChatHandoffs": (m) => m.aiChatHandoffs,

	"analyses": (m) => m.analyses,

	"analysisJobs": (m) => m.analysisJobs,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Organization) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Organization');
    }
    return propFunction as V? Function(Organization);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Organization.fromJson(JsonMap json) =>
      Organization(
        id: json['id'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? OrgType.fromJson(json['type']) : null,
	region: json['region'] != null ? Region.fromJson(json['region']) : null,
	defaultCurrency: json['defaultCurrency'] as String?,
	defaultLocale: json['defaultLocale'] as String?,
	legalName: json['legalName'] as String?,
	taxId: json['taxId'] as String?,
	address: json['address'] as String?,
	contactEmail: json['contactEmail'] as String?,
	managementFeeType: json['managementFeeType'] != null ? ManagementFeeType.fromJson(json['managementFeeType']) : null,
	managementFeeRate: json['managementFeeRate']?.toDouble(),
	managementFeeAmount: json['managementFeeAmount'] as double?,
	managementFeeScope: json['managementFeeScope'] != null ? ManagementFeeScope.fromJson(json['managementFeeScope']) : null,
	taxReportingEnabled: json['taxReportingEnabled'] as bool?,
	complianceTracking: json['complianceTracking'] as bool?,
	requiredInspections: json['requiredInspections'] != null ? (json['requiredInspections']).map((item) => ComplianceType.fromJson(item)).toList() : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	aiChatbotSessions: json['aiChatbotSessions'] != null ? createModels<AIChatbotSession>((json['aiChatbotSessions'] as List).cast<JsonMap>(), AIChatbotSession.fromJson) : null,
	aiFraudDetections: json['aiFraudDetections'] != null ? createModels<AIFraudDetection>((json['aiFraudDetections'] as List).cast<JsonMap>(), AIFraudDetection.fromJson) : null,
	aiImageAnalyses: json['aiImageAnalyses'] != null ? createModels<AIImageAnalysis>((json['aiImageAnalyses'] as List).cast<JsonMap>(), AIImageAnalysis.fromJson) : null,
	aiInvestmentAnalyses: json['aiInvestmentAnalyses'] != null ? createModels<AIInvestmentAnalysis>((json['aiInvestmentAnalyses'] as List).cast<JsonMap>(), AIInvestmentAnalysis.fromJson) : null,
	aiLeadScores: json['aiLeadScores'] != null ? createModels<AILeadScore>((json['aiLeadScores'] as List).cast<JsonMap>(), AILeadScore.fromJson) : null,
	aiLeadScoringModels: json['aiLeadScoringModels'] != null ? createModels<AILeadScoring>((json['aiLeadScoringModels'] as List).cast<JsonMap>(), AILeadScoring.fromJson) : null,
	aiMarketAnalyses: json['aiMarketAnalyses'] != null ? createModels<AIMarketAnalysis>((json['aiMarketAnalyses'] as List).cast<JsonMap>(), AIMarketAnalysis.fromJson) : null,
	aiModels: json['aiModels'] != null ? createModels<AIModel>((json['aiModels'] as List).cast<JsonMap>(), AIModel.fromJson) : null,
	aiModelDeployments: json['aiModelDeployments'] != null ? createModels<AIModelDeployment>((json['aiModelDeployments'] as List).cast<JsonMap>(), AIModelDeployment.fromJson) : null,
	aiPredictions: json['aiPredictions'] != null ? createModels<AIPrediction>((json['aiPredictions'] as List).cast<JsonMap>(), AIPrediction.fromJson) : null,
	aiPredictiveMaintenance: json['aiPredictiveMaintenance'] != null ? createModels<AIPredictiveMaintenance>((json['aiPredictiveMaintenance'] as List).cast<JsonMap>(), AIPredictiveMaintenance.fromJson) : null,
	aiPriceOptimizations: json['aiPriceOptimizations'] != null ? createModels<AIPriceOptimization>((json['aiPriceOptimizations'] as List).cast<JsonMap>(), AIPriceOptimization.fromJson) : null,
	aiPropertyDescriptions: json['aiPropertyDescriptions'] != null ? createModels<AIPropertyDescription>((json['aiPropertyDescriptions'] as List).cast<JsonMap>(), AIPropertyDescription.fromJson) : null,
	aiPropertyValuations: json['aiPropertyValuations'] != null ? createModels<AIPropertyValuation>((json['aiPropertyValuations'] as List).cast<JsonMap>(), AIPropertyValuation.fromJson) : null,
	aiRecommendations: json['aiRecommendations'] != null ? createModels<AIRecommendation>((json['aiRecommendations'] as List).cast<JsonMap>(), AIRecommendation.fromJson) : null,
	aiSentimentAnalyses: json['aiSentimentAnalyses'] != null ? createModels<AISentimentAnalysis>((json['aiSentimentAnalyses'] as List).cast<JsonMap>(), AISentimentAnalysis.fromJson) : null,
	aiTenantScreenings: json['aiTenantScreenings'] != null ? createModels<AITenantScreening>((json['aiTenantScreenings'] as List).cast<JsonMap>(), AITenantScreening.fromJson) : null,
	aiValuationModels: json['aiValuationModels'] != null ? createModels<AIValuationModel>((json['aiValuationModels'] as List).cast<JsonMap>(), AIValuationModel.fromJson) : null,
	integrations: json['integrations'] != null ? createModels<APIIntegration>((json['integrations'] as List).cast<JsonMap>(), APIIntegration.fromJson) : null,
	achievements: json['achievements'] != null ? createModels<Achievement>((json['achievements'] as List).cast<JsonMap>(), Achievement.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	agencyRelations: json['agencyRelations'] != null ? createModels<Agency>((json['agencyRelations'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	organizationAgencies: json['organizationAgencies'] != null ? createModels<Agency>((json['organizationAgencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	agentAssignments: json['agentAssignments'] != null ? createModels<AgentAssignment>((json['agentAssignments'] as List).cast<JsonMap>(), AgentAssignment.fromJson) : null,
	agentTeams: json['agentTeams'] != null ? createModels<AgentTeam>((json['agentTeams'] as List).cast<JsonMap>(), AgentTeam.fromJson) : null,
	amenities: json['amenities'] != null ? createModels<Amenity>((json['amenities'] as List).cast<JsonMap>(), Amenity.fromJson) : null,
	apiIntegrations: json['apiIntegrations'] != null ? createModels<ApiIntegration>((json['apiIntegrations'] as List).cast<JsonMap>(), ApiIntegration.fromJson) : null,
	apiKeys: json['apiKeys'] != null ? createModels<ApiKey>((json['apiKeys'] as List).cast<JsonMap>(), ApiKey.fromJson) : null,
	appointments: json['appointments'] != null ? createModels<Appointment>((json['appointments'] as List).cast<JsonMap>(), Appointment.fromJson) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	attorneyCases: json['attorneyCases'] != null ? createModels<AttorneyManagement>((json['attorneyCases'] as List).cast<JsonMap>(), AttorneyManagement.fromJson) : null,
	auditLogs: json['auditLogs'] != null ? createModels<AuditLog>((json['auditLogs'] as List).cast<JsonMap>(), AuditLog.fromJson) : null,
	automationExecutions: json['automationExecutions'] != null ? createModels<AutomationExecution>((json['automationExecutions'] as List).cast<JsonMap>(), AutomationExecution.fromJson) : null,
	automationRules: json['automationRules'] != null ? createModels<AutomationRule>((json['automationRules'] as List).cast<JsonMap>(), AutomationRule.fromJson) : null,
	bookings: json['bookings'] != null ? createModels<Booking>((json['bookings'] as List).cast<JsonMap>(), Booking.fromJson) : null,
	budgets: json['budgets'] != null ? createModels<Budget>((json['budgets'] as List).cast<JsonMap>(), Budget.fromJson) : null,
	calendarEvents: json['calendarEvents'] != null ? createModels<CalendarEvent>((json['calendarEvents'] as List).cast<JsonMap>(), CalendarEvent.fromJson) : null,
	commissions: json['commissions'] != null ? createModels<Commission>((json['commissions'] as List).cast<JsonMap>(), Commission.fromJson) : null,
	communicationTemplates: json['communicationTemplates'] != null ? createModels<CommunicationTemplate>((json['communicationTemplates'] as List).cast<JsonMap>(), CommunicationTemplate.fromJson) : null,
	contacts: json['contacts'] != null ? createModels<Contact>((json['contacts'] as List).cast<JsonMap>(), Contact.fromJson) : null,
	contracts: json['contracts'] != null ? createModels<Contract>((json['contracts'] as List).cast<JsonMap>(), Contract.fromJson) : null,
	contractVersions: json['contractVersions'] != null ? createModels<ContractVersion>((json['contractVersions'] as List).cast<JsonMap>(), ContractVersion.fromJson) : null,
	dashboardConfigurations: json['dashboardConfigurations'] != null ? createModels<DashboardConfiguration>((json['dashboardConfigurations'] as List).cast<JsonMap>(), DashboardConfiguration.fromJson) : null,
	dashboardWidgets: json['dashboardWidgets'] != null ? createModels<DashboardWidget>((json['dashboardWidgets'] as List).cast<JsonMap>(), DashboardWidget.fromJson) : null,
	deals: json['deals'] != null ? createModels<Deal>((json['deals'] as List).cast<JsonMap>(), Deal.fromJson) : null,
	depositProtections: json['depositProtections'] != null ? createModels<DepositProtection>((json['depositProtections'] as List).cast<JsonMap>(), DepositProtection.fromJson) : null,
	documents: json['documents'] != null ? createModels<Document>((json['documents'] as List).cast<JsonMap>(), Document.fromJson) : null,
	documentTemplates: json['documentTemplates'] != null ? createModels<DocumentTemplate>((json['documentTemplates'] as List).cast<JsonMap>(), DocumentTemplate.fromJson) : null,
	earnings: json['earnings'] != null ? createModels<Earning>((json['earnings'] as List).cast<JsonMap>(), Earning.fromJson) : null,
	events: json['events'] != null ? createModels<Event>((json['events'] as List).cast<JsonMap>(), Event.fromJson) : null,
	eventAttendees: json['eventAttendees'] != null ? createModels<EventAttendee>((json['eventAttendees'] as List).cast<JsonMap>(), EventAttendee.fromJson) : null,
	exchangeRates: json['exchangeRates'] != null ? createModels<ExchangeRate>((json['exchangeRates'] as List).cast<JsonMap>(), ExchangeRate.fromJson) : null,
	exportFiles: json['exportFiles'] != null ? createModels<ExportFile>((json['exportFiles'] as List).cast<JsonMap>(), ExportFile.fromJson) : null,
	exportJobs: json['exportJobs'] != null ? createModels<ExportJob>((json['exportJobs'] as List).cast<JsonMap>(), ExportJob.fromJson) : null,
	externalRentalListings: json['externalRentalListings'] != null ? createModels<ExternalRentalListing>((json['externalRentalListings'] as List).cast<JsonMap>(), ExternalRentalListing.fromJson) : null,
	facilities: json['facilities'] != null ? createModels<Facility>((json['facilities'] as List).cast<JsonMap>(), Facility.fromJson) : null,
	financialRecords: json['financialRecords'] != null ? createModels<FinancialRecord>((json['financialRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	floorPlans: json['floorPlans'] != null ? createModels<FloorPlan>((json['floorPlans'] as List).cast<JsonMap>(), FloorPlan.fromJson) : null,
	giftCards: json['giftCards'] != null ? createModels<GiftCard>((json['giftCards'] as List).cast<JsonMap>(), GiftCard.fromJson) : null,
	govtIntegrations: json['govtIntegrations'] != null ? createModels<GovernmentIntegration>((json['govtIntegrations'] as List).cast<JsonMap>(), GovernmentIntegration.fromJson) : null,
	healthChecks: json['healthChecks'] != null ? createModels<HealthCheck>((json['healthChecks'] as List).cast<JsonMap>(), HealthCheck.fromJson) : null,
	homeInformationPacks: json['homeInformationPacks'] != null ? createModels<HomeInformationPack>((json['homeInformationPacks'] as List).cast<JsonMap>(), HomeInformationPack.fromJson) : null,
	immigrationStatusChecks: json['immigrationStatusChecks'] != null ? createModels<ImmigrationStatusCheck>((json['immigrationStatusChecks'] as List).cast<JsonMap>(), ImmigrationStatusCheck.fromJson) : null,
	integrationLogs: json['integrationLogs'] != null ? createModels<IntegrationLog>((json['integrationLogs'] as List).cast<JsonMap>(), IntegrationLog.fromJson) : null,
	investorPortfolios: json['investorPortfolios'] != null ? createModels<InvestorPortfolio>((json['investorPortfolios'] as List).cast<JsonMap>(), InvestorPortfolio.fromJson) : null,
	keys: json['keys'] != null ? createModels<KeyManagement>((json['keys'] as List).cast<JsonMap>(), KeyManagement.fromJson) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	leadSources: json['leadSources'] != null ? createModels<LeadSource>((json['leadSources'] as List).cast<JsonMap>(), LeadSource.fromJson) : null,
	leases: json['leases'] != null ? createModels<Lease>((json['leases'] as List).cast<JsonMap>(), Lease.fromJson) : null,
	leaseRenewals: json['leaseRenewals'] != null ? createModels<LeaseRenewal>((json['leaseRenewals'] as List).cast<JsonMap>(), LeaseRenewal.fromJson) : null,
	ledgerEntries: json['ledgerEntries'] != null ? createModels<LedgerEntry>((json['ledgerEntries'] as List).cast<JsonMap>(), LedgerEntry.fromJson) : null,
	listings: json['listings'] != null ? createModels<Listing>((json['listings'] as List).cast<JsonMap>(), Listing.fromJson) : null,
	listingChannels: json['listingChannels'] != null ? createModels<ListingChannel>((json['listingChannels'] as List).cast<JsonMap>(), ListingChannel.fromJson) : null,
	listingStatusHistories: json['listingStatusHistories'] != null ? createModels<ListingStatusHistory>((json['listingStatusHistories'] as List).cast<JsonMap>(), ListingStatusHistory.fromJson) : null,
	listingTags: json['listingTags'] != null ? createModels<ListingTag>((json['listingTags'] as List).cast<JsonMap>(), ListingTag.fromJson) : null,
	locations: json['locations'] != null ? createModels<Location>((json['locations'] as List).cast<JsonMap>(), Location.fromJson) : null,
	loyaltyAccounts: json['loyaltyAccounts'] != null ? createModels<LoyaltyAccount>((json['loyaltyAccounts'] as List).cast<JsonMap>(), LoyaltyAccount.fromJson) : null,
	mlsConnections: json['mlsConnections'] != null ? createModels<MLSConnection>((json['mlsConnections'] as List).cast<JsonMap>(), MLSConnection.fromJson) : null,
	mlsexternalListings: json['mlsexternalListings'] != null ? createModels<MLSExternalListing>((json['mlsexternalListings'] as List).cast<JsonMap>(), MLSExternalListing.fromJson) : null,
	mlssyncJobs: json['mlssyncJobs'] != null ? createModels<MLSSyncJob>((json['mlssyncJobs'] as List).cast<JsonMap>(), MLSSyncJob.fromJson) : null,
	maintenanceBlocks: json['maintenanceBlocks'] != null ? createModels<MaintenanceBlock>((json['maintenanceBlocks'] as List).cast<JsonMap>(), MaintenanceBlock.fromJson) : null,
	workOrders: json['workOrders'] != null ? createModels<MaintenanceWorkOrder>((json['workOrders'] as List).cast<JsonMap>(), MaintenanceWorkOrder.fromJson) : null,
	mapLayers: json['mapLayers'] != null ? createModels<MapLayer>((json['mapLayers'] as List).cast<JsonMap>(), MapLayer.fromJson) : null,
	marketingCampaigns: json['marketingCampaigns'] != null ? createModels<MarketingCampaign>((json['marketingCampaigns'] as List).cast<JsonMap>(), MarketingCampaign.fromJson) : null,
	messages: json['messages'] != null ? createModels<Message>((json['messages'] as List).cast<JsonMap>(), Message.fromJson) : null,
	mlsDataMappings: json['mlsDataMappings'] != null ? createModels<MlsDataMapping>((json['mlsDataMappings'] as List).cast<JsonMap>(), MlsDataMapping.fromJson) : null,
	mlsListingEnhancements: json['mlsListingEnhancements'] != null ? createModels<MlsListingEnhancement>((json['mlsListingEnhancements'] as List).cast<JsonMap>(), MlsListingEnhancement.fromJson) : null,
	mobileDevices: json['mobileDevices'] != null ? createModels<MobileDevice>((json['mobileDevices'] as List).cast<JsonMap>(), MobileDevice.fromJson) : null,
	mortgageOffers: json['mortgageOffers'] != null ? createModels<MortgageOffer>((json['mortgageOffers'] as List).cast<JsonMap>(), MortgageOffer.fromJson) : null,
	mortgagePreApprovals: json['mortgagePreApprovals'] != null ? createModels<MortgagePreApproval>((json['mortgagePreApprovals'] as List).cast<JsonMap>(), MortgagePreApproval.fromJson) : null,
	neighborhoods: json['neighborhoods'] != null ? createModels<Neighborhood>((json['neighborhoods'] as List).cast<JsonMap>(), Neighborhood.fromJson) : null,
	notifications: json['notifications'] != null ? createModels<Notification>((json['notifications'] as List).cast<JsonMap>(), Notification.fromJson) : null,
	offlineSyncQueues: json['offlineSyncQueues'] != null ? createModels<OfflineSyncQueue>((json['offlineSyncQueues'] as List).cast<JsonMap>(), OfflineSyncQueue.fromJson) : null,
	orgSubscription: json['orgSubscription'] != null ? OrgSubscription.fromJson(json['orgSubscription'] as JsonMap) : null,
	payouts: json['payouts'] != null ? createModels<Payout>((json['payouts'] as List).cast<JsonMap>(), Payout.fromJson) : null,
	performanceAlerts: json['performanceAlerts'] != null ? createModels<PerformanceAlert>((json['performanceAlerts'] as List).cast<JsonMap>(), PerformanceAlert.fromJson) : null,
	predictiveModels: json['predictiveModels'] != null ? createModels<PredictiveModel>((json['predictiveModels'] as List).cast<JsonMap>(), PredictiveModel.fromJson) : null,
	projects: json['projects'] != null ? createModels<Project>((json['projects'] as List).cast<JsonMap>(), Project.fromJson) : null,
	properties: json['properties'] != null ? createModels<Property>((json['properties'] as List).cast<JsonMap>(), Property.fromJson) : null,
	propertyAmenities: json['propertyAmenities'] != null ? createModels<PropertyAmenity>((json['propertyAmenities'] as List).cast<JsonMap>(), PropertyAmenity.fromJson) : null,
	propertyCompliance: json['propertyCompliance'] != null ? createModels<PropertyCompliance>((json['propertyCompliance'] as List).cast<JsonMap>(), PropertyCompliance.fromJson) : null,
	propertyDisclosures: json['propertyDisclosures'] != null ? createModels<PropertyDisclosure>((json['propertyDisclosures'] as List).cast<JsonMap>(), PropertyDisclosure.fromJson) : null,
	propertyDocuments: json['propertyDocuments'] != null ? createModels<PropertyDocument>((json['propertyDocuments'] as List).cast<JsonMap>(), PropertyDocument.fromJson) : null,
	inventories: json['inventories'] != null ? createModels<PropertyInventory>((json['inventories'] as List).cast<JsonMap>(), PropertyInventory.fromJson) : null,
	propertyOffers: json['propertyOffers'] != null ? createModels<PropertyOffer>((json['propertyOffers'] as List).cast<JsonMap>(), PropertyOffer.fromJson) : null,
	propertyPhotos: json['propertyPhotos'] != null ? createModels<PropertyPhoto>((json['propertyPhotos'] as List).cast<JsonMap>(), PropertyPhoto.fromJson) : null,
	propertyViewings: json['propertyViewings'] != null ? createModels<PropertyViewing>((json['propertyViewings'] as List).cast<JsonMap>(), PropertyViewing.fromJson) : null,
	queueConfigurations: json['queueConfigurations'] != null ? createModels<QueueConfiguration>((json['queueConfigurations'] as List).cast<JsonMap>(), QueueConfiguration.fromJson) : null,
	queueMessages: json['queueMessages'] != null ? createModels<QueueMessage>((json['queueMessages'] as List).cast<JsonMap>(), QueueMessage.fromJson) : null,
	quotes: json['quotes'] != null ? createModels<Quote>((json['quotes'] as List).cast<JsonMap>(), Quote.fromJson) : null,
	recommendationResults: json['recommendationResults'] != null ? createModels<RecommendationResult>((json['recommendationResults'] as List).cast<JsonMap>(), RecommendationResult.fromJson) : null,
	referrals: json['referrals'] != null ? createModels<Referral>((json['referrals'] as List).cast<JsonMap>(), Referral.fromJson) : null,
	rentArrears: json['rentArrears'] != null ? createModels<RentArrears>((json['rentArrears'] as List).cast<JsonMap>(), RentArrears.fromJson) : null,
	rentSchedules: json['rentSchedules'] != null ? createModels<RentSchedule>((json['rentSchedules'] as List).cast<JsonMap>(), RentSchedule.fromJson) : null,
	rentalSyncJobs: json['rentalSyncJobs'] != null ? createModels<RentalSyncJob>((json['rentalSyncJobs'] as List).cast<JsonMap>(), RentalSyncJob.fromJson) : null,
	reports: json['reports'] != null ? createModels<Report>((json['reports'] as List).cast<JsonMap>(), Report.fromJson) : null,
	reportExecutions: json['reportExecutions'] != null ? createModels<ReportExecution>((json['reportExecutions'] as List).cast<JsonMap>(), ReportExecution.fromJson) : null,
	reservations: json['reservations'] != null ? createModels<Reservation>((json['reservations'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	reviews: json['reviews'] != null ? createModels<Review>((json['reviews'] as List).cast<JsonMap>(), Review.fromJson) : null,
	rightToRentChecks: json['rightToRentChecks'] != null ? createModels<RightToRentCheck>((json['rightToRentChecks'] as List).cast<JsonMap>(), RightToRentCheck.fromJson) : null,
	roles: json['roles'] != null ? createModels<Role>((json['roles'] as List).cast<JsonMap>(), Role.fromJson) : null,
	routes: json['routes'] != null ? createModels<Route>((json['routes'] as List).cast<JsonMap>(), Route.fromJson) : null,
	securityDepositProtections: json['securityDepositProtections'] != null ? createModels<SecurityDepositProtection>((json['securityDepositProtections'] as List).cast<JsonMap>(), SecurityDepositProtection.fromJson) : null,
	signatureRequests: json['signatureRequests'] != null ? createModels<SignatureRequest>((json['signatureRequests'] as List).cast<JsonMap>(), SignatureRequest.fromJson) : null,
	signatureSigners: json['signatureSigners'] != null ? createModels<SignatureSigner>((json['signatureSigners'] as List).cast<JsonMap>(), SignatureSigner.fromJson) : null,
	solicitorManagements: json['solicitorManagements'] != null ? createModels<SolicitorManagement>((json['solicitorManagements'] as List).cast<JsonMap>(), SolicitorManagement.fromJson) : null,
	subscriptions: json['subscriptions'] != null ? createModels<Subscription>((json['subscriptions'] as List).cast<JsonMap>(), Subscription.fromJson) : null,
	systemMetrics: json['systemMetrics'] != null ? createModels<SystemMetrics>((json['systemMetrics'] as List).cast<JsonMap>(), SystemMetrics.fromJson) : null,
	tags: json['tags'] != null ? createModels<Tag>((json['tags'] as List).cast<JsonMap>(), Tag.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	tax1099Forms: json['tax1099Forms'] != null ? createModels<Tax1099Form>((json['tax1099Forms'] as List).cast<JsonMap>(), Tax1099Form.fromJson) : null,
	taxDepreciations: json['taxDepreciations'] != null ? createModels<TaxDepreciation>((json['taxDepreciations'] as List).cast<JsonMap>(), TaxDepreciation.fromJson) : null,
	taxRecords: json['taxRecords'] != null ? createModels<TaxRecord>((json['taxRecords'] as List).cast<JsonMap>(), TaxRecord.fromJson) : null,
	tenantApplications: json['tenantApplications'] != null ? createModels<TenantApplication>((json['tenantApplications'] as List).cast<JsonMap>(), TenantApplication.fromJson) : null,
	userActivityLogs: json['userActivityLogs'] != null ? createModels<UserActivityLog>((json['userActivityLogs'] as List).cast<JsonMap>(), UserActivityLog.fromJson) : null,
	userPreferences: json['userPreferences'] != null ? createModels<UserPreference>((json['userPreferences'] as List).cast<JsonMap>(), UserPreference.fromJson) : null,
	vacationRentals: json['vacationRentals'] != null ? createModels<VacationRental>((json['vacationRentals'] as List).cast<JsonMap>(), VacationRental.fromJson) : null,
	vendors: json['vendors'] != null ? createModels<VendorProfile>((json['vendors'] as List).cast<JsonMap>(), VendorProfile.fromJson) : null,
	virtualTours: json['virtualTours'] != null ? createModels<VirtualTour>((json['virtualTours'] as List).cast<JsonMap>(), VirtualTour.fromJson) : null,
	webhooks: json['webhooks'] != null ? createModels<Webhook>((json['webhooks'] as List).cast<JsonMap>(), Webhook.fromJson) : null,
	webhookDeliveries: json['webhookDeliveries'] != null ? createModels<WebhookDelivery>((json['webhookDeliveries'] as List).cast<JsonMap>(), WebhookDelivery.fromJson) : null,
	escrowAccounts: json['escrowAccounts'] != null ? createModels<EscrowAccount>((json['escrowAccounts'] as List).cast<JsonMap>(), EscrowAccount.fromJson) : null,
	escrowReleases: json['escrowReleases'] != null ? createModels<EscrowRelease>((json['escrowReleases'] as List).cast<JsonMap>(), EscrowRelease.fromJson) : null,
	escrowDisputes: json['escrowDisputes'] != null ? createModels<EscrowDispute>((json['escrowDisputes'] as List).cast<JsonMap>(), EscrowDispute.fromJson) : null,
	paymentNegotiations: json['paymentNegotiations'] != null ? createModels<PaymentNegotiation>((json['paymentNegotiations'] as List).cast<JsonMap>(), PaymentNegotiation.fromJson) : null,
	paymentInstallments: json['paymentInstallments'] != null ? createModels<PaymentInstallment>((json['paymentInstallments'] as List).cast<JsonMap>(), PaymentInstallment.fromJson) : null,
	videoContents: json['videoContents'] != null ? createModels<VideoContent>((json['videoContents'] as List).cast<JsonMap>(), VideoContent.fromJson) : null,
	brandAmbassadors: json['brandAmbassadors'] != null ? createModels<BrandAmbassador>((json['brandAmbassadors'] as List).cast<JsonMap>(), BrandAmbassador.fromJson) : null,
	ambassadorCampaigns: json['ambassadorCampaigns'] != null ? createModels<AmbassadorCampaign>((json['ambassadorCampaigns'] as List).cast<JsonMap>(), AmbassadorCampaign.fromJson) : null,
	socialImpactCounters: json['socialImpactCounters'] != null ? createModels<SocialImpactCounter>((json['socialImpactCounters'] as List).cast<JsonMap>(), SocialImpactCounter.fromJson) : null,
	socialImpactRecords: json['socialImpactRecords'] != null ? createModels<SocialImpactRecord>((json['socialImpactRecords'] as List).cast<JsonMap>(), SocialImpactRecord.fromJson) : null,
	negotiationOffers: json['negotiationOffers'] != null ? createModels<NegotiationOffer>((json['negotiationOffers'] as List).cast<JsonMap>(), NegotiationOffer.fromJson) : null,
	ambassadorContracts: json['ambassadorContracts'] != null ? createModels<AmbassadorContract>((json['ambassadorContracts'] as List).cast<JsonMap>(), AmbassadorContract.fromJson) : null,
	escrowStatusHistories: json['escrowStatusHistories'] != null ? createModels<EscrowStatusHistory>((json['escrowStatusHistories'] as List).cast<JsonMap>(), EscrowStatusHistory.fromJson) : null,
	aiChatMessages: json['aiChatMessages'] != null ? createModels<AIChatMessage>((json['aiChatMessages'] as List).cast<JsonMap>(), AIChatMessage.fromJson) : null,
	aiChatHandoffs: json['aiChatHandoffs'] != null ? createModels<AIChatHandoff>((json['aiChatHandoffs'] as List).cast<JsonMap>(), AIChatHandoff.fromJson) : null,
	analyses: json['analyses'] != null ? createModels<DocumentAnalysis>((json['analyses'] as List).cast<JsonMap>(), DocumentAnalysis.fromJson) : null,
	analysisJobs: json['analysisJobs'] != null ? createModels<AnalysisJob>((json['analysisJobs'] as List).cast<JsonMap>(), AnalysisJob.fromJson) : null,
	$requiredInspectionsCount: json['_count']?['requiredInspections'] as int?,
	$aiChatbotSessionsCount: json['_count']?['aiChatbotSessions'] as int?,
	$aiFraudDetectionsCount: json['_count']?['aiFraudDetections'] as int?,
	$aiImageAnalysesCount: json['_count']?['aiImageAnalyses'] as int?,
	$aiInvestmentAnalysesCount: json['_count']?['aiInvestmentAnalyses'] as int?,
	$aiLeadScoresCount: json['_count']?['aiLeadScores'] as int?,
	$aiLeadScoringModelsCount: json['_count']?['aiLeadScoringModels'] as int?,
	$aiMarketAnalysesCount: json['_count']?['aiMarketAnalyses'] as int?,
	$aiModelsCount: json['_count']?['aiModels'] as int?,
	$aiModelDeploymentsCount: json['_count']?['aiModelDeployments'] as int?,
	$aiPredictionsCount: json['_count']?['aiPredictions'] as int?,
	$aiPredictiveMaintenanceCount: json['_count']?['aiPredictiveMaintenance'] as int?,
	$aiPriceOptimizationsCount: json['_count']?['aiPriceOptimizations'] as int?,
	$aiPropertyDescriptionsCount: json['_count']?['aiPropertyDescriptions'] as int?,
	$aiPropertyValuationsCount: json['_count']?['aiPropertyValuations'] as int?,
	$aiRecommendationsCount: json['_count']?['aiRecommendations'] as int?,
	$aiSentimentAnalysesCount: json['_count']?['aiSentimentAnalyses'] as int?,
	$aiTenantScreeningsCount: json['_count']?['aiTenantScreenings'] as int?,
	$aiValuationModelsCount: json['_count']?['aiValuationModels'] as int?,
	$integrationsCount: json['_count']?['integrations'] as int?,
	$achievementsCount: json['_count']?['achievements'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$agencyRelationsCount: json['_count']?['agencyRelations'] as int?,
	$organizationAgenciesCount: json['_count']?['organizationAgencies'] as int?,
	$agentAssignmentsCount: json['_count']?['agentAssignments'] as int?,
	$agentTeamsCount: json['_count']?['agentTeams'] as int?,
	$amenitiesCount: json['_count']?['amenities'] as int?,
	$apiIntegrationsCount: json['_count']?['apiIntegrations'] as int?,
	$apiKeysCount: json['_count']?['apiKeys'] as int?,
	$appointmentsCount: json['_count']?['appointments'] as int?,
	$attachmentsCount: json['_count']?['attachments'] as int?,
	$attorneyCasesCount: json['_count']?['attorneyCases'] as int?,
	$auditLogsCount: json['_count']?['auditLogs'] as int?,
	$automationExecutionsCount: json['_count']?['automationExecutions'] as int?,
	$automationRulesCount: json['_count']?['automationRules'] as int?,
	$bookingsCount: json['_count']?['bookings'] as int?,
	$budgetsCount: json['_count']?['budgets'] as int?,
	$calendarEventsCount: json['_count']?['calendarEvents'] as int?,
	$commissionsCount: json['_count']?['commissions'] as int?,
	$communicationTemplatesCount: json['_count']?['communicationTemplates'] as int?,
	$contactsCount: json['_count']?['contacts'] as int?,
	$contractsCount: json['_count']?['contracts'] as int?,
	$contractVersionsCount: json['_count']?['contractVersions'] as int?,
	$dashboardConfigurationsCount: json['_count']?['dashboardConfigurations'] as int?,
	$dashboardWidgetsCount: json['_count']?['dashboardWidgets'] as int?,
	$dealsCount: json['_count']?['deals'] as int?,
	$depositProtectionsCount: json['_count']?['depositProtections'] as int?,
	$documentsCount: json['_count']?['documents'] as int?,
	$documentTemplatesCount: json['_count']?['documentTemplates'] as int?,
	$earningsCount: json['_count']?['earnings'] as int?,
	$eventsCount: json['_count']?['events'] as int?,
	$eventAttendeesCount: json['_count']?['eventAttendees'] as int?,
	$exchangeRatesCount: json['_count']?['exchangeRates'] as int?,
	$exportFilesCount: json['_count']?['exportFiles'] as int?,
	$exportJobsCount: json['_count']?['exportJobs'] as int?,
	$externalRentalListingsCount: json['_count']?['externalRentalListings'] as int?,
	$facilitiesCount: json['_count']?['facilities'] as int?,
	$financialRecordsCount: json['_count']?['financialRecords'] as int?,
	$floorPlansCount: json['_count']?['floorPlans'] as int?,
	$giftCardsCount: json['_count']?['giftCards'] as int?,
	$govtIntegrationsCount: json['_count']?['govtIntegrations'] as int?,
	$healthChecksCount: json['_count']?['healthChecks'] as int?,
	$homeInformationPacksCount: json['_count']?['homeInformationPacks'] as int?,
	$immigrationStatusChecksCount: json['_count']?['immigrationStatusChecks'] as int?,
	$integrationLogsCount: json['_count']?['integrationLogs'] as int?,
	$investorPortfoliosCount: json['_count']?['investorPortfolios'] as int?,
	$keysCount: json['_count']?['keys'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
	$leadSourcesCount: json['_count']?['leadSources'] as int?,
	$leasesCount: json['_count']?['leases'] as int?,
	$leaseRenewalsCount: json['_count']?['leaseRenewals'] as int?,
	$ledgerEntriesCount: json['_count']?['ledgerEntries'] as int?,
	$listingsCount: json['_count']?['listings'] as int?,
	$listingChannelsCount: json['_count']?['listingChannels'] as int?,
	$listingStatusHistoriesCount: json['_count']?['listingStatusHistories'] as int?,
	$listingTagsCount: json['_count']?['listingTags'] as int?,
	$locationsCount: json['_count']?['locations'] as int?,
	$loyaltyAccountsCount: json['_count']?['loyaltyAccounts'] as int?,
	$mlsConnectionsCount: json['_count']?['mlsConnections'] as int?,
	$mlsexternalListingsCount: json['_count']?['mlsexternalListings'] as int?,
	$mlssyncJobsCount: json['_count']?['mlssyncJobs'] as int?,
	$maintenanceBlocksCount: json['_count']?['maintenanceBlocks'] as int?,
	$workOrdersCount: json['_count']?['workOrders'] as int?,
	$mapLayersCount: json['_count']?['mapLayers'] as int?,
	$marketingCampaignsCount: json['_count']?['marketingCampaigns'] as int?,
	$messagesCount: json['_count']?['messages'] as int?,
	$mlsDataMappingsCount: json['_count']?['mlsDataMappings'] as int?,
	$mlsListingEnhancementsCount: json['_count']?['mlsListingEnhancements'] as int?,
	$mobileDevicesCount: json['_count']?['mobileDevices'] as int?,
	$mortgageOffersCount: json['_count']?['mortgageOffers'] as int?,
	$mortgagePreApprovalsCount: json['_count']?['mortgagePreApprovals'] as int?,
	$neighborhoodsCount: json['_count']?['neighborhoods'] as int?,
	$notificationsCount: json['_count']?['notifications'] as int?,
	$offlineSyncQueuesCount: json['_count']?['offlineSyncQueues'] as int?,
	$payoutsCount: json['_count']?['payouts'] as int?,
	$performanceAlertsCount: json['_count']?['performanceAlerts'] as int?,
	$predictiveModelsCount: json['_count']?['predictiveModels'] as int?,
	$projectsCount: json['_count']?['projects'] as int?,
	$propertiesCount: json['_count']?['properties'] as int?,
	$propertyAmenitiesCount: json['_count']?['propertyAmenities'] as int?,
	$propertyComplianceCount: json['_count']?['propertyCompliance'] as int?,
	$propertyDisclosuresCount: json['_count']?['propertyDisclosures'] as int?,
	$propertyDocumentsCount: json['_count']?['propertyDocuments'] as int?,
	$inventoriesCount: json['_count']?['inventories'] as int?,
	$propertyOffersCount: json['_count']?['propertyOffers'] as int?,
	$propertyPhotosCount: json['_count']?['propertyPhotos'] as int?,
	$propertyViewingsCount: json['_count']?['propertyViewings'] as int?,
	$queueConfigurationsCount: json['_count']?['queueConfigurations'] as int?,
	$queueMessagesCount: json['_count']?['queueMessages'] as int?,
	$quotesCount: json['_count']?['quotes'] as int?,
	$recommendationResultsCount: json['_count']?['recommendationResults'] as int?,
	$referralsCount: json['_count']?['referrals'] as int?,
	$rentArrearsCount: json['_count']?['rentArrears'] as int?,
	$rentSchedulesCount: json['_count']?['rentSchedules'] as int?,
	$rentalSyncJobsCount: json['_count']?['rentalSyncJobs'] as int?,
	$reportsCount: json['_count']?['reports'] as int?,
	$reportExecutionsCount: json['_count']?['reportExecutions'] as int?,
	$reservationsCount: json['_count']?['reservations'] as int?,
	$reviewsCount: json['_count']?['reviews'] as int?,
	$rightToRentChecksCount: json['_count']?['rightToRentChecks'] as int?,
	$rolesCount: json['_count']?['roles'] as int?,
	$routesCount: json['_count']?['routes'] as int?,
	$securityDepositProtectionsCount: json['_count']?['securityDepositProtections'] as int?,
	$signatureRequestsCount: json['_count']?['signatureRequests'] as int?,
	$signatureSignersCount: json['_count']?['signatureSigners'] as int?,
	$solicitorManagementsCount: json['_count']?['solicitorManagements'] as int?,
	$subscriptionsCount: json['_count']?['subscriptions'] as int?,
	$systemMetricsCount: json['_count']?['systemMetrics'] as int?,
	$tagsCount: json['_count']?['tags'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$tax1099FormsCount: json['_count']?['tax1099Forms'] as int?,
	$taxDepreciationsCount: json['_count']?['taxDepreciations'] as int?,
	$taxRecordsCount: json['_count']?['taxRecords'] as int?,
	$tenantApplicationsCount: json['_count']?['tenantApplications'] as int?,
	$userActivityLogsCount: json['_count']?['userActivityLogs'] as int?,
	$userPreferencesCount: json['_count']?['userPreferences'] as int?,
	$vacationRentalsCount: json['_count']?['vacationRentals'] as int?,
	$vendorsCount: json['_count']?['vendors'] as int?,
	$virtualToursCount: json['_count']?['virtualTours'] as int?,
	$webhooksCount: json['_count']?['webhooks'] as int?,
	$webhookDeliveriesCount: json['_count']?['webhookDeliveries'] as int?,
	$escrowAccountsCount: json['_count']?['escrowAccounts'] as int?,
	$escrowReleasesCount: json['_count']?['escrowReleases'] as int?,
	$escrowDisputesCount: json['_count']?['escrowDisputes'] as int?,
	$paymentNegotiationsCount: json['_count']?['paymentNegotiations'] as int?,
	$paymentInstallmentsCount: json['_count']?['paymentInstallments'] as int?,
	$videoContentsCount: json['_count']?['videoContents'] as int?,
	$brandAmbassadorsCount: json['_count']?['brandAmbassadors'] as int?,
	$ambassadorCampaignsCount: json['_count']?['ambassadorCampaigns'] as int?,
	$socialImpactCountersCount: json['_count']?['socialImpactCounters'] as int?,
	$socialImpactRecordsCount: json['_count']?['socialImpactRecords'] as int?,
	$negotiationOffersCount: json['_count']?['negotiationOffers'] as int?,
	$ambassadorContractsCount: json['_count']?['ambassadorContracts'] as int?,
	$escrowStatusHistoriesCount: json['_count']?['escrowStatusHistories'] as int?,
	$aiChatMessagesCount: json['_count']?['aiChatMessages'] as int?,
	$aiChatHandoffsCount: json['_count']?['aiChatHandoffs'] as int?,
	$analysesCount: json['_count']?['analyses'] as int?,
	$analysisJobsCount: json['_count']?['analysisJobs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Organization copyWith({
        Value<String?>? id,
		Value<String?>? name,
		Value<OrgType?>? type,
		Value<Region?>? region,
		Value<String?>? defaultCurrency,
		Value<String?>? defaultLocale,
		Value<String?>? legalName,
		Value<String?>? taxId,
		Value<String?>? address,
		Value<String?>? contactEmail,
		Value<ManagementFeeType?>? managementFeeType,
		Value<double?>? managementFeeRate,
		Value<double?>? managementFeeAmount,
		Value<ManagementFeeScope?>? managementFeeScope,
		Value<bool?>? taxReportingEnabled,
		Value<bool?>? complianceTracking,
		Value<List<ComplianceType>?>? requiredInspections,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<AIChatbotSession>?>? aiChatbotSessions,
		Value<List<AIFraudDetection>?>? aiFraudDetections,
		Value<List<AIImageAnalysis>?>? aiImageAnalyses,
		Value<List<AIInvestmentAnalysis>?>? aiInvestmentAnalyses,
		Value<List<AILeadScore>?>? aiLeadScores,
		Value<List<AILeadScoring>?>? aiLeadScoringModels,
		Value<List<AIMarketAnalysis>?>? aiMarketAnalyses,
		Value<List<AIModel>?>? aiModels,
		Value<List<AIModelDeployment>?>? aiModelDeployments,
		Value<List<AIPrediction>?>? aiPredictions,
		Value<List<AIPredictiveMaintenance>?>? aiPredictiveMaintenance,
		Value<List<AIPriceOptimization>?>? aiPriceOptimizations,
		Value<List<AIPropertyDescription>?>? aiPropertyDescriptions,
		Value<List<AIPropertyValuation>?>? aiPropertyValuations,
		Value<List<AIRecommendation>?>? aiRecommendations,
		Value<List<AISentimentAnalysis>?>? aiSentimentAnalyses,
		Value<List<AITenantScreening>?>? aiTenantScreenings,
		Value<List<AIValuationModel>?>? aiValuationModels,
		Value<List<APIIntegration>?>? integrations,
		Value<List<Achievement>?>? achievements,
		Value<List<Agency>?>? agencies,
		Value<List<Agency>?>? agencyRelations,
		Value<List<Agency>?>? organizationAgencies,
		Value<List<AgentAssignment>?>? agentAssignments,
		Value<List<AgentTeam>?>? agentTeams,
		Value<List<Amenity>?>? amenities,
		Value<List<ApiIntegration>?>? apiIntegrations,
		Value<List<ApiKey>?>? apiKeys,
		Value<List<Appointment>?>? appointments,
		Value<List<Attachment>?>? attachments,
		Value<List<AttorneyManagement>?>? attorneyCases,
		Value<List<AuditLog>?>? auditLogs,
		Value<List<AutomationExecution>?>? automationExecutions,
		Value<List<AutomationRule>?>? automationRules,
		Value<List<Booking>?>? bookings,
		Value<List<Budget>?>? budgets,
		Value<List<CalendarEvent>?>? calendarEvents,
		Value<List<Commission>?>? commissions,
		Value<List<CommunicationTemplate>?>? communicationTemplates,
		Value<List<Contact>?>? contacts,
		Value<List<Contract>?>? contracts,
		Value<List<ContractVersion>?>? contractVersions,
		Value<List<DashboardConfiguration>?>? dashboardConfigurations,
		Value<List<DashboardWidget>?>? dashboardWidgets,
		Value<List<Deal>?>? deals,
		Value<List<DepositProtection>?>? depositProtections,
		Value<List<Document>?>? documents,
		Value<List<DocumentTemplate>?>? documentTemplates,
		Value<List<Earning>?>? earnings,
		Value<List<Event>?>? events,
		Value<List<EventAttendee>?>? eventAttendees,
		Value<List<ExchangeRate>?>? exchangeRates,
		Value<List<ExportFile>?>? exportFiles,
		Value<List<ExportJob>?>? exportJobs,
		Value<List<ExternalRentalListing>?>? externalRentalListings,
		Value<List<Facility>?>? facilities,
		Value<List<FinancialRecord>?>? financialRecords,
		Value<List<FloorPlan>?>? floorPlans,
		Value<List<GiftCard>?>? giftCards,
		Value<List<GovernmentIntegration>?>? govtIntegrations,
		Value<List<HealthCheck>?>? healthChecks,
		Value<List<HomeInformationPack>?>? homeInformationPacks,
		Value<List<ImmigrationStatusCheck>?>? immigrationStatusChecks,
		Value<List<IntegrationLog>?>? integrationLogs,
		Value<List<InvestorPortfolio>?>? investorPortfolios,
		Value<List<KeyManagement>?>? keys,
		Value<List<Lead>?>? leads,
		Value<List<LeadSource>?>? leadSources,
		Value<List<Lease>?>? leases,
		Value<List<LeaseRenewal>?>? leaseRenewals,
		Value<List<LedgerEntry>?>? ledgerEntries,
		Value<List<Listing>?>? listings,
		Value<List<ListingChannel>?>? listingChannels,
		Value<List<ListingStatusHistory>?>? listingStatusHistories,
		Value<List<ListingTag>?>? listingTags,
		Value<List<Location>?>? locations,
		Value<List<LoyaltyAccount>?>? loyaltyAccounts,
		Value<List<MLSConnection>?>? mlsConnections,
		Value<List<MLSExternalListing>?>? mlsexternalListings,
		Value<List<MLSSyncJob>?>? mlssyncJobs,
		Value<List<MaintenanceBlock>?>? maintenanceBlocks,
		Value<List<MaintenanceWorkOrder>?>? workOrders,
		Value<List<MapLayer>?>? mapLayers,
		Value<List<MarketingCampaign>?>? marketingCampaigns,
		Value<List<Message>?>? messages,
		Value<List<MlsDataMapping>?>? mlsDataMappings,
		Value<List<MlsListingEnhancement>?>? mlsListingEnhancements,
		Value<List<MobileDevice>?>? mobileDevices,
		Value<List<MortgageOffer>?>? mortgageOffers,
		Value<List<MortgagePreApproval>?>? mortgagePreApprovals,
		Value<List<Neighborhood>?>? neighborhoods,
		Value<List<Notification>?>? notifications,
		Value<List<OfflineSyncQueue>?>? offlineSyncQueues,
		Value<OrgSubscription?>? orgSubscription,
		Value<List<Payout>?>? payouts,
		Value<List<PerformanceAlert>?>? performanceAlerts,
		Value<List<PredictiveModel>?>? predictiveModels,
		Value<List<Project>?>? projects,
		Value<List<Property>?>? properties,
		Value<List<PropertyAmenity>?>? propertyAmenities,
		Value<List<PropertyCompliance>?>? propertyCompliance,
		Value<List<PropertyDisclosure>?>? propertyDisclosures,
		Value<List<PropertyDocument>?>? propertyDocuments,
		Value<List<PropertyInventory>?>? inventories,
		Value<List<PropertyOffer>?>? propertyOffers,
		Value<List<PropertyPhoto>?>? propertyPhotos,
		Value<List<PropertyViewing>?>? propertyViewings,
		Value<List<QueueConfiguration>?>? queueConfigurations,
		Value<List<QueueMessage>?>? queueMessages,
		Value<List<Quote>?>? quotes,
		Value<List<RecommendationResult>?>? recommendationResults,
		Value<List<Referral>?>? referrals,
		Value<List<RentArrears>?>? rentArrears,
		Value<List<RentSchedule>?>? rentSchedules,
		Value<List<RentalSyncJob>?>? rentalSyncJobs,
		Value<List<Report>?>? reports,
		Value<List<ReportExecution>?>? reportExecutions,
		Value<List<Reservation>?>? reservations,
		Value<List<Review>?>? reviews,
		Value<List<RightToRentCheck>?>? rightToRentChecks,
		Value<List<Role>?>? roles,
		Value<List<Route>?>? routes,
		Value<List<SecurityDepositProtection>?>? securityDepositProtections,
		Value<List<SignatureRequest>?>? signatureRequests,
		Value<List<SignatureSigner>?>? signatureSigners,
		Value<List<SolicitorManagement>?>? solicitorManagements,
		Value<List<Subscription>?>? subscriptions,
		Value<List<SystemMetrics>?>? systemMetrics,
		Value<List<Tag>?>? tags,
		Value<List<Task>?>? tasks,
		Value<List<Tax1099Form>?>? tax1099Forms,
		Value<List<TaxDepreciation>?>? taxDepreciations,
		Value<List<TaxRecord>?>? taxRecords,
		Value<List<TenantApplication>?>? tenantApplications,
		Value<List<UserActivityLog>?>? userActivityLogs,
		Value<List<UserPreference>?>? userPreferences,
		Value<List<VacationRental>?>? vacationRentals,
		Value<List<VendorProfile>?>? vendors,
		Value<List<VirtualTour>?>? virtualTours,
		Value<List<Webhook>?>? webhooks,
		Value<List<WebhookDelivery>?>? webhookDeliveries,
		Value<List<EscrowAccount>?>? escrowAccounts,
		Value<List<EscrowRelease>?>? escrowReleases,
		Value<List<EscrowDispute>?>? escrowDisputes,
		Value<List<PaymentNegotiation>?>? paymentNegotiations,
		Value<List<PaymentInstallment>?>? paymentInstallments,
		Value<List<VideoContent>?>? videoContents,
		Value<List<BrandAmbassador>?>? brandAmbassadors,
		Value<List<AmbassadorCampaign>?>? ambassadorCampaigns,
		Value<List<SocialImpactCounter>?>? socialImpactCounters,
		Value<List<SocialImpactRecord>?>? socialImpactRecords,
		Value<List<NegotiationOffer>?>? negotiationOffers,
		Value<List<AmbassadorContract>?>? ambassadorContracts,
		Value<List<EscrowStatusHistory>?>? escrowStatusHistories,
		Value<List<AIChatMessage>?>? aiChatMessages,
		Value<List<AIChatHandoff>?>? aiChatHandoffs,
		Value<List<DocumentAnalysis>?>? analyses,
		Value<List<AnalysisJob>?>? analysisJobs,
		int? $requiredInspectionsCount,
		int? $aiChatbotSessionsCount,
		int? $aiFraudDetectionsCount,
		int? $aiImageAnalysesCount,
		int? $aiInvestmentAnalysesCount,
		int? $aiLeadScoresCount,
		int? $aiLeadScoringModelsCount,
		int? $aiMarketAnalysesCount,
		int? $aiModelsCount,
		int? $aiModelDeploymentsCount,
		int? $aiPredictionsCount,
		int? $aiPredictiveMaintenanceCount,
		int? $aiPriceOptimizationsCount,
		int? $aiPropertyDescriptionsCount,
		int? $aiPropertyValuationsCount,
		int? $aiRecommendationsCount,
		int? $aiSentimentAnalysesCount,
		int? $aiTenantScreeningsCount,
		int? $aiValuationModelsCount,
		int? $integrationsCount,
		int? $achievementsCount,
		int? $agenciesCount,
		int? $agencyRelationsCount,
		int? $organizationAgenciesCount,
		int? $agentAssignmentsCount,
		int? $agentTeamsCount,
		int? $amenitiesCount,
		int? $apiIntegrationsCount,
		int? $apiKeysCount,
		int? $appointmentsCount,
		int? $attachmentsCount,
		int? $attorneyCasesCount,
		int? $auditLogsCount,
		int? $automationExecutionsCount,
		int? $automationRulesCount,
		int? $bookingsCount,
		int? $budgetsCount,
		int? $calendarEventsCount,
		int? $commissionsCount,
		int? $communicationTemplatesCount,
		int? $contactsCount,
		int? $contractsCount,
		int? $contractVersionsCount,
		int? $dashboardConfigurationsCount,
		int? $dashboardWidgetsCount,
		int? $dealsCount,
		int? $depositProtectionsCount,
		int? $documentsCount,
		int? $documentTemplatesCount,
		int? $earningsCount,
		int? $eventsCount,
		int? $eventAttendeesCount,
		int? $exchangeRatesCount,
		int? $exportFilesCount,
		int? $exportJobsCount,
		int? $externalRentalListingsCount,
		int? $facilitiesCount,
		int? $financialRecordsCount,
		int? $floorPlansCount,
		int? $giftCardsCount,
		int? $govtIntegrationsCount,
		int? $healthChecksCount,
		int? $homeInformationPacksCount,
		int? $immigrationStatusChecksCount,
		int? $integrationLogsCount,
		int? $investorPortfoliosCount,
		int? $keysCount,
		int? $leadsCount,
		int? $leadSourcesCount,
		int? $leasesCount,
		int? $leaseRenewalsCount,
		int? $ledgerEntriesCount,
		int? $listingsCount,
		int? $listingChannelsCount,
		int? $listingStatusHistoriesCount,
		int? $listingTagsCount,
		int? $locationsCount,
		int? $loyaltyAccountsCount,
		int? $mlsConnectionsCount,
		int? $mlsexternalListingsCount,
		int? $mlssyncJobsCount,
		int? $maintenanceBlocksCount,
		int? $workOrdersCount,
		int? $mapLayersCount,
		int? $marketingCampaignsCount,
		int? $messagesCount,
		int? $mlsDataMappingsCount,
		int? $mlsListingEnhancementsCount,
		int? $mobileDevicesCount,
		int? $mortgageOffersCount,
		int? $mortgagePreApprovalsCount,
		int? $neighborhoodsCount,
		int? $notificationsCount,
		int? $offlineSyncQueuesCount,
		int? $payoutsCount,
		int? $performanceAlertsCount,
		int? $predictiveModelsCount,
		int? $projectsCount,
		int? $propertiesCount,
		int? $propertyAmenitiesCount,
		int? $propertyComplianceCount,
		int? $propertyDisclosuresCount,
		int? $propertyDocumentsCount,
		int? $inventoriesCount,
		int? $propertyOffersCount,
		int? $propertyPhotosCount,
		int? $propertyViewingsCount,
		int? $queueConfigurationsCount,
		int? $queueMessagesCount,
		int? $quotesCount,
		int? $recommendationResultsCount,
		int? $referralsCount,
		int? $rentArrearsCount,
		int? $rentSchedulesCount,
		int? $rentalSyncJobsCount,
		int? $reportsCount,
		int? $reportExecutionsCount,
		int? $reservationsCount,
		int? $reviewsCount,
		int? $rightToRentChecksCount,
		int? $rolesCount,
		int? $routesCount,
		int? $securityDepositProtectionsCount,
		int? $signatureRequestsCount,
		int? $signatureSignersCount,
		int? $solicitorManagementsCount,
		int? $subscriptionsCount,
		int? $systemMetricsCount,
		int? $tagsCount,
		int? $tasksCount,
		int? $tax1099FormsCount,
		int? $taxDepreciationsCount,
		int? $taxRecordsCount,
		int? $tenantApplicationsCount,
		int? $userActivityLogsCount,
		int? $userPreferencesCount,
		int? $vacationRentalsCount,
		int? $vendorsCount,
		int? $virtualToursCount,
		int? $webhooksCount,
		int? $webhookDeliveriesCount,
		int? $escrowAccountsCount,
		int? $escrowReleasesCount,
		int? $escrowDisputesCount,
		int? $paymentNegotiationsCount,
		int? $paymentInstallmentsCount,
		int? $videoContentsCount,
		int? $brandAmbassadorsCount,
		int? $ambassadorCampaignsCount,
		int? $socialImpactCountersCount,
		int? $socialImpactRecordsCount,
		int? $negotiationOffersCount,
		int? $ambassadorContractsCount,
		int? $escrowStatusHistoriesCount,
		int? $aiChatMessagesCount,
		int? $aiChatHandoffsCount,
		int? $analysesCount,
		int? $analysisJobsCount,
        }) {
        return Organization(
            id: id != null ? id.value : this.id,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		region: region != null ? region.value : this.region,
		defaultCurrency: defaultCurrency != null ? defaultCurrency.value : this.defaultCurrency,
		defaultLocale: defaultLocale != null ? defaultLocale.value : this.defaultLocale,
		legalName: legalName != null ? legalName.value : this.legalName,
		taxId: taxId != null ? taxId.value : this.taxId,
		address: address != null ? address.value : this.address,
		contactEmail: contactEmail != null ? contactEmail.value : this.contactEmail,
		managementFeeType: managementFeeType != null ? managementFeeType.value : this.managementFeeType,
		managementFeeRate: managementFeeRate != null ? managementFeeRate.value : this.managementFeeRate,
		managementFeeAmount: managementFeeAmount != null ? managementFeeAmount.value : this.managementFeeAmount,
		managementFeeScope: managementFeeScope != null ? managementFeeScope.value : this.managementFeeScope,
		taxReportingEnabled: taxReportingEnabled != null ? taxReportingEnabled.value : this.taxReportingEnabled,
		complianceTracking: complianceTracking != null ? complianceTracking.value : this.complianceTracking,
		requiredInspections: requiredInspections != null ? requiredInspections.value : this.requiredInspections,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		aiChatbotSessions: aiChatbotSessions != null ? aiChatbotSessions.value : this.aiChatbotSessions,
		aiFraudDetections: aiFraudDetections != null ? aiFraudDetections.value : this.aiFraudDetections,
		aiImageAnalyses: aiImageAnalyses != null ? aiImageAnalyses.value : this.aiImageAnalyses,
		aiInvestmentAnalyses: aiInvestmentAnalyses != null ? aiInvestmentAnalyses.value : this.aiInvestmentAnalyses,
		aiLeadScores: aiLeadScores != null ? aiLeadScores.value : this.aiLeadScores,
		aiLeadScoringModels: aiLeadScoringModels != null ? aiLeadScoringModels.value : this.aiLeadScoringModels,
		aiMarketAnalyses: aiMarketAnalyses != null ? aiMarketAnalyses.value : this.aiMarketAnalyses,
		aiModels: aiModels != null ? aiModels.value : this.aiModels,
		aiModelDeployments: aiModelDeployments != null ? aiModelDeployments.value : this.aiModelDeployments,
		aiPredictions: aiPredictions != null ? aiPredictions.value : this.aiPredictions,
		aiPredictiveMaintenance: aiPredictiveMaintenance != null ? aiPredictiveMaintenance.value : this.aiPredictiveMaintenance,
		aiPriceOptimizations: aiPriceOptimizations != null ? aiPriceOptimizations.value : this.aiPriceOptimizations,
		aiPropertyDescriptions: aiPropertyDescriptions != null ? aiPropertyDescriptions.value : this.aiPropertyDescriptions,
		aiPropertyValuations: aiPropertyValuations != null ? aiPropertyValuations.value : this.aiPropertyValuations,
		aiRecommendations: aiRecommendations != null ? aiRecommendations.value : this.aiRecommendations,
		aiSentimentAnalyses: aiSentimentAnalyses != null ? aiSentimentAnalyses.value : this.aiSentimentAnalyses,
		aiTenantScreenings: aiTenantScreenings != null ? aiTenantScreenings.value : this.aiTenantScreenings,
		aiValuationModels: aiValuationModels != null ? aiValuationModels.value : this.aiValuationModels,
		integrations: integrations != null ? integrations.value : this.integrations,
		achievements: achievements != null ? achievements.value : this.achievements,
		agencies: agencies != null ? agencies.value : this.agencies,
		agencyRelations: agencyRelations != null ? agencyRelations.value : this.agencyRelations,
		organizationAgencies: organizationAgencies != null ? organizationAgencies.value : this.organizationAgencies,
		agentAssignments: agentAssignments != null ? agentAssignments.value : this.agentAssignments,
		agentTeams: agentTeams != null ? agentTeams.value : this.agentTeams,
		amenities: amenities != null ? amenities.value : this.amenities,
		apiIntegrations: apiIntegrations != null ? apiIntegrations.value : this.apiIntegrations,
		apiKeys: apiKeys != null ? apiKeys.value : this.apiKeys,
		appointments: appointments != null ? appointments.value : this.appointments,
		attachments: attachments != null ? attachments.value : this.attachments,
		attorneyCases: attorneyCases != null ? attorneyCases.value : this.attorneyCases,
		auditLogs: auditLogs != null ? auditLogs.value : this.auditLogs,
		automationExecutions: automationExecutions != null ? automationExecutions.value : this.automationExecutions,
		automationRules: automationRules != null ? automationRules.value : this.automationRules,
		bookings: bookings != null ? bookings.value : this.bookings,
		budgets: budgets != null ? budgets.value : this.budgets,
		calendarEvents: calendarEvents != null ? calendarEvents.value : this.calendarEvents,
		commissions: commissions != null ? commissions.value : this.commissions,
		communicationTemplates: communicationTemplates != null ? communicationTemplates.value : this.communicationTemplates,
		contacts: contacts != null ? contacts.value : this.contacts,
		contracts: contracts != null ? contracts.value : this.contracts,
		contractVersions: contractVersions != null ? contractVersions.value : this.contractVersions,
		dashboardConfigurations: dashboardConfigurations != null ? dashboardConfigurations.value : this.dashboardConfigurations,
		dashboardWidgets: dashboardWidgets != null ? dashboardWidgets.value : this.dashboardWidgets,
		deals: deals != null ? deals.value : this.deals,
		depositProtections: depositProtections != null ? depositProtections.value : this.depositProtections,
		documents: documents != null ? documents.value : this.documents,
		documentTemplates: documentTemplates != null ? documentTemplates.value : this.documentTemplates,
		earnings: earnings != null ? earnings.value : this.earnings,
		events: events != null ? events.value : this.events,
		eventAttendees: eventAttendees != null ? eventAttendees.value : this.eventAttendees,
		exchangeRates: exchangeRates != null ? exchangeRates.value : this.exchangeRates,
		exportFiles: exportFiles != null ? exportFiles.value : this.exportFiles,
		exportJobs: exportJobs != null ? exportJobs.value : this.exportJobs,
		externalRentalListings: externalRentalListings != null ? externalRentalListings.value : this.externalRentalListings,
		facilities: facilities != null ? facilities.value : this.facilities,
		financialRecords: financialRecords != null ? financialRecords.value : this.financialRecords,
		floorPlans: floorPlans != null ? floorPlans.value : this.floorPlans,
		giftCards: giftCards != null ? giftCards.value : this.giftCards,
		govtIntegrations: govtIntegrations != null ? govtIntegrations.value : this.govtIntegrations,
		healthChecks: healthChecks != null ? healthChecks.value : this.healthChecks,
		homeInformationPacks: homeInformationPacks != null ? homeInformationPacks.value : this.homeInformationPacks,
		immigrationStatusChecks: immigrationStatusChecks != null ? immigrationStatusChecks.value : this.immigrationStatusChecks,
		integrationLogs: integrationLogs != null ? integrationLogs.value : this.integrationLogs,
		investorPortfolios: investorPortfolios != null ? investorPortfolios.value : this.investorPortfolios,
		keys: keys != null ? keys.value : this.keys,
		leads: leads != null ? leads.value : this.leads,
		leadSources: leadSources != null ? leadSources.value : this.leadSources,
		leases: leases != null ? leases.value : this.leases,
		leaseRenewals: leaseRenewals != null ? leaseRenewals.value : this.leaseRenewals,
		ledgerEntries: ledgerEntries != null ? ledgerEntries.value : this.ledgerEntries,
		listings: listings != null ? listings.value : this.listings,
		listingChannels: listingChannels != null ? listingChannels.value : this.listingChannels,
		listingStatusHistories: listingStatusHistories != null ? listingStatusHistories.value : this.listingStatusHistories,
		listingTags: listingTags != null ? listingTags.value : this.listingTags,
		locations: locations != null ? locations.value : this.locations,
		loyaltyAccounts: loyaltyAccounts != null ? loyaltyAccounts.value : this.loyaltyAccounts,
		mlsConnections: mlsConnections != null ? mlsConnections.value : this.mlsConnections,
		mlsexternalListings: mlsexternalListings != null ? mlsexternalListings.value : this.mlsexternalListings,
		mlssyncJobs: mlssyncJobs != null ? mlssyncJobs.value : this.mlssyncJobs,
		maintenanceBlocks: maintenanceBlocks != null ? maintenanceBlocks.value : this.maintenanceBlocks,
		workOrders: workOrders != null ? workOrders.value : this.workOrders,
		mapLayers: mapLayers != null ? mapLayers.value : this.mapLayers,
		marketingCampaigns: marketingCampaigns != null ? marketingCampaigns.value : this.marketingCampaigns,
		messages: messages != null ? messages.value : this.messages,
		mlsDataMappings: mlsDataMappings != null ? mlsDataMappings.value : this.mlsDataMappings,
		mlsListingEnhancements: mlsListingEnhancements != null ? mlsListingEnhancements.value : this.mlsListingEnhancements,
		mobileDevices: mobileDevices != null ? mobileDevices.value : this.mobileDevices,
		mortgageOffers: mortgageOffers != null ? mortgageOffers.value : this.mortgageOffers,
		mortgagePreApprovals: mortgagePreApprovals != null ? mortgagePreApprovals.value : this.mortgagePreApprovals,
		neighborhoods: neighborhoods != null ? neighborhoods.value : this.neighborhoods,
		notifications: notifications != null ? notifications.value : this.notifications,
		offlineSyncQueues: offlineSyncQueues != null ? offlineSyncQueues.value : this.offlineSyncQueues,
		orgSubscription: orgSubscription != null ? orgSubscription.value : this.orgSubscription,
		payouts: payouts != null ? payouts.value : this.payouts,
		performanceAlerts: performanceAlerts != null ? performanceAlerts.value : this.performanceAlerts,
		predictiveModels: predictiveModels != null ? predictiveModels.value : this.predictiveModels,
		projects: projects != null ? projects.value : this.projects,
		properties: properties != null ? properties.value : this.properties,
		propertyAmenities: propertyAmenities != null ? propertyAmenities.value : this.propertyAmenities,
		propertyCompliance: propertyCompliance != null ? propertyCompliance.value : this.propertyCompliance,
		propertyDisclosures: propertyDisclosures != null ? propertyDisclosures.value : this.propertyDisclosures,
		propertyDocuments: propertyDocuments != null ? propertyDocuments.value : this.propertyDocuments,
		inventories: inventories != null ? inventories.value : this.inventories,
		propertyOffers: propertyOffers != null ? propertyOffers.value : this.propertyOffers,
		propertyPhotos: propertyPhotos != null ? propertyPhotos.value : this.propertyPhotos,
		propertyViewings: propertyViewings != null ? propertyViewings.value : this.propertyViewings,
		queueConfigurations: queueConfigurations != null ? queueConfigurations.value : this.queueConfigurations,
		queueMessages: queueMessages != null ? queueMessages.value : this.queueMessages,
		quotes: quotes != null ? quotes.value : this.quotes,
		recommendationResults: recommendationResults != null ? recommendationResults.value : this.recommendationResults,
		referrals: referrals != null ? referrals.value : this.referrals,
		rentArrears: rentArrears != null ? rentArrears.value : this.rentArrears,
		rentSchedules: rentSchedules != null ? rentSchedules.value : this.rentSchedules,
		rentalSyncJobs: rentalSyncJobs != null ? rentalSyncJobs.value : this.rentalSyncJobs,
		reports: reports != null ? reports.value : this.reports,
		reportExecutions: reportExecutions != null ? reportExecutions.value : this.reportExecutions,
		reservations: reservations != null ? reservations.value : this.reservations,
		reviews: reviews != null ? reviews.value : this.reviews,
		rightToRentChecks: rightToRentChecks != null ? rightToRentChecks.value : this.rightToRentChecks,
		roles: roles != null ? roles.value : this.roles,
		routes: routes != null ? routes.value : this.routes,
		securityDepositProtections: securityDepositProtections != null ? securityDepositProtections.value : this.securityDepositProtections,
		signatureRequests: signatureRequests != null ? signatureRequests.value : this.signatureRequests,
		signatureSigners: signatureSigners != null ? signatureSigners.value : this.signatureSigners,
		solicitorManagements: solicitorManagements != null ? solicitorManagements.value : this.solicitorManagements,
		subscriptions: subscriptions != null ? subscriptions.value : this.subscriptions,
		systemMetrics: systemMetrics != null ? systemMetrics.value : this.systemMetrics,
		tags: tags != null ? tags.value : this.tags,
		tasks: tasks != null ? tasks.value : this.tasks,
		tax1099Forms: tax1099Forms != null ? tax1099Forms.value : this.tax1099Forms,
		taxDepreciations: taxDepreciations != null ? taxDepreciations.value : this.taxDepreciations,
		taxRecords: taxRecords != null ? taxRecords.value : this.taxRecords,
		tenantApplications: tenantApplications != null ? tenantApplications.value : this.tenantApplications,
		userActivityLogs: userActivityLogs != null ? userActivityLogs.value : this.userActivityLogs,
		userPreferences: userPreferences != null ? userPreferences.value : this.userPreferences,
		vacationRentals: vacationRentals != null ? vacationRentals.value : this.vacationRentals,
		vendors: vendors != null ? vendors.value : this.vendors,
		virtualTours: virtualTours != null ? virtualTours.value : this.virtualTours,
		webhooks: webhooks != null ? webhooks.value : this.webhooks,
		webhookDeliveries: webhookDeliveries != null ? webhookDeliveries.value : this.webhookDeliveries,
		escrowAccounts: escrowAccounts != null ? escrowAccounts.value : this.escrowAccounts,
		escrowReleases: escrowReleases != null ? escrowReleases.value : this.escrowReleases,
		escrowDisputes: escrowDisputes != null ? escrowDisputes.value : this.escrowDisputes,
		paymentNegotiations: paymentNegotiations != null ? paymentNegotiations.value : this.paymentNegotiations,
		paymentInstallments: paymentInstallments != null ? paymentInstallments.value : this.paymentInstallments,
		videoContents: videoContents != null ? videoContents.value : this.videoContents,
		brandAmbassadors: brandAmbassadors != null ? brandAmbassadors.value : this.brandAmbassadors,
		ambassadorCampaigns: ambassadorCampaigns != null ? ambassadorCampaigns.value : this.ambassadorCampaigns,
		socialImpactCounters: socialImpactCounters != null ? socialImpactCounters.value : this.socialImpactCounters,
		socialImpactRecords: socialImpactRecords != null ? socialImpactRecords.value : this.socialImpactRecords,
		negotiationOffers: negotiationOffers != null ? negotiationOffers.value : this.negotiationOffers,
		ambassadorContracts: ambassadorContracts != null ? ambassadorContracts.value : this.ambassadorContracts,
		escrowStatusHistories: escrowStatusHistories != null ? escrowStatusHistories.value : this.escrowStatusHistories,
		aiChatMessages: aiChatMessages != null ? aiChatMessages.value : this.aiChatMessages,
		aiChatHandoffs: aiChatHandoffs != null ? aiChatHandoffs.value : this.aiChatHandoffs,
		analyses: analyses != null ? analyses.value : this.analyses,
		analysisJobs: analysisJobs != null ? analysisJobs.value : this.analysisJobs,
		$requiredInspectionsCount: $requiredInspectionsCount ?? this.$requiredInspectionsCount,
		$aiChatbotSessionsCount: $aiChatbotSessionsCount ?? this.$aiChatbotSessionsCount,
		$aiFraudDetectionsCount: $aiFraudDetectionsCount ?? this.$aiFraudDetectionsCount,
		$aiImageAnalysesCount: $aiImageAnalysesCount ?? this.$aiImageAnalysesCount,
		$aiInvestmentAnalysesCount: $aiInvestmentAnalysesCount ?? this.$aiInvestmentAnalysesCount,
		$aiLeadScoresCount: $aiLeadScoresCount ?? this.$aiLeadScoresCount,
		$aiLeadScoringModelsCount: $aiLeadScoringModelsCount ?? this.$aiLeadScoringModelsCount,
		$aiMarketAnalysesCount: $aiMarketAnalysesCount ?? this.$aiMarketAnalysesCount,
		$aiModelsCount: $aiModelsCount ?? this.$aiModelsCount,
		$aiModelDeploymentsCount: $aiModelDeploymentsCount ?? this.$aiModelDeploymentsCount,
		$aiPredictionsCount: $aiPredictionsCount ?? this.$aiPredictionsCount,
		$aiPredictiveMaintenanceCount: $aiPredictiveMaintenanceCount ?? this.$aiPredictiveMaintenanceCount,
		$aiPriceOptimizationsCount: $aiPriceOptimizationsCount ?? this.$aiPriceOptimizationsCount,
		$aiPropertyDescriptionsCount: $aiPropertyDescriptionsCount ?? this.$aiPropertyDescriptionsCount,
		$aiPropertyValuationsCount: $aiPropertyValuationsCount ?? this.$aiPropertyValuationsCount,
		$aiRecommendationsCount: $aiRecommendationsCount ?? this.$aiRecommendationsCount,
		$aiSentimentAnalysesCount: $aiSentimentAnalysesCount ?? this.$aiSentimentAnalysesCount,
		$aiTenantScreeningsCount: $aiTenantScreeningsCount ?? this.$aiTenantScreeningsCount,
		$aiValuationModelsCount: $aiValuationModelsCount ?? this.$aiValuationModelsCount,
		$integrationsCount: $integrationsCount ?? this.$integrationsCount,
		$achievementsCount: $achievementsCount ?? this.$achievementsCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$agencyRelationsCount: $agencyRelationsCount ?? this.$agencyRelationsCount,
		$organizationAgenciesCount: $organizationAgenciesCount ?? this.$organizationAgenciesCount,
		$agentAssignmentsCount: $agentAssignmentsCount ?? this.$agentAssignmentsCount,
		$agentTeamsCount: $agentTeamsCount ?? this.$agentTeamsCount,
		$amenitiesCount: $amenitiesCount ?? this.$amenitiesCount,
		$apiIntegrationsCount: $apiIntegrationsCount ?? this.$apiIntegrationsCount,
		$apiKeysCount: $apiKeysCount ?? this.$apiKeysCount,
		$appointmentsCount: $appointmentsCount ?? this.$appointmentsCount,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount,
		$attorneyCasesCount: $attorneyCasesCount ?? this.$attorneyCasesCount,
		$auditLogsCount: $auditLogsCount ?? this.$auditLogsCount,
		$automationExecutionsCount: $automationExecutionsCount ?? this.$automationExecutionsCount,
		$automationRulesCount: $automationRulesCount ?? this.$automationRulesCount,
		$bookingsCount: $bookingsCount ?? this.$bookingsCount,
		$budgetsCount: $budgetsCount ?? this.$budgetsCount,
		$calendarEventsCount: $calendarEventsCount ?? this.$calendarEventsCount,
		$commissionsCount: $commissionsCount ?? this.$commissionsCount,
		$communicationTemplatesCount: $communicationTemplatesCount ?? this.$communicationTemplatesCount,
		$contactsCount: $contactsCount ?? this.$contactsCount,
		$contractsCount: $contractsCount ?? this.$contractsCount,
		$contractVersionsCount: $contractVersionsCount ?? this.$contractVersionsCount,
		$dashboardConfigurationsCount: $dashboardConfigurationsCount ?? this.$dashboardConfigurationsCount,
		$dashboardWidgetsCount: $dashboardWidgetsCount ?? this.$dashboardWidgetsCount,
		$dealsCount: $dealsCount ?? this.$dealsCount,
		$depositProtectionsCount: $depositProtectionsCount ?? this.$depositProtectionsCount,
		$documentsCount: $documentsCount ?? this.$documentsCount,
		$documentTemplatesCount: $documentTemplatesCount ?? this.$documentTemplatesCount,
		$earningsCount: $earningsCount ?? this.$earningsCount,
		$eventsCount: $eventsCount ?? this.$eventsCount,
		$eventAttendeesCount: $eventAttendeesCount ?? this.$eventAttendeesCount,
		$exchangeRatesCount: $exchangeRatesCount ?? this.$exchangeRatesCount,
		$exportFilesCount: $exportFilesCount ?? this.$exportFilesCount,
		$exportJobsCount: $exportJobsCount ?? this.$exportJobsCount,
		$externalRentalListingsCount: $externalRentalListingsCount ?? this.$externalRentalListingsCount,
		$facilitiesCount: $facilitiesCount ?? this.$facilitiesCount,
		$financialRecordsCount: $financialRecordsCount ?? this.$financialRecordsCount,
		$floorPlansCount: $floorPlansCount ?? this.$floorPlansCount,
		$giftCardsCount: $giftCardsCount ?? this.$giftCardsCount,
		$govtIntegrationsCount: $govtIntegrationsCount ?? this.$govtIntegrationsCount,
		$healthChecksCount: $healthChecksCount ?? this.$healthChecksCount,
		$homeInformationPacksCount: $homeInformationPacksCount ?? this.$homeInformationPacksCount,
		$immigrationStatusChecksCount: $immigrationStatusChecksCount ?? this.$immigrationStatusChecksCount,
		$integrationLogsCount: $integrationLogsCount ?? this.$integrationLogsCount,
		$investorPortfoliosCount: $investorPortfoliosCount ?? this.$investorPortfoliosCount,
		$keysCount: $keysCount ?? this.$keysCount,
		$leadsCount: $leadsCount ?? this.$leadsCount,
		$leadSourcesCount: $leadSourcesCount ?? this.$leadSourcesCount,
		$leasesCount: $leasesCount ?? this.$leasesCount,
		$leaseRenewalsCount: $leaseRenewalsCount ?? this.$leaseRenewalsCount,
		$ledgerEntriesCount: $ledgerEntriesCount ?? this.$ledgerEntriesCount,
		$listingsCount: $listingsCount ?? this.$listingsCount,
		$listingChannelsCount: $listingChannelsCount ?? this.$listingChannelsCount,
		$listingStatusHistoriesCount: $listingStatusHistoriesCount ?? this.$listingStatusHistoriesCount,
		$listingTagsCount: $listingTagsCount ?? this.$listingTagsCount,
		$locationsCount: $locationsCount ?? this.$locationsCount,
		$loyaltyAccountsCount: $loyaltyAccountsCount ?? this.$loyaltyAccountsCount,
		$mlsConnectionsCount: $mlsConnectionsCount ?? this.$mlsConnectionsCount,
		$mlsexternalListingsCount: $mlsexternalListingsCount ?? this.$mlsexternalListingsCount,
		$mlssyncJobsCount: $mlssyncJobsCount ?? this.$mlssyncJobsCount,
		$maintenanceBlocksCount: $maintenanceBlocksCount ?? this.$maintenanceBlocksCount,
		$workOrdersCount: $workOrdersCount ?? this.$workOrdersCount,
		$mapLayersCount: $mapLayersCount ?? this.$mapLayersCount,
		$marketingCampaignsCount: $marketingCampaignsCount ?? this.$marketingCampaignsCount,
		$messagesCount: $messagesCount ?? this.$messagesCount,
		$mlsDataMappingsCount: $mlsDataMappingsCount ?? this.$mlsDataMappingsCount,
		$mlsListingEnhancementsCount: $mlsListingEnhancementsCount ?? this.$mlsListingEnhancementsCount,
		$mobileDevicesCount: $mobileDevicesCount ?? this.$mobileDevicesCount,
		$mortgageOffersCount: $mortgageOffersCount ?? this.$mortgageOffersCount,
		$mortgagePreApprovalsCount: $mortgagePreApprovalsCount ?? this.$mortgagePreApprovalsCount,
		$neighborhoodsCount: $neighborhoodsCount ?? this.$neighborhoodsCount,
		$notificationsCount: $notificationsCount ?? this.$notificationsCount,
		$offlineSyncQueuesCount: $offlineSyncQueuesCount ?? this.$offlineSyncQueuesCount,
		$payoutsCount: $payoutsCount ?? this.$payoutsCount,
		$performanceAlertsCount: $performanceAlertsCount ?? this.$performanceAlertsCount,
		$predictiveModelsCount: $predictiveModelsCount ?? this.$predictiveModelsCount,
		$projectsCount: $projectsCount ?? this.$projectsCount,
		$propertiesCount: $propertiesCount ?? this.$propertiesCount,
		$propertyAmenitiesCount: $propertyAmenitiesCount ?? this.$propertyAmenitiesCount,
		$propertyComplianceCount: $propertyComplianceCount ?? this.$propertyComplianceCount,
		$propertyDisclosuresCount: $propertyDisclosuresCount ?? this.$propertyDisclosuresCount,
		$propertyDocumentsCount: $propertyDocumentsCount ?? this.$propertyDocumentsCount,
		$inventoriesCount: $inventoriesCount ?? this.$inventoriesCount,
		$propertyOffersCount: $propertyOffersCount ?? this.$propertyOffersCount,
		$propertyPhotosCount: $propertyPhotosCount ?? this.$propertyPhotosCount,
		$propertyViewingsCount: $propertyViewingsCount ?? this.$propertyViewingsCount,
		$queueConfigurationsCount: $queueConfigurationsCount ?? this.$queueConfigurationsCount,
		$queueMessagesCount: $queueMessagesCount ?? this.$queueMessagesCount,
		$quotesCount: $quotesCount ?? this.$quotesCount,
		$recommendationResultsCount: $recommendationResultsCount ?? this.$recommendationResultsCount,
		$referralsCount: $referralsCount ?? this.$referralsCount,
		$rentArrearsCount: $rentArrearsCount ?? this.$rentArrearsCount,
		$rentSchedulesCount: $rentSchedulesCount ?? this.$rentSchedulesCount,
		$rentalSyncJobsCount: $rentalSyncJobsCount ?? this.$rentalSyncJobsCount,
		$reportsCount: $reportsCount ?? this.$reportsCount,
		$reportExecutionsCount: $reportExecutionsCount ?? this.$reportExecutionsCount,
		$reservationsCount: $reservationsCount ?? this.$reservationsCount,
		$reviewsCount: $reviewsCount ?? this.$reviewsCount,
		$rightToRentChecksCount: $rightToRentChecksCount ?? this.$rightToRentChecksCount,
		$rolesCount: $rolesCount ?? this.$rolesCount,
		$routesCount: $routesCount ?? this.$routesCount,
		$securityDepositProtectionsCount: $securityDepositProtectionsCount ?? this.$securityDepositProtectionsCount,
		$signatureRequestsCount: $signatureRequestsCount ?? this.$signatureRequestsCount,
		$signatureSignersCount: $signatureSignersCount ?? this.$signatureSignersCount,
		$solicitorManagementsCount: $solicitorManagementsCount ?? this.$solicitorManagementsCount,
		$subscriptionsCount: $subscriptionsCount ?? this.$subscriptionsCount,
		$systemMetricsCount: $systemMetricsCount ?? this.$systemMetricsCount,
		$tagsCount: $tagsCount ?? this.$tagsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$tax1099FormsCount: $tax1099FormsCount ?? this.$tax1099FormsCount,
		$taxDepreciationsCount: $taxDepreciationsCount ?? this.$taxDepreciationsCount,
		$taxRecordsCount: $taxRecordsCount ?? this.$taxRecordsCount,
		$tenantApplicationsCount: $tenantApplicationsCount ?? this.$tenantApplicationsCount,
		$userActivityLogsCount: $userActivityLogsCount ?? this.$userActivityLogsCount,
		$userPreferencesCount: $userPreferencesCount ?? this.$userPreferencesCount,
		$vacationRentalsCount: $vacationRentalsCount ?? this.$vacationRentalsCount,
		$vendorsCount: $vendorsCount ?? this.$vendorsCount,
		$virtualToursCount: $virtualToursCount ?? this.$virtualToursCount,
		$webhooksCount: $webhooksCount ?? this.$webhooksCount,
		$webhookDeliveriesCount: $webhookDeliveriesCount ?? this.$webhookDeliveriesCount,
		$escrowAccountsCount: $escrowAccountsCount ?? this.$escrowAccountsCount,
		$escrowReleasesCount: $escrowReleasesCount ?? this.$escrowReleasesCount,
		$escrowDisputesCount: $escrowDisputesCount ?? this.$escrowDisputesCount,
		$paymentNegotiationsCount: $paymentNegotiationsCount ?? this.$paymentNegotiationsCount,
		$paymentInstallmentsCount: $paymentInstallmentsCount ?? this.$paymentInstallmentsCount,
		$videoContentsCount: $videoContentsCount ?? this.$videoContentsCount,
		$brandAmbassadorsCount: $brandAmbassadorsCount ?? this.$brandAmbassadorsCount,
		$ambassadorCampaignsCount: $ambassadorCampaignsCount ?? this.$ambassadorCampaignsCount,
		$socialImpactCountersCount: $socialImpactCountersCount ?? this.$socialImpactCountersCount,
		$socialImpactRecordsCount: $socialImpactRecordsCount ?? this.$socialImpactRecordsCount,
		$negotiationOffersCount: $negotiationOffersCount ?? this.$negotiationOffersCount,
		$ambassadorContractsCount: $ambassadorContractsCount ?? this.$ambassadorContractsCount,
		$escrowStatusHistoriesCount: $escrowStatusHistoriesCount ?? this.$escrowStatusHistoriesCount,
		$aiChatMessagesCount: $aiChatMessagesCount ?? this.$aiChatMessagesCount,
		$aiChatHandoffsCount: $aiChatHandoffsCount ?? this.$aiChatHandoffsCount,
		$analysesCount: $analysesCount ?? this.$analysesCount,
		$analysisJobsCount: $analysisJobsCount ?? this.$analysisJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Organization copyWithInstanceValues(Organization organization) {
        return Organization(
            id: organization.id ?? id,
		name: organization.name ?? name,
		type: organization.type ?? type,
		region: organization.region ?? region,
		defaultCurrency: organization.defaultCurrency ?? defaultCurrency,
		defaultLocale: organization.defaultLocale ?? defaultLocale,
		legalName: organization.legalName ?? legalName,
		taxId: organization.taxId ?? taxId,
		address: organization.address ?? address,
		contactEmail: organization.contactEmail ?? contactEmail,
		managementFeeType: organization.managementFeeType ?? managementFeeType,
		managementFeeRate: organization.managementFeeRate ?? managementFeeRate,
		managementFeeAmount: organization.managementFeeAmount ?? managementFeeAmount,
		managementFeeScope: organization.managementFeeScope ?? managementFeeScope,
		taxReportingEnabled: organization.taxReportingEnabled ?? taxReportingEnabled,
		complianceTracking: organization.complianceTracking ?? complianceTracking,
		requiredInspections: organization.requiredInspections ?? requiredInspections,
		createdAt: organization.createdAt ?? createdAt,
		updatedAt: organization.updatedAt ?? updatedAt,
		deletedAt: organization.deletedAt ?? deletedAt,
		aiChatbotSessions: organization.aiChatbotSessions ?? aiChatbotSessions,
		aiFraudDetections: organization.aiFraudDetections ?? aiFraudDetections,
		aiImageAnalyses: organization.aiImageAnalyses ?? aiImageAnalyses,
		aiInvestmentAnalyses: organization.aiInvestmentAnalyses ?? aiInvestmentAnalyses,
		aiLeadScores: organization.aiLeadScores ?? aiLeadScores,
		aiLeadScoringModels: organization.aiLeadScoringModels ?? aiLeadScoringModels,
		aiMarketAnalyses: organization.aiMarketAnalyses ?? aiMarketAnalyses,
		aiModels: organization.aiModels ?? aiModels,
		aiModelDeployments: organization.aiModelDeployments ?? aiModelDeployments,
		aiPredictions: organization.aiPredictions ?? aiPredictions,
		aiPredictiveMaintenance: organization.aiPredictiveMaintenance ?? aiPredictiveMaintenance,
		aiPriceOptimizations: organization.aiPriceOptimizations ?? aiPriceOptimizations,
		aiPropertyDescriptions: organization.aiPropertyDescriptions ?? aiPropertyDescriptions,
		aiPropertyValuations: organization.aiPropertyValuations ?? aiPropertyValuations,
		aiRecommendations: organization.aiRecommendations ?? aiRecommendations,
		aiSentimentAnalyses: organization.aiSentimentAnalyses ?? aiSentimentAnalyses,
		aiTenantScreenings: organization.aiTenantScreenings ?? aiTenantScreenings,
		aiValuationModels: organization.aiValuationModels ?? aiValuationModels,
		integrations: organization.integrations ?? integrations,
		achievements: organization.achievements ?? achievements,
		agencies: organization.agencies ?? agencies,
		agencyRelations: organization.agencyRelations ?? agencyRelations,
		organizationAgencies: organization.organizationAgencies ?? organizationAgencies,
		agentAssignments: organization.agentAssignments ?? agentAssignments,
		agentTeams: organization.agentTeams ?? agentTeams,
		amenities: organization.amenities ?? amenities,
		apiIntegrations: organization.apiIntegrations ?? apiIntegrations,
		apiKeys: organization.apiKeys ?? apiKeys,
		appointments: organization.appointments ?? appointments,
		attachments: organization.attachments ?? attachments,
		attorneyCases: organization.attorneyCases ?? attorneyCases,
		auditLogs: organization.auditLogs ?? auditLogs,
		automationExecutions: organization.automationExecutions ?? automationExecutions,
		automationRules: organization.automationRules ?? automationRules,
		bookings: organization.bookings ?? bookings,
		budgets: organization.budgets ?? budgets,
		calendarEvents: organization.calendarEvents ?? calendarEvents,
		commissions: organization.commissions ?? commissions,
		communicationTemplates: organization.communicationTemplates ?? communicationTemplates,
		contacts: organization.contacts ?? contacts,
		contracts: organization.contracts ?? contracts,
		contractVersions: organization.contractVersions ?? contractVersions,
		dashboardConfigurations: organization.dashboardConfigurations ?? dashboardConfigurations,
		dashboardWidgets: organization.dashboardWidgets ?? dashboardWidgets,
		deals: organization.deals ?? deals,
		depositProtections: organization.depositProtections ?? depositProtections,
		documents: organization.documents ?? documents,
		documentTemplates: organization.documentTemplates ?? documentTemplates,
		earnings: organization.earnings ?? earnings,
		events: organization.events ?? events,
		eventAttendees: organization.eventAttendees ?? eventAttendees,
		exchangeRates: organization.exchangeRates ?? exchangeRates,
		exportFiles: organization.exportFiles ?? exportFiles,
		exportJobs: organization.exportJobs ?? exportJobs,
		externalRentalListings: organization.externalRentalListings ?? externalRentalListings,
		facilities: organization.facilities ?? facilities,
		financialRecords: organization.financialRecords ?? financialRecords,
		floorPlans: organization.floorPlans ?? floorPlans,
		giftCards: organization.giftCards ?? giftCards,
		govtIntegrations: organization.govtIntegrations ?? govtIntegrations,
		healthChecks: organization.healthChecks ?? healthChecks,
		homeInformationPacks: organization.homeInformationPacks ?? homeInformationPacks,
		immigrationStatusChecks: organization.immigrationStatusChecks ?? immigrationStatusChecks,
		integrationLogs: organization.integrationLogs ?? integrationLogs,
		investorPortfolios: organization.investorPortfolios ?? investorPortfolios,
		keys: organization.keys ?? keys,
		leads: organization.leads ?? leads,
		leadSources: organization.leadSources ?? leadSources,
		leases: organization.leases ?? leases,
		leaseRenewals: organization.leaseRenewals ?? leaseRenewals,
		ledgerEntries: organization.ledgerEntries ?? ledgerEntries,
		listings: organization.listings ?? listings,
		listingChannels: organization.listingChannels ?? listingChannels,
		listingStatusHistories: organization.listingStatusHistories ?? listingStatusHistories,
		listingTags: organization.listingTags ?? listingTags,
		locations: organization.locations ?? locations,
		loyaltyAccounts: organization.loyaltyAccounts ?? loyaltyAccounts,
		mlsConnections: organization.mlsConnections ?? mlsConnections,
		mlsexternalListings: organization.mlsexternalListings ?? mlsexternalListings,
		mlssyncJobs: organization.mlssyncJobs ?? mlssyncJobs,
		maintenanceBlocks: organization.maintenanceBlocks ?? maintenanceBlocks,
		workOrders: organization.workOrders ?? workOrders,
		mapLayers: organization.mapLayers ?? mapLayers,
		marketingCampaigns: organization.marketingCampaigns ?? marketingCampaigns,
		messages: organization.messages ?? messages,
		mlsDataMappings: organization.mlsDataMappings ?? mlsDataMappings,
		mlsListingEnhancements: organization.mlsListingEnhancements ?? mlsListingEnhancements,
		mobileDevices: organization.mobileDevices ?? mobileDevices,
		mortgageOffers: organization.mortgageOffers ?? mortgageOffers,
		mortgagePreApprovals: organization.mortgagePreApprovals ?? mortgagePreApprovals,
		neighborhoods: organization.neighborhoods ?? neighborhoods,
		notifications: organization.notifications ?? notifications,
		offlineSyncQueues: organization.offlineSyncQueues ?? offlineSyncQueues,
		orgSubscription: organization.orgSubscription ?? orgSubscription,
		payouts: organization.payouts ?? payouts,
		performanceAlerts: organization.performanceAlerts ?? performanceAlerts,
		predictiveModels: organization.predictiveModels ?? predictiveModels,
		projects: organization.projects ?? projects,
		properties: organization.properties ?? properties,
		propertyAmenities: organization.propertyAmenities ?? propertyAmenities,
		propertyCompliance: organization.propertyCompliance ?? propertyCompliance,
		propertyDisclosures: organization.propertyDisclosures ?? propertyDisclosures,
		propertyDocuments: organization.propertyDocuments ?? propertyDocuments,
		inventories: organization.inventories ?? inventories,
		propertyOffers: organization.propertyOffers ?? propertyOffers,
		propertyPhotos: organization.propertyPhotos ?? propertyPhotos,
		propertyViewings: organization.propertyViewings ?? propertyViewings,
		queueConfigurations: organization.queueConfigurations ?? queueConfigurations,
		queueMessages: organization.queueMessages ?? queueMessages,
		quotes: organization.quotes ?? quotes,
		recommendationResults: organization.recommendationResults ?? recommendationResults,
		referrals: organization.referrals ?? referrals,
		rentArrears: organization.rentArrears ?? rentArrears,
		rentSchedules: organization.rentSchedules ?? rentSchedules,
		rentalSyncJobs: organization.rentalSyncJobs ?? rentalSyncJobs,
		reports: organization.reports ?? reports,
		reportExecutions: organization.reportExecutions ?? reportExecutions,
		reservations: organization.reservations ?? reservations,
		reviews: organization.reviews ?? reviews,
		rightToRentChecks: organization.rightToRentChecks ?? rightToRentChecks,
		roles: organization.roles ?? roles,
		routes: organization.routes ?? routes,
		securityDepositProtections: organization.securityDepositProtections ?? securityDepositProtections,
		signatureRequests: organization.signatureRequests ?? signatureRequests,
		signatureSigners: organization.signatureSigners ?? signatureSigners,
		solicitorManagements: organization.solicitorManagements ?? solicitorManagements,
		subscriptions: organization.subscriptions ?? subscriptions,
		systemMetrics: organization.systemMetrics ?? systemMetrics,
		tags: organization.tags ?? tags,
		tasks: organization.tasks ?? tasks,
		tax1099Forms: organization.tax1099Forms ?? tax1099Forms,
		taxDepreciations: organization.taxDepreciations ?? taxDepreciations,
		taxRecords: organization.taxRecords ?? taxRecords,
		tenantApplications: organization.tenantApplications ?? tenantApplications,
		userActivityLogs: organization.userActivityLogs ?? userActivityLogs,
		userPreferences: organization.userPreferences ?? userPreferences,
		vacationRentals: organization.vacationRentals ?? vacationRentals,
		vendors: organization.vendors ?? vendors,
		virtualTours: organization.virtualTours ?? virtualTours,
		webhooks: organization.webhooks ?? webhooks,
		webhookDeliveries: organization.webhookDeliveries ?? webhookDeliveries,
		escrowAccounts: organization.escrowAccounts ?? escrowAccounts,
		escrowReleases: organization.escrowReleases ?? escrowReleases,
		escrowDisputes: organization.escrowDisputes ?? escrowDisputes,
		paymentNegotiations: organization.paymentNegotiations ?? paymentNegotiations,
		paymentInstallments: organization.paymentInstallments ?? paymentInstallments,
		videoContents: organization.videoContents ?? videoContents,
		brandAmbassadors: organization.brandAmbassadors ?? brandAmbassadors,
		ambassadorCampaigns: organization.ambassadorCampaigns ?? ambassadorCampaigns,
		socialImpactCounters: organization.socialImpactCounters ?? socialImpactCounters,
		socialImpactRecords: organization.socialImpactRecords ?? socialImpactRecords,
		negotiationOffers: organization.negotiationOffers ?? negotiationOffers,
		ambassadorContracts: organization.ambassadorContracts ?? ambassadorContracts,
		escrowStatusHistories: organization.escrowStatusHistories ?? escrowStatusHistories,
		aiChatMessages: organization.aiChatMessages ?? aiChatMessages,
		aiChatHandoffs: organization.aiChatHandoffs ?? aiChatHandoffs,
		analyses: organization.analyses ?? analyses,
		analysisJobs: organization.analysisJobs ?? analysisJobs,
		$requiredInspectionsCount: organization.$requiredInspectionsCount ?? $requiredInspectionsCount,
		$aiChatbotSessionsCount: organization.$aiChatbotSessionsCount ?? $aiChatbotSessionsCount,
		$aiFraudDetectionsCount: organization.$aiFraudDetectionsCount ?? $aiFraudDetectionsCount,
		$aiImageAnalysesCount: organization.$aiImageAnalysesCount ?? $aiImageAnalysesCount,
		$aiInvestmentAnalysesCount: organization.$aiInvestmentAnalysesCount ?? $aiInvestmentAnalysesCount,
		$aiLeadScoresCount: organization.$aiLeadScoresCount ?? $aiLeadScoresCount,
		$aiLeadScoringModelsCount: organization.$aiLeadScoringModelsCount ?? $aiLeadScoringModelsCount,
		$aiMarketAnalysesCount: organization.$aiMarketAnalysesCount ?? $aiMarketAnalysesCount,
		$aiModelsCount: organization.$aiModelsCount ?? $aiModelsCount,
		$aiModelDeploymentsCount: organization.$aiModelDeploymentsCount ?? $aiModelDeploymentsCount,
		$aiPredictionsCount: organization.$aiPredictionsCount ?? $aiPredictionsCount,
		$aiPredictiveMaintenanceCount: organization.$aiPredictiveMaintenanceCount ?? $aiPredictiveMaintenanceCount,
		$aiPriceOptimizationsCount: organization.$aiPriceOptimizationsCount ?? $aiPriceOptimizationsCount,
		$aiPropertyDescriptionsCount: organization.$aiPropertyDescriptionsCount ?? $aiPropertyDescriptionsCount,
		$aiPropertyValuationsCount: organization.$aiPropertyValuationsCount ?? $aiPropertyValuationsCount,
		$aiRecommendationsCount: organization.$aiRecommendationsCount ?? $aiRecommendationsCount,
		$aiSentimentAnalysesCount: organization.$aiSentimentAnalysesCount ?? $aiSentimentAnalysesCount,
		$aiTenantScreeningsCount: organization.$aiTenantScreeningsCount ?? $aiTenantScreeningsCount,
		$aiValuationModelsCount: organization.$aiValuationModelsCount ?? $aiValuationModelsCount,
		$integrationsCount: organization.$integrationsCount ?? $integrationsCount,
		$achievementsCount: organization.$achievementsCount ?? $achievementsCount,
		$agenciesCount: organization.$agenciesCount ?? $agenciesCount,
		$agencyRelationsCount: organization.$agencyRelationsCount ?? $agencyRelationsCount,
		$organizationAgenciesCount: organization.$organizationAgenciesCount ?? $organizationAgenciesCount,
		$agentAssignmentsCount: organization.$agentAssignmentsCount ?? $agentAssignmentsCount,
		$agentTeamsCount: organization.$agentTeamsCount ?? $agentTeamsCount,
		$amenitiesCount: organization.$amenitiesCount ?? $amenitiesCount,
		$apiIntegrationsCount: organization.$apiIntegrationsCount ?? $apiIntegrationsCount,
		$apiKeysCount: organization.$apiKeysCount ?? $apiKeysCount,
		$appointmentsCount: organization.$appointmentsCount ?? $appointmentsCount,
		$attachmentsCount: organization.$attachmentsCount ?? $attachmentsCount,
		$attorneyCasesCount: organization.$attorneyCasesCount ?? $attorneyCasesCount,
		$auditLogsCount: organization.$auditLogsCount ?? $auditLogsCount,
		$automationExecutionsCount: organization.$automationExecutionsCount ?? $automationExecutionsCount,
		$automationRulesCount: organization.$automationRulesCount ?? $automationRulesCount,
		$bookingsCount: organization.$bookingsCount ?? $bookingsCount,
		$budgetsCount: organization.$budgetsCount ?? $budgetsCount,
		$calendarEventsCount: organization.$calendarEventsCount ?? $calendarEventsCount,
		$commissionsCount: organization.$commissionsCount ?? $commissionsCount,
		$communicationTemplatesCount: organization.$communicationTemplatesCount ?? $communicationTemplatesCount,
		$contactsCount: organization.$contactsCount ?? $contactsCount,
		$contractsCount: organization.$contractsCount ?? $contractsCount,
		$contractVersionsCount: organization.$contractVersionsCount ?? $contractVersionsCount,
		$dashboardConfigurationsCount: organization.$dashboardConfigurationsCount ?? $dashboardConfigurationsCount,
		$dashboardWidgetsCount: organization.$dashboardWidgetsCount ?? $dashboardWidgetsCount,
		$dealsCount: organization.$dealsCount ?? $dealsCount,
		$depositProtectionsCount: organization.$depositProtectionsCount ?? $depositProtectionsCount,
		$documentsCount: organization.$documentsCount ?? $documentsCount,
		$documentTemplatesCount: organization.$documentTemplatesCount ?? $documentTemplatesCount,
		$earningsCount: organization.$earningsCount ?? $earningsCount,
		$eventsCount: organization.$eventsCount ?? $eventsCount,
		$eventAttendeesCount: organization.$eventAttendeesCount ?? $eventAttendeesCount,
		$exchangeRatesCount: organization.$exchangeRatesCount ?? $exchangeRatesCount,
		$exportFilesCount: organization.$exportFilesCount ?? $exportFilesCount,
		$exportJobsCount: organization.$exportJobsCount ?? $exportJobsCount,
		$externalRentalListingsCount: organization.$externalRentalListingsCount ?? $externalRentalListingsCount,
		$facilitiesCount: organization.$facilitiesCount ?? $facilitiesCount,
		$financialRecordsCount: organization.$financialRecordsCount ?? $financialRecordsCount,
		$floorPlansCount: organization.$floorPlansCount ?? $floorPlansCount,
		$giftCardsCount: organization.$giftCardsCount ?? $giftCardsCount,
		$govtIntegrationsCount: organization.$govtIntegrationsCount ?? $govtIntegrationsCount,
		$healthChecksCount: organization.$healthChecksCount ?? $healthChecksCount,
		$homeInformationPacksCount: organization.$homeInformationPacksCount ?? $homeInformationPacksCount,
		$immigrationStatusChecksCount: organization.$immigrationStatusChecksCount ?? $immigrationStatusChecksCount,
		$integrationLogsCount: organization.$integrationLogsCount ?? $integrationLogsCount,
		$investorPortfoliosCount: organization.$investorPortfoliosCount ?? $investorPortfoliosCount,
		$keysCount: organization.$keysCount ?? $keysCount,
		$leadsCount: organization.$leadsCount ?? $leadsCount,
		$leadSourcesCount: organization.$leadSourcesCount ?? $leadSourcesCount,
		$leasesCount: organization.$leasesCount ?? $leasesCount,
		$leaseRenewalsCount: organization.$leaseRenewalsCount ?? $leaseRenewalsCount,
		$ledgerEntriesCount: organization.$ledgerEntriesCount ?? $ledgerEntriesCount,
		$listingsCount: organization.$listingsCount ?? $listingsCount,
		$listingChannelsCount: organization.$listingChannelsCount ?? $listingChannelsCount,
		$listingStatusHistoriesCount: organization.$listingStatusHistoriesCount ?? $listingStatusHistoriesCount,
		$listingTagsCount: organization.$listingTagsCount ?? $listingTagsCount,
		$locationsCount: organization.$locationsCount ?? $locationsCount,
		$loyaltyAccountsCount: organization.$loyaltyAccountsCount ?? $loyaltyAccountsCount,
		$mlsConnectionsCount: organization.$mlsConnectionsCount ?? $mlsConnectionsCount,
		$mlsexternalListingsCount: organization.$mlsexternalListingsCount ?? $mlsexternalListingsCount,
		$mlssyncJobsCount: organization.$mlssyncJobsCount ?? $mlssyncJobsCount,
		$maintenanceBlocksCount: organization.$maintenanceBlocksCount ?? $maintenanceBlocksCount,
		$workOrdersCount: organization.$workOrdersCount ?? $workOrdersCount,
		$mapLayersCount: organization.$mapLayersCount ?? $mapLayersCount,
		$marketingCampaignsCount: organization.$marketingCampaignsCount ?? $marketingCampaignsCount,
		$messagesCount: organization.$messagesCount ?? $messagesCount,
		$mlsDataMappingsCount: organization.$mlsDataMappingsCount ?? $mlsDataMappingsCount,
		$mlsListingEnhancementsCount: organization.$mlsListingEnhancementsCount ?? $mlsListingEnhancementsCount,
		$mobileDevicesCount: organization.$mobileDevicesCount ?? $mobileDevicesCount,
		$mortgageOffersCount: organization.$mortgageOffersCount ?? $mortgageOffersCount,
		$mortgagePreApprovalsCount: organization.$mortgagePreApprovalsCount ?? $mortgagePreApprovalsCount,
		$neighborhoodsCount: organization.$neighborhoodsCount ?? $neighborhoodsCount,
		$notificationsCount: organization.$notificationsCount ?? $notificationsCount,
		$offlineSyncQueuesCount: organization.$offlineSyncQueuesCount ?? $offlineSyncQueuesCount,
		$payoutsCount: organization.$payoutsCount ?? $payoutsCount,
		$performanceAlertsCount: organization.$performanceAlertsCount ?? $performanceAlertsCount,
		$predictiveModelsCount: organization.$predictiveModelsCount ?? $predictiveModelsCount,
		$projectsCount: organization.$projectsCount ?? $projectsCount,
		$propertiesCount: organization.$propertiesCount ?? $propertiesCount,
		$propertyAmenitiesCount: organization.$propertyAmenitiesCount ?? $propertyAmenitiesCount,
		$propertyComplianceCount: organization.$propertyComplianceCount ?? $propertyComplianceCount,
		$propertyDisclosuresCount: organization.$propertyDisclosuresCount ?? $propertyDisclosuresCount,
		$propertyDocumentsCount: organization.$propertyDocumentsCount ?? $propertyDocumentsCount,
		$inventoriesCount: organization.$inventoriesCount ?? $inventoriesCount,
		$propertyOffersCount: organization.$propertyOffersCount ?? $propertyOffersCount,
		$propertyPhotosCount: organization.$propertyPhotosCount ?? $propertyPhotosCount,
		$propertyViewingsCount: organization.$propertyViewingsCount ?? $propertyViewingsCount,
		$queueConfigurationsCount: organization.$queueConfigurationsCount ?? $queueConfigurationsCount,
		$queueMessagesCount: organization.$queueMessagesCount ?? $queueMessagesCount,
		$quotesCount: organization.$quotesCount ?? $quotesCount,
		$recommendationResultsCount: organization.$recommendationResultsCount ?? $recommendationResultsCount,
		$referralsCount: organization.$referralsCount ?? $referralsCount,
		$rentArrearsCount: organization.$rentArrearsCount ?? $rentArrearsCount,
		$rentSchedulesCount: organization.$rentSchedulesCount ?? $rentSchedulesCount,
		$rentalSyncJobsCount: organization.$rentalSyncJobsCount ?? $rentalSyncJobsCount,
		$reportsCount: organization.$reportsCount ?? $reportsCount,
		$reportExecutionsCount: organization.$reportExecutionsCount ?? $reportExecutionsCount,
		$reservationsCount: organization.$reservationsCount ?? $reservationsCount,
		$reviewsCount: organization.$reviewsCount ?? $reviewsCount,
		$rightToRentChecksCount: organization.$rightToRentChecksCount ?? $rightToRentChecksCount,
		$rolesCount: organization.$rolesCount ?? $rolesCount,
		$routesCount: organization.$routesCount ?? $routesCount,
		$securityDepositProtectionsCount: organization.$securityDepositProtectionsCount ?? $securityDepositProtectionsCount,
		$signatureRequestsCount: organization.$signatureRequestsCount ?? $signatureRequestsCount,
		$signatureSignersCount: organization.$signatureSignersCount ?? $signatureSignersCount,
		$solicitorManagementsCount: organization.$solicitorManagementsCount ?? $solicitorManagementsCount,
		$subscriptionsCount: organization.$subscriptionsCount ?? $subscriptionsCount,
		$systemMetricsCount: organization.$systemMetricsCount ?? $systemMetricsCount,
		$tagsCount: organization.$tagsCount ?? $tagsCount,
		$tasksCount: organization.$tasksCount ?? $tasksCount,
		$tax1099FormsCount: organization.$tax1099FormsCount ?? $tax1099FormsCount,
		$taxDepreciationsCount: organization.$taxDepreciationsCount ?? $taxDepreciationsCount,
		$taxRecordsCount: organization.$taxRecordsCount ?? $taxRecordsCount,
		$tenantApplicationsCount: organization.$tenantApplicationsCount ?? $tenantApplicationsCount,
		$userActivityLogsCount: organization.$userActivityLogsCount ?? $userActivityLogsCount,
		$userPreferencesCount: organization.$userPreferencesCount ?? $userPreferencesCount,
		$vacationRentalsCount: organization.$vacationRentalsCount ?? $vacationRentalsCount,
		$vendorsCount: organization.$vendorsCount ?? $vendorsCount,
		$virtualToursCount: organization.$virtualToursCount ?? $virtualToursCount,
		$webhooksCount: organization.$webhooksCount ?? $webhooksCount,
		$webhookDeliveriesCount: organization.$webhookDeliveriesCount ?? $webhookDeliveriesCount,
		$escrowAccountsCount: organization.$escrowAccountsCount ?? $escrowAccountsCount,
		$escrowReleasesCount: organization.$escrowReleasesCount ?? $escrowReleasesCount,
		$escrowDisputesCount: organization.$escrowDisputesCount ?? $escrowDisputesCount,
		$paymentNegotiationsCount: organization.$paymentNegotiationsCount ?? $paymentNegotiationsCount,
		$paymentInstallmentsCount: organization.$paymentInstallmentsCount ?? $paymentInstallmentsCount,
		$videoContentsCount: organization.$videoContentsCount ?? $videoContentsCount,
		$brandAmbassadorsCount: organization.$brandAmbassadorsCount ?? $brandAmbassadorsCount,
		$ambassadorCampaignsCount: organization.$ambassadorCampaignsCount ?? $ambassadorCampaignsCount,
		$socialImpactCountersCount: organization.$socialImpactCountersCount ?? $socialImpactCountersCount,
		$socialImpactRecordsCount: organization.$socialImpactRecordsCount ?? $socialImpactRecordsCount,
		$negotiationOffersCount: organization.$negotiationOffersCount ?? $negotiationOffersCount,
		$ambassadorContractsCount: organization.$ambassadorContractsCount ?? $ambassadorContractsCount,
		$escrowStatusHistoriesCount: organization.$escrowStatusHistoriesCount ?? $escrowStatusHistoriesCount,
		$aiChatMessagesCount: organization.$aiChatMessagesCount ?? $aiChatMessagesCount,
		$aiChatHandoffsCount: organization.$aiChatHandoffsCount ?? $aiChatHandoffsCount,
		$analysesCount: organization.$analysesCount ?? $analysesCount,
		$analysisJobsCount: organization.$analysisJobsCount ?? $analysisJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Organization mergeWithInstanceValues(Organization organization) {
        return Organization(
            id: organization.$assignedFields.contains('id') ? organization.id : id,
		name: organization.$assignedFields.contains('name') ? organization.name : name,
		type: organization.$assignedFields.contains('type') ? organization.type : type,
		region: organization.$assignedFields.contains('region') ? organization.region : region,
		defaultCurrency: organization.$assignedFields.contains('defaultCurrency') ? organization.defaultCurrency : defaultCurrency,
		defaultLocale: organization.$assignedFields.contains('defaultLocale') ? organization.defaultLocale : defaultLocale,
		legalName: organization.$assignedFields.contains('legalName') ? organization.legalName : legalName,
		taxId: organization.$assignedFields.contains('taxId') ? organization.taxId : taxId,
		address: organization.$assignedFields.contains('address') ? organization.address : address,
		contactEmail: organization.$assignedFields.contains('contactEmail') ? organization.contactEmail : contactEmail,
		managementFeeType: organization.$assignedFields.contains('managementFeeType') ? organization.managementFeeType : managementFeeType,
		managementFeeRate: organization.$assignedFields.contains('managementFeeRate') ? organization.managementFeeRate : managementFeeRate,
		managementFeeAmount: organization.$assignedFields.contains('managementFeeAmount') ? organization.managementFeeAmount : managementFeeAmount,
		managementFeeScope: organization.$assignedFields.contains('managementFeeScope') ? organization.managementFeeScope : managementFeeScope,
		taxReportingEnabled: organization.$assignedFields.contains('taxReportingEnabled') ? organization.taxReportingEnabled : taxReportingEnabled,
		complianceTracking: organization.$assignedFields.contains('complianceTracking') ? organization.complianceTracking : complianceTracking,
		requiredInspections: organization.$assignedFields.contains('requiredInspections') ? organization.requiredInspections : requiredInspections,
		createdAt: organization.$assignedFields.contains('createdAt') ? organization.createdAt : createdAt,
		updatedAt: organization.$assignedFields.contains('updatedAt') ? organization.updatedAt : updatedAt,
		deletedAt: organization.$assignedFields.contains('deletedAt') ? organization.deletedAt : deletedAt,
		aiChatbotSessions: (organization.$assignedFields.contains('aiChatbotSessions') && organization.aiChatbotSessions != null) ? mergeModelLists(aiChatbotSessions, organization.aiChatbotSessions) : aiChatbotSessions,
		aiFraudDetections: (organization.$assignedFields.contains('aiFraudDetections') && organization.aiFraudDetections != null) ? mergeModelLists(aiFraudDetections, organization.aiFraudDetections) : aiFraudDetections,
		aiImageAnalyses: (organization.$assignedFields.contains('aiImageAnalyses') && organization.aiImageAnalyses != null) ? mergeModelLists(aiImageAnalyses, organization.aiImageAnalyses) : aiImageAnalyses,
		aiInvestmentAnalyses: (organization.$assignedFields.contains('aiInvestmentAnalyses') && organization.aiInvestmentAnalyses != null) ? mergeModelLists(aiInvestmentAnalyses, organization.aiInvestmentAnalyses) : aiInvestmentAnalyses,
		aiLeadScores: (organization.$assignedFields.contains('aiLeadScores') && organization.aiLeadScores != null) ? mergeModelLists(aiLeadScores, organization.aiLeadScores) : aiLeadScores,
		aiLeadScoringModels: (organization.$assignedFields.contains('aiLeadScoringModels') && organization.aiLeadScoringModels != null) ? mergeModelLists(aiLeadScoringModels, organization.aiLeadScoringModels) : aiLeadScoringModels,
		aiMarketAnalyses: (organization.$assignedFields.contains('aiMarketAnalyses') && organization.aiMarketAnalyses != null) ? mergeModelLists(aiMarketAnalyses, organization.aiMarketAnalyses) : aiMarketAnalyses,
		aiModels: (organization.$assignedFields.contains('aiModels') && organization.aiModels != null) ? mergeModelLists(aiModels, organization.aiModels) : aiModels,
		aiModelDeployments: (organization.$assignedFields.contains('aiModelDeployments') && organization.aiModelDeployments != null) ? mergeModelLists(aiModelDeployments, organization.aiModelDeployments) : aiModelDeployments,
		aiPredictions: (organization.$assignedFields.contains('aiPredictions') && organization.aiPredictions != null) ? mergeModelLists(aiPredictions, organization.aiPredictions) : aiPredictions,
		aiPredictiveMaintenance: (organization.$assignedFields.contains('aiPredictiveMaintenance') && organization.aiPredictiveMaintenance != null) ? mergeModelLists(aiPredictiveMaintenance, organization.aiPredictiveMaintenance) : aiPredictiveMaintenance,
		aiPriceOptimizations: (organization.$assignedFields.contains('aiPriceOptimizations') && organization.aiPriceOptimizations != null) ? mergeModelLists(aiPriceOptimizations, organization.aiPriceOptimizations) : aiPriceOptimizations,
		aiPropertyDescriptions: (organization.$assignedFields.contains('aiPropertyDescriptions') && organization.aiPropertyDescriptions != null) ? mergeModelLists(aiPropertyDescriptions, organization.aiPropertyDescriptions) : aiPropertyDescriptions,
		aiPropertyValuations: (organization.$assignedFields.contains('aiPropertyValuations') && organization.aiPropertyValuations != null) ? mergeModelLists(aiPropertyValuations, organization.aiPropertyValuations) : aiPropertyValuations,
		aiRecommendations: (organization.$assignedFields.contains('aiRecommendations') && organization.aiRecommendations != null) ? mergeModelLists(aiRecommendations, organization.aiRecommendations) : aiRecommendations,
		aiSentimentAnalyses: (organization.$assignedFields.contains('aiSentimentAnalyses') && organization.aiSentimentAnalyses != null) ? mergeModelLists(aiSentimentAnalyses, organization.aiSentimentAnalyses) : aiSentimentAnalyses,
		aiTenantScreenings: (organization.$assignedFields.contains('aiTenantScreenings') && organization.aiTenantScreenings != null) ? mergeModelLists(aiTenantScreenings, organization.aiTenantScreenings) : aiTenantScreenings,
		aiValuationModels: (organization.$assignedFields.contains('aiValuationModels') && organization.aiValuationModels != null) ? mergeModelLists(aiValuationModels, organization.aiValuationModels) : aiValuationModels,
		integrations: (organization.$assignedFields.contains('integrations') && organization.integrations != null) ? mergeModelLists(integrations, organization.integrations) : integrations,
		achievements: (organization.$assignedFields.contains('achievements') && organization.achievements != null) ? mergeModelLists(achievements, organization.achievements) : achievements,
		agencies: (organization.$assignedFields.contains('agencies') && organization.agencies != null) ? mergeModelLists(agencies, organization.agencies) : agencies,
		agencyRelations: (organization.$assignedFields.contains('agencyRelations') && organization.agencyRelations != null) ? mergeModelLists(agencyRelations, organization.agencyRelations) : agencyRelations,
		organizationAgencies: (organization.$assignedFields.contains('organizationAgencies') && organization.organizationAgencies != null) ? mergeModelLists(organizationAgencies, organization.organizationAgencies) : organizationAgencies,
		agentAssignments: (organization.$assignedFields.contains('agentAssignments') && organization.agentAssignments != null) ? mergeModelLists(agentAssignments, organization.agentAssignments) : agentAssignments,
		agentTeams: (organization.$assignedFields.contains('agentTeams') && organization.agentTeams != null) ? mergeModelLists(agentTeams, organization.agentTeams) : agentTeams,
		amenities: (organization.$assignedFields.contains('amenities') && organization.amenities != null) ? mergeModelLists(amenities, organization.amenities) : amenities,
		apiIntegrations: (organization.$assignedFields.contains('apiIntegrations') && organization.apiIntegrations != null) ? mergeModelLists(apiIntegrations, organization.apiIntegrations) : apiIntegrations,
		apiKeys: (organization.$assignedFields.contains('apiKeys') && organization.apiKeys != null) ? mergeModelLists(apiKeys, organization.apiKeys) : apiKeys,
		appointments: (organization.$assignedFields.contains('appointments') && organization.appointments != null) ? mergeModelLists(appointments, organization.appointments) : appointments,
		attachments: (organization.$assignedFields.contains('attachments') && organization.attachments != null) ? mergeModelLists(attachments, organization.attachments) : attachments,
		attorneyCases: (organization.$assignedFields.contains('attorneyCases') && organization.attorneyCases != null) ? mergeModelLists(attorneyCases, organization.attorneyCases) : attorneyCases,
		auditLogs: (organization.$assignedFields.contains('auditLogs') && organization.auditLogs != null) ? mergeModelLists(auditLogs, organization.auditLogs) : auditLogs,
		automationExecutions: (organization.$assignedFields.contains('automationExecutions') && organization.automationExecutions != null) ? mergeModelLists(automationExecutions, organization.automationExecutions) : automationExecutions,
		automationRules: (organization.$assignedFields.contains('automationRules') && organization.automationRules != null) ? mergeModelLists(automationRules, organization.automationRules) : automationRules,
		bookings: (organization.$assignedFields.contains('bookings') && organization.bookings != null) ? mergeModelLists(bookings, organization.bookings) : bookings,
		budgets: (organization.$assignedFields.contains('budgets') && organization.budgets != null) ? mergeModelLists(budgets, organization.budgets) : budgets,
		calendarEvents: (organization.$assignedFields.contains('calendarEvents') && organization.calendarEvents != null) ? mergeModelLists(calendarEvents, organization.calendarEvents) : calendarEvents,
		commissions: (organization.$assignedFields.contains('commissions') && organization.commissions != null) ? mergeModelLists(commissions, organization.commissions) : commissions,
		communicationTemplates: (organization.$assignedFields.contains('communicationTemplates') && organization.communicationTemplates != null) ? mergeModelLists(communicationTemplates, organization.communicationTemplates) : communicationTemplates,
		contacts: (organization.$assignedFields.contains('contacts') && organization.contacts != null) ? mergeModelLists(contacts, organization.contacts) : contacts,
		contracts: (organization.$assignedFields.contains('contracts') && organization.contracts != null) ? mergeModelLists(contracts, organization.contracts) : contracts,
		contractVersions: (organization.$assignedFields.contains('contractVersions') && organization.contractVersions != null) ? mergeModelLists(contractVersions, organization.contractVersions) : contractVersions,
		dashboardConfigurations: (organization.$assignedFields.contains('dashboardConfigurations') && organization.dashboardConfigurations != null) ? mergeModelLists(dashboardConfigurations, organization.dashboardConfigurations) : dashboardConfigurations,
		dashboardWidgets: (organization.$assignedFields.contains('dashboardWidgets') && organization.dashboardWidgets != null) ? mergeModelLists(dashboardWidgets, organization.dashboardWidgets) : dashboardWidgets,
		deals: (organization.$assignedFields.contains('deals') && organization.deals != null) ? mergeModelLists(deals, organization.deals) : deals,
		depositProtections: (organization.$assignedFields.contains('depositProtections') && organization.depositProtections != null) ? mergeModelLists(depositProtections, organization.depositProtections) : depositProtections,
		documents: (organization.$assignedFields.contains('documents') && organization.documents != null) ? mergeModelLists(documents, organization.documents) : documents,
		documentTemplates: (organization.$assignedFields.contains('documentTemplates') && organization.documentTemplates != null) ? mergeModelLists(documentTemplates, organization.documentTemplates) : documentTemplates,
		earnings: (organization.$assignedFields.contains('earnings') && organization.earnings != null) ? mergeModelLists(earnings, organization.earnings) : earnings,
		events: (organization.$assignedFields.contains('events') && organization.events != null) ? mergeModelLists(events, organization.events) : events,
		eventAttendees: (organization.$assignedFields.contains('eventAttendees') && organization.eventAttendees != null) ? mergeModelLists(eventAttendees, organization.eventAttendees) : eventAttendees,
		exchangeRates: (organization.$assignedFields.contains('exchangeRates') && organization.exchangeRates != null) ? mergeModelLists(exchangeRates, organization.exchangeRates) : exchangeRates,
		exportFiles: (organization.$assignedFields.contains('exportFiles') && organization.exportFiles != null) ? mergeModelLists(exportFiles, organization.exportFiles) : exportFiles,
		exportJobs: (organization.$assignedFields.contains('exportJobs') && organization.exportJobs != null) ? mergeModelLists(exportJobs, organization.exportJobs) : exportJobs,
		externalRentalListings: (organization.$assignedFields.contains('externalRentalListings') && organization.externalRentalListings != null) ? mergeModelLists(externalRentalListings, organization.externalRentalListings) : externalRentalListings,
		facilities: (organization.$assignedFields.contains('facilities') && organization.facilities != null) ? mergeModelLists(facilities, organization.facilities) : facilities,
		financialRecords: (organization.$assignedFields.contains('financialRecords') && organization.financialRecords != null) ? mergeModelLists(financialRecords, organization.financialRecords) : financialRecords,
		floorPlans: (organization.$assignedFields.contains('floorPlans') && organization.floorPlans != null) ? mergeModelLists(floorPlans, organization.floorPlans) : floorPlans,
		giftCards: (organization.$assignedFields.contains('giftCards') && organization.giftCards != null) ? mergeModelLists(giftCards, organization.giftCards) : giftCards,
		govtIntegrations: (organization.$assignedFields.contains('govtIntegrations') && organization.govtIntegrations != null) ? mergeModelLists(govtIntegrations, organization.govtIntegrations) : govtIntegrations,
		healthChecks: (organization.$assignedFields.contains('healthChecks') && organization.healthChecks != null) ? mergeModelLists(healthChecks, organization.healthChecks) : healthChecks,
		homeInformationPacks: (organization.$assignedFields.contains('homeInformationPacks') && organization.homeInformationPacks != null) ? mergeModelLists(homeInformationPacks, organization.homeInformationPacks) : homeInformationPacks,
		immigrationStatusChecks: (organization.$assignedFields.contains('immigrationStatusChecks') && organization.immigrationStatusChecks != null) ? mergeModelLists(immigrationStatusChecks, organization.immigrationStatusChecks) : immigrationStatusChecks,
		integrationLogs: (organization.$assignedFields.contains('integrationLogs') && organization.integrationLogs != null) ? mergeModelLists(integrationLogs, organization.integrationLogs) : integrationLogs,
		investorPortfolios: (organization.$assignedFields.contains('investorPortfolios') && organization.investorPortfolios != null) ? mergeModelLists(investorPortfolios, organization.investorPortfolios) : investorPortfolios,
		keys: (organization.$assignedFields.contains('keys') && organization.keys != null) ? mergeModelLists(keys, organization.keys) : keys,
		leads: (organization.$assignedFields.contains('leads') && organization.leads != null) ? mergeModelLists(leads, organization.leads) : leads,
		leadSources: (organization.$assignedFields.contains('leadSources') && organization.leadSources != null) ? mergeModelLists(leadSources, organization.leadSources) : leadSources,
		leases: (organization.$assignedFields.contains('leases') && organization.leases != null) ? mergeModelLists(leases, organization.leases) : leases,
		leaseRenewals: (organization.$assignedFields.contains('leaseRenewals') && organization.leaseRenewals != null) ? mergeModelLists(leaseRenewals, organization.leaseRenewals) : leaseRenewals,
		ledgerEntries: (organization.$assignedFields.contains('ledgerEntries') && organization.ledgerEntries != null) ? mergeModelLists(ledgerEntries, organization.ledgerEntries) : ledgerEntries,
		listings: (organization.$assignedFields.contains('listings') && organization.listings != null) ? mergeModelLists(listings, organization.listings) : listings,
		listingChannels: (organization.$assignedFields.contains('listingChannels') && organization.listingChannels != null) ? mergeModelLists(listingChannels, organization.listingChannels) : listingChannels,
		listingStatusHistories: (organization.$assignedFields.contains('listingStatusHistories') && organization.listingStatusHistories != null) ? mergeModelLists(listingStatusHistories, organization.listingStatusHistories) : listingStatusHistories,
		listingTags: (organization.$assignedFields.contains('listingTags') && organization.listingTags != null) ? mergeModelLists(listingTags, organization.listingTags) : listingTags,
		locations: (organization.$assignedFields.contains('locations') && organization.locations != null) ? mergeModelLists(locations, organization.locations) : locations,
		loyaltyAccounts: (organization.$assignedFields.contains('loyaltyAccounts') && organization.loyaltyAccounts != null) ? mergeModelLists(loyaltyAccounts, organization.loyaltyAccounts) : loyaltyAccounts,
		mlsConnections: (organization.$assignedFields.contains('mlsConnections') && organization.mlsConnections != null) ? mergeModelLists(mlsConnections, organization.mlsConnections) : mlsConnections,
		mlsexternalListings: (organization.$assignedFields.contains('mlsexternalListings') && organization.mlsexternalListings != null) ? mergeModelLists(mlsexternalListings, organization.mlsexternalListings) : mlsexternalListings,
		mlssyncJobs: (organization.$assignedFields.contains('mlssyncJobs') && organization.mlssyncJobs != null) ? mergeModelLists(mlssyncJobs, organization.mlssyncJobs) : mlssyncJobs,
		maintenanceBlocks: (organization.$assignedFields.contains('maintenanceBlocks') && organization.maintenanceBlocks != null) ? mergeModelLists(maintenanceBlocks, organization.maintenanceBlocks) : maintenanceBlocks,
		workOrders: (organization.$assignedFields.contains('workOrders') && organization.workOrders != null) ? mergeModelLists(workOrders, organization.workOrders) : workOrders,
		mapLayers: (organization.$assignedFields.contains('mapLayers') && organization.mapLayers != null) ? mergeModelLists(mapLayers, organization.mapLayers) : mapLayers,
		marketingCampaigns: (organization.$assignedFields.contains('marketingCampaigns') && organization.marketingCampaigns != null) ? mergeModelLists(marketingCampaigns, organization.marketingCampaigns) : marketingCampaigns,
		messages: (organization.$assignedFields.contains('messages') && organization.messages != null) ? mergeModelLists(messages, organization.messages) : messages,
		mlsDataMappings: (organization.$assignedFields.contains('mlsDataMappings') && organization.mlsDataMappings != null) ? mergeModelLists(mlsDataMappings, organization.mlsDataMappings) : mlsDataMappings,
		mlsListingEnhancements: (organization.$assignedFields.contains('mlsListingEnhancements') && organization.mlsListingEnhancements != null) ? mergeModelLists(mlsListingEnhancements, organization.mlsListingEnhancements) : mlsListingEnhancements,
		mobileDevices: (organization.$assignedFields.contains('mobileDevices') && organization.mobileDevices != null) ? mergeModelLists(mobileDevices, organization.mobileDevices) : mobileDevices,
		mortgageOffers: (organization.$assignedFields.contains('mortgageOffers') && organization.mortgageOffers != null) ? mergeModelLists(mortgageOffers, organization.mortgageOffers) : mortgageOffers,
		mortgagePreApprovals: (organization.$assignedFields.contains('mortgagePreApprovals') && organization.mortgagePreApprovals != null) ? mergeModelLists(mortgagePreApprovals, organization.mortgagePreApprovals) : mortgagePreApprovals,
		neighborhoods: (organization.$assignedFields.contains('neighborhoods') && organization.neighborhoods != null) ? mergeModelLists(neighborhoods, organization.neighborhoods) : neighborhoods,
		notifications: (organization.$assignedFields.contains('notifications') && organization.notifications != null) ? mergeModelLists(notifications, organization.notifications) : notifications,
		offlineSyncQueues: (organization.$assignedFields.contains('offlineSyncQueues') && organization.offlineSyncQueues != null) ? mergeModelLists(offlineSyncQueues, organization.offlineSyncQueues) : offlineSyncQueues,
		orgSubscription: organization.$assignedFields.contains('orgSubscription') ? organization.orgSubscription : orgSubscription,
		payouts: (organization.$assignedFields.contains('payouts') && organization.payouts != null) ? mergeModelLists(payouts, organization.payouts) : payouts,
		performanceAlerts: (organization.$assignedFields.contains('performanceAlerts') && organization.performanceAlerts != null) ? mergeModelLists(performanceAlerts, organization.performanceAlerts) : performanceAlerts,
		predictiveModels: (organization.$assignedFields.contains('predictiveModels') && organization.predictiveModels != null) ? mergeModelLists(predictiveModels, organization.predictiveModels) : predictiveModels,
		projects: (organization.$assignedFields.contains('projects') && organization.projects != null) ? mergeModelLists(projects, organization.projects) : projects,
		properties: (organization.$assignedFields.contains('properties') && organization.properties != null) ? mergeModelLists(properties, organization.properties) : properties,
		propertyAmenities: (organization.$assignedFields.contains('propertyAmenities') && organization.propertyAmenities != null) ? mergeModelLists(propertyAmenities, organization.propertyAmenities) : propertyAmenities,
		propertyCompliance: (organization.$assignedFields.contains('propertyCompliance') && organization.propertyCompliance != null) ? mergeModelLists(propertyCompliance, organization.propertyCompliance) : propertyCompliance,
		propertyDisclosures: (organization.$assignedFields.contains('propertyDisclosures') && organization.propertyDisclosures != null) ? mergeModelLists(propertyDisclosures, organization.propertyDisclosures) : propertyDisclosures,
		propertyDocuments: (organization.$assignedFields.contains('propertyDocuments') && organization.propertyDocuments != null) ? mergeModelLists(propertyDocuments, organization.propertyDocuments) : propertyDocuments,
		inventories: (organization.$assignedFields.contains('inventories') && organization.inventories != null) ? mergeModelLists(inventories, organization.inventories) : inventories,
		propertyOffers: (organization.$assignedFields.contains('propertyOffers') && organization.propertyOffers != null) ? mergeModelLists(propertyOffers, organization.propertyOffers) : propertyOffers,
		propertyPhotos: (organization.$assignedFields.contains('propertyPhotos') && organization.propertyPhotos != null) ? mergeModelLists(propertyPhotos, organization.propertyPhotos) : propertyPhotos,
		propertyViewings: (organization.$assignedFields.contains('propertyViewings') && organization.propertyViewings != null) ? mergeModelLists(propertyViewings, organization.propertyViewings) : propertyViewings,
		queueConfigurations: (organization.$assignedFields.contains('queueConfigurations') && organization.queueConfigurations != null) ? mergeModelLists(queueConfigurations, organization.queueConfigurations) : queueConfigurations,
		queueMessages: (organization.$assignedFields.contains('queueMessages') && organization.queueMessages != null) ? mergeModelLists(queueMessages, organization.queueMessages) : queueMessages,
		quotes: (organization.$assignedFields.contains('quotes') && organization.quotes != null) ? mergeModelLists(quotes, organization.quotes) : quotes,
		recommendationResults: (organization.$assignedFields.contains('recommendationResults') && organization.recommendationResults != null) ? mergeModelLists(recommendationResults, organization.recommendationResults) : recommendationResults,
		referrals: (organization.$assignedFields.contains('referrals') && organization.referrals != null) ? mergeModelLists(referrals, organization.referrals) : referrals,
		rentArrears: (organization.$assignedFields.contains('rentArrears') && organization.rentArrears != null) ? mergeModelLists(rentArrears, organization.rentArrears) : rentArrears,
		rentSchedules: (organization.$assignedFields.contains('rentSchedules') && organization.rentSchedules != null) ? mergeModelLists(rentSchedules, organization.rentSchedules) : rentSchedules,
		rentalSyncJobs: (organization.$assignedFields.contains('rentalSyncJobs') && organization.rentalSyncJobs != null) ? mergeModelLists(rentalSyncJobs, organization.rentalSyncJobs) : rentalSyncJobs,
		reports: (organization.$assignedFields.contains('reports') && organization.reports != null) ? mergeModelLists(reports, organization.reports) : reports,
		reportExecutions: (organization.$assignedFields.contains('reportExecutions') && organization.reportExecutions != null) ? mergeModelLists(reportExecutions, organization.reportExecutions) : reportExecutions,
		reservations: (organization.$assignedFields.contains('reservations') && organization.reservations != null) ? mergeModelLists(reservations, organization.reservations) : reservations,
		reviews: (organization.$assignedFields.contains('reviews') && organization.reviews != null) ? mergeModelLists(reviews, organization.reviews) : reviews,
		rightToRentChecks: (organization.$assignedFields.contains('rightToRentChecks') && organization.rightToRentChecks != null) ? mergeModelLists(rightToRentChecks, organization.rightToRentChecks) : rightToRentChecks,
		roles: (organization.$assignedFields.contains('roles') && organization.roles != null) ? mergeModelLists(roles, organization.roles) : roles,
		routes: (organization.$assignedFields.contains('routes') && organization.routes != null) ? mergeModelLists(routes, organization.routes) : routes,
		securityDepositProtections: (organization.$assignedFields.contains('securityDepositProtections') && organization.securityDepositProtections != null) ? mergeModelLists(securityDepositProtections, organization.securityDepositProtections) : securityDepositProtections,
		signatureRequests: (organization.$assignedFields.contains('signatureRequests') && organization.signatureRequests != null) ? mergeModelLists(signatureRequests, organization.signatureRequests) : signatureRequests,
		signatureSigners: (organization.$assignedFields.contains('signatureSigners') && organization.signatureSigners != null) ? mergeModelLists(signatureSigners, organization.signatureSigners) : signatureSigners,
		solicitorManagements: (organization.$assignedFields.contains('solicitorManagements') && organization.solicitorManagements != null) ? mergeModelLists(solicitorManagements, organization.solicitorManagements) : solicitorManagements,
		subscriptions: (organization.$assignedFields.contains('subscriptions') && organization.subscriptions != null) ? mergeModelLists(subscriptions, organization.subscriptions) : subscriptions,
		systemMetrics: (organization.$assignedFields.contains('systemMetrics') && organization.systemMetrics != null) ? mergeModelLists(systemMetrics, organization.systemMetrics) : systemMetrics,
		tags: (organization.$assignedFields.contains('tags') && organization.tags != null) ? mergeModelLists(tags, organization.tags) : tags,
		tasks: (organization.$assignedFields.contains('tasks') && organization.tasks != null) ? mergeModelLists(tasks, organization.tasks) : tasks,
		tax1099Forms: (organization.$assignedFields.contains('tax1099Forms') && organization.tax1099Forms != null) ? mergeModelLists(tax1099Forms, organization.tax1099Forms) : tax1099Forms,
		taxDepreciations: (organization.$assignedFields.contains('taxDepreciations') && organization.taxDepreciations != null) ? mergeModelLists(taxDepreciations, organization.taxDepreciations) : taxDepreciations,
		taxRecords: (organization.$assignedFields.contains('taxRecords') && organization.taxRecords != null) ? mergeModelLists(taxRecords, organization.taxRecords) : taxRecords,
		tenantApplications: (organization.$assignedFields.contains('tenantApplications') && organization.tenantApplications != null) ? mergeModelLists(tenantApplications, organization.tenantApplications) : tenantApplications,
		userActivityLogs: (organization.$assignedFields.contains('userActivityLogs') && organization.userActivityLogs != null) ? mergeModelLists(userActivityLogs, organization.userActivityLogs) : userActivityLogs,
		userPreferences: (organization.$assignedFields.contains('userPreferences') && organization.userPreferences != null) ? mergeModelLists(userPreferences, organization.userPreferences) : userPreferences,
		vacationRentals: (organization.$assignedFields.contains('vacationRentals') && organization.vacationRentals != null) ? mergeModelLists(vacationRentals, organization.vacationRentals) : vacationRentals,
		vendors: (organization.$assignedFields.contains('vendors') && organization.vendors != null) ? mergeModelLists(vendors, organization.vendors) : vendors,
		virtualTours: (organization.$assignedFields.contains('virtualTours') && organization.virtualTours != null) ? mergeModelLists(virtualTours, organization.virtualTours) : virtualTours,
		webhooks: (organization.$assignedFields.contains('webhooks') && organization.webhooks != null) ? mergeModelLists(webhooks, organization.webhooks) : webhooks,
		webhookDeliveries: (organization.$assignedFields.contains('webhookDeliveries') && organization.webhookDeliveries != null) ? mergeModelLists(webhookDeliveries, organization.webhookDeliveries) : webhookDeliveries,
		escrowAccounts: (organization.$assignedFields.contains('escrowAccounts') && organization.escrowAccounts != null) ? mergeModelLists(escrowAccounts, organization.escrowAccounts) : escrowAccounts,
		escrowReleases: (organization.$assignedFields.contains('escrowReleases') && organization.escrowReleases != null) ? mergeModelLists(escrowReleases, organization.escrowReleases) : escrowReleases,
		escrowDisputes: (organization.$assignedFields.contains('escrowDisputes') && organization.escrowDisputes != null) ? mergeModelLists(escrowDisputes, organization.escrowDisputes) : escrowDisputes,
		paymentNegotiations: (organization.$assignedFields.contains('paymentNegotiations') && organization.paymentNegotiations != null) ? mergeModelLists(paymentNegotiations, organization.paymentNegotiations) : paymentNegotiations,
		paymentInstallments: (organization.$assignedFields.contains('paymentInstallments') && organization.paymentInstallments != null) ? mergeModelLists(paymentInstallments, organization.paymentInstallments) : paymentInstallments,
		videoContents: (organization.$assignedFields.contains('videoContents') && organization.videoContents != null) ? mergeModelLists(videoContents, organization.videoContents) : videoContents,
		brandAmbassadors: (organization.$assignedFields.contains('brandAmbassadors') && organization.brandAmbassadors != null) ? mergeModelLists(brandAmbassadors, organization.brandAmbassadors) : brandAmbassadors,
		ambassadorCampaigns: (organization.$assignedFields.contains('ambassadorCampaigns') && organization.ambassadorCampaigns != null) ? mergeModelLists(ambassadorCampaigns, organization.ambassadorCampaigns) : ambassadorCampaigns,
		socialImpactCounters: (organization.$assignedFields.contains('socialImpactCounters') && organization.socialImpactCounters != null) ? mergeModelLists(socialImpactCounters, organization.socialImpactCounters) : socialImpactCounters,
		socialImpactRecords: (organization.$assignedFields.contains('socialImpactRecords') && organization.socialImpactRecords != null) ? mergeModelLists(socialImpactRecords, organization.socialImpactRecords) : socialImpactRecords,
		negotiationOffers: (organization.$assignedFields.contains('negotiationOffers') && organization.negotiationOffers != null) ? mergeModelLists(negotiationOffers, organization.negotiationOffers) : negotiationOffers,
		ambassadorContracts: (organization.$assignedFields.contains('ambassadorContracts') && organization.ambassadorContracts != null) ? mergeModelLists(ambassadorContracts, organization.ambassadorContracts) : ambassadorContracts,
		escrowStatusHistories: (organization.$assignedFields.contains('escrowStatusHistories') && organization.escrowStatusHistories != null) ? mergeModelLists(escrowStatusHistories, organization.escrowStatusHistories) : escrowStatusHistories,
		aiChatMessages: (organization.$assignedFields.contains('aiChatMessages') && organization.aiChatMessages != null) ? mergeModelLists(aiChatMessages, organization.aiChatMessages) : aiChatMessages,
		aiChatHandoffs: (organization.$assignedFields.contains('aiChatHandoffs') && organization.aiChatHandoffs != null) ? mergeModelLists(aiChatHandoffs, organization.aiChatHandoffs) : aiChatHandoffs,
		analyses: (organization.$assignedFields.contains('analyses') && organization.analyses != null) ? mergeModelLists(analyses, organization.analyses) : analyses,
		analysisJobs: (organization.$assignedFields.contains('analysisJobs') && organization.analysisJobs != null) ? mergeModelLists(analysisJobs, organization.analysisJobs) : analysisJobs,
		$requiredInspectionsCount: organization.$requiredInspectionsCount ?? $requiredInspectionsCount,
		$aiChatbotSessionsCount: organization.$aiChatbotSessionsCount ?? $aiChatbotSessionsCount,
		$aiFraudDetectionsCount: organization.$aiFraudDetectionsCount ?? $aiFraudDetectionsCount,
		$aiImageAnalysesCount: organization.$aiImageAnalysesCount ?? $aiImageAnalysesCount,
		$aiInvestmentAnalysesCount: organization.$aiInvestmentAnalysesCount ?? $aiInvestmentAnalysesCount,
		$aiLeadScoresCount: organization.$aiLeadScoresCount ?? $aiLeadScoresCount,
		$aiLeadScoringModelsCount: organization.$aiLeadScoringModelsCount ?? $aiLeadScoringModelsCount,
		$aiMarketAnalysesCount: organization.$aiMarketAnalysesCount ?? $aiMarketAnalysesCount,
		$aiModelsCount: organization.$aiModelsCount ?? $aiModelsCount,
		$aiModelDeploymentsCount: organization.$aiModelDeploymentsCount ?? $aiModelDeploymentsCount,
		$aiPredictionsCount: organization.$aiPredictionsCount ?? $aiPredictionsCount,
		$aiPredictiveMaintenanceCount: organization.$aiPredictiveMaintenanceCount ?? $aiPredictiveMaintenanceCount,
		$aiPriceOptimizationsCount: organization.$aiPriceOptimizationsCount ?? $aiPriceOptimizationsCount,
		$aiPropertyDescriptionsCount: organization.$aiPropertyDescriptionsCount ?? $aiPropertyDescriptionsCount,
		$aiPropertyValuationsCount: organization.$aiPropertyValuationsCount ?? $aiPropertyValuationsCount,
		$aiRecommendationsCount: organization.$aiRecommendationsCount ?? $aiRecommendationsCount,
		$aiSentimentAnalysesCount: organization.$aiSentimentAnalysesCount ?? $aiSentimentAnalysesCount,
		$aiTenantScreeningsCount: organization.$aiTenantScreeningsCount ?? $aiTenantScreeningsCount,
		$aiValuationModelsCount: organization.$aiValuationModelsCount ?? $aiValuationModelsCount,
		$integrationsCount: organization.$integrationsCount ?? $integrationsCount,
		$achievementsCount: organization.$achievementsCount ?? $achievementsCount,
		$agenciesCount: organization.$agenciesCount ?? $agenciesCount,
		$agencyRelationsCount: organization.$agencyRelationsCount ?? $agencyRelationsCount,
		$organizationAgenciesCount: organization.$organizationAgenciesCount ?? $organizationAgenciesCount,
		$agentAssignmentsCount: organization.$agentAssignmentsCount ?? $agentAssignmentsCount,
		$agentTeamsCount: organization.$agentTeamsCount ?? $agentTeamsCount,
		$amenitiesCount: organization.$amenitiesCount ?? $amenitiesCount,
		$apiIntegrationsCount: organization.$apiIntegrationsCount ?? $apiIntegrationsCount,
		$apiKeysCount: organization.$apiKeysCount ?? $apiKeysCount,
		$appointmentsCount: organization.$appointmentsCount ?? $appointmentsCount,
		$attachmentsCount: organization.$attachmentsCount ?? $attachmentsCount,
		$attorneyCasesCount: organization.$attorneyCasesCount ?? $attorneyCasesCount,
		$auditLogsCount: organization.$auditLogsCount ?? $auditLogsCount,
		$automationExecutionsCount: organization.$automationExecutionsCount ?? $automationExecutionsCount,
		$automationRulesCount: organization.$automationRulesCount ?? $automationRulesCount,
		$bookingsCount: organization.$bookingsCount ?? $bookingsCount,
		$budgetsCount: organization.$budgetsCount ?? $budgetsCount,
		$calendarEventsCount: organization.$calendarEventsCount ?? $calendarEventsCount,
		$commissionsCount: organization.$commissionsCount ?? $commissionsCount,
		$communicationTemplatesCount: organization.$communicationTemplatesCount ?? $communicationTemplatesCount,
		$contactsCount: organization.$contactsCount ?? $contactsCount,
		$contractsCount: organization.$contractsCount ?? $contractsCount,
		$contractVersionsCount: organization.$contractVersionsCount ?? $contractVersionsCount,
		$dashboardConfigurationsCount: organization.$dashboardConfigurationsCount ?? $dashboardConfigurationsCount,
		$dashboardWidgetsCount: organization.$dashboardWidgetsCount ?? $dashboardWidgetsCount,
		$dealsCount: organization.$dealsCount ?? $dealsCount,
		$depositProtectionsCount: organization.$depositProtectionsCount ?? $depositProtectionsCount,
		$documentsCount: organization.$documentsCount ?? $documentsCount,
		$documentTemplatesCount: organization.$documentTemplatesCount ?? $documentTemplatesCount,
		$earningsCount: organization.$earningsCount ?? $earningsCount,
		$eventsCount: organization.$eventsCount ?? $eventsCount,
		$eventAttendeesCount: organization.$eventAttendeesCount ?? $eventAttendeesCount,
		$exchangeRatesCount: organization.$exchangeRatesCount ?? $exchangeRatesCount,
		$exportFilesCount: organization.$exportFilesCount ?? $exportFilesCount,
		$exportJobsCount: organization.$exportJobsCount ?? $exportJobsCount,
		$externalRentalListingsCount: organization.$externalRentalListingsCount ?? $externalRentalListingsCount,
		$facilitiesCount: organization.$facilitiesCount ?? $facilitiesCount,
		$financialRecordsCount: organization.$financialRecordsCount ?? $financialRecordsCount,
		$floorPlansCount: organization.$floorPlansCount ?? $floorPlansCount,
		$giftCardsCount: organization.$giftCardsCount ?? $giftCardsCount,
		$govtIntegrationsCount: organization.$govtIntegrationsCount ?? $govtIntegrationsCount,
		$healthChecksCount: organization.$healthChecksCount ?? $healthChecksCount,
		$homeInformationPacksCount: organization.$homeInformationPacksCount ?? $homeInformationPacksCount,
		$immigrationStatusChecksCount: organization.$immigrationStatusChecksCount ?? $immigrationStatusChecksCount,
		$integrationLogsCount: organization.$integrationLogsCount ?? $integrationLogsCount,
		$investorPortfoliosCount: organization.$investorPortfoliosCount ?? $investorPortfoliosCount,
		$keysCount: organization.$keysCount ?? $keysCount,
		$leadsCount: organization.$leadsCount ?? $leadsCount,
		$leadSourcesCount: organization.$leadSourcesCount ?? $leadSourcesCount,
		$leasesCount: organization.$leasesCount ?? $leasesCount,
		$leaseRenewalsCount: organization.$leaseRenewalsCount ?? $leaseRenewalsCount,
		$ledgerEntriesCount: organization.$ledgerEntriesCount ?? $ledgerEntriesCount,
		$listingsCount: organization.$listingsCount ?? $listingsCount,
		$listingChannelsCount: organization.$listingChannelsCount ?? $listingChannelsCount,
		$listingStatusHistoriesCount: organization.$listingStatusHistoriesCount ?? $listingStatusHistoriesCount,
		$listingTagsCount: organization.$listingTagsCount ?? $listingTagsCount,
		$locationsCount: organization.$locationsCount ?? $locationsCount,
		$loyaltyAccountsCount: organization.$loyaltyAccountsCount ?? $loyaltyAccountsCount,
		$mlsConnectionsCount: organization.$mlsConnectionsCount ?? $mlsConnectionsCount,
		$mlsexternalListingsCount: organization.$mlsexternalListingsCount ?? $mlsexternalListingsCount,
		$mlssyncJobsCount: organization.$mlssyncJobsCount ?? $mlssyncJobsCount,
		$maintenanceBlocksCount: organization.$maintenanceBlocksCount ?? $maintenanceBlocksCount,
		$workOrdersCount: organization.$workOrdersCount ?? $workOrdersCount,
		$mapLayersCount: organization.$mapLayersCount ?? $mapLayersCount,
		$marketingCampaignsCount: organization.$marketingCampaignsCount ?? $marketingCampaignsCount,
		$messagesCount: organization.$messagesCount ?? $messagesCount,
		$mlsDataMappingsCount: organization.$mlsDataMappingsCount ?? $mlsDataMappingsCount,
		$mlsListingEnhancementsCount: organization.$mlsListingEnhancementsCount ?? $mlsListingEnhancementsCount,
		$mobileDevicesCount: organization.$mobileDevicesCount ?? $mobileDevicesCount,
		$mortgageOffersCount: organization.$mortgageOffersCount ?? $mortgageOffersCount,
		$mortgagePreApprovalsCount: organization.$mortgagePreApprovalsCount ?? $mortgagePreApprovalsCount,
		$neighborhoodsCount: organization.$neighborhoodsCount ?? $neighborhoodsCount,
		$notificationsCount: organization.$notificationsCount ?? $notificationsCount,
		$offlineSyncQueuesCount: organization.$offlineSyncQueuesCount ?? $offlineSyncQueuesCount,
		$payoutsCount: organization.$payoutsCount ?? $payoutsCount,
		$performanceAlertsCount: organization.$performanceAlertsCount ?? $performanceAlertsCount,
		$predictiveModelsCount: organization.$predictiveModelsCount ?? $predictiveModelsCount,
		$projectsCount: organization.$projectsCount ?? $projectsCount,
		$propertiesCount: organization.$propertiesCount ?? $propertiesCount,
		$propertyAmenitiesCount: organization.$propertyAmenitiesCount ?? $propertyAmenitiesCount,
		$propertyComplianceCount: organization.$propertyComplianceCount ?? $propertyComplianceCount,
		$propertyDisclosuresCount: organization.$propertyDisclosuresCount ?? $propertyDisclosuresCount,
		$propertyDocumentsCount: organization.$propertyDocumentsCount ?? $propertyDocumentsCount,
		$inventoriesCount: organization.$inventoriesCount ?? $inventoriesCount,
		$propertyOffersCount: organization.$propertyOffersCount ?? $propertyOffersCount,
		$propertyPhotosCount: organization.$propertyPhotosCount ?? $propertyPhotosCount,
		$propertyViewingsCount: organization.$propertyViewingsCount ?? $propertyViewingsCount,
		$queueConfigurationsCount: organization.$queueConfigurationsCount ?? $queueConfigurationsCount,
		$queueMessagesCount: organization.$queueMessagesCount ?? $queueMessagesCount,
		$quotesCount: organization.$quotesCount ?? $quotesCount,
		$recommendationResultsCount: organization.$recommendationResultsCount ?? $recommendationResultsCount,
		$referralsCount: organization.$referralsCount ?? $referralsCount,
		$rentArrearsCount: organization.$rentArrearsCount ?? $rentArrearsCount,
		$rentSchedulesCount: organization.$rentSchedulesCount ?? $rentSchedulesCount,
		$rentalSyncJobsCount: organization.$rentalSyncJobsCount ?? $rentalSyncJobsCount,
		$reportsCount: organization.$reportsCount ?? $reportsCount,
		$reportExecutionsCount: organization.$reportExecutionsCount ?? $reportExecutionsCount,
		$reservationsCount: organization.$reservationsCount ?? $reservationsCount,
		$reviewsCount: organization.$reviewsCount ?? $reviewsCount,
		$rightToRentChecksCount: organization.$rightToRentChecksCount ?? $rightToRentChecksCount,
		$rolesCount: organization.$rolesCount ?? $rolesCount,
		$routesCount: organization.$routesCount ?? $routesCount,
		$securityDepositProtectionsCount: organization.$securityDepositProtectionsCount ?? $securityDepositProtectionsCount,
		$signatureRequestsCount: organization.$signatureRequestsCount ?? $signatureRequestsCount,
		$signatureSignersCount: organization.$signatureSignersCount ?? $signatureSignersCount,
		$solicitorManagementsCount: organization.$solicitorManagementsCount ?? $solicitorManagementsCount,
		$subscriptionsCount: organization.$subscriptionsCount ?? $subscriptionsCount,
		$systemMetricsCount: organization.$systemMetricsCount ?? $systemMetricsCount,
		$tagsCount: organization.$tagsCount ?? $tagsCount,
		$tasksCount: organization.$tasksCount ?? $tasksCount,
		$tax1099FormsCount: organization.$tax1099FormsCount ?? $tax1099FormsCount,
		$taxDepreciationsCount: organization.$taxDepreciationsCount ?? $taxDepreciationsCount,
		$taxRecordsCount: organization.$taxRecordsCount ?? $taxRecordsCount,
		$tenantApplicationsCount: organization.$tenantApplicationsCount ?? $tenantApplicationsCount,
		$userActivityLogsCount: organization.$userActivityLogsCount ?? $userActivityLogsCount,
		$userPreferencesCount: organization.$userPreferencesCount ?? $userPreferencesCount,
		$vacationRentalsCount: organization.$vacationRentalsCount ?? $vacationRentalsCount,
		$vendorsCount: organization.$vendorsCount ?? $vendorsCount,
		$virtualToursCount: organization.$virtualToursCount ?? $virtualToursCount,
		$webhooksCount: organization.$webhooksCount ?? $webhooksCount,
		$webhookDeliveriesCount: organization.$webhookDeliveriesCount ?? $webhookDeliveriesCount,
		$escrowAccountsCount: organization.$escrowAccountsCount ?? $escrowAccountsCount,
		$escrowReleasesCount: organization.$escrowReleasesCount ?? $escrowReleasesCount,
		$escrowDisputesCount: organization.$escrowDisputesCount ?? $escrowDisputesCount,
		$paymentNegotiationsCount: organization.$paymentNegotiationsCount ?? $paymentNegotiationsCount,
		$paymentInstallmentsCount: organization.$paymentInstallmentsCount ?? $paymentInstallmentsCount,
		$videoContentsCount: organization.$videoContentsCount ?? $videoContentsCount,
		$brandAmbassadorsCount: organization.$brandAmbassadorsCount ?? $brandAmbassadorsCount,
		$ambassadorCampaignsCount: organization.$ambassadorCampaignsCount ?? $ambassadorCampaignsCount,
		$socialImpactCountersCount: organization.$socialImpactCountersCount ?? $socialImpactCountersCount,
		$socialImpactRecordsCount: organization.$socialImpactRecordsCount ?? $socialImpactRecordsCount,
		$negotiationOffersCount: organization.$negotiationOffersCount ?? $negotiationOffersCount,
		$ambassadorContractsCount: organization.$ambassadorContractsCount ?? $ambassadorContractsCount,
		$escrowStatusHistoriesCount: organization.$escrowStatusHistoriesCount ?? $escrowStatusHistoriesCount,
		$aiChatMessagesCount: organization.$aiChatMessagesCount ?? $aiChatMessagesCount,
		$aiChatHandoffsCount: organization.$aiChatHandoffsCount ?? $aiChatHandoffsCount,
		$analysesCount: organization.$analysesCount ?? $analysesCount,
		$analysisJobsCount: organization.$analysisJobsCount ?? $analysisJobsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Organization updateWithInstanceValues(Organization organization) {
        if (organization.$assignedFields.contains('id')) { id = organization.id; }
		if (organization.$assignedFields.contains('name')) { name = organization.name; }
		if (organization.$assignedFields.contains('type')) { type = organization.type; }
		if (organization.$assignedFields.contains('region')) { region = organization.region; }
		if (organization.$assignedFields.contains('defaultCurrency')) { defaultCurrency = organization.defaultCurrency; }
		if (organization.$assignedFields.contains('defaultLocale')) { defaultLocale = organization.defaultLocale; }
		if (organization.$assignedFields.contains('legalName')) { legalName = organization.legalName; }
		if (organization.$assignedFields.contains('taxId')) { taxId = organization.taxId; }
		if (organization.$assignedFields.contains('address')) { address = organization.address; }
		if (organization.$assignedFields.contains('contactEmail')) { contactEmail = organization.contactEmail; }
		if (organization.$assignedFields.contains('managementFeeType')) { managementFeeType = organization.managementFeeType; }
		if (organization.$assignedFields.contains('managementFeeRate')) { managementFeeRate = organization.managementFeeRate; }
		if (organization.$assignedFields.contains('managementFeeAmount')) { managementFeeAmount = organization.managementFeeAmount; }
		if (organization.$assignedFields.contains('managementFeeScope')) { managementFeeScope = organization.managementFeeScope; }
		if (organization.$assignedFields.contains('taxReportingEnabled')) { taxReportingEnabled = organization.taxReportingEnabled; }
		if (organization.$assignedFields.contains('complianceTracking')) { complianceTracking = organization.complianceTracking; }
		if (organization.$assignedFields.contains('requiredInspections')) { requiredInspections = organization.requiredInspections; }
		if (organization.$assignedFields.contains('createdAt')) { createdAt = organization.createdAt; }
		if (organization.$assignedFields.contains('updatedAt')) { updatedAt = organization.updatedAt; }
		if (organization.$assignedFields.contains('deletedAt')) { deletedAt = organization.deletedAt; }
		if (organization.$assignedFields.contains('aiChatbotSessions') && organization.aiChatbotSessions != null) { aiChatbotSessions = mergeModelLists(aiChatbotSessions, organization.aiChatbotSessions); }
		if (organization.$assignedFields.contains('aiFraudDetections') && organization.aiFraudDetections != null) { aiFraudDetections = mergeModelLists(aiFraudDetections, organization.aiFraudDetections); }
		if (organization.$assignedFields.contains('aiImageAnalyses') && organization.aiImageAnalyses != null) { aiImageAnalyses = mergeModelLists(aiImageAnalyses, organization.aiImageAnalyses); }
		if (organization.$assignedFields.contains('aiInvestmentAnalyses') && organization.aiInvestmentAnalyses != null) { aiInvestmentAnalyses = mergeModelLists(aiInvestmentAnalyses, organization.aiInvestmentAnalyses); }
		if (organization.$assignedFields.contains('aiLeadScores') && organization.aiLeadScores != null) { aiLeadScores = mergeModelLists(aiLeadScores, organization.aiLeadScores); }
		if (organization.$assignedFields.contains('aiLeadScoringModels') && organization.aiLeadScoringModels != null) { aiLeadScoringModels = mergeModelLists(aiLeadScoringModels, organization.aiLeadScoringModels); }
		if (organization.$assignedFields.contains('aiMarketAnalyses') && organization.aiMarketAnalyses != null) { aiMarketAnalyses = mergeModelLists(aiMarketAnalyses, organization.aiMarketAnalyses); }
		if (organization.$assignedFields.contains('aiModels') && organization.aiModels != null) { aiModels = mergeModelLists(aiModels, organization.aiModels); }
		if (organization.$assignedFields.contains('aiModelDeployments') && organization.aiModelDeployments != null) { aiModelDeployments = mergeModelLists(aiModelDeployments, organization.aiModelDeployments); }
		if (organization.$assignedFields.contains('aiPredictions') && organization.aiPredictions != null) { aiPredictions = mergeModelLists(aiPredictions, organization.aiPredictions); }
		if (organization.$assignedFields.contains('aiPredictiveMaintenance') && organization.aiPredictiveMaintenance != null) { aiPredictiveMaintenance = mergeModelLists(aiPredictiveMaintenance, organization.aiPredictiveMaintenance); }
		if (organization.$assignedFields.contains('aiPriceOptimizations') && organization.aiPriceOptimizations != null) { aiPriceOptimizations = mergeModelLists(aiPriceOptimizations, organization.aiPriceOptimizations); }
		if (organization.$assignedFields.contains('aiPropertyDescriptions') && organization.aiPropertyDescriptions != null) { aiPropertyDescriptions = mergeModelLists(aiPropertyDescriptions, organization.aiPropertyDescriptions); }
		if (organization.$assignedFields.contains('aiPropertyValuations') && organization.aiPropertyValuations != null) { aiPropertyValuations = mergeModelLists(aiPropertyValuations, organization.aiPropertyValuations); }
		if (organization.$assignedFields.contains('aiRecommendations') && organization.aiRecommendations != null) { aiRecommendations = mergeModelLists(aiRecommendations, organization.aiRecommendations); }
		if (organization.$assignedFields.contains('aiSentimentAnalyses') && organization.aiSentimentAnalyses != null) { aiSentimentAnalyses = mergeModelLists(aiSentimentAnalyses, organization.aiSentimentAnalyses); }
		if (organization.$assignedFields.contains('aiTenantScreenings') && organization.aiTenantScreenings != null) { aiTenantScreenings = mergeModelLists(aiTenantScreenings, organization.aiTenantScreenings); }
		if (organization.$assignedFields.contains('aiValuationModels') && organization.aiValuationModels != null) { aiValuationModels = mergeModelLists(aiValuationModels, organization.aiValuationModels); }
		if (organization.$assignedFields.contains('integrations') && organization.integrations != null) { integrations = mergeModelLists(integrations, organization.integrations); }
		if (organization.$assignedFields.contains('achievements') && organization.achievements != null) { achievements = mergeModelLists(achievements, organization.achievements); }
		if (organization.$assignedFields.contains('agencies') && organization.agencies != null) { agencies = mergeModelLists(agencies, organization.agencies); }
		if (organization.$assignedFields.contains('agencyRelations') && organization.agencyRelations != null) { agencyRelations = mergeModelLists(agencyRelations, organization.agencyRelations); }
		if (organization.$assignedFields.contains('organizationAgencies') && organization.organizationAgencies != null) { organizationAgencies = mergeModelLists(organizationAgencies, organization.organizationAgencies); }
		if (organization.$assignedFields.contains('agentAssignments') && organization.agentAssignments != null) { agentAssignments = mergeModelLists(agentAssignments, organization.agentAssignments); }
		if (organization.$assignedFields.contains('agentTeams') && organization.agentTeams != null) { agentTeams = mergeModelLists(agentTeams, organization.agentTeams); }
		if (organization.$assignedFields.contains('amenities') && organization.amenities != null) { amenities = mergeModelLists(amenities, organization.amenities); }
		if (organization.$assignedFields.contains('apiIntegrations') && organization.apiIntegrations != null) { apiIntegrations = mergeModelLists(apiIntegrations, organization.apiIntegrations); }
		if (organization.$assignedFields.contains('apiKeys') && organization.apiKeys != null) { apiKeys = mergeModelLists(apiKeys, organization.apiKeys); }
		if (organization.$assignedFields.contains('appointments') && organization.appointments != null) { appointments = mergeModelLists(appointments, organization.appointments); }
		if (organization.$assignedFields.contains('attachments') && organization.attachments != null) { attachments = mergeModelLists(attachments, organization.attachments); }
		if (organization.$assignedFields.contains('attorneyCases') && organization.attorneyCases != null) { attorneyCases = mergeModelLists(attorneyCases, organization.attorneyCases); }
		if (organization.$assignedFields.contains('auditLogs') && organization.auditLogs != null) { auditLogs = mergeModelLists(auditLogs, organization.auditLogs); }
		if (organization.$assignedFields.contains('automationExecutions') && organization.automationExecutions != null) { automationExecutions = mergeModelLists(automationExecutions, organization.automationExecutions); }
		if (organization.$assignedFields.contains('automationRules') && organization.automationRules != null) { automationRules = mergeModelLists(automationRules, organization.automationRules); }
		if (organization.$assignedFields.contains('bookings') && organization.bookings != null) { bookings = mergeModelLists(bookings, organization.bookings); }
		if (organization.$assignedFields.contains('budgets') && organization.budgets != null) { budgets = mergeModelLists(budgets, organization.budgets); }
		if (organization.$assignedFields.contains('calendarEvents') && organization.calendarEvents != null) { calendarEvents = mergeModelLists(calendarEvents, organization.calendarEvents); }
		if (organization.$assignedFields.contains('commissions') && organization.commissions != null) { commissions = mergeModelLists(commissions, organization.commissions); }
		if (organization.$assignedFields.contains('communicationTemplates') && organization.communicationTemplates != null) { communicationTemplates = mergeModelLists(communicationTemplates, organization.communicationTemplates); }
		if (organization.$assignedFields.contains('contacts') && organization.contacts != null) { contacts = mergeModelLists(contacts, organization.contacts); }
		if (organization.$assignedFields.contains('contracts') && organization.contracts != null) { contracts = mergeModelLists(contracts, organization.contracts); }
		if (organization.$assignedFields.contains('contractVersions') && organization.contractVersions != null) { contractVersions = mergeModelLists(contractVersions, organization.contractVersions); }
		if (organization.$assignedFields.contains('dashboardConfigurations') && organization.dashboardConfigurations != null) { dashboardConfigurations = mergeModelLists(dashboardConfigurations, organization.dashboardConfigurations); }
		if (organization.$assignedFields.contains('dashboardWidgets') && organization.dashboardWidgets != null) { dashboardWidgets = mergeModelLists(dashboardWidgets, organization.dashboardWidgets); }
		if (organization.$assignedFields.contains('deals') && organization.deals != null) { deals = mergeModelLists(deals, organization.deals); }
		if (organization.$assignedFields.contains('depositProtections') && organization.depositProtections != null) { depositProtections = mergeModelLists(depositProtections, organization.depositProtections); }
		if (organization.$assignedFields.contains('documents') && organization.documents != null) { documents = mergeModelLists(documents, organization.documents); }
		if (organization.$assignedFields.contains('documentTemplates') && organization.documentTemplates != null) { documentTemplates = mergeModelLists(documentTemplates, organization.documentTemplates); }
		if (organization.$assignedFields.contains('earnings') && organization.earnings != null) { earnings = mergeModelLists(earnings, organization.earnings); }
		if (organization.$assignedFields.contains('events') && organization.events != null) { events = mergeModelLists(events, organization.events); }
		if (organization.$assignedFields.contains('eventAttendees') && organization.eventAttendees != null) { eventAttendees = mergeModelLists(eventAttendees, organization.eventAttendees); }
		if (organization.$assignedFields.contains('exchangeRates') && organization.exchangeRates != null) { exchangeRates = mergeModelLists(exchangeRates, organization.exchangeRates); }
		if (organization.$assignedFields.contains('exportFiles') && organization.exportFiles != null) { exportFiles = mergeModelLists(exportFiles, organization.exportFiles); }
		if (organization.$assignedFields.contains('exportJobs') && organization.exportJobs != null) { exportJobs = mergeModelLists(exportJobs, organization.exportJobs); }
		if (organization.$assignedFields.contains('externalRentalListings') && organization.externalRentalListings != null) { externalRentalListings = mergeModelLists(externalRentalListings, organization.externalRentalListings); }
		if (organization.$assignedFields.contains('facilities') && organization.facilities != null) { facilities = mergeModelLists(facilities, organization.facilities); }
		if (organization.$assignedFields.contains('financialRecords') && organization.financialRecords != null) { financialRecords = mergeModelLists(financialRecords, organization.financialRecords); }
		if (organization.$assignedFields.contains('floorPlans') && organization.floorPlans != null) { floorPlans = mergeModelLists(floorPlans, organization.floorPlans); }
		if (organization.$assignedFields.contains('giftCards') && organization.giftCards != null) { giftCards = mergeModelLists(giftCards, organization.giftCards); }
		if (organization.$assignedFields.contains('govtIntegrations') && organization.govtIntegrations != null) { govtIntegrations = mergeModelLists(govtIntegrations, organization.govtIntegrations); }
		if (organization.$assignedFields.contains('healthChecks') && organization.healthChecks != null) { healthChecks = mergeModelLists(healthChecks, organization.healthChecks); }
		if (organization.$assignedFields.contains('homeInformationPacks') && organization.homeInformationPacks != null) { homeInformationPacks = mergeModelLists(homeInformationPacks, organization.homeInformationPacks); }
		if (organization.$assignedFields.contains('immigrationStatusChecks') && organization.immigrationStatusChecks != null) { immigrationStatusChecks = mergeModelLists(immigrationStatusChecks, organization.immigrationStatusChecks); }
		if (organization.$assignedFields.contains('integrationLogs') && organization.integrationLogs != null) { integrationLogs = mergeModelLists(integrationLogs, organization.integrationLogs); }
		if (organization.$assignedFields.contains('investorPortfolios') && organization.investorPortfolios != null) { investorPortfolios = mergeModelLists(investorPortfolios, organization.investorPortfolios); }
		if (organization.$assignedFields.contains('keys') && organization.keys != null) { keys = mergeModelLists(keys, organization.keys); }
		if (organization.$assignedFields.contains('leads') && organization.leads != null) { leads = mergeModelLists(leads, organization.leads); }
		if (organization.$assignedFields.contains('leadSources') && organization.leadSources != null) { leadSources = mergeModelLists(leadSources, organization.leadSources); }
		if (organization.$assignedFields.contains('leases') && organization.leases != null) { leases = mergeModelLists(leases, organization.leases); }
		if (organization.$assignedFields.contains('leaseRenewals') && organization.leaseRenewals != null) { leaseRenewals = mergeModelLists(leaseRenewals, organization.leaseRenewals); }
		if (organization.$assignedFields.contains('ledgerEntries') && organization.ledgerEntries != null) { ledgerEntries = mergeModelLists(ledgerEntries, organization.ledgerEntries); }
		if (organization.$assignedFields.contains('listings') && organization.listings != null) { listings = mergeModelLists(listings, organization.listings); }
		if (organization.$assignedFields.contains('listingChannels') && organization.listingChannels != null) { listingChannels = mergeModelLists(listingChannels, organization.listingChannels); }
		if (organization.$assignedFields.contains('listingStatusHistories') && organization.listingStatusHistories != null) { listingStatusHistories = mergeModelLists(listingStatusHistories, organization.listingStatusHistories); }
		if (organization.$assignedFields.contains('listingTags') && organization.listingTags != null) { listingTags = mergeModelLists(listingTags, organization.listingTags); }
		if (organization.$assignedFields.contains('locations') && organization.locations != null) { locations = mergeModelLists(locations, organization.locations); }
		if (organization.$assignedFields.contains('loyaltyAccounts') && organization.loyaltyAccounts != null) { loyaltyAccounts = mergeModelLists(loyaltyAccounts, organization.loyaltyAccounts); }
		if (organization.$assignedFields.contains('mlsConnections') && organization.mlsConnections != null) { mlsConnections = mergeModelLists(mlsConnections, organization.mlsConnections); }
		if (organization.$assignedFields.contains('mlsexternalListings') && organization.mlsexternalListings != null) { mlsexternalListings = mergeModelLists(mlsexternalListings, organization.mlsexternalListings); }
		if (organization.$assignedFields.contains('mlssyncJobs') && organization.mlssyncJobs != null) { mlssyncJobs = mergeModelLists(mlssyncJobs, organization.mlssyncJobs); }
		if (organization.$assignedFields.contains('maintenanceBlocks') && organization.maintenanceBlocks != null) { maintenanceBlocks = mergeModelLists(maintenanceBlocks, organization.maintenanceBlocks); }
		if (organization.$assignedFields.contains('workOrders') && organization.workOrders != null) { workOrders = mergeModelLists(workOrders, organization.workOrders); }
		if (organization.$assignedFields.contains('mapLayers') && organization.mapLayers != null) { mapLayers = mergeModelLists(mapLayers, organization.mapLayers); }
		if (organization.$assignedFields.contains('marketingCampaigns') && organization.marketingCampaigns != null) { marketingCampaigns = mergeModelLists(marketingCampaigns, organization.marketingCampaigns); }
		if (organization.$assignedFields.contains('messages') && organization.messages != null) { messages = mergeModelLists(messages, organization.messages); }
		if (organization.$assignedFields.contains('mlsDataMappings') && organization.mlsDataMappings != null) { mlsDataMappings = mergeModelLists(mlsDataMappings, organization.mlsDataMappings); }
		if (organization.$assignedFields.contains('mlsListingEnhancements') && organization.mlsListingEnhancements != null) { mlsListingEnhancements = mergeModelLists(mlsListingEnhancements, organization.mlsListingEnhancements); }
		if (organization.$assignedFields.contains('mobileDevices') && organization.mobileDevices != null) { mobileDevices = mergeModelLists(mobileDevices, organization.mobileDevices); }
		if (organization.$assignedFields.contains('mortgageOffers') && organization.mortgageOffers != null) { mortgageOffers = mergeModelLists(mortgageOffers, organization.mortgageOffers); }
		if (organization.$assignedFields.contains('mortgagePreApprovals') && organization.mortgagePreApprovals != null) { mortgagePreApprovals = mergeModelLists(mortgagePreApprovals, organization.mortgagePreApprovals); }
		if (organization.$assignedFields.contains('neighborhoods') && organization.neighborhoods != null) { neighborhoods = mergeModelLists(neighborhoods, organization.neighborhoods); }
		if (organization.$assignedFields.contains('notifications') && organization.notifications != null) { notifications = mergeModelLists(notifications, organization.notifications); }
		if (organization.$assignedFields.contains('offlineSyncQueues') && organization.offlineSyncQueues != null) { offlineSyncQueues = mergeModelLists(offlineSyncQueues, organization.offlineSyncQueues); }
		if (organization.$assignedFields.contains('orgSubscription')) { orgSubscription = organization.orgSubscription; }
		if (organization.$assignedFields.contains('payouts') && organization.payouts != null) { payouts = mergeModelLists(payouts, organization.payouts); }
		if (organization.$assignedFields.contains('performanceAlerts') && organization.performanceAlerts != null) { performanceAlerts = mergeModelLists(performanceAlerts, organization.performanceAlerts); }
		if (organization.$assignedFields.contains('predictiveModels') && organization.predictiveModels != null) { predictiveModels = mergeModelLists(predictiveModels, organization.predictiveModels); }
		if (organization.$assignedFields.contains('projects') && organization.projects != null) { projects = mergeModelLists(projects, organization.projects); }
		if (organization.$assignedFields.contains('properties') && organization.properties != null) { properties = mergeModelLists(properties, organization.properties); }
		if (organization.$assignedFields.contains('propertyAmenities') && organization.propertyAmenities != null) { propertyAmenities = mergeModelLists(propertyAmenities, organization.propertyAmenities); }
		if (organization.$assignedFields.contains('propertyCompliance') && organization.propertyCompliance != null) { propertyCompliance = mergeModelLists(propertyCompliance, organization.propertyCompliance); }
		if (organization.$assignedFields.contains('propertyDisclosures') && organization.propertyDisclosures != null) { propertyDisclosures = mergeModelLists(propertyDisclosures, organization.propertyDisclosures); }
		if (organization.$assignedFields.contains('propertyDocuments') && organization.propertyDocuments != null) { propertyDocuments = mergeModelLists(propertyDocuments, organization.propertyDocuments); }
		if (organization.$assignedFields.contains('inventories') && organization.inventories != null) { inventories = mergeModelLists(inventories, organization.inventories); }
		if (organization.$assignedFields.contains('propertyOffers') && organization.propertyOffers != null) { propertyOffers = mergeModelLists(propertyOffers, organization.propertyOffers); }
		if (organization.$assignedFields.contains('propertyPhotos') && organization.propertyPhotos != null) { propertyPhotos = mergeModelLists(propertyPhotos, organization.propertyPhotos); }
		if (organization.$assignedFields.contains('propertyViewings') && organization.propertyViewings != null) { propertyViewings = mergeModelLists(propertyViewings, organization.propertyViewings); }
		if (organization.$assignedFields.contains('queueConfigurations') && organization.queueConfigurations != null) { queueConfigurations = mergeModelLists(queueConfigurations, organization.queueConfigurations); }
		if (organization.$assignedFields.contains('queueMessages') && organization.queueMessages != null) { queueMessages = mergeModelLists(queueMessages, organization.queueMessages); }
		if (organization.$assignedFields.contains('quotes') && organization.quotes != null) { quotes = mergeModelLists(quotes, organization.quotes); }
		if (organization.$assignedFields.contains('recommendationResults') && organization.recommendationResults != null) { recommendationResults = mergeModelLists(recommendationResults, organization.recommendationResults); }
		if (organization.$assignedFields.contains('referrals') && organization.referrals != null) { referrals = mergeModelLists(referrals, organization.referrals); }
		if (organization.$assignedFields.contains('rentArrears') && organization.rentArrears != null) { rentArrears = mergeModelLists(rentArrears, organization.rentArrears); }
		if (organization.$assignedFields.contains('rentSchedules') && organization.rentSchedules != null) { rentSchedules = mergeModelLists(rentSchedules, organization.rentSchedules); }
		if (organization.$assignedFields.contains('rentalSyncJobs') && organization.rentalSyncJobs != null) { rentalSyncJobs = mergeModelLists(rentalSyncJobs, organization.rentalSyncJobs); }
		if (organization.$assignedFields.contains('reports') && organization.reports != null) { reports = mergeModelLists(reports, organization.reports); }
		if (organization.$assignedFields.contains('reportExecutions') && organization.reportExecutions != null) { reportExecutions = mergeModelLists(reportExecutions, organization.reportExecutions); }
		if (organization.$assignedFields.contains('reservations') && organization.reservations != null) { reservations = mergeModelLists(reservations, organization.reservations); }
		if (organization.$assignedFields.contains('reviews') && organization.reviews != null) { reviews = mergeModelLists(reviews, organization.reviews); }
		if (organization.$assignedFields.contains('rightToRentChecks') && organization.rightToRentChecks != null) { rightToRentChecks = mergeModelLists(rightToRentChecks, organization.rightToRentChecks); }
		if (organization.$assignedFields.contains('roles') && organization.roles != null) { roles = mergeModelLists(roles, organization.roles); }
		if (organization.$assignedFields.contains('routes') && organization.routes != null) { routes = mergeModelLists(routes, organization.routes); }
		if (organization.$assignedFields.contains('securityDepositProtections') && organization.securityDepositProtections != null) { securityDepositProtections = mergeModelLists(securityDepositProtections, organization.securityDepositProtections); }
		if (organization.$assignedFields.contains('signatureRequests') && organization.signatureRequests != null) { signatureRequests = mergeModelLists(signatureRequests, organization.signatureRequests); }
		if (organization.$assignedFields.contains('signatureSigners') && organization.signatureSigners != null) { signatureSigners = mergeModelLists(signatureSigners, organization.signatureSigners); }
		if (organization.$assignedFields.contains('solicitorManagements') && organization.solicitorManagements != null) { solicitorManagements = mergeModelLists(solicitorManagements, organization.solicitorManagements); }
		if (organization.$assignedFields.contains('subscriptions') && organization.subscriptions != null) { subscriptions = mergeModelLists(subscriptions, organization.subscriptions); }
		if (organization.$assignedFields.contains('systemMetrics') && organization.systemMetrics != null) { systemMetrics = mergeModelLists(systemMetrics, organization.systemMetrics); }
		if (organization.$assignedFields.contains('tags') && organization.tags != null) { tags = mergeModelLists(tags, organization.tags); }
		if (organization.$assignedFields.contains('tasks') && organization.tasks != null) { tasks = mergeModelLists(tasks, organization.tasks); }
		if (organization.$assignedFields.contains('tax1099Forms') && organization.tax1099Forms != null) { tax1099Forms = mergeModelLists(tax1099Forms, organization.tax1099Forms); }
		if (organization.$assignedFields.contains('taxDepreciations') && organization.taxDepreciations != null) { taxDepreciations = mergeModelLists(taxDepreciations, organization.taxDepreciations); }
		if (organization.$assignedFields.contains('taxRecords') && organization.taxRecords != null) { taxRecords = mergeModelLists(taxRecords, organization.taxRecords); }
		if (organization.$assignedFields.contains('tenantApplications') && organization.tenantApplications != null) { tenantApplications = mergeModelLists(tenantApplications, organization.tenantApplications); }
		if (organization.$assignedFields.contains('userActivityLogs') && organization.userActivityLogs != null) { userActivityLogs = mergeModelLists(userActivityLogs, organization.userActivityLogs); }
		if (organization.$assignedFields.contains('userPreferences') && organization.userPreferences != null) { userPreferences = mergeModelLists(userPreferences, organization.userPreferences); }
		if (organization.$assignedFields.contains('vacationRentals') && organization.vacationRentals != null) { vacationRentals = mergeModelLists(vacationRentals, organization.vacationRentals); }
		if (organization.$assignedFields.contains('vendors') && organization.vendors != null) { vendors = mergeModelLists(vendors, organization.vendors); }
		if (organization.$assignedFields.contains('virtualTours') && organization.virtualTours != null) { virtualTours = mergeModelLists(virtualTours, organization.virtualTours); }
		if (organization.$assignedFields.contains('webhooks') && organization.webhooks != null) { webhooks = mergeModelLists(webhooks, organization.webhooks); }
		if (organization.$assignedFields.contains('webhookDeliveries') && organization.webhookDeliveries != null) { webhookDeliveries = mergeModelLists(webhookDeliveries, organization.webhookDeliveries); }
		if (organization.$assignedFields.contains('escrowAccounts') && organization.escrowAccounts != null) { escrowAccounts = mergeModelLists(escrowAccounts, organization.escrowAccounts); }
		if (organization.$assignedFields.contains('escrowReleases') && organization.escrowReleases != null) { escrowReleases = mergeModelLists(escrowReleases, organization.escrowReleases); }
		if (organization.$assignedFields.contains('escrowDisputes') && organization.escrowDisputes != null) { escrowDisputes = mergeModelLists(escrowDisputes, organization.escrowDisputes); }
		if (organization.$assignedFields.contains('paymentNegotiations') && organization.paymentNegotiations != null) { paymentNegotiations = mergeModelLists(paymentNegotiations, organization.paymentNegotiations); }
		if (organization.$assignedFields.contains('paymentInstallments') && organization.paymentInstallments != null) { paymentInstallments = mergeModelLists(paymentInstallments, organization.paymentInstallments); }
		if (organization.$assignedFields.contains('videoContents') && organization.videoContents != null) { videoContents = mergeModelLists(videoContents, organization.videoContents); }
		if (organization.$assignedFields.contains('brandAmbassadors') && organization.brandAmbassadors != null) { brandAmbassadors = mergeModelLists(brandAmbassadors, organization.brandAmbassadors); }
		if (organization.$assignedFields.contains('ambassadorCampaigns') && organization.ambassadorCampaigns != null) { ambassadorCampaigns = mergeModelLists(ambassadorCampaigns, organization.ambassadorCampaigns); }
		if (organization.$assignedFields.contains('socialImpactCounters') && organization.socialImpactCounters != null) { socialImpactCounters = mergeModelLists(socialImpactCounters, organization.socialImpactCounters); }
		if (organization.$assignedFields.contains('socialImpactRecords') && organization.socialImpactRecords != null) { socialImpactRecords = mergeModelLists(socialImpactRecords, organization.socialImpactRecords); }
		if (organization.$assignedFields.contains('negotiationOffers') && organization.negotiationOffers != null) { negotiationOffers = mergeModelLists(negotiationOffers, organization.negotiationOffers); }
		if (organization.$assignedFields.contains('ambassadorContracts') && organization.ambassadorContracts != null) { ambassadorContracts = mergeModelLists(ambassadorContracts, organization.ambassadorContracts); }
		if (organization.$assignedFields.contains('escrowStatusHistories') && organization.escrowStatusHistories != null) { escrowStatusHistories = mergeModelLists(escrowStatusHistories, organization.escrowStatusHistories); }
		if (organization.$assignedFields.contains('aiChatMessages') && organization.aiChatMessages != null) { aiChatMessages = mergeModelLists(aiChatMessages, organization.aiChatMessages); }
		if (organization.$assignedFields.contains('aiChatHandoffs') && organization.aiChatHandoffs != null) { aiChatHandoffs = mergeModelLists(aiChatHandoffs, organization.aiChatHandoffs); }
		if (organization.$assignedFields.contains('analyses') && organization.analyses != null) { analyses = mergeModelLists(analyses, organization.analyses); }
		if (organization.$assignedFields.contains('analysisJobs') && organization.analysisJobs != null) { analysisJobs = mergeModelLists(analysisJobs, organization.analysisJobs); }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'Organization'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(region != null) 'region': region?.toJson(),
	if(defaultCurrency != null) 'defaultCurrency': defaultCurrency,
	if(defaultLocale != null) 'defaultLocale': defaultLocale,
	if(legalName != null) 'legalName': legalName,
	if(taxId != null) 'taxId': taxId,
	if(address != null) 'address': address,
	if(contactEmail != null) 'contactEmail': contactEmail,
	if(managementFeeType != null) 'managementFeeType': managementFeeType?.toJson(),
	if(managementFeeRate != null) 'managementFeeRate': managementFeeRate,
	if(managementFeeAmount != null) 'managementFeeAmount': managementFeeAmount,
	if(managementFeeScope != null) 'managementFeeScope': managementFeeScope?.toJson(),
	if(taxReportingEnabled != null) 'taxReportingEnabled': taxReportingEnabled,
	if(complianceTracking != null) 'complianceTracking': complianceTracking,
	if(requiredInspections != null) 'requiredInspections': requiredInspections?.map((item) => item.toJson()).toList(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(aiChatbotSessions != null && (!preventCircularSerialization || !serializedModels.contains('AIChatbotSession'))) 'aiChatbotSessions': aiChatbotSessions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiFraudDetections != null && (!preventCircularSerialization || !serializedModels.contains('AIFraudDetection'))) 'aiFraudDetections': aiFraudDetections?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiImageAnalyses != null && (!preventCircularSerialization || !serializedModels.contains('AIImageAnalysis'))) 'aiImageAnalyses': aiImageAnalyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiInvestmentAnalyses != null && (!preventCircularSerialization || !serializedModels.contains('AIInvestmentAnalysis'))) 'aiInvestmentAnalyses': aiInvestmentAnalyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiLeadScores != null && (!preventCircularSerialization || !serializedModels.contains('AILeadScore'))) 'aiLeadScores': aiLeadScores?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiLeadScoringModels != null && (!preventCircularSerialization || !serializedModels.contains('AILeadScoring'))) 'aiLeadScoringModels': aiLeadScoringModels?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiMarketAnalyses != null && (!preventCircularSerialization || !serializedModels.contains('AIMarketAnalysis'))) 'aiMarketAnalyses': aiMarketAnalyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiModels != null && (!preventCircularSerialization || !serializedModels.contains('AIModel'))) 'aiModels': aiModels?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiModelDeployments != null && (!preventCircularSerialization || !serializedModels.contains('AIModelDeployment'))) 'aiModelDeployments': aiModelDeployments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiPredictions != null && (!preventCircularSerialization || !serializedModels.contains('AIPrediction'))) 'aiPredictions': aiPredictions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiPredictiveMaintenance != null && (!preventCircularSerialization || !serializedModels.contains('AIPredictiveMaintenance'))) 'aiPredictiveMaintenance': aiPredictiveMaintenance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiPriceOptimizations != null && (!preventCircularSerialization || !serializedModels.contains('AIPriceOptimization'))) 'aiPriceOptimizations': aiPriceOptimizations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiPropertyDescriptions != null && (!preventCircularSerialization || !serializedModels.contains('AIPropertyDescription'))) 'aiPropertyDescriptions': aiPropertyDescriptions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiPropertyValuations != null && (!preventCircularSerialization || !serializedModels.contains('AIPropertyValuation'))) 'aiPropertyValuations': aiPropertyValuations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiRecommendations != null && (!preventCircularSerialization || !serializedModels.contains('AIRecommendation'))) 'aiRecommendations': aiRecommendations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiSentimentAnalyses != null && (!preventCircularSerialization || !serializedModels.contains('AISentimentAnalysis'))) 'aiSentimentAnalyses': aiSentimentAnalyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiTenantScreenings != null && (!preventCircularSerialization || !serializedModels.contains('AITenantScreening'))) 'aiTenantScreenings': aiTenantScreenings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiValuationModels != null && (!preventCircularSerialization || !serializedModels.contains('AIValuationModel'))) 'aiValuationModels': aiValuationModels?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(integrations != null && (!preventCircularSerialization || !serializedModels.contains('APIIntegration'))) 'integrations': integrations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(achievements != null && (!preventCircularSerialization || !serializedModels.contains('Achievement'))) 'achievements': achievements?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencyRelations != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencyRelations': agencyRelations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(organizationAgencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'organizationAgencies': organizationAgencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentAssignments != null && (!preventCircularSerialization || !serializedModels.contains('AgentAssignment'))) 'agentAssignments': agentAssignments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentTeams != null && (!preventCircularSerialization || !serializedModels.contains('AgentTeam'))) 'agentTeams': agentTeams?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(amenities != null && (!preventCircularSerialization || !serializedModels.contains('Amenity'))) 'amenities': amenities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(apiIntegrations != null && (!preventCircularSerialization || !serializedModels.contains('ApiIntegration'))) 'apiIntegrations': apiIntegrations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(apiKeys != null && (!preventCircularSerialization || !serializedModels.contains('ApiKey'))) 'apiKeys': apiKeys?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(appointments != null && (!preventCircularSerialization || !serializedModels.contains('Appointment'))) 'appointments': appointments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(attorneyCases != null && (!preventCircularSerialization || !serializedModels.contains('AttorneyManagement'))) 'attorneyCases': attorneyCases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(auditLogs != null && (!preventCircularSerialization || !serializedModels.contains('AuditLog'))) 'auditLogs': auditLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(automationExecutions != null && (!preventCircularSerialization || !serializedModels.contains('AutomationExecution'))) 'automationExecutions': automationExecutions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(automationRules != null && (!preventCircularSerialization || !serializedModels.contains('AutomationRule'))) 'automationRules': automationRules?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(bookings != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'bookings': bookings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(budgets != null && (!preventCircularSerialization || !serializedModels.contains('Budget'))) 'budgets': budgets?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(calendarEvents != null && (!preventCircularSerialization || !serializedModels.contains('CalendarEvent'))) 'calendarEvents': calendarEvents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(commissions != null && (!preventCircularSerialization || !serializedModels.contains('Commission'))) 'commissions': commissions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(communicationTemplates != null && (!preventCircularSerialization || !serializedModels.contains('CommunicationTemplate'))) 'communicationTemplates': communicationTemplates?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contacts != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contacts': contacts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contracts != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contracts': contracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contractVersions != null && (!preventCircularSerialization || !serializedModels.contains('ContractVersion'))) 'contractVersions': contractVersions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(dashboardConfigurations != null && (!preventCircularSerialization || !serializedModels.contains('DashboardConfiguration'))) 'dashboardConfigurations': dashboardConfigurations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(dashboardWidgets != null && (!preventCircularSerialization || !serializedModels.contains('DashboardWidget'))) 'dashboardWidgets': dashboardWidgets?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(deals != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deals': deals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(depositProtections != null && (!preventCircularSerialization || !serializedModels.contains('DepositProtection'))) 'depositProtections': depositProtections?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(documents != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'documents': documents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(documentTemplates != null && (!preventCircularSerialization || !serializedModels.contains('DocumentTemplate'))) 'documentTemplates': documentTemplates?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(earnings != null && (!preventCircularSerialization || !serializedModels.contains('Earning'))) 'earnings': earnings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(events != null && (!preventCircularSerialization || !serializedModels.contains('Event'))) 'events': events?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(eventAttendees != null && (!preventCircularSerialization || !serializedModels.contains('EventAttendee'))) 'eventAttendees': eventAttendees?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(exchangeRates != null && (!preventCircularSerialization || !serializedModels.contains('ExchangeRate'))) 'exchangeRates': exchangeRates?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(exportFiles != null && (!preventCircularSerialization || !serializedModels.contains('ExportFile'))) 'exportFiles': exportFiles?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(exportJobs != null && (!preventCircularSerialization || !serializedModels.contains('ExportJob'))) 'exportJobs': exportJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(externalRentalListings != null && (!preventCircularSerialization || !serializedModels.contains('ExternalRentalListing'))) 'externalRentalListings': externalRentalListings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(facilities != null && (!preventCircularSerialization || !serializedModels.contains('Facility'))) 'facilities': facilities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(financialRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecords': financialRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(floorPlans != null && (!preventCircularSerialization || !serializedModels.contains('FloorPlan'))) 'floorPlans': floorPlans?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(giftCards != null && (!preventCircularSerialization || !serializedModels.contains('GiftCard'))) 'giftCards': giftCards?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(govtIntegrations != null && (!preventCircularSerialization || !serializedModels.contains('GovernmentIntegration'))) 'govtIntegrations': govtIntegrations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(healthChecks != null && (!preventCircularSerialization || !serializedModels.contains('HealthCheck'))) 'healthChecks': healthChecks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(homeInformationPacks != null && (!preventCircularSerialization || !serializedModels.contains('HomeInformationPack'))) 'homeInformationPacks': homeInformationPacks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(immigrationStatusChecks != null && (!preventCircularSerialization || !serializedModels.contains('ImmigrationStatusCheck'))) 'immigrationStatusChecks': immigrationStatusChecks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(integrationLogs != null && (!preventCircularSerialization || !serializedModels.contains('IntegrationLog'))) 'integrationLogs': integrationLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(investorPortfolios != null && (!preventCircularSerialization || !serializedModels.contains('InvestorPortfolio'))) 'investorPortfolios': investorPortfolios?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(keys != null && (!preventCircularSerialization || !serializedModels.contains('KeyManagement'))) 'keys': keys?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leadSources != null && (!preventCircularSerialization || !serializedModels.contains('LeadSource'))) 'leadSources': leadSources?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leases != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'leases': leases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leaseRenewals != null && (!preventCircularSerialization || !serializedModels.contains('LeaseRenewal'))) 'leaseRenewals': leaseRenewals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(ledgerEntries != null && (!preventCircularSerialization || !serializedModels.contains('LedgerEntry'))) 'ledgerEntries': ledgerEntries?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(listings != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listings': listings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(listingChannels != null && (!preventCircularSerialization || !serializedModels.contains('ListingChannel'))) 'listingChannels': listingChannels?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(listingStatusHistories != null && (!preventCircularSerialization || !serializedModels.contains('ListingStatusHistory'))) 'listingStatusHistories': listingStatusHistories?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(listingTags != null && (!preventCircularSerialization || !serializedModels.contains('ListingTag'))) 'listingTags': listingTags?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(locations != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'locations': locations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(loyaltyAccounts != null && (!preventCircularSerialization || !serializedModels.contains('LoyaltyAccount'))) 'loyaltyAccounts': loyaltyAccounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mlsConnections != null && (!preventCircularSerialization || !serializedModels.contains('MLSConnection'))) 'mlsConnections': mlsConnections?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mlsexternalListings != null && (!preventCircularSerialization || !serializedModels.contains('MLSExternalListing'))) 'mlsexternalListings': mlsexternalListings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mlssyncJobs != null && (!preventCircularSerialization || !serializedModels.contains('MLSSyncJob'))) 'mlssyncJobs': mlssyncJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(maintenanceBlocks != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceBlock'))) 'maintenanceBlocks': maintenanceBlocks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(workOrders != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceWorkOrder'))) 'workOrders': workOrders?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mapLayers != null && (!preventCircularSerialization || !serializedModels.contains('MapLayer'))) 'mapLayers': mapLayers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(marketingCampaigns != null && (!preventCircularSerialization || !serializedModels.contains('MarketingCampaign'))) 'marketingCampaigns': marketingCampaigns?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(messages != null && (!preventCircularSerialization || !serializedModels.contains('Message'))) 'messages': messages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mlsDataMappings != null && (!preventCircularSerialization || !serializedModels.contains('MlsDataMapping'))) 'mlsDataMappings': mlsDataMappings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mlsListingEnhancements != null && (!preventCircularSerialization || !serializedModels.contains('MlsListingEnhancement'))) 'mlsListingEnhancements': mlsListingEnhancements?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mobileDevices != null && (!preventCircularSerialization || !serializedModels.contains('MobileDevice'))) 'mobileDevices': mobileDevices?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgageOffers != null && (!preventCircularSerialization || !serializedModels.contains('MortgageOffer'))) 'mortgageOffers': mortgageOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgagePreApprovals != null && (!preventCircularSerialization || !serializedModels.contains('MortgagePreApproval'))) 'mortgagePreApprovals': mortgagePreApprovals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(neighborhoods != null && (!preventCircularSerialization || !serializedModels.contains('Neighborhood'))) 'neighborhoods': neighborhoods?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(notifications != null && (!preventCircularSerialization || !serializedModels.contains('Notification'))) 'notifications': notifications?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(offlineSyncQueues != null && (!preventCircularSerialization || !serializedModels.contains('OfflineSyncQueue'))) 'offlineSyncQueues': offlineSyncQueues?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(orgSubscription != null && (!preventCircularSerialization || !serializedModels.contains('OrgSubscription'))) 'orgSubscription': orgSubscription?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(payouts != null && (!preventCircularSerialization || !serializedModels.contains('Payout'))) 'payouts': payouts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(performanceAlerts != null && (!preventCircularSerialization || !serializedModels.contains('PerformanceAlert'))) 'performanceAlerts': performanceAlerts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(predictiveModels != null && (!preventCircularSerialization || !serializedModels.contains('PredictiveModel'))) 'predictiveModels': predictiveModels?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(projects != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'projects': projects?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(properties != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'properties': properties?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyAmenities != null && (!preventCircularSerialization || !serializedModels.contains('PropertyAmenity'))) 'propertyAmenities': propertyAmenities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyCompliance != null && (!preventCircularSerialization || !serializedModels.contains('PropertyCompliance'))) 'propertyCompliance': propertyCompliance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyDisclosures != null && (!preventCircularSerialization || !serializedModels.contains('PropertyDisclosure'))) 'propertyDisclosures': propertyDisclosures?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyDocuments != null && (!preventCircularSerialization || !serializedModels.contains('PropertyDocument'))) 'propertyDocuments': propertyDocuments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(inventories != null && (!preventCircularSerialization || !serializedModels.contains('PropertyInventory'))) 'inventories': inventories?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyOffers != null && (!preventCircularSerialization || !serializedModels.contains('PropertyOffer'))) 'propertyOffers': propertyOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyPhotos != null && (!preventCircularSerialization || !serializedModels.contains('PropertyPhoto'))) 'propertyPhotos': propertyPhotos?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyViewings != null && (!preventCircularSerialization || !serializedModels.contains('PropertyViewing'))) 'propertyViewings': propertyViewings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(queueConfigurations != null && (!preventCircularSerialization || !serializedModels.contains('QueueConfiguration'))) 'queueConfigurations': queueConfigurations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(queueMessages != null && (!preventCircularSerialization || !serializedModels.contains('QueueMessage'))) 'queueMessages': queueMessages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(quotes != null && (!preventCircularSerialization || !serializedModels.contains('Quote'))) 'quotes': quotes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(recommendationResults != null && (!preventCircularSerialization || !serializedModels.contains('RecommendationResult'))) 'recommendationResults': recommendationResults?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(referrals != null && (!preventCircularSerialization || !serializedModels.contains('Referral'))) 'referrals': referrals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rentArrears != null && (!preventCircularSerialization || !serializedModels.contains('RentArrears'))) 'rentArrears': rentArrears?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rentSchedules != null && (!preventCircularSerialization || !serializedModels.contains('RentSchedule'))) 'rentSchedules': rentSchedules?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rentalSyncJobs != null && (!preventCircularSerialization || !serializedModels.contains('RentalSyncJob'))) 'rentalSyncJobs': rentalSyncJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reports != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'reports': reports?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reportExecutions != null && (!preventCircularSerialization || !serializedModels.contains('ReportExecution'))) 'reportExecutions': reportExecutions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reservations != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservations': reservations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reviews != null && (!preventCircularSerialization || !serializedModels.contains('Review'))) 'reviews': reviews?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rightToRentChecks != null && (!preventCircularSerialization || !serializedModels.contains('RightToRentCheck'))) 'rightToRentChecks': rightToRentChecks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(roles != null && (!preventCircularSerialization || !serializedModels.contains('Role'))) 'roles': roles?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(routes != null && (!preventCircularSerialization || !serializedModels.contains('Route'))) 'routes': routes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(securityDepositProtections != null && (!preventCircularSerialization || !serializedModels.contains('SecurityDepositProtection'))) 'securityDepositProtections': securityDepositProtections?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(signatureRequests != null && (!preventCircularSerialization || !serializedModels.contains('SignatureRequest'))) 'signatureRequests': signatureRequests?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(signatureSigners != null && (!preventCircularSerialization || !serializedModels.contains('SignatureSigner'))) 'signatureSigners': signatureSigners?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(solicitorManagements != null && (!preventCircularSerialization || !serializedModels.contains('SolicitorManagement'))) 'solicitorManagements': solicitorManagements?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(subscriptions != null && (!preventCircularSerialization || !serializedModels.contains('Subscription'))) 'subscriptions': subscriptions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(systemMetrics != null && (!preventCircularSerialization || !serializedModels.contains('SystemMetrics'))) 'systemMetrics': systemMetrics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tags != null && (!preventCircularSerialization || !serializedModels.contains('Tag'))) 'tags': tags?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tax1099Forms != null && (!preventCircularSerialization || !serializedModels.contains('Tax1099Form'))) 'tax1099Forms': tax1099Forms?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(taxDepreciations != null && (!preventCircularSerialization || !serializedModels.contains('TaxDepreciation'))) 'taxDepreciations': taxDepreciations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(taxRecords != null && (!preventCircularSerialization || !serializedModels.contains('TaxRecord'))) 'taxRecords': taxRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenantApplications != null && (!preventCircularSerialization || !serializedModels.contains('TenantApplication'))) 'tenantApplications': tenantApplications?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(userActivityLogs != null && (!preventCircularSerialization || !serializedModels.contains('UserActivityLog'))) 'userActivityLogs': userActivityLogs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(userPreferences != null && (!preventCircularSerialization || !serializedModels.contains('UserPreference'))) 'userPreferences': userPreferences?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(vacationRentals != null && (!preventCircularSerialization || !serializedModels.contains('VacationRental'))) 'vacationRentals': vacationRentals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(vendors != null && (!preventCircularSerialization || !serializedModels.contains('VendorProfile'))) 'vendors': vendors?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(virtualTours != null && (!preventCircularSerialization || !serializedModels.contains('VirtualTour'))) 'virtualTours': virtualTours?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(webhooks != null && (!preventCircularSerialization || !serializedModels.contains('Webhook'))) 'webhooks': webhooks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(webhookDeliveries != null && (!preventCircularSerialization || !serializedModels.contains('WebhookDelivery'))) 'webhookDeliveries': webhookDeliveries?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(escrowAccounts != null && (!preventCircularSerialization || !serializedModels.contains('EscrowAccount'))) 'escrowAccounts': escrowAccounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(escrowReleases != null && (!preventCircularSerialization || !serializedModels.contains('EscrowRelease'))) 'escrowReleases': escrowReleases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(escrowDisputes != null && (!preventCircularSerialization || !serializedModels.contains('EscrowDispute'))) 'escrowDisputes': escrowDisputes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(paymentNegotiations != null && (!preventCircularSerialization || !serializedModels.contains('PaymentNegotiation'))) 'paymentNegotiations': paymentNegotiations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(paymentInstallments != null && (!preventCircularSerialization || !serializedModels.contains('PaymentInstallment'))) 'paymentInstallments': paymentInstallments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(videoContents != null && (!preventCircularSerialization || !serializedModels.contains('VideoContent'))) 'videoContents': videoContents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(brandAmbassadors != null && (!preventCircularSerialization || !serializedModels.contains('BrandAmbassador'))) 'brandAmbassadors': brandAmbassadors?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(ambassadorCampaigns != null && (!preventCircularSerialization || !serializedModels.contains('AmbassadorCampaign'))) 'ambassadorCampaigns': ambassadorCampaigns?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(socialImpactCounters != null && (!preventCircularSerialization || !serializedModels.contains('SocialImpactCounter'))) 'socialImpactCounters': socialImpactCounters?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(socialImpactRecords != null && (!preventCircularSerialization || !serializedModels.contains('SocialImpactRecord'))) 'socialImpactRecords': socialImpactRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(negotiationOffers != null && (!preventCircularSerialization || !serializedModels.contains('NegotiationOffer'))) 'negotiationOffers': negotiationOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(ambassadorContracts != null && (!preventCircularSerialization || !serializedModels.contains('AmbassadorContract'))) 'ambassadorContracts': ambassadorContracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(escrowStatusHistories != null && (!preventCircularSerialization || !serializedModels.contains('EscrowStatusHistory'))) 'escrowStatusHistories': escrowStatusHistories?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiChatMessages != null && (!preventCircularSerialization || !serializedModels.contains('AIChatMessage'))) 'aiChatMessages': aiChatMessages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(aiChatHandoffs != null && (!preventCircularSerialization || !serializedModels.contains('AIChatHandoff'))) 'aiChatHandoffs': aiChatHandoffs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analyses != null && (!preventCircularSerialization || !serializedModels.contains('DocumentAnalysis'))) 'analyses': analyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analysisJobs != null && (!preventCircularSerialization || !serializedModels.contains('AnalysisJob'))) 'analysisJobs': analysisJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($requiredInspectionsCount != null || $aiChatbotSessionsCount != null || $aiFraudDetectionsCount != null || $aiImageAnalysesCount != null || $aiInvestmentAnalysesCount != null || $aiLeadScoresCount != null || $aiLeadScoringModelsCount != null || $aiMarketAnalysesCount != null || $aiModelsCount != null || $aiModelDeploymentsCount != null || $aiPredictionsCount != null || $aiPredictiveMaintenanceCount != null || $aiPriceOptimizationsCount != null || $aiPropertyDescriptionsCount != null || $aiPropertyValuationsCount != null || $aiRecommendationsCount != null || $aiSentimentAnalysesCount != null || $aiTenantScreeningsCount != null || $aiValuationModelsCount != null || $integrationsCount != null || $achievementsCount != null || $agenciesCount != null || $agencyRelationsCount != null || $organizationAgenciesCount != null || $agentAssignmentsCount != null || $agentTeamsCount != null || $amenitiesCount != null || $apiIntegrationsCount != null || $apiKeysCount != null || $appointmentsCount != null || $attachmentsCount != null || $attorneyCasesCount != null || $auditLogsCount != null || $automationExecutionsCount != null || $automationRulesCount != null || $bookingsCount != null || $budgetsCount != null || $calendarEventsCount != null || $commissionsCount != null || $communicationTemplatesCount != null || $contactsCount != null || $contractsCount != null || $contractVersionsCount != null || $dashboardConfigurationsCount != null || $dashboardWidgetsCount != null || $dealsCount != null || $depositProtectionsCount != null || $documentsCount != null || $documentTemplatesCount != null || $earningsCount != null || $eventsCount != null || $eventAttendeesCount != null || $exchangeRatesCount != null || $exportFilesCount != null || $exportJobsCount != null || $externalRentalListingsCount != null || $facilitiesCount != null || $financialRecordsCount != null || $floorPlansCount != null || $giftCardsCount != null || $govtIntegrationsCount != null || $healthChecksCount != null || $homeInformationPacksCount != null || $immigrationStatusChecksCount != null || $integrationLogsCount != null || $investorPortfoliosCount != null || $keysCount != null || $leadsCount != null || $leadSourcesCount != null || $leasesCount != null || $leaseRenewalsCount != null || $ledgerEntriesCount != null || $listingsCount != null || $listingChannelsCount != null || $listingStatusHistoriesCount != null || $listingTagsCount != null || $locationsCount != null || $loyaltyAccountsCount != null || $mlsConnectionsCount != null || $mlsexternalListingsCount != null || $mlssyncJobsCount != null || $maintenanceBlocksCount != null || $workOrdersCount != null || $mapLayersCount != null || $marketingCampaignsCount != null || $messagesCount != null || $mlsDataMappingsCount != null || $mlsListingEnhancementsCount != null || $mobileDevicesCount != null || $mortgageOffersCount != null || $mortgagePreApprovalsCount != null || $neighborhoodsCount != null || $notificationsCount != null || $offlineSyncQueuesCount != null || $payoutsCount != null || $performanceAlertsCount != null || $predictiveModelsCount != null || $projectsCount != null || $propertiesCount != null || $propertyAmenitiesCount != null || $propertyComplianceCount != null || $propertyDisclosuresCount != null || $propertyDocumentsCount != null || $inventoriesCount != null || $propertyOffersCount != null || $propertyPhotosCount != null || $propertyViewingsCount != null || $queueConfigurationsCount != null || $queueMessagesCount != null || $quotesCount != null || $recommendationResultsCount != null || $referralsCount != null || $rentArrearsCount != null || $rentSchedulesCount != null || $rentalSyncJobsCount != null || $reportsCount != null || $reportExecutionsCount != null || $reservationsCount != null || $reviewsCount != null || $rightToRentChecksCount != null || $rolesCount != null || $routesCount != null || $securityDepositProtectionsCount != null || $signatureRequestsCount != null || $signatureSignersCount != null || $solicitorManagementsCount != null || $subscriptionsCount != null || $systemMetricsCount != null || $tagsCount != null || $tasksCount != null || $tax1099FormsCount != null || $taxDepreciationsCount != null || $taxRecordsCount != null || $tenantApplicationsCount != null || $userActivityLogsCount != null || $userPreferencesCount != null || $vacationRentalsCount != null || $vendorsCount != null || $virtualToursCount != null || $webhooksCount != null || $webhookDeliveriesCount != null || $escrowAccountsCount != null || $escrowReleasesCount != null || $escrowDisputesCount != null || $paymentNegotiationsCount != null || $paymentInstallmentsCount != null || $videoContentsCount != null || $brandAmbassadorsCount != null || $ambassadorCampaignsCount != null || $socialImpactCountersCount != null || $socialImpactRecordsCount != null || $negotiationOffersCount != null || $ambassadorContractsCount != null || $escrowStatusHistoriesCount != null || $aiChatMessagesCount != null || $aiChatHandoffsCount != null || $analysesCount != null || $analysisJobsCount != null) '_count': { 
		if ($requiredInspectionsCount != null) 'requiredInspections': $requiredInspectionsCount, 
		if ($aiChatbotSessionsCount != null) 'aiChatbotSessions': $aiChatbotSessionsCount, 
		if ($aiFraudDetectionsCount != null) 'aiFraudDetections': $aiFraudDetectionsCount, 
		if ($aiImageAnalysesCount != null) 'aiImageAnalyses': $aiImageAnalysesCount, 
		if ($aiInvestmentAnalysesCount != null) 'aiInvestmentAnalyses': $aiInvestmentAnalysesCount, 
		if ($aiLeadScoresCount != null) 'aiLeadScores': $aiLeadScoresCount, 
		if ($aiLeadScoringModelsCount != null) 'aiLeadScoringModels': $aiLeadScoringModelsCount, 
		if ($aiMarketAnalysesCount != null) 'aiMarketAnalyses': $aiMarketAnalysesCount, 
		if ($aiModelsCount != null) 'aiModels': $aiModelsCount, 
		if ($aiModelDeploymentsCount != null) 'aiModelDeployments': $aiModelDeploymentsCount, 
		if ($aiPredictionsCount != null) 'aiPredictions': $aiPredictionsCount, 
		if ($aiPredictiveMaintenanceCount != null) 'aiPredictiveMaintenance': $aiPredictiveMaintenanceCount, 
		if ($aiPriceOptimizationsCount != null) 'aiPriceOptimizations': $aiPriceOptimizationsCount, 
		if ($aiPropertyDescriptionsCount != null) 'aiPropertyDescriptions': $aiPropertyDescriptionsCount, 
		if ($aiPropertyValuationsCount != null) 'aiPropertyValuations': $aiPropertyValuationsCount, 
		if ($aiRecommendationsCount != null) 'aiRecommendations': $aiRecommendationsCount, 
		if ($aiSentimentAnalysesCount != null) 'aiSentimentAnalyses': $aiSentimentAnalysesCount, 
		if ($aiTenantScreeningsCount != null) 'aiTenantScreenings': $aiTenantScreeningsCount, 
		if ($aiValuationModelsCount != null) 'aiValuationModels': $aiValuationModelsCount, 
		if ($integrationsCount != null) 'integrations': $integrationsCount, 
		if ($achievementsCount != null) 'achievements': $achievementsCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($agencyRelationsCount != null) 'agencyRelations': $agencyRelationsCount, 
		if ($organizationAgenciesCount != null) 'organizationAgencies': $organizationAgenciesCount, 
		if ($agentAssignmentsCount != null) 'agentAssignments': $agentAssignmentsCount, 
		if ($agentTeamsCount != null) 'agentTeams': $agentTeamsCount, 
		if ($amenitiesCount != null) 'amenities': $amenitiesCount, 
		if ($apiIntegrationsCount != null) 'apiIntegrations': $apiIntegrationsCount, 
		if ($apiKeysCount != null) 'apiKeys': $apiKeysCount, 
		if ($appointmentsCount != null) 'appointments': $appointmentsCount, 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		if ($attorneyCasesCount != null) 'attorneyCases': $attorneyCasesCount, 
		if ($auditLogsCount != null) 'auditLogs': $auditLogsCount, 
		if ($automationExecutionsCount != null) 'automationExecutions': $automationExecutionsCount, 
		if ($automationRulesCount != null) 'automationRules': $automationRulesCount, 
		if ($bookingsCount != null) 'bookings': $bookingsCount, 
		if ($budgetsCount != null) 'budgets': $budgetsCount, 
		if ($calendarEventsCount != null) 'calendarEvents': $calendarEventsCount, 
		if ($commissionsCount != null) 'commissions': $commissionsCount, 
		if ($communicationTemplatesCount != null) 'communicationTemplates': $communicationTemplatesCount, 
		if ($contactsCount != null) 'contacts': $contactsCount, 
		if ($contractsCount != null) 'contracts': $contractsCount, 
		if ($contractVersionsCount != null) 'contractVersions': $contractVersionsCount, 
		if ($dashboardConfigurationsCount != null) 'dashboardConfigurations': $dashboardConfigurationsCount, 
		if ($dashboardWidgetsCount != null) 'dashboardWidgets': $dashboardWidgetsCount, 
		if ($dealsCount != null) 'deals': $dealsCount, 
		if ($depositProtectionsCount != null) 'depositProtections': $depositProtectionsCount, 
		if ($documentsCount != null) 'documents': $documentsCount, 
		if ($documentTemplatesCount != null) 'documentTemplates': $documentTemplatesCount, 
		if ($earningsCount != null) 'earnings': $earningsCount, 
		if ($eventsCount != null) 'events': $eventsCount, 
		if ($eventAttendeesCount != null) 'eventAttendees': $eventAttendeesCount, 
		if ($exchangeRatesCount != null) 'exchangeRates': $exchangeRatesCount, 
		if ($exportFilesCount != null) 'exportFiles': $exportFilesCount, 
		if ($exportJobsCount != null) 'exportJobs': $exportJobsCount, 
		if ($externalRentalListingsCount != null) 'externalRentalListings': $externalRentalListingsCount, 
		if ($facilitiesCount != null) 'facilities': $facilitiesCount, 
		if ($financialRecordsCount != null) 'financialRecords': $financialRecordsCount, 
		if ($floorPlansCount != null) 'floorPlans': $floorPlansCount, 
		if ($giftCardsCount != null) 'giftCards': $giftCardsCount, 
		if ($govtIntegrationsCount != null) 'govtIntegrations': $govtIntegrationsCount, 
		if ($healthChecksCount != null) 'healthChecks': $healthChecksCount, 
		if ($homeInformationPacksCount != null) 'homeInformationPacks': $homeInformationPacksCount, 
		if ($immigrationStatusChecksCount != null) 'immigrationStatusChecks': $immigrationStatusChecksCount, 
		if ($integrationLogsCount != null) 'integrationLogs': $integrationLogsCount, 
		if ($investorPortfoliosCount != null) 'investorPortfolios': $investorPortfoliosCount, 
		if ($keysCount != null) 'keys': $keysCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		if ($leadSourcesCount != null) 'leadSources': $leadSourcesCount, 
		if ($leasesCount != null) 'leases': $leasesCount, 
		if ($leaseRenewalsCount != null) 'leaseRenewals': $leaseRenewalsCount, 
		if ($ledgerEntriesCount != null) 'ledgerEntries': $ledgerEntriesCount, 
		if ($listingsCount != null) 'listings': $listingsCount, 
		if ($listingChannelsCount != null) 'listingChannels': $listingChannelsCount, 
		if ($listingStatusHistoriesCount != null) 'listingStatusHistories': $listingStatusHistoriesCount, 
		if ($listingTagsCount != null) 'listingTags': $listingTagsCount, 
		if ($locationsCount != null) 'locations': $locationsCount, 
		if ($loyaltyAccountsCount != null) 'loyaltyAccounts': $loyaltyAccountsCount, 
		if ($mlsConnectionsCount != null) 'mlsConnections': $mlsConnectionsCount, 
		if ($mlsexternalListingsCount != null) 'mlsexternalListings': $mlsexternalListingsCount, 
		if ($mlssyncJobsCount != null) 'mlssyncJobs': $mlssyncJobsCount, 
		if ($maintenanceBlocksCount != null) 'maintenanceBlocks': $maintenanceBlocksCount, 
		if ($workOrdersCount != null) 'workOrders': $workOrdersCount, 
		if ($mapLayersCount != null) 'mapLayers': $mapLayersCount, 
		if ($marketingCampaignsCount != null) 'marketingCampaigns': $marketingCampaignsCount, 
		if ($messagesCount != null) 'messages': $messagesCount, 
		if ($mlsDataMappingsCount != null) 'mlsDataMappings': $mlsDataMappingsCount, 
		if ($mlsListingEnhancementsCount != null) 'mlsListingEnhancements': $mlsListingEnhancementsCount, 
		if ($mobileDevicesCount != null) 'mobileDevices': $mobileDevicesCount, 
		if ($mortgageOffersCount != null) 'mortgageOffers': $mortgageOffersCount, 
		if ($mortgagePreApprovalsCount != null) 'mortgagePreApprovals': $mortgagePreApprovalsCount, 
		if ($neighborhoodsCount != null) 'neighborhoods': $neighborhoodsCount, 
		if ($notificationsCount != null) 'notifications': $notificationsCount, 
		if ($offlineSyncQueuesCount != null) 'offlineSyncQueues': $offlineSyncQueuesCount, 
		if ($payoutsCount != null) 'payouts': $payoutsCount, 
		if ($performanceAlertsCount != null) 'performanceAlerts': $performanceAlertsCount, 
		if ($predictiveModelsCount != null) 'predictiveModels': $predictiveModelsCount, 
		if ($projectsCount != null) 'projects': $projectsCount, 
		if ($propertiesCount != null) 'properties': $propertiesCount, 
		if ($propertyAmenitiesCount != null) 'propertyAmenities': $propertyAmenitiesCount, 
		if ($propertyComplianceCount != null) 'propertyCompliance': $propertyComplianceCount, 
		if ($propertyDisclosuresCount != null) 'propertyDisclosures': $propertyDisclosuresCount, 
		if ($propertyDocumentsCount != null) 'propertyDocuments': $propertyDocumentsCount, 
		if ($inventoriesCount != null) 'inventories': $inventoriesCount, 
		if ($propertyOffersCount != null) 'propertyOffers': $propertyOffersCount, 
		if ($propertyPhotosCount != null) 'propertyPhotos': $propertyPhotosCount, 
		if ($propertyViewingsCount != null) 'propertyViewings': $propertyViewingsCount, 
		if ($queueConfigurationsCount != null) 'queueConfigurations': $queueConfigurationsCount, 
		if ($queueMessagesCount != null) 'queueMessages': $queueMessagesCount, 
		if ($quotesCount != null) 'quotes': $quotesCount, 
		if ($recommendationResultsCount != null) 'recommendationResults': $recommendationResultsCount, 
		if ($referralsCount != null) 'referrals': $referralsCount, 
		if ($rentArrearsCount != null) 'rentArrears': $rentArrearsCount, 
		if ($rentSchedulesCount != null) 'rentSchedules': $rentSchedulesCount, 
		if ($rentalSyncJobsCount != null) 'rentalSyncJobs': $rentalSyncJobsCount, 
		if ($reportsCount != null) 'reports': $reportsCount, 
		if ($reportExecutionsCount != null) 'reportExecutions': $reportExecutionsCount, 
		if ($reservationsCount != null) 'reservations': $reservationsCount, 
		if ($reviewsCount != null) 'reviews': $reviewsCount, 
		if ($rightToRentChecksCount != null) 'rightToRentChecks': $rightToRentChecksCount, 
		if ($rolesCount != null) 'roles': $rolesCount, 
		if ($routesCount != null) 'routes': $routesCount, 
		if ($securityDepositProtectionsCount != null) 'securityDepositProtections': $securityDepositProtectionsCount, 
		if ($signatureRequestsCount != null) 'signatureRequests': $signatureRequestsCount, 
		if ($signatureSignersCount != null) 'signatureSigners': $signatureSignersCount, 
		if ($solicitorManagementsCount != null) 'solicitorManagements': $solicitorManagementsCount, 
		if ($subscriptionsCount != null) 'subscriptions': $subscriptionsCount, 
		if ($systemMetricsCount != null) 'systemMetrics': $systemMetricsCount, 
		if ($tagsCount != null) 'tags': $tagsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($tax1099FormsCount != null) 'tax1099Forms': $tax1099FormsCount, 
		if ($taxDepreciationsCount != null) 'taxDepreciations': $taxDepreciationsCount, 
		if ($taxRecordsCount != null) 'taxRecords': $taxRecordsCount, 
		if ($tenantApplicationsCount != null) 'tenantApplications': $tenantApplicationsCount, 
		if ($userActivityLogsCount != null) 'userActivityLogs': $userActivityLogsCount, 
		if ($userPreferencesCount != null) 'userPreferences': $userPreferencesCount, 
		if ($vacationRentalsCount != null) 'vacationRentals': $vacationRentalsCount, 
		if ($vendorsCount != null) 'vendors': $vendorsCount, 
		if ($virtualToursCount != null) 'virtualTours': $virtualToursCount, 
		if ($webhooksCount != null) 'webhooks': $webhooksCount, 
		if ($webhookDeliveriesCount != null) 'webhookDeliveries': $webhookDeliveriesCount, 
		if ($escrowAccountsCount != null) 'escrowAccounts': $escrowAccountsCount, 
		if ($escrowReleasesCount != null) 'escrowReleases': $escrowReleasesCount, 
		if ($escrowDisputesCount != null) 'escrowDisputes': $escrowDisputesCount, 
		if ($paymentNegotiationsCount != null) 'paymentNegotiations': $paymentNegotiationsCount, 
		if ($paymentInstallmentsCount != null) 'paymentInstallments': $paymentInstallmentsCount, 
		if ($videoContentsCount != null) 'videoContents': $videoContentsCount, 
		if ($brandAmbassadorsCount != null) 'brandAmbassadors': $brandAmbassadorsCount, 
		if ($ambassadorCampaignsCount != null) 'ambassadorCampaigns': $ambassadorCampaignsCount, 
		if ($socialImpactCountersCount != null) 'socialImpactCounters': $socialImpactCountersCount, 
		if ($socialImpactRecordsCount != null) 'socialImpactRecords': $socialImpactRecordsCount, 
		if ($negotiationOffersCount != null) 'negotiationOffers': $negotiationOffersCount, 
		if ($ambassadorContractsCount != null) 'ambassadorContracts': $ambassadorContractsCount, 
		if ($escrowStatusHistoriesCount != null) 'escrowStatusHistories': $escrowStatusHistoriesCount, 
		if ($aiChatMessagesCount != null) 'aiChatMessages': $aiChatMessagesCount, 
		if ($aiChatHandoffsCount != null) 'aiChatHandoffs': $aiChatHandoffsCount, 
		if ($analysesCount != null) 'analyses': $analysesCount, 
		if ($analysisJobsCount != null) 'analysisJobs': $analysisJobsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Organization &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    