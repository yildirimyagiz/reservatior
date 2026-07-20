import { Elysia } from "elysia";
import { escrowGuardMiddleware } from "./middleware/escrow-guard";
import { dashboardSummaryRoutes } from "./routes/dashboard-summary";
import { authRoutes } from "./routes/auth";
import { adminRoutes } from "./routes/admin";
import { dynamicAdminRoutes } from "./routes/dynamic_admin";
import { configRoutes } from "./routes/config";
import { systemRoutes } from "./routes/system";
import { feedRoutes } from "./routes/feed";
import { aiRoutes } from "./routes/ai";
import { aiSearchRoutes } from "./routes/ai-search";
import { aiSearchStreamRoutes } from "./routes/ai-search-stream";
import { aiCreditRoutes } from "./routes/ai-credits";
import { hoaRoutes } from "./routes/hoa";
import { userRoutes } from "./routes/user";
import { dataBrowserRoutes } from "./routes/data-browser";
import { chatProxyRoutes } from "./routes/chat-proxy";
import { contractGenerationRoutes } from "./routes/contract-generation";
import { sessionRoutes } from "./routes/session";
import { organizationRoutes } from "./routes/organization";
import { analysisJobRoutes } from "./routes/analysis-job";
import { documentAnalysesRoutes } from "./routes/document-analyses";
import { roleRoutes } from "./routes/role";
import { permissionRoutes } from "./routes/permission";
import { rolePermissionRoutes } from "./routes/role-permission";
import { apiTokenRoutes } from "./routes/api-token";
import { contactRoutes } from "./routes/contact";
import { vendorProfileRoutes } from "./routes/vendor-profile";
import { agentAssignmentRoutes } from "./routes/agent-assignment";
import { propertyRoutes } from "./routes/property";
import { listingRoutes } from "./routes/listing";
import { listingStatusHistoryRoutes } from "./routes/listing-status-history";
import { tagRoutes } from "./routes/tag";
import { listingTagRoutes } from "./routes/listing-tag";
import { bookingRoutes } from "./routes/booking";
import { maintenanceBlockRoutes } from "./routes/maintenance-block";
import { leaseRoutes } from "./routes/lease";
import { rentScheduleRoutes } from "./routes/rent-schedule";
import { financialRecordRoutes } from "./routes/financial-record";
import { taxRecordRoutes } from "./routes/tax-record";
import { attachmentRoutes } from "./routes/attachment";
import { ledgerEntryRoutes } from "./routes/ledger-entry";
import { exchangeRateRoutes } from "./routes/exchange-rate";
import { exportJobRoutes } from "./routes/export-job";
import { exportFileRoutes } from "./routes/export-file";
import { governmentIntegrationRoutes } from "./routes/government-integration";
import { leadRoutes } from "./routes/lead";
import { leadSourceRoutes } from "./routes/lead-source";
import { locationRoutes } from "./routes/location";
import { dealRoutes } from "./routes/deal";
import { documentRoutes } from "./routes/document";
import { payoutRoutes } from "./routes/payout";
import { mapLayerRoutes } from "./routes/map-layer";
import { routeRoutes } from "./routes/route";
import { apiIntegrationRoutes } from "./routes/api-integration";
import { homeInformationPackRoutes } from "./routes/home-information-pack";
import { depositProtectionRoutes } from "./routes/deposit-protection";
import { rightToRentCheckRoutes } from "./routes/right-to-rent-check";
import { solicitorManagementRoutes } from "./routes/solicitor-management";
import { mortgageOfferRoutes } from "./routes/mortgage-offer";
import { rentalSyncJobRoutes } from "./routes/rental-sync-job";
import { externalRentalListingRoutes } from "./routes/external-rental-listing";
import { vacationRentalRoutes } from "./routes/vacation-rental";
import { vacationRentalPlatformRoutes } from "./routes/vacation-rental-platform";
import { mlsDataMappingRoutes } from "./routes/mls-data-mapping";
import { mlsListingEnhancementRoutes } from "./routes/mls-listing-enhancement";
import { listingChannelRoutes } from "./routes/listing-channel";
import { investorPortfolioRoutes } from "./routes/investor-portfolio";
import { investorPropertyRoutes } from "./routes/investor-property";
import { propertyValuationRoutes } from "./routes/property-valuation";
import { agentTeamRoutes } from "./routes/agent-team";
import { agentTeamMemberRoutes } from "./routes/agent-team-member";
import { agentPerformanceRoutes } from "./routes/agent-performance";
import { agentsRoutes } from "./routes/agents";
import { clientRelationshipRoutes } from "./routes/client-relationship";
import { tenantApplicationRoutes } from "./routes/tenant-application";
import { maintenanceWorkOrderRoutes } from "./routes/maintenance-work-order";
import { leaseRenewalRoutes } from "./routes/lease-renewal";
import { guestProfileRoutes } from "./routes/guest-profile";
import { guestReviewRoutes } from "./routes/guest-review";
import { taxDepreciationRoutes } from "./routes/tax-depreciation";
import { tax1099FormRoutes } from "./routes/tax1099-form";
import { dashboardWidgetRoutes } from "./routes/dashboard-widget";
import { predictiveModelRoutes } from "./routes/predictive-model";
import { loyaltyAccountRoutes } from "./routes/loyalty-account";
import { referralRoutes } from "./routes/referral";
import { subscriptionRoutes } from "./routes/subscription";
import { partnerAgreementRoutes } from "./routes/partner-agreement";
import { agentMatchingRoutes } from "./routes/agent-matching";
import { giftCardRoutes } from "./routes/gift-card";
import { achievementRoutes } from "./routes/achievement";
import { earningRoutes } from "./routes/earning";
import { jobRoutes } from "./routes/job";
import { notificationRoutes } from "./routes/notification";
import { messageRoutes } from "./routes/message";
import { taskRoutes } from "./routes/task";
import { facilityRoutes } from "./routes/facility";
import { contractRoutes } from "./routes/contract";
import { contractVersionRoutes } from "./routes/contract-version";
import { signatureRequestRoutes } from "./routes/signature-request";
import { signatureSignerRoutes } from "./routes/signature-signer";
import { userFinancialProfileRoutes } from "./routes/user-financial-profile";
import { userPreferenceRoutes } from "./routes/user-preference";
import { userActivityLogRoutes } from "./routes/user-activity-log";
import { apiKeyRoutes } from "./routes/api-key";
import { reviewRoutes } from "./routes/review";
import { marketingCampaignRoutes } from "./routes/marketing-campaign";
import { orgSubscriptionRoutes } from "./routes/org-subscription";
import { planRoutes } from "./routes/plan";
import { mlsconnectionRoutes } from "./routes/mlsconnection";
import { mlssyncJobRoutes } from "./routes/mlssync-job";
import { mlsexternalListingRoutes } from "./routes/mlsexternal-listing";
import { commissionRoutes } from "./routes/commission";
import { propertyPhotoRoutes } from "./routes/property-photo";
import { propertyComplianceRoutes } from "./routes/property-compliance";
import { propertyDocumentRoutes } from "./routes/property-document";
import { amenityRoutes } from "./routes/amenity";
import { propertyAmenityRoutes } from "./routes/property-amenity";
import { neighborhoodRoutes } from "./routes/neighborhood";
import { recommendationResultRoutes } from "./routes/recommendation-result";
import { eventRoutes } from "./routes/event";
import { eventAttendeeRoutes } from "./routes/event-attendee";
import { propertyOfferRoutes } from "./routes/property-offer";
import { reservationRoutes } from "./routes/reservation";
import { documentTemplateRoutes } from "./routes/document-template";
import { appointmentRoutes } from "./routes/appointment";
import { calendarEventRoutes } from "./routes/calendar-event";
import { reportRoutes } from "./routes/report";
import { reportExecutionRoutes } from "./routes/report-execution";
import { webhookRoutes } from "./routes/webhook";
import { webhookDeliveryRoutes } from "./routes/webhook-delivery";
import { auditLogRoutes } from "./routes/audit-log";
import { communicationTemplateRoutes } from "./routes/communication-template";
import { budgetRoutes } from "./routes/budget";
import { quoteRoutes } from "./routes/quote";
import { projectRoutes } from "./routes/project";
import { floorPlanRoutes } from "./routes/floor-plan";
import { virtualTourRoutes } from "./routes/virtual-tour";
import { keyManagementRoutes } from "./routes/key-management";
import { propertyInventoryRoutes } from "./routes/property-inventory";
import { securityDepositProtectionRoutes } from "./routes/security-deposit-protection";
import { propertyViewingRoutes } from "./routes/property-viewing";
import { propertyDisclosureRoutes } from "./routes/property-disclosure";
import { immigrationStatusCheckRoutes } from "./routes/immigration-status-check";
import { rentArrearsRoutes } from "./routes/rent-arrears";
import { attorneyManagementRoutes } from "./routes/attorney-management";
import { mortgagePreApprovalRoutes } from "./routes/mortgage-pre-approval";
import { aimodelRoutes } from "./routes/aimodel";
import { aimodelDeploymentRoutes } from "./routes/aimodel-deployment";
import { aipredictionRoutes } from "./routes/aiprediction";
import { queueMessageRoutes } from "./routes/queue-message";
import { queueConfigurationRoutes } from "./routes/queue-configuration";
import { integrationLogRoutes } from "./routes/integration-log";
import { instagramRoutes } from "./routes/instagram";
import { automationRuleRoutes } from "./routes/automation-rule";
import { automationExecutionRoutes } from "./routes/automation-execution";
import { aivaluationModelRoutes } from "./routes/aivaluation-model";
import { aipropertyValuationRoutes } from "./routes/aiproperty-valuation";
import { aileadScoringRoutes } from "./routes/ailead-scoring";
import { aileadScoreRoutes } from "./routes/ailead-score";
import { aimarketAnalysisRoutes } from "./routes/aimarket-analysis";
import { aipropertyDescriptionRoutes } from "./routes/aiproperty-description";
import { aiimageAnalysisRoutes } from "./routes/aiimage-analysis";
import { aipriceOptimizationRoutes } from "./routes/aiprice-optimization";
import { aisentimentAnalysisRoutes } from "./routes/aisentiment-analysis";
import { aifraudDetectionRoutes } from "./routes/aifraud-detection";
import { airecommendationRoutes } from "./routes/airecommendation";
import { aiChatbotSessionsRoutes } from "./routes/ai-chatbot-sessions";
import { aipredictiveMaintenanceRoutes } from "./routes/aipredictive-maintenance";
import { aitenantScreeningRoutes } from "./routes/aitenant-screening";
import { aiinvestmentAnalysisRoutes } from "./routes/aiinvestment-analysis";
import { mobileDeviceRoutes } from "./routes/mobile-device";
import { offlineSyncQueueRoutes } from "./routes/offline-sync-queue";
import { dashboardConfigurationRoutes } from "./routes/dashboard-configuration";
import { systemMetricsRoutes } from "./routes/system-metrics";
import { healthCheckRoutes } from "./routes/health-check";
import { performanceAlertRoutes } from "./routes/performance-alert";
import { escrowAccountRoutes } from "./routes/escrow-account";
import { escrowReleaseRoutes } from "./routes/escrow-release";
import { escrowDisputeRoutes } from "./routes/escrow-dispute";
import { aiChatMessagesRoutes } from "./routes/ai-chat-messages";
import { aiChatHandoffsRoutes } from "./routes/ai-chat-handoffs";
import { paymentNegotiationRoutes } from "./routes/payment-negotiation";
import { negotiationOfferRoutes } from "./routes/negotiation-offer";
import { paymentInstallmentRoutes } from "./routes/payment-installment";
import { videoContentRoutes } from "./routes/video-content";
import { brandAmbassadorRoutes } from "./routes/brand-ambassador";
import { ambassadorContractRoutes } from "./routes/ambassador-contract";
import { ambassadorCampaignRoutes } from "./routes/ambassador-campaign";
import { socialImpactCounterRoutes } from "./routes/social-impact-counter";
import { socialImpactRecordRoutes } from "./routes/social-impact-record";
import { escrowStatusHistoryRoutes } from "./routes/escrow-status-history";
import { accountRoutes } from "./routes/account";
import { agencyRoutes } from "./routes/agency";
import { agentRoutes } from "./routes/agent";
import { analyticsRoutes } from "./routes/analytics";
import { automationTaskRoutes } from "./routes/automation-task";
import { availabilityRoutes } from "./routes/availability";
import { channelRoutes } from "./routes/channel";
import { commissionRuleRoutes } from "./routes/commission-rule";
import { communicationLogRoutes } from "./routes/communication-log";
import { complianceRecordRoutes } from "./routes/compliance-record";
import { currencyRoutes } from "./routes/currency";
import { discountRoutes } from "./routes/discount";
import { expenseRoutes } from "./routes/expense";
import { extraChargeRoutes } from "./routes/extra-charge";
import { facilityBlockRoutes } from "./routes/facility-block";
import { favoriteRoutes } from "./routes/favorite";
import { guestRoutes } from "./routes/guest";
import { hashtagRoutes } from "./routes/hashtag";
import { includedServiceRoutes } from "./routes/included-service";
import { increaseRoutes } from "./routes/increase";
import { languageRoutes } from "./routes/language";
import { mlconfigurationRoutes } from "./routes/mlconfiguration";
import { mlmodelRoutes } from "./routes/mlmodel";
import { mapDataRoutes } from "./routes/map-data";
import { mentionRoutes } from "./routes/mention";
import { mortgageRoutes } from "./routes/mortgage";
import { offerRoutes } from "./routes/offer";
import { paymentRoutes } from "./routes/payment";
import { photoRoutes } from "./routes/photo";
import { postRoutes } from "./routes/post";
import { pricingRuleRoutes } from "./routes/pricing-rule";
import { projectAlertRoutes } from "./routes/project-alert";
import { projectAnalyticsRoutes } from "./routes/project-analytics";
import { projectReportRoutes } from "./routes/project-report";
import { propertyPromotionRoutes } from "./routes/property-promotion";
import { referenceSourceRoutes } from "./routes/reference-source";
import { scrapingJobRoutes } from "./routes/scraping-job";
import { sharedAmenityRoutes } from "./routes/shared-amenity";
import { tenantRoutes } from "./routes/tenant";
import { ticketRoutes } from "./routes/ticket";
import { verificationRoutes } from "./routes/verification";
import { propertyOwnershipVerificationRoutes } from "./routes/property-ownership-verification";
import { ownershipVerificationDocumentRoutes } from "./routes/ownership-verification-document";
import { propertyOwnershipTransferRoutes } from "./routes/property-ownership-transfer";
import { bookingSecurityScreeningRoutes } from "./routes/booking-security-screening";
import { videoVendorRoutes } from "./routes/video-vendor";
import { videoVendorPartnershipRoutes } from "./routes/video-vendor-partnership";
import { agentVideoRoutes } from "./routes/agent-video";
import { agentEarningRoutes } from "./routes/agent-earning";
import { vendorEarningRoutes } from "./routes/vendor-earning";
import { partnershipEarningRoutes } from "./routes/partnership-earning";
import { videoQualityReviewRoutes } from "./routes/video-quality-review";
import { vendorQualityReviewRoutes } from "./routes/vendor-quality-review";
import { valuationRequestRoutes } from "./routes/valuation-request";
import { valuationReportRoutes } from "./routes/valuation-report";
import { leadConversionRoutes } from "./routes/lead-conversion";
import { marketInsightRoutes } from "./routes/market-insight";
import { userValuationPreferenceRoutes } from "./routes/user-valuation-preference";
import { videoEarningRoutes } from "./routes/video-earning";
import { legalComplianceRoutes } from "./routes/legal-compliance";
import { globalTaxRegulationRoutes } from "./routes/global-tax-regulation";
import { smartLockRoutes } from "./routes/smart-lock";
import { accessCodeRoutes } from "./routes/access-code";
import { accessLogRoutes } from "./routes/access-log";
import { stayOccupantRoutes } from "./routes/stay-occupant";
import { policeReportRoutes } from "./routes/police-report";
import { kbsReportLogRoutes } from "./routes/kbs-report-log";
import { hostPenaltyRoutes } from "./routes/host-penalty";
import { identityDocumentRoutes } from "./routes/identity-document";
import { marketRateComparisonRoutes } from "./routes/market-rate-comparison";
import { featureAddOnRoutes } from "./routes/feature-add-on";
import { platformRevenueRecordRoutes } from "./routes/platform-revenue-record";
import { aiServiceTaskRoutes } from "./routes/ai-service-task";
import { aiVideoGenerationRoutes } from "./routes/ai-video-generation";
import { videoCaptionRoutes } from "./routes/video-caption";
import { aiBrochureGenerationRoutes } from "./routes/ai-brochure-generation";
import { aiExtractedDataRoutes } from "./routes/ai-extracted-data";
import { categoryRoutes } from "./routes/category";
import { categoryTranslationRoutes } from "./routes/category-translation";
import { stripeWebhookRoutes } from "./routes/stripe-webhook";
import { mediaUploadRoutes } from "./routes/media-upload";
import { externalImportRoutes } from "./routes/external-import";
import { aiMigrationRoutes } from "./routes/ai-migration";
import { mlsRoutes } from "./routes/mls";
import { googleHotelsFeed } from "./routes/google-hotels-feed";
import { checkoutService } from "./routes/checkout";
import { staticPlugin } from "@elysiajs/static";
import { whatsappRouter } from "./pages/whatsapp";
import { searchRoutes } from "./routes/search";
import { globalActivityRoutes } from "./routes/global-activity";
import { escrowRoutes } from "./routes/escrow";
import { b2bHotelsRoutes } from "./routes/b2b-hotels";
import { marketplaceRoutes } from "./routes/marketplace";
import { hotelBookingSyncRoutes } from "./routes/hotel-booking-sync";
import { aiArbitrageRoutes } from "./routes/ai-arbitrage";
import { publicApiRoutes } from "./routes/public-api";
import { aiAdsSeoRoutes } from "./routes/ai-ads-seo";
import { aiBlogCronRoutes } from "./routes/ai-blog-cron";
import { aiMarketingCronRoutes } from "./routes/ai-marketing-cron";
import { systemCronRoutes } from "./routes/system-cron";
import { dashboardAnalyticsRoutes } from "./routes/dashboard-analytics";
import { aiCrmRoutes } from "./routes/ai-crm-api";
import { mlsSyncRoutes } from "./routes/mls-sync";
import { channelManagerRoutes } from "./routes/channel-manager";
import { listingTagsRoutes } from "./routes/listing-tags";
import { telemetryRoutes } from "./routes/telemetry";

