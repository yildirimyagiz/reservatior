// Otomatik üretilmiş Valibot schema'ları (TR)
// Generated: 2026-06-22T17:05:32.335Z

import * as v from 'valibot';

// --- ENUMS ---
export enum Region {
  TR = "TR",
  UAE = "UAE",
  UK = "UK",
  USA = "USA",
  RU = "RU",
  CN = "CN",
  GLOBAL = "GLOBAL",
  FR = "FR",
  DE = "DE",
  SA = "SA",
  CA = "CA",
  SG = "SG",
  ES = "ES",
  IT = "IT",
  JP = "JP",
  KR = "KR",
  AU = "AU",
  NZ = "NZ",
  NL = "NL",
  MX = "MX",
  BR = "BR",
  IN = "IN",
  TH = "TH",
  MY = "MY",
  AR = "AR",
  USA_NORTHEAST = "USA_NORTHEAST",
  USA_SOUTH = "USA_SOUTH",
  USA_MIDWEST = "USA_MIDWEST",
  USA_WEST = "USA_WEST",
  USA_SOUTHWEST = "USA_SOUTHWEST"
}
export const RegionSchema = v.enum_(Region);

export enum OrgType {
  OWNER_PORTFOLIO = "OWNER_PORTFOLIO",
  VENDOR_PM = "VENDOR_PM",
  AGENCY = "AGENCY",
  ACCOUNTING_FIRM = "ACCOUNTING_FIRM",
  PUBLIC_ENTITY = "PUBLIC_ENTITY"
}
export const OrgTypeSchema = v.enum_(OrgType);

export enum MemberRoleKey {
  ORG_ADMIN = "ORG_ADMIN"
}
export const MemberRoleKeySchema = v.enum_(MemberRoleKey);

export enum PermissionKey {
  ORG_MANAGE = "ORG_MANAGE",
  USERS_MANAGE = "USERS_MANAGE",
  FINANCE_MANAGE = "FINANCE_MANAGE",
  TAX_MANAGE = "TAX_MANAGE",
  REPORTS_VIEW = "REPORTS_VIEW",
  EXPORTS_MANAGE = "EXPORTS_MANAGE",
  NOTIFICATIONS_MANAGE = "NOTIFICATIONS_MANAGE",
  MLS_MANAGE = "MLS_MANAGE",
  GOV_INTEGRATIONS_MANAGE = "GOV_INTEGRATIONS_MANAGE",
  SETTINGS_MANAGE = "SETTINGS_MANAGE"
}
export const PermissionKeySchema = v.enum_(PermissionKey);

export enum PropertyType {
  STUDIO = "STUDIO",
  PENTHOUSE = "PENTHOUSE"
}
export const PropertyTypeSchema = v.enum_(PropertyType);

export enum ListingType {
  SALE = "SALE",
  RENT = "RENT",
  BOOKING = "BOOKING"
}
export const ListingTypeSchema = v.enum_(ListingType);

export enum ListingStatus {
  DRAFT = "DRAFT",
  VACANT = "VACANT",
  AVAILABLE = "AVAILABLE",
  RESERVED = "RESERVED",
  RENTED = "RENTED",
  BOOKED = "BOOKED",
  WILL_BE_AVAILABLE = "WILL_BE_AVAILABLE",
  MAINTENANCE = "MAINTENANCE",
  SOLD = "SOLD",
  ARCHIVED = "ARCHIVED"
}
export const ListingStatusSchema = v.enum_(ListingStatus);

export enum EarningStrategy {
  LONG_TERM_STABLE = "LONG_TERM_STABLE",
  SHORT_TERM_YIELD = "SHORT_TERM_YIELD",
  FLIP_SALE = "FLIP_SALE",
  MIXED = "MIXED"
}
export const EarningStrategySchema = v.enum_(EarningStrategy);

export enum BookingStatus {
  DRAFT = "DRAFT",
  CONFIRMED = "CONFIRMED",
  CHECKED_IN = "CHECKED_IN",
  CHECKED_OUT = "CHECKED_OUT",
  CANCELLED = "CANCELLED",
  NO_SHOW = "NO_SHOW"
}
export const BookingStatusSchema = v.enum_(BookingStatus);

export enum MaintenanceBlockType {
  MAINTENANCE = "MAINTENANCE",
  OWNER_BLOCK = "OWNER_BLOCK",
  CLEANING_BUFFER = "CLEANING_BUFFER",
  OTHER = "OTHER"
}
export const MaintenanceBlockTypeSchema = v.enum_(MaintenanceBlockType);

export enum TransactionType {
  INCOME = "INCOME",
  EXPENSE = "EXPENSE"
}
export const TransactionTypeSchema = v.enum_(TransactionType);

export enum PaymentStatus {
  UNPAID = "UNPAID",
  PARTIAL = "PARTIAL",
  PAID = "PAID",
  OVERDUE = "OVERDUE",
  CANCELLED = "CANCELLED",
  REFUNDED = "REFUNDED"
}
export const PaymentStatusSchema = v.enum_(PaymentStatus);

export enum BillCategory {
  ELECTRICITY = "ELECTRICITY",
  WATER = "WATER",
  GAS = "GAS",
  INTERNET = "INTERNET",
  HOA = "HOA",
  INSURANCE = "INSURANCE",
  TAX = "TAX",
  OTHER = "OTHER"
}
export const BillCategorySchema = v.enum_(BillCategory);

export enum ContractType {
  RENTAL_LEASE = "RENTAL_LEASE",
  BOOKING_AGREEMENT = "BOOKING_AGREEMENT",
  SALE_AGREEMENT = "SALE_AGREEMENT",
  MANAGEMENT_AGREEMENT = "MANAGEMENT_AGREEMENT",
  VENDOR_SERVICE = "VENDOR_SERVICE",
  OTHER = "OTHER"
}
export const ContractTypeSchema = v.enum_(ContractType);

export enum ContractStatus {
  DRAFT = "DRAFT",
  REVIEW = "REVIEW",
  APPROVED = "APPROVED",
  SIGNING = "SIGNING",
  ACTIVE = "ACTIVE",
  EXPIRING = "EXPIRING",
  RENEWED = "RENEWED",
  TERMINATED = "TERMINATED",
  ARCHIVED = "ARCHIVED"
}
export const ContractStatusSchema = v.enum_(ContractStatus);

export enum SignatureStatus {
  PENDING = "PENDING",
  SIGNED = "SIGNED",
  DECLINED = "DECLINED",
  EXPIRED = "EXPIRED",
  CANCELLED = "CANCELLED"
}
export const SignatureStatusSchema = v.enum_(SignatureStatus);

export enum TaskStatus {
  OPEN = "OPEN",
  IN_PROGRESS = "IN_PROGRESS",
  DONE = "DONE",
  CANCELLED = "CANCELLED",
  BLOCKED = "BLOCKED"
}
export const TaskStatusSchema = v.enum_(TaskStatus);

export enum NotificationChannel {
  IN_APP = "IN_APP",
  EMAIL = "EMAIL",
  SMS = "SMS",
  PUSH = "PUSH",
  WEBHOOK = "WEBHOOK"
}
export const NotificationChannelSchema = v.enum_(NotificationChannel);

export enum NotificationStatus {
  QUEUED = "QUEUED",
  SENT = "SENT",
  FAILED = "FAILED",
  READ = "READ"
}
export const NotificationStatusSchema = v.enum_(NotificationStatus);

export enum MessageParticipantType {
  USER = "USER",
  CONTACT = "CONTACT"
}
export const MessageParticipantTypeSchema = v.enum_(MessageParticipantType);

export enum ContactType {
  TENANT = "TENANT",
  GUEST = "GUEST",
  OWNER_CONTACT = "OWNER_CONTACT",
  VENDOR_CONTACT = "VENDOR_CONTACT",
  OTHER = "OTHER"
}
export const ContactTypeSchema = v.enum_(ContactType);

export enum LedgerEventType {
  INCOME = "INCOME",
  EXPENSE = "EXPENSE",
  BILL = "BILL",
  BOOKING_CREATED = "BOOKING_CREATED",
  BOOKING_UPDATED = "BOOKING_UPDATED",
  LEASE_STARTED = "LEASE_STARTED",
  LEASE_ENDED = "LEASE_ENDED",
  CONTRACT_CREATED = "CONTRACT_CREATED",
  CONTRACT_VERSIONED = "CONTRACT_VERSIONED",
  CONTRACT_RENEWED = "CONTRACT_RENEWED",
  STATUS_CHANGED = "STATUS_CHANGED",
  MAINTENANCE_BLOCKED = "MAINTENANCE_BLOCKED",
  OWNERSHIP_CHANGED = "OWNERSHIP_CHANGED",
  NOTE = "NOTE"
}
export const LedgerEventTypeSchema = v.enum_(LedgerEventType);

export enum TaxCategoryType {
  RENTAL_INCOME = "RENTAL_INCOME",
  ACCOMMODATION_TAX = "ACCOMMODATION_TAX",
  CAPITAL_GAINS = "CAPITAL_GAINS",
  LOCAL_TAX = "LOCAL_TAX",
  VAT = "VAT",
  OTHER = "OTHER"
}
export const TaxCategoryTypeSchema = v.enum_(TaxCategoryType);

export enum TaxPeriod {
  MONTHLY = "MONTHLY",
  QUARTERLY = "QUARTERLY",
  ANNUAL = "ANNUAL"
}
export const TaxPeriodSchema = v.enum_(TaxPeriod);

export enum RiskTolerance {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH"
}
export const RiskToleranceSchema = v.enum_(RiskTolerance);

export enum ExportType {
  LEDGER_CSV = "LEDGER_CSV",
  TAX_SUMMARY_CSV = "TAX_SUMMARY_CSV",
  EVIDENCE_PACK_ZIP = "EVIDENCE_PACK_ZIP",
  GOV_STANDARD_JSON = "GOV_STANDARD_JSON",
  REPORT_PDF_READY_JSON = "REPORT_PDF_READY_JSON"
}
export const ExportTypeSchema = v.enum_(ExportType);

export enum ExportStatus {
  QUEUED = "QUEUED",
  RUNNING = "RUNNING",
  DONE = "DONE",
  FAILED = "FAILED"
}
export const ExportStatusSchema = v.enum_(ExportStatus);

export enum MLSProviderKey {
  RIGHTMOVE = "RIGHTMOVE",
  ZOOPLA = "ZOOPLA",
  ONTHEMARKET = "ONTHEMARKET",
  SAVILLS = "SAVILLS",
  STRATFORD_GRAHAM = "STRATFORD_GRAHAM",
  GENERIC_RETS = "GENERIC_RETS",
  OTHER = "OTHER"
}
export const MLSProviderKeySchema = v.enum_(MLSProviderKey);

export enum SyncStatus {
  IDLE = "IDLE",
  RUNNING = "RUNNING",
  SUCCESS = "SUCCESS",
  FAILED = "FAILED"
}
export const SyncStatusSchema = v.enum_(SyncStatus);

export enum InspectionType {
  MOVE_IN = "MOVE_IN",
  MOVE_OUT = "MOVE_OUT",
  ROUTINE = "ROUTINE",
  EMERGENCY = "EMERGENCY",
  HEALTH_SAFETY = "HEALTH_SAFETY",
  PEST_CONTROL = "PEST_CONTROL",
  STRUCTURAL = "STRUCTURAL",
  ELECTRICAL = "ELECTRICAL",
  PLUMBING = "PLUMBING",
  HVAC = "HVAC"
}
export const InspectionTypeSchema = v.enum_(InspectionType);

export enum InspectionStatus {
  SCHEDULED = "SCHEDULED",
  IN_PROGRESS = "IN_PROGRESS",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED",
  RESCHEDULED = "RESCHEDULED"
}
export const InspectionStatusSchema = v.enum_(InspectionStatus);

export enum AmenityCategory {
  OUTDOOR = "OUTDOOR",
  INDOOR = "INDOOR",
  KITCHEN = "KITCHEN",
  BATHROOM = "BATHROOM",
  SECURITY = "SECURITY",
  PARKING = "PARKING",
  FITNESS = "FITNESS",
  ENTERTAINMENT = "ENTERTAINMENT",
  LAUNDRY = "LAUNDRY",
  STORAGE = "STORAGE",
  UTILITY = "UTILITY",
  OTHER = "OTHER"
}
export const AmenityCategorySchema = v.enum_(AmenityCategory);

export enum ReviewEntityType {
  PROPERTY = "PROPERTY",
  LISTING = "LISTING",
  AGENT = "AGENT",
  AGENCY = "AGENCY",
  VENDOR = "VENDOR"
}
export const ReviewEntityTypeSchema = v.enum_(ReviewEntityType);

export enum CampaignType {
  EMAIL = "EMAIL",
  SOCIAL_MEDIA = "SOCIAL_MEDIA",
  SEARCH_ENGINE = "SEARCH_ENGINE",
  DISPLAY_ADS = "DISPLAY_ADS",
  PRINT = "PRINT",
  EVENT = "EVENT",
  REFERRAL = "REFERRAL",
  DIRECT_MAIL = "DIRECT_MAIL"
}
export const CampaignTypeSchema = v.enum_(CampaignType);

export enum CampaignStatus {
  DRAFT = "DRAFT",
  ACTIVE = "ACTIVE",
  PAUSED = "PAUSED",
  COMPLETED = "COMPLETED",
  CANCELLED = "CANCELLED"
}
export const CampaignStatusSchema = v.enum_(CampaignStatus);

export enum LeadStatus {
  NEW = "NEW",
  CONTACTED = "CONTACTED",
  QUALIFIED = "QUALIFIED",
  CONVERTED = "CONVERTED",
  LOST = "LOST",
  UNQUALIFIED = "UNQUALIFIED",
  NURTURE = "NURTURE"
}
export const LeadStatusSchema = v.enum_(LeadStatus);

export enum SourceType {
  WEBSITE = "WEBSITE",
  PHONE = "PHONE",
  EMAIL = "EMAIL",
  SOCIAL_MEDIA = "SOCIAL_MEDIA",
  REFERRAL = "REFERRAL",
  ADVERTISEMENT = "ADVERTISEMENT",
  OPEN_HOUSE = "OPEN_HOUSE",
  MLS = "MLS",
  WALK_IN = "WALK_IN",
  OTHER = "OTHER"
}
export const SourceTypeSchema = v.enum_(SourceType);

export enum ComplianceType {
  FAIR_HOUSING_ACT = "FAIR_HOUSING_ACT",
  ADA_COMPLIANCE = "ADA_COMPLIANCE",
  ENERGY_EFFICIENCY = "ENERGY_EFFICIENCY",
  BUILDING_CODE = "BUILDING_CODE",
  ELECTRICAL_SAFETY = "ELECTRICAL_SAFETY",
  FIRE_SAFETY = "FIRE_SAFETY",
  IMMIGRATION_CHECK = "IMMIGRATION_CHECK",
  LEAD_PAINT_DISCLOSURE = "LEAD_PAINT_DISCLOSURE",
  MOLD_DISCLOSURE = "MOLD_DISCLOSURE",
  FLOOD_INSURANCE = "FLOOD_INSURANCE",
  PROPERTY_TAXES = "PROPERTY_TAXES",
  HOA_RULES = "HOA_RULES"
}
export const ComplianceTypeSchema = v.enum_(ComplianceType);

export enum DealStatusUSA {
  LEAD = "LEAD",
  PROSPECT = "PROSPECT",
  QUALIFIED = "QUALIFIED",
  UNDER_CONTRACT = "UNDER_CONTRACT",
  CONTINGENT = "CONTINGENT",
  PENDING_CLOSING = "PENDING_CLOSING",
  CLOSED = "CLOSED",
  FALLEN_THROUGH = "FALLEN_THROUGH",
  CANCELLED = "CANCELLED",
  ON_HOLD = "ON_HOLD",
  REACTIVATED = "REACTIVATED"
}
export const DealStatusUSASchema = v.enum_(DealStatusUSA);

export enum DocumentTypeUSA {
  PURCHASE_AGREEMENT = "PURCHASE_AGREEMENT",
  LISTING_AGREEMENT = "LISTING_AGREEMENT",
  LEASE_AGREEMENT = "LEASE_AGREEMENT",
  DISCLOSURE_FORM = "DISCLOSURE_FORM",
  INSPECTION_REPORT = "INSPECTION_REPORT",
  APPRAISAL_REPORT = "APPRAISAL_REPORT",
  TITLE_REPORT = "TITLE_REPORT",
  CLOSING_STATEMENT = "CLOSING_STATEMENT",
  TAX_DOCUMENT = "TAX_DOCUMENT",
  INSURANCE_POLICY = "INSURANCE_POLICY",
  HOA_DOCUMENTS = "HOA_DOCUMENTS",
  PERMIT = "PERMIT",
  LICENSE = "LICENSE",
  CERTIFICATE = "CERTIFICATE",
  FINANCIAL_STATEMENT = "FINANCIAL_STATEMENT",
  VOIDED_CHECK = "VOIDED_CHECK",
  W9_FORM = "W9_FORM",
  FORM_1099 = "FORM_1099"
}
export const DocumentTypeUSASchema = v.enum_(DocumentTypeUSA);

export enum MarkerType {
  PROPERTY_PIN = "PROPERTY_PIN",
  LISTING_PIN = "LISTING_PIN",
  DEAL_PIN = "DEAL_PIN",
  LEAD_PIN = "LEAD_PIN",
  VENDOR_PIN = "VENDOR_PIN",
  SCHOOL_PIN = "SCHOOL_PIN",
  TRANSIT_PIN = "TRANSIT_PIN",
  SHOPPING_PIN = "SHOPPING_PIN",
  PARK_PIN = "PARK_PIN",
  MEDICAL_PIN = "MEDICAL_PIN",
  RESTAURANT_PIN = "RESTAURANT_PIN",
  BANK_PIN = "BANK_PIN",
  GOVERNMENT_PIN = "GOVERNMENT_PIN",
  CUSTOM_PIN = "CUSTOM_PIN"
}
export const MarkerTypeSchema = v.enum_(MarkerType);

export enum MarkerIcon {
  HOME = "HOME",
  BUILDING = "BUILDING",
  APARTMENT = "APARTMENT",
  COMMERCIAL = "COMMERCIAL",
  LAND = "LAND",
  VACANT = "VACANT",
  UNDER_CONSTRUCTION = "UNDER_CONSTRUCTION",
  FOR_SALE = "FOR_SALE",
  FOR_RENT = "FOR_RENT",
  SOLD = "SOLD",
  PENDING = "PENDING",
  SCHOOL = "SCHOOL",
  HOSPITAL = "HOSPITAL",
  PARK = "PARK",
  TRANSIT = "TRANSIT",
  SHOPPING = "SHOPPING",
  RESTAURANT = "RESTAURANT",
  BANK = "BANK",
  GOVERNMENT = "GOVERNMENT",
  CUSTOM = "CUSTOM"
}
export const MarkerIconSchema = v.enum_(MarkerIcon);

export enum MapProvider {
  GOOGLE_MAPS = "GOOGLE_MAPS",
  MAPBOX = "MAPBOX",
  OPENSTREETMAP = "OPENSTREETMAP",
  HERE_MAPS = "HERE_MAPS",
  BING_MAPS = "BING_MAPS",
  ESRI = "ESRI",
  TOMTOM = "TOMTOM"
}
export const MapProviderSchema = v.enum_(MapProvider);

export enum GeocodingStatus {
  PENDING = "PENDING",
  VERIFIED = "VERIFIED",
  FAILED = "FAILED",
  NEEDS_REVIEW = "NEEDS_REVIEW",
  MANUAL_OVERRIDE = "MANUAL_OVERRIDE"
}
export const GeocodingStatusSchema = v.enum_(GeocodingStatus);

export enum RentalPlatform {
  HOTELBEDS = "HOTELBEDS",
  WEBBEDS = "WEBBEDS",
  EPS = "EPS",
  HOTELDO = "HOTELDO"
}
export const RentalPlatformSchema = v.enum_(RentalPlatform);

export enum LocationAccuracy {
  EXACT = "EXACT",
  STREET_LEVEL = "STREET_LEVEL",
  NEIGHBORHOOD_LEVEL = "NEIGHBORHOOD_LEVEL",
  CITY_LEVEL = "CITY_LEVEL",
  APPROXIMATE = "APPROXIMATE",
  ESTIMATED = "ESTIMATED"
}
export const LocationAccuracySchema = v.enum_(LocationAccuracy);

export enum LegalComplianceStatus {
  UNVERIFIED = "UNVERIFIED",
  PENDING = "PENDING",
  VERIFIED = "VERIFIED",
  EXPIRED = "EXPIRED",
  REVOKED = "REVOKED",
  BLOCKLISTED = "BLOCKLISTED"
}
export const LegalComplianceStatusSchema = v.enum_(LegalComplianceStatus);

export enum AddOnType {
  GOVERNMENT_REPORTING = "GOVERNMENT_REPORTING",
  IOT_SMARTLOCK = "IOT_SMARTLOCK",
  SECURE_ESCROW = "SECURE_ESCROW",
  AI_VALUATION_PRO = "AI_VALUATION_PRO",
  VIDEO_BOOST_CREDITS = "VIDEO_BOOST_CREDITS",
  IDENTITY_VERIFICATION = "IDENTITY_VERIFICATION",
  MARKET_INSIGHTS_PRO = "MARKET_INSIGHTS_PRO",
  CHANNEL_SYNC = "CHANNEL_SYNC",
  INSURANCE_PREMIUM = "INSURANCE_PREMIUM"
}
export const AddOnTypeSchema = v.enum_(AddOnType);

export enum AddOnStatus {
  ACTIVE = "ACTIVE",
  EXPIRED = "EXPIRED",
  PENDING_PAYMENT = "PENDING_PAYMENT",
  CANCELLED = "CANCELLED"
}
export const AddOnStatusSchema = v.enum_(AddOnStatus);

