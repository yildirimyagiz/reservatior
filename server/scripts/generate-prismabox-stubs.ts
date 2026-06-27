import { writeFileSync, mkdirSync } from "fs";
import { join } from "path";

const models = [
  "AccessCode", "AccessLog", "Account", "Achievement", "Agency", "Agent", "AgentAssignment",
  "AgentEarning", "AgentPerformance", "AgentTeam", "AgentTeamMember", "AgentVideo",
  "AIChatbotSession", "AIChatHandoff", "AIChatMessage", "AIFraudDetection", "AIImageAnalysis",
  "AIInvestmentAnalysis", "AILeadScore", "AILeadScoring", "AIMarketAnalysis", "AIModel",
  "AIModelDeployment", "AIPrediction", "AIPredictiveMaintenance", "AIPriceOptimization",
  "AIPropertyDescription", "AIPropertyValuation", "AIRecommendation", "AISentimentAnalysis",
  "AITenantScreening", "AIValuationModel", "AiBrochureGeneration", "AiExtractedData",
  "AiServiceTask", "AiVideoGeneration", "AmbassadorCampaign", "AmbassadorContract", "Amenity",
  "AnalysisJob", "Analytics", "ApiIntegration", "ApiKey", "ApiToken", "Appointment",
  "Attachment", "AttorneyManagement", "AuditLog", "AutomationExecution", "AutomationRule",
  "AutomationTask", "Availability", "Booking", "BookingSecurityScreening", "BrandAmbassador",
  "Budget", "CalendarEvent", "Category", "CategoryTranslation", "Channel",
  "ClientRelationship", "Commission", "CommissionRule", "CommunicationLog",
  "CommunicationTemplate", "ComplianceRecord", "Contact", "Contract", "ContractVersion",
  "Currency", "DashboardConfiguration", "DashboardWidget", "Deal", "DepositProtection",
  "Discount", "Document", "DocumentAnalysis", "DocumentTemplate", "Earning", "EscrowAccount",
  "EscrowDispute", "EscrowRelease", "EscrowSplitConfig", "EscrowStatusHistory", "Event",
  "EventAttendee", "ExchangeRate", "Expense", "ExportFile", "ExportJob",
  "ExternalRentalListing", "ExtraCharge", "Facility", "FacilityBlock", "Favorite",
  "FeatureAddOn", "FinancialRecord", "FloorPlan", "GiftCard", "GlobalTaxRegulation",
  "GovernmentIntegration", "Guest", "GuestProfile", "GuestReview", "GuestVerification",
  "Hashtag", "HealthCheck", "HomeInformationPack", "IdentityDocument",
  "ImmigrationStatusCheck", "IncludedService", "Increase", "IntegrationLog",
  "InvestorPortfolio", "InvestorProperty", "Job", "KeyManagement", "Language", "Lead",
  "LeadConversion", "LeadSource", "Lease", "LeaseRenewal", "LedgerEntry", "LegalCompliance",
  "Listing", "ListingChannel", "ListingStatusHistory", "ListingTag", "Location",
  "LoyaltyAccount", "MaintenanceBlock", "MaintenanceWorkOrder", "MapData", "MapLayer",
  "MarketInsight", "MarketingCampaign", "MarketRateComparison", "Mention", "Message",
  "MLConfiguration", "MLModel", "MLSConnection", "MlsDataMapping", "MLSExternalListing",
  "MlsListingEnhancement", "MLSSyncJob", "MobileDevice", "Mortgage", "MortgageOffer",
  "MortgagePreApproval", "NegotiationOffer", "Neighborhood", "Notification",
  "NotificationTemplate", "Offer", "OfflineSyncQueue", "OperatorLicense", "Organization",
  "OrganizationMember", "OrgSubscription", "OwnershipVerificationDocument",
  "PartnershipEarning", "Payment", "PaymentInstallment", "PaymentNegotiation", "Payout",
  "PerformanceAlert", "Permission", "Photo", "Plan", "PlatformRevenueRecord", "PoliceReport",
  "Post", "PredictiveModel", "PricingRule", "Project", "ProjectAlert", "ProjectAnalytics",
  "ProjectReport", "Property", "PropertyAmenity", "PropertyCompliance", "PropertyDisclosure",
  "PropertyDocument", "PropertyInventory", "PropertyOffer", "PropertyOwnershipTransfer",
  "PropertyOwnershipVerification", "PropertyPhoto", "PropertyPromotion",
  "PropertySecurityConfig", "PropertyValuation", "PropertyViewing", "QueueConfiguration",
  "QueueMessage", "Quote", "RecommendationResult", "ReferenceSource", "Referral",
  "RentalSyncJob", "RentArrears", "RentSchedule", "Report", "ReportExecution",
  "Reservation", "Review", "RightToRentCheck", "Role", "RolePermission", "Route",
  "ScrapingJob", "SecurityDepositProtection", "SecurityIncident", "Session",
  "SharedAmenity", "SignatureRequest", "SignatureSigner", "SmartLock", "SocialAccount",
  "SocialAccountMetric", "SocialAIContent", "SocialAutomationRule", "SocialCommentReply",
  "SocialImpactCounter", "SocialImpactRecord", "SocialInboundMessage", "SocialPost",
  "SolicitorManagement", "StayOccupant", "Subscription", "SystemEvent", "SystemMetrics",
  "Tag", "Task", "Tax1099Form", "TaxDepreciation", "TaxRecord", "Tenant",
  "TenantApplication", "TenantReliabilityScore", "TenantVerificationStage", "Ticket",
  "TRPropertyDocumentRecord", "TRTaxDeclaration", "UKPropertyCertificateRecord", "User",
  "UserActivityLog", "UserFinancialProfile", "UserPreference", "UserValuationPreference",
  "USPropertyAssessment", "USPublicTaxRecord", "VacationRental", "VacationRentalPlatform",
  "ValuationReport", "ValuationRequest", "VendorEarning", "VendorProfile",
  "VendorQualityReview", "Verification", "VideoCaption", "VideoContent", "VideoEarning",
  "VideoQualityReview", "VideoVendor", "VideoVendorPartnership", "VirtualTour",
  "VrpMandate", "Webhook", "WebhookDelivery",
];

const outputDir = join(__dirname, "..", "generated", "prismabox");
mkdirSync(outputDir, { recursive: true });

const anyObject = "t.Object({})";
const anyPartial = "t.Partial(t.Object({}))";

for (const name of models) {
  const content = `import { t } from "elysia";

export const ${name}Plain = ${anyObject};
export const ${name}PlainInputCreate = ${anyPartial};
export const ${name}PlainInputUpdate = ${anyPartial};
export const ${name}Relations = ${anyObject};
export const ${name} = t.Composite([${name}Plain, ${name}Relations]);
export const ${name}Where = ${anyPartial};
export const ${name}WhereUnique = t.Object({ id: t.String() });
export const ${name}Select = ${anyPartial};
export const ${name}Include = ${anyPartial};
export const ${name}OrderBy = ${anyPartial};
export const ${name}InputCreate = t.Composite([${name}PlainInputCreate, t.Object({})]);
export const ${name}InputUpdate = t.Composite([${name}PlainInputUpdate, t.Object({})]);
`;

  writeFileSync(join(outputDir, `${name}.ts`), content);
}

console.log(`Generated stub files for ${models.length} models in ${outputDir}`);