import { experiencesRoutes } from "./routes/experiences";
import { transfersRoutes } from "./routes/transfers";
import { conciergeRoutes } from "./routes/concierge";
import { socialAccountRoutes } from "./routes/social-account";
import { socialAccountMetricRoutes } from "./routes/social-accountmetric";
import { socialAIContentRoutes } from "./routes/social-aicontent";
import { socialAutomationRuleRoutes } from "./routes/social-automationrule";
import { socialCommentReplyRoutes } from "./routes/social-commentreply";
import { socialInboundMessageRoutes } from "./routes/social-inboundmessage";
import { socialPostRoutes } from "./routes/social-post";
import { fileLifecycleRoutes } from "./routes/file-lifecycle";
import { invoiceRoutes } from "./routes/invoice";
import { mediaServeRoutes } from "./routes/media-serve";
import { realtimeRoutes } from "./routes/realtime";
import { triggerRoutes } from "./routes/triggers";
import { workerRoutes } from "./routes/workers";
import { adminLegacyRoutes } from "./routes/admin-legacy";
import { aichatHandoffRoutes } from "./routes/aichat-handoff";
import { turkeyRoutes } from "./routes/turkey";
import { marketAnalysisRoutes } from "./routes/market-analysis";
import { securityRoutes } from "./routes/security";
import { strRoutes } from "./routes/str";
import { cloudRoutes } from "./routes/cloud";
import { orchestrationRoutes } from "./routes/orchestration";
import { salesProcessRoutes } from "./routes/sales-process";
import { identityComplianceRoutes } from "./routes/identity-compliance";
import { tax1099Routes } from "./routes/tax-1099";
import { financeOSRoutes } from "./routes/finance-os";
import { bookingOSRoutes } from "./routes/booking-os";
import { listingOSRoutes } from "./routes/listing-os";
import { agentOSRoutes } from "./routes/agent-os";
import { cleaningStandardRoutes } from "./routes/cleaning-standard";
import { reputationRoutes } from "./routes/reputation";
import { kumbaraDepositRoutes } from "./routes/kumbara-deposit";
import { universalTrustScoreRoutes } from "./routes/universal-trust-score";
import { purchaseIntentRoutes } from "./routes/purchase-intent";
import { reoPortfolioRoutes } from "./routes/reo-portfolio";
import { financialAuditLogRoutes } from "./routes/financial-audit-log";
import { bankAccountRoutes } from "./routes/bank-account";
import { productRoutes } from "./routes/product";
import { supplierRoutes } from "./routes/supplier";
import { productBundleRoutes } from "./routes/product-bundle";
import { commerceAgentRoutes } from "./routes/commerce-agent";
import { commissionEngineRoutes } from "./routes/commission-engine";
import { commerceOrderRoutes } from "./routes/commerce-order";
import { commerceCampaignRoutes } from "./routes/commerce-campaign";
import { incomeCertificateRoutes, publicCertificateRoutes } from "./routes/income-certificate";
import { assetMarketplaceRoutes } from "./routes/asset-marketplace";
import { seoDataRoutes } from "./routes/seo-data";
import { investmentOSRoutes } from "./routes/investment-os";
import { operationsOSRoutes } from "./routes/operations-os";
import { securityOSRoutes } from "./routes/security-os";
import { governanceOSRoutes } from "./routes/governance-os";
import { partnerOSRoutes } from "./routes/partner-os";
import { developerOSRoutes } from "./routes/developer-os";
import { analyticsOSRoutes } from "./routes/analytics-os";
import { documentOSRoutes } from "./routes/document-os";
import { notificationOSRoutes } from "./routes/notification-os";
import { userOSRoutes } from "./routes/user-os";
import { adsOSRoutes } from "./routes/ads-os";