export enum RevenueSource {
  BOOKING_COMMISSION = "BOOKING_COMMISSION",
  SALE_COMMISSION = "SALE_COMMISSION",
  ADDON_SUBSCRIPTION = "ADDON_SUBSCRIPTION",
  PROFESSIONAL_VALUATION = "PROFESSIONAL_VALUATION",
  IDENTITY_VERIFICATION_FEE = "IDENTITY_VERIFICATION_FEE",
  ADVERTISING_REELS = "ADVERTISING_REELS",
  IOT_MANAGEMENT_FEE = "IOT_MANAGEMENT_FEE",
  COMPLIANCE_REPORT_FEE = "COMPLIANCE_REPORT_FEE"
}
export const RevenueSourceSchema = v.enum_(RevenueSource);

export enum AiTaskType {
  REELS_VIDEO_GEN = "REELS_VIDEO_GEN",
  PDF_BROCHURE_GEN = "PDF_BROCHURE_GEN",
  DOCUMENT_OCR = "DOCUMENT_OCR",
  FINANCIAL_EXTRACTION = "FINANCIAL_EXTRACTION",
  TRANSLATION_LOCALIZATION = "TRANSLATION_LOCALIZATION",
  PHOTO_ENHANCEMENT = "PHOTO_ENHANCEMENT",
  COMPLIANCE_CHECK = "COMPLIANCE_CHECK"
}
export const AiTaskTypeSchema = v.enum_(AiTaskType);

export enum AiTaskStatus {
  QUEUED = "QUEUED",
  PROCESSING = "PROCESSING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELED = "CANCELED"
}
export const AiTaskStatusSchema = v.enum_(AiTaskStatus);

export enum TRHeatingType {
  GUNEŞ_ENERJISI = "GUNEŞ_ENERJISI"
}
export const TRHeatingTypeSchema = v.enum_(TRHeatingType);

export enum AgentEscrowTxType {
  COMMISSION_EARNED = "COMMISSION_EARNED",
  PAYOUT_WITHDRAWAL = "PAYOUT_WITHDRAWAL"
}
export const AgentEscrowTxTypeSchema = v.enum_(AgentEscrowTxType);

export enum AgentEscrowTxStatus {
  BLOCKED = "BLOCKED",
  PENDING_PAYOUT = "PENDING_PAYOUT",
  SUCCEEDED = "SUCCEEDED",
  FAILED = "FAILED"
}
export const AgentEscrowTxStatusSchema = v.enum_(AgentEscrowTxStatus);

export enum HotelProvider {
  HOTELBEDS = "HOTELBEDS",
  WEBBEDS = "WEBBEDS",
  EPS = "EPS",
  HOTELDO = "HOTELDO"
}
export const HotelProviderSchema = v.enum_(HotelProvider);

export enum PenaltyStatus {
  PENDING = "PENDING",
  PAID = "PAID",
  DEDUCTED_FROM_ESCROW = "DEDUCTED_FROM_ESCROW",
  WAIVED = "WAIVED"
}
export const PenaltyStatusSchema = v.enum_(PenaltyStatus);

export enum KbsStatus {
  PENDING = "PENDING",
  SENT = "SENT",
  SUCCESS = "SUCCESS",
  FAILED = "FAILED"
}
export const KbsStatusSchema = v.enum_(KbsStatus);

// --- MODELS ---
// User Schemas (TR)
export const userCreateSchema = v.object({
  email: v.pipe(v.string(), v.email())
});

export const userUpdateSchema = v.partial(v.object({
  email: v.optional(v.pipe(v.string(), v.email())),
  name: v.optional(v.string()),
  phone: v.optional(v.string()),
  imageUrl: v.optional(v.string()),
  locale: v.optional(v.string()),
  timezone: v.optional(v.string()),
  originRegion: v.optional(v.string()),
  isClone: v.optional(v.boolean()),
  lastSyncedAt: v.optional(v.string())
}));

export type UserCreate = v.InferOutput<typeof userCreateSchema>;
export type UserUpdate = v.InferOutput<typeof userUpdateSchema>;

// Session Schemas (TR)
export const sessionCreateSchema = v.object({
  userId: v.string(),
  tokenHash: v.string(),
  expiresAt: v.string()
});

export const sessionUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  tokenHash: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  ip: v.optional(v.string()),
  userAgent: v.optional(v.string())
}));

export type SessionCreate = v.InferOutput<typeof sessionCreateSchema>;
export type SessionUpdate = v.InferOutput<typeof sessionUpdateSchema>;

// Organization Schemas (TR)
export const organizationCreateSchema = v.object({
  name: v.string(),
  type: v.enum_(OrgType),
  region: v.enum_(Region)
});

export const organizationUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  type: v.optional(v.enum_(OrgType)),
  region: v.optional(v.enum_(Region)),
  defaultCurrency: v.optional(v.string()),
  defaultLocale: v.optional(v.string()),
  legalName: v.optional(v.string()),
  taxId: v.optional(v.string()),
  address: v.optional(v.string()),
  contactEmail: v.optional(v.string()),
  taxReportingEnabled: v.optional(v.boolean()),
  complianceTracking: v.optional(v.boolean()),
  originRegion: v.optional(v.string()),
  isClone: v.optional(v.boolean()),
  lastSyncedAt: v.optional(v.string())
}));

export type OrganizationCreate = v.InferOutput<typeof organizationCreateSchema>;
export type OrganizationUpdate = v.InferOutput<typeof organizationUpdateSchema>;

// AnalysisJob Schemas (TR)
export const analysisJobCreateSchema = v.object({
  // No required fields
});

export const analysisJobUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AnalysisJobCreate = v.InferOutput<typeof analysisJobCreateSchema>;
export type AnalysisJobUpdate = v.InferOutput<typeof analysisJobUpdateSchema>;

// DocumentAnalysis Schemas (TR)
export const documentAnalysisCreateSchema = v.object({
  // No required fields
});

export const documentAnalysisUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type DocumentAnalysisCreate = v.InferOutput<typeof documentAnalysisCreateSchema>;
export type DocumentAnalysisUpdate = v.InferOutput<typeof documentAnalysisUpdateSchema>;

// Role Schemas (TR)
export const roleCreateSchema = v.object({
  orgId: v.string(),
  key: v.enum_(MemberRoleKey),
  name: v.string()
});

export const roleUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  key: v.optional(v.enum_(MemberRoleKey)),
  name: v.optional(v.string()),
  locationId: v.optional(v.string())
}));

export type RoleCreate = v.InferOutput<typeof roleCreateSchema>;
export type RoleUpdate = v.InferOutput<typeof roleUpdateSchema>;

// Permission Schemas (TR)
export const permissionCreateSchema = v.object({
  key: v.enum_(PermissionKey),
  name: v.string()
});

export const permissionUpdateSchema = v.partial(v.object({
  key: v.optional(v.enum_(PermissionKey)),
  name: v.optional(v.string()),
  description: v.optional(v.string())
}));

export type PermissionCreate = v.InferOutput<typeof permissionCreateSchema>;
export type PermissionUpdate = v.InferOutput<typeof permissionUpdateSchema>;

// RolePermission Schemas (TR)
export const rolePermissionCreateSchema = v.object({
  roleId: v.string(),
  permissionId: v.string()
});

export const rolePermissionUpdateSchema = v.partial(v.object({
  roleId: v.optional(v.string()),
  permissionId: v.optional(v.string())
}));

export type RolePermissionCreate = v.InferOutput<typeof rolePermissionCreateSchema>;
export type RolePermissionUpdate = v.InferOutput<typeof rolePermissionUpdateSchema>;

// OrganizationMember Schemas (TR)
export const organizationMemberCreateSchema = v.object({
  // No required fields
});

export const organizationMemberUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type OrganizationMemberCreate = v.InferOutput<typeof organizationMemberCreateSchema>;
export type OrganizationMemberUpdate = v.InferOutput<typeof organizationMemberUpdateSchema>;

// ApiToken Schemas (TR)
export const apiTokenCreateSchema = v.object({
  userId: v.string(),
  name: v.string(),
  tokenHash: v.string(),
  scopes: v.string()
});

export const apiTokenUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  tokenHash: v.optional(v.string()),
  scopes: v.optional(v.string()),
  lastUsedAt: v.optional(v.string())
}));

export type ApiTokenCreate = v.InferOutput<typeof apiTokenCreateSchema>;
export type ApiTokenUpdate = v.InferOutput<typeof apiTokenUpdateSchema>;

// Contact Schemas (TR)
export const contactCreateSchema = v.object({
  orgId: v.string(),
  type: v.enum_(ContactType),
  fullName: v.string()
});

export const contactUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  type: v.optional(v.enum_(ContactType)),
  fullName: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  phone: v.optional(v.string()),
  notes: v.optional(v.string()),
  locale: v.optional(v.string()),
  currency: v.optional(v.string()),
  tenantReliabilityScoreId: v.optional(v.string())
}));

export type ContactCreate = v.InferOutput<typeof contactCreateSchema>;
export type ContactUpdate = v.InferOutput<typeof contactUpdateSchema>;

// VendorProfile Schemas (TR)
export const vendorProfileCreateSchema = v.object({
  orgId: v.string()
});

export const vendorProfileUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  legalName: v.optional(v.string()),
  serviceAreas: v.optional(v.string()),
  defaultCommissionBps: v.optional(v.number())
}));

export type VendorProfileCreate = v.InferOutput<typeof vendorProfileCreateSchema>;
export type VendorProfileUpdate = v.InferOutput<typeof vendorProfileUpdateSchema>;

// AgentAssignment Schemas (TR)
export const agentAssignmentCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string(),
  agentUserId: v.string()
});

export const agentAssignmentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  agentUserId: v.optional(v.string()),
  agencyOrgId: v.optional(v.string()),
  commissionBps: v.optional(v.number())
}));

export type AgentAssignmentCreate = v.InferOutput<typeof agentAssignmentCreateSchema>;
export type AgentAssignmentUpdate = v.InferOutput<typeof agentAssignmentUpdateSchema>;

// Property Schemas (TR)
export const propertyCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  region: v.enum_(Region),
  addressLine1: v.string(),
  city: v.string(),
  country: v.string(),
  accessibilityFeatures: v.string(),
  smartHomeFeatures: v.string(),
  securityFeatures: v.string(),
  outdoorFeatures: v.string(),
  environmentalHazards: v.string()
});

export const propertyUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  type: v.optional(v.enum_(PropertyType)),
  name: v.optional(v.string()),
  region: v.optional(v.enum_(Region)),
  currency: v.optional(v.string()),
  addressLine1: v.optional(v.string()),
  addressLine2: v.optional(v.string()),
  city: v.optional(v.string()),
  state: v.optional(v.string()),
  zip: v.optional(v.string()),
  country: v.optional(v.string()),
  lat: v.optional(v.number()),
  lng: v.optional(v.number()),
  neighborhoodId: v.optional(v.string()),
  bedrooms: v.optional(v.number()),
  bathrooms: v.optional(v.number()),
  areaSqm: v.optional(v.number()),
  yearBuilt: v.optional(v.number()),
  notes: v.optional(v.string()),
  locationId: v.optional(v.string()),
  schoolDistrict: v.optional(v.string()),
  hoaFee: v.optional(v.number()),
  hoaFeeFrequency: v.optional(v.string()),
  propertyTaxRate: v.optional(v.number()),
  lastAssessmentValue: v.optional(v.number()),
  lastAssessmentYear: v.optional(v.number()),
  floodZone: v.optional(v.string()),
  zoningCode: v.optional(v.string()),
  lotSizeAcres: v.optional(v.number()),
  frontageFeet: v.optional(v.number()),
  depthFeet: v.optional(v.number()),
  basementType: v.optional(v.string()),
  basementFinishedSqFt: v.optional(v.number()),
  garageType: v.optional(v.string()),
  garageCapacity: v.optional(v.number()),
  parkingSpaces: v.optional(v.number()),
  parkingType: v.optional(v.string()),
  poolType: v.optional(v.string()),
  heatingType: v.optional(v.string()),
  coolingType: v.optional(v.string()),
  fireplaceType: v.optional(v.string()),
  fireplaceCount: v.optional(v.number()),
  viewType: v.optional(v.string()),
  waterfrontType: v.optional(v.string()),
  waterfrontFeet: v.optional(v.number()),
  constructionType: v.optional(v.string()),
  roofType: v.optional(v.string()),
  roofYear: v.optional(v.number()),
  sidingType: v.optional(v.string()),
  zipPlus4: v.optional(v.string()),
  countyFIPS: v.optional(v.string()),
  censusTract: v.optional(v.string()),
  mlsArea: v.optional(v.string()),
  propertyClass: v.optional(v.string()),
  buildingClass: v.optional(v.string()),
  totalRooms: v.optional(v.number()),
  livingAreaSqFt: v.optional(v.number()),
  lotSizeSqFt: v.optional(v.number()),
  stories: v.optional(v.number()),
  unitsPerBuilding: v.optional(v.number()),
  assessedValue: v.optional(v.number()),
  marketValue: v.optional(v.number()),
  propertyTax: v.optional(v.number()),
  insuranceAmount: v.optional(v.number()),
  mortgageBalance: v.optional(v.number()),
  lienAmount: v.optional(v.number()),
  electricityProvider: v.optional(v.string()),
  gasProvider: v.optional(v.string()),
  waterProvider: v.optional(v.string()),
  internetProvider: v.optional(v.string()),
  trashService: v.optional(v.string()),
  mlsNumber: v.optional(v.string()),
  mlsStatus: v.optional(v.string()),
  daysOnMarket: v.optional(v.number()),
  pricePerSqFt: v.optional(v.number()),
  rentalYield: v.optional(v.number()),
  yearRenovated: v.optional(v.number()),
  energyRating: v.optional(v.string()),
  accessibilityFeatures: v.optional(v.string()),
  smartHomeFeatures: v.optional(v.string()),
  securityFeatures: v.optional(v.string()),
  outdoorFeatures: v.optional(v.string()),
  zoningDescription: v.optional(v.string()),
  landUse: v.optional(v.string()),
  buildingRestrictions: v.optional(v.string()),
  futureDevelopment: v.optional(v.string()),
  leadPaintCompliance: v.optional(v.boolean()),
  moldInspectionDate: v.optional(v.string()),
  asbestosInspectionDate: v.optional(v.string()),
  radonTestDate: v.optional(v.string()),
  pestControlDate: v.optional(v.string()),
  fireInspectionDate: v.optional(v.string()),
  elevatorInspectionDate: v.optional(v.string()),
  poolInspectionDate: v.optional(v.string()),
  lastCodeComplianceDate: v.optional(v.string()),
  accessibilityCompliance: v.optional(v.boolean()),
  environmentalHazards: v.optional(v.string()),
  createdBy: v.optional(v.string()),
  legalComplianceStatus: v.optional(v.enum_(LegalComplianceStatus)),
  unitId: v.optional(v.string()),
  balkonTipi: v.optional(v.string()),
  katKategorisi: v.optional(v.string()),
  county: v.optional(v.string())
}));

export type PropertyCreate = v.InferOutput<typeof propertyCreateSchema>;
export type PropertyUpdate = v.InferOutput<typeof propertyUpdateSchema>;

// Listing Schemas (TR)
export const listingCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  type: v.enum_(ListingType),
  status: v.enum_(ListingStatus)
});

export const listingUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  type: v.optional(v.enum_(ListingType)),
  status: v.optional(v.enum_(ListingStatus)),
  willBeAvailableAt: v.optional(v.string()),
  strategy: v.optional(v.enum_(EarningStrategy)),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  price: v.optional(v.number()),
  priceCurrency: v.optional(v.string()),
  createdBy: v.optional(v.string()),
  locationId: v.optional(v.string()),
  categoryId: v.optional(v.string()),
  userId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  agencyId: v.optional(v.string())
}));

export type ListingCreate = v.InferOutput<typeof listingCreateSchema>;
export type ListingUpdate = v.InferOutput<typeof listingUpdateSchema>;

// ListingStatusHistory Schemas (TR)
export const listingStatusHistoryCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string(),
  status: v.enum_(ListingStatus),
  fromDate: v.string()
});

export const listingStatusHistoryUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  status: v.optional(v.enum_(ListingStatus)),
  fromDate: v.optional(v.string()),
  toDate: v.optional(v.string()),
  reason: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type ListingStatusHistoryCreate = v.InferOutput<typeof listingStatusHistoryCreateSchema>;
export type ListingStatusHistoryUpdate = v.InferOutput<typeof listingStatusHistoryUpdateSchema>;

// Tag Schemas (TR)
export const tagCreateSchema = v.object({
  orgId: v.string(),
  name: v.string()
});

export const tagUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  color: v.optional(v.string())
}));

export type TagCreate = v.InferOutput<typeof tagCreateSchema>;
export type TagUpdate = v.InferOutput<typeof tagUpdateSchema>;

// ListingTag Schemas (TR)
export const listingTagCreateSchema = v.object({
  listingId: v.string(),
  tagId: v.string(),
  orgId: v.string()
});

export const listingTagUpdateSchema = v.partial(v.object({
  listingId: v.optional(v.string()),
  tagId: v.optional(v.string()),
  orgId: v.optional(v.string())
}));

export type ListingTagCreate = v.InferOutput<typeof listingTagCreateSchema>;
export type ListingTagUpdate = v.InferOutput<typeof listingTagUpdateSchema>;

// Booking Schemas (TR)
export const bookingCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string(),
  startDate: v.string(),
  endDate: v.string()
});

export const bookingUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  status: v.optional(v.enum_(BookingStatus)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  adults: v.optional(v.number()),
  children: v.optional(v.number()),
  priceTotal: v.optional(v.number()),
  currency: v.optional(v.string()),
  paymentStatus: v.optional(v.enum_(PaymentStatus)),
  notes: v.optional(v.string()),
  createdBy: v.optional(v.string()),
  hotelId: v.optional(v.string()),
  hotelRoomTypeId: v.optional(v.string()),
  hotelRatePlanId: v.optional(v.string()),
  bookingFailoverEventId: v.optional(v.string())
}));

export type BookingCreate = v.InferOutput<typeof bookingCreateSchema>;
export type BookingUpdate = v.InferOutput<typeof bookingUpdateSchema>;

// MaintenanceBlock Schemas (TR)
export const maintenanceBlockCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  type: v.enum_(MaintenanceBlockType),
  startDate: v.string(),
  endDate: v.string()
});

export const maintenanceBlockUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  type: v.optional(v.enum_(MaintenanceBlockType)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  reason: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type MaintenanceBlockCreate = v.InferOutput<typeof maintenanceBlockCreateSchema>;
export type MaintenanceBlockUpdate = v.InferOutput<typeof maintenanceBlockUpdateSchema>;

// Lease Schemas (TR)
export const leaseCreateSchema = v.object({
  // No required fields
});

export const leaseUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type LeaseCreate = v.InferOutput<typeof leaseCreateSchema>;
export type LeaseUpdate = v.InferOutput<typeof leaseUpdateSchema>;

// RentSchedule Schemas (TR)
export const rentScheduleCreateSchema = v.object({
  orgId: v.string(),
  leaseId: v.string(),
  dueDate: v.string(),
  amount: v.number()
});

export const rentScheduleUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  dueDate: v.optional(v.string()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(PaymentStatus)),
  paidAt: v.optional(v.string())
}));

export type RentScheduleCreate = v.InferOutput<typeof rentScheduleCreateSchema>;
export type RentScheduleUpdate = v.InferOutput<typeof rentScheduleUpdateSchema>;

// FinancialRecord Schemas (TR)
export const financialRecordCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  type: v.string(),
  amount: v.number()
});

export const financialRecordUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bookingId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  vendorContactId: v.optional(v.string()),
  type: v.optional(v.string()),
  recordType: v.optional(v.enum_(TransactionType)),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  occurredAt: v.optional(v.string()),
  dueDate: v.optional(v.string()),
  billData: v.optional(v.unknown())
}));

export type FinancialRecordCreate = v.InferOutput<typeof financialRecordCreateSchema>;
export type FinancialRecordUpdate = v.InferOutput<typeof financialRecordUpdateSchema>;

// TaxRecord Schemas (TR)
export const taxRecordCreateSchema = v.object({
  orgId: v.string(),
  recordType: v.string()
});

export const taxRecordUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  profileId: v.optional(v.string()),
  transactionId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  recordType: v.optional(v.string()),
  profileData: v.optional(v.unknown())
}));

export type TaxRecordCreate = v.InferOutput<typeof taxRecordCreateSchema>;
export type TaxRecordUpdate = v.InferOutput<typeof taxRecordUpdateSchema>;

// Attachment Schemas (TR)
export const attachmentCreateSchema = v.object({
  orgId: v.string(),
  entityType: v.string(),
  entityId: v.string(),
  fileName: v.string(),
  mimeType: v.string(),
  sizeBytes: v.number(),
  storageKey: v.string()
});

export const attachmentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  fileName: v.optional(v.string()),
  mimeType: v.optional(v.string()),
  sizeBytes: v.optional(v.number()),
  storageKey: v.optional(v.string()),
  url: v.optional(v.string()),
  checksum: v.optional(v.string()),
  createdBy: v.optional(v.string()),
  transactionId: v.optional(v.string()),
  taskId: v.optional(v.string()),
  messageId: v.optional(v.string()),
  propertyComplianceId: v.optional(v.string()),
  reviewId: v.optional(v.string()),
  documentId: v.optional(v.string())
}));

export type AttachmentCreate = v.InferOutput<typeof attachmentCreateSchema>;
export type AttachmentUpdate = v.InferOutput<typeof attachmentUpdateSchema>;

// LedgerEntry Schemas (TR)
export const ledgerEntryCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  type: v.enum_(LedgerEventType)
});

export const ledgerEntryUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bookingId: v.optional(v.string()),
  contractId: v.optional(v.string()),
  billId: v.optional(v.string()),
  transactionId: v.optional(v.string()),
  type: v.optional(v.enum_(LedgerEventType)),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  occurredAt: v.optional(v.string()),
  note: v.optional(v.string()),
  meta: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type LedgerEntryCreate = v.InferOutput<typeof ledgerEntryCreateSchema>;
export type LedgerEntryUpdate = v.InferOutput<typeof ledgerEntryUpdateSchema>;