// Route Clusters to optimize TypeScript instantiation depth
const cluster1 = new Elysia()
  .use(userRoutes)
  .use(sessionRoutes)
  .use(organizationRoutes)
  .use(analysisJobRoutes)
  .use(documentAnalysesRoutes)
  .use(roleRoutes)
  .use(permissionRoutes)
  .use(rolePermissionRoutes)
  .use(apiTokenRoutes)
  .use(contactRoutes)
  .use(vendorProfileRoutes)
  .use(agentAssignmentRoutes)
  .use(aiSearchRoutes)
  .use(aiSearchStreamRoutes)
  .use(aiCreditRoutes)
  .use(propertyRoutes)
  .use(listingRoutes)
  .use(listingStatusHistoryRoutes)
  .use(tagRoutes)
  .use(listingTagRoutes)
  .use(bookingRoutes)
  .use(maintenanceBlockRoutes)
  .use(leaseRoutes)
  .use(rentScheduleRoutes)
  .use(financialRecordRoutes)
  .use(taxRecordRoutes)
  .use(attachmentRoutes)
  .use(ledgerEntryRoutes)
;

const cluster2 = new Elysia()
  .use(exchangeRateRoutes)
  .use(exportJobRoutes)
  .use(exportFileRoutes)
  .use(governmentIntegrationRoutes)
  .use(leadRoutes)
  .use(leadSourceRoutes)
  .use(locationRoutes)
  .use(dealRoutes)
  .use(documentRoutes)
  .use(payoutRoutes)
  .use(mapLayerRoutes)
  .use(routeRoutes)
  .use(apiIntegrationRoutes)
  .use(homeInformationPackRoutes)
  .use(depositProtectionRoutes)
  .use(rightToRentCheckRoutes)
  .use(solicitorManagementRoutes)
  .use(mortgageOfferRoutes)
  .use(rentalSyncJobRoutes)
  .use(externalRentalListingRoutes)
  .use(vacationRentalRoutes)
  .use(vacationRentalPlatformRoutes)
  .use(mlsDataMappingRoutes)
  .use(mlsListingEnhancementRoutes)
  .use(listingChannelRoutes)
;

const cluster3 = new Elysia()
  .use(investorPortfolioRoutes)
  .use(investorPropertyRoutes)
  .use(propertyValuationRoutes)
  .use(agentTeamRoutes)
  .use(agentTeamMemberRoutes)
  .use(agentPerformanceRoutes)
  .use(clientRelationshipRoutes)
  .use(tenantApplicationRoutes)
  .use(maintenanceWorkOrderRoutes)
  .use(leaseRenewalRoutes)
  .use(guestProfileRoutes)
  .use(guestReviewRoutes)
  .use(taxDepreciationRoutes)
  .use(tax1099FormRoutes)
  .use(dashboardWidgetRoutes)
  .use(predictiveModelRoutes)
  .use(loyaltyAccountRoutes)
  .use(referralRoutes)
  .use(subscriptionRoutes)
  .use(partnerAgreementRoutes)
  .use(agentMatchingRoutes)
  .use(giftCardRoutes)
  .use(achievementRoutes)
  .use(earningRoutes)
  .use(jobRoutes)
  .use(notificationRoutes)
  .use(messageRoutes)
;

const cluster4 = new Elysia()
  .use(taskRoutes)
  .use(facilityRoutes)
  .use(contractRoutes)
  .use(contractVersionRoutes)
  .use(signatureRequestRoutes)
  .use(signatureSignerRoutes)
  .use(userFinancialProfileRoutes)
  .use(userPreferenceRoutes)
  .use(userActivityLogRoutes)
  .use(apiKeyRoutes)
  .use(reviewRoutes)
  .use(marketingCampaignRoutes)
  .use(orgSubscriptionRoutes)
  .use(planRoutes)
  .use(mlsconnectionRoutes)
  .use(mlssyncJobRoutes)
  .use(mlsexternalListingRoutes)
  .use(commissionRoutes)
  .use(propertyPhotoRoutes)
  .use(propertyComplianceRoutes)
  .use(propertyDocumentRoutes)
  .use(amenityRoutes)
  .use(propertyAmenityRoutes)
  .use(neighborhoodRoutes)
  .use(recommendationResultRoutes)