// ExchangeRate Schemas (TR)
export const exchangeRateCreateSchema = v.object({
  orgId: v.string(),
  baseCurrency: v.string(),
  quoteCurrency: v.string(),
  rate: v.number(),
  asOfDate: v.string()
});

export const exchangeRateUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  baseCurrency: v.optional(v.string()),
  quoteCurrency: v.optional(v.string()),
  rate: v.optional(v.number()),
  asOfDate: v.optional(v.string()),
  source: v.optional(v.string())
}));

export type ExchangeRateCreate = v.InferOutput<typeof exchangeRateCreateSchema>;
export type ExchangeRateUpdate = v.InferOutput<typeof exchangeRateUpdateSchema>;

// ExportJob Schemas (TR)
export const exportJobCreateSchema = v.object({
  orgId: v.string(),
  type: v.enum_(ExportType)
});

export const exportJobUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  type: v.optional(v.enum_(ExportType)),
  status: v.optional(v.enum_(ExportStatus)),
  params: v.optional(v.unknown()),
  startedAt: v.optional(v.string()),
  finishedAt: v.optional(v.string()),
  error: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type ExportJobCreate = v.InferOutput<typeof exportJobCreateSchema>;
export type ExportJobUpdate = v.InferOutput<typeof exportJobUpdateSchema>;

// ExportFile Schemas (TR)
export const exportFileCreateSchema = v.object({
  orgId: v.string(),
  exportJobId: v.string(),
  fileName: v.string(),
  storageKey: v.string(),
  mimeType: v.string(),
  sizeBytes: v.number()
});

export const exportFileUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  exportJobId: v.optional(v.string()),
  fileName: v.optional(v.string()),
  storageKey: v.optional(v.string()),
  mimeType: v.optional(v.string()),
  sizeBytes: v.optional(v.number())
}));

export type ExportFileCreate = v.InferOutput<typeof exportFileCreateSchema>;
export type ExportFileUpdate = v.InferOutput<typeof exportFileUpdateSchema>;

// GovernmentIntegration Schemas (TR)
export const governmentIntegrationCreateSchema = v.object({
  orgId: v.string(),
  region: v.enum_(Region),
  name: v.string(),
  scopes: v.string()
});

export const governmentIntegrationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  region: v.optional(v.enum_(Region)),
  name: v.optional(v.string()),
  baseUrl: v.optional(v.string()),
  isEnabled: v.optional(v.boolean()),
  apiKeyCiphertext: v.optional(v.string()),
  apiSecretCiphertext: v.optional(v.string()),
  tokenCiphertext: v.optional(v.string()),
  scopes: v.optional(v.string()),
  lastSyncAt: v.optional(v.string()),
  status: v.optional(v.enum_(SyncStatus)),
  lastError: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type GovernmentIntegrationCreate = v.InferOutput<typeof governmentIntegrationCreateSchema>;
export type GovernmentIntegrationUpdate = v.InferOutput<typeof governmentIntegrationUpdateSchema>;

// Lead Schemas (TR)
export const leadCreateSchema = v.object({
  orgId: v.string()
});

export const leadUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  campaignId: v.optional(v.string()),
  sourceId: v.optional(v.string()),
  firstName: v.optional(v.string()),
  lastName: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  phone: v.optional(v.string()),
  budget: v.optional(v.number()),
  timeline: v.optional(v.string()),
  notes: v.optional(v.string()),
  status: v.optional(v.enum_(LeadStatus)),
  sourceDetail: v.optional(v.string()),
  assignedToUserId: v.optional(v.string()),
  assignedToContactId: v.optional(v.string()),
  interestedPropertyId: v.optional(v.string()),
  interestedListingId: v.optional(v.string()),
  agentTeamId: v.optional(v.string())
}));

export type LeadCreate = v.InferOutput<typeof leadCreateSchema>;
export type LeadUpdate = v.InferOutput<typeof leadUpdateSchema>;

// LeadSource Schemas (TR)
export const leadSourceCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.enum_(SourceType)
});

export const leadSourceUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.enum_(SourceType)),
  config: v.optional(v.unknown())
}));

export type LeadSourceCreate = v.InferOutput<typeof leadSourceCreateSchema>;
export type LeadSourceUpdate = v.InferOutput<typeof leadSourceUpdateSchema>;

// Location Schemas (TR)
export const locationCreateSchema = v.object({
  orgId: v.string(),
  addressLine1: v.string(),
  city: v.string(),
  latitude: v.number(),
  longitude: v.number(),
  tags: v.string()
});

export const locationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  addressLine1: v.optional(v.string()),
  addressLine2: v.optional(v.string()),
  addressLine3: v.optional(v.string()),
  city: v.optional(v.string()),
  state: v.optional(v.string()),
  zip: v.optional(v.string()),
  zipPlus4: v.optional(v.string()),
  country: v.optional(v.string()),
  censusTract: v.optional(v.string()),
  blockGroup: v.optional(v.string()),
  precinct: v.optional(v.string()),
  schoolDistrict: v.optional(v.string()),
  congressionalDistrict: v.optional(v.string()),
  latitude: v.optional(v.number()),
  longitude: v.optional(v.number()),
  accuracy: v.optional(v.enum_(LocationAccuracy)),
  altitude: v.optional(v.number()),
  elevation: v.optional(v.number()),
  geocodingStatus: v.optional(v.enum_(GeocodingStatus)),
  geocodedAt: v.optional(v.string()),
  geocodingProvider: v.optional(v.enum_(MapProvider)),
  confidenceScore: v.optional(v.number()),
  isVerified: v.optional(v.boolean()),
  verifiedAt: v.optional(v.string()),
  verifiedBy: v.optional(v.string()),
  uspsVerified: v.optional(v.boolean()),
  uspsVerifiedAt: v.optional(v.string()),
  dpvConfirmation: v.optional(v.string()),
  footnotes: v.optional(v.string()),
  isStandardized: v.optional(v.boolean()),
  isResidential: v.optional(v.boolean()),
  isCommercial: v.optional(v.boolean()),
  isValid: v.optional(v.boolean()),
  markerType: v.optional(v.enum_(MarkerType)),
  markerIcon: v.optional(v.enum_(MarkerIcon)),
  markerColor: v.optional(v.string()),
  markerSize: v.optional(v.number()),
  isVisible: v.optional(v.boolean()),
  zIndex: v.optional(v.number()),
  opacity: v.optional(v.number()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  imageUrl: v.optional(v.string()),
  linkUrl: v.optional(v.string()),
  category: v.optional(v.string()),
  tags: v.optional(v.string()),
  mondayOpen: v.optional(v.string()),
  mondayClose: v.optional(v.string()),
  tuesdayOpen: v.optional(v.string()),
  tuesdayClose: v.optional(v.string()),
  wednesdayOpen: v.optional(v.string()),
  wednesdayClose: v.optional(v.string()),
  thursdayOpen: v.optional(v.string()),
  thursdayClose: v.optional(v.string()),
  fridayOpen: v.optional(v.string()),
  fridayClose: v.optional(v.string()),
  saturdayOpen: v.optional(v.string()),
  saturdayClose: v.optional(v.string()),
  sundayOpen: v.optional(v.string()),
  sundayClose: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  createdBy: v.optional(v.string()),
  county: v.optional(v.string()),
  countyFIPS: v.optional(v.string())
}));

export type LocationCreate = v.InferOutput<typeof locationCreateSchema>;
export type LocationUpdate = v.InferOutput<typeof locationUpdateSchema>;

// Deal Schemas (TR)
export const dealCreateSchema = v.object({
  orgId: v.string()
});

export const dealUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  clientId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  locationId: v.optional(v.string()),
  dealStatus: v.optional(v.enum_(DealStatusUSA)),
  dealType: v.optional(v.string()),
  offerPrice: v.optional(v.number()),
  listPrice: v.optional(v.number()),
  salePrice: v.optional(v.number()),
  commissionRate: v.optional(v.number()),
  commissionAmount: v.optional(v.number()),
  closingDate: v.optional(v.string()),
  financingType: v.optional(v.string()),
  loanAmount: v.optional(v.number()),
  downPayment: v.optional(v.number()),
  earnestMoney: v.optional(v.number()),
  escrowAmount: v.optional(v.number()),
  closingCosts: v.optional(v.number()),
  sellerConcessions: v.optional(v.number()),
  buyerCredits: v.optional(v.number()),
  inspectionPeriod: v.optional(v.number()),
  financingContingency: v.optional(v.boolean()),
  appraisalContingency: v.optional(v.boolean()),
  titleContingency: v.optional(v.boolean()),
  attorneyReview: v.optional(v.boolean()),
  multipleOffers: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type DealCreate = v.InferOutput<typeof dealCreateSchema>;
export type DealUpdate = v.InferOutput<typeof dealUpdateSchema>;

// Document Schemas (TR)
export const documentCreateSchema = v.object({
  orgId: v.string(),
  documentType: v.enum_(DocumentTypeUSA),
  title: v.string(),
  fileUrl: v.string(),
  fileName: v.string(),
  fileSize: v.number(),
  mimeType: v.string(),
  checksum: v.string(),
  tags: v.string()
});

export const documentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  contractId: v.optional(v.string()),
  userId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  documentType: v.optional(v.enum_(DocumentTypeUSA)),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  fileUrl: v.optional(v.string()),
  fileName: v.optional(v.string()),
  fileSize: v.optional(v.number()),
  mimeType: v.optional(v.string()),
  checksum: v.optional(v.string()),
  version: v.optional(v.number()),
  isRequired: v.optional(v.boolean()),
  isSigned: v.optional(v.boolean()),
  signatureRequired: v.optional(v.boolean()),
  notarizationRequired: v.optional(v.boolean()),
  recordingRequired: v.optional(v.boolean()),
  expiryDate: v.optional(v.string()),
  complianceType: v.optional(v.enum_(ComplianceType)),
  jurisdiction: v.optional(v.string()),
  templateId: v.optional(v.string()),
  tags: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type DocumentCreate = v.InferOutput<typeof documentCreateSchema>;
export type DocumentUpdate = v.InferOutput<typeof documentUpdateSchema>;

// Payout Schemas (TR)
export const payoutCreateSchema = v.object({
  // No required fields
});

export const payoutUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PayoutCreate = v.InferOutput<typeof payoutCreateSchema>;
export type PayoutUpdate = v.InferOutput<typeof payoutUpdateSchema>;

// MapLayer Schemas (TR)
export const mapLayerCreateSchema = v.object({
  // No required fields
});

export const mapLayerUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MapLayerCreate = v.InferOutput<typeof mapLayerCreateSchema>;
export type MapLayerUpdate = v.InferOutput<typeof mapLayerUpdateSchema>;

// Route Schemas (TR)
export const routeCreateSchema = v.object({
  // No required fields
});

export const routeUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type RouteCreate = v.InferOutput<typeof routeCreateSchema>;
export type RouteUpdate = v.InferOutput<typeof routeUpdateSchema>;

// ApiIntegration Schemas (TR)
export const apiIntegrationCreateSchema = v.object({
  // No required fields
});

export const apiIntegrationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ApiIntegrationCreate = v.InferOutput<typeof apiIntegrationCreateSchema>;
export type ApiIntegrationUpdate = v.InferOutput<typeof apiIntegrationUpdateSchema>;

// HomeInformationPack Schemas (TR)
export const homeInformationPackCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string()
});

export const homeInformationPackUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  packStatus: v.optional(v.string()),
  createdDate: v.optional(v.string()),
  submittedDate: v.optional(v.string()),
  energyPerformanceCertificate: v.optional(v.unknown())
}));

export type HomeInformationPackCreate = v.InferOutput<typeof homeInformationPackCreateSchema>;
export type HomeInformationPackUpdate = v.InferOutput<typeof homeInformationPackUpdateSchema>;

// DepositProtection Schemas (TR)
export const depositProtectionCreateSchema = v.object({
  orgId: v.string(),
  leaseId: v.string(),
  schemeProvider: v.string(),
  schemeReference: v.string(),
  depositAmount: v.number(),
  tenantDetails: v.unknown()
});

export const depositProtectionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  currency: v.optional(v.string()),
  schemeProvider: v.optional(v.string()),
  schemeReference: v.optional(v.string()),
  depositAmount: v.optional(v.number()),
  protectionStatus: v.optional(v.string()),
  protectedDate: v.optional(v.string()),
  releasedDate: v.optional(v.string()),
  tenantDetails: v.optional(v.unknown())
}));

export type DepositProtectionCreate = v.InferOutput<typeof depositProtectionCreateSchema>;
export type DepositProtectionUpdate = v.InferOutput<typeof depositProtectionUpdateSchema>;

// RightToRentCheck Schemas (TR)
export const rightToRentCheckCreateSchema = v.object({
  orgId: v.string(),
  tenantId: v.string()
});

export const rightToRentCheckUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  checkStatus: v.optional(v.string()),
  checkDate: v.optional(v.string()),
  validUntil: v.optional(v.string()),
  immigrationStatus: v.optional(v.string()),
  visaType: v.optional(v.string()),
  visaExpiry: v.optional(v.string()),
  documentType: v.optional(v.string()),
  documentNumber: v.optional(v.string()),
  documentVerified: v.optional(v.boolean()),
  shareCode: v.optional(v.string()),
  checkReference: v.optional(v.string()),
  notes: v.optional(v.string())
}));

export type RightToRentCheckCreate = v.InferOutput<typeof rightToRentCheckCreateSchema>;
export type RightToRentCheckUpdate = v.InferOutput<typeof rightToRentCheckUpdateSchema>;

// SolicitorManagement Schemas (TR)
export const solicitorManagementCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  solicitorFirm: v.string(),
  solicitorName: v.string(),
  solicitorEmail: v.string(),
  appointmentType: v.string()
});

export const solicitorManagementUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  status: v.optional(v.string()),
  solicitorFirm: v.optional(v.string()),
  solicitorName: v.optional(v.string()),
  solicitorEmail: v.optional(v.string()),
  solicitorPhone: v.optional(v.string()),
  appointmentType: v.optional(v.string()),
  appointmentDate: v.optional(v.string()),
  appointmentNotes: v.optional(v.string()),
  searchDate: v.optional(v.string()),
  draftContractDate: v.optional(v.string()),
  finalContractDate: v.optional(v.string()),
  completionDate: v.optional(v.string()),
  completionNotes: v.optional(v.string()),
  fees: v.optional(v.unknown())
}));

export type SolicitorManagementCreate = v.InferOutput<typeof solicitorManagementCreateSchema>;
export type SolicitorManagementUpdate = v.InferOutput<typeof solicitorManagementUpdateSchema>;

// MortgageOffer Schemas (TR)
export const mortgageOfferCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  interestRate: v.number(),
  monthlyPayment: v.number(),
  lenderName: v.string(),
  mortgageType: v.string(),
  mortgageTerm: v.number(),
  arrangementFee: v.number(),
  valuationFee: v.number(),
  loanAmount: v.number(),
  depositAmount: v.number(),
  loanToValue: v.number(),
  totalPayable: v.number(),
  offerDate: v.string()
});

export const mortgageOfferUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  interestRate: v.optional(v.number()),
  monthlyPayment: v.optional(v.number()),
  dealId: v.optional(v.string()),
  lenderName: v.optional(v.string()),
  mortgageType: v.optional(v.string()),
  mortgageTerm: v.optional(v.number()),
  arrangementFee: v.optional(v.number()),
  valuationFee: v.optional(v.number()),
  loanAmount: v.optional(v.number()),
  depositAmount: v.optional(v.number()),
  loanToValue: v.optional(v.number()),
  totalPayable: v.optional(v.number()),
  offerStatus: v.optional(v.string()),
  offerDate: v.optional(v.string()),
  expiryDate: v.optional(v.string()),
  acceptedDate: v.optional(v.string()),
  solicitorName: v.optional(v.string()),
  solicitorEmail: v.optional(v.string())
}));

export type MortgageOfferCreate = v.InferOutput<typeof mortgageOfferCreateSchema>;
export type MortgageOfferUpdate = v.InferOutput<typeof mortgageOfferUpdateSchema>;

// RentalSyncJob Schemas (TR)
export const rentalSyncJobCreateSchema = v.object({
  // No required fields
});

export const rentalSyncJobUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type RentalSyncJobCreate = v.InferOutput<typeof rentalSyncJobCreateSchema>;
export type RentalSyncJobUpdate = v.InferOutput<typeof rentalSyncJobUpdateSchema>;

// ExternalRentalListing Schemas (TR)
export const externalRentalListingCreateSchema = v.object({
  // No required fields
});

export const externalRentalListingUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ExternalRentalListingCreate = v.InferOutput<typeof externalRentalListingCreateSchema>;
export type ExternalRentalListingUpdate = v.InferOutput<typeof externalRentalListingUpdateSchema>;

// VacationRental Schemas (TR)
export const vacationRentalCreateSchema = v.object({
  // No required fields
});

export const vacationRentalUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VacationRentalCreate = v.InferOutput<typeof vacationRentalCreateSchema>;
export type VacationRentalUpdate = v.InferOutput<typeof vacationRentalUpdateSchema>;

// VacationRentalPlatform Schemas (TR)
export const vacationRentalPlatformCreateSchema = v.object({
  // No required fields
});

export const vacationRentalPlatformUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VacationRentalPlatformCreate = v.InferOutput<typeof vacationRentalPlatformCreateSchema>;
export type VacationRentalPlatformUpdate = v.InferOutput<typeof vacationRentalPlatformUpdateSchema>;

// MlsDataMapping Schemas (TR)
export const mlsDataMappingCreateSchema = v.object({
  // No required fields
});

export const mlsDataMappingUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MlsDataMappingCreate = v.InferOutput<typeof mlsDataMappingCreateSchema>;
export type MlsDataMappingUpdate = v.InferOutput<typeof mlsDataMappingUpdateSchema>;

// MlsListingEnhancement Schemas (TR)
export const mlsListingEnhancementCreateSchema = v.object({
  // No required fields
});

export const mlsListingEnhancementUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MlsListingEnhancementCreate = v.InferOutput<typeof mlsListingEnhancementCreateSchema>;
export type MlsListingEnhancementUpdate = v.InferOutput<typeof mlsListingEnhancementUpdateSchema>;

// ListingChannel Schemas (TR)
export const listingChannelCreateSchema = v.object({
  // No required fields
});

export const listingChannelUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ListingChannelCreate = v.InferOutput<typeof listingChannelCreateSchema>;
export type ListingChannelUpdate = v.InferOutput<typeof listingChannelUpdateSchema>;

// InvestorPortfolio Schemas (TR)
export const investorPortfolioCreateSchema = v.object({
  // No required fields
});

export const investorPortfolioUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type InvestorPortfolioCreate = v.InferOutput<typeof investorPortfolioCreateSchema>;
export type InvestorPortfolioUpdate = v.InferOutput<typeof investorPortfolioUpdateSchema>;

// InvestorProperty Schemas (TR)
export const investorPropertyCreateSchema = v.object({
  // No required fields
});

export const investorPropertyUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type InvestorPropertyCreate = v.InferOutput<typeof investorPropertyCreateSchema>;
export type InvestorPropertyUpdate = v.InferOutput<typeof investorPropertyUpdateSchema>;

// PropertyValuation Schemas (TR)
export const propertyValuationCreateSchema = v.object({
  // No required fields
});

export const propertyValuationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertyValuationCreate = v.InferOutput<typeof propertyValuationCreateSchema>;
export type PropertyValuationUpdate = v.InferOutput<typeof propertyValuationUpdateSchema>;

// AgentTeam Schemas (TR)
export const agentTeamCreateSchema = v.object({
  // No required fields
});

export const agentTeamUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgentTeamCreate = v.InferOutput<typeof agentTeamCreateSchema>;
export type AgentTeamUpdate = v.InferOutput<typeof agentTeamUpdateSchema>;

// AgentTeamMember Schemas (TR)
export const agentTeamMemberCreateSchema = v.object({
  // No required fields
});

export const agentTeamMemberUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgentTeamMemberCreate = v.InferOutput<typeof agentTeamMemberCreateSchema>;
export type AgentTeamMemberUpdate = v.InferOutput<typeof agentTeamMemberUpdateSchema>;

// AgentPerformance Schemas (TR)
export const agentPerformanceCreateSchema = v.object({
  // No required fields
});

export const agentPerformanceUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgentPerformanceCreate = v.InferOutput<typeof agentPerformanceCreateSchema>;
export type AgentPerformanceUpdate = v.InferOutput<typeof agentPerformanceUpdateSchema>;

// ClientRelationship Schemas (TR)
export const clientRelationshipCreateSchema = v.object({
  // No required fields
});

export const clientRelationshipUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ClientRelationshipCreate = v.InferOutput<typeof clientRelationshipCreateSchema>;
export type ClientRelationshipUpdate = v.InferOutput<typeof clientRelationshipUpdateSchema>;

// TenantApplication Schemas (TR)
export const tenantApplicationCreateSchema = v.object({
  // No required fields
});

export const tenantApplicationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TenantApplicationCreate = v.InferOutput<typeof tenantApplicationCreateSchema>;
export type TenantApplicationUpdate = v.InferOutput<typeof tenantApplicationUpdateSchema>;

// MaintenanceWorkOrder Schemas (TR)
export const maintenanceWorkOrderCreateSchema = v.object({
  // No required fields
});

export const maintenanceWorkOrderUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MaintenanceWorkOrderCreate = v.InferOutput<typeof maintenanceWorkOrderCreateSchema>;
export type MaintenanceWorkOrderUpdate = v.InferOutput<typeof maintenanceWorkOrderUpdateSchema>;

// LeaseRenewal Schemas (TR)
export const leaseRenewalCreateSchema = v.object({
  // No required fields
});

export const leaseRenewalUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type LeaseRenewalCreate = v.InferOutput<typeof leaseRenewalCreateSchema>;
export type LeaseRenewalUpdate = v.InferOutput<typeof leaseRenewalUpdateSchema>;

// GuestProfile Schemas (TR)
export const guestProfileCreateSchema = v.object({
  // No required fields
});

export const guestProfileUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type GuestProfileCreate = v.InferOutput<typeof guestProfileCreateSchema>;
export type GuestProfileUpdate = v.InferOutput<typeof guestProfileUpdateSchema>;

// GuestReview Schemas (TR)
export const guestReviewCreateSchema = v.object({
  // No required fields
});

export const guestReviewUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type GuestReviewCreate = v.InferOutput<typeof guestReviewCreateSchema>;
export type GuestReviewUpdate = v.InferOutput<typeof guestReviewUpdateSchema>;

// TaxDepreciation Schemas (TR)
export const taxDepreciationCreateSchema = v.object({
  // No required fields
});

export const taxDepreciationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TaxDepreciationCreate = v.InferOutput<typeof taxDepreciationCreateSchema>;
export type TaxDepreciationUpdate = v.InferOutput<typeof taxDepreciationUpdateSchema>;

// Tax1099Form Schemas (TR)
export const tax1099FormCreateSchema = v.object({
  // No required fields
});

export const tax1099FormUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type Tax1099FormCreate = v.InferOutput<typeof tax1099FormCreateSchema>;
export type Tax1099FormUpdate = v.InferOutput<typeof tax1099FormUpdateSchema>;

// DashboardWidget Schemas (TR)
export const dashboardWidgetCreateSchema = v.object({
  // No required fields
});

export const dashboardWidgetUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type DashboardWidgetCreate = v.InferOutput<typeof dashboardWidgetCreateSchema>;
export type DashboardWidgetUpdate = v.InferOutput<typeof dashboardWidgetUpdateSchema>;

// PredictiveModel Schemas (TR)
export const predictiveModelCreateSchema = v.object({
  // No required fields
});

export const predictiveModelUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PredictiveModelCreate = v.InferOutput<typeof predictiveModelCreateSchema>;
export type PredictiveModelUpdate = v.InferOutput<typeof predictiveModelUpdateSchema>;

// LoyaltyAccount Schemas (TR)
export const loyaltyAccountCreateSchema = v.object({
  // No required fields
});

export const loyaltyAccountUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type LoyaltyAccountCreate = v.InferOutput<typeof loyaltyAccountCreateSchema>;
export type LoyaltyAccountUpdate = v.InferOutput<typeof loyaltyAccountUpdateSchema>;

// Referral Schemas (TR)
export const referralCreateSchema = v.object({
  // No required fields
});

export const referralUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ReferralCreate = v.InferOutput<typeof referralCreateSchema>;
export type ReferralUpdate = v.InferOutput<typeof referralUpdateSchema>;

// Subscription Schemas (TR)
export const subscriptionCreateSchema = v.object({
  // No required fields
});

export const subscriptionUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SubscriptionCreate = v.InferOutput<typeof subscriptionCreateSchema>;
export type SubscriptionUpdate = v.InferOutput<typeof subscriptionUpdateSchema>;

// GiftCard Schemas (TR)
export const giftCardCreateSchema = v.object({
  // No required fields
});

export const giftCardUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type GiftCardCreate = v.InferOutput<typeof giftCardCreateSchema>;
export type GiftCardUpdate = v.InferOutput<typeof giftCardUpdateSchema>;

// Achievement Schemas (TR)
export const achievementCreateSchema = v.object({
  // No required fields
});

export const achievementUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AchievementCreate = v.InferOutput<typeof achievementCreateSchema>;
export type AchievementUpdate = v.InferOutput<typeof achievementUpdateSchema>;

// Earning Schemas (TR)
export const earningCreateSchema = v.object({
  // No required fields
});

export const earningUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type EarningCreate = v.InferOutput<typeof earningCreateSchema>;
export type EarningUpdate = v.InferOutput<typeof earningUpdateSchema>;

// Job Schemas (TR)
export const jobCreateSchema = v.object({
  // No required fields
});

export const jobUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type JobCreate = v.InferOutput<typeof jobCreateSchema>;
export type JobUpdate = v.InferOutput<typeof jobUpdateSchema>;

// Notification Schemas (TR)
export const notificationCreateSchema = v.object({
  // No required fields
});

export const notificationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type NotificationCreate = v.InferOutput<typeof notificationCreateSchema>;
export type NotificationUpdate = v.InferOutput<typeof notificationUpdateSchema>;

// Message Schemas (TR)
export const messageCreateSchema = v.object({
  // No required fields
});

export const messageUpdateSchema = v.partial(v.object({
  aiSentimentScore: v.optional(v.number()),
  aiPriority: v.optional(v.string())
}));

export type MessageCreate = v.InferOutput<typeof messageCreateSchema>;
export type MessageUpdate = v.InferOutput<typeof messageUpdateSchema>;

// Task Schemas (TR)
export const taskCreateSchema = v.object({
  // No required fields
});

export const taskUpdateSchema = v.partial(v.object({
  gpsLatitude: v.optional(v.number()),
  gpsLongitude: v.optional(v.number()),
  gpsVerified: v.optional(v.boolean()),
  gpsVerifiedAt: v.optional(v.string()),
  photoLocationMatch: v.optional(v.boolean()),
  deviceInfo: v.optional(v.unknown())
}));

export type TaskCreate = v.InferOutput<typeof taskCreateSchema>;
export type TaskUpdate = v.InferOutput<typeof taskUpdateSchema>;

// Facility Schemas (TR)
export const facilityCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  name: v.string()
});

export const facilityUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  name: v.optional(v.string()),
  feeAmount: v.optional(v.number()),
  feeCurrency: v.optional(v.string()),
  notes: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type FacilityCreate = v.InferOutput<typeof facilityCreateSchema>;
export type FacilityUpdate = v.InferOutput<typeof facilityUpdateSchema>;

// Contract Schemas (TR)
export const contractCreateSchema = v.object({
  orgId: v.string(),
  type: v.enum_(ContractType)
});

export const contractUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bookingId: v.optional(v.string()),
  type: v.optional(v.enum_(ContractType)),
  status: v.optional(v.enum_(ContractStatus)),
  title: v.optional(v.string()),
  effectiveFrom: v.optional(v.string()),
  effectiveTo: v.optional(v.string()),
  nextRenewalAt: v.optional(v.string()),
  renewalNoticeDays: v.optional(v.number()),
  createdBy: v.optional(v.string())
}));

export type ContractCreate = v.InferOutput<typeof contractCreateSchema>;
export type ContractUpdate = v.InferOutput<typeof contractUpdateSchema>;

// ContractVersion Schemas (TR)
export const contractVersionCreateSchema = v.object({
  orgId: v.string(),
  contractId: v.string(),
  version: v.number(),
  documentUrl: v.string()
});

export const contractVersionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contractId: v.optional(v.string()),
  version: v.optional(v.number()),
  documentUrl: v.optional(v.string()),
  checksum: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type ContractVersionCreate = v.InferOutput<typeof contractVersionCreateSchema>;
export type ContractVersionUpdate = v.InferOutput<typeof contractVersionUpdateSchema>;

// SignatureRequest Schemas (TR)
export const signatureRequestCreateSchema = v.object({
  orgId: v.string(),
  contractId: v.string()
});

export const signatureRequestUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contractId: v.optional(v.string()),
  provider: v.optional(v.string()),
  status: v.optional(v.enum_(SignatureStatus)),
  signUrl: v.optional(v.string()),
  signedDocumentUrl: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type SignatureRequestCreate = v.InferOutput<typeof signatureRequestCreateSchema>;
export type SignatureRequestUpdate = v.InferOutput<typeof signatureRequestUpdateSchema>;

// SignatureSigner Schemas (TR)
export const signatureSignerCreateSchema = v.object({
  orgId: v.string(),
  signatureRequestId: v.string(),
  participantType: v.enum_(MessageParticipantType),
  fullName: v.string()
});

export const signatureSignerUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  signatureRequestId: v.optional(v.string()),
  participantType: v.optional(v.enum_(MessageParticipantType)),
  userId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  fullName: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  status: v.optional(v.enum_(SignatureStatus)),
  signedAt: v.optional(v.string())
}));

export type SignatureSignerCreate = v.InferOutput<typeof signatureSignerCreateSchema>;
export type SignatureSignerUpdate = v.InferOutput<typeof signatureSignerUpdateSchema>;

// UserFinancialProfile Schemas (TR)
export const userFinancialProfileCreateSchema = v.object({
  userId: v.string(),
  region: v.enum_(Region),
  monthlyIncome: v.number(),
  monthlyObligations: v.number()
});

export const userFinancialProfileUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  region: v.optional(v.enum_(Region)),
  currency: v.optional(v.string()),
  monthlyIncome: v.optional(v.number()),
  monthlyObligations: v.optional(v.number()),
  riskTolerance: v.optional(v.enum_(RiskTolerance)),
  assumptions: v.optional(v.unknown())
}));

export type UserFinancialProfileCreate = v.InferOutput<typeof userFinancialProfileCreateSchema>;
export type UserFinancialProfileUpdate = v.InferOutput<typeof userFinancialProfileUpdateSchema>;

// UserPreference Schemas (TR)
export const userPreferenceCreateSchema = v.object({
  userId: v.string()
});

export const userPreferenceUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  theme: v.optional(v.string()),
  language: v.optional(v.string()),
  timezone: v.optional(v.string()),
  dateFormat: v.optional(v.string()),
  currency: v.optional(v.string()),
  emailNotifications: v.optional(v.pipe(v.string(), v.email())),
  pushNotifications: v.optional(v.boolean()),
  marketingEmails: v.optional(v.boolean()),
  dashboardLayout: v.optional(v.unknown())
}));

export type UserPreferenceCreate = v.InferOutput<typeof userPreferenceCreateSchema>;
export type UserPreferenceUpdate = v.InferOutput<typeof userPreferenceUpdateSchema>;

// UserActivityLog Schemas (TR)
export const userActivityLogCreateSchema = v.object({
  userId: v.string(),
  action: v.string()
});

export const userActivityLogUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  action: v.optional(v.string()),
  entityType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  ipAddress: v.optional(v.string()),
  userAgent: v.optional(v.string())
}));

export type UserActivityLogCreate = v.InferOutput<typeof userActivityLogCreateSchema>;
export type UserActivityLogUpdate = v.InferOutput<typeof userActivityLogUpdateSchema>;

// ApiKey Schemas (TR)
export const apiKeyCreateSchema = v.object({
  userId: v.string(),
  name: v.string(),
  keyHash: v.string(),
  scopes: v.string()
});

export const apiKeyUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  keyHash: v.optional(v.string()),
  scopes: v.optional(v.string()),
  lastUsedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string())
}));

export type ApiKeyCreate = v.InferOutput<typeof apiKeyCreateSchema>;
export type ApiKeyUpdate = v.InferOutput<typeof apiKeyUpdateSchema>;

// Review Schemas (TR)
export const reviewCreateSchema = v.object({
  orgId: v.string(),
  reviewerId: v.string(),
  targetId: v.string(),
  targetType: v.string(),
  rating: v.number()
});

export const reviewUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reviewerId: v.optional(v.string()),
  targetId: v.optional(v.string()),
  targetType: v.optional(v.string()),
  rating: v.optional(v.number()),
  title: v.optional(v.string()),
  comment: v.optional(v.string()),
  isVerified: v.optional(v.boolean()),
  responses: v.optional(v.unknown())
}));

export type ReviewCreate = v.InferOutput<typeof reviewCreateSchema>;
export type ReviewUpdate = v.InferOutput<typeof reviewUpdateSchema>;

// MarketingCampaign Schemas (TR)
export const marketingCampaignCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  targetType: v.string(),
  targetIds: v.string()
});

export const marketingCampaignUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.enum_(CampaignType)),
  status: v.optional(v.enum_(CampaignStatus)),
  targetType: v.optional(v.string()),
  targetIds: v.optional(v.string()),
  subject: v.optional(v.string()),
  content: v.optional(v.string()),
  templateId: v.optional(v.string()),
  scheduledAt: v.optional(v.string()),
  sentAt: v.optional(v.string()),
  completedAt: v.optional(v.string()),
  sentCount: v.optional(v.number()),
  openCount: v.optional(v.number()),
  clickCount: v.optional(v.number()),
  conversionCount: v.optional(v.number())
}));

export type MarketingCampaignCreate = v.InferOutput<typeof marketingCampaignCreateSchema>;
export type MarketingCampaignUpdate = v.InferOutput<typeof marketingCampaignUpdateSchema>;

// OrgSubscription Schemas (TR)
export const orgSubscriptionCreateSchema = v.object({
  orgId: v.string(),
  planId: v.string()
});

export const orgSubscriptionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  planId: v.optional(v.string()),
  status: v.optional(v.string()),
  stripeCustomerId: v.optional(v.string()),
  stripeSubscriptionId: v.optional(v.string()),
  currentPeriodEnd: v.optional(v.string())
}));

export type OrgSubscriptionCreate = v.InferOutput<typeof orgSubscriptionCreateSchema>;
export type OrgSubscriptionUpdate = v.InferOutput<typeof orgSubscriptionUpdateSchema>;

// Plan Schemas (TR)
export const planCreateSchema = v.object({
  key: v.string(),
  name: v.string(),
  limits: v.unknown()
});

export const planUpdateSchema = v.partial(v.object({
  key: v.optional(v.string()),
  name: v.optional(v.string()),
  limits: v.optional(v.unknown())
}));

export type PlanCreate = v.InferOutput<typeof planCreateSchema>;
export type PlanUpdate = v.InferOutput<typeof planUpdateSchema>;

// MLSConnection Schemas (TR)
export const mLSConnectionCreateSchema = v.object({
  orgId: v.string(),
  provider: v.enum_(MLSProviderKey),
  name: v.string()
});

export const mLSConnectionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  provider: v.optional(v.enum_(MLSProviderKey)),
  name: v.optional(v.string()),
  baseUrl: v.optional(v.string()),
  isEnabled: v.optional(v.boolean()),
  usernameCiphertext: v.optional(v.string()),
  passwordCiphertext: v.optional(v.string()),
  apiKeyCiphertext: v.optional(v.string()),
  tokenCiphertext: v.optional(v.string()),
  region: v.optional(v.enum_(Region)),
  config: v.optional(v.unknown()),
  lastSyncAt: v.optional(v.string()),
  status: v.optional(v.enum_(SyncStatus)),
  lastError: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type MLSConnectionCreate = v.InferOutput<typeof mLSConnectionCreateSchema>;
export type MLSConnectionUpdate = v.InferOutput<typeof mLSConnectionUpdateSchema>;

// MLSSyncJob Schemas (TR)
export const mLSSyncJobCreateSchema = v.object({
  orgId: v.string(),
  connectionId: v.string()
});

export const mLSSyncJobUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  connectionId: v.optional(v.string()),
  status: v.optional(v.enum_(SyncStatus)),
  startedAt: v.optional(v.string()),
  finishedAt: v.optional(v.string()),
  error: v.optional(v.string()),
  stats: v.optional(v.unknown())
}));

export type MLSSyncJobCreate = v.InferOutput<typeof mLSSyncJobCreateSchema>;
export type MLSSyncJobUpdate = v.InferOutput<typeof mLSSyncJobUpdateSchema>;

// MLSExternalListing Schemas (TR)
export const mLSExternalListingCreateSchema = v.object({
  orgId: v.string(),
  connectionId: v.string(),
  externalId: v.string(),
  raw: v.unknown()
});

export const mLSExternalListingUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  connectionId: v.optional(v.string()),
  externalId: v.optional(v.string()),
  externalUrl: v.optional(v.string()),
  raw: v.optional(v.unknown()),
  mappedListingId: v.optional(v.string()),
  status: v.optional(v.string()),
  lastSeenAt: v.optional(v.string())
}));

export type MLSExternalListingCreate = v.InferOutput<typeof mLSExternalListingCreateSchema>;
export type MLSExternalListingUpdate = v.InferOutput<typeof mLSExternalListingUpdateSchema>;

// Commission Schemas (TR)
export const commissionCreateSchema = v.object({
  orgId: v.string()
});

export const commissionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bookingId: v.optional(v.string()),
  transactionId: v.optional(v.string()),
  beneficiaryUserId: v.optional(v.string()),
  beneficiaryOrgId: v.optional(v.string()),
  ruleData: v.optional(v.unknown())
}));

export type CommissionCreate = v.InferOutput<typeof commissionCreateSchema>;
export type CommissionUpdate = v.InferOutput<typeof commissionUpdateSchema>;

// PropertyPhoto Schemas (TR)
export const propertyPhotoCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  url: v.string()
});

export const propertyPhotoUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  url: v.optional(v.string()),
  caption: v.optional(v.string()),
  isPrimary: v.optional(v.boolean()),
  sortOrder: v.optional(v.number())
}));

export type PropertyPhotoCreate = v.InferOutput<typeof propertyPhotoCreateSchema>;
export type PropertyPhotoUpdate = v.InferOutput<typeof propertyPhotoUpdateSchema>;

// PropertyCompliance Schemas (TR)
export const propertyComplianceCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  type: v.string()
});

export const propertyComplianceUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  type: v.optional(v.string()),
  status: v.optional(v.string()),
  data: v.optional(v.unknown()),
  inspectorId: v.optional(v.string()),
  inspectorContactId: v.optional(v.string())
}));

export type PropertyComplianceCreate = v.InferOutput<typeof propertyComplianceCreateSchema>;
export type PropertyComplianceUpdate = v.InferOutput<typeof propertyComplianceUpdateSchema>;

// PropertyDocument Schemas (TR)
export const propertyDocumentCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  title: v.string(),
  fileName: v.string(),
  mimeType: v.string(),
  sizeBytes: v.number(),
  storageKey: v.string()
});

export const propertyDocumentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  title: v.optional(v.string()),
  fileName: v.optional(v.string()),
  mimeType: v.optional(v.string()),
  sizeBytes: v.optional(v.number()),
  storageKey: v.optional(v.string()),
  category: v.optional(v.string())
}));

export type PropertyDocumentCreate = v.InferOutput<typeof propertyDocumentCreateSchema>;
export type PropertyDocumentUpdate = v.InferOutput<typeof propertyDocumentUpdateSchema>;

// Amenity Schemas (TR)
export const amenityCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  category: v.enum_(AmenityCategory)
});

export const amenityUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  category: v.optional(v.enum_(AmenityCategory)),
  icon: v.optional(v.string())
}));

export type AmenityCreate = v.InferOutput<typeof amenityCreateSchema>;
export type AmenityUpdate = v.InferOutput<typeof amenityUpdateSchema>;

// PropertyAmenity Schemas (TR)
export const propertyAmenityCreateSchema = v.object({
  propertyId: v.string(),
  amenityId: v.string(),
  orgId: v.string()
});

export const propertyAmenityUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  amenityId: v.optional(v.string()),
  orgId: v.optional(v.string())
}));

export type PropertyAmenityCreate = v.InferOutput<typeof propertyAmenityCreateSchema>;
export type PropertyAmenityUpdate = v.InferOutput<typeof propertyAmenityUpdateSchema>;

// Neighborhood Schemas (TR)
export const neighborhoodCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  city: v.string()
});

export const neighborhoodUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  city: v.optional(v.string()),
  state: v.optional(v.string()),
  zip: v.optional(v.string()),
  lat: v.optional(v.number()),
  lng: v.optional(v.number()),
  avgPrice: v.optional(v.number()),
  medianPrice: v.optional(v.number()),
  propertyCount: v.optional(v.number())
}));

export type NeighborhoodCreate = v.InferOutput<typeof neighborhoodCreateSchema>;
export type NeighborhoodUpdate = v.InferOutput<typeof neighborhoodUpdateSchema>;

// RecommendationResult Schemas (TR)
export const recommendationResultCreateSchema = v.object({
  profileId: v.string(),
  orgId: v.string(),
  score: v.number(),
  explanation: v.string()
});

export const recommendationResultUpdateSchema = v.partial(v.object({
  profileId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  score: v.optional(v.number()),
  explanation: v.optional(v.string()),
  breakdown: v.optional(v.unknown())
}));

export type RecommendationResultCreate = v.InferOutput<typeof recommendationResultCreateSchema>;
export type RecommendationResultUpdate = v.InferOutput<typeof recommendationResultUpdateSchema>;

// Event Schemas (TR)
export const eventCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  name: v.string(),
  eventType: v.string(),
  startDate: v.string(),
  endDate: v.string()
});

export const eventUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  eventType: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  maxAttendees: v.optional(v.number()),
  isPublic: v.optional(v.boolean()),
  status: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type EventCreate = v.InferOutput<typeof eventCreateSchema>;
export type EventUpdate = v.InferOutput<typeof eventUpdateSchema>;

// EventAttendee Schemas (TR)
export const eventAttendeeCreateSchema = v.object({
  orgId: v.string(),
  eventId: v.string()
});

export const eventAttendeeUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  eventId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  userId: v.optional(v.string()),
  rsvpStatus: v.optional(v.string()),
  notes: v.optional(v.string())
}));

export type EventAttendeeCreate = v.InferOutput<typeof eventAttendeeCreateSchema>;
export type EventAttendeeUpdate = v.InferOutput<typeof eventAttendeeUpdateSchema>;

// PropertyOffer Schemas (TR)
export const propertyOfferCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  contactId: v.string(),
  offerPrice: v.number()
});

export const propertyOfferUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  originalOfferId: v.optional(v.string()),
  offerPrice: v.optional(v.number()),
  currency: v.optional(v.string()),
  closingDate: v.optional(v.string()),
  financingType: v.optional(v.string()),
  earnestMoneyDeposit: v.optional(v.number()),
  dueDiligencePeriod: v.optional(v.number()),
  inspectionContingency: v.optional(v.boolean()),
  appraisalContingency: v.optional(v.boolean()),
  specialConditions: v.optional(v.string()),
  status: v.optional(v.string()),
  validUntil: v.optional(v.string())
}));

export type PropertyOfferCreate = v.InferOutput<typeof propertyOfferCreateSchema>;
export type PropertyOfferUpdate = v.InferOutput<typeof propertyOfferUpdateSchema>;

// Reservation Schemas (TR)
export const reservationCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string(),
  contactId: v.string(),
  checkInDate: v.string(),
  checkOutDate: v.string(),
  guestCount: v.number(),
  nightlyRate: v.number(),
  cleaningFee: v.number(),
  totalAmount: v.number()
});