;

const cluster5 = new Elysia()
  .use(eventRoutes)
  .use(eventAttendeeRoutes)
  .use(propertyOfferRoutes)
  .use(reservationRoutes)
  .use(documentTemplateRoutes)
  .use(appointmentRoutes)
  .use(calendarEventRoutes)
  .use(reportRoutes)
  .use(reportExecutionRoutes)
  .use(webhookRoutes)
  .use(webhookDeliveryRoutes)
  .use(auditLogRoutes)
  .use(communicationTemplateRoutes)
  .use(budgetRoutes)
  .use(quoteRoutes)
  .use(projectRoutes)
  .use(floorPlanRoutes)
  .use(virtualTourRoutes)
  .use(keyManagementRoutes)
  .use(propertyInventoryRoutes)
  .use(securityDepositProtectionRoutes)
  .use(propertyViewingRoutes)
  .use(propertyDisclosureRoutes)
  .use(immigrationStatusCheckRoutes)
  .use(rentArrearsRoutes)
;

const cluster6 = new Elysia()
  .use(attorneyManagementRoutes)
  .use(mortgagePreApprovalRoutes)
  .use(aimodelRoutes)
  .use(aimodelDeploymentRoutes)
  .use(aipredictionRoutes)
  .use(queueMessageRoutes)
  .use(queueConfigurationRoutes)
  .use(integrationLogRoutes)
  .use(instagramRoutes)
  .use(automationRuleRoutes)
  .use(automationExecutionRoutes)
  .use(aivaluationModelRoutes)
  .use(aipropertyValuationRoutes)
  .use(aileadScoringRoutes)
  .use(aileadScoreRoutes)
  .use(aimarketAnalysisRoutes)
  .use(aipropertyDescriptionRoutes)
  .use(aiimageAnalysisRoutes)
  .use(aipriceOptimizationRoutes)
  .use(aisentimentAnalysisRoutes)
  .use(aifraudDetectionRoutes)
  .use(airecommendationRoutes)
  .use(aiChatbotSessionsRoutes)
  .use(aipredictiveMaintenanceRoutes)
  .use(aitenantScreeningRoutes)
  .use(aiinvestmentAnalysisRoutes)