export const reservationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  checkInDate: v.optional(v.string()),
  checkOutDate: v.optional(v.string()),
  guestCount: v.optional(v.number()),
  specialRequests: v.optional(v.string()),
  nightlyRate: v.optional(v.number()),
  cleaningFee: v.optional(v.number()),
  totalAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.string()),
  paymentStatus: v.optional(v.enum_(PaymentStatus)),
  validUntil: v.optional(v.string()),
  hotelId: v.optional(v.string()),
  hotelRoomTypeId: v.optional(v.string()),
  hotelRatePlanId: v.optional(v.string())
}));

export type ReservationCreate = v.InferOutput<typeof reservationCreateSchema>;
export type ReservationUpdate = v.InferOutput<typeof reservationUpdateSchema>;

// DocumentTemplate Schemas (TR)
export const documentTemplateCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.string(),
  templateContent: v.string()
});

export const documentTemplateUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.string()),
  category: v.optional(v.string()),
  templateContent: v.optional(v.string()),
  variables: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type DocumentTemplateCreate = v.InferOutput<typeof documentTemplateCreateSchema>;
export type DocumentTemplateUpdate = v.InferOutput<typeof documentTemplateUpdateSchema>;

// Appointment Schemas (TR)
export const appointmentCreateSchema = v.object({
  orgId: v.string(),
  title: v.string(),
  appointmentType: v.string(),
  startDate: v.string(),
  endDate: v.string()
});

export const appointmentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  appointmentType: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  timezone: v.optional(v.string()),
  status: v.optional(v.string()),
  location: v.optional(v.string()),
  assignedToUserId: v.optional(v.string()),
  assignedToContactId: v.optional(v.string()),
  reminders: v.optional(v.unknown())
}));

export type AppointmentCreate = v.InferOutput<typeof appointmentCreateSchema>;
export type AppointmentUpdate = v.InferOutput<typeof appointmentUpdateSchema>;

// CalendarEvent Schemas (TR)
export const calendarEventCreateSchema = v.object({
  orgId: v.string(),
  userId: v.string(),
  title: v.string(),
  startDate: v.string(),
  endDate: v.string()
});

export const calendarEventUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  externalId: v.optional(v.string()),
  externalSource: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  timezone: v.optional(v.string()),
  location: v.optional(v.string()),
  attendees: v.optional(v.unknown())
}));

export type CalendarEventCreate = v.InferOutput<typeof calendarEventCreateSchema>;
export type CalendarEventUpdate = v.InferOutput<typeof calendarEventUpdateSchema>;

// Report Schemas (TR)
export const reportCreateSchema = v.object({
  orgId: v.string(),
  userId: v.string(),
  name: v.string(),
  reportType: v.string(),
  config: v.unknown()
});

export const reportUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  reportType: v.optional(v.string()),
  config: v.optional(v.unknown()),
  schedule: v.optional(v.unknown()),
  recipients: v.optional(v.unknown()),
  lastRunAt: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type ReportCreate = v.InferOutput<typeof reportCreateSchema>;
export type ReportUpdate = v.InferOutput<typeof reportUpdateSchema>;

// ReportExecution Schemas (TR)
export const reportExecutionCreateSchema = v.object({
  orgId: v.string(),
  reportId: v.string(),
  executedAt: v.string(),
  executedBy: v.string(),
  status: v.string()
});

export const reportExecutionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reportId: v.optional(v.string()),
  executedAt: v.optional(v.string()),
  executedBy: v.optional(v.string()),
  status: v.optional(v.string()),
  resultUrl: v.optional(v.string()),
  errorMessage: v.optional(v.string()),
  parameters: v.optional(v.unknown())
}));

export type ReportExecutionCreate = v.InferOutput<typeof reportExecutionCreateSchema>;
export type ReportExecutionUpdate = v.InferOutput<typeof reportExecutionUpdateSchema>;

// Webhook Schemas (TR)
export const webhookCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  url: v.string(),
  secret: v.string(),
  events: v.string()
});

export const webhookUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  url: v.optional(v.string()),
  secret: v.optional(v.string()),
  events: v.optional(v.string()),
  headers: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  lastTriggeredAt: v.optional(v.string()),
  failureCount: v.optional(v.number())
}));

export type WebhookCreate = v.InferOutput<typeof webhookCreateSchema>;
export type WebhookUpdate = v.InferOutput<typeof webhookUpdateSchema>;

// WebhookDelivery Schemas (TR)
export const webhookDeliveryCreateSchema = v.object({
  orgId: v.string(),
  webhookId: v.string(),
  eventType: v.string(),
  payload: v.unknown()
});

export const webhookDeliveryUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  webhookId: v.optional(v.string()),
  eventType: v.optional(v.string()),
  payload: v.optional(v.unknown()),
  response: v.optional(v.unknown()),
  statusCode: v.optional(v.number()),
  deliveredAt: v.optional(v.string()),
  error: v.optional(v.string())
}));

export type WebhookDeliveryCreate = v.InferOutput<typeof webhookDeliveryCreateSchema>;
export type WebhookDeliveryUpdate = v.InferOutput<typeof webhookDeliveryUpdateSchema>;

// AuditLog Schemas (TR)
export const auditLogCreateSchema = v.object({
  orgId: v.string(),
  action: v.string(),
  entityType: v.string(),
  entityId: v.string()
});

export const auditLogUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  action: v.optional(v.string()),
  entityType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  oldValues: v.optional(v.unknown()),
  newValues: v.optional(v.unknown()),
  changes: v.optional(v.unknown()),
  ipAddress: v.optional(v.string()),
  userAgent: v.optional(v.string()),
  sessionId: v.optional(v.string())
}));

export type AuditLogCreate = v.InferOutput<typeof auditLogCreateSchema>;
export type AuditLogUpdate = v.InferOutput<typeof auditLogUpdateSchema>;

// CommunicationTemplate Schemas (TR)
export const communicationTemplateCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.string(),
  templateType: v.string(),
  channels: v.string()
});

export const communicationTemplateUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.string()),
  templateType: v.optional(v.string()),
  subject: v.optional(v.string()),
  htmlContent: v.optional(v.string()),
  textContent: v.optional(v.string()),
  title: v.optional(v.string()),
  message: v.optional(v.string()),
  channels: v.optional(v.string()),
  category: v.optional(v.string()),
  variables: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type CommunicationTemplateCreate = v.InferOutput<typeof communicationTemplateCreateSchema>;
export type CommunicationTemplateUpdate = v.InferOutput<typeof communicationTemplateUpdateSchema>;

// Budget Schemas (TR)
export const budgetCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  budgetType: v.string(),
  period: v.string(),
  startDate: v.string(),
  endDate: v.string(),
  totalAmount: v.number()
});

export const budgetUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  budgetType: v.optional(v.string()),
  period: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  totalAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  lineItems: v.optional(v.unknown())
}));

export type BudgetCreate = v.InferOutput<typeof budgetCreateSchema>;
export type BudgetUpdate = v.InferOutput<typeof budgetUpdateSchema>;

// Quote Schemas (TR)
export const quoteCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  quoteNumber: v.string(),
  title: v.string(),
  items: v.unknown()
});

export const quoteUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  quoteNumber: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  items: v.optional(v.unknown())
}));

export type QuoteCreate = v.InferOutput<typeof quoteCreateSchema>;
export type QuoteUpdate = v.InferOutput<typeof quoteUpdateSchema>;

// Project Schemas (TR)
export const projectCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  projectType: v.string()
});

export const projectUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  projectType: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  address: v.optional(v.string()),
  status: v.optional(v.string()),
  startDate: v.optional(v.string()),
  estimatedEndDate: v.optional(v.string()),
  actualEndDate: v.optional(v.string()),
  budget: v.optional(v.number()),
  currency: v.optional(v.string()),
  actualCost: v.optional(v.number()),
  managerId: v.optional(v.string()),
  contractorId: v.optional(v.string()),
  milestones: v.optional(v.unknown()),
  phases: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type ProjectCreate = v.InferOutput<typeof projectCreateSchema>;
export type ProjectUpdate = v.InferOutput<typeof projectUpdateSchema>;

// FloorPlan Schemas (TR)
export const floorPlanCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  name: v.string(),
  floorLevel: v.number(),
  imageUrl: v.string()
});

export const floorPlanUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  floorLevel: v.optional(v.number()),
  imageUrl: v.optional(v.string()),
  imageWidth: v.optional(v.number()),
  imageHeight: v.optional(v.number()),
  rooms: v.optional(v.unknown())
}));

export type FloorPlanCreate = v.InferOutput<typeof floorPlanCreateSchema>;
export type FloorPlanUpdate = v.InferOutput<typeof floorPlanUpdateSchema>;

// VirtualTour Schemas (TR)
export const virtualTourCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  name: v.string(),
  tourType: v.string()
});

export const virtualTourUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  tourType: v.optional(v.string()),
  videoUrl: v.optional(v.string()),
  embedCode: v.optional(v.string()),
  thumbnailUrl: v.optional(v.string()),
  duration: v.optional(v.number()),
  hotspots: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type VirtualTourCreate = v.InferOutput<typeof virtualTourCreateSchema>;
export type VirtualTourUpdate = v.InferOutput<typeof virtualTourUpdateSchema>;

// KeyManagement Schemas (TR)
export const keyManagementCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  keyType: v.string()
});

export const keyManagementUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  keyType: v.optional(v.string()),
  keyNumber: v.optional(v.string()),
  keyLocation: v.optional(v.string()),
  keySafeCode: v.optional(v.string()),
  keyStatus: v.optional(v.string()),
  cutDate: v.optional(v.string()),
  cutBy: v.optional(v.string()),
  replacementCost: v.optional(v.number()),
  notes: v.optional(v.string())
}));

export type KeyManagementCreate = v.InferOutput<typeof keyManagementCreateSchema>;
export type KeyManagementUpdate = v.InferOutput<typeof keyManagementUpdateSchema>;

// PropertyInventory Schemas (TR)
export const propertyInventoryCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  inventoryType: v.string(),
  inventoryDate: v.string(),
  conductedBy: v.string(),
  presentAtCheck: v.string()
});

export const propertyInventoryUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  inventoryType: v.optional(v.string()),
  inventoryDate: v.optional(v.string()),
  conductedBy: v.optional(v.string()),
  presentAtCheck: v.optional(v.string()),
  rooms: v.optional(v.unknown())
}));

export type PropertyInventoryCreate = v.InferOutput<typeof propertyInventoryCreateSchema>;
export type PropertyInventoryUpdate = v.InferOutput<typeof propertyInventoryUpdateSchema>;

// SecurityDepositProtection Schemas (TR)
export const securityDepositProtectionCreateSchema = v.object({
  // No required fields
});

export const securityDepositProtectionUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SecurityDepositProtectionCreate = v.InferOutput<typeof securityDepositProtectionCreateSchema>;
export type SecurityDepositProtectionUpdate = v.InferOutput<typeof securityDepositProtectionUpdateSchema>;

// PropertyViewing Schemas (TR)
export const propertyViewingCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  viewingType: v.string(),
  scheduledDate: v.string(),
  duration: v.number(),
  attendeeName: v.string(),
  attendeeEmail: v.string(),
  attendeeType: v.string()
});

export const propertyViewingUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  viewingType: v.optional(v.string()),
  scheduledDate: v.optional(v.string()),
  duration: v.optional(v.number()),
  attendeeName: v.optional(v.string()),
  attendeeEmail: v.optional(v.string()),
  attendeePhone: v.optional(v.string()),
  attendeeType: v.optional(v.string()),
  status: v.optional(v.string()),
  assignedAgentId: v.optional(v.string()),
  feedback: v.optional(v.string()),
  interestedLevel: v.optional(v.string()),
  followUpRequired: v.optional(v.boolean()),
  followUpNotes: v.optional(v.string())
}));

export type PropertyViewingCreate = v.InferOutput<typeof propertyViewingCreateSchema>;
export type PropertyViewingUpdate = v.InferOutput<typeof propertyViewingUpdateSchema>;

// PropertyDisclosure Schemas (TR)
export const propertyDisclosureCreateSchema = v.object({
  // No required fields
});

export const propertyDisclosureUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertyDisclosureCreate = v.InferOutput<typeof propertyDisclosureCreateSchema>;
export type PropertyDisclosureUpdate = v.InferOutput<typeof propertyDisclosureUpdateSchema>;

// ImmigrationStatusCheck Schemas (TR)
export const immigrationStatusCheckCreateSchema = v.object({
  // No required fields
});

export const immigrationStatusCheckUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ImmigrationStatusCheckCreate = v.InferOutput<typeof immigrationStatusCheckCreateSchema>;
export type ImmigrationStatusCheckUpdate = v.InferOutput<typeof immigrationStatusCheckUpdateSchema>;

// RentArrears Schemas (TR)
export const rentArrearsCreateSchema = v.object({
  orgId: v.string(),
  leaseId: v.string(),
  tenantId: v.string(),
  periodStart: v.string(),
  periodEnd: v.string(),
  rentDue: v.number()
});

export const rentArrearsUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  periodStart: v.optional(v.string()),
  periodEnd: v.optional(v.string()),
  rentDue: v.optional(v.number()),
  rentPaid: v.optional(v.number()),
  arrearsAmount: v.optional(v.number()),
  status: v.optional(v.string()),
  lastPaymentDate: v.optional(v.string()),
  noticeSent: v.optional(v.boolean()),
  noticeDate: v.optional(v.string()),
  noticeType: v.optional(v.string()),
  legalAction: v.optional(v.boolean()),
  legalReference: v.optional(v.string()),
  courtDate: v.optional(v.string()),
  recoveryAmount: v.optional(v.number()),
  writeOffAmount: v.optional(v.number())
}));

export type RentArrearsCreate = v.InferOutput<typeof rentArrearsCreateSchema>;
export type RentArrearsUpdate = v.InferOutput<typeof rentArrearsUpdateSchema>;

// AttorneyManagement Schemas (TR)
export const attorneyManagementCreateSchema = v.object({
  // No required fields
});

export const attorneyManagementUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AttorneyManagementCreate = v.InferOutput<typeof attorneyManagementCreateSchema>;
export type AttorneyManagementUpdate = v.InferOutput<typeof attorneyManagementUpdateSchema>;

// MortgagePreApproval Schemas (TR)
export const mortgagePreApprovalCreateSchema = v.object({
  // No required fields
});

export const mortgagePreApprovalUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MortgagePreApprovalCreate = v.InferOutput<typeof mortgagePreApprovalCreateSchema>;
export type MortgagePreApprovalUpdate = v.InferOutput<typeof mortgagePreApprovalUpdateSchema>;

// AIModel Schemas (TR)
export const aIModelCreateSchema = v.object({
  modelName: v.string(),
  modelVersion: v.string(),
  modelType: v.string(),
  provider: v.string()
});

export const aIModelUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelName: v.optional(v.string()),
  modelVersion: v.optional(v.string()),
  modelType: v.optional(v.string()),
  provider: v.optional(v.string()),
  endpointUrl: v.optional(v.string()),
  apiKey: v.optional(v.string()),
  status: v.optional(v.string()),
  accuracy: v.optional(v.number()),
  lastTrainedAt: v.optional(v.string()),
  config: v.optional(v.unknown()),
  metadata: v.optional(v.unknown())
}));

export type AIModelCreate = v.InferOutput<typeof aIModelCreateSchema>;
export type AIModelUpdate = v.InferOutput<typeof aIModelUpdateSchema>;

// AIModelDeployment Schemas (TR)
export const aIModelDeploymentCreateSchema = v.object({
  modelId: v.string(),
  deploymentId: v.string(),
  environment: v.string()
});

export const aIModelDeploymentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelId: v.optional(v.string()),
  deploymentId: v.optional(v.string()),
  environment: v.optional(v.string()),
  status: v.optional(v.string()),
  deployedAt: v.optional(v.string()),
  lastHealthCheck: v.optional(v.string()),
  config: v.optional(v.unknown()),
  metrics: v.optional(v.unknown())
}));

export type AIModelDeploymentCreate = v.InferOutput<typeof aIModelDeploymentCreateSchema>;
export type AIModelDeploymentUpdate = v.InferOutput<typeof aIModelDeploymentUpdateSchema>;

// AIPrediction Schemas (TR)
export const aIPredictionCreateSchema = v.object({
  orgId: v.string(),
  confidence: v.number()
});

export const aIPredictionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelId: v.optional(v.string()),
  requestId: v.optional(v.string()),
  inputData: v.optional(v.unknown()),
  outputData: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  processingTimeMs: v.optional(v.number()),
  status: v.optional(v.string()),
  errorMessage: v.optional(v.string())
}));

export type AIPredictionCreate = v.InferOutput<typeof aIPredictionCreateSchema>;
export type AIPredictionUpdate = v.InferOutput<typeof aIPredictionUpdateSchema>;

// QueueMessage Schemas (TR)
export const queueMessageCreateSchema = v.object({
  messageId: v.string(),
  queueName: v.string(),
  messageType: v.string(),
  payload: v.unknown()
});

export const queueMessageUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  messageId: v.optional(v.string()),
  queueName: v.optional(v.string()),
  exchangeName: v.optional(v.string()),
  routingKey: v.optional(v.string()),
  messageType: v.optional(v.string()),
  payload: v.optional(v.unknown()),
  status: v.optional(v.string()),
  priority: v.optional(v.number()),
  retryCount: v.optional(v.number()),
  maxRetries: v.optional(v.number()),
  nextRetryAt: v.optional(v.string()),
  processedAt: v.optional(v.string()),
  completedAt: v.optional(v.string()),
  failedAt: v.optional(v.string()),
  errorMessage: v.optional(v.string())
}));

export type QueueMessageCreate = v.InferOutput<typeof queueMessageCreateSchema>;
export type QueueMessageUpdate = v.InferOutput<typeof queueMessageUpdateSchema>;

// QueueConfiguration Schemas (TR)
export const queueConfigurationCreateSchema = v.object({
  queueName: v.string(),
  messageType: v.string(),
  handlerClass: v.string()
});

export const queueConfigurationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  queueName: v.optional(v.string()),
  exchangeName: v.optional(v.string()),
  routingKey: v.optional(v.string()),
  messageType: v.optional(v.string()),
  handlerClass: v.optional(v.string()),
  maxConcurrency: v.optional(v.number()),
  retryPolicy: v.optional(v.unknown())
}));

export type QueueConfigurationCreate = v.InferOutput<typeof queueConfigurationCreateSchema>;
export type QueueConfigurationUpdate = v.InferOutput<typeof queueConfigurationUpdateSchema>;

// IntegrationLog Schemas (TR)
export const integrationLogCreateSchema = v.object({
  integrationType: v.string(),
  operation: v.string(),
  success: v.boolean()
});

export const integrationLogUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  integrationType: v.optional(v.string()),
  operation: v.optional(v.string()),
  requestData: v.optional(v.unknown()),
  responseData: v.optional(v.unknown()),
  statusCode: v.optional(v.number()),
  success: v.optional(v.boolean()),
  errorMessage: v.optional(v.string()),
  processingTimeMs: v.optional(v.number()),
  externalId: v.optional(v.string()),
  correlationId: v.optional(v.string())
}));

export type IntegrationLogCreate = v.InferOutput<typeof integrationLogCreateSchema>;
export type IntegrationLogUpdate = v.InferOutput<typeof integrationLogUpdateSchema>;

// AutomationRule Schemas (TR)
export const automationRuleCreateSchema = v.object({
  orgId: v.string(),
  ruleName: v.string(),
  ruleType: v.string(),
  triggerType: v.string(),
  triggerConfig: v.unknown()
});

export const automationRuleUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  ruleName: v.optional(v.string()),
  ruleType: v.optional(v.string()),
  triggerType: v.optional(v.string()),
  triggerConfig: v.optional(v.unknown())
}));

export type AutomationRuleCreate = v.InferOutput<typeof automationRuleCreateSchema>;
export type AutomationRuleUpdate = v.InferOutput<typeof automationRuleUpdateSchema>;

// AutomationExecution Schemas (TR)
export const automationExecutionCreateSchema = v.object({
  orgId: v.string(),
  ruleId: v.string(),
  executionData: v.unknown()
});

export const automationExecutionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  ruleId: v.optional(v.string()),
  triggerEvent: v.optional(v.unknown()),
  executionData: v.optional(v.unknown()),
  status: v.optional(v.string()),
  executedAt: v.optional(v.string()),
  processingTimeMs: v.optional(v.number())
}));

export type AutomationExecutionCreate = v.InferOutput<typeof automationExecutionCreateSchema>;
export type AutomationExecutionUpdate = v.InferOutput<typeof automationExecutionUpdateSchema>;

// AIValuationModel Schemas (TR)
export const aIValuationModelCreateSchema = v.object({
  modelName: v.string(),
  modelVersion: v.string(),
  accuracy: v.number(),
  lastTrainedAt: v.string(),
  features: v.unknown()
});

export const aIValuationModelUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelName: v.optional(v.string()),
  modelVersion: v.optional(v.string()),
  accuracy: v.optional(v.number()),
  lastTrainedAt: v.optional(v.string()),
  features: v.optional(v.unknown())
}));

export type AIValuationModelCreate = v.InferOutput<typeof aIValuationModelCreateSchema>;
export type AIValuationModelUpdate = v.InferOutput<typeof aIValuationModelUpdateSchema>;

// AIPropertyValuation Schemas (TR)
export const aIPropertyValuationCreateSchema = v.object({
  modelId: v.string(),
  propertyId: v.string(),
  predictedValue: v.number(),
  confidenceScore: v.number(),
  valuationDate: v.string(),
  inputFeatures: v.unknown()
});

export const aIPropertyValuationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  predictedValue: v.optional(v.number()),
  confidenceScore: v.optional(v.number()),
  valuationDate: v.optional(v.string()),
  inputFeatures: v.optional(v.unknown()),
  comparableSales: v.optional(v.unknown()),
  marketTrends: v.optional(v.unknown()),
  status: v.optional(v.string())
}));

export type AIPropertyValuationCreate = v.InferOutput<typeof aIPropertyValuationCreateSchema>;
export type AIPropertyValuationUpdate = v.InferOutput<typeof aIPropertyValuationUpdateSchema>;

// AILeadScoring Schemas (TR)
export const aILeadScoringCreateSchema = v.object({
  modelName: v.string(),
  modelVersion: v.string(),
  accuracy: v.number(),
  lastTrainedAt: v.string(),
  features: v.unknown(),
  scoringLogic: v.unknown()
});

export const aILeadScoringUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelName: v.optional(v.string()),
  modelVersion: v.optional(v.string()),
  accuracy: v.optional(v.number()),
  lastTrainedAt: v.optional(v.string()),
  features: v.optional(v.unknown()),
  scoringLogic: v.optional(v.unknown()),
  isActive: v.optional(v.boolean())
}));

export type AILeadScoringCreate = v.InferOutput<typeof aILeadScoringCreateSchema>;
export type AILeadScoringUpdate = v.InferOutput<typeof aILeadScoringUpdateSchema>;

// AILeadScore Schemas (TR)
export const aILeadScoreCreateSchema = v.object({
  modelId: v.string(),
  leadId: v.string(),
  score: v.number(),
  scoreBreakdown: v.unknown()
});

export const aILeadScoreUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelId: v.optional(v.string()),
  leadId: v.optional(v.string()),
  score: v.optional(v.number()),
  scoreBreakdown: v.optional(v.unknown())
}));

export type AILeadScoreCreate = v.InferOutput<typeof aILeadScoreCreateSchema>;
export type AILeadScoreUpdate = v.InferOutput<typeof aILeadScoreUpdateSchema>;

// AIMarketAnalysis Schemas (TR)
export const aIMarketAnalysisCreateSchema = v.object({
  analysisType: v.string(),
  location: v.string(),
  analysisPeriod: v.string(),
  dataPoints: v.unknown(),
  predictions: v.unknown(),
  insights: v.unknown(),
  confidence: v.number(),
  generatedAt: v.string()
});

export const aIMarketAnalysisUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  analysisType: v.optional(v.string()),
  location: v.optional(v.string()),
  analysisPeriod: v.optional(v.string()),
  dataPoints: v.optional(v.unknown()),
  predictions: v.optional(v.unknown()),
  insights: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  generatedAt: v.optional(v.string()),
  status: v.optional(v.string())
}));

export type AIMarketAnalysisCreate = v.InferOutput<typeof aIMarketAnalysisCreateSchema>;
export type AIMarketAnalysisUpdate = v.InferOutput<typeof aIMarketAnalysisUpdateSchema>;

// AIPropertyDescription Schemas (TR)
export const aIPropertyDescriptionCreateSchema = v.object({
  propertyId: v.string(),
  generatedDescription: v.string(),
  tone: v.string(),
  targetAudience: v.string(),
  keyFeatures: v.unknown(),
  seoKeywords: v.unknown(),
  qualityScore: v.number(),
  generatedAt: v.string()
});

export const aIPropertyDescriptionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  generatedDescription: v.optional(v.string()),
  originalDescription: v.optional(v.string()),
  tone: v.optional(v.string()),
  targetAudience: v.optional(v.string()),
  keyFeatures: v.optional(v.unknown()),
  seoKeywords: v.optional(v.unknown()),
  qualityScore: v.optional(v.number()),
  generatedAt: v.optional(v.string()),
  isApproved: v.optional(v.boolean()),
  approvedBy: v.optional(v.string()),
  approvedAt: v.optional(v.string())
}));

export type AIPropertyDescriptionCreate = v.InferOutput<typeof aIPropertyDescriptionCreateSchema>;
export type AIPropertyDescriptionUpdate = v.InferOutput<typeof aIPropertyDescriptionUpdateSchema>;

// AIImageAnalysis Schemas (TR)
export const aIImageAnalysisCreateSchema = v.object({
  propertyId: v.string(),
  analysisType: v.string()
});

export const aIImageAnalysisUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  photoId: v.optional(v.string()),
  analysisType: v.optional(v.string()),
  detectedRooms: v.optional(v.unknown())
}));

export type AIImageAnalysisCreate = v.InferOutput<typeof aIImageAnalysisCreateSchema>;
export type AIImageAnalysisUpdate = v.InferOutput<typeof aIImageAnalysisUpdateSchema>;

// AIPriceOptimization Schemas (TR)
export const aIPriceOptimizationCreateSchema = v.object({
  listingId: v.string(),
  currentPrice: v.number(),
  recommendedPrice: v.number(),
  priceRange: v.unknown()
});

export const aIPriceOptimizationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  currentPrice: v.optional(v.number()),
  recommendedPrice: v.optional(v.number()),
  priceRange: v.optional(v.unknown())
}));

export type AIPriceOptimizationCreate = v.InferOutput<typeof aIPriceOptimizationCreateSchema>;
export type AIPriceOptimizationUpdate = v.InferOutput<typeof aIPriceOptimizationUpdateSchema>;

// AISentimentAnalysis Schemas (TR)
export const aISentimentAnalysisCreateSchema = v.object({
  contentType: v.string(),
  contentId: v.string(),
  contentText: v.string(),
  sentiment: v.string(),
  sentimentScore: v.number(),
  confidence: v.number()
});

export const aISentimentAnalysisUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contentType: v.optional(v.string()),
  contentId: v.optional(v.string()),
  contentText: v.optional(v.string()),
  sentiment: v.optional(v.string()),
  sentimentScore: v.optional(v.number()),
  confidence: v.optional(v.number()),
  keyPhrases: v.optional(v.unknown()),
  emotions: v.optional(v.unknown())
}));

export type AISentimentAnalysisCreate = v.InferOutput<typeof aISentimentAnalysisCreateSchema>;
export type AISentimentAnalysisUpdate = v.InferOutput<typeof aISentimentAnalysisUpdateSchema>;

// AIFraudDetection Schemas (TR)
export const aIFraudDetectionCreateSchema = v.object({
  entityType: v.string(),
  entityId: v.string(),
  riskScore: v.number(),
  riskFactors: v.unknown()
});

export const aIFraudDetectionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  riskScore: v.optional(v.number()),
  riskFactors: v.optional(v.unknown())
}));

export type AIFraudDetectionCreate = v.InferOutput<typeof aIFraudDetectionCreateSchema>;
export type AIFraudDetectionUpdate = v.InferOutput<typeof aIFraudDetectionUpdateSchema>;

// AIRecommendation Schemas (TR)
export const aIRecommendationCreateSchema = v.object({
  userType: v.string(),
  userId: v.string(),
  recommendedProperties: v.unknown()
});

export const aIRecommendationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userType: v.optional(v.string()),
  userId: v.optional(v.string()),
  sessionId: v.optional(v.string()),
  recommendedProperties: v.optional(v.unknown())
}));

export type AIRecommendationCreate = v.InferOutput<typeof aIRecommendationCreateSchema>;
export type AIRecommendationUpdate = v.InferOutput<typeof aIRecommendationUpdateSchema>;

// AIChatbotSession Schemas (TR)
export const aIChatbotSessionCreateSchema = v.object({
  sessionId: v.string(),
  conversationHistory: v.unknown()
});

export const aIChatbotSessionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  sessionId: v.optional(v.string()),
  conversationHistory: v.optional(v.unknown())
}));

export type AIChatbotSessionCreate = v.InferOutput<typeof aIChatbotSessionCreateSchema>;
export type AIChatbotSessionUpdate = v.InferOutput<typeof aIChatbotSessionUpdateSchema>;

// AIPredictiveMaintenance Schemas (TR)
export const aIPredictiveMaintenanceCreateSchema = v.object({
  propertyId: v.string(),
  componentType: v.string(),
  failureProbability: v.number(),
  riskLevel: v.string(),
  contributingFactors: v.unknown()
});

export const aIPredictiveMaintenanceUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  componentType: v.optional(v.string()),
  failureProbability: v.optional(v.number()),
  predictedFailureDate: v.optional(v.string()),
  riskLevel: v.optional(v.string()),
  estimatedCost: v.optional(v.number()),
  contributingFactors: v.optional(v.unknown())
}));

export type AIPredictiveMaintenanceCreate = v.InferOutput<typeof aIPredictiveMaintenanceCreateSchema>;
export type AIPredictiveMaintenanceUpdate = v.InferOutput<typeof aIPredictiveMaintenanceUpdateSchema>;

// AITenantScreening Schemas (TR)
export const aITenantScreeningCreateSchema = v.object({
  applicationId: v.string(),
  overallScore: v.number(),
  riskAssessment: v.string(),
  riskFactors: v.unknown()
});

export const aITenantScreeningUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  applicationId: v.optional(v.string()),
  overallScore: v.optional(v.number()),
  riskAssessment: v.optional(v.string()),
  creditScore: v.optional(v.number()),
  incomeStability: v.optional(v.number()),
  rentalHistory: v.optional(v.number()),
  backgroundCheck: v.optional(v.number()),
  riskFactors: v.optional(v.unknown())
}));

export type AITenantScreeningCreate = v.InferOutput<typeof aITenantScreeningCreateSchema>;
export type AITenantScreeningUpdate = v.InferOutput<typeof aITenantScreeningUpdateSchema>;

// AIInvestmentAnalysis Schemas (TR)
export const aIInvestmentAnalysisCreateSchema = v.object({
  propertyId: v.string(),
  analysisType: v.string(),
  timeHorizon: v.string(),
  projectedReturns: v.unknown()
});

export const aIInvestmentAnalysisUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  analysisType: v.optional(v.string()),
  timeHorizon: v.optional(v.string()),
  projectedReturns: v.optional(v.unknown())
}));

export type AIInvestmentAnalysisCreate = v.InferOutput<typeof aIInvestmentAnalysisCreateSchema>;
export type AIInvestmentAnalysisUpdate = v.InferOutput<typeof aIInvestmentAnalysisUpdateSchema>;

// MobileDevice Schemas (TR)
export const mobileDeviceCreateSchema = v.object({
  orgId: v.string(),
  userId: v.string(),
  deviceId: v.string(),
  deviceType: v.string(),
  appVersion: v.string(),
  osVersion: v.string()
});

export const mobileDeviceUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  deviceId: v.optional(v.string()),
  deviceType: v.optional(v.string()),
  deviceToken: v.optional(v.string()),
  appVersion: v.optional(v.string()),
  osVersion: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  lastLoginAt: v.optional(v.string()),
  notificationPreferences: v.optional(v.unknown())
}));

export type MobileDeviceCreate = v.InferOutput<typeof mobileDeviceCreateSchema>;
export type MobileDeviceUpdate = v.InferOutput<typeof mobileDeviceUpdateSchema>;

// OfflineSyncQueue Schemas (TR)
export const offlineSyncQueueCreateSchema = v.object({
  orgId: v.string(),
  userId: v.string(),
  deviceId: v.string(),
  entityType: v.string(),
  entityId: v.string(),
  operation: v.string(),
  data: v.unknown()
});

export const offlineSyncQueueUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  deviceId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  operation: v.optional(v.string()),
  data: v.optional(v.unknown()),
  version: v.optional(v.number()),
  syncStatus: v.optional(v.string()),
  syncedAt: v.optional(v.string())
}));

export type OfflineSyncQueueCreate = v.InferOutput<typeof offlineSyncQueueCreateSchema>;
export type OfflineSyncQueueUpdate = v.InferOutput<typeof offlineSyncQueueUpdateSchema>;

// DashboardConfiguration Schemas (TR)
export const dashboardConfigurationCreateSchema = v.object({
  userId: v.string(),
  dashboardName: v.string(),
  layout: v.unknown(),
  widgets: v.unknown()
});

export const dashboardConfigurationUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  dashboardName: v.optional(v.string()),
  isDefault: v.optional(v.boolean()),
  layout: v.optional(v.unknown()),
  widgets: v.optional(v.unknown())
}));

export type DashboardConfigurationCreate = v.InferOutput<typeof dashboardConfigurationCreateSchema>;
export type DashboardConfigurationUpdate = v.InferOutput<typeof dashboardConfigurationUpdateSchema>;

// SystemMetrics Schemas (TR)
export const systemMetricsCreateSchema = v.object({
  metricType: v.string(),
  metricName: v.string(),
  value: v.number(),
  unit: v.string(),
  timestamp: v.string()
});

export const systemMetricsUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  metricType: v.optional(v.string()),
  metricName: v.optional(v.string()),
  value: v.optional(v.number()),
  unit: v.optional(v.string()),
  timestamp: v.optional(v.string()),
  dimensions: v.optional(v.unknown())
}));

export type SystemMetricsCreate = v.InferOutput<typeof systemMetricsCreateSchema>;
export type SystemMetricsUpdate = v.InferOutput<typeof systemMetricsUpdateSchema>;

// HealthCheck Schemas (TR)
export const healthCheckCreateSchema = v.object({
  serviceName: v.string(),
  componentName: v.string(),
  status: v.string()
});

export const healthCheckUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  serviceName: v.optional(v.string()),
  componentName: v.optional(v.string()),
  status: v.optional(v.string()),
  responseTime: v.optional(v.number()),
  details: v.optional(v.unknown()),
  errorMessage: v.optional(v.string()),
  checkedAt: v.optional(v.string())
}));

export type HealthCheckCreate = v.InferOutput<typeof healthCheckCreateSchema>;
export type HealthCheckUpdate = v.InferOutput<typeof healthCheckUpdateSchema>;

// PerformanceAlert Schemas (TR)
export const performanceAlertCreateSchema = v.object({
  alertType: v.string(),
  severity: v.string(),
  metricName: v.string(),
  threshold: v.number(),
  actualValue: v.number(),
  description: v.string()
});

export const performanceAlertUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  alertType: v.optional(v.string()),
  severity: v.optional(v.string()),
  metricName: v.optional(v.string()),
  threshold: v.optional(v.number()),
  actualValue: v.optional(v.number()),
  description: v.optional(v.string()),
  affectedServices: v.optional(v.unknown()),
  status: v.optional(v.string()),
  acknowledgedAt: v.optional(v.string()),
  acknowledgedBy: v.optional(v.string()),
  resolvedAt: v.optional(v.string())
}));

export type PerformanceAlertCreate = v.InferOutput<typeof performanceAlertCreateSchema>;
export type PerformanceAlertUpdate = v.InferOutput<typeof performanceAlertUpdateSchema>;

// EscrowAccount Schemas (TR)
export const escrowAccountCreateSchema = v.object({
  // No required fields
});

export const escrowAccountUpdateSchema = v.partial(v.object({
  bankName: v.optional(v.string()),
  bankReferenceNo: v.optional(v.string()),
  obBlockId: v.optional(v.string()),
  obConsentId: v.optional(v.string()),
  obStatus: v.optional(v.string())
}));

export type EscrowAccountCreate = v.InferOutput<typeof escrowAccountCreateSchema>;
export type EscrowAccountUpdate = v.InferOutput<typeof escrowAccountUpdateSchema>;

// EscrowRelease Schemas (TR)
export const escrowReleaseCreateSchema = v.object({
  // No required fields
});

export const escrowReleaseUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type EscrowReleaseCreate = v.InferOutput<typeof escrowReleaseCreateSchema>;
export type EscrowReleaseUpdate = v.InferOutput<typeof escrowReleaseUpdateSchema>;

// EscrowDispute Schemas (TR)
export const escrowDisputeCreateSchema = v.object({
  // No required fields
});

export const escrowDisputeUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type EscrowDisputeCreate = v.InferOutput<typeof escrowDisputeCreateSchema>;
export type EscrowDisputeUpdate = v.InferOutput<typeof escrowDisputeUpdateSchema>;

// AIChatMessage Schemas (TR)
export const aIChatMessageCreateSchema = v.object({
  // No required fields
});

export const aIChatMessageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AIChatMessageCreate = v.InferOutput<typeof aIChatMessageCreateSchema>;
export type AIChatMessageUpdate = v.InferOutput<typeof aIChatMessageUpdateSchema>;

// AIChatHandoff Schemas (TR)
export const aIChatHandoffCreateSchema = v.object({
  // No required fields
});

export const aIChatHandoffUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AIChatHandoffCreate = v.InferOutput<typeof aIChatHandoffCreateSchema>;
export type AIChatHandoffUpdate = v.InferOutput<typeof aIChatHandoffUpdateSchema>;

// PaymentNegotiation Schemas (TR)
export const paymentNegotiationCreateSchema = v.object({
  // No required fields
});

export const paymentNegotiationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PaymentNegotiationCreate = v.InferOutput<typeof paymentNegotiationCreateSchema>;
export type PaymentNegotiationUpdate = v.InferOutput<typeof paymentNegotiationUpdateSchema>;

// NegotiationOffer Schemas (TR)
export const negotiationOfferCreateSchema = v.object({
  // No required fields
});

export const negotiationOfferUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type NegotiationOfferCreate = v.InferOutput<typeof negotiationOfferCreateSchema>;
export type NegotiationOfferUpdate = v.InferOutput<typeof negotiationOfferUpdateSchema>;

// PaymentInstallment Schemas (TR)
export const paymentInstallmentCreateSchema = v.object({
  // No required fields
});

export const paymentInstallmentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PaymentInstallmentCreate = v.InferOutput<typeof paymentInstallmentCreateSchema>;
export type PaymentInstallmentUpdate = v.InferOutput<typeof paymentInstallmentUpdateSchema>;

// VideoContent Schemas (TR)
export const videoContentCreateSchema = v.object({
  // No required fields
});

export const videoContentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VideoContentCreate = v.InferOutput<typeof videoContentCreateSchema>;
export type VideoContentUpdate = v.InferOutput<typeof videoContentUpdateSchema>;

// BrandAmbassador Schemas (TR)
export const brandAmbassadorCreateSchema = v.object({
  // No required fields
});

export const brandAmbassadorUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type BrandAmbassadorCreate = v.InferOutput<typeof brandAmbassadorCreateSchema>;
export type BrandAmbassadorUpdate = v.InferOutput<typeof brandAmbassadorUpdateSchema>;

// AmbassadorContract Schemas (TR)
export const ambassadorContractCreateSchema = v.object({
  // No required fields
});

export const ambassadorContractUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AmbassadorContractCreate = v.InferOutput<typeof ambassadorContractCreateSchema>;
export type AmbassadorContractUpdate = v.InferOutput<typeof ambassadorContractUpdateSchema>;

// AmbassadorCampaign Schemas (TR)
export const ambassadorCampaignCreateSchema = v.object({
  // No required fields
});

export const ambassadorCampaignUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AmbassadorCampaignCreate = v.InferOutput<typeof ambassadorCampaignCreateSchema>;
export type AmbassadorCampaignUpdate = v.InferOutput<typeof ambassadorCampaignUpdateSchema>;

// SocialImpactCounter Schemas (TR)
export const socialImpactCounterCreateSchema = v.object({
  // No required fields
});

export const socialImpactCounterUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialImpactCounterCreate = v.InferOutput<typeof socialImpactCounterCreateSchema>;
export type SocialImpactCounterUpdate = v.InferOutput<typeof socialImpactCounterUpdateSchema>;

// SocialImpactRecord Schemas (TR)
export const socialImpactRecordCreateSchema = v.object({
  // No required fields
});

export const socialImpactRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialImpactRecordCreate = v.InferOutput<typeof socialImpactRecordCreateSchema>;
export type SocialImpactRecordUpdate = v.InferOutput<typeof socialImpactRecordUpdateSchema>;

// SocialAccount Schemas (TR)
export const socialAccountCreateSchema = v.object({
  // No required fields
});

export const socialAccountUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAccountCreate = v.InferOutput<typeof socialAccountCreateSchema>;
export type SocialAccountUpdate = v.InferOutput<typeof socialAccountUpdateSchema>;

// SocialPost Schemas (TR)
export const socialPostCreateSchema = v.object({
  // No required fields
});

export const socialPostUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialPostCreate = v.InferOutput<typeof socialPostCreateSchema>;
export type SocialPostUpdate = v.InferOutput<typeof socialPostUpdateSchema>;

// SocialAIContent Schemas (TR)
export const socialAIContentCreateSchema = v.object({
  // No required fields
});

export const socialAIContentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAIContentCreate = v.InferOutput<typeof socialAIContentCreateSchema>;
export type SocialAIContentUpdate = v.InferOutput<typeof socialAIContentUpdateSchema>;

// SocialInboundMessage Schemas (TR)
export const socialInboundMessageCreateSchema = v.object({
  // No required fields
});

export const socialInboundMessageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialInboundMessageCreate = v.InferOutput<typeof socialInboundMessageCreateSchema>;
export type SocialInboundMessageUpdate = v.InferOutput<typeof socialInboundMessageUpdateSchema>;

// SocialCommentReply Schemas (TR)
export const socialCommentReplyCreateSchema = v.object({
  // No required fields
});

export const socialCommentReplyUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialCommentReplyCreate = v.InferOutput<typeof socialCommentReplyCreateSchema>;
export type SocialCommentReplyUpdate = v.InferOutput<typeof socialCommentReplyUpdateSchema>;

// SocialAutomationRule Schemas (TR)
export const socialAutomationRuleCreateSchema = v.object({
  // No required fields
});

export const socialAutomationRuleUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAutomationRuleCreate = v.InferOutput<typeof socialAutomationRuleCreateSchema>;
export type SocialAutomationRuleUpdate = v.InferOutput<typeof socialAutomationRuleUpdateSchema>;

// SocialAccountMetric Schemas (TR)
export const socialAccountMetricCreateSchema = v.object({
  // No required fields
});

export const socialAccountMetricUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAccountMetricCreate = v.InferOutput<typeof socialAccountMetricCreateSchema>;
export type SocialAccountMetricUpdate = v.InferOutput<typeof socialAccountMetricUpdateSchema>;

// EscrowStatusHistory Schemas (TR)
export const escrowStatusHistoryCreateSchema = v.object({
  // No required fields
});

export const escrowStatusHistoryUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type EscrowStatusHistoryCreate = v.InferOutput<typeof escrowStatusHistoryCreateSchema>;
export type EscrowStatusHistoryUpdate = v.InferOutput<typeof escrowStatusHistoryUpdateSchema>;

// Account Schemas (TR)
export const accountCreateSchema = v.object({
  // No required fields
});