;

const cluster7 = new Elysia()
  .use(mobileDeviceRoutes)
  .use(offlineSyncQueueRoutes)
  .use(dashboardConfigurationRoutes)
  .use(systemMetricsRoutes)
  .use(healthCheckRoutes)
  .use(performanceAlertRoutes)
  .use(escrowAccountRoutes)
  .use(escrowReleaseRoutes)
  .use(escrowDisputeRoutes)
  .use(aiChatMessagesRoutes)
  .use(aiChatHandoffsRoutes)
  .use(paymentNegotiationRoutes)
  .use(negotiationOfferRoutes)
  .use(paymentInstallmentRoutes)
  .use(videoContentRoutes)
  .use(brandAmbassadorRoutes)
  .use(ambassadorContractRoutes)
  .use(ambassadorCampaignRoutes)
  .use(socialImpactCounterRoutes)
  .use(socialImpactRecordRoutes)
  .use(escrowStatusHistoryRoutes)
  .use(accountRoutes)
  .use(agencyRoutes)
  .use(agentRoutes)
  .use(analyticsRoutes)
;

const cluster8 = new Elysia()
  .use(automationTaskRoutes)
  .use(availabilityRoutes)
  .use(channelRoutes)
  .use(commissionRuleRoutes)
  .use(communicationLogRoutes)
  .use(complianceRecordRoutes)
  .use(currencyRoutes)
  .use(discountRoutes)
  .use(expenseRoutes)
  .use(extraChargeRoutes)
  .use(facilityBlockRoutes)
  .use(favoriteRoutes)
  .use(guestRoutes)
  .use(hashtagRoutes)
  .use(includedServiceRoutes)
  .use(increaseRoutes)
  .use(languageRoutes)
  .use(mlconfigurationRoutes)
  .use(mlmodelRoutes)
  .use(mapDataRoutes)
  .use(mentionRoutes)
  .use(mortgageRoutes)
  .use(offerRoutes)
  .use(paymentRoutes)
  .use(photoRoutes)
  .use(agentsRoutes)