export const accountUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AccountCreate = v.InferOutput<typeof accountCreateSchema>;
export type AccountUpdate = v.InferOutput<typeof accountUpdateSchema>;

// Agency Schemas (TR)
export const agencyCreateSchema = v.object({
  // No required fields
});

export const agencyUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgencyCreate = v.InferOutput<typeof agencyCreateSchema>;
export type AgencyUpdate = v.InferOutput<typeof agencyUpdateSchema>;

// Agent Schemas (TR)
export const agentCreateSchema = v.object({
  // No required fields
});

export const agentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgentCreate = v.InferOutput<typeof agentCreateSchema>;
export type AgentUpdate = v.InferOutput<typeof agentUpdateSchema>;

// Analytics Schemas (TR)
export const analyticsCreateSchema = v.object({
  // No required fields
});

export const analyticsUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AnalyticsCreate = v.InferOutput<typeof analyticsCreateSchema>;
export type AnalyticsUpdate = v.InferOutput<typeof analyticsUpdateSchema>;

// AutomationTask Schemas (TR)
export const automationTaskCreateSchema = v.object({
  // No required fields
});

export const automationTaskUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AutomationTaskCreate = v.InferOutput<typeof automationTaskCreateSchema>;
export type AutomationTaskUpdate = v.InferOutput<typeof automationTaskUpdateSchema>;

// Availability Schemas (TR)
export const availabilityCreateSchema = v.object({
  // No required fields
});

export const availabilityUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AvailabilityCreate = v.InferOutput<typeof availabilityCreateSchema>;
export type AvailabilityUpdate = v.InferOutput<typeof availabilityUpdateSchema>;

// Channel Schemas (TR)
export const channelCreateSchema = v.object({
  // No required fields
});

export const channelUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ChannelCreate = v.InferOutput<typeof channelCreateSchema>;
export type ChannelUpdate = v.InferOutput<typeof channelUpdateSchema>;

// CommissionRule Schemas (TR)
export const commissionRuleCreateSchema = v.object({
  // No required fields
});

export const commissionRuleUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type CommissionRuleCreate = v.InferOutput<typeof commissionRuleCreateSchema>;
export type CommissionRuleUpdate = v.InferOutput<typeof commissionRuleUpdateSchema>;

// CommunicationLog Schemas (TR)
export const communicationLogCreateSchema = v.object({
  // No required fields
});

export const communicationLogUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type CommunicationLogCreate = v.InferOutput<typeof communicationLogCreateSchema>;
export type CommunicationLogUpdate = v.InferOutput<typeof communicationLogUpdateSchema>;

// ComplianceRecord Schemas (TR)
export const complianceRecordCreateSchema = v.object({
  // No required fields
});

export const complianceRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ComplianceRecordCreate = v.InferOutput<typeof complianceRecordCreateSchema>;
export type ComplianceRecordUpdate = v.InferOutput<typeof complianceRecordUpdateSchema>;

// Currency Schemas (TR)
export const currencyCreateSchema = v.object({
  // No required fields
});

export const currencyUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type CurrencyCreate = v.InferOutput<typeof currencyCreateSchema>;
export type CurrencyUpdate = v.InferOutput<typeof currencyUpdateSchema>;

// Discount Schemas (TR)
export const discountCreateSchema = v.object({
  // No required fields
});

export const discountUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type DiscountCreate = v.InferOutput<typeof discountCreateSchema>;
export type DiscountUpdate = v.InferOutput<typeof discountUpdateSchema>;

// Expense Schemas (TR)
export const expenseCreateSchema = v.object({
  // No required fields
});

export const expenseUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ExpenseCreate = v.InferOutput<typeof expenseCreateSchema>;
export type ExpenseUpdate = v.InferOutput<typeof expenseUpdateSchema>;

// ExtraCharge Schemas (TR)
export const extraChargeCreateSchema = v.object({
  // No required fields
});

export const extraChargeUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ExtraChargeCreate = v.InferOutput<typeof extraChargeCreateSchema>;
export type ExtraChargeUpdate = v.InferOutput<typeof extraChargeUpdateSchema>;

// FacilityBlock Schemas (TR)
export const facilityBlockCreateSchema = v.object({
  // No required fields
});

export const facilityBlockUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type FacilityBlockCreate = v.InferOutput<typeof facilityBlockCreateSchema>;
export type FacilityBlockUpdate = v.InferOutput<typeof facilityBlockUpdateSchema>;

// Favorite Schemas (TR)
export const favoriteCreateSchema = v.object({
  // No required fields
});

export const favoriteUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type FavoriteCreate = v.InferOutput<typeof favoriteCreateSchema>;
export type FavoriteUpdate = v.InferOutput<typeof favoriteUpdateSchema>;

// Guest Schemas (TR)
export const guestCreateSchema = v.object({
  // No required fields
});

export const guestUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type GuestCreate = v.InferOutput<typeof guestCreateSchema>;
export type GuestUpdate = v.InferOutput<typeof guestUpdateSchema>;

// Hashtag Schemas (TR)
export const hashtagCreateSchema = v.object({
  // No required fields
});

export const hashtagUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type HashtagCreate = v.InferOutput<typeof hashtagCreateSchema>;
export type HashtagUpdate = v.InferOutput<typeof hashtagUpdateSchema>;

// IncludedService Schemas (TR)
export const includedServiceCreateSchema = v.object({
  // No required fields
});

export const includedServiceUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type IncludedServiceCreate = v.InferOutput<typeof includedServiceCreateSchema>;
export type IncludedServiceUpdate = v.InferOutput<typeof includedServiceUpdateSchema>;

// Increase Schemas (TR)
export const increaseCreateSchema = v.object({
  // No required fields
});

export const increaseUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type IncreaseCreate = v.InferOutput<typeof increaseCreateSchema>;
export type IncreaseUpdate = v.InferOutput<typeof increaseUpdateSchema>;

// Language Schemas (TR)
export const languageCreateSchema = v.object({
  // No required fields
});

export const languageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type LanguageCreate = v.InferOutput<typeof languageCreateSchema>;
export type LanguageUpdate = v.InferOutput<typeof languageUpdateSchema>;

// MLConfiguration Schemas (TR)
export const mLConfigurationCreateSchema = v.object({
  // No required fields
});

export const mLConfigurationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MLConfigurationCreate = v.InferOutput<typeof mLConfigurationCreateSchema>;
export type MLConfigurationUpdate = v.InferOutput<typeof mLConfigurationUpdateSchema>;

// MLModel Schemas (TR)
export const mLModelCreateSchema = v.object({
  // No required fields
});

export const mLModelUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MLModelCreate = v.InferOutput<typeof mLModelCreateSchema>;
export type MLModelUpdate = v.InferOutput<typeof mLModelUpdateSchema>;

// MapData Schemas (TR)
export const mapDataCreateSchema = v.object({
  // No required fields
});

export const mapDataUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MapDataCreate = v.InferOutput<typeof mapDataCreateSchema>;
export type MapDataUpdate = v.InferOutput<typeof mapDataUpdateSchema>;

// Mention Schemas (TR)
export const mentionCreateSchema = v.object({
  // No required fields
});

export const mentionUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MentionCreate = v.InferOutput<typeof mentionCreateSchema>;
export type MentionUpdate = v.InferOutput<typeof mentionUpdateSchema>;

// Mortgage Schemas (TR)
export const mortgageCreateSchema = v.object({
  // No required fields
});

export const mortgageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MortgageCreate = v.InferOutput<typeof mortgageCreateSchema>;
export type MortgageUpdate = v.InferOutput<typeof mortgageUpdateSchema>;

// Offer Schemas (TR)
export const offerCreateSchema = v.object({
  // No required fields
});

export const offerUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type OfferCreate = v.InferOutput<typeof offerCreateSchema>;
export type OfferUpdate = v.InferOutput<typeof offerUpdateSchema>;

// Payment Schemas (TR)
export const paymentCreateSchema = v.object({
  // No required fields
});

export const paymentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PaymentCreate = v.InferOutput<typeof paymentCreateSchema>;
export type PaymentUpdate = v.InferOutput<typeof paymentUpdateSchema>;

// Photo Schemas (TR)
export const photoCreateSchema = v.object({
  // No required fields
});

export const photoUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PhotoCreate = v.InferOutput<typeof photoCreateSchema>;
export type PhotoUpdate = v.InferOutput<typeof photoUpdateSchema>;

// Post Schemas (TR)
export const postCreateSchema = v.object({
  // No required fields
});

export const postUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PostCreate = v.InferOutput<typeof postCreateSchema>;
export type PostUpdate = v.InferOutput<typeof postUpdateSchema>;

// PricingRule Schemas (TR)
export const pricingRuleCreateSchema = v.object({
  // No required fields
});

export const pricingRuleUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PricingRuleCreate = v.InferOutput<typeof pricingRuleCreateSchema>;
export type PricingRuleUpdate = v.InferOutput<typeof pricingRuleUpdateSchema>;

// ProjectAlert Schemas (TR)
export const projectAlertCreateSchema = v.object({
  // No required fields
});

export const projectAlertUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ProjectAlertCreate = v.InferOutput<typeof projectAlertCreateSchema>;
export type ProjectAlertUpdate = v.InferOutput<typeof projectAlertUpdateSchema>;

// ProjectAnalytics Schemas (TR)
export const projectAnalyticsCreateSchema = v.object({
  // No required fields
});

export const projectAnalyticsUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ProjectAnalyticsCreate = v.InferOutput<typeof projectAnalyticsCreateSchema>;
export type ProjectAnalyticsUpdate = v.InferOutput<typeof projectAnalyticsUpdateSchema>;

// ProjectReport Schemas (TR)
export const projectReportCreateSchema = v.object({
  // No required fields
});

export const projectReportUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ProjectReportCreate = v.InferOutput<typeof projectReportCreateSchema>;
export type ProjectReportUpdate = v.InferOutput<typeof projectReportUpdateSchema>;

// PropertyPromotion Schemas (TR)
export const propertyPromotionCreateSchema = v.object({
  // No required fields
});

export const propertyPromotionUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertyPromotionCreate = v.InferOutput<typeof propertyPromotionCreateSchema>;
export type PropertyPromotionUpdate = v.InferOutput<typeof propertyPromotionUpdateSchema>;

// ReferenceSource Schemas (TR)
export const referenceSourceCreateSchema = v.object({
  // No required fields
});

export const referenceSourceUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ReferenceSourceCreate = v.InferOutput<typeof referenceSourceCreateSchema>;
export type ReferenceSourceUpdate = v.InferOutput<typeof referenceSourceUpdateSchema>;

// ScrapingJob Schemas (TR)
export const scrapingJobCreateSchema = v.object({
  // No required fields
});

export const scrapingJobUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ScrapingJobCreate = v.InferOutput<typeof scrapingJobCreateSchema>;
export type ScrapingJobUpdate = v.InferOutput<typeof scrapingJobUpdateSchema>;

// SharedAmenity Schemas (TR)
export const sharedAmenityCreateSchema = v.object({
  // No required fields
});

export const sharedAmenityUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SharedAmenityCreate = v.InferOutput<typeof sharedAmenityCreateSchema>;
export type SharedAmenityUpdate = v.InferOutput<typeof sharedAmenityUpdateSchema>;

// Tenant Schemas (TR)
export const tenantCreateSchema = v.object({
  // No required fields
});

export const tenantUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TenantCreate = v.InferOutput<typeof tenantCreateSchema>;
export type TenantUpdate = v.InferOutput<typeof tenantUpdateSchema>;

// Ticket Schemas (TR)
export const ticketCreateSchema = v.object({
  // No required fields
});

export const ticketUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TicketCreate = v.InferOutput<typeof ticketCreateSchema>;
export type TicketUpdate = v.InferOutput<typeof ticketUpdateSchema>;

// Verification Schemas (TR)
export const verificationCreateSchema = v.object({
  // No required fields
});

export const verificationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VerificationCreate = v.InferOutput<typeof verificationCreateSchema>;
export type VerificationUpdate = v.InferOutput<typeof verificationUpdateSchema>;

// PropertyOwnershipVerification Schemas (TR)
export const propertyOwnershipVerificationCreateSchema = v.object({
  // No required fields
});

export const propertyOwnershipVerificationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertyOwnershipVerificationCreate = v.InferOutput<typeof propertyOwnershipVerificationCreateSchema>;
export type PropertyOwnershipVerificationUpdate = v.InferOutput<typeof propertyOwnershipVerificationUpdateSchema>;

// OwnershipVerificationDocument Schemas (TR)
export const ownershipVerificationDocumentCreateSchema = v.object({
  // No required fields
});

export const ownershipVerificationDocumentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type OwnershipVerificationDocumentCreate = v.InferOutput<typeof ownershipVerificationDocumentCreateSchema>;
export type OwnershipVerificationDocumentUpdate = v.InferOutput<typeof ownershipVerificationDocumentUpdateSchema>;

// PropertyOwnershipTransfer Schemas (TR)
export const propertyOwnershipTransferCreateSchema = v.object({
  // No required fields
});

export const propertyOwnershipTransferUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertyOwnershipTransferCreate = v.InferOutput<typeof propertyOwnershipTransferCreateSchema>;
export type PropertyOwnershipTransferUpdate = v.InferOutput<typeof propertyOwnershipTransferUpdateSchema>;

// BookingSecurityScreening Schemas (TR)
export const bookingSecurityScreeningCreateSchema = v.object({
  // No required fields
});

export const bookingSecurityScreeningUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type BookingSecurityScreeningCreate = v.InferOutput<typeof bookingSecurityScreeningCreateSchema>;
export type BookingSecurityScreeningUpdate = v.InferOutput<typeof bookingSecurityScreeningUpdateSchema>;

// VideoVendor Schemas (TR)
export const videoVendorCreateSchema = v.object({
  // No required fields
});

export const videoVendorUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VideoVendorCreate = v.InferOutput<typeof videoVendorCreateSchema>;
export type VideoVendorUpdate = v.InferOutput<typeof videoVendorUpdateSchema>;

// VideoVendorPartnership Schemas (TR)
export const videoVendorPartnershipCreateSchema = v.object({
  // No required fields
});

export const videoVendorPartnershipUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VideoVendorPartnershipCreate = v.InferOutput<typeof videoVendorPartnershipCreateSchema>;
export type VideoVendorPartnershipUpdate = v.InferOutput<typeof videoVendorPartnershipUpdateSchema>;

// AgentVideo Schemas (TR)
export const agentVideoCreateSchema = v.object({
  // No required fields
});

export const agentVideoUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgentVideoCreate = v.InferOutput<typeof agentVideoCreateSchema>;
export type AgentVideoUpdate = v.InferOutput<typeof agentVideoUpdateSchema>;

// AgentEarning Schemas (TR)
export const agentEarningCreateSchema = v.object({
  // No required fields
});

export const agentEarningUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AgentEarningCreate = v.InferOutput<typeof agentEarningCreateSchema>;
export type AgentEarningUpdate = v.InferOutput<typeof agentEarningUpdateSchema>;

// VendorEarning Schemas (TR)
export const vendorEarningCreateSchema = v.object({
  // No required fields
});

export const vendorEarningUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VendorEarningCreate = v.InferOutput<typeof vendorEarningCreateSchema>;
export type VendorEarningUpdate = v.InferOutput<typeof vendorEarningUpdateSchema>;

// PartnershipEarning Schemas (TR)
export const partnershipEarningCreateSchema = v.object({
  // No required fields
});

export const partnershipEarningUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PartnershipEarningCreate = v.InferOutput<typeof partnershipEarningCreateSchema>;
export type PartnershipEarningUpdate = v.InferOutput<typeof partnershipEarningUpdateSchema>;

// VideoQualityReview Schemas (TR)
export const videoQualityReviewCreateSchema = v.object({
  // No required fields
});

export const videoQualityReviewUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VideoQualityReviewCreate = v.InferOutput<typeof videoQualityReviewCreateSchema>;
export type VideoQualityReviewUpdate = v.InferOutput<typeof videoQualityReviewUpdateSchema>;

// VendorQualityReview Schemas (TR)
export const vendorQualityReviewCreateSchema = v.object({
  // No required fields
});

export const vendorQualityReviewUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VendorQualityReviewCreate = v.InferOutput<typeof vendorQualityReviewCreateSchema>;
export type VendorQualityReviewUpdate = v.InferOutput<typeof vendorQualityReviewUpdateSchema>;

// ValuationRequest Schemas (TR)
export const valuationRequestCreateSchema = v.object({
  // No required fields
});

export const valuationRequestUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ValuationRequestCreate = v.InferOutput<typeof valuationRequestCreateSchema>;
export type ValuationRequestUpdate = v.InferOutput<typeof valuationRequestUpdateSchema>;

// ValuationReport Schemas (TR)
export const valuationReportCreateSchema = v.object({
  // No required fields
});

export const valuationReportUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type ValuationReportCreate = v.InferOutput<typeof valuationReportCreateSchema>;
export type ValuationReportUpdate = v.InferOutput<typeof valuationReportUpdateSchema>;

// LeadConversion Schemas (TR)
export const leadConversionCreateSchema = v.object({
  // No required fields
});

export const leadConversionUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type LeadConversionCreate = v.InferOutput<typeof leadConversionCreateSchema>;
export type LeadConversionUpdate = v.InferOutput<typeof leadConversionUpdateSchema>;

// MarketInsight Schemas (TR)
export const marketInsightCreateSchema = v.object({
  // No required fields
});

export const marketInsightUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type MarketInsightCreate = v.InferOutput<typeof marketInsightCreateSchema>;
export type MarketInsightUpdate = v.InferOutput<typeof marketInsightUpdateSchema>;

// UserValuationPreference Schemas (TR)
export const userValuationPreferenceCreateSchema = v.object({
  // No required fields
});

export const userValuationPreferenceUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type UserValuationPreferenceCreate = v.InferOutput<typeof userValuationPreferenceCreateSchema>;
export type UserValuationPreferenceUpdate = v.InferOutput<typeof userValuationPreferenceUpdateSchema>;

// VideoEarning Schemas (TR)
export const videoEarningCreateSchema = v.object({
  // No required fields
});

export const videoEarningUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type VideoEarningCreate = v.InferOutput<typeof videoEarningCreateSchema>;
export type VideoEarningUpdate = v.InferOutput<typeof videoEarningUpdateSchema>;

// LegalCompliance Schemas (TR)
export const legalComplianceCreateSchema = v.object({
  propertyId: v.string(),
  region: v.enum_(Region)
});

export const legalComplianceUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  region: v.optional(v.enum_(Region)),
  licenseNumber: v.optional(v.string()),
  registrationDate: v.optional(v.string()),
  expiryDate: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  vettedBy: v.optional(v.string()),
  vettedAt: v.optional(v.string()),
  isPublic: v.optional(v.boolean()),
  verificationLevel: v.optional(v.number())
}));

export type LegalComplianceCreate = v.InferOutput<typeof legalComplianceCreateSchema>;
export type LegalComplianceUpdate = v.InferOutput<typeof legalComplianceUpdateSchema>;

// GlobalTaxRegulation Schemas (TR)
export const globalTaxRegulationCreateSchema = v.object({
  propertyId: v.string(),
  taxAuthority: v.string(),
  taxType: v.string(),
  taxRate: v.number()
});

export const globalTaxRegulationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  taxAuthority: v.optional(v.string()),
  taxType: v.optional(v.string()),
  taxRate: v.optional(v.number()),
  isAutomated: v.optional(v.boolean()),
  reportingInterval: v.optional(v.string()),
  lastReportedAt: v.optional(v.string()),
  config: v.optional(v.unknown())
}));

export type GlobalTaxRegulationCreate = v.InferOutput<typeof globalTaxRegulationCreateSchema>;
export type GlobalTaxRegulationUpdate = v.InferOutput<typeof globalTaxRegulationUpdateSchema>;

// SmartLock Schemas (TR)
export const smartLockCreateSchema = v.object({
  // No required fields
});

export const smartLockUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SmartLockCreate = v.InferOutput<typeof smartLockCreateSchema>;
export type SmartLockUpdate = v.InferOutput<typeof smartLockUpdateSchema>;

// AccessCode Schemas (TR)
export const accessCodeCreateSchema = v.object({
  // No required fields
});

export const accessCodeUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AccessCodeCreate = v.InferOutput<typeof accessCodeCreateSchema>;
export type AccessCodeUpdate = v.InferOutput<typeof accessCodeUpdateSchema>;

// AccessLog Schemas (TR)
export const accessLogCreateSchema = v.object({
  // No required fields
});

export const accessLogUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type AccessLogCreate = v.InferOutput<typeof accessLogCreateSchema>;
export type AccessLogUpdate = v.InferOutput<typeof accessLogUpdateSchema>;

// StayOccupant Schemas (TR)
export const stayOccupantCreateSchema = v.object({
  // No required fields
});

export const stayOccupantUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type StayOccupantCreate = v.InferOutput<typeof stayOccupantCreateSchema>;
export type StayOccupantUpdate = v.InferOutput<typeof stayOccupantUpdateSchema>;

// PoliceReport Schemas (TR)
export const policeReportCreateSchema = v.object({
  // No required fields
});

export const policeReportUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PoliceReportCreate = v.InferOutput<typeof policeReportCreateSchema>;
export type PoliceReportUpdate = v.InferOutput<typeof policeReportUpdateSchema>;

// IdentityDocument Schemas (TR)
export const identityDocumentCreateSchema = v.object({
  // No required fields
});

export const identityDocumentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type IdentityDocumentCreate = v.InferOutput<typeof identityDocumentCreateSchema>;
export type IdentityDocumentUpdate = v.InferOutput<typeof identityDocumentUpdateSchema>;

// MarketRateComparison Schemas (TR)
export const marketRateComparisonCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  sourceName: v.string(),
  competitorPrice: v.number(),
  ourPrice: v.number(),
  priceDifference: v.number()
});

export const marketRateComparisonUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  listingType: v.optional(v.enum_(ListingType)),
  sourceName: v.optional(v.string()),
  externalUrl: v.optional(v.string()),
  competitorPrice: v.optional(v.number()),
  competitorCurrency: v.optional(v.string()),
  ourPrice: v.optional(v.number()),
  priceDifference: v.optional(v.number()),
  savingsPercentage: v.optional(v.number()),
  lastCheckedAt: v.optional(v.string()),
  status: v.optional(v.string())
}));