;

const cluster9 = new Elysia()
  .use(postRoutes)
  .use(pricingRuleRoutes)
  .use(projectAlertRoutes)
  .use(projectAnalyticsRoutes)
  .use(projectReportRoutes)
  .use(propertyPromotionRoutes)
  .use(referenceSourceRoutes)
  .use(scrapingJobRoutes)
  .use(sharedAmenityRoutes)
  .use(tenantRoutes)
  .use(ticketRoutes)
  .use(verificationRoutes)
  .use(propertyOwnershipVerificationRoutes)
  .use(ownershipVerificationDocumentRoutes)
  .use(propertyOwnershipTransferRoutes)
  .use(bookingSecurityScreeningRoutes)
  .use(videoVendorRoutes)
  .use(videoVendorPartnershipRoutes)
  .use(agentVideoRoutes)
  .use(agentEarningRoutes)
  .use(vendorEarningRoutes)
  .use(partnershipEarningRoutes)
  .use(videoQualityReviewRoutes)
  .use(vendorQualityReviewRoutes)
  .use(valuationRequestRoutes)
;

const cluster10 = new Elysia()
  .use(valuationReportRoutes)
  .use(leadConversionRoutes)
  .use(marketInsightRoutes)
  .use(userValuationPreferenceRoutes)
  .use(videoEarningRoutes)
  .use(legalComplianceRoutes)
  .use(globalTaxRegulationRoutes)
  .use(smartLockRoutes)
  .use(accessCodeRoutes)
  .use(accessLogRoutes)
  .use(stayOccupantRoutes)
  .use(policeReportRoutes)
  .use(identityDocumentRoutes)
  .use(marketRateComparisonRoutes)
  .use(featureAddOnRoutes)
  .use(platformRevenueRecordRoutes)
  .use(aiServiceTaskRoutes)
  .use(aiVideoGenerationRoutes)
  .use(videoCaptionRoutes)
  .use(aiBrochureGenerationRoutes)
  .use(aiExtractedDataRoutes)
  .use(categoryRoutes)
  .use(categoryTranslationRoutes)
  .use(kbsReportLogRoutes)
  .use(hostPenaltyRoutes)
;


const cluster11 = new Elysia()
  .use(socialAccountRoutes)
  .use(socialAccountMetricRoutes)
  .use(socialAIContentRoutes)
  .use(socialAutomationRuleRoutes)
  .use(socialCommentReplyRoutes)
  .use(socialInboundMessageRoutes)
  .use(socialPostRoutes)
  .use(fileLifecycleRoutes)
  .use(invoiceRoutes)
  .use(mediaServeRoutes)
  .use(realtimeRoutes)
  .use(experiencesRoutes)
  .use(transfersRoutes)
  .use(conciergeRoutes)
  .use(triggerRoutes)
  .use(workerRoutes)
;

export const router = new Elysia({ prefix: "/api/v1" })
  .use(authRoutes)
  .use(escrowGuardMiddleware)
  .use(dashboardSummaryRoutes)
  .use(searchRoutes)
  .use(globalActivityRoutes)
  .use(escrowRoutes)
  .use(b2bHotelsRoutes)
  .use(marketplaceRoutes)
  .use(hotelBookingSyncRoutes)
  .use(adminRoutes)
  .use(dynamicAdminRoutes)
  .use(configRoutes)
  .use(systemRoutes)
  .use(feedRoutes)
  .use(aiRoutes)
  .use(aiArbitrageRoutes)
  .use(aiBlogCronRoutes)
  .use(aiMarketingCronRoutes)
  .use(systemCronRoutes)
  .use(dashboardAnalyticsRoutes)
  .use(aiCrmRoutes)
  .use(hoaRoutes)
  .use(cluster1)
  .use(cluster2)
  .use(cluster3)
  .use(cluster4)
  .use(cluster5)
  .use(cluster6)
  .use(cluster7)
  .use(cluster8)
  .use(cluster9)
  .use(cluster10)
  .use(cluster11)
  .use(stripeWebhookRoutes)
  .use(mediaUploadRoutes)
  .use(dataBrowserRoutes)
  .use(externalImportRoutes)
  .use(aiMigrationRoutes)
  .use(mlsRoutes)
  .use(googleHotelsFeed)
  .use(publicApiRoutes)
  .use(checkoutService)
  .use(contractGenerationRoutes)
  .use(whatsappRouter)
  .use(chatProxyRoutes)
  .use(mlsSyncRoutes)
  .use(channelManagerRoutes)
  .use(listingTagsRoutes)
  .use(telemetryRoutes)
  .use(adminLegacyRoutes)
  .use(aichatHandoffRoutes)
  .use(turkeyRoutes)
  .use(marketAnalysisRoutes)
  .use(securityRoutes)
  .use(strRoutes)
  .use(cloudRoutes)
  .use(orchestrationRoutes)
  .use(salesProcessRoutes)
  .use(tax1099Routes)
  .use(financeOSRoutes)
  .use(bookingOSRoutes)
  .use(listingOSRoutes)
  .use(agentOSRoutes)
  .use(cleaningStandardRoutes)
  .use(reputationRoutes)
  .use(kumbaraDepositRoutes)
  .use(universalTrustScoreRoutes)
  .use(purchaseIntentRoutes)
  .use(reoPortfolioRoutes)
  .use(financialAuditLogRoutes)
  .use(bankAccountRoutes)
  .use(productRoutes)
  .use(supplierRoutes)
  .use(productBundleRoutes)
  .use(commerceAgentRoutes)
  .use(commissionEngineRoutes)
  .use(commerceOrderRoutes)
  .use(commerceCampaignRoutes)
  .use(publicCertificateRoutes)
  .use(incomeCertificateRoutes)
  .use(seoDataRoutes)
  .use(assetMarketplaceRoutes)
  .use(investmentOSRoutes)
  .use(operationsOSRoutes)
  .use(securityOSRoutes)
  .use(governanceOSRoutes)
  .use(partnerOSRoutes)
  .use(developerOSRoutes)
  .use(analyticsOSRoutes)
  .use(documentOSRoutes)
  .use(notificationOSRoutes)
  .use(userOSRoutes)
  .use(adsOSRoutes)
;