export type MarketRateComparisonCreate = v.InferOutput<typeof marketRateComparisonCreateSchema>;
export type MarketRateComparisonUpdate = v.InferOutput<typeof marketRateComparisonUpdateSchema>;

// FeatureAddOn Schemas (TR)
export const featureAddOnCreateSchema = v.object({
  orgId: v.string(),
  type: v.enum_(AddOnType),
  priceAmount: v.number()
});

export const featureAddOnUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  type: v.optional(v.enum_(AddOnType)),
  status: v.optional(v.enum_(AddOnStatus)),
  priceAmount: v.optional(v.number()),
  billingCycle: v.optional(v.string()),
  usageLimit: v.optional(v.number()),
  usageCount: v.optional(v.number()),
  expiresAt: v.optional(v.string())
}));

export type FeatureAddOnCreate = v.InferOutput<typeof featureAddOnCreateSchema>;
export type FeatureAddOnUpdate = v.InferOutput<typeof featureAddOnUpdateSchema>;

// PlatformRevenueRecord Schemas (TR)
export const platformRevenueRecordCreateSchema = v.object({
  orgId: v.string(),
  sourceType: v.enum_(RevenueSource),
  amount: v.number()
});

export const platformRevenueRecordUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  sourceType: v.optional(v.enum_(RevenueSource)),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.string()),
  entityId: v.optional(v.string()),
  metadata: v.optional(v.unknown())
}));

export type PlatformRevenueRecordCreate = v.InferOutput<typeof platformRevenueRecordCreateSchema>;
export type PlatformRevenueRecordUpdate = v.InferOutput<typeof platformRevenueRecordUpdateSchema>;

// AiServiceTask Schemas (TR)
export const aiServiceTaskCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  taskType: v.enum_(AiTaskType)
});

export const aiServiceTaskUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  taskType: v.optional(v.enum_(AiTaskType)),
  status: v.optional(v.enum_(AiTaskStatus)),
  inputData: v.optional(v.unknown()),
  outputData: v.optional(v.unknown()),
  externalJobId: v.optional(v.string()),
  errorMessage: v.optional(v.string()),
  progress: v.optional(v.number()),
  priority: v.optional(v.number())
}));

export type AiServiceTaskCreate = v.InferOutput<typeof aiServiceTaskCreateSchema>;
export type AiServiceTaskUpdate = v.InferOutput<typeof aiServiceTaskUpdateSchema>;

// AiVideoGeneration Schemas (TR)
export const aiVideoGenerationCreateSchema = v.object({
  propertyId: v.string(),
  sourcePhotos: v.string()
});

export const aiVideoGenerationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  sourcePhotos: v.optional(v.string()),
  status: v.optional(v.string()),
  videoUrl: v.optional(v.string()),
  musicTrack: v.optional(v.string()),
  languageVariant: v.optional(v.string())
}));

export type AiVideoGenerationCreate = v.InferOutput<typeof aiVideoGenerationCreateSchema>;
export type AiVideoGenerationUpdate = v.InferOutput<typeof aiVideoGenerationUpdateSchema>;

// VideoCaption Schemas (TR)
export const videoCaptionCreateSchema = v.object({
  videoId: v.string(),
  languageCode: v.string(),
  content: v.unknown()
});

export const videoCaptionUpdateSchema = v.partial(v.object({
  videoId: v.optional(v.string()),
  languageCode: v.optional(v.string()),
  content: v.optional(v.unknown()),
  isActive: v.optional(v.boolean())
}));

export type VideoCaptionCreate = v.InferOutput<typeof videoCaptionCreateSchema>;
export type VideoCaptionUpdate = v.InferOutput<typeof videoCaptionUpdateSchema>;

// AiBrochureGeneration Schemas (TR)
export const aiBrochureGenerationCreateSchema = v.object({
  propertyId: v.string()
});

export const aiBrochureGenerationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  templateId: v.optional(v.string()),
  languageVariant: v.optional(v.string()),
  pdfUrl: v.optional(v.string()),
  status: v.optional(v.string())
}));

export type AiBrochureGenerationCreate = v.InferOutput<typeof aiBrochureGenerationCreateSchema>;
export type AiBrochureGenerationUpdate = v.InferOutput<typeof aiBrochureGenerationUpdateSchema>;

// AiExtractedData Schemas (TR)
export const aiExtractedDataCreateSchema = v.object({
  propertyId: v.string(),
  sourceType: v.string(),
  extractedValues: v.unknown()
});

export const aiExtractedDataUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  sourceType: v.optional(v.string()),
  extractedValues: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  verifiedBy: v.optional(v.string())
}));

export type AiExtractedDataCreate = v.InferOutput<typeof aiExtractedDataCreateSchema>;
export type AiExtractedDataUpdate = v.InferOutput<typeof aiExtractedDataUpdateSchema>;

// Category Schemas (TR)
export const categoryCreateSchema = v.object({
  slug: v.string()
});

export const categoryUpdateSchema = v.partial(v.object({
  parentId: v.optional(v.string()),
  slug: v.optional(v.string()),
  icon: v.optional(v.string()),
  imageUrl: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  order: v.optional(v.number())
}));

export type CategoryCreate = v.InferOutput<typeof categoryCreateSchema>;
export type CategoryUpdate = v.InferOutput<typeof categoryUpdateSchema>;

// CategoryTranslation Schemas (TR)
export const categoryTranslationCreateSchema = v.object({
  categoryId: v.string(),
  languageCode: v.string(),
  name: v.string()
});

export const categoryTranslationUpdateSchema = v.partial(v.object({
  categoryId: v.optional(v.string()),
  languageCode: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string())
}));

export type CategoryTranslationCreate = v.InferOutput<typeof categoryTranslationCreateSchema>;
export type CategoryTranslationUpdate = v.InferOutput<typeof categoryTranslationUpdateSchema>;

// USPublicTaxRecord Schemas (TR)
export const uSPublicTaxRecordCreateSchema = v.object({
  // No required fields
});

export const uSPublicTaxRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type USPublicTaxRecordCreate = v.InferOutput<typeof uSPublicTaxRecordCreateSchema>;
export type USPublicTaxRecordUpdate = v.InferOutput<typeof uSPublicTaxRecordUpdateSchema>;

// USPropertyAssessment Schemas (TR)
export const uSPropertyAssessmentCreateSchema = v.object({
  // No required fields
});

export const uSPropertyAssessmentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type USPropertyAssessmentCreate = v.InferOutput<typeof uSPropertyAssessmentCreateSchema>;
export type USPropertyAssessmentUpdate = v.InferOutput<typeof uSPropertyAssessmentUpdateSchema>;

// UKPropertyCertificateRecord Schemas (TR)
export const uKPropertyCertificateRecordCreateSchema = v.object({
  // No required fields
});

export const uKPropertyCertificateRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type UKPropertyCertificateRecordCreate = v.InferOutput<typeof uKPropertyCertificateRecordCreateSchema>;
export type UKPropertyCertificateRecordUpdate = v.InferOutput<typeof uKPropertyCertificateRecordUpdateSchema>;

// TRPropertyDocumentRecord Schemas (TR)
export const tRPropertyDocumentRecordCreateSchema = v.object({
  // No required fields
});

export const tRPropertyDocumentRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TRPropertyDocumentRecordCreate = v.InferOutput<typeof tRPropertyDocumentRecordCreateSchema>;
export type TRPropertyDocumentRecordUpdate = v.InferOutput<typeof tRPropertyDocumentRecordUpdateSchema>;

// TRTaxDeclaration Schemas (TR)
export const tRTaxDeclarationCreateSchema = v.object({
  // No required fields
});

export const tRTaxDeclarationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TRTaxDeclarationCreate = v.InferOutput<typeof tRTaxDeclarationCreateSchema>;
export type TRTaxDeclarationUpdate = v.InferOutput<typeof tRTaxDeclarationUpdateSchema>;

// VrpMandate Schemas (TR)
export const vrpMandateCreateSchema = v.object({
  // No required fields
});

export const vrpMandateUpdateSchema = v.partial(v.object({
  bookingId: v.optional(v.string()),
  reservationId: v.optional(v.string())
}));

export type VrpMandateCreate = v.InferOutput<typeof vrpMandateCreateSchema>;
export type VrpMandateUpdate = v.InferOutput<typeof vrpMandateUpdateSchema>;

// IotAccessLog Schemas (TR)
export const iotAccessLogCreateSchema = v.object({
  // No required fields
});

export const iotAccessLogUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type IotAccessLogCreate = v.InferOutput<typeof iotAccessLogCreateSchema>;
export type IotAccessLogUpdate = v.InferOutput<typeof iotAccessLogUpdateSchema>;

// GuestVerification Schemas (TR)
export const guestVerificationCreateSchema = v.object({
  // No required fields
});

export const guestVerificationUpdateSchema = v.partial(v.object({
  organizationId: v.optional(v.string())
}));

export type GuestVerificationCreate = v.InferOutput<typeof guestVerificationCreateSchema>;
export type GuestVerificationUpdate = v.InferOutput<typeof guestVerificationUpdateSchema>;

// TenantVerificationStage Schemas (TR)
export const tenantVerificationStageCreateSchema = v.object({
  // No required fields
});

export const tenantVerificationStageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TenantVerificationStageCreate = v.InferOutput<typeof tenantVerificationStageCreateSchema>;
export type TenantVerificationStageUpdate = v.InferOutput<typeof tenantVerificationStageUpdateSchema>;

// SecurityIncident Schemas (TR)
export const securityIncidentCreateSchema = v.object({
  // No required fields
});

export const securityIncidentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SecurityIncidentCreate = v.InferOutput<typeof securityIncidentCreateSchema>;
export type SecurityIncidentUpdate = v.InferOutput<typeof securityIncidentUpdateSchema>;

// OperatorLicense Schemas (TR)
export const operatorLicenseCreateSchema = v.object({
  // No required fields
});

export const operatorLicenseUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type OperatorLicenseCreate = v.InferOutput<typeof operatorLicenseCreateSchema>;
export type OperatorLicenseUpdate = v.InferOutput<typeof operatorLicenseUpdateSchema>;

// TenantReliabilityScore Schemas (TR)
export const tenantReliabilityScoreCreateSchema = v.object({
  // No required fields
});

export const tenantReliabilityScoreUpdateSchema = v.partial(v.object({
  organizationId: v.optional(v.string())
}));

export type TenantReliabilityScoreCreate = v.InferOutput<typeof tenantReliabilityScoreCreateSchema>;
export type TenantReliabilityScoreUpdate = v.InferOutput<typeof tenantReliabilityScoreUpdateSchema>;

// PropertySecurityConfig Schemas (TR)
export const propertySecurityConfigCreateSchema = v.object({
  // No required fields
});

export const propertySecurityConfigUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertySecurityConfigCreate = v.InferOutput<typeof propertySecurityConfigCreateSchema>;
export type PropertySecurityConfigUpdate = v.InferOutput<typeof propertySecurityConfigUpdateSchema>;

// AgentEscrowWallet Schemas (TR)
export const agentEscrowWalletCreateSchema = v.object({
  agentId: v.string()
});

export const agentEscrowWalletUpdateSchema = v.partial(v.object({
  agentId: v.optional(v.string()),
  balance: v.optional(v.number()),
  pendingBalance: v.optional(v.number()),
  paidBalance: v.optional(v.number()),
  currency: v.optional(v.string())
}));

export type AgentEscrowWalletCreate = v.InferOutput<typeof agentEscrowWalletCreateSchema>;
export type AgentEscrowWalletUpdate = v.InferOutput<typeof agentEscrowWalletUpdateSchema>;

// AgentEscrowTransaction Schemas (TR)
export const agentEscrowTransactionCreateSchema = v.object({
  walletId: v.string(),
  amount: v.number()
});

export const agentEscrowTransactionUpdateSchema = v.partial(v.object({
  walletId: v.optional(v.string()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  type: v.optional(v.enum_(AgentEscrowTxType)),
  status: v.optional(v.enum_(AgentEscrowTxStatus)),
  escrowAccountId: v.optional(v.string()),
  releaseDate: v.optional(v.string()),
  reference: v.optional(v.string())
}));

export type AgentEscrowTransactionCreate = v.InferOutput<typeof agentEscrowTransactionCreateSchema>;
export type AgentEscrowTransactionUpdate = v.InferOutput<typeof agentEscrowTransactionUpdateSchema>;

// EscrowSplitConfig Schemas (TR)
export const escrowSplitConfigCreateSchema = v.object({
  propertyId: v.string(),
  agentId: v.string()
});

export const escrowSplitConfigUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  agentPayoutRate: v.optional(v.number()),
  reservatiorFeeRate: v.optional(v.number()),
  blockageDays: v.optional(v.number()),
  isActive: v.optional(v.boolean())
}));

export type EscrowSplitConfigCreate = v.InferOutput<typeof escrowSplitConfigCreateSchema>;
export type EscrowSplitConfigUpdate = v.InferOutput<typeof escrowSplitConfigUpdateSchema>;

// Hotel Schemas (TR)
export const hotelCreateSchema = v.object({
  name: v.string(),
  photos: v.string(),
  amenities: v.string()
});

export const hotelUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  address: v.optional(v.string()),
  city: v.optional(v.string()),
  country: v.optional(v.string()),
  lat: v.optional(v.number()),
  lng: v.optional(v.number()),
  rating: v.optional(v.number()),
  starRating: v.optional(v.number()),
  photos: v.optional(v.string()),
  amenities: v.optional(v.string()),
  currency: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type HotelCreate = v.InferOutput<typeof hotelCreateSchema>;
export type HotelUpdate = v.InferOutput<typeof hotelUpdateSchema>;

// HotelProviderMapping Schemas (TR)
export const hotelProviderMappingCreateSchema = v.object({
  hotelId: v.string(),
  provider: v.enum_(HotelProvider),
  providerHotelId: v.string()
});

export const hotelProviderMappingUpdateSchema = v.partial(v.object({
  hotelId: v.optional(v.string()),
  provider: v.optional(v.enum_(HotelProvider)),
  providerHotelId: v.optional(v.string()),
  providerData: v.optional(v.unknown()),
  isPrimary: v.optional(v.boolean())
}));

export type HotelProviderMappingCreate = v.InferOutput<typeof hotelProviderMappingCreateSchema>;
export type HotelProviderMappingUpdate = v.InferOutput<typeof hotelProviderMappingUpdateSchema>;

// HotelRoomType Schemas (TR)
export const hotelRoomTypeCreateSchema = v.object({
  hotelId: v.string(),
  name: v.string(),
  amenities: v.string(),
  photos: v.string()
});

export const hotelRoomTypeUpdateSchema = v.partial(v.object({
  hotelId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  maxGuests: v.optional(v.number()),
  bedType: v.optional(v.string()),
  amenities: v.optional(v.string()),
  photos: v.optional(v.string())
}));

export type HotelRoomTypeCreate = v.InferOutput<typeof hotelRoomTypeCreateSchema>;
export type HotelRoomTypeUpdate = v.InferOutput<typeof hotelRoomTypeUpdateSchema>;

// HotelRatePlan Schemas (TR)
export const hotelRatePlanCreateSchema = v.object({
  roomTypeId: v.string(),
  provider: v.enum_(HotelProvider),
  netPrice: v.number(),
  grossPrice: v.number()
});

export const hotelRatePlanUpdateSchema = v.partial(v.object({
  roomTypeId: v.optional(v.string()),
  provider: v.optional(v.enum_(HotelProvider)),
  providerRateId: v.optional(v.string()),
  name: v.optional(v.string()),
  boardType: v.optional(v.string()),
  netPrice: v.optional(v.number()),
  grossPrice: v.optional(v.number()),
  currency: v.optional(v.string()),
  cancellationPolicy: v.optional(v.string()),
  isRefundable: v.optional(v.boolean()),
  validFrom: v.optional(v.string()),
  validTo: v.optional(v.string())
}));

export type HotelRatePlanCreate = v.InferOutput<typeof hotelRatePlanCreateSchema>;
export type HotelRatePlanUpdate = v.InferOutput<typeof hotelRatePlanUpdateSchema>;

// HotelSearchCache Schemas (TR)
export const hotelSearchCacheCreateSchema = v.object({
  hotelId: v.string(),
  destination: v.string(),
  checkIn: v.string(),
  checkOut: v.string(),
  provider: v.enum_(HotelProvider),
  expiresAt: v.string()
});

export const hotelSearchCacheUpdateSchema = v.partial(v.object({
  hotelId: v.optional(v.string()),
  destination: v.optional(v.string()),
  checkIn: v.optional(v.string()),
  checkOut: v.optional(v.string()),
  guests: v.optional(v.number()),
  provider: v.optional(v.enum_(HotelProvider)),
  rawResponse: v.optional(v.unknown()),
  netPrice: v.optional(v.number()),
  grossPrice: v.optional(v.number()),
  cachedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string())
}));

export type HotelSearchCacheCreate = v.InferOutput<typeof hotelSearchCacheCreateSchema>;
export type HotelSearchCacheUpdate = v.InferOutput<typeof hotelSearchCacheUpdateSchema>;

// HostPenalty Schemas (TR)
export const hostPenaltyCreateSchema = v.object({
  orgId: v.string(),
  reservationId: v.string(),
  penaltyAmount: v.number()
});

export const hostPenaltyUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  penaltyAmount: v.optional(v.number()),
  relocationCost: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(PenaltyStatus)),
  deductedFromEscrowId: v.optional(v.string()),
  notes: v.optional(v.string())
}));

export type HostPenaltyCreate = v.InferOutput<typeof hostPenaltyCreateSchema>;
export type HostPenaltyUpdate = v.InferOutput<typeof hostPenaltyUpdateSchema>;

// IncomingWebhook Schemas (TR)
export const incomingWebhookCreateSchema = v.object({
  provider: v.string(),
  eventId: v.string()
});

export const incomingWebhookUpdateSchema = v.partial(v.object({
  provider: v.optional(v.string()),
  eventId: v.optional(v.string()),
  payload: v.optional(v.unknown()),
  status: v.optional(v.string()),
  processedAt: v.optional(v.string())
}));

export type IncomingWebhookCreate = v.InferOutput<typeof incomingWebhookCreateSchema>;
export type IncomingWebhookUpdate = v.InferOutput<typeof incomingWebhookUpdateSchema>;

// KbsReportLog Schemas (TR)
export const kbsReportLogCreateSchema = v.object({
  orgId: v.string(),
  reservationId: v.string(),
  guestName: v.string(),
  documentNumber: v.string()
});

export const kbsReportLogUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  guestName: v.optional(v.string()),
  documentNumber: v.optional(v.string()),
  status: v.optional(v.enum_(KbsStatus)),
  responseCode: v.optional(v.string()),
  errorMessage: v.optional(v.string()),
  submittedAt: v.optional(v.string())
}));

export type KbsReportLogCreate = v.InferOutput<typeof kbsReportLogCreateSchema>;
export type KbsReportLogUpdate = v.InferOutput<typeof kbsReportLogUpdateSchema>;

// PropertyTrustScore Schemas (TR)
export const propertyTrustScoreCreateSchema = v.object({
  propertyId: v.string(),
  orgId: v.string(),
  overallScore: v.number()
});

export const propertyTrustScoreUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  overallScore: v.optional(v.number()),
  kycVerified: v.optional(v.boolean()),
  reviewScore: v.optional(v.number()),
  cancellationRate: v.optional(v.number()),
  disputeRate: v.optional(v.number()),
  isSuspended: v.optional(v.boolean()),
  lastCalculated: v.optional(v.string()),
  signals: v.optional(v.unknown())
}));

export type PropertyTrustScoreCreate = v.InferOutput<typeof propertyTrustScoreCreateSchema>;
export type PropertyTrustScoreUpdate = v.InferOutput<typeof propertyTrustScoreUpdateSchema>;

// AIFeedbackLoop Schemas (TR)
export const aIFeedbackLoopCreateSchema = v.object({
  orgId: v.string(),
  actionType: v.string(),
  entityId: v.string(),
  outcomeScore: v.number()
});

export const aIFeedbackLoopUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  actionType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  originalDecision: v.optional(v.unknown()),
  outcomeScore: v.optional(v.number()),
  outcomeReason: v.optional(v.string()),
  processedAt: v.optional(v.string())
}));

export type AIFeedbackLoopCreate = v.InferOutput<typeof aIFeedbackLoopCreateSchema>;
export type AIFeedbackLoopUpdate = v.InferOutput<typeof aIFeedbackLoopUpdateSchema>;

// PaymentRoutingLog Schemas (TR)
export const paymentRoutingLogCreateSchema = v.object({
  amount: v.number(),
  currency: v.string(),
  selectedProvider: v.string()
});

export const paymentRoutingLogUpdateSchema = v.partial(v.object({
  reservationId: v.optional(v.string()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  selectedProvider: v.optional(v.string()),
  routingReason: v.optional(v.string()),
  isSuccess: v.optional(v.boolean()),
  latencyMs: v.optional(v.number()),
  bookingId: v.optional(v.string())
}));

export type PaymentRoutingLogCreate = v.InferOutput<typeof paymentRoutingLogCreateSchema>;
export type PaymentRoutingLogUpdate = v.InferOutput<typeof paymentRoutingLogUpdateSchema>;

// BookingFailoverEvent Schemas (TR)
export const bookingFailoverEventCreateSchema = v.object({
  originalReservationId: v.string(),
  orgId: v.string(),
  reason: v.string()
});

export const bookingFailoverEventUpdateSchema = v.partial(v.object({
  originalReservationId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  reason: v.optional(v.string()),
  aiAlternatives: v.optional(v.unknown()),
  selectedAlternativeId: v.optional(v.string()),
  status: v.optional(v.string()),
  resolvedAt: v.optional(v.string())
}));

export type BookingFailoverEventCreate = v.InferOutput<typeof bookingFailoverEventCreateSchema>;
export type BookingFailoverEventUpdate = v.InferOutput<typeof bookingFailoverEventUpdateSchema>;

