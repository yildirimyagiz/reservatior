// Otomatik üretilmiş Valibot schema'ları (JP)
// Generated: 2026-06-16T13:24:29.735Z

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
  OWNER = "OWNER",
  VENDOR_MANAGER = "VENDOR_MANAGER",
  AGENCY_ADMIN = "AGENCY_ADMIN",
  AGENT = "AGENT",
  ACCOUNTANT = "ACCOUNTANT",
  MAINTENANCE = "MAINTENANCE",
  TENANT_GUEST = "TENANT_GUEST",
  ORG_ADMIN = "ORG_ADMIN",
  READ_ONLY = "READ_ONLY"
}
export const MemberRoleKeySchema = v.enum_(MemberRoleKey);

export enum PermissionKey {
  ORG_MANAGE = "ORG_MANAGE",
  USERS_MANAGE = "USERS_MANAGE",
  PROPERTIES_VIEW_ALL = "PROPERTIES_VIEW_ALL",
  PROPERTIES_MANAGE_OWN = "PROPERTIES_MANAGE_OWN",
  PROPERTIES_MANAGE_ALL = "PROPERTIES_MANAGE_ALL",
  LISTINGS_VIEW_ALL = "LISTINGS_VIEW_ALL",
  LISTINGS_MANAGE_OWN = "LISTINGS_MANAGE_OWN",
  LISTINGS_MANAGE_ALL = "LISTINGS_MANAGE_ALL",
  BOOKINGS_VIEW_OWN = "BOOKINGS_VIEW_OWN",
  BOOKINGS_MANAGE_OWN = "BOOKINGS_MANAGE_OWN",
  BOOKINGS_MANAGE_ALL = "BOOKINGS_MANAGE_ALL",
  LEASES_MANAGE_OWN = "LEASES_MANAGE_OWN",
  LEASES_MANAGE_ALL = "LEASES_MANAGE_ALL",
  CONTRACTS_MANAGE_OWN = "CONTRACTS_MANAGE_OWN",
  CONTRACTS_MANAGE_ALL = "CONTRACTS_MANAGE_ALL",
  FINANCE_MANAGE = "FINANCE_MANAGE",
  TAX_MANAGE = "TAX_MANAGE",
  REPORTS_VIEW = "REPORTS_VIEW",
  EXPORTS_MANAGE = "EXPORTS_MANAGE",
  RESERVATIONS_MANAGE_OWN = "RESERVATIONS_MANAGE_OWN",
  RESERVATIONS_MANAGE_ALL = "RESERVATIONS_MANAGE_ALL",
  TASKS_VIEW_OWN = "TASKS_VIEW_OWN",
  TASKS_MANAGE_OWN = "TASKS_MANAGE_OWN",
  TASKS_MANAGE_ALL = "TASKS_MANAGE_ALL",
  MESSAGES_USE_OWN = "MESSAGES_USE_OWN",
  MESSAGES_MANAGE_ALL = "MESSAGES_MANAGE_ALL",
  MESSAGES_READ_ALL = "MESSAGES_READ_ALL",
  BOOKINGS_VIEW_ALL = "BOOKINGS_VIEW_ALL",
  TASKS_VIEW_ALL = "TASKS_VIEW_ALL",
  VENDORS_MANAGE = "VENDORS_MANAGE",
  REVIEWS_MANAGE = "REVIEWS_MANAGE",
  DOCUMENTS_MANAGE = "DOCUMENTS_MANAGE",
  AUDIT_LOGS_VIEW = "AUDIT_LOGS_VIEW",
  API_KEYS_MANAGE = "API_KEYS_MANAGE",
  NOTIFICATIONS_MANAGE = "NOTIFICATIONS_MANAGE",
  MLS_MANAGE = "MLS_MANAGE",
  GOV_INTEGRATIONS_MANAGE = "GOV_INTEGRATIONS_MANAGE",
  SETTINGS_MANAGE = "SETTINGS_MANAGE"
}
export const PermissionKeySchema = v.enum_(PermissionKey);

export enum PropertyType {
  DETACHED_HOUSE = "DETACHED_HOUSE",
  SEMI_DETACHED_HOUSE = "SEMI_DETACHED_HOUSE",
  TERRACED_HOUSE = "TERRACED_HOUSE",
  FLAT_MAISONETTE = "FLAT_MAISONETTE",
  BUNGALOW = "BUNGALOW",
  COTTAGE = "COTTAGE",
  TOWNHOUSE = "TOWNHOUSE",
  APARTMENT = "APARTMENT",
  STUDIO = "STUDIO",
  PENTHOUSE = "PENTHOUSE",
  OFFICE = "OFFICE",
  RETAIL = "RETAIL",
  COMMERCIAL_SPACE = "COMMERCIAL_SPACE"
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

export enum LeaseStatus {
  DRAFT = "DRAFT",
  ACTIVE = "ACTIVE",
  LATE = "LATE",
  ENDED = "ENDED",
  TERMINATED = "TERMINATED",
  ARCHIVED = "ARCHIVED"
}
export const LeaseStatusSchema = v.enum_(LeaseStatus);

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

export enum TaskType {
  CLEANING = "CLEANING",
  INSPECTION = "INSPECTION",
  REPAIR = "REPAIR",
  ADMIN = "ADMIN",
  LEGAL = "LEGAL",
  OTHER = "OTHER"
}
export const TaskTypeSchema = v.enum_(TaskType);

export enum TaskStatus {
  OPEN = "OPEN",
  IN_PROGRESS = "IN_PROGRESS",
  DONE = "DONE",
  CANCELLED = "CANCELLED",
  BLOCKED = "BLOCKED"
}
export const TaskStatusSchema = v.enum_(TaskStatus);

export enum Priority {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  URGENT = "URGENT"
}
export const PrioritySchema = v.enum_(Priority);

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
  BRIDGE_API = "BRIDGE_API",
  SPARK_API = "SPARK_API",
  ZILLOW = "ZILLOW",
  REDFIN = "REDFIN",
  TREB = "TREB",
  CREA = "CREA",
  IDEALISTA = "IDEALISTA",
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

export enum PropertyCategory {
  RESIDENTIAL = "RESIDENTIAL",
  COMMERCIAL = "COMMERCIAL",
  INDUSTRIAL = "INDUSTRIAL",
  MIXED_USE = "MIXED_USE",
  AGRICULTURAL = "AGRICULTURAL",
  SPECIAL_PURPOSE = "SPECIAL_PURPOSE"
}
export const PropertyCategorySchema = v.enum_(PropertyCategory);

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

export enum LoyaltyTier {
  BRONZE = "BRONZE",
  SILVER = "SILVER",
  GOLD = "GOLD",
  PLATINUM = "PLATINUM",
  DIAMOND = "DIAMOND"
}
export const LoyaltyTierSchema = v.enum_(LoyaltyTier);

export enum ReferralStatus {
  PENDING = "PENDING",
  COMPLETED = "COMPLETED",
  EXPIRED = "EXPIRED",
  CANCELLED = "CANCELLED"
}
export const ReferralStatusSchema = v.enum_(ReferralStatus);

export enum GoalType {
  LISTINGS_CREATED = "LISTINGS_CREATED",
  DEALS_CLOSED = "DEALS_CLOSED",
  REFERRALS_MADE = "REFERRALS_MADE",
  REVIEWS_RECEIVED = "REVIEWS_RECEIVED",
  COMMISSION_EARNED = "COMMISSION_EARNED"
}
export const GoalTypeSchema = v.enum_(GoalType);

export enum SubscriptionStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  CANCELLED = "CANCELLED",
  EXPIRED = "EXPIRED"
}
export const SubscriptionStatusSchema = v.enum_(SubscriptionStatus);

export enum MembershipType {
  BASIC = "BASIC",
  PREMIUM = "PREMIUM",
  ENTERPRISE = "ENTERPRISE",
  VIP = "VIP"
}
export const MembershipTypeSchema = v.enum_(MembershipType);

export enum RewardType {
  DISCOUNT = "DISCOUNT",
  CASH_BACK = "CASH_BACK",
  FREE_SERVICE = "FREE_SERVICE",
  PRIORITY_SUPPORT = "PRIORITY_SUPPORT",
  FEATURED_LISTING = "FEATURED_LISTING"
}
export const RewardTypeSchema = v.enum_(RewardType);

export enum EarningType {
  COMMISSION = "COMMISSION",
  REFERRAL_BONUS = "REFERRAL_BONUS",
  LOYALTY_REWARD = "LOYALTY_REWARD",
  SUBSCRIPTION_BONUS = "SUBSCRIPTION_BONUS",
  FEATURE_FEE = "FEATURE_FEE"
}
export const EarningTypeSchema = v.enum_(EarningType);

export enum ManagementFeeType {
  PERCENTAGE_RENT = "PERCENTAGE_RENT",
  PERCENTAGE_INCOME = "PERCENTAGE_INCOME",
  FLAT_MONTHLY = "FLAT_MONTHLY",
  FLAT_ANNUAL = "FLAT_ANNUAL",
  PER_UNIT_MONTHLY = "PER_UNIT_MONTHLY",
  TIERED_PERCENTAGE = "TIERED_PERCENTAGE",
  PERFORMANCE_BASED = "PERFORMANCE_BASED",
  HYBRID = "HYBRID"
}
export const ManagementFeeTypeSchema = v.enum_(ManagementFeeType);

export enum ManagementFeeScope {
  PROPERTY_MANAGEMENT = "PROPERTY_MANAGEMENT",
  LEASING_ONLY = "LEASING_ONLY",
  MAINTENANCE_ONLY = "MAINTENANCE_ONLY",
  FULL_SERVICE = "FULL_SERVICE",
  FINANCIAL_ONLY = "FINANCIAL_ONLY",
  COMPLIANCE_ONLY = "COMPLIANCE_ONLY"
}
export const ManagementFeeScopeSchema = v.enum_(ManagementFeeScope);

export enum USTaxForm {
  FORM_1040 = "FORM_1040",
  FORM_1099 = "FORM_1099",
  FORM_1065 = "FORM_1065",
  FORM_1120 = "FORM_1120",
  FORM_1120S = "FORM_1120S",
  FORM_4797 = "FORM_4797",
  FORM_6251 = "FORM_6251",
  FORM_8606 = "FORM_8606",
  FORM_8824 = "FORM_8824",
  FORM_8867 = "FORM_8867",
  SCHEDULE_E = "SCHEDULE_E",
  SCHEDULE_EIC = "SCHEDULE_EIC"
}
export const USTaxFormSchema = v.enum_(USTaxForm);

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

export enum LeaseTypeUS {
  MONTH_TO_MONTH_TENANCY = "MONTH_TO_MONTH_TENANCY",
  FIXED_TERM_LEASE = "FIXED_TERM_LEASE",
  COMMERCIAL_LEASE = "COMMERCIAL_LEASE",
  RESIDENTIAL_LEASE = "RESIDENTIAL_LEASE",
  SUBLEASE = "SUBLEASE",
  ROOM_RENTAL_AGREEMENT = "ROOM_RENTAL_AGREEMENT",
  STUDENT_HOUSING_LEASE = "STUDENT_HOUSING_LEASE",
  VACATION_RENTAL_AGREEMENT = "VACATION_RENTAL_AGREEMENT",
  MOBILE_HOME_LEASE = "MOBILE_HOME_LEASE",
  STORAGE_UNIT_LEASE = "STORAGE_UNIT_LEASE",
  OFFICE_LEASE = "OFFICE_LEASE",
  RETAIL_LEASE = "RETAIL_LEASE"
}
export const LeaseTypeUSSchema = v.enum_(LeaseTypeUS);

export enum InspectionTypeUS {
  HOME_INSPECTION = "HOME_INSPECTION",
  RADON_TESTING = "RADON_TESTING",
  MOLD_INSPECTION = "MOLD_INSPECTION",
  PEST_INSPECTION = "PEST_INSPECTION",
  LEAD_PAINT_INSPECTION = "LEAD_PAINT_INSPECTION",
  ELECTRICAL_INSPECTION = "ELECTRICAL_INSPECTION",
  PLUMBING_INSPECTION = "PLUMBING_INSPECTION",
  HVAC_INSPECTION = "HVAC_INSPECTION",
  ROOF_INSPECTION = "ROOF_INSPECTION",
  FOUNDATION_INSPECTION = "FOUNDATION_INSPECTION",
  FIRE_SAFETY_INSPECTION = "FIRE_SAFETY_INSPECTION",
  CODE_COMPLIANCE_INSPECTION = "CODE_COMPLIANCE_INSPECTION"
}
export const InspectionTypeUSSchema = v.enum_(InspectionTypeUS);

export enum PaymentMethodUS {
  ACH_TRANSFER = "ACH_TRANSFER",
  WIRE_TRANSFER = "WIRE_TRANSFER",
  CHECK = "CHECK",
  CASHIERS_CHECK = "CASHIERS_CHECK",
  CERTIFIED_CHECK = "CERTIFIED_CHECK",
  MONEY_ORDER = "MONEY_ORDER",
  DEBIT_CARD = "DEBIT_CARD",
  CREDIT_CARD = "CREDIT_CARD",
  PAYPAL = "PAYPAL",
  VENMO = "VENMO",
  ZELLE = "ZELLE",
  APPLE_PAY = "APPLE_PAY",
  GOOGLE_PAY = "GOOGLE_PAY",
  CRYPTOCURRENCY = "CRYPTOCURRENCY",
  ESCROW_ACCOUNT = "ESCROW_ACCOUNT",
  TITLE_COMPANY_HOLD = "TITLE_COMPANY_HOLD"
}
export const PaymentMethodUSSchema = v.enum_(PaymentMethodUS);

export enum CommissionTypeUS {
  BUYER_AGENT_COMMISSION = "BUYER_AGENT_COMMISSION",
  SELLER_AGENT_COMMISSION = "SELLER_AGENT_COMMISSION",
  REFERRAL_FEE = "REFERRAL_FEE",
  TRANSACTION_COORDINATOR_FEE = "TRANSACTION_COORDINATOR_FEE",
  TITLE_COMPANY_FEE = "TITLE_COMPANY_FEE",
  ESCROW_FEE = "ESCROW_FEE",
  APPRAISAL_FEE = "APPRAISAL_FEE",
  HOME_INSPECTION_FEE = "HOME_INSPECTION_FEE",
  PROPERTY_MANAGEMENT_FEE = "PROPERTY_MANAGEMENT_FEE",
  LEASING_COMMISSION = "LEASING_COMMISSION",
  MAINTENANCE_FEE = "MAINTENANCE_FEE",
  MARKETING_FEE = "MARKETING_FEE",
  ADMINISTRATIVE_FEE = "ADMINISTRATIVE_FEE",
  PROCESSING_FEE = "PROCESSING_FEE"
}
export const CommissionTypeUSSchema = v.enum_(CommissionTypeUS);

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

export enum PayoutStatusUSA {
  PENDING = "PENDING",
  APPROVED = "APPROVED",
  PROCESSING = "PROCESSING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED",
  REVERSED = "REVERSED",
  ESCROW = "ESCROW",
  HELD = "HELD",
  RELEASED = "RELEASED"
}
export const PayoutStatusUSASchema = v.enum_(PayoutStatusUSA);

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
  AIRBNB = "AIRBNB",
  BOOKING_COM = "BOOKING_COM",
  EXPEDIA = "EXPEDIA",
  VRBO = "VRBO",
  HOMEAWAY = "HOMEAWAY",
  TRIPADVISOR = "TRIPADVISOR",
  GOOGLE_VACATION_RENTALS = "GOOGLE_VACATION_RENTALS",
  FACEBOOK_MARKETPLACE = "FACEBOOK_MARKETPLACE",
  OTHER = "OTHER"
}
export const RentalPlatformSchema = v.enum_(RentalPlatform);

export enum SyncDirection {
  IMPORT = "IMPORT",
  EXPORT = "EXPORT",
  BIDIRECTIONAL = "BIDIRECTIONAL"
}
export const SyncDirectionSchema = v.enum_(SyncDirection);

export enum RentalStatus {
  DRAFT = "DRAFT",
  PENDING_REVIEW = "PENDING_REVIEW",
  ACTIVE = "ACTIVE",
  PAUSED = "PAUSED",
  SUSPENDED = "SUSPENDED",
  EXPIRED = "EXPIRED",
  DELETED = "DELETED"
}
export const RentalStatusSchema = v.enum_(RentalStatus);

export enum ListingChannelType {
  DIRECT = "DIRECT",
  MLS = "MLS",
  AIRBNB = "AIRBNB",
  BOOKING_COM = "BOOKING_COM",
  EXPEDIA = "EXPEDIA",
  VRBO = "VRBO",
  OTHER_PLATFORM = "OTHER_PLATFORM"
}
export const ListingChannelTypeSchema = v.enum_(ListingChannelType);

export enum AssetType {
  BUILDING = "BUILDING",
  LAND_IMPROVEMENT = "LAND_IMPROVEMENT",
  PERSONAL_PROPERTY = "PERSONAL_PROPERTY"
}
export const AssetTypeSchema = v.enum_(AssetType);

export enum DepreciationMethod {
  STRAIGHT_LINE = "STRAIGHT_LINE",
  DECLINING_BALANCE = "DECLINING_BALANCE"
}
export const DepreciationMethodSchema = v.enum_(DepreciationMethod);

export enum RelationshipStatus {
  PROSPECT = "PROSPECT",
  CLIENT = "CLIENT",
  PAST_CLIENT = "PAST_CLIENT"
}
export const RelationshipStatusSchema = v.enum_(RelationshipStatus);

export enum ApplicationStatus {
  PENDING = "PENDING",
  APPROVED = "APPROVED",
  DENIED = "DENIED",
  WITHDRAWN = "WITHDRAWN"
}
export const ApplicationStatusSchema = v.enum_(ApplicationStatus);

export enum WorkOrderStatus {
  OPEN = "OPEN",
  ASSIGNED = "ASSIGNED",
  IN_PROGRESS = "IN_PROGRESS",
  COMPLETED = "COMPLETED",
  CANCELLED = "CANCELLED"
}
export const WorkOrderStatusSchema = v.enum_(WorkOrderStatus);

export enum RenewalStatus {
  PENDING = "PENDING",
  OFFERED = "OFFERED",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED"
}
export const RenewalStatusSchema = v.enum_(RenewalStatus);

export enum WidgetType {
  OCCUPANCY_RATE = "OCCUPANCY_RATE",
  REVENUE_CHART = "REVENUE_CHART",
  MAINTENANCE_COSTS = "MAINTENANCE_COSTS",
  CASH_FLOW = "CASH_FLOW",
  PROPERTY_PERFORMANCE = "PROPERTY_PERFORMANCE",
  MARKET_TRENDS = "MARKET_TRENDS"
}
export const WidgetTypeSchema = v.enum_(WidgetType);

export enum ModelType {
  OCCUPANCY_FORECAST = "OCCUPANCY_FORECAST",
  RENT_PRICE_PREDICTION = "RENT_PRICE_PREDICTION",
  MARKET_VALUE_ESTIMATE = "MARKET_VALUE_ESTIMATE",
  CASH_FLOW_PROJECTION = "CASH_FLOW_PROJECTION"
}
export const ModelTypeSchema = v.enum_(ModelType);

export enum LocationAccuracy {
  EXACT = "EXACT",
  STREET_LEVEL = "STREET_LEVEL",
  NEIGHBORHOOD_LEVEL = "NEIGHBORHOOD_LEVEL",
  CITY_LEVEL = "CITY_LEVEL",
  APPROXIMATE = "APPROXIMATE",
  ESTIMATED = "ESTIMATED"
}
export const LocationAccuracySchema = v.enum_(LocationAccuracy);

export enum EscrowStatus {
  HOLDING = "HOLDING",
  PARTIALLY_RELEASED = "PARTIALLY_RELEASED",
  FULLY_RELEASED = "FULLY_RELEASED",
  DISPUTED = "DISPUTED",
  REFUNDED = "REFUNDED",
  CANCELLED = "CANCELLED"
}
export const EscrowStatusSchema = v.enum_(EscrowStatus);

export enum EscrowTriggerEvent {
  RESERVATION_CONFIRMED = "RESERVATION_CONFIRMED",
  CHECK_IN_COMPLETED = "CHECK_IN_COMPLETED",
  MIDSTAY_REACHED = "MIDSTAY_REACHED",
  CHECK_OUT_COMPLETED = "CHECK_OUT_COMPLETED",
  SURVEY_COMPLETED = "SURVEY_COMPLETED",
  DEPOSIT_INSPECTION_DONE = "DEPOSIT_INSPECTION_DONE",
  DISPUTE_RESOLVED = "DISPUTE_RESOLVED",
  MANUAL_RELEASE = "MANUAL_RELEASE"
}
export const EscrowTriggerEventSchema = v.enum_(EscrowTriggerEvent);

export enum EscrowReleaseStatus {
  PENDING = "PENDING",
  SCHEDULED = "SCHEDULED",
  PROCESSING = "PROCESSING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED"
}
export const EscrowReleaseStatusSchema = v.enum_(EscrowReleaseStatus);

export enum EscrowDisputeParty {
  TENANT = "TENANT",
  OWNER = "OWNER",
  PLATFORM = "PLATFORM"
}
export const EscrowDisputePartySchema = v.enum_(EscrowDisputeParty);

export enum EscrowDisputeType {
  PROPERTY_DAMAGE = "PROPERTY_DAMAGE",
  LISTING_MISMATCH = "LISTING_MISMATCH",
  PAYMENT_DISPUTE = "PAYMENT_DISPUTE",
  EARLY_DEPARTURE = "EARLY_DEPARTURE",
  CANCELLATION = "CANCELLATION",
  OTHER = "OTHER"
}
export const EscrowDisputeTypeSchema = v.enum_(EscrowDisputeType);

export enum EscrowDisputeStatus {
  OPEN = "OPEN",
  EVIDENCE_COLLECTION = "EVIDENCE_COLLECTION",
  UNDER_REVIEW = "UNDER_REVIEW",
  RESOLVED = "RESOLVED",
  ESCALATED = "ESCALATED",
  CLOSED = "CLOSED"
}
export const EscrowDisputeStatusSchema = v.enum_(EscrowDisputeStatus);

export enum AIChatRole {
  USER = "USER",
  ASSISTANT = "ASSISTANT",
  SYSTEM = "SYSTEM"
}
export const AIChatRoleSchema = v.enum_(AIChatRole);

export enum AIChatModuleType {
  SALES_ASSISTANT = "SALES_ASSISTANT",
  PAYMENT_NEGOTIATION = "PAYMENT_NEGOTIATION",
  RESERVATION_APPROVAL = "RESERVATION_APPROVAL",
  DISPUTE_RESOLUTION = "DISPUTE_RESOLUTION",
  CONTRACT_ASSISTANT = "CONTRACT_ASSISTANT",
  GENERAL = "GENERAL"
}
export const AIChatModuleTypeSchema = v.enum_(AIChatModuleType);

export enum PaymentNegotiationStatus {
  NEGOTIATING = "NEGOTIATING",
  TENANT_PROPOSED = "TENANT_PROPOSED",
  OWNER_COUNTERED = "OWNER_COUNTERED",
  AGREED = "AGREED",
  REJECTED = "REJECTED",
  EXPIRED = "EXPIRED",
  CANCELLED = "CANCELLED"
}
export const PaymentNegotiationStatusSchema = v.enum_(PaymentNegotiationStatus);

export enum VideoLoraStyle {
  FILM_NOIR = "FILM_NOIR",
  PIXAR = "PIXAR",
  ORIGAMI = "ORIGAMI",
  ARCANE = "ARCANE",
  GENSHIN_TCG = "GENSHIN_TCG",
  REALISTIC = "REALISTIC",
  CUSTOM = "CUSTOM"
}
export const VideoLoraStyleSchema = v.enum_(VideoLoraStyle);

export enum VideoPipeline {
  STREAM_DIFFUSION_V2 = "STREAM_DIFFUSION_V2",
  LONGLIVE = "LONGLIVE",
  REWARD_FORCING = "REWARD_FORCING",
  MEMFLOW = "MEMFLOW",
  KREA_REALTIME = "KREA_REALTIME"
}
export const VideoPipelineSchema = v.enum_(VideoPipeline);

export enum VideoLoraStrategy {
  PERMANENT_MERGE = "PERMANENT_MERGE",
  RUNTIME_PEFT = "RUNTIME_PEFT"
}
export const VideoLoraStrategySchema = v.enum_(VideoLoraStrategy);

export enum VideoTargetPlatform {
  INSTAGRAM_REELS = "INSTAGRAM_REELS",
  TIKTOK = "TIKTOK",
  YOUTUBE_SHORTS = "YOUTUBE_SHORTS",
  LINKEDIN = "LINKEDIN",
  FACEBOOK = "FACEBOOK",
  TWITTER_X = "TWITTER_X",
  PLATFORM_INTERNAL = "PLATFORM_INTERNAL",
  ALL_PLATFORMS = "ALL_PLATFORMS"
}
export const VideoTargetPlatformSchema = v.enum_(VideoTargetPlatform);

export enum VideoContentStatus {
  DRAFT = "DRAFT",
  GENERATING = "GENERATING",
  READY = "READY",
  PUBLISHED = "PUBLISHED",
  ARCHIVED = "ARCHIVED",
  FAILED = "FAILED"
}
export const VideoContentStatusSchema = v.enum_(VideoContentStatus);

export enum VideoCampaignType {
  SALES_ASSISTANT = "SALES_ASSISTANT",
  PRICE_OPTIMIZATION = "PRICE_OPTIMIZATION",
  MARKET_REPORT = "MARKET_REPORT",
  SOCIAL_PROOF = "SOCIAL_PROOF",
  SEASONAL = "SEASONAL",
  RETARGETING = "RETARGETING",
  AMBASSADOR = "AMBASSADOR",
  SOCIAL_IMPACT = "SOCIAL_IMPACT",
  PROPERTY_SHOWCASE = "PROPERTY_SHOWCASE",
  ONBOARDING = "ONBOARDING"
}
export const VideoCampaignTypeSchema = v.enum_(VideoCampaignType);

export enum AmbassadorCategory {
  ATHLETE = "ATHLETE",
  ENTERTAINER = "ENTERTAINER",
  REAL_ESTATE_INFLUENCER = "REAL_ESTATE_INFLUENCER",
  BUSINESS_LEADER = "BUSINESS_LEADER",
  SOCIAL_MEDIA_CREATOR = "SOCIAL_MEDIA_CREATOR",
  CELEBRITY = "CELEBRITY",
  MICRO_INFLUENCER = "MICRO_INFLUENCER"
}
export const AmbassadorCategorySchema = v.enum_(AmbassadorCategory);

export enum AmbassadorStatus {
  PROSPECT = "PROSPECT",
  PITCHED = "PITCHED",
  NEGOTIATING = "NEGOTIATING",
  SIGNED = "SIGNED",
  ACTIVE = "ACTIVE",
  PAUSED = "PAUSED",
  ENDED = "ENDED"
}
export const AmbassadorStatusSchema = v.enum_(AmbassadorStatus);

export enum SocialImpactType {
  TREE_PLANTED = "TREE_PLANTED",
  CHILD_SUPPORTED = "CHILD_SUPPORTED",
  ANIMAL_SHELTERED = "ANIMAL_SHELTERED",
  DONATION_MADE = "DONATION_MADE"
}
export const SocialImpactTypeSchema = v.enum_(SocialImpactType);

export enum NegotiationParty {
  TENANT = "TENANT",
  OWNER = "OWNER",
  PLATFORM = "PLATFORM"
}
export const NegotiationPartySchema = v.enum_(NegotiationParty);

export enum NegotiationOfferStatus {
  PENDING = "PENDING",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
  COUNTERED = "COUNTERED",
  EXPIRED = "EXPIRED",
  WITHDRAWN = "WITHDRAWN"
}
export const NegotiationOfferStatusSchema = v.enum_(NegotiationOfferStatus);

export enum PaymentType {
  Rent = "Rent",
  Booking = "Booking",
  Commission = "Commission",
  Membership = "Membership",
  Downpayment = "Downpayment"
}
export const PaymentTypeSchema = v.enum_(PaymentType);

export enum AccountType {
  OAUTH = "OAUTH",
  EMAIL = "EMAIL",
  OIDC = "OIDC",
  CREDENTIALS = "CREDENTIALS",
  GOOGLE = "GOOGLE",
  FACEBOOK = "FACEBOOK"
}
export const AccountTypeSchema = v.enum_(AccountType);

export enum AgentSpecialities {
  RESIDENTIAL = "RESIDENTIAL",
  COMMERCIAL = "COMMERCIAL",
  LUXURY = "LUXURY",
  RENTAL = "RENTAL",
  INVESTMENT = "INVESTMENT",
  OTHER = "OTHER"
}
export const AgentSpecialitiesSchema = v.enum_(AgentSpecialities);

export enum AlertSeverity {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  CRITICAL = "CRITICAL"
}
export const AlertSeveritySchema = v.enum_(AlertSeverity);

export enum AlertType {
  WARNING = "WARNING",
  CRITICAL = "CRITICAL",
  INFO = "INFO",
  SUCCESS = "SUCCESS"
}
export const AlertTypeSchema = v.enum_(AlertType);

export enum AmenityAccessType {
  FREE = "FREE",
  PAID = "PAID",
  MEMBERSHIP = "MEMBERSHIP"
}
export const AmenityAccessTypeSchema = v.enum_(AmenityAccessType);

export enum AnalyticsType {
  LISTING_VIEW = "LISTING_VIEW",
  BOOKING_CONVERSION = "BOOKING_CONVERSION",
  ML_PROPERTY_SCORE = "ML_PROPERTY_SCORE",
  USER_ENGAGEMENT = "USER_ENGAGEMENT",
  REVENUE = "REVENUE",
  PERFORMANCE = "PERFORMANCE",
  AGENT_PERFORMANCE = "AGENT_PERFORMANCE",
  AGENCY_PERFORMANCE = "AGENCY_PERFORMANCE",
  TAX_PAYMENT = "TAX_PAYMENT",
  TAX_OVERDUE = "TAX_OVERDUE",
  TAX_COMPLIANCE = "TAX_COMPLIANCE",
  TAX_REVENUE = "TAX_REVENUE",
  TAX_PERFORMANCE = "TAX_PERFORMANCE",
  TAX_REMINDER = "TAX_REMINDER",
  TAX_AUDIT = "TAX_AUDIT",
  TAX_REPORT = "TAX_REPORT"
}
export const AnalyticsTypeSchema = v.enum_(AnalyticsType);

export enum ArchitecturalStyle {
  MODERN = "MODERN",
  CONTEMPORARY = "CONTEMPORARY",
  TRADITIONAL = "TRADITIONAL",
  COLONIAL = "COLONIAL",
  VICTORIAN = "VICTORIAN",
  CRAFTSMAN = "CRAFTSMAN",
  MID_CENTURY = "MID_CENTURY",
  MEDITERRANEAN = "MEDITERRANEAN",
  FARMHOUSE = "FARMHOUSE",
  RANCH = "RANCH",
  SPANISH = "SPANISH",
  TUDOR = "TUDOR"
}
export const ArchitecturalStyleSchema = v.enum_(ArchitecturalStyle);

export enum BookingSource {
  Direct = "Direct",
  Airbnb = "Airbnb",
  Booking = "Booking",
  Expedia = "Expedia",
  Other = "Other",
  Agency = "Agency",
  ReferenceSource = "ReferenceSource"
}
export const BookingSourceSchema = v.enum_(BookingSource);

export enum BuildingClass {
  CLASS_A = "CLASS_A",
  CLASS_B = "CLASS_B",
  CLASS_C = "CLASS_C",
  CLASS_D = "CLASS_D",
  LUXURY = "LUXURY",
  HISTORIC = "HISTORIC"
}
export const BuildingClassSchema = v.enum_(BuildingClass);

export enum ChannelCategory {
  AGENT = "AGENT",
  AGENCY = "AGENCY",
  TENANT = "TENANT",
  PROPERTY = "PROPERTY",
  PAYMENT = "PAYMENT",
  SYSTEM = "SYSTEM",
  REPORT = "REPORT",
  RESERVATION = "RESERVATION",
  TASK = "TASK",
  TICKET = "TICKET"
}
export const ChannelCategorySchema = v.enum_(ChannelCategory);

export enum ChannelType {
  PUBLIC = "PUBLIC",
  PRIVATE = "PRIVATE",
  GROUP = "GROUP"
}
export const ChannelTypeSchema = v.enum_(ChannelType);

export enum CommissionRuleType {
  SEASONAL = "SEASONAL",
  VOLUME = "VOLUME",
  PROPERTY_TYPE = "PROPERTY_TYPE",
  LOCATION_BASED = "LOCATION_BASED",
  BOOKING_VALUE = "BOOKING_VALUE",
  LOYALTY = "LOYALTY",
  SPECIAL_PROMOTION = "SPECIAL_PROMOTION",
  PACKAGE_DEAL = "PACKAGE_DEAL",
  PRICE_COMPARISON = "PRICE_COMPARISON",
  COMMISSION_SUMMARY = "COMMISSION_SUMMARY",
  BOOKING_VOLUME = "BOOKING_VOLUME",
  REVENUE = "REVENUE",
  PERFORMANCE = "PERFORMANCE"
}
export const CommissionRuleTypeSchema = v.enum_(CommissionRuleType);

export enum CommunicationType {
  PROBLEM = "PROBLEM",
  REQUEST = "REQUEST",
  ADVICE = "ADVICE",
  INFORMATION = "INFORMATION",
  FEEDBACK = "FEEDBACK"
}
export const CommunicationTypeSchema = v.enum_(CommunicationType);

export enum ComplianceStatus {
  PENDING = "PENDING",
  APPROVED = "APPROVED",
  REJECTED = "REJECTED"
}
export const ComplianceStatusSchema = v.enum_(ComplianceStatus);

export enum ConstructionType {
  WOOD_FRAME = "WOOD_FRAME",
  BRICK = "BRICK",
  CONCRETE = "CONCRETE",
  STEEL = "STEEL",
  STONE = "STONE",
  LOG = "LOG",
  PREFAB = "PREFAB",
  MODULAR = "MODULAR"
}
export const ConstructionTypeSchema = v.enum_(ConstructionType);

export enum ContactMethod {
  EMAIL = "EMAIL",
  PHONE = "PHONE",
  MESSAGE = "MESSAGE",
  ANY = "ANY"
}
export const ContactMethodSchema = v.enum_(ContactMethod);

export enum CoolingType {
  CENTRAL_AC = "CENTRAL_AC",
  WINDOW_UNIT = "WINDOW_UNIT",
  DUCTLESS_MINI_SPLIT = "DUCTLESS_MINI_SPLIT",
  EVAPORATIVE_COOLER = "EVAPORATIVE_COOLER"
}
export const CoolingTypeSchema = v.enum_(CoolingType);

export enum DeviceType {
  MOBILE = "MOBILE",
  DESKTOP = "DESKTOP",
  TABLET = "TABLET",
  OTHER = "OTHER"
}
export const DeviceTypeSchema = v.enum_(DeviceType);

export enum DiscountType {
  FIRST_BOOKING = "FIRST_BOOKING",
  LONG_TERM = "LONG_TERM",
  REFERRAL = "REFERRAL",
  SEASONAL = "SEASONAL",
  CUSTOM = "CUSTOM",
  PERCENTAGE = "PERCENTAGE",
  FIXED_AMOUNT = "FIXED_AMOUNT",
  FREE_NIGHTS = "FREE_NIGHTS"
}
export const DiscountTypeSchema = v.enum_(DiscountType);

export enum EnergyEfficiencyRating {
  ENERGY_STAR = "ENERGY_STAR",
  LEED_CERTIFIED = "LEED_CERTIFIED",
  LEED_SILVER = "LEED_SILVER",
  LEED_GOLD = "LEED_GOLD",
  LEED_PLATINUM = "LEED_PLATINUM",
  NET_ZERO = "NET_ZERO"
}
export const EnergyEfficiencyRatingSchema = v.enum_(EnergyEfficiencyRating);

export enum EnergyRating {
  A = "A",
  B = "B",
  C = "C",
  D = "D",
  E = "E",
  F = "F",
  G = "G"
}
export const EnergyRatingSchema = v.enum_(EnergyRating);

export enum EventType {
  VIEWING = "VIEWING",
  OPEN_HOUSE = "OPEN_HOUSE",
  VIRTUAL_TOUR = "VIRTUAL_TOUR",
  INSPECTION = "INSPECTION",
  OTHER = "OTHER"
}
export const EventTypeSchema = v.enum_(EventType);

export enum ExpenseStatus {
  PENDING = "PENDING",
  PAID = "PAID",
  OVERDUE = "OVERDUE",
  CANCELLED = "CANCELLED"
}
export const ExpenseStatusSchema = v.enum_(ExpenseStatus);

export enum ExpenseType {
  MAINTENANCE = "MAINTENANCE",
  CLEANING = "CLEANING",
  UTILITIES = "UTILITIES",
  MANAGEMENT_FEE = "MANAGEMENT_FEE",
  TAX = "TAX",
  INSURANCE = "INSURANCE",
  REPAIR = "REPAIR",
  SECURITY = "SECURITY",
  OTHER = "OTHER"
}
export const ExpenseTypeSchema = v.enum_(ExpenseType);

export enum FacilityAmenities {
  COMMUNITY_CENTER = "COMMUNITY_CENTER",
  CO_WORKING_SPACE = "CO_WORKING_SPACE",
  BIKE_STORAGE = "BIKE_STORAGE",
  PARKING_GARAGE = "PARKING_GARAGE",
  EV_CHARGING = "EV_CHARGING",
  SECURITY_DESK = "SECURITY_DESK",
  PACKAGE_ROOM = "PACKAGE_ROOM",
  BBQ_AREA = "BBQ_AREA",
  ROOFTOP_TERRACE = "ROOFTOP_TERRACE"
}
export const FacilityAmenitiesSchema = v.enum_(FacilityAmenities);

export enum FacilityStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  DEVELOPMENT = "DEVELOPMENT",
  RENOVATION = "RENOVATION"
}
export const FacilityStatusSchema = v.enum_(FacilityStatus);

export enum FacilityType {
  RESIDENTIAL = "RESIDENTIAL",
  COMMERCIAL = "COMMERCIAL",
  MIXED_USE = "MIXED_USE",
  INDUSTRIAL = "INDUSTRIAL",
  OFFICE = "OFFICE",
  RETAIL = "RETAIL",
  WAREHOUSE = "WAREHOUSE",
  PARKING = "PARKING",
  GYM = "GYM",
  SWIMMING_POOL = "SWIMMING_POOL",
  YOGA = "YOGA",
  FITNESS = "FITNESS",
  GOLF = "GOLF",
  CAFETERIA = "CAFETERIA",
  RESTAURANT = "RESTAURANT",
  THEATER = "THEATER",
  CONCERT_HALL = "CONCERT_HALL",
  MUSEUM = "MUSEUM",
  GALLERY = "GALLERY",
  CINEMA = "CINEMA",
  ZOO = "ZOO",
  BOTANIC_GARDEN = "BOTANIC_GARDEN",
  THEME_PARK = "THEME_PARK",
  GOLF_COURSE = "GOLF_COURSE",
  BEACH = "BEACH",
  PARK = "PARK",
  RESIDENTIAL_COMPLEX = "RESIDENTIAL_COMPLEX",
  COMMERCIAL_COMPLEX = "COMMERCIAL_COMPLEX",
  LUXURY_RESIDENCE = "LUXURY_RESIDENCE",
  APARTMENT_BUILDING = "APARTMENT_BUILDING",
  TOWER_COMPLEX = "TOWER_COMPLEX",
  GATED_COMMUNITY = "GATED_COMMUNITY"
}
export const FacilityTypeSchema = v.enum_(FacilityType);

export enum Gender {
  MALE = "MALE",
  FEMALE = "FEMALE"
}
export const GenderSchema = v.enum_(Gender);

export enum GreenCertification {
  ENERGY_STAR = "ENERGY_STAR",
  LEED = "LEED",
  WELL = "WELL",
  BREEAM = "BREEAM",
  GREEN_GLOBES = "GREEN_GLOBES"
}
export const GreenCertificationSchema = v.enum_(GreenCertification);

export enum HashtagType {
  GENERAL = "GENERAL",
  PROPERTY = "PROPERTY",
  AGENT = "AGENT"
}
export const HashtagTypeSchema = v.enum_(HashtagType);

export enum HeatingType {
  FORCED_AIR = "FORCED_AIR",
  RADIANT = "RADIANT",
  ELECTRIC = "ELECTRIC",
  GAS = "GAS",
  OIL = "OIL",
  HEAT_PUMP = "HEAT_PUMP",
  GEOTHERMAL = "GEOTHERMAL"
}
export const HeatingTypeSchema = v.enum_(HeatingType);

export enum IncreaseStatus {
  PENDING = "PENDING",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
  WITHDRAWN = "WITHDRAWN"
}
export const IncreaseStatusSchema = v.enum_(IncreaseStatus);

export enum JobStatus {
  PENDING = "PENDING",
  RUNNING = "RUNNING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED"
}
export const JobStatusSchema = v.enum_(JobStatus);

export enum LocationAmenities {
  CITY_CENTER = "CITY_CENTER",
  BEACH = "BEACH",
  PARK = "PARK",
  SHOPPING_MALL = "SHOPPING_MALL",
  HOSPITAL = "HOSPITAL",
  SCHOOL = "SCHOOL",
  UNIVERSITY = "UNIVERSITY",
  POLICE_STATION = "POLICE_STATION",
  FIRE_STATION = "FIRE_STATION",
  PUBLIC_TRANSPORT = "PUBLIC_TRANSPORT",
  SUBWAY_STATION = "SUBWAY_STATION",
  BUS_STOP = "BUS_STOP",
  AIRPORT = "AIRPORT",
  RESTAURANT_DISTRICT = "RESTAURANT_DISTRICT",
  ENTERTAINMENT_ZONE = "ENTERTAINMENT_ZONE",
  BUSINESS_DISTRICT = "BUSINESS_DISTRICT",
  CULTURAL_CENTER = "CULTURAL_CENTER",
  MUSEUM = "MUSEUM",
  LIBRARY = "LIBRARY",
  SPORTS_COMPLEX = "SPORTS_COMPLEX"
}
export const LocationAmenitiesSchema = v.enum_(LocationAmenities);

export enum MentionType {
  USER = "USER",
  PROPERTY = "PROPERTY",
  TASK = "TASK"
}
export const MentionTypeSchema = v.enum_(MentionType);

export enum MortgageStatus {
  ACTIVE = "ACTIVE",
  PAID = "PAID",
  DEFAULTED = "DEFAULTED",
  CANCELLED = "CANCELLED"
}
export const MortgageStatusSchema = v.enum_(MortgageStatus);

export enum NotificationType {
  MENTION = "MENTION",
  TASK_ASSIGNED = "TASK_ASSIGNED",
  BOOKING_CONFIRMED = "BOOKING_CONFIRMED",
  REVIEW_RECEIVED = "REVIEW_RECEIVED",
  PRICE_CHANGE = "PRICE_CHANGE",
  SYSTEM_UPDATE = "SYSTEM_UPDATE",
  COMPLIANCE_ALERT = "COMPLIANCE_ALERT",
  COMMUNICATION_RECEIVED = "COMMUNICATION_RECEIVED",
  RENT_DUE = "RENT_DUE",
  RENT_PAID = "RENT_PAID",
  LEASE_EXPIRING = "LEASE_EXPIRING",
  MAINTENANCE_REQUEST = "MAINTENANCE_REQUEST",
  LEASE_RENEWAL = "LEASE_RENEWAL",
  LATE_PAYMENT_WARNING = "LATE_PAYMENT_WARNING",
  LEASE_TERMINATION = "LEASE_TERMINATION",
  RENT_INCREASE = "RENT_INCREASE",
  COMMUNITY_NOTICE = "COMMUNITY_NOTICE",
  POLICY_UPDATE = "POLICY_UPDATE",
  LIKE = "LIKE",
  COMMENT = "COMMENT",
  FOLLOW = "FOLLOW",
  AVAILABILITY = "AVAILABILITY",
  OTHER = "OTHER"
}
export const NotificationTypeSchema = v.enum_(NotificationType);

export enum OfferStatus {
  PENDING = "PENDING",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
  EXPIRED = "EXPIRED",
  CANCELLED = "CANCELLED"
}
export const OfferStatusSchema = v.enum_(OfferStatus);

export enum OfferType {
  STANDARD = "STANDARD",
  PROMOTIONAL = "PROMOTIONAL",
  LAST_MINUTE = "LAST_MINUTE",
  GROUP = "GROUP",
  EXTENDED_STAY = "EXTENDED_STAY"
}
export const OfferTypeSchema = v.enum_(OfferType);

export enum OwnershipCategory {
  PERSONAL = "PERSONAL",
  COMPANY = "COMPANY",
  BANK = "BANK",
  CONSTRUCTION_COMPANY = "CONSTRUCTION_COMPANY",
  INVESTMENT_FUND = "INVESTMENT_FUND",
  GOVERNMENT = "GOVERNMENT",
  TRUST = "TRUST"
}
export const OwnershipCategorySchema = v.enum_(OwnershipCategory);

export enum OwnershipType {
  FREEHOLD = "FREEHOLD",
  LEASEHOLD = "LEASEHOLD",
  COMMONHOLD = "COMMONHOLD",
  COOPERATIVE = "COOPERATIVE",
  TIMESHARE = "TIMESHARE",
  FRACTIONAL = "FRACTIONAL"
}
export const OwnershipTypeSchema = v.enum_(OwnershipType);

export enum ParkingType {
  STREET = "STREET",
  DRIVEWAY = "DRIVEWAY",
  GARAGE = "GARAGE",
  CARPORT = "CARPORT",
  UNDERGROUND = "UNDERGROUND",
  ASSIGNED_PARKING = "ASSIGNED_PARKING"
}
export const ParkingTypeSchema = v.enum_(ParkingType);

export enum PaymentMethod {
  CASH = "CASH",
  BANK_TRANSFER = "BANK_TRANSFER",
  CREDIT_CARD = "CREDIT_CARD",
  DEBIT_CARD = "DEBIT_CARD",
  PAYPAL = "PAYPAL",
  STRIPE = "STRIPE",
  CHECK = "CHECK",
  MONEY_ORDER = "MONEY_ORDER",
  CRYPTO = "CRYPTO",
  OTHER = "OTHER"
}
export const PaymentMethodSchema = v.enum_(PaymentMethod);

export enum PermissionLevel {
  READ = "READ",
  WRITE = "WRITE",
  ADMIN = "ADMIN"
}
export const PermissionLevelSchema = v.enum_(PermissionLevel);

export enum PhotoType {
  COVER = "COVER",
  GALLERY = "GALLERY",
  PROFILE = "PROFILE",
  DOCUMENT = "DOCUMENT",
  INTERIOR = "INTERIOR",
  EXTERIOR = "EXTERIOR",
  AERIAL = "AERIAL",
  FLOOR_PLAN = "FLOOR_PLAN"
}
export const PhotoTypeSchema = v.enum_(PhotoType);

export enum PricingRuleType {
  SEASONAL = "SEASONAL",
  LONG_TERM = "LONG_TERM",
  EARLY_BOOKING = "EARLY_BOOKING",
  LAST_MINUTE = "LAST_MINUTE",
  SPECIAL_EVENT = "SPECIAL_EVENT"
}
export const PricingRuleTypeSchema = v.enum_(PricingRuleType);

export enum ProjectAnalysisType {
  ARCHITECT = "ARCHITECT",
  DATA_SCIENTIST = "DATA_SCIENTIST",
  BUSINESS_ANALYST = "BUSINESS_ANALYST",
  SECURITY_EXPERT = "SECURITY_EXPERT",
  PERFORMANCE_EXPERT = "PERFORMANCE_EXPERT",
  QA_SPECIALIST = "QA_SPECIALIST",
  UX_DESIGNER = "UX_DESIGNER",
  MOBILE_DEVELOPER = "MOBILE_DEVELOPER",
  DEVOPS_ENGINEER = "DEVOPS_ENGINEER"
}
export const ProjectAnalysisTypeSchema = v.enum_(ProjectAnalysisType);

export enum ProjectModelType {
  INVESTMENT_SCORE = "INVESTMENT_SCORE",
  LOCATION_SCORE = "LOCATION_SCORE",
  PRICE_PREDICTION = "PRICE_PREDICTION",
  AMENITIES_SCORE = "AMENITIES_SCORE",
  MARKET_ANALYSIS = "MARKET_ANALYSIS",
  TREND_PREDICTION = "TREND_PREDICTION"
}
export const ProjectModelTypeSchema = v.enum_(ProjectModelType);

export enum ProjectReportType {
  DAILY = "DAILY",
  WEEKLY = "WEEKLY",
  MONTHLY = "MONTHLY",
  QUARTERLY = "QUARTERLY",
  YEARLY = "YEARLY",
  CUSTOM = "CUSTOM"
}
export const ProjectReportTypeSchema = v.enum_(ProjectReportType);

export enum ProjectStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  DEVELOPMENT = "DEVELOPMENT",
  RENOVATION = "RENOVATION",
  COMPLETED = "COMPLETED",
  CANCELLED = "CANCELLED"
}
export const ProjectStatusSchema = v.enum_(ProjectStatus);

export enum ProjectTaskStatus {
  PENDING = "PENDING",
  RUNNING = "RUNNING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED"
}
export const ProjectTaskStatusSchema = v.enum_(ProjectTaskStatus);

export enum ProjectTaskType {
  SCRAPING = "SCRAPING",
  ANALYSIS = "ANALYSIS",
  MONITORING = "MONITORING",
  REPORTING = "REPORTING",
  OPTIMIZATION = "OPTIMIZATION",
  VALIDATION = "VALIDATION",
  BENCHMARKING = "BENCHMARKING"
}
export const ProjectTaskTypeSchema = v.enum_(ProjectTaskType);

export enum ProjectType {
  RESIDENTIAL = "RESIDENTIAL",
  COMMERCIAL = "COMMERCIAL",
  APARTMENT_BUILDING = "APARTMENT_BUILDING",
  MIXED_USE_COMPLEX = "MIXED_USE_COMPLEX"
}
export const ProjectTypeSchema = v.enum_(ProjectType);

export enum PropertyAmenities {
  POOL = "POOL",
  GYM = "GYM",
  GARDEN = "GARDEN",
  PARKING = "PARKING",
  SECURITY = "SECURITY",
  ELEVATOR = "ELEVATOR",
  STORAGE = "STORAGE",
  BALCONY = "BALCONY",
  TERRACE = "TERRACE",
  AIR_CONDITIONING = "AIR_CONDITIONING",
  HEATING = "HEATING",
  WIFI = "WIFI",
  SAUNA = "SAUNA",
  JACUZZI = "JACUZZI",
  FIREPLACE = "FIREPLACE",
  BBQ = "BBQ",
  PET_FRIENDLY = "PET_FRIENDLY",
  WHEELCHAIR_ACCESS = "WHEELCHAIR_ACCESS",
  LAUNDRY = "LAUNDRY",
  DISHWASHER = "DISHWASHER",
  SMART_HOME = "SMART_HOME",
  SOLAR_PANELS = "SOLAR_PANELS",
  CONCIERGE = "CONCIERGE",
  PLAYGROUND = "PLAYGROUND",
  TENNIS_COURT = "TENNIS_COURT",
  BASKETBALL_COURT = "BASKETBALL_COURT",
  CINEMA_ROOM = "CINEMA_ROOM",
  GAME_ROOM = "GAME_ROOM",
  ROOFTOP = "ROOFTOP",
  SEA_VIEW = "SEA_VIEW",
  MOUNTAIN_VIEW = "MOUNTAIN_VIEW",
  CITY_VIEW = "CITY_VIEW"
}
export const PropertyAmenitiesSchema = v.enum_(PropertyAmenities);

export enum PropertyCondition {
  EXCELLENT = "EXCELLENT",
  GOOD = "GOOD",
  FAIR = "FAIR",
  NEEDS_RENOVATION = "NEEDS_RENOVATION",
  UNDER_CONSTRUCTION = "UNDER_CONSTRUCTION"
}
export const PropertyConditionSchema = v.enum_(PropertyCondition);

export enum PropertyFeatures {
  FURNISHED = "FURNISHED",
  PARTIALLY_FURNISHED = "PARTIALLY_FURNISHED",
  UNFURNISHED = "UNFURNISHED",
  OPEN_FLOOR_PLAN = "OPEN_FLOOR_PLAN",
  HIGH_CEILING = "HIGH_CEILING",
  BALCONY = "BALCONY",
  TERRACE = "TERRACE",
  GARDEN = "GARDEN",
  SEA_VIEW = "SEA_VIEW",
  MOUNTAIN_VIEW = "MOUNTAIN_VIEW",
  CITY_VIEW = "CITY_VIEW",
  SMART_HOME = "SMART_HOME",
  ENERGY_EFFICIENT = "ENERGY_EFFICIENT",
  SOLAR_PANELS = "SOLAR_PANELS",
  EARTHQUAKE_RESISTANT = "EARTHQUAKE_RESISTANT",
  SOUNDPROOF = "SOUNDPROOF",
  WHEELCHAIR_ACCESSIBLE = "WHEELCHAIR_ACCESSIBLE",
  PET_FRIENDLY = "PET_FRIENDLY",
  HOME_OFFICE = "HOME_OFFICE",
  WALK_IN_CLOSET = "WALK_IN_CLOSET"
}
export const PropertyFeaturesSchema = v.enum_(PropertyFeatures);

export enum PropertyPromotionStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  EXPIRED = "EXPIRED",
  PENDING = "PENDING",
  CANCELLED = "CANCELLED"
}
export const PropertyPromotionStatusSchema = v.enum_(PropertyPromotionStatus);

export enum PropertyPromotionType {
  FEATURED = "FEATURED",
  URGENT = "URGENT",
  PRICE_REDUCED = "PRICE_REDUCED",
  BEST_DEAL = "BEST_DEAL"
}
export const PropertyPromotionTypeSchema = v.enum_(PropertyPromotionType);

export enum PropertyStatus {
  AVAILABLE = "AVAILABLE",
  UNDER_CONTRACT = "UNDER_CONTRACT",
  SOLD = "SOLD",
  RENTED = "RENTED",
  PENDING_APPROVAL = "PENDING_APPROVAL",
  OFF_MARKET = "OFF_MARKET",
  MAINTENANCE = "MAINTENANCE",
  FORECLOSURE = "FORECLOSURE"
}
export const PropertyStatusSchema = v.enum_(PropertyStatus);

export enum RecurringFrequency {
  MONTHLY = "MONTHLY",
  QUARTERLY = "QUARTERLY",
  YEARLY = "YEARLY",
  CUSTOM = "CUSTOM"
}
export const RecurringFrequencySchema = v.enum_(RecurringFrequency);

export enum ReportStatus {
  GENERATED = "GENERATED",
  IN_PROGRESS = "IN_PROGRESS",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  ARCHIVED = "ARCHIVED",
  PENDING = "PENDING",
  SUBMITTED = "SUBMITTED",
  ACCEPTED = "ACCEPTED",
  REJECTED = "REJECTED",
  MANUAL_SUBMISSION = "MANUAL_SUBMISSION"
}
export const ReportStatusSchema = v.enum_(ReportStatus);

export enum ReportType {
  FINANCIAL = "FINANCIAL",
  PERFORMANCE = "PERFORMANCE",
  COMPLIANCE = "COMPLIANCE",
  MARKET_ANALYSIS = "MARKET_ANALYSIS",
  REVENUE = "REVENUE",
  OCCUPANCY = "OCCUPANCY",
  GUEST_ANALYSIS = "GUEST_ANALYSIS",
  OFFER_PERFORMANCE = "OFFER_PERFORMANCE",
  RESERVATION_SUMMARY = "RESERVATION_SUMMARY",
  EXPENSE_TRACKING = "EXPENSE_TRACKING",
  TASK_MANAGEMENT = "TASK_MANAGEMENT",
  PROPERTY_PERFORMANCE = "PROPERTY_PERFORMANCE"
}
export const ReportTypeSchema = v.enum_(ReportType);

export enum ReservationStatus {
  PENDING = "PENDING",
  CONFIRMED = "CONFIRMED",
  CANCELLED = "CANCELLED",
  COMPLETED = "COMPLETED",
  REFUNDED = "REFUNDED"
}
export const ReservationStatusSchema = v.enum_(ReservationStatus);

export enum ReviewType {
  PROPERTY = "PROPERTY",
  AGENT = "AGENT",
  AGENCY = "AGENCY",
  SERVICE = "SERVICE"
}
export const ReviewTypeSchema = v.enum_(ReviewType);

export enum SharedAmenityType {
  SWIMMING_POOL = "SWIMMING_POOL",
  INDOOR_POOL = "INDOOR_POOL",
  OUTDOOR_POOL = "OUTDOOR_POOL",
  KIDS_POOL = "KIDS_POOL",
  FITNESS_CENTER = "FITNESS_CENTER",
  GYM = "GYM",
  SPA = "SPA",
  SAUNA = "SAUNA",
  TENNIS_COURT = "TENNIS_COURT",
  BASKETBALL_COURT = "BASKETBALL_COURT",
  FOOTBALL_FIELD = "FOOTBALL_FIELD",
  CHILDREN_PLAYGROUND = "CHILDREN_PLAYGROUND",
  PARK = "PARK",
  GARDEN = "GARDEN",
  TERRACE = "TERRACE",
  ROOFTOP = "ROOFTOP",
  CONCIERGE = "CONCIERGE",
  SECURITY = "SECURITY",
  PARKING = "PARKING",
  ELEVATOR = "ELEVATOR",
  LIBRARY = "LIBRARY",
  MEETING_ROOM = "MEETING_ROOM",
  EVENT_HALL = "EVENT_HALL",
  CAFE = "CAFE",
  RESTAURANT = "RESTAURANT",
  MARKET = "MARKET",
  PHARMACY = "PHARMACY",
  MEDICAL_CENTER = "MEDICAL_CENTER",
  SHUTTLE_SERVICE = "SHUTTLE_SERVICE",
  CLEANING_SERVICE = "CLEANING_SERVICE",
  MAINTENANCE_SERVICE = "MAINTENANCE_SERVICE"
}
export const SharedAmenityTypeSchema = v.enum_(SharedAmenityType);

export enum SharedStatus {
  PENDING = "PENDING",
  ACTIVE = "ACTIVE",
  SUSPENDED = "SUSPENDED"
}
export const SharedStatusSchema = v.enum_(SharedStatus);

export enum SubscriptionTier {
  TRIAL = "TRIAL",
  SILVER = "SILVER",
  STARTER = "STARTER",
  GOLD = "GOLD",
  PROFESSIONAL = "PROFESSIONAL",
  PRO = "PRO",
  DIAMOND = "DIAMOND",
  BASIC = "BASIC",
  ENTERPRISE = "ENTERPRISE"
}
export const SubscriptionTierSchema = v.enum_(SubscriptionTier);

export enum TaskCategory {
  CLEANING = "CLEANING",
  REPAIR = "REPAIR",
  DECORATION = "DECORATION",
  SERVICE = "SERVICE",
  MOVING = "MOVING"
}
export const TaskCategorySchema = v.enum_(TaskCategory);

export enum TaskLabel {
  CLEANING = "CLEANING",
  DOOR = "DOOR",
  WINDOW = "WINDOW",
  ELECTRICITY = "ELECTRICITY",
  PLUMPING = "PLUMPING",
  ROOF = "ROOF",
  GATES = "GATES",
  FURNITURE = "FURNITURE",
  WARDROBE = "WARDROBE"
}
export const TaskLabelSchema = v.enum_(TaskLabel);

export enum TaskPriority {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  URGENT = "URGENT"
}
export const TaskPrioritySchema = v.enum_(TaskPriority);

export enum TaxStatus {
  PENDING = "PENDING",
  PAID = "PAID",
  OVERDUE = "OVERDUE",
  CANCELLED = "CANCELLED",
  DISPUTED = "DISPUTED",
  PARTIALLY_PAID = "PARTIALLY_PAID",
  WAIVED = "WAIVED",
  EXTENDED = "EXTENDED"
}
export const TaxStatusSchema = v.enum_(TaxStatus);

export enum TaxType {
  PROPERTY_TAX = "PROPERTY_TAX",
  INCOME_TAX = "INCOME_TAX",
  SALES_TAX = "SALES_TAX",
  OCCUPANCY_TAX = "OCCUPANCY_TAX",
  CITY_TAX = "CITY_TAX",
  STATE_TAX = "STATE_TAX",
  FEDERAL_TAX = "FEDERAL_TAX",
  UTILITY_TAX = "UTILITY_TAX",
  MAINTENANCE_TAX = "MAINTENANCE_TAX",
  LUXURY_TAX = "LUXURY_TAX",
  TRANSFER_TAX = "TRANSFER_TAX",
  STAMP_DUTY = "STAMP_DUTY",
  VAT = "VAT",
  MUNICIPALITY_TAX = "MUNICIPALITY_TAX",
  COMMISSION_TAX = "COMMISSION_TAX",
  AGENCY_TAX = "AGENCY_TAX",
  AGENT_TAX = "AGENT_TAX",
  OTHER = "OTHER"
}
export const TaxTypeSchema = v.enum_(TaxType);

export enum TicketStatus {
  OPEN = "OPEN",
  IN_PROGRESS = "IN_PROGRESS",
  RESOLVED = "RESOLVED",
  CLOSED = "CLOSED",
  ARCHIVED = "ARCHIVED"
}
export const TicketStatusSchema = v.enum_(TicketStatus);

export enum UnitStatus {
  AVAILABLE = "AVAILABLE",
  OCCUPIED = "OCCUPIED",
  MAINTENANCE = "MAINTENANCE",
  RENOVATION = "RENOVATION",
  RESERVED = "RESERVED",
  SOLD = "SOLD",
  RENTED = "RENTED"
}
export const UnitStatusSchema = v.enum_(UnitStatus);

export enum UnitType {
  STUDIO = "STUDIO",
  ONE_PLUS_ONE = "ONE_PLUS_ONE",
  TWO_PLUS_ONE = "TWO_PLUS_ONE",
  THREE_PLUS_ONE = "THREE_PLUS_ONE",
  FOUR_PLUS_ONE = "FOUR_PLUS_ONE",
  FIVE_PLUS_ONE = "FIVE_PLUS_ONE",
  PENTHOUSE = "PENTHOUSE",
  DUPLEX = "DUPLEX",
  TRIPLEX = "TRIPLEX",
  VILLA = "VILLA",
  COMMERCIAL_UNIT = "COMMERCIAL_UNIT",
  OFFICE_UNIT = "OFFICE_UNIT",
  RETAIL_UNIT = "RETAIL_UNIT"
}
export const UnitTypeSchema = v.enum_(UnitType);

export enum UserStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  SUSPENDED = "SUSPENDED"
}
export const UserStatusSchema = v.enum_(UserStatus);

export enum OwnershipVerificationStatus {
  PENDING = "PENDING",
  VERIFIED = "VERIFIED",
  REJECTED = "REJECTED",
  EXPIRED = "EXPIRED",
  SUSPENDED = "SUSPENDED"
}
export const OwnershipVerificationStatusSchema = v.enum_(OwnershipVerificationStatus);

export enum OwnershipDocumentType {
  DEED = "DEED",
  TITLE_DEED = "TITLE_DEED",
  PROPERTY_TAX_RECORD = "PROPERTY_TAX_RECORD",
  MORTGAGE_STATEMENT = "MORTGAGE_STATEMENT",
  INSURANCE_POLICY = "INSURANCE_POLICY",
  UTILITY_BILL = "UTILITY_BILL",
  HOA_DOCUMENT = "HOA_DOCUMENT",
  COURT_ORDER = "COURT_ORDER",
  INHERITANCE_DOCUMENT = "INHERITANCE_DOCUMENT",
  TRUST_DOCUMENT = "TRUST_DOCUMENT",
  CORPORATE_RESOLUTION = "CORPORATE_RESOLUTION",
  POWER_OF_ATTORNEY = "POWER_OF_ATTORNEY",
  OTHER = "OTHER"
}
export const OwnershipDocumentTypeSchema = v.enum_(OwnershipDocumentType);

export enum VerificationMethod {
  DOCUMENT_UPLOAD = "DOCUMENT_UPLOAD",
  BLOCKCHAIN_VERIFICATION = "BLOCKCHAIN_VERIFICATION",
  GOVERNMENT_API = "GOVERNMENT_API",
  THIRD_PARTY_SERVICE = "THIRD_PARTY_SERVICE",
  MANUAL_REVIEW = "MANUAL_REVIEW",
  AI_VERIFICATION = "AI_VERIFICATION"
}
export const VerificationMethodSchema = v.enum_(VerificationMethod);

export enum SecurityScreeningStatus {
  PENDING = "PENDING",
  CLEARED = "CLEARED",
  REJECTED = "REJECTED",
  MANUAL_REVIEW_REQUIRED = "MANUAL_REVIEW_REQUIRED",
  EXPIRED = "EXPIRED"
}
export const SecurityScreeningStatusSchema = v.enum_(SecurityScreeningStatus);

export enum SecurityRiskLevel {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  CRITICAL = "CRITICAL"
}
export const SecurityRiskLevelSchema = v.enum_(SecurityRiskLevel);

export enum VendorTier {
  BASIC = "BASIC",
  PROFESSIONAL = "PROFESSIONAL",
  ENTERPRISE = "ENTERPRISE",
  PREMIUM = "PREMIUM"
}
export const VendorTierSchema = v.enum_(VendorTier);

export enum VideoQuality {
  STANDARD = "STANDARD",
  HIGH = "HIGH",
  ULTRA = "ULTRA",
  CINEMATIC = "CINEMATIC"
}
export const VideoQualitySchema = v.enum_(VideoQuality);

export enum VendorStatus {
  PENDING = "PENDING",
  APPROVED = "APPROVED",
  ACTIVE = "ACTIVE",
  SUSPENDED = "SUSPENDED",
  TERMINATED = "TERMINATED"
}
export const VendorStatusSchema = v.enum_(VendorStatus);

export enum ValuationStatus {
  PENDING = "PENDING",
  PROCESSING = "PROCESSING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  EXPIRED = "EXPIRED"
}
export const ValuationStatusSchema = v.enum_(ValuationStatus);

export enum ValuationType {
  BASIC = "BASIC",
  PROFESSIONAL = "PROFESSIONAL",
  ENTERPRISE = "ENTERPRISE",
  INSTANT = "INSTANT",
  DETAILED = "DETAILED"
}
export const ValuationTypeSchema = v.enum_(ValuationType);

export enum ConfidenceLevel {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  VERY_HIGH = "VERY_HIGH"
}
export const ConfidenceLevelSchema = v.enum_(ConfidenceLevel);

export enum LegalComplianceStatus {
  UNVERIFIED = "UNVERIFIED",
  PENDING = "PENDING",
  VERIFIED = "VERIFIED",
  EXPIRED = "EXPIRED",
  REVOKED = "REVOKED",
  BLOCKLISTED = "BLOCKLISTED"
}
export const LegalComplianceStatusSchema = v.enum_(LegalComplianceStatus);

export enum SmartLockStatus {
  ONLINE = "ONLINE",
  OFFLINE = "OFFLINE",
  LOCKED = "LOCKED",
  UNLOCKED = "UNLOCKED",
  LOW_BATTERY = "LOW_BATTERY",
  JAMMED = "JAMMED",
  UNAUTHORIZED_ACCESS = "UNAUTHORIZED_ACCESS"
}
export const SmartLockStatusSchema = v.enum_(SmartLockStatus);

export enum SmartLockBrand {
  AUGUST = "AUGUST",
  SCHLAGE = "SCHLAGE",
  YALE = "YALE",
  KWIKSET = "KWIKSET",
  IGLOOHOME = "IGLOOHOME",
  SALTO = "SALTO",
  CUSTOM = "CUSTOM"
}
export const SmartLockBrandSchema = v.enum_(SmartLockBrand);

export enum AccessCodeStatus {
  ACTIVE = "ACTIVE",
  EXPIRED = "EXPIRED",
  REVOKED = "REVOKED",
  SCHEDULED = "SCHEDULED",
  FAILED_SYNC = "FAILED_SYNC"
}
export const AccessCodeStatusSchema = v.enum_(AccessCodeStatus);

export enum AccessMethod {
  PIN_CODE = "PIN_CODE",
  BLUETOOTH = "BLUETOOTH",
  REMOTE_COMMAND = "REMOTE_COMMAND",
  KEY_TURN = "KEY_TURN",
  RFID_NFC = "RFID_NFC",
  FINGERPRINT = "FINGERPRINT",
  ONE_TIME_PASSWORD = "ONE_TIME_PASSWORD"
}
export const AccessMethodSchema = v.enum_(AccessMethod);

export enum AccessEvent {
  LOCK = "LOCK",
  UNLOCK = "UNLOCK",
  TAMPER = "TAMPER",
  MANUAL_LOCKED = "MANUAL_LOCKED",
  MANUAL_UNLOCKED = "MANUAL_UNLOCKED",
  LOW_BATTERY_ALERT = "LOW_BATTERY_ALERT",
  CONNECTION_LOST = "CONNECTION_LOST"
}
export const AccessEventSchema = v.enum_(AccessEvent);

export enum CommissionStatus {
  PENDING = "PENDING",
  CALCULATED = "CALCULATED",
  APPROVED = "APPROVED",
  PAID = "PAID",
  CANCELLED = "CANCELLED",
  DISPUTED = "DISPUTED",
  HOLDBACK = "HOLDBACK"
}
export const CommissionStatusSchema = v.enum_(CommissionStatus);

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
  COMPLIANCE_CHECK = "COMPLIANCE_CHECK",
  VIRTUAL_STAGING = "VIRTUAL_STAGING"
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

export enum JPRegion {
  HOKKAIDO = "HOKKAIDO",
  TOHOKU = "TOHOKU",
  KANTO = "KANTO",
  CHUBU = "CHUBU",
  KANSAI = "KANSAI",
  CHUGOKU = "CHUGOKU",
  SHIKOKU = "SHIKOKU",
  KYUSHU = "KYUSHU"
}
export const JPRegionSchema = v.enum_(JPRegion);

export enum JPTaxForm {
  SHOTOKUZEI = "SHOTOKUZEI",
  KOTEI_SHISAN_ZEI = "KOTEI_SHISAN_ZEI",
  TOSHI_KEIKAKU_ZEI = "TOSHI_KEIKAKU_ZEI"
}
export const JPTaxFormSchema = v.enum_(JPTaxForm);

export enum TRHeatingType {
  GUNEŞ_ENERJISI = "GUNEŞ_ENERJISI"
}
export const TRHeatingTypeSchema = v.enum_(TRHeatingType);

export enum MandateStatus {
  PENDING = "PENDING",
  ACTIVE = "ACTIVE",
  REVOKED = "REVOKED",
  EXPIRED = "EXPIRED"
}
export const MandateStatusSchema = v.enum_(MandateStatus);

export enum LockAction {
  LOCK = "LOCK",
  UNLOCK = "UNLOCK",
  SUSPEND = "SUSPEND",
  RESTORE = "RESTORE"
}
export const LockActionSchema = v.enum_(LockAction);

export enum LeaseContractType {
  STANDARD_LEASE = "STANDARD_LEASE",
  MASTER_LEASE = "MASTER_LEASE",
  SUBSCRIPTION = "SUBSCRIPTION"
}
export const LeaseContractTypeSchema = v.enum_(LeaseContractType);

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

// --- MODELS ---
// User Schemas (JP)
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
  gdprConsentAt: v.optional(v.string()),
  ccpaOptOutAt: v.optional(v.string()),
  dataRetentionUntil: v.optional(v.string()),
  anonymizedAt: v.optional(v.string()),
  originRegion: v.optional(v.string()),
  isClone: v.optional(v.boolean()),
  lastSyncedAt: v.optional(v.string())
}));

export type UserCreate = v.InferOutput<typeof userCreateSchema>;
export type UserUpdate = v.InferOutput<typeof userUpdateSchema>;

// Session Schemas (JP)
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

// Organization Schemas (JP)
export const organizationCreateSchema = v.object({
  name: v.string(),
  type: v.enum_(OrgType),
  region: v.enum_(Region),
  requiredInspections: v.enum_(ComplianceType)
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
  managementFeeType: v.optional(v.enum_(ManagementFeeType)),
  managementFeeRate: v.optional(v.number()),
  managementFeeAmount: v.optional(v.number()),
  managementFeeScope: v.optional(v.enum_(ManagementFeeScope)),
  taxReportingEnabled: v.optional(v.boolean()),
  complianceTracking: v.optional(v.boolean()),
  requiredInspections: v.optional(v.enum_(ComplianceType)),
  originRegion: v.optional(v.string()),
  isClone: v.optional(v.boolean()),
  lastSyncedAt: v.optional(v.string())
}));

export type OrganizationCreate = v.InferOutput<typeof organizationCreateSchema>;
export type OrganizationUpdate = v.InferOutput<typeof organizationUpdateSchema>;

// AnalysisJob Schemas (JP)
export const analysisJobCreateSchema = v.object({
  documentId: v.string(),
  orgId: v.string(),
  type: v.string()
});

export const analysisJobUpdateSchema = v.partial(v.object({
  documentId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  status: v.optional(v.string()),
  type: v.optional(v.string()),
  priority: v.optional(v.string()),
  startedAt: v.optional(v.string()),
  completedAt: v.optional(v.string()),
  processingTime: v.optional(v.number()),
  errorMessage: v.optional(v.string()),
  parameters: v.optional(v.unknown())
}));

export type AnalysisJobCreate = v.InferOutput<typeof analysisJobCreateSchema>;
export type AnalysisJobUpdate = v.InferOutput<typeof analysisJobUpdateSchema>;

// DocumentAnalysis Schemas (JP)
export const documentAnalysisCreateSchema = v.object({
  documentId: v.string()
});

export const documentAnalysisUpdateSchema = v.partial(v.object({
  documentId: v.optional(v.string()),
  jobId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  extractedText: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  classification: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  processingTime: v.optional(v.number())
}));

export type DocumentAnalysisCreate = v.InferOutput<typeof documentAnalysisCreateSchema>;
export type DocumentAnalysisUpdate = v.InferOutput<typeof documentAnalysisUpdateSchema>;

// Role Schemas (JP)
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

// Permission Schemas (JP)
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

// RolePermission Schemas (JP)
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

// OrganizationMember Schemas (JP)
export const organizationMemberCreateSchema = v.object({
  userId: v.string(),
  orgId: v.string(),
  roleId: v.string()
});

export const organizationMemberUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  roleId: v.optional(v.string())
}));

export type OrganizationMemberCreate = v.InferOutput<typeof organizationMemberCreateSchema>;
export type OrganizationMemberUpdate = v.InferOutput<typeof organizationMemberUpdateSchema>;

// ApiToken Schemas (JP)
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

// Contact Schemas (JP)
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
  consentGivenAt: v.optional(v.string()),
  consentWithdrawnAt: v.optional(v.string()),
  dataSubjectId: v.optional(v.string()),
  tenantReliabilityScoreId: v.optional(v.string())
}));

export type ContactCreate = v.InferOutput<typeof contactCreateSchema>;
export type ContactUpdate = v.InferOutput<typeof contactUpdateSchema>;

// VendorProfile Schemas (JP)
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

// AgentAssignment Schemas (JP)
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

// Property Schemas (JP)
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
  propertyCategory: v.optional(v.enum_(PropertyCategory)),
  listingType: v.optional(v.enum_(ListingType)),
  listingStatus: v.optional(v.enum_(ListingStatus)),
  listingPrice: v.optional(v.number()),
  originalPrice: v.optional(v.number()),
  priceHistory: v.optional(v.unknown()),
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
  jpCode: v.optional(v.enum_(JPRegion)),
  chibanNumber: v.optional(v.string()),
  koteiShisanZei: v.optional(v.number()),
  kanrihi: v.optional(v.number()),
  unitId: v.optional(v.string()),
  balkonTipi: v.optional(v.string()),
  katKategorisi: v.optional(v.string())
}));

export type PropertyCreate = v.InferOutput<typeof propertyCreateSchema>;
export type PropertyUpdate = v.InferOutput<typeof propertyUpdateSchema>;

// Listing Schemas (JP)
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
  expiresAt: v.optional(v.string()),
  isPromoted: v.optional(v.boolean()),
  promotionTier: v.optional(v.number()),
  promotedUntil: v.optional(v.string()),
  likesCount: v.optional(v.number()),
  createdBy: v.optional(v.string()),
  locationId: v.optional(v.string()),
  categoryId: v.optional(v.string()),
  userId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  agencyId: v.optional(v.string())
}));

export type ListingCreate = v.InferOutput<typeof listingCreateSchema>;
export type ListingUpdate = v.InferOutput<typeof listingUpdateSchema>;

// ListingStatusHistory Schemas (JP)
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

// Tag Schemas (JP)
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

// ListingTag Schemas (JP)
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

// Booking Schemas (JP)
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
  propertyId: v.optional(v.string()),
  ownershipVerificationId: v.optional(v.string()),
  status: v.optional(v.enum_(BookingStatus)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  adults: v.optional(v.number()),
  children: v.optional(v.number()),
  priceTotal: v.optional(v.number()),
  currency: v.optional(v.string()),
  paymentStatus: v.optional(v.enum_(PaymentStatus)),
  notes: v.optional(v.string()),
  ownershipVerified: v.optional(v.boolean()),
  verificationRequired: v.optional(v.boolean()),
  verificationStatus: v.optional(v.string()),
  verifiedAt: v.optional(v.string()),
  verificationExpiresAt: v.optional(v.string()),
  riskScore: v.optional(v.number()),
  fraudFlags: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type BookingCreate = v.InferOutput<typeof bookingCreateSchema>;
export type BookingUpdate = v.InferOutput<typeof bookingUpdateSchema>;

// MaintenanceBlock Schemas (JP)
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

// Lease Schemas (JP)
export const leaseCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string(),
  tenantId: v.string(),
  startDate: v.string(),
  endDate: v.string(),
  rent: v.number()
});

export const leaseUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  status: v.optional(v.enum_(LeaseStatus)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  rent: v.optional(v.number()),
  currency: v.optional(v.string()),
  deposit: v.optional(v.number()),
  rentDueDay: v.optional(v.number()),
  notes: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string()),
  contractType: v.optional(v.enum_(LeaseContractType)),
  isUtilityManaged: v.optional(v.boolean()),
  smartLockId: v.optional(v.string()),
  autoEvictionEnabled: v.optional(v.boolean()),
  vrpPenaltyRate: v.optional(v.number()),
  evictionUndertakingDate: v.optional(v.string())
}));

export type LeaseCreate = v.InferOutput<typeof leaseCreateSchema>;
export type LeaseUpdate = v.InferOutput<typeof leaseUpdateSchema>;

// RentSchedule Schemas (JP)
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

// FinancialRecord Schemas (JP)
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
  billData: v.optional(v.unknown()),
  category: v.optional(v.string()),
  description: v.optional(v.string()),
  notes: v.optional(v.string()),
  paymentStatus: v.optional(v.enum_(PaymentStatus)),
  paidAt: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type FinancialRecordCreate = v.InferOutput<typeof financialRecordCreateSchema>;
export type FinancialRecordUpdate = v.InferOutput<typeof financialRecordUpdateSchema>;

// TaxRecord Schemas (JP)
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
  profileData: v.optional(v.unknown()),
  categoryData: v.optional(v.unknown()),
  lineItemData: v.optional(v.unknown()),
  auditData: v.optional(v.unknown()),
  ruleData: v.optional(v.unknown()),
  depreciationData: v.optional(v.unknown()),
  form1099Data: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type TaxRecordCreate = v.InferOutput<typeof taxRecordCreateSchema>;
export type TaxRecordUpdate = v.InferOutput<typeof taxRecordUpdateSchema>;

// Attachment Schemas (JP)
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

// LedgerEntry Schemas (JP)
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

// ExchangeRate Schemas (JP)
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

// ExportJob Schemas (JP)
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

// ExportFile Schemas (JP)
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

// GovernmentIntegration Schemas (JP)
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

// Lead Schemas (JP)
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

// LeadSource Schemas (JP)
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

// Location Schemas (JP)
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
  stateName: v.optional(v.string()),
  stateFIPS: v.optional(v.string()),
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
  createdBy: v.optional(v.string())
}));

export type LocationCreate = v.InferOutput<typeof locationCreateSchema>;
export type LocationUpdate = v.InferOutput<typeof locationUpdateSchema>;

// Deal Schemas (JP)
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

// Document Schemas (JP)
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
  analysisStatus: v.optional(v.string()),
  lastAnalyzedAt: v.optional(v.string()),
  analysisJobId: v.optional(v.string()),
  duplicates: v.optional(v.unknown()),
  searchVector: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type DocumentCreate = v.InferOutput<typeof documentCreateSchema>;
export type DocumentUpdate = v.InferOutput<typeof documentUpdateSchema>;

// Payout Schemas (JP)
export const payoutCreateSchema = v.object({
  orgId: v.string(),
  payoutType: v.enum_(CommissionTypeUS),
  amount: v.number(),
  grossAmount: v.number(),
  netAmount: v.number(),
  paymentMethod: v.enum_(PaymentMethodUS)
});

export const payoutUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  commissionId: v.optional(v.string()),
  recipientId: v.optional(v.string()),
  processorId: v.optional(v.string()),
  payoutStatus: v.optional(v.enum_(PayoutStatusUSA)),
  payoutType: v.optional(v.enum_(CommissionTypeUS)),
  amount: v.optional(v.number()),
  grossAmount: v.optional(v.number()),
  netAmount: v.optional(v.number()),
  taxWithheld: v.optional(v.number()),
  fees: v.optional(v.number()),
  paymentMethod: v.optional(v.enum_(PaymentMethodUS)),
  scheduledDate: v.optional(v.string()),
  processedDate: v.optional(v.string()),
  completedDate: v.optional(v.string()),
  referenceNumber: v.optional(v.string()),
  trackingNumber: v.optional(v.string()),
  bankAccount: v.optional(v.unknown()),
  checkNumber: v.optional(v.string()),
  wireReference: v.optional(v.string()),
  achRouting: v.optional(v.string()),
  escrowReleaseDate: v.optional(v.string()),
  holdReason: v.optional(v.string()),
  failureReason: v.optional(v.string()),
  retryCount: v.optional(v.number()),
  maxRetries: v.optional(v.number()),
  nextRetryDate: v.optional(v.string()),
  priority: v.optional(v.string()),
  approvalRequired: v.optional(v.boolean()),
  approvedBy: v.optional(v.string()),
  approvedAt: v.optional(v.string()),
  notes: v.optional(v.string()),
  taxFormGenerated: v.optional(v.boolean()),
  taxFormSent: v.optional(v.boolean()),
  yearEndReport: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type PayoutCreate = v.InferOutput<typeof payoutCreateSchema>;
export type PayoutUpdate = v.InferOutput<typeof payoutUpdateSchema>;

// MapLayer Schemas (JP)
export const mapLayerCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.string(),
  provider: v.enum_(MapProvider)
});

export const mapLayerUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.string()),
  provider: v.optional(v.enum_(MapProvider)),
  url: v.optional(v.string()),
  config: v.optional(v.unknown()),
  isVisible: v.optional(v.boolean()),
  opacity: v.optional(v.number()),
  zIndex: v.optional(v.number()),
  northEastLat: v.optional(v.number()),
  northEastLng: v.optional(v.number()),
  southWestLat: v.optional(v.number()),
  southWestLng: v.optional(v.number()),
  centerLat: v.optional(v.number()),
  centerLng: v.optional(v.number()),
  zoomLevel: v.optional(v.number()),
  minZoom: v.optional(v.number()),
  maxZoom: v.optional(v.number()),
  fillColor: v.optional(v.string()),
  strokeColor: v.optional(v.string()),
  strokeWidth: v.optional(v.number()),
  fillOpacity: v.optional(v.number()),
  createdBy: v.optional(v.string())
}));

export type MapLayerCreate = v.InferOutput<typeof mapLayerCreateSchema>;
export type MapLayerUpdate = v.InferOutput<typeof mapLayerUpdateSchema>;

// Route Schemas (JP)
export const routeCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.string(),
  startLocationId: v.string(),
  endLocationId: v.string(),
  provider: v.enum_(MapProvider)
});

export const routeUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.string()),
  startLocationId: v.optional(v.string()),
  endLocationId: v.optional(v.string()),
  waypoints: v.optional(v.unknown()),
  distance: v.optional(v.number()),
  duration: v.optional(v.number()),
  polyline: v.optional(v.string()),
  provider: v.optional(v.enum_(MapProvider)),
  instructions: v.optional(v.unknown()),
  trafficData: v.optional(v.unknown()),
  tolls: v.optional(v.number()),
  isVisible: v.optional(v.boolean()),
  color: v.optional(v.string()),
  strokeWidth: v.optional(v.number()),
  opacity: v.optional(v.number()),
  createdBy: v.optional(v.string())
}));

export type RouteCreate = v.InferOutput<typeof routeCreateSchema>;
export type RouteUpdate = v.InferOutput<typeof routeUpdateSchema>;

// ApiIntegration Schemas (JP)
export const apiIntegrationCreateSchema = v.object({
  orgId: v.string()
});

export const apiIntegrationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  platform: v.optional(v.enum_(RentalPlatform)),
  name: v.optional(v.string()),
  providerName: v.optional(v.string()),
  integrationType: v.optional(v.string()),
  isEnabled: v.optional(v.boolean()),
  status: v.optional(v.string()),
  apiKey: v.optional(v.string()),
  apiSecret: v.optional(v.string()),
  apiKeyCiphertext: v.optional(v.string()),
  apiSecretCiphertext: v.optional(v.string()),
  accessToken: v.optional(v.string()),
  refreshToken: v.optional(v.string()),
  accessTokenCiphertext: v.optional(v.string()),
  refreshTokenCiphertext: v.optional(v.string()),
  tokenExpiry: v.optional(v.string()),
  baseUrl: v.optional(v.string()),
  config: v.optional(v.unknown()),
  webhooks: v.optional(v.unknown()),
  rateLimit: v.optional(v.number()),
  timeout: v.optional(v.number()),
  syncDirection: v.optional(v.enum_(SyncDirection)),
  autoSync: v.optional(v.boolean()),
  syncInterval: v.optional(v.number()),
  isSandbox: v.optional(v.boolean()),
  lastSyncAt: v.optional(v.string()),
  lastSyncStatus: v.optional(v.enum_(SyncStatus)),
  lastUsedAt: v.optional(v.string()),
  errorCount: v.optional(v.number()),
  lastError: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type ApiIntegrationCreate = v.InferOutput<typeof apiIntegrationCreateSchema>;
export type ApiIntegrationUpdate = v.InferOutput<typeof apiIntegrationUpdateSchema>;

// HomeInformationPack Schemas (JP)
export const homeInformationPackCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  title: v.string(),
  fileUrl: v.string(),
  fileName: v.string(),
  fileSize: v.number(),
  mimeType: v.string(),
  checksum: v.string()
});

export const homeInformationPackUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  fileUrl: v.optional(v.string()),
  fileName: v.optional(v.string()),
  fileSize: v.optional(v.number()),
  mimeType: v.optional(v.string()),
  checksum: v.optional(v.string()),
  version: v.optional(v.number()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type HomeInformationPackCreate = v.InferOutput<typeof homeInformationPackCreateSchema>;
export type HomeInformationPackUpdate = v.InferOutput<typeof homeInformationPackUpdateSchema>;

// DepositProtection Schemas (JP)
export const depositProtectionCreateSchema = v.object({
  orgId: v.string(),
  leaseId: v.string(),
  provider: v.string(),
  scheme: v.string(),
  reference: v.string(),
  amount: v.number()
});

export const depositProtectionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  provider: v.optional(v.string()),
  scheme: v.optional(v.string()),
  reference: v.optional(v.string()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.string()),
  protectedAt: v.optional(v.string()),
  claimedAt: v.optional(v.string()),
  returnedAt: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type DepositProtectionCreate = v.InferOutput<typeof depositProtectionCreateSchema>;
export type DepositProtectionUpdate = v.InferOutput<typeof depositProtectionUpdateSchema>;

// RightToRentCheck Schemas (JP)
export const rightToRentCheckCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  checkType: v.string(),
  reference: v.string()
});

export const rightToRentCheckUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  checkType: v.optional(v.string()),
  reference: v.optional(v.string()),
  status: v.optional(v.string()),
  checkedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  result: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type RightToRentCheckCreate = v.InferOutput<typeof rightToRentCheckCreateSchema>;
export type RightToRentCheckUpdate = v.InferOutput<typeof rightToRentCheckUpdateSchema>;

// SolicitorManagement Schemas (JP)
export const solicitorManagementCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  solicitorType: v.string()
});

export const solicitorManagementUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  solicitorType: v.optional(v.string()),
  status: v.optional(v.string()),
  engagedAt: v.optional(v.string()),
  completedAt: v.optional(v.string()),
  fee: v.optional(v.number()),
  currency: v.optional(v.string()),
  notes: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type SolicitorManagementCreate = v.InferOutput<typeof solicitorManagementCreateSchema>;
export type SolicitorManagementUpdate = v.InferOutput<typeof solicitorManagementUpdateSchema>;

// MortgageOffer Schemas (JP)
export const mortgageOfferCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  lender: v.string(),
  offerAmount: v.number(),
  interestRate: v.number(),
  termYears: v.number(),
  monthlyPayment: v.number()
});

export const mortgageOfferUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  lender: v.optional(v.string()),
  offerAmount: v.optional(v.number()),
  interestRate: v.optional(v.number()),
  termYears: v.optional(v.number()),
  monthlyPayment: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.string()),
  offeredAt: v.optional(v.string()),
  acceptedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  conditions: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type MortgageOfferCreate = v.InferOutput<typeof mortgageOfferCreateSchema>;
export type MortgageOfferUpdate = v.InferOutput<typeof mortgageOfferUpdateSchema>;

// RentalSyncJob Schemas (JP)
export const rentalSyncJobCreateSchema = v.object({
  orgId: v.string(),
  integrationId: v.string(),
  platform: v.enum_(RentalPlatform),
  jobType: v.string(),
  direction: v.enum_(SyncDirection)
});

export const rentalSyncJobUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  integrationId: v.optional(v.string()),
  platform: v.optional(v.enum_(RentalPlatform)),
  status: v.optional(v.enum_(SyncStatus)),
  jobType: v.optional(v.string()),
  direction: v.optional(v.enum_(SyncDirection)),
  startedAt: v.optional(v.string()),
  finishedAt: v.optional(v.string()),
  error: v.optional(v.string()),
  stats: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type RentalSyncJobCreate = v.InferOutput<typeof rentalSyncJobCreateSchema>;
export type RentalSyncJobUpdate = v.InferOutput<typeof rentalSyncJobUpdateSchema>;

// ExternalRentalListing Schemas (JP)
export const externalRentalListingCreateSchema = v.object({
  orgId: v.string(),
  integrationId: v.string(),
  platform: v.enum_(RentalPlatform),
  externalId: v.string(),
  title: v.string(),
  amenities: v.string(),
  rawData: v.unknown()
});

export const externalRentalListingUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  integrationId: v.optional(v.string()),
  platform: v.optional(v.enum_(RentalPlatform)),
  externalId: v.optional(v.string()),
  externalUrl: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  status: v.optional(v.enum_(RentalStatus)),
  address: v.optional(v.string()),
  city: v.optional(v.string()),
  state: v.optional(v.string()),
  zip: v.optional(v.string()),
  country: v.optional(v.string()),
  latitude: v.optional(v.number()),
  longitude: v.optional(v.number()),
  nightlyRate: v.optional(v.number()),
  currency: v.optional(v.string()),
  cleaningFee: v.optional(v.number()),
  serviceFee: v.optional(v.number()),
  checkInTime: v.optional(v.string()),
  checkOutTime: v.optional(v.string()),
  minStay: v.optional(v.number()),
  maxStay: v.optional(v.number()),
  bedrooms: v.optional(v.number()),
  bathrooms: v.optional(v.number()),
  maxGuests: v.optional(v.number()),
  amenities: v.optional(v.string()),
  rawData: v.optional(v.unknown()),
  lastSyncedAt: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type ExternalRentalListingCreate = v.InferOutput<typeof externalRentalListingCreateSchema>;
export type ExternalRentalListingUpdate = v.InferOutput<typeof externalRentalListingUpdateSchema>;

// VacationRental Schemas (JP)
export const vacationRentalCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  baseNightlyRate: v.number(),
  maxGuests: v.number()
});

export const vacationRentalUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  ownershipVerificationId: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  rentalType: v.optional(v.string()),
  instantBooking: v.optional(v.boolean()),
  baseNightlyRate: v.optional(v.number()),
  currency: v.optional(v.string()),
  cleaningFee: v.optional(v.number()),
  securityDeposit: v.optional(v.number()),
  weeklyDiscount: v.optional(v.number()),
  monthlyDiscount: v.optional(v.number()),
  checkInTime: v.optional(v.string()),
  checkOutTime: v.optional(v.string()),
  minStayNights: v.optional(v.number()),
  maxStayNights: v.optional(v.number()),
  advanceBookingDays: v.optional(v.number()),
  maxGuests: v.optional(v.number()),
  childrenAllowed: v.optional(v.boolean()),
  petsAllowed: v.optional(v.boolean()),
  smokingAllowed: v.optional(v.boolean()),
  eventsAllowed: v.optional(v.boolean()),
  houseRules: v.optional(v.string()),
  cancellationPolicy: v.optional(v.string()),
  ownershipVerified: v.optional(v.boolean()),
  verificationRequired: v.optional(v.boolean()),
  verificationStatus: v.optional(v.string()),
  verifiedAt: v.optional(v.string()),
  verificationExpiresAt: v.optional(v.string()),
  riskScore: v.optional(v.number()),
  fraudFlags: v.optional(v.unknown()),
  listingQuality: v.optional(v.unknown()),
  photoVerification: v.optional(v.unknown()),
  addressVerification: v.optional(v.unknown()),
  complianceScore: v.optional(v.number()),
  createdBy: v.optional(v.string())
}));

export type VacationRentalCreate = v.InferOutput<typeof vacationRentalCreateSchema>;
export type VacationRentalUpdate = v.InferOutput<typeof vacationRentalUpdateSchema>;

// VacationRentalPlatform Schemas (JP)
export const vacationRentalPlatformCreateSchema = v.object({
  rentalId: v.string(),
  platform: v.enum_(RentalPlatform)
});

export const vacationRentalPlatformUpdateSchema = v.partial(v.object({
  rentalId: v.optional(v.string()),
  platform: v.optional(v.enum_(RentalPlatform)),
  externalId: v.optional(v.string()),
  externalUrl: v.optional(v.string()),
  status: v.optional(v.enum_(RentalStatus)),
  lastSyncedAt: v.optional(v.string()),
  syncEnabled: v.optional(v.boolean())
}));

export type VacationRentalPlatformCreate = v.InferOutput<typeof vacationRentalPlatformCreateSchema>;
export type VacationRentalPlatformUpdate = v.InferOutput<typeof vacationRentalPlatformUpdateSchema>;

// MlsDataMapping Schemas (JP)
export const mlsDataMappingCreateSchema = v.object({
  orgId: v.string(),
  mlsProvider: v.enum_(MLSProviderKey),
  fieldName: v.string(),
  standardField: v.string(),
  dataType: v.string()
});

export const mlsDataMappingUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  mlsProvider: v.optional(v.enum_(MLSProviderKey)),
  fieldName: v.optional(v.string()),
  standardField: v.optional(v.string()),
  dataType: v.optional(v.string()),
  isRequired: v.optional(v.boolean()),
  transformRule: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type MlsDataMappingCreate = v.InferOutput<typeof mlsDataMappingCreateSchema>;
export type MlsDataMappingUpdate = v.InferOutput<typeof mlsDataMappingUpdateSchema>;

// MlsListingEnhancement Schemas (JP)
export const mlsListingEnhancementCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string()
});

export const mlsListingEnhancementUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  mlsNumber: v.optional(v.string()),
  mlsStatus: v.optional(v.string()),
  mlsPhotos: v.optional(v.unknown()),
  mlsDocuments: v.optional(v.unknown()),
  mlsHistory: v.optional(v.unknown()),
  lastMlsUpdate: v.optional(v.string())
}));

export type MlsListingEnhancementCreate = v.InferOutput<typeof mlsListingEnhancementCreateSchema>;
export type MlsListingEnhancementUpdate = v.InferOutput<typeof mlsListingEnhancementUpdateSchema>;

// ListingChannel Schemas (JP)
export const listingChannelCreateSchema = v.object({
  orgId: v.string(),
  listingId: v.string(),
  channel: v.enum_(ListingChannelType)
});

export const listingChannelUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  channel: v.optional(v.enum_(ListingChannelType)),
  channelId: v.optional(v.string()),
  status: v.optional(v.string()),
  lastSync: v.optional(v.string())
}));

export type ListingChannelCreate = v.InferOutput<typeof listingChannelCreateSchema>;
export type ListingChannelUpdate = v.InferOutput<typeof listingChannelUpdateSchema>;

// InvestorPortfolio Schemas (JP)
export const investorPortfolioCreateSchema = v.object({
  userId: v.string(),
  name: v.string(),
  riskTolerance: v.enum_(RiskTolerance)
});

export const investorPortfolioUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  targetIrr: v.optional(v.number()),
  riskTolerance: v.optional(v.enum_(RiskTolerance)),
  investmentHorizon: v.optional(v.string()),
  totalInvested: v.optional(v.number()),
  currentValue: v.optional(v.number()),
  totalReturns: v.optional(v.number()),
  organizationId: v.optional(v.string())
}));

export type InvestorPortfolioCreate = v.InferOutput<typeof investorPortfolioCreateSchema>;
export type InvestorPortfolioUpdate = v.InferOutput<typeof investorPortfolioUpdateSchema>;

// InvestorProperty Schemas (JP)
export const investorPropertyCreateSchema = v.object({
  portfolioId: v.string(),
  propertyId: v.string(),
  acquiredAt: v.string(),
  acquiredCost: v.number()
});

export const investorPropertyUpdateSchema = v.partial(v.object({
  portfolioId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  acquiredAt: v.optional(v.string()),
  acquiredCost: v.optional(v.number()),
  mortgageBalance: v.optional(v.number()),
  mortgageRate: v.optional(v.number()),
  mortgageTerm: v.optional(v.number()),
  insuranceProvider: v.optional(v.string()),
  insuranceAmount: v.optional(v.number())
}));

export type InvestorPropertyCreate = v.InferOutput<typeof investorPropertyCreateSchema>;
export type InvestorPropertyUpdate = v.InferOutput<typeof investorPropertyUpdateSchema>;

// PropertyValuation Schemas (JP)
export const propertyValuationCreateSchema = v.object({
  propertyId: v.string(),
  orgId: v.string(),
  value: v.number()
});

export const propertyValuationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  valuationType: v.optional(v.enum_(ValuationType)),
  status: v.optional(v.enum_(ValuationStatus)),
  value: v.optional(v.number()),
  confidence: v.optional(v.number()),
  valuationDate: v.optional(v.string()),
  source: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  contactId: v.optional(v.string())
}));

export type PropertyValuationCreate = v.InferOutput<typeof propertyValuationCreateSchema>;
export type PropertyValuationUpdate = v.InferOutput<typeof propertyValuationUpdateSchema>;

// AgentTeam Schemas (JP)
export const agentTeamCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  leaderId: v.string()
});

export const agentTeamUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  leaderId: v.optional(v.string())
}));

export type AgentTeamCreate = v.InferOutput<typeof agentTeamCreateSchema>;
export type AgentTeamUpdate = v.InferOutput<typeof agentTeamUpdateSchema>;

// AgentTeamMember Schemas (JP)
export const agentTeamMemberCreateSchema = v.object({
  teamId: v.string(),
  userId: v.string(),
  role: v.string()
});

export const agentTeamMemberUpdateSchema = v.partial(v.object({
  teamId: v.optional(v.string()),
  userId: v.optional(v.string()),
  role: v.optional(v.string())
}));

export type AgentTeamMemberCreate = v.InferOutput<typeof agentTeamMemberCreateSchema>;
export type AgentTeamMemberUpdate = v.InferOutput<typeof agentTeamMemberUpdateSchema>;

// AgentPerformance Schemas (JP)
export const agentPerformanceCreateSchema = v.object({
  userId: v.string(),
  period: v.string(),
  startDate: v.string(),
  endDate: v.string()
});

export const agentPerformanceUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  period: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  leadsGenerated: v.optional(v.number()),
  showingsCompleted: v.optional(v.number()),
  offersSubmitted: v.optional(v.number()),
  dealsClosed: v.optional(v.number()),
  commissionEarned: v.optional(v.number())
}));

export type AgentPerformanceCreate = v.InferOutput<typeof agentPerformanceCreateSchema>;
export type AgentPerformanceUpdate = v.InferOutput<typeof agentPerformanceUpdateSchema>;

// ClientRelationship Schemas (JP)
export const clientRelationshipCreateSchema = v.object({
  agentId: v.string(),
  clientId: v.string(),
  firstContact: v.string()
});

export const clientRelationshipUpdateSchema = v.partial(v.object({
  agentId: v.optional(v.string()),
  clientId: v.optional(v.string()),
  status: v.optional(v.enum_(RelationshipStatus)),
  firstContact: v.optional(v.string()),
  lastContact: v.optional(v.string()),
  contactFrequency: v.optional(v.string()),
  preferredChannel: v.optional(v.enum_(NotificationChannel))
}));

export type ClientRelationshipCreate = v.InferOutput<typeof clientRelationshipCreateSchema>;
export type ClientRelationshipUpdate = v.InferOutput<typeof clientRelationshipUpdateSchema>;

// TenantApplication Schemas (JP)
export const tenantApplicationCreateSchema = v.object({
  propertyId: v.string(),
  applicantId: v.string(),
  submittedAt: v.string(),
  applicationData: v.unknown()
});

export const tenantApplicationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  applicantId: v.optional(v.string()),
  status: v.optional(v.enum_(ApplicationStatus)),
  submittedAt: v.optional(v.string()),
  reviewedAt: v.optional(v.string()),
  reviewedBy: v.optional(v.string()),
  applicationData: v.optional(v.unknown()),
  creditScore: v.optional(v.number()),
  incomeVerified: v.optional(v.boolean()),
  backgroundCheck: v.optional(v.boolean()),
  organizationId: v.optional(v.string())
}));

export type TenantApplicationCreate = v.InferOutput<typeof tenantApplicationCreateSchema>;
export type TenantApplicationUpdate = v.InferOutput<typeof tenantApplicationUpdateSchema>;

// MaintenanceWorkOrder Schemas (JP)
export const maintenanceWorkOrderCreateSchema = v.object({
  propertyId: v.string(),
  reportedBy: v.string(),
  title: v.string(),
  description: v.string(),
  priority: v.enum_(Priority),
  category: v.string(),
  reportedAt: v.string()
});

export const maintenanceWorkOrderUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  reportedBy: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  priority: v.optional(v.enum_(Priority)),
  category: v.optional(v.string()),
  status: v.optional(v.enum_(WorkOrderStatus)),
  reportedAt: v.optional(v.string()),
  dueDate: v.optional(v.string()),
  assignedTo: v.optional(v.string()),
  assignedVendor: v.optional(v.string()),
  estimatedCost: v.optional(v.number()),
  actualCost: v.optional(v.number()),
  userId: v.optional(v.string()),
  organizationId: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type MaintenanceWorkOrderCreate = v.InferOutput<typeof maintenanceWorkOrderCreateSchema>;
export type MaintenanceWorkOrderUpdate = v.InferOutput<typeof maintenanceWorkOrderUpdateSchema>;

// LeaseRenewal Schemas (JP)
export const leaseRenewalCreateSchema = v.object({
  leaseId: v.string(),
  renewalDate: v.string()
});

export const leaseRenewalUpdateSchema = v.partial(v.object({
  leaseId: v.optional(v.string()),
  status: v.optional(v.enum_(RenewalStatus)),
  proposedRent: v.optional(v.number()),
  proposedTerms: v.optional(v.unknown()),
  renewalDate: v.optional(v.string()),
  responseDeadline: v.optional(v.string()),
  organizationId: v.optional(v.string()),
  listingId: v.optional(v.string())
}));

export type LeaseRenewalCreate = v.InferOutput<typeof leaseRenewalCreateSchema>;
export type LeaseRenewalUpdate = v.InferOutput<typeof leaseRenewalUpdateSchema>;

// GuestProfile Schemas (JP)
export const guestProfileCreateSchema = v.object({
  contactId: v.string(),
  preferredAmenities: v.string()
});

export const guestProfileUpdateSchema = v.partial(v.object({
  contactId: v.optional(v.string()),
  preferredCheckInTime: v.optional(v.string()),
  preferredAmenities: v.optional(v.string()),
  dietaryRestrictions: v.optional(v.string()),
  accessibilityNeeds: v.optional(v.string()),
  loyaltyPoints: v.optional(v.number()),
  lifetimeSpent: v.optional(v.number()),
  bookingCount: v.optional(v.number())
}));

export type GuestProfileCreate = v.InferOutput<typeof guestProfileCreateSchema>;
export type GuestProfileUpdate = v.InferOutput<typeof guestProfileUpdateSchema>;

// GuestReview Schemas (JP)
export const guestReviewCreateSchema = v.object({
  bookingId: v.string(),
  guestId: v.string(),
  propertyId: v.string(),
  rating: v.number()
});

export const guestReviewUpdateSchema = v.partial(v.object({
  bookingId: v.optional(v.string()),
  guestId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  rating: v.optional(v.number()),
  cleanliness: v.optional(v.number()),
  communication: v.optional(v.number()),
  checkIn: v.optional(v.number()),
  accuracy: v.optional(v.number()),
  location: v.optional(v.number()),
  value: v.optional(v.number()),
  comment: v.optional(v.string()),
  response: v.optional(v.string()),
  isPublic: v.optional(v.boolean())
}));

export type GuestReviewCreate = v.InferOutput<typeof guestReviewCreateSchema>;
export type GuestReviewUpdate = v.InferOutput<typeof guestReviewUpdateSchema>;

// TaxDepreciation Schemas (JP)
export const taxDepreciationCreateSchema = v.object({
  propertyId: v.string(),
  assetType: v.enum_(AssetType),
  costBasis: v.number(),
  depreciationMethod: v.enum_(DepreciationMethod),
  usefulLife: v.number(),
  startDate: v.string()
});

export const taxDepreciationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  assetType: v.optional(v.enum_(AssetType)),
  costBasis: v.optional(v.number()),
  depreciationMethod: v.optional(v.enum_(DepreciationMethod)),
  usefulLife: v.optional(v.number()),
  salvageValue: v.optional(v.number()),
  startDate: v.optional(v.string()),
  accumulatedDepreciation: v.optional(v.number()),
  organizationId: v.optional(v.string())
}));

export type TaxDepreciationCreate = v.InferOutput<typeof taxDepreciationCreateSchema>;
export type TaxDepreciationUpdate = v.InferOutput<typeof taxDepreciationUpdateSchema>;

// Tax1099Form Schemas (JP)
export const tax1099FormCreateSchema = v.object({
  orgId: v.string(),
  recipientId: v.string(),
  taxYear: v.number(),
  formType: v.enum_(USTaxForm),
  amount: v.number()
});

export const tax1099FormUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  recipientId: v.optional(v.string()),
  taxYear: v.optional(v.number()),
  formType: v.optional(v.enum_(USTaxForm)),
  amount: v.optional(v.number()),
  description: v.optional(v.string()),
  issuedAt: v.optional(v.string()),
  mailedAt: v.optional(v.string())
}));

export type Tax1099FormCreate = v.InferOutput<typeof tax1099FormCreateSchema>;
export type Tax1099FormUpdate = v.InferOutput<typeof tax1099FormUpdateSchema>;

// DashboardWidget Schemas (JP)
export const dashboardWidgetCreateSchema = v.object({
  userId: v.string(),
  widgetType: v.enum_(WidgetType),
  title: v.string(),
  config: v.unknown(),
  position: v.unknown()
});

export const dashboardWidgetUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  widgetType: v.optional(v.enum_(WidgetType)),
  title: v.optional(v.string()),
  config: v.optional(v.unknown()),
  position: v.optional(v.unknown())
}));

export type DashboardWidgetCreate = v.InferOutput<typeof dashboardWidgetCreateSchema>;
export type DashboardWidgetUpdate = v.InferOutput<typeof dashboardWidgetUpdateSchema>;

// PredictiveModel Schemas (JP)
export const predictiveModelCreateSchema = v.object({
  orgId: v.string(),
  modelType: v.enum_(ModelType),
  trainingData: v.unknown(),
  parameters: v.unknown()
});

export const predictiveModelUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelType: v.optional(v.enum_(ModelType)),
  trainingData: v.optional(v.unknown()),
  parameters: v.optional(v.unknown()),
  accuracy: v.optional(v.number()),
  lastTrained: v.optional(v.string())
}));

export type PredictiveModelCreate = v.InferOutput<typeof predictiveModelCreateSchema>;
export type PredictiveModelUpdate = v.InferOutput<typeof predictiveModelUpdateSchema>;

// LoyaltyAccount Schemas (JP)
export const loyaltyAccountCreateSchema = v.object({
  orgId: v.string(),
  userId: v.string(),
  name: v.string()
});

export const loyaltyAccountUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  pointsPerDollar: v.optional(v.number()),
  pointsExpiryDays: v.optional(v.number()),
  tiersEnabled: v.optional(v.boolean()),
  bronzeThreshold: v.optional(v.number()),
  silverThreshold: v.optional(v.number()),
  goldThreshold: v.optional(v.number()),
  platinumThreshold: v.optional(v.number()),
  diamondThreshold: v.optional(v.number()),
  currentPoints: v.optional(v.number()),
  currentTier: v.optional(v.enum_(LoyaltyTier)),
  totalEarned: v.optional(v.number()),
  pointsHistory: v.optional(v.unknown()),
  rewards: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type LoyaltyAccountCreate = v.InferOutput<typeof loyaltyAccountCreateSchema>;
export type LoyaltyAccountUpdate = v.InferOutput<typeof loyaltyAccountUpdateSchema>;

// Referral Schemas (JP)
export const referralCreateSchema = v.object({
  userId: v.string(),
  code: v.string()
});

export const referralUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  code: v.optional(v.string()),
  commissionRate: v.optional(v.number()),
  bonusPoints: v.optional(v.number()),
  expiresAt: v.optional(v.string()),
  totalReferrals: v.optional(v.number()),
  successfulReferrals: v.optional(v.number()),
  totalEarnings: v.optional(v.number()),
  trackingHistory: v.optional(v.unknown()),
  organizationId: v.optional(v.string())
}));

export type ReferralCreate = v.InferOutput<typeof referralCreateSchema>;
export type ReferralUpdate = v.InferOutput<typeof referralUpdateSchema>;

// Subscription Schemas (JP)
export const subscriptionCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.enum_(MembershipType),
  price: v.number()
});

export const subscriptionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.enum_(MembershipType)),
  price: v.optional(v.number()),
  currency: v.optional(v.string()),
  billingCycle: v.optional(v.string()),
  maxProperties: v.optional(v.number()),
  maxListings: v.optional(v.number()),
  featuredListings: v.optional(v.number()),
  prioritySupport: v.optional(v.boolean()),
  apiAccess: v.optional(v.boolean()),
  commissionDiscount: v.optional(v.number()),
  loyaltyMultiplier: v.optional(v.number()),
  isActive: v.optional(v.boolean()),
  userSubscriptions: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type SubscriptionCreate = v.InferOutput<typeof subscriptionCreateSchema>;
export type SubscriptionUpdate = v.InferOutput<typeof subscriptionUpdateSchema>;

// GiftCard Schemas (JP)
export const giftCardCreateSchema = v.object({
  code: v.string(),
  orgId: v.string(),
  amount: v.number(),
  balance: v.number()
});

export const giftCardUpdateSchema = v.partial(v.object({
  code: v.optional(v.string()),
  orgId: v.optional(v.string()),
  amount: v.optional(v.number()),
  balance: v.optional(v.number()),
  currency: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  issuedTo: v.optional(v.string()),
  issuedBy: v.optional(v.string()),
  issuedFor: v.optional(v.string())
}));

export type GiftCardCreate = v.InferOutput<typeof giftCardCreateSchema>;
export type GiftCardUpdate = v.InferOutput<typeof giftCardUpdateSchema>;

// Achievement Schemas (JP)
export const achievementCreateSchema = v.object({
  userId: v.string(),
  goalType: v.enum_(GoalType),
  goalValue: v.number()
});

export const achievementUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  goalType: v.optional(v.enum_(GoalType)),
  goalValue: v.optional(v.number()),
  currentValue: v.optional(v.number()),
  isCompleted: v.optional(v.boolean()),
  completedAt: v.optional(v.string()),
  pointsReward: v.optional(v.number()),
  bonusReward: v.optional(v.string()),
  organizationId: v.optional(v.string())
}));

export type AchievementCreate = v.InferOutput<typeof achievementCreateSchema>;
export type AchievementUpdate = v.InferOutput<typeof achievementUpdateSchema>;

// Earning Schemas (JP)
export const earningCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  type: v.enum_(EarningType)
});

export const earningUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.enum_(EarningType)),
  percentage: v.optional(v.number()),
  fixedAmount: v.optional(v.number()),
  conditions: v.optional(v.unknown()),
  appliesToUsers: v.optional(v.boolean()),
  appliesToAgents: v.optional(v.boolean()),
  appliesToVendors: v.optional(v.boolean()),
  isActive: v.optional(v.boolean()),
  earningsRecords: v.optional(v.unknown()),
  createdBy: v.optional(v.string())
}));

export type EarningCreate = v.InferOutput<typeof earningCreateSchema>;
export type EarningUpdate = v.InferOutput<typeof earningUpdateSchema>;

// Job Schemas (JP)
export const jobCreateSchema = v.object({
  type: v.string(),
  payload: v.unknown()
});

export const jobUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  type: v.optional(v.string()),
  payload: v.optional(v.unknown()),
  status: v.optional(v.enum_(ExportStatus)),
  runAt: v.optional(v.string()),
  attempts: v.optional(v.number()),
  lastError: v.optional(v.string()),
  lockedAt: v.optional(v.string()),
  lockedBy: v.optional(v.string())
}));

export type JobCreate = v.InferOutput<typeof jobCreateSchema>;
export type JobUpdate = v.InferOutput<typeof jobUpdateSchema>;

// Notification Schemas (JP)
export const notificationCreateSchema = v.object({
  orgId: v.string(),
  title: v.string(),
  body: v.string()
});

export const notificationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  title: v.optional(v.string()),
  body: v.optional(v.string()),
  data: v.optional(v.unknown()),
  status: v.optional(v.enum_(NotificationStatus)),
  sentAt: v.optional(v.string()),
  readAt: v.optional(v.string()),
  userPreferences: v.optional(v.unknown()),
  deliveries: v.optional(v.unknown()),
  ruleKey: v.optional(v.string()),
  ruleConfig: v.optional(v.unknown())
}));

export type NotificationCreate = v.InferOutput<typeof notificationCreateSchema>;
export type NotificationUpdate = v.InferOutput<typeof notificationUpdateSchema>;

// Message Schemas (JP)
export const messageCreateSchema = v.object({
  orgId: v.string(),
  senderType: v.enum_(MessageParticipantType),
  body: v.string()
});

export const messageUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  threadId: v.optional(v.string()),
  senderType: v.optional(v.enum_(MessageParticipantType)),
  senderUserId: v.optional(v.string()),
  senderContactId: v.optional(v.string()),
  body: v.optional(v.string()),
  subject: v.optional(v.string()),
  isThreadStarter: v.optional(v.boolean()),
  threadInfo: v.optional(v.unknown()),
  readStatus: v.optional(v.unknown()),
  aiSentimentScore: v.optional(v.number()),
  aiPriority: v.optional(v.string())
}));

export type MessageCreate = v.InferOutput<typeof messageCreateSchema>;
export type MessageUpdate = v.InferOutput<typeof messageUpdateSchema>;

// Task Schemas (JP)
export const taskCreateSchema = v.object({
  orgId: v.string(),
  type: v.enum_(TaskType),
  title: v.string()
});

export const taskUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bookingId: v.optional(v.string()),
  contractId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  projectId: v.optional(v.string()),
  type: v.optional(v.enum_(TaskType)),
  status: v.optional(v.enum_(TaskStatus)),
  priority: v.optional(v.enum_(Priority)),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  dueAt: v.optional(v.string()),
  slaHours: v.optional(v.number()),
  assignedToUserId: v.optional(v.string()),
  assignedToContactId: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type TaskCreate = v.InferOutput<typeof taskCreateSchema>;
export type TaskUpdate = v.InferOutput<typeof taskUpdateSchema>;

// Facility Schemas (JP)
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

// Contract Schemas (JP)
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

// ContractVersion Schemas (JP)
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

// SignatureRequest Schemas (JP)
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

// SignatureSigner Schemas (JP)
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

// UserFinancialProfile Schemas (JP)
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

// UserPreference Schemas (JP)
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
  dashboardLayout: v.optional(v.unknown()),
  twoFactorEnabled: v.optional(v.boolean()),
  twoFactorSecret: v.optional(v.string()),
  biometricEnabled: v.optional(v.boolean()),
  biometricPublicKey: v.optional(v.string()),
  lastDeviceId: v.optional(v.string())
}));

export type UserPreferenceCreate = v.InferOutput<typeof userPreferenceCreateSchema>;
export type UserPreferenceUpdate = v.InferOutput<typeof userPreferenceUpdateSchema>;

// UserActivityLog Schemas (JP)
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

// ApiKey Schemas (JP)
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

// Review Schemas (JP)
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

// MarketingCampaign Schemas (JP)
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
  conversionCount: v.optional(v.number()),
  budget: v.optional(v.number()),
  actualSpend: v.optional(v.number()),
  objective: v.optional(v.string())
}));

export type MarketingCampaignCreate = v.InferOutput<typeof marketingCampaignCreateSchema>;
export type MarketingCampaignUpdate = v.InferOutput<typeof marketingCampaignUpdateSchema>;

// OrgSubscription Schemas (JP)
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

// Plan Schemas (JP)
export const planCreateSchema = v.object({
  key: v.string(),
  name: v.string(),
  limits: v.unknown()
});

export const planUpdateSchema = v.partial(v.object({
  key: v.optional(v.string()),
  name: v.optional(v.string()),
  limits: v.optional(v.unknown()),
  priceMonthlyCents: v.optional(v.number())
}));

export type PlanCreate = v.InferOutput<typeof planCreateSchema>;
export type PlanUpdate = v.InferOutput<typeof planUpdateSchema>;

// MLSConnection Schemas (JP)
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

// MLSSyncJob Schemas (JP)
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

// MLSExternalListing Schemas (JP)
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

// Commission Schemas (JP)
export const commissionCreateSchema = v.object({
  orgId: v.string(),
  amountBase: v.number(),
  platformFee: v.number(),
  partnerFee: v.number(),
  taxAmount: v.number(),
  commissionAmount: v.number()
});

export const commissionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bookingId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  transactionId: v.optional(v.string()),
  beneficiaryUserId: v.optional(v.string()),
  beneficiaryOrgId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  amountBase: v.optional(v.number()),
  commissionRate: v.optional(v.number()),
  platformRate: v.optional(v.number()),
  partnerRate: v.optional(v.number()),
  platformFee: v.optional(v.number()),
  partnerFee: v.optional(v.number()),
  taxAmount: v.optional(v.number()),
  commissionAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(CommissionStatus)),
  ruleData: v.optional(v.unknown()),
  records: v.optional(v.unknown())
}));

export type CommissionCreate = v.InferOutput<typeof commissionCreateSchema>;
export type CommissionUpdate = v.InferOutput<typeof commissionUpdateSchema>;

// PropertyPhoto Schemas (JP)
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

// PropertyCompliance Schemas (JP)
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

// PropertyDocument Schemas (JP)
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

// Amenity Schemas (JP)
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

// PropertyAmenity Schemas (JP)
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

// Neighborhood Schemas (JP)
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

// RecommendationResult Schemas (JP)
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

// Event Schemas (JP)
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

// EventAttendee Schemas (JP)
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

// PropertyOffer Schemas (JP)
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

// Reservation Schemas (JP)
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
  propertyId: v.optional(v.string()),
  ownershipVerificationId: v.optional(v.string()),
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
  ownershipVerified: v.optional(v.boolean()),
  verificationRequired: v.optional(v.boolean()),
  verificationStatus: v.optional(v.string()),
  verifiedAt: v.optional(v.string()),
  verificationExpiresAt: v.optional(v.string()),
  riskScore: v.optional(v.number()),
  fraudFlags: v.optional(v.unknown()),
  securityScreening: v.optional(v.unknown()),
  backgroundCheckStatus: v.optional(v.string()),
  identityVerified: v.optional(v.boolean())
}));

export type ReservationCreate = v.InferOutput<typeof reservationCreateSchema>;
export type ReservationUpdate = v.InferOutput<typeof reservationUpdateSchema>;

// DocumentTemplate Schemas (JP)
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

// Appointment Schemas (JP)
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
  reminders: v.optional(v.unknown()),
  notes: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type AppointmentCreate = v.InferOutput<typeof appointmentCreateSchema>;
export type AppointmentUpdate = v.InferOutput<typeof appointmentUpdateSchema>;

// CalendarEvent Schemas (JP)
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
  attendees: v.optional(v.unknown()),
  isAllDay: v.optional(v.boolean()),
  recurrence: v.optional(v.unknown()),
  reminders: v.optional(v.unknown()),
  lastSyncedAt: v.optional(v.string()),
  syncStatus: v.optional(v.string())
}));

export type CalendarEventCreate = v.InferOutput<typeof calendarEventCreateSchema>;
export type CalendarEventUpdate = v.InferOutput<typeof calendarEventUpdateSchema>;

// Report Schemas (JP)
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

// ReportExecution Schemas (JP)
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

// Webhook Schemas (JP)
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

// WebhookDelivery Schemas (JP)
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

// AuditLog Schemas (JP)
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

// CommunicationTemplate Schemas (JP)
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

// Budget Schemas (JP)
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
  lineItems: v.optional(v.unknown()),
  categories: v.optional(v.unknown()),
  alerts: v.optional(v.unknown()),
  actualSpent: v.optional(v.number()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type BudgetCreate = v.InferOutput<typeof budgetCreateSchema>;
export type BudgetUpdate = v.InferOutput<typeof budgetUpdateSchema>;

// Quote Schemas (JP)
export const quoteCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  quoteNumber: v.string(),
  title: v.string(),
  items: v.unknown(),
  subtotal: v.number(),
  totalAmount: v.number()
});

export const quoteUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  quoteNumber: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  items: v.optional(v.unknown()),
  subtotal: v.optional(v.number()),
  taxAmount: v.optional(v.number()),
  totalAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  validUntil: v.optional(v.string()),
  status: v.optional(v.string()),
  notes: v.optional(v.string()),
  terms: v.optional(v.string()),
  createdBy: v.optional(v.string())
}));

export type QuoteCreate = v.InferOutput<typeof quoteCreateSchema>;
export type QuoteUpdate = v.InferOutput<typeof quoteUpdateSchema>;

// Project Schemas (JP)
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

// FloorPlan Schemas (JP)
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
  rooms: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  createdBy: v.optional(v.string())
}));

export type FloorPlanCreate = v.InferOutput<typeof floorPlanCreateSchema>;
export type FloorPlanUpdate = v.InferOutput<typeof floorPlanUpdateSchema>;

// VirtualTour Schemas (JP)
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

// KeyManagement Schemas (JP)
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

// PropertyInventory Schemas (JP)
export const propertyInventoryCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  inventoryType: v.string(),
  inventoryDate: v.string(),
  conductedBy: v.string(),
  presentAtCheck: v.string(),
  overallCondition: v.string()
});

export const propertyInventoryUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  inventoryType: v.optional(v.string()),
  inventoryDate: v.optional(v.string()),
  conductedBy: v.optional(v.string()),
  presentAtCheck: v.optional(v.string()),
  rooms: v.optional(v.unknown()),
  overallCondition: v.optional(v.string()),
  damages: v.optional(v.unknown()),
  cleaningRequired: v.optional(v.boolean()),
  tenantSignature: v.optional(v.string()),
  landlordSignature: v.optional(v.string()),
  agentSignature: v.optional(v.string()),
  reportUrl: v.optional(v.string()),
  photos: v.optional(v.unknown())
}));

export type PropertyInventoryCreate = v.InferOutput<typeof propertyInventoryCreateSchema>;
export type PropertyInventoryUpdate = v.InferOutput<typeof propertyInventoryUpdateSchema>;

// SecurityDepositProtection Schemas (JP)
export const securityDepositProtectionCreateSchema = v.object({
  orgId: v.string(),
  leaseId: v.string(),
  schemeProvider: v.string(),
  schemeReference: v.string(),
  depositAmount: v.number(),
  tenantDetails: v.unknown(),
  landlordDetails: v.unknown()
});

export const securityDepositProtectionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  schemeProvider: v.optional(v.string()),
  schemeReference: v.optional(v.string()),
  depositAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  protectionStatus: v.optional(v.string()),
  protectedDate: v.optional(v.string()),
  releasedDate: v.optional(v.string()),
  tenantDetails: v.optional(v.unknown()),
  landlordDetails: v.optional(v.unknown()),
  disputeStatus: v.optional(v.string()),
  disputeReason: v.optional(v.string()),
  disputeResolution: v.optional(v.string())
}));

export type SecurityDepositProtectionCreate = v.InferOutput<typeof securityDepositProtectionCreateSchema>;
export type SecurityDepositProtectionUpdate = v.InferOutput<typeof securityDepositProtectionUpdateSchema>;

// PropertyViewing Schemas (JP)
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

// PropertyDisclosure Schemas (JP)
export const propertyDisclosureCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string()
});

export const propertyDisclosureUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  packStatus: v.optional(v.string()),
  createdDate: v.optional(v.string()),
  submittedDate: v.optional(v.string()),
  energyPerformanceCertificate: v.optional(v.unknown()),
  floorPlan: v.optional(v.unknown()),
  leaseholdInfo: v.optional(v.unknown()),
  boundaryPlan: v.optional(v.unknown()),
  planningPermission: v.optional(v.unknown()),
  propertyQuestionnaire: v.optional(v.unknown()),
  electricalSafety: v.optional(v.unknown()),
  gasSafety: v.optional(v.unknown()),
  fireSafety: v.optional(v.unknown()),
  completionNotes: v.optional(v.string())
}));

export type PropertyDisclosureCreate = v.InferOutput<typeof propertyDisclosureCreateSchema>;
export type PropertyDisclosureUpdate = v.InferOutput<typeof propertyDisclosureUpdateSchema>;

// ImmigrationStatusCheck Schemas (JP)
export const immigrationStatusCheckCreateSchema = v.object({
  orgId: v.string(),
  leaseId: v.string(),
  tenantId: v.string()
});

export const immigrationStatusCheckUpdateSchema = v.partial(v.object({
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

export type ImmigrationStatusCheckCreate = v.InferOutput<typeof immigrationStatusCheckCreateSchema>;
export type ImmigrationStatusCheckUpdate = v.InferOutput<typeof immigrationStatusCheckUpdateSchema>;

// RentArrears Schemas (JP)
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

// AttorneyManagement Schemas (JP)
export const attorneyManagementCreateSchema = v.object({
  orgId: v.string(),
  dealId: v.string(),
  contactId: v.string(),
  solicitorFirm: v.string(),
  solicitorName: v.string(),
  solicitorEmail: v.string(),
  appointmentType: v.string()
});

export const attorneyManagementUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  solicitorFirm: v.optional(v.string()),
  solicitorName: v.optional(v.string()),
  solicitorEmail: v.optional(v.string()),
  solicitorPhone: v.optional(v.string()),
  appointmentType: v.optional(v.string()),
  appointmentDate: v.optional(v.string()),
  appointmentNotes: v.optional(v.string()),
  status: v.optional(v.string()),
  searchDate: v.optional(v.string()),
  draftContractDate: v.optional(v.string()),
  finalContractDate: v.optional(v.string()),
  completionDate: v.optional(v.string()),
  completionNotes: v.optional(v.string()),
  fees: v.optional(v.unknown())
}));

export type AttorneyManagementCreate = v.InferOutput<typeof attorneyManagementCreateSchema>;
export type AttorneyManagementUpdate = v.InferOutput<typeof attorneyManagementUpdateSchema>;

// MortgagePreApproval Schemas (JP)
export const mortgagePreApprovalCreateSchema = v.object({
  orgId: v.string(),
  contactId: v.string(),
  lenderName: v.string(),
  mortgageType: v.string(),
  mortgageTerm: v.number(),
  interestRate: v.number(),
  arrangementFee: v.number(),
  valuationFee: v.number(),
  loanAmount: v.number(),
  depositAmount: v.number(),
  loanToValue: v.number(),
  monthlyPayment: v.number(),
  totalPayable: v.number(),
  offerDate: v.string()
});

export const mortgagePreApprovalUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  dealId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  lenderName: v.optional(v.string()),
  mortgageType: v.optional(v.string()),
  mortgageTerm: v.optional(v.number()),
  interestRate: v.optional(v.number()),
  arrangementFee: v.optional(v.number()),
  valuationFee: v.optional(v.number()),
  loanAmount: v.optional(v.number()),
  depositAmount: v.optional(v.number()),
  loanToValue: v.optional(v.number()),
  monthlyPayment: v.optional(v.number()),
  totalPayable: v.optional(v.number()),
  offerStatus: v.optional(v.string()),
  offerDate: v.optional(v.string()),
  expiryDate: v.optional(v.string()),
  acceptedDate: v.optional(v.string()),
  solicitorName: v.optional(v.string()),
  solicitorEmail: v.optional(v.string())
}));

export type MortgagePreApprovalCreate = v.InferOutput<typeof mortgagePreApprovalCreateSchema>;
export type MortgagePreApprovalUpdate = v.InferOutput<typeof mortgagePreApprovalUpdateSchema>;

// AIModel Schemas (JP)
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

// AIModelDeployment Schemas (JP)
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

// AIPrediction Schemas (JP)
export const aIPredictionCreateSchema = v.object({
  orgId: v.string(),
  modelType: v.string(),
  confidence: v.number()
});

export const aIPredictionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelId: v.optional(v.string()),
  requestId: v.optional(v.string()),
  batchId: v.optional(v.string()),
  modelType: v.optional(v.string()),
  inputData: v.optional(v.unknown()),
  outputData: v.optional(v.unknown()),
  result: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  processingTimeMs: v.optional(v.number()),
  processingTime: v.optional(v.number()),
  status: v.optional(v.string()),
  success: v.optional(v.boolean()),
  errorMessage: v.optional(v.string()),
  userId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  metadata: v.optional(v.unknown())
}));

export type AIPredictionCreate = v.InferOutput<typeof aIPredictionCreateSchema>;
export type AIPredictionUpdate = v.InferOutput<typeof aIPredictionUpdateSchema>;

// QueueMessage Schemas (JP)
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

// QueueConfiguration Schemas (JP)
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
  retryPolicy: v.optional(v.unknown()),
  deadLetterQueue: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type QueueConfigurationCreate = v.InferOutput<typeof queueConfigurationCreateSchema>;
export type QueueConfigurationUpdate = v.InferOutput<typeof queueConfigurationUpdateSchema>;

// IntegrationLog Schemas (JP)
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

// AutomationRule Schemas (JP)
export const automationRuleCreateSchema = v.object({
  orgId: v.string(),
  ruleName: v.string(),
  ruleType: v.string(),
  triggerType: v.string(),
  triggerConfig: v.unknown(),
  actions: v.unknown()
});

export const automationRuleUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  ruleName: v.optional(v.string()),
  ruleType: v.optional(v.string()),
  triggerType: v.optional(v.string()),
  triggerConfig: v.optional(v.unknown()),
  conditions: v.optional(v.unknown()),
  actions: v.optional(v.unknown()),
  isActive: v.optional(v.boolean()),
  lastExecutedAt: v.optional(v.string()),
  executionCount: v.optional(v.number()),
  createdBy: v.optional(v.string())
}));

export type AutomationRuleCreate = v.InferOutput<typeof automationRuleCreateSchema>;
export type AutomationRuleUpdate = v.InferOutput<typeof automationRuleUpdateSchema>;

// AutomationExecution Schemas (JP)
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

// AIValuationModel Schemas (JP)
export const aIValuationModelCreateSchema = v.object({
  modelName: v.string(),
  modelVersion: v.string(),
  accuracy: v.number(),
  lastTrainedAt: v.string(),
  features: v.unknown(),
  hyperparameters: v.unknown(),
  trainingMetrics: v.unknown()
});

export const aIValuationModelUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelName: v.optional(v.string()),
  modelVersion: v.optional(v.string()),
  accuracy: v.optional(v.number()),
  lastTrainedAt: v.optional(v.string()),
  features: v.optional(v.unknown()),
  hyperparameters: v.optional(v.unknown()),
  trainingMetrics: v.optional(v.unknown()),
  isActive: v.optional(v.boolean())
}));

export type AIValuationModelCreate = v.InferOutput<typeof aIValuationModelCreateSchema>;
export type AIValuationModelUpdate = v.InferOutput<typeof aIValuationModelUpdateSchema>;

// AIPropertyValuation Schemas (JP)
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

// AILeadScoring Schemas (JP)
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

// AILeadScore Schemas (JP)
export const aILeadScoreCreateSchema = v.object({
  modelId: v.string(),
  leadId: v.string(),
  score: v.number(),
  scoreBreakdown: v.unknown(),
  confidence: v.number(),
  scoredAt: v.string(),
  featuresUsed: v.unknown()
});

export const aILeadScoreUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  modelId: v.optional(v.string()),
  leadId: v.optional(v.string()),
  score: v.optional(v.number()),
  scoreBreakdown: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  scoredAt: v.optional(v.string()),
  featuresUsed: v.optional(v.unknown()),
  status: v.optional(v.string())
}));

export type AILeadScoreCreate = v.InferOutput<typeof aILeadScoreCreateSchema>;
export type AILeadScoreUpdate = v.InferOutput<typeof aILeadScoreUpdateSchema>;

// AIMarketAnalysis Schemas (JP)
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

// AIPropertyDescription Schemas (JP)
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

// AIImageAnalysis Schemas (JP)
export const aIImageAnalysisCreateSchema = v.object({
  propertyId: v.string(),
  analysisType: v.string(),
  analyzedAt: v.string(),
  confidence: v.number()
});

export const aIImageAnalysisUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  photoId: v.optional(v.string()),
  analysisType: v.optional(v.string()),
  detectedRooms: v.optional(v.unknown()),
  qualityScore: v.optional(v.number()),
  styleTags: v.optional(v.unknown()),
  colorPalette: v.optional(v.unknown()),
  lightingQuality: v.optional(v.number()),
  recommendations: v.optional(v.unknown()),
  analyzedAt: v.optional(v.string()),
  confidence: v.optional(v.number())
}));

export type AIImageAnalysisCreate = v.InferOutput<typeof aIImageAnalysisCreateSchema>;
export type AIImageAnalysisUpdate = v.InferOutput<typeof aIImageAnalysisUpdateSchema>;

// AIPriceOptimization Schemas (JP)
export const aIPriceOptimizationCreateSchema = v.object({
  listingId: v.string(),
  currentPrice: v.number(),
  recommendedPrice: v.number(),
  priceRange: v.unknown(),
  factors: v.unknown(),
  comparableData: v.unknown(),
  marketTrends: v.unknown(),
  confidence: v.number(),
  generatedAt: v.string()
});

export const aIPriceOptimizationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  currentPrice: v.optional(v.number()),
  recommendedPrice: v.optional(v.number()),
  priceRange: v.optional(v.unknown()),
  factors: v.optional(v.unknown()),
  comparableData: v.optional(v.unknown()),
  marketTrends: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  generatedAt: v.optional(v.string()),
  isApplied: v.optional(v.boolean()),
  appliedAt: v.optional(v.string())
}));

export type AIPriceOptimizationCreate = v.InferOutput<typeof aIPriceOptimizationCreateSchema>;
export type AIPriceOptimizationUpdate = v.InferOutput<typeof aIPriceOptimizationUpdateSchema>;

// AISentimentAnalysis Schemas (JP)
export const aISentimentAnalysisCreateSchema = v.object({
  contentType: v.string(),
  contentId: v.string(),
  contentText: v.string(),
  sentiment: v.string(),
  sentimentScore: v.number(),
  confidence: v.number(),
  analyzedAt: v.string()
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
  emotions: v.optional(v.unknown()),
  analyzedAt: v.optional(v.string())
}));

export type AISentimentAnalysisCreate = v.InferOutput<typeof aISentimentAnalysisCreateSchema>;
export type AISentimentAnalysisUpdate = v.InferOutput<typeof aISentimentAnalysisUpdateSchema>;

// AIFraudDetection Schemas (JP)
export const aIFraudDetectionCreateSchema = v.object({
  entityType: v.string(),
  entityId: v.string(),
  riskScore: v.number(),
  riskFactors: v.unknown(),
  riskCategory: v.string(),
  detectedAt: v.string()
});

export const aIFraudDetectionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  entityId: v.optional(v.string()),
  riskScore: v.optional(v.number()),
  riskFactors: v.optional(v.unknown()),
  riskCategory: v.optional(v.string()),
  recommendedActions: v.optional(v.unknown()),
  detectedAt: v.optional(v.string()),
  reviewedAt: v.optional(v.string()),
  reviewedBy: v.optional(v.string()),
  resolution: v.optional(v.string())
}));

export type AIFraudDetectionCreate = v.InferOutput<typeof aIFraudDetectionCreateSchema>;
export type AIFraudDetectionUpdate = v.InferOutput<typeof aIFraudDetectionUpdateSchema>;

// AIRecommendation Schemas (JP)
export const aIRecommendationCreateSchema = v.object({
  userType: v.string(),
  userId: v.string(),
  recommendedProperties: v.unknown(),
  recommendationType: v.string(),
  userPreferences: v.unknown(),
  reasoning: v.unknown(),
  generatedAt: v.string()
});

export const aIRecommendationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userType: v.optional(v.string()),
  userId: v.optional(v.string()),
  sessionId: v.optional(v.string()),
  recommendedProperties: v.optional(v.unknown()),
  recommendationType: v.optional(v.string()),
  userPreferences: v.optional(v.unknown()),
  reasoning: v.optional(v.unknown()),
  generatedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string())
}));

export type AIRecommendationCreate = v.InferOutput<typeof aIRecommendationCreateSchema>;
export type AIRecommendationUpdate = v.InferOutput<typeof aIRecommendationUpdateSchema>;

// AIChatbotSession Schemas (JP)
export const aIChatbotSessionCreateSchema = v.object({
  sessionId: v.string(),
  conversationHistory: v.unknown(),
  startedAt: v.string(),
  lastActivityAt: v.string()
});

export const aIChatbotSessionUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  userId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  sessionId: v.optional(v.string()),
  conversationHistory: v.optional(v.unknown()),
  intent: v.optional(v.string()),
  confidence: v.optional(v.number()),
  status: v.optional(v.string()),
  transferredTo: v.optional(v.string()),
  startedAt: v.optional(v.string()),
  lastActivityAt: v.optional(v.string()),
  endedAt: v.optional(v.string()),
  satisfaction: v.optional(v.number())
}));

export type AIChatbotSessionCreate = v.InferOutput<typeof aIChatbotSessionCreateSchema>;
export type AIChatbotSessionUpdate = v.InferOutput<typeof aIChatbotSessionUpdateSchema>;

// AIPredictiveMaintenance Schemas (JP)
export const aIPredictiveMaintenanceCreateSchema = v.object({
  propertyId: v.string(),
  componentType: v.string(),
  failureProbability: v.number(),
  riskLevel: v.string(),
  contributingFactors: v.unknown(),
  generatedAt: v.string()
});

export const aIPredictiveMaintenanceUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  componentType: v.optional(v.string()),
  failureProbability: v.optional(v.number()),
  predictedFailureDate: v.optional(v.string()),
  riskLevel: v.optional(v.string()),
  estimatedCost: v.optional(v.number()),
  contributingFactors: v.optional(v.unknown()),
  lastInspectionDate: v.optional(v.string()),
  recommendedAction: v.optional(v.string()),
  generatedAt: v.optional(v.string())
}));

export type AIPredictiveMaintenanceCreate = v.InferOutput<typeof aIPredictiveMaintenanceCreateSchema>;
export type AIPredictiveMaintenanceUpdate = v.InferOutput<typeof aIPredictiveMaintenanceUpdateSchema>;

// AITenantScreening Schemas (JP)
export const aITenantScreeningCreateSchema = v.object({
  applicationId: v.string(),
  overallScore: v.number(),
  riskAssessment: v.string(),
  riskFactors: v.unknown(),
  recommendations: v.unknown(),
  screenedAt: v.string()
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
  riskFactors: v.optional(v.unknown()),
  recommendations: v.optional(v.unknown()),
  screenedAt: v.optional(v.string()),
  reviewedBy: v.optional(v.string()),
  finalDecision: v.optional(v.string())
}));

export type AITenantScreeningCreate = v.InferOutput<typeof aITenantScreeningCreateSchema>;
export type AITenantScreeningUpdate = v.InferOutput<typeof aITenantScreeningUpdateSchema>;

// AIInvestmentAnalysis Schemas (JP)
export const aIInvestmentAnalysisCreateSchema = v.object({
  propertyId: v.string(),
  analysisType: v.string(),
  timeHorizon: v.string(),
  projectedReturns: v.unknown(),
  cashFlowProjection: v.unknown(),
  riskMetrics: v.unknown(),
  keyAssumptions: v.unknown(),
  sensitivityAnalysis: v.unknown(),
  confidence: v.number(),
  generatedAt: v.string()
});

export const aIInvestmentAnalysisUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  analysisType: v.optional(v.string()),
  timeHorizon: v.optional(v.string()),
  projectedReturns: v.optional(v.unknown()),
  cashFlowProjection: v.optional(v.unknown()),
  riskMetrics: v.optional(v.unknown()),
  keyAssumptions: v.optional(v.unknown()),
  sensitivityAnalysis: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  generatedAt: v.optional(v.string())
}));

export type AIInvestmentAnalysisCreate = v.InferOutput<typeof aIInvestmentAnalysisCreateSchema>;
export type AIInvestmentAnalysisUpdate = v.InferOutput<typeof aIInvestmentAnalysisUpdateSchema>;

// MobileDevice Schemas (JP)
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

// OfflineSyncQueue Schemas (JP)
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

// DashboardConfiguration Schemas (JP)
export const dashboardConfigurationCreateSchema = v.object({
  userId: v.string(),
  dashboardName: v.string(),
  layout: v.unknown(),
  widgets: v.unknown(),
  sharedWith: v.string()
});

export const dashboardConfigurationUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  dashboardName: v.optional(v.string()),
  isDefault: v.optional(v.boolean()),
  layout: v.optional(v.unknown()),
  widgets: v.optional(v.unknown()),
  filters: v.optional(v.unknown()),
  timeRange: v.optional(v.string()),
  isPublic: v.optional(v.boolean()),
  sharedWith: v.optional(v.string())
}));

export type DashboardConfigurationCreate = v.InferOutput<typeof dashboardConfigurationCreateSchema>;
export type DashboardConfigurationUpdate = v.InferOutput<typeof dashboardConfigurationUpdateSchema>;

// SystemMetrics Schemas (JP)
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
  dimensions: v.optional(v.unknown()),
  tags: v.optional(v.unknown()),
  collectedAt: v.optional(v.string())
}));

export type SystemMetricsCreate = v.InferOutput<typeof systemMetricsCreateSchema>;
export type SystemMetricsUpdate = v.InferOutput<typeof systemMetricsUpdateSchema>;

// HealthCheck Schemas (JP)
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

// PerformanceAlert Schemas (JP)
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

// EscrowAccount Schemas (JP)
export const escrowAccountCreateSchema = v.object({
  orgId: v.string(),
  reservationId: v.string(),
  totalAmount: v.number(),
  depositAmount: v.number()
});

export const escrowAccountUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  totalAmount: v.optional(v.number()),
  depositAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(EscrowStatus)),
  heldAt: v.optional(v.string()),
  releasedAt: v.optional(v.string())
}));

export type EscrowAccountCreate = v.InferOutput<typeof escrowAccountCreateSchema>;
export type EscrowAccountUpdate = v.InferOutput<typeof escrowAccountUpdateSchema>;

// EscrowRelease Schemas (JP)
export const escrowReleaseCreateSchema = v.object({
  orgId: v.string(),
  escrowId: v.string(),
  triggerEvent: v.enum_(EscrowTriggerEvent),
  releasePercent: v.number(),
  amount: v.number(),
  approvalRequiredBy: v.string()
});

export const escrowReleaseUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  escrowId: v.optional(v.string()),
  triggerEvent: v.optional(v.enum_(EscrowTriggerEvent)),
  releasePercent: v.optional(v.number()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(EscrowReleaseStatus)),
  scheduledAt: v.optional(v.string()),
  releasedAt: v.optional(v.string()),
  approvalRequiredBy: v.optional(v.string()),
  approvals: v.optional(v.unknown()),
  approvalCompletedAt: v.optional(v.string()),
  approvedBy: v.optional(v.string()),
  failureReason: v.optional(v.string()),
  retryCount: v.optional(v.number()),
  notes: v.optional(v.string())
}));

export type EscrowReleaseCreate = v.InferOutput<typeof escrowReleaseCreateSchema>;
export type EscrowReleaseUpdate = v.InferOutput<typeof escrowReleaseUpdateSchema>;

// EscrowDispute Schemas (JP)
export const escrowDisputeCreateSchema = v.object({
  orgId: v.string(),
  reservationId: v.string(),
  escrowAccountId: v.string(),
  openedBy: v.enum_(EscrowDisputeParty),
  disputeType: v.enum_(EscrowDisputeType),
  description: v.string()
});

export const escrowDisputeUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  escrowAccountId: v.optional(v.string()),
  openedBy: v.optional(v.enum_(EscrowDisputeParty)),
  disputeType: v.optional(v.enum_(EscrowDisputeType)),
  description: v.optional(v.string()),
  claimedAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(EscrowDisputeStatus)),
  evidence: v.optional(v.unknown()),
  resolution: v.optional(v.string()),
  resolvedAmount: v.optional(v.number()),
  resolvedAt: v.optional(v.string()),
  resolvedBy: v.optional(v.string()),
  moderatorNotes: v.optional(v.string()),
  escalatedAt: v.optional(v.string()),
  deadlineAt: v.optional(v.string())
}));

export type EscrowDisputeCreate = v.InferOutput<typeof escrowDisputeCreateSchema>;
export type EscrowDisputeUpdate = v.InferOutput<typeof escrowDisputeUpdateSchema>;

// AIChatMessage Schemas (JP)
export const aIChatMessageCreateSchema = v.object({
  sessionId: v.string(),
  role: v.enum_(AIChatRole),
  content: v.string(),
  piiTypes: v.string(),
  moduleType: v.enum_(AIChatModuleType)
});

export const aIChatMessageUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  sessionId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  role: v.optional(v.enum_(AIChatRole)),
  content: v.optional(v.string()),
  contentHash: v.optional(v.string()),
  redactedContent: v.optional(v.string()),
  piiDetected: v.optional(v.boolean()),
  piiTypes: v.optional(v.string()),
  language: v.optional(v.string()),
  isAI: v.optional(v.boolean()),
  escalationTag: v.optional(v.string()),
  escalationTopic: v.optional(v.string()),
  paymentAgreed: v.optional(v.boolean()),
  paymentPlan: v.optional(v.unknown()),
  securityFlag: v.optional(v.boolean()),
  securityReason: v.optional(v.string()),
  moduleType: v.optional(v.enum_(AIChatModuleType)),
  metadata: v.optional(v.unknown()),
  tokenCount: v.optional(v.number()),
  processingMs: v.optional(v.number())
}));

export type AIChatMessageCreate = v.InferOutput<typeof aIChatMessageCreateSchema>;
export type AIChatMessageUpdate = v.InferOutput<typeof aIChatMessageUpdateSchema>;

// AIChatHandoff Schemas (JP)
export const aIChatHandoffCreateSchema = v.object({
  sessionId: v.string(),
  handoffReason: v.string(),
  handoffTo: v.string()
});

export const aIChatHandoffUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  sessionId: v.optional(v.string()),
  handoffReason: v.optional(v.string()),
  handoffTo: v.optional(v.string()),
  handoffAt: v.optional(v.string()),
  resolvedAt: v.optional(v.string()),
  resolvedBy: v.optional(v.string()),
  notes: v.optional(v.string())
}));

export type AIChatHandoffCreate = v.InferOutput<typeof aIChatHandoffCreateSchema>;
export type AIChatHandoffUpdate = v.InferOutput<typeof aIChatHandoffUpdateSchema>;

// PaymentNegotiation Schemas (JP)
export const paymentNegotiationCreateSchema = v.object({
  orgId: v.string(),
  reservationId: v.string(),
  tenantContactId: v.string()
});

export const paymentNegotiationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  tenantContactId: v.optional(v.string()),
  ownerContactId: v.optional(v.string()),
  ownerUserId: v.optional(v.string()),
  status: v.optional(v.enum_(PaymentNegotiationStatus)),
  maxInstallments: v.optional(v.number()),
  minFirstPaymentPct: v.optional(v.number()),
  platformValidated: v.optional(v.boolean()),
  validationNotes: v.optional(v.string()),
  agreedOfferId: v.optional(v.string()),
  agreedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  reminderSentAt: v.optional(v.string())
}));

export type PaymentNegotiationCreate = v.InferOutput<typeof paymentNegotiationCreateSchema>;
export type PaymentNegotiationUpdate = v.InferOutput<typeof paymentNegotiationUpdateSchema>;

// NegotiationOffer Schemas (JP)
export const negotiationOfferCreateSchema = v.object({
  negotiationId: v.string(),
  offeredBy: v.enum_(NegotiationParty),
  installmentCount: v.number(),
  firstPaymentPct: v.number(),
  totalAmount: v.number()
});

export const negotiationOfferUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  negotiationId: v.optional(v.string()),
  offeredBy: v.optional(v.enum_(NegotiationParty)),
  installmentCount: v.optional(v.number()),
  firstPaymentPct: v.optional(v.number()),
  totalAmount: v.optional(v.number()),
  currency: v.optional(v.string()),
  notes: v.optional(v.string()),
  status: v.optional(v.enum_(NegotiationOfferStatus)),
  offeredAt: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  respondedAt: v.optional(v.string())
}));

export type NegotiationOfferCreate = v.InferOutput<typeof negotiationOfferCreateSchema>;
export type NegotiationOfferUpdate = v.InferOutput<typeof negotiationOfferUpdateSchema>;

// PaymentInstallment Schemas (JP)
export const paymentInstallmentCreateSchema = v.object({
  orgId: v.string(),
  negotiationId: v.string(),
  installmentNo: v.number(),
  amount: v.number(),
  dueDate: v.string()
});

export const paymentInstallmentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  negotiationId: v.optional(v.string()),
  installmentNo: v.optional(v.number()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  dueDate: v.optional(v.string()),
  status: v.optional(v.enum_(PaymentStatus)),
  paidAt: v.optional(v.string()),
  paymentMethod: v.optional(v.enum_(PaymentMethodUS)),
  referenceNo: v.optional(v.string()),
  notes: v.optional(v.string())
}));

export type PaymentInstallmentCreate = v.InferOutput<typeof paymentInstallmentCreateSchema>;
export type PaymentInstallmentUpdate = v.InferOutput<typeof paymentInstallmentUpdateSchema>;

// VideoContent Schemas (JP)
export const videoContentCreateSchema = v.object({
  orgId: v.string(),
  primaryLoraStyle: v.enum_(VideoLoraStyle),
  prompt: v.string(),
  platform: v.enum_(VideoTargetPlatform)
});

export const videoContentUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  ambassadorId: v.optional(v.string()),
  ambassadorCampaignId: v.optional(v.string()),
  title: v.optional(v.string()),
  primaryLoraStyle: v.optional(v.enum_(VideoLoraStyle)),
  secondaryLoraStyle: v.optional(v.enum_(VideoLoraStyle)),
  primaryLoraScale: v.optional(v.number()),
  secondaryLoraScale: v.optional(v.number()),
  pipeline: v.optional(v.enum_(VideoPipeline)),
  prompt: v.optional(v.string()),
  negativePrompt: v.optional(v.string()),
  strategy: v.optional(v.enum_(VideoLoraStrategy)),
  durationSeconds: v.optional(v.number()),
  platform: v.optional(v.enum_(VideoTargetPlatform)),
  status: v.optional(v.enum_(VideoContentStatus)),
  renderingJobId: v.optional(v.string()),
  storageKey: v.optional(v.string()),
  url: v.optional(v.string()),
  thumbnailUrl: v.optional(v.string()),
  fileSize: v.optional(v.number()),
  mimeType: v.optional(v.string()),
  publishedAt: v.optional(v.string()),
  engagementData: v.optional(v.unknown()),
  campaignType: v.optional(v.enum_(VideoCampaignType)),
  abTestGroup: v.optional(v.string()),
  createdBy: v.optional(v.string()),
  campaignId: v.optional(v.string())
}));

export type VideoContentCreate = v.InferOutput<typeof videoContentCreateSchema>;
export type VideoContentUpdate = v.InferOutput<typeof videoContentUpdateSchema>;

// BrandAmbassador Schemas (JP)
export const brandAmbassadorCreateSchema = v.object({
  orgId: v.string(),
  fullName: v.string(),
  category: v.enum_(AmbassadorCategory),
  platform: v.string()
});

export const brandAmbassadorUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  fullName: v.optional(v.string()),
  emailCiphertext: v.optional(v.pipe(v.string(), v.email())),
  phoneCiphertext: v.optional(v.string()),
  category: v.optional(v.enum_(AmbassadorCategory)),
  platform: v.optional(v.string()),
  followerCount: v.optional(v.number()),
  engagementRate: v.optional(v.number()),
  contractStart: v.optional(v.string()),
  contractEnd: v.optional(v.string()),
  equityPercent: v.optional(v.number()),
  upfrontFee: v.optional(v.number()),
  currency: v.optional(v.string()),
  tier: v.optional(v.string()),
  status: v.optional(v.enum_(AmbassadorStatus)),
  agencyName: v.optional(v.string()),
  agencyContact: v.optional(v.string()),
  ndaSigned: v.optional(v.boolean()),
  ndaSignedAt: v.optional(v.string()),
  notes: v.optional(v.string()),
  pitchSentAt: v.optional(v.string()),
  respondedAt: v.optional(v.string()),
  signedAt: v.optional(v.string()),
  actualReach: v.optional(v.number()),
  totalRoi: v.optional(v.number())
}));

export type BrandAmbassadorCreate = v.InferOutput<typeof brandAmbassadorCreateSchema>;
export type BrandAmbassadorUpdate = v.InferOutput<typeof brandAmbassadorUpdateSchema>;

// AmbassadorContract Schemas (JP)
export const ambassadorContractCreateSchema = v.object({
  ambassadorId: v.string(),
  version: v.number(),
  startDate: v.string()
});

export const ambassadorContractUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  ambassadorId: v.optional(v.string()),
  version: v.optional(v.number()),
  equityPercent: v.optional(v.number()),
  upfrontFee: v.optional(v.number()),
  currency: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  signedAt: v.optional(v.string()),
  documentUrl: v.optional(v.string()),
  status: v.optional(v.enum_(ContractStatus)),
  notes: v.optional(v.string())
}));

export type AmbassadorContractCreate = v.InferOutput<typeof ambassadorContractCreateSchema>;
export type AmbassadorContractUpdate = v.InferOutput<typeof ambassadorContractUpdateSchema>;

// AmbassadorCampaign Schemas (JP)
export const ambassadorCampaignCreateSchema = v.object({
  orgId: v.string(),
  ambassadorId: v.string(),
  name: v.string(),
  platforms: v.string()
});

export const ambassadorCampaignUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  ambassadorId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  budget: v.optional(v.number()),
  actualSpend: v.optional(v.number()),
  currency: v.optional(v.string()),
  status: v.optional(v.enum_(CampaignStatus)),
  targetReach: v.optional(v.number()),
  actualReach: v.optional(v.number()),
  impressions: v.optional(v.number()),
  clicks: v.optional(v.number()),
  conversions: v.optional(v.number()),
  conversionValue: v.optional(v.number()),
  roi: v.optional(v.number()),
  content: v.optional(v.unknown()),
  platforms: v.optional(v.string())
}));

export type AmbassadorCampaignCreate = v.InferOutput<typeof ambassadorCampaignCreateSchema>;
export type AmbassadorCampaignUpdate = v.InferOutput<typeof ambassadorCampaignUpdateSchema>;

// SocialImpactCounter Schemas (JP)
export const socialImpactCounterCreateSchema = v.object({
  orgId: v.string(),
  impactType: v.enum_(SocialImpactType)
});

export const socialImpactCounterUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  impactType: v.optional(v.enum_(SocialImpactType)),
  currency: v.optional(v.string()),
  partnerName: v.optional(v.string()),
  partnerUrl: v.optional(v.string()),
  partnerOrgId: v.optional(v.string()),
  campaignTag: v.optional(v.string()),
  isPublic: v.optional(v.boolean()),
  displayGoal: v.optional(v.number())
}));

export type SocialImpactCounterCreate = v.InferOutput<typeof socialImpactCounterCreateSchema>;
export type SocialImpactCounterUpdate = v.InferOutput<typeof socialImpactCounterUpdateSchema>;

// SocialImpactRecord Schemas (JP)
export const socialImpactRecordCreateSchema = v.object({
  orgId: v.string(),
  counterId: v.string(),
  impactType: v.enum_(SocialImpactType)
});

export const socialImpactRecordUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  counterId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  impactType: v.optional(v.enum_(SocialImpactType)),
  quantity: v.optional(v.number()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  description: v.optional(v.string()),
  verifiedAt: v.optional(v.string()),
  verifiedBy: v.optional(v.string()),
  proofUrl: v.optional(v.string())
}));

export type SocialImpactRecordCreate = v.InferOutput<typeof socialImpactRecordCreateSchema>;
export type SocialImpactRecordUpdate = v.InferOutput<typeof socialImpactRecordUpdateSchema>;

// SocialAccount Schemas (JP)
export const socialAccountCreateSchema = v.object({
  // No required fields
});

export const socialAccountUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAccountCreate = v.InferOutput<typeof socialAccountCreateSchema>;
export type SocialAccountUpdate = v.InferOutput<typeof socialAccountUpdateSchema>;

// SocialPost Schemas (JP)
export const socialPostCreateSchema = v.object({
  // No required fields
});

export const socialPostUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialPostCreate = v.InferOutput<typeof socialPostCreateSchema>;
export type SocialPostUpdate = v.InferOutput<typeof socialPostUpdateSchema>;

// SocialAIContent Schemas (JP)
export const socialAIContentCreateSchema = v.object({
  // No required fields
});

export const socialAIContentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAIContentCreate = v.InferOutput<typeof socialAIContentCreateSchema>;
export type SocialAIContentUpdate = v.InferOutput<typeof socialAIContentUpdateSchema>;

// SocialInboundMessage Schemas (JP)
export const socialInboundMessageCreateSchema = v.object({
  // No required fields
});

export const socialInboundMessageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialInboundMessageCreate = v.InferOutput<typeof socialInboundMessageCreateSchema>;
export type SocialInboundMessageUpdate = v.InferOutput<typeof socialInboundMessageUpdateSchema>;

// SocialCommentReply Schemas (JP)
export const socialCommentReplyCreateSchema = v.object({
  // No required fields
});

export const socialCommentReplyUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialCommentReplyCreate = v.InferOutput<typeof socialCommentReplyCreateSchema>;
export type SocialCommentReplyUpdate = v.InferOutput<typeof socialCommentReplyUpdateSchema>;

// SocialAutomationRule Schemas (JP)
export const socialAutomationRuleCreateSchema = v.object({
  // No required fields
});

export const socialAutomationRuleUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAutomationRuleCreate = v.InferOutput<typeof socialAutomationRuleCreateSchema>;
export type SocialAutomationRuleUpdate = v.InferOutput<typeof socialAutomationRuleUpdateSchema>;

// SocialAccountMetric Schemas (JP)
export const socialAccountMetricCreateSchema = v.object({
  // No required fields
});

export const socialAccountMetricUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SocialAccountMetricCreate = v.InferOutput<typeof socialAccountMetricCreateSchema>;
export type SocialAccountMetricUpdate = v.InferOutput<typeof socialAccountMetricUpdateSchema>;

// EscrowStatusHistory Schemas (JP)
export const escrowStatusHistoryCreateSchema = v.object({
  escrowId: v.string(),
  fromStatus: v.enum_(EscrowStatus),
  toStatus: v.enum_(EscrowStatus),
  changedBy: v.string()
});

export const escrowStatusHistoryUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  escrowId: v.optional(v.string()),
  fromStatus: v.optional(v.enum_(EscrowStatus)),
  toStatus: v.optional(v.enum_(EscrowStatus)),
  changedBy: v.optional(v.string()),
  reason: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  changedAt: v.optional(v.string())
}));

export type EscrowStatusHistoryCreate = v.InferOutput<typeof escrowStatusHistoryCreateSchema>;
export type EscrowStatusHistoryUpdate = v.InferOutput<typeof escrowStatusHistoryUpdateSchema>;

// Account Schemas (JP)
export const accountCreateSchema = v.object({
  userId: v.string(),
  providerId: v.string(),
  accountId: v.string()
});

export const accountUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  type: v.optional(v.enum_(AccountType)),
  providerId: v.optional(v.string()),
  accountId: v.optional(v.string()),
  refreshToken: v.optional(v.string()),
  accessToken: v.optional(v.string()),
  accessTokenExpiresAt: v.optional(v.string()),
  tokenType: v.optional(v.string()),
  scope: v.optional(v.string()),
  idToken: v.optional(v.string()),
  sessionState: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type AccountCreate = v.InferOutput<typeof accountCreateSchema>;
export type AccountUpdate = v.InferOutput<typeof accountUpdateSchema>;

// Agency Schemas (JP)
export const agencyCreateSchema = v.object({
  organizationId: v.string(),
  name: v.string()
});

export const agencyUpdateSchema = v.partial(v.object({
  organizationId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  phoneNumber: v.optional(v.string()),
  address: v.optional(v.string()),
  website: v.optional(v.string()),
  logoUrl: v.optional(v.string()),
  status: v.optional(v.enum_(SharedStatus)),
  facilityId: v.optional(v.string()),
  includedServiceId: v.optional(v.string()),
  extraChargeId: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  ownerId: v.optional(v.string()),
  settings: v.optional(v.unknown()),
  theme: v.optional(v.string()),
  externalId: v.optional(v.string()),
  integration: v.optional(v.unknown()),
  totalProperties: v.optional(v.number()),
  totalAgents: v.optional(v.number()),
  establishedYear: v.optional(v.number()),
  licenseNumber: v.optional(v.string()),
  commissionRate: v.optional(v.number()),
  taxIdentificationNumber: v.optional(v.string()),
  taxJurisdiction: v.optional(v.string()),
  metrics: v.optional(v.unknown()),
  taxConfiguration: v.optional(v.unknown())
}));

export type AgencyCreate = v.InferOutput<typeof agencyCreateSchema>;
export type AgencyUpdate = v.InferOutput<typeof agencyUpdateSchema>;

// Agent Schemas (JP)
export const agentCreateSchema = v.object({
  name: v.string(),
  specialities: v.enum_(AgentSpecialities)
});

export const agentUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  phoneNumber: v.optional(v.string()),
  bio: v.optional(v.string()),
  locationId: v.optional(v.string()),
  address: v.optional(v.string()),
  website: v.optional(v.string()),
  logoUrl: v.optional(v.string()),
  status: v.optional(v.enum_(SharedStatus)),
  agencyId: v.optional(v.string()),
  licenseNumber: v.optional(v.string()),
  licenseState: v.optional(v.string()),
  licenseType: v.optional(v.string()),
  licenseExpiryDate: v.optional(v.string()),
  licenseStatus: v.optional(v.string()),
  licenseVerified: v.optional(v.boolean()),
  licenseVerifiedAt: v.optional(v.string()),
  verificationMethod: v.optional(v.string()),
  commissionRate: v.optional(v.number()),
  specialties: v.optional(v.string()),
  serviceAreas: v.optional(v.string()),
  yearsOfExperience: v.optional(v.number()),
  experienceLevel: v.optional(v.string()),
  certifications: v.optional(v.string()),
  education: v.optional(v.string()),
  languages: v.optional(v.string()),
  performanceMetrics: v.optional(v.unknown()),
  taxConfiguration: v.optional(v.unknown()),
  availability: v.optional(v.unknown()),
  socialMedia: v.optional(v.unknown()),
  totalTransactions: v.optional(v.number()),
  totalVolume: v.optional(v.number()),
  avgTransactionValue: v.optional(v.number()),
  clientSatisfaction: v.optional(v.number()),
  responseRate: v.optional(v.number()),
  responseTime: v.optional(v.number()),
  closingRate: v.optional(v.number()),
  marketExpertise: v.optional(v.unknown()),
  negotiationSkills: v.optional(v.unknown()),
  technologyAdoption: v.optional(v.unknown()),
  tierLevel: v.optional(v.string()),
  monthlyRevenue: v.optional(v.number()),
  quarterlyRevenue: v.optional(v.number()),
  annualRevenue: v.optional(v.number()),
  revenueGrowthRate: v.optional(v.number()),
  leadConversionRate: v.optional(v.number()),
  clientRetentionRate: v.optional(v.number()),
  referralRate: v.optional(v.number()),
  videoVendorEnabled: v.optional(v.boolean()),
  videoVendorTier: v.optional(v.string()),
  videoCommission: v.optional(v.number()),
  videoPartnerships: v.optional(v.unknown()),
  contentQuality: v.optional(v.unknown()),
  videoAnalytics: v.optional(v.unknown()),
  specialities: v.optional(v.enum_(AgentSpecialities)),
  settings: v.optional(v.unknown()),
  externalId: v.optional(v.string()),
  integration: v.optional(v.unknown()),
  ownerId: v.optional(v.string()),
  lastActive: v.optional(v.string())
}));

export type AgentCreate = v.InferOutput<typeof agentCreateSchema>;
export type AgentUpdate = v.InferOutput<typeof agentUpdateSchema>;

// Analytics Schemas (JP)
export const analyticsCreateSchema = v.object({
  entityId: v.string(),
  entityType: v.string(),
  type: v.enum_(AnalyticsType)
});

export const analyticsUpdateSchema = v.partial(v.object({
  entityId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  type: v.optional(v.enum_(AnalyticsType)),
  data: v.optional(v.unknown()),
  timestamp: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  userId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  taskId: v.optional(v.string()),
  taxRecordId: v.optional(v.string())
}));

export type AnalyticsCreate = v.InferOutput<typeof analyticsCreateSchema>;
export type AnalyticsUpdate = v.InferOutput<typeof analyticsUpdateSchema>;

// AutomationTask Schemas (JP)
export const automationTaskCreateSchema = v.object({
  taskType: v.string(),
  status: v.string(),
  configuration: v.unknown()
});

export const automationTaskUpdateSchema = v.partial(v.object({
  taskType: v.optional(v.string()),
  persona: v.optional(v.string()),
  command: v.optional(v.string()),
  status: v.optional(v.string()),
  schedule: v.optional(v.string()),
  lastRun: v.optional(v.string()),
  nextRun: v.optional(v.string()),
  configuration: v.optional(v.unknown()),
  result: v.optional(v.unknown()),
  error: v.optional(v.string())
}));

export type AutomationTaskCreate = v.InferOutput<typeof automationTaskCreateSchema>;
export type AutomationTaskUpdate = v.InferOutput<typeof automationTaskUpdateSchema>;

// Availability Schemas (JP)
export const availabilityCreateSchema = v.object({
  date: v.string(),
  propertyId: v.string()
});

export const availabilityUpdateSchema = v.partial(v.object({
  date: v.optional(v.string()),
  isBlocked: v.optional(v.boolean()),
  isBooked: v.optional(v.boolean()),
  propertyId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  pricingRuleId: v.optional(v.string()),
  totalUnits: v.optional(v.number()),
  availableUnits: v.optional(v.number()),
  bookedUnits: v.optional(v.number()),
  blockedUnits: v.optional(v.number()),
  specialPricing: v.optional(v.unknown()),
  basePrice: v.optional(v.number()),
  currentPrice: v.optional(v.number()),
  priceSettings: v.optional(v.unknown()),
  minNights: v.optional(v.number()),
  maxNights: v.optional(v.number()),
  maxGuests: v.optional(v.number()),
  discountSettings: v.optional(v.unknown()),
  weekendRate: v.optional(v.number()),
  weekdayRate: v.optional(v.number()),
  weekendMultiplier: v.optional(v.number()),
  weekdayMultiplier: v.optional(v.number()),
  seasonalMultiplier: v.optional(v.number())
}));

export type AvailabilityCreate = v.InferOutput<typeof availabilityCreateSchema>;
export type AvailabilityUpdate = v.InferOutput<typeof availabilityUpdateSchema>;

// Channel Schemas (JP)
export const channelCreateSchema = v.object({
  name: v.string()
});

export const channelUpdateSchema = v.partial(v.object({
  cuid: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.enum_(ChannelType)),
  category: v.optional(v.enum_(ChannelCategory)),
  description: v.optional(v.string())
}));

export type ChannelCreate = v.InferOutput<typeof channelCreateSchema>;
export type ChannelUpdate = v.InferOutput<typeof channelUpdateSchema>;

// CommissionRule Schemas (JP)
export const commissionRuleCreateSchema = v.object({
  providerId: v.string(),
  ruleType: v.enum_(CommissionRuleType),
  commission: v.number()
});

export const commissionRuleUpdateSchema = v.partial(v.object({
  providerId: v.optional(v.string()),
  ruleType: v.optional(v.enum_(CommissionRuleType)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  commission: v.optional(v.number()),
  minVolume: v.optional(v.number()),
  maxVolume: v.optional(v.number()),
  conditions: v.optional(v.unknown())
}));

export type CommissionRuleCreate = v.InferOutput<typeof commissionRuleCreateSchema>;
export type CommissionRuleUpdate = v.InferOutput<typeof commissionRuleUpdateSchema>;

// CommunicationLog Schemas (JP)
export const communicationLogCreateSchema = v.object({
  senderId: v.string(),
  receiverId: v.string(),
  type: v.enum_(CommunicationType),
  content: v.string()
});

export const communicationLogUpdateSchema = v.partial(v.object({
  senderId: v.optional(v.string()),
  receiverId: v.optional(v.string()),
  type: v.optional(v.enum_(CommunicationType)),
  content: v.optional(v.string()),
  entityId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  isRead: v.optional(v.boolean()),
  readAt: v.optional(v.string()),
  deliveredAt: v.optional(v.string()),
  timestamp: v.optional(v.string()),
  userId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  threadId: v.optional(v.string()),
  replyToId: v.optional(v.string()),
  channelId: v.optional(v.string()),
  ticketId: v.optional(v.string()),
  isEdited: v.optional(v.boolean()),
  editedAt: v.optional(v.string()),
  deletedById: v.optional(v.string()),
  reactions: v.optional(v.unknown()),
  attachments: v.optional(v.unknown()),
  readBy: v.optional(v.unknown())
}));

export type CommunicationLogCreate = v.InferOutput<typeof communicationLogCreateSchema>;
export type CommunicationLogUpdate = v.InferOutput<typeof communicationLogUpdateSchema>;

// ComplianceRecord Schemas (JP)
export const complianceRecordCreateSchema = v.object({
  entityId: v.string(),
  entityType: v.string(),
  type: v.enum_(ComplianceType),
  status: v.enum_(ComplianceStatus)
});

export const complianceRecordUpdateSchema = v.partial(v.object({
  entityId: v.optional(v.string()),
  entityType: v.optional(v.string()),
  type: v.optional(v.enum_(ComplianceType)),
  status: v.optional(v.enum_(ComplianceStatus)),
  documentUrl: v.optional(v.string()),
  expiryDate: v.optional(v.string()),
  notes: v.optional(v.string()),
  isVerified: v.optional(v.boolean()),
  propertyId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  reservationId: v.optional(v.string())
}));

export type ComplianceRecordCreate = v.InferOutput<typeof complianceRecordCreateSchema>;
export type ComplianceRecordUpdate = v.InferOutput<typeof complianceRecordUpdateSchema>;

// Currency Schemas (JP)
export const currencyCreateSchema = v.object({
  code: v.string(),
  name: v.string(),
  symbol: v.string(),
  exchangeRate: v.number()
});

export const currencyUpdateSchema = v.partial(v.object({
  code: v.optional(v.string()),
  name: v.optional(v.string()),
  symbol: v.optional(v.string()),
  exchangeRate: v.optional(v.number()),
  isActive: v.optional(v.boolean())
}));

export type CurrencyCreate = v.InferOutput<typeof currencyCreateSchema>;
export type CurrencyUpdate = v.InferOutput<typeof currencyUpdateSchema>;

// Discount Schemas (JP)
export const discountCreateSchema = v.object({
  name: v.string(),
  value: v.number(),
  type: v.enum_(DiscountType),
  propertyId: v.string()
});

export const discountUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  code: v.optional(v.string()),
  value: v.optional(v.number()),
  type: v.optional(v.enum_(DiscountType)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  maxUsage: v.optional(v.number()),
  currentUsage: v.optional(v.number()),
  isActive: v.optional(v.boolean()),
  propertyId: v.optional(v.string()),
  pricingRuleId: v.optional(v.string())
}));

export type DiscountCreate = v.InferOutput<typeof discountCreateSchema>;
export type DiscountUpdate = v.InferOutput<typeof discountUpdateSchema>;

// Expense Schemas (JP)
export const expenseCreateSchema = v.object({
  type: v.enum_(ExpenseType),
  amount: v.number(),
  currencyId: v.string()
});

export const expenseUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  type: v.optional(v.enum_(ExpenseType)),
  amount: v.optional(v.number()),
  currencyId: v.optional(v.string()),
  dueDate: v.optional(v.string()),
  paidDate: v.optional(v.string()),
  status: v.optional(v.enum_(ExpenseStatus)),
  notes: v.optional(v.string()),
  facilityId: v.optional(v.string()),
  includedServiceId: v.optional(v.string()),
  extraChargeId: v.optional(v.string())
}));

export type ExpenseCreate = v.InferOutput<typeof expenseCreateSchema>;
export type ExpenseUpdate = v.InferOutput<typeof expenseUpdateSchema>;

// ExtraCharge Schemas (JP)
export const extraChargeCreateSchema = v.object({
  reservationId: v.string(),
  name: v.string(),
  amount: v.number(),
  facilityAmenities: v.enum_(FacilityAmenities),
  locationAmenities: v.enum_(LocationAmenities)
});

export const extraChargeUpdateSchema = v.partial(v.object({
  reservationId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  amount: v.optional(v.number()),
  chargeType: v.optional(v.string()),
  isPaid: v.optional(v.boolean()),
  icon: v.optional(v.string()),
  logo: v.optional(v.string()),
  facilityAmenities: v.optional(v.enum_(FacilityAmenities)),
  locationAmenities: v.optional(v.enum_(LocationAmenities)),
  facilityId: v.optional(v.string()),
  includedServiceId: v.optional(v.string())
}));

export type ExtraChargeCreate = v.InferOutput<typeof extraChargeCreateSchema>;
export type ExtraChargeUpdate = v.InferOutput<typeof extraChargeUpdateSchema>;

// FacilityBlock Schemas (JP)
export const facilityBlockCreateSchema = v.object({
  facilityId: v.string(),
  name: v.string(),
  floors: v.number(),
  totalUnits: v.number()
});

export const facilityBlockUpdateSchema = v.partial(v.object({
  facilityId: v.optional(v.string()),
  name: v.optional(v.string()),
  floors: v.optional(v.number()),
  unitsPerFloor: v.optional(v.number()),
  totalUnits: v.optional(v.number()),
  yearBuilt: v.optional(v.number()),
  architect: v.optional(v.string()),
  features: v.optional(v.string()),
  images: v.optional(v.string())
}));

export type FacilityBlockCreate = v.InferOutput<typeof facilityBlockCreateSchema>;
export type FacilityBlockUpdate = v.InferOutput<typeof facilityBlockUpdateSchema>;

// Favorite Schemas (JP)
export const favoriteCreateSchema = v.object({
  userId: v.string(),
  propertyId: v.string()
});

export const favoriteUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  propertyId: v.optional(v.string())
}));

export type FavoriteCreate = v.InferOutput<typeof favoriteCreateSchema>;
export type FavoriteUpdate = v.InferOutput<typeof favoriteUpdateSchema>;

// Guest Schemas (JP)
export const guestCreateSchema = v.object({
  name: v.string(),
  phone: v.string(),
  nationality: v.string(),
  passportNumber: v.string(),
  gender: v.enum_(Gender),
  birthDate: v.string(),
  address: v.string(),
  city: v.string(),
  country: v.string(),
  zipCode: v.string(),
  email: v.pipe(v.string(), v.email())
});

export const guestUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  phone: v.optional(v.string()),
  image: v.optional(v.string()),
  nationality: v.optional(v.string()),
  passportNumber: v.optional(v.string()),
  gender: v.optional(v.enum_(Gender)),
  birthDate: v.optional(v.string()),
  address: v.optional(v.string()),
  city: v.optional(v.string()),
  country: v.optional(v.string()),
  zipCode: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  agencyId: v.optional(v.string())
}));

export type GuestCreate = v.InferOutput<typeof guestCreateSchema>;
export type GuestUpdate = v.InferOutput<typeof guestUpdateSchema>;

// Hashtag Schemas (JP)
export const hashtagCreateSchema = v.object({
  name: v.string(),
  relatedTags: v.string()
});

export const hashtagUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  type: v.optional(v.enum_(HashtagType)),
  description: v.optional(v.string()),
  usageCount: v.optional(v.number()),
  relatedTags: v.optional(v.string()),
  createdById: v.optional(v.string()),
  agencyId: v.optional(v.string())
}));

export type HashtagCreate = v.InferOutput<typeof hashtagCreateSchema>;
export type HashtagUpdate = v.InferOutput<typeof hashtagUpdateSchema>;

// IncludedService Schemas (JP)
export const includedServiceCreateSchema = v.object({
  propertyId: v.string(),
  name: v.string(),
  facilityAmenities: v.enum_(FacilityAmenities),
  locationAmenities: v.enum_(LocationAmenities)
});

export const includedServiceUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  value: v.optional(v.number()),
  isRecurring: v.optional(v.boolean()),
  frequency: v.optional(v.string()),
  icon: v.optional(v.string()),
  logo: v.optional(v.string()),
  facilityAmenities: v.optional(v.enum_(FacilityAmenities)),
  locationAmenities: v.optional(v.enum_(LocationAmenities)),
  facilityId: v.optional(v.string())
}));

export type IncludedServiceCreate = v.InferOutput<typeof includedServiceCreateSchema>;
export type IncludedServiceUpdate = v.InferOutput<typeof includedServiceUpdateSchema>;

// Increase Schemas (JP)
export const increaseCreateSchema = v.object({
  propertyId: v.string(),
  tenantId: v.string(),
  proposedBy: v.string(),
  oldRent: v.number(),
  newRent: v.number(),
  effectiveDate: v.string()
});

export const increaseUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  proposedBy: v.optional(v.string()),
  oldRent: v.optional(v.number()),
  newRent: v.optional(v.number()),
  effectiveDate: v.optional(v.string()),
  status: v.optional(v.enum_(IncreaseStatus)),
  contractId: v.optional(v.string())
}));

export type IncreaseCreate = v.InferOutput<typeof increaseCreateSchema>;
export type IncreaseUpdate = v.InferOutput<typeof increaseUpdateSchema>;

// Language Schemas (JP)
export const languageCreateSchema = v.object({
  code: v.string(),
  name: v.string(),
  nativeName: v.string()
});

export const languageUpdateSchema = v.partial(v.object({
  code: v.optional(v.string()),
  name: v.optional(v.string()),
  nativeName: v.optional(v.string()),
  isRTL: v.optional(v.boolean()),
  isActive: v.optional(v.boolean()),
  agencyId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  userId: v.optional(v.string())
}));

export type LanguageCreate = v.InferOutput<typeof languageCreateSchema>;
export type LanguageUpdate = v.InferOutput<typeof languageUpdateSchema>;

// MLConfiguration Schemas (JP)
export const mLConfigurationCreateSchema = v.object({
  // No required fields
});

export const mLConfigurationUpdateSchema = v.partial(v.object({
  enableAutoTagging: v.optional(v.boolean()),
  qualityThreshold: v.optional(v.number()),
  enableMLFeatures: v.optional(v.boolean()),
  maxTagsPerImage: v.optional(v.number()),
  analysisMode: v.optional(v.string()),
  allowedModels: v.optional(v.string()),
  customSettings: v.optional(v.unknown()),
  updatedBy: v.optional(v.string()),
  version: v.optional(v.number())
}));

export type MLConfigurationCreate = v.InferOutput<typeof mLConfigurationCreateSchema>;
export type MLConfigurationUpdate = v.InferOutput<typeof mLConfigurationUpdateSchema>;

// MLModel Schemas (JP)
export const mLModelCreateSchema = v.object({
  modelName: v.string(),
  modelType: v.string(),
  version: v.string(),
  trainingData: v.unknown()
});

export const mLModelUpdateSchema = v.partial(v.object({
  modelName: v.optional(v.string()),
  modelType: v.optional(v.string()),
  version: v.optional(v.string()),
  accuracy: v.optional(v.number()),
  trainingData: v.optional(v.unknown()),
  modelPath: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type MLModelCreate = v.InferOutput<typeof mLModelCreateSchema>;
export type MLModelUpdate = v.InferOutput<typeof mLModelUpdateSchema>;

// MapData Schemas (JP)
export const mapDataCreateSchema = v.object({
  coordinates: v.unknown(),
  address: v.string(),
  amenities: v.unknown(),
  geocodingData: v.unknown()
});

export const mapDataUpdateSchema = v.partial(v.object({
  projectId: v.optional(v.string()),
  coordinates: v.optional(v.unknown()),
  address: v.optional(v.string()),
  placeId: v.optional(v.string()),
  amenities: v.optional(v.unknown()),
  geocodingData: v.optional(v.unknown())
}));

export type MapDataCreate = v.InferOutput<typeof mapDataCreateSchema>;
export type MapDataUpdate = v.InferOutput<typeof mapDataUpdateSchema>;

// Mention Schemas (JP)
export const mentionCreateSchema = v.object({
  mentionedById: v.string(),
  mentionedToId: v.string(),
  type: v.enum_(MentionType)
});

export const mentionUpdateSchema = v.partial(v.object({
  mentionedById: v.optional(v.string()),
  mentionedToId: v.optional(v.string()),
  type: v.optional(v.enum_(MentionType)),
  taskId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  content: v.optional(v.string()),
  isRead: v.optional(v.boolean()),
  agencyId: v.optional(v.string()),
  userId: v.optional(v.string())
}));

export type MentionCreate = v.InferOutput<typeof mentionCreateSchema>;
export type MentionUpdate = v.InferOutput<typeof mentionUpdateSchema>;

// Mortgage Schemas (JP)
export const mortgageCreateSchema = v.object({
  propertyId: v.string(),
  lender: v.string(),
  principal: v.number(),
  interestRate: v.number(),
  startDate: v.string()
});

export const mortgageUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  lender: v.optional(v.string()),
  principal: v.optional(v.number()),
  interestRate: v.optional(v.number()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  status: v.optional(v.enum_(MortgageStatus)),
  notes: v.optional(v.string())
}));

export type MortgageCreate = v.InferOutput<typeof mortgageCreateSchema>;
export type MortgageUpdate = v.InferOutput<typeof mortgageUpdateSchema>;

// Offer Schemas (JP)
export const offerCreateSchema = v.object({
  basePrice: v.number(),
  finalPrice: v.number(),
  startDate: v.string(),
  endDate: v.string(),
  propertyId: v.string()
});

export const offerUpdateSchema = v.partial(v.object({
  increaseId: v.optional(v.string()),
  offerType: v.optional(v.enum_(OfferType)),
  status: v.optional(v.enum_(OfferStatus)),
  basePrice: v.optional(v.number()),
  discountRate: v.optional(v.number()),
  finalPrice: v.optional(v.number()),
  guestId: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  specialRequirements: v.optional(v.string()),
  notes: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  propertyId: v.optional(v.string())
}));

export type OfferCreate = v.InferOutput<typeof offerCreateSchema>;
export type OfferUpdate = v.InferOutput<typeof offerUpdateSchema>;

// Payment Schemas (JP)
export const paymentCreateSchema = v.object({
  tenantId: v.string(),
  amount: v.number(),
  currencyId: v.string(),
  paymentDate: v.string(),
  dueDate: v.string()
});

export const paymentUpdateSchema = v.partial(v.object({
  tenantId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  amount: v.optional(v.number()),
  type: v.optional(v.enum_(PaymentType)),
  currencyId: v.optional(v.string()),
  paymentDate: v.optional(v.string()),
  dueDate: v.optional(v.string()),
  status: v.optional(v.enum_(PaymentStatus)),
  paymentMethod: v.optional(v.string()),
  reference: v.optional(v.string()),
  notes: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  expenseId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  subscriptionId: v.optional(v.string()),
  commissionRuleId: v.optional(v.string()),
  includedServiceId: v.optional(v.string()),
  extraChargeId: v.optional(v.string()),
  stripePaymentIntentId: v.optional(v.string()),
  stripePaymentMethodId: v.optional(v.string()),
  stripeClientSecret: v.optional(v.string()),
  stripeStatus: v.optional(v.string()),
  stripeError: v.optional(v.string())
}));

export type PaymentCreate = v.InferOutput<typeof paymentCreateSchema>;
export type PaymentUpdate = v.InferOutput<typeof paymentUpdateSchema>;

// Photo Schemas (JP)
export const photoCreateSchema = v.object({
  url: v.string()
});

export const photoUpdateSchema = v.partial(v.object({
  url: v.optional(v.string()),
  originalName: v.optional(v.string()),
  filename: v.optional(v.string()),
  type: v.optional(v.enum_(PhotoType)),
  caption: v.optional(v.string()),
  alt: v.optional(v.string()),
  src: v.optional(v.string()),
  featured: v.optional(v.boolean()),
  width: v.optional(v.number()),
  height: v.optional(v.number()),
  fileSize: v.optional(v.number()),
  mimeType: v.optional(v.string()),
  dominantColor: v.optional(v.string()),
  mlMetadata: v.optional(v.unknown()),
  userId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  postId: v.optional(v.string())
}));

export type PhotoCreate = v.InferOutput<typeof photoCreateSchema>;
export type PhotoUpdate = v.InferOutput<typeof photoUpdateSchema>;

// Post Schemas (JP)
export const postCreateSchema = v.object({
  title: v.string(),
  content: v.string(),
  slug: v.string(),
  userId: v.string()
});

export const postUpdateSchema = v.partial(v.object({
  title: v.optional(v.string()),
  content: v.optional(v.string()),
  slug: v.optional(v.string()),
  userId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  hashtagId: v.optional(v.string()),
  agentId: v.optional(v.string())
}));

export type PostCreate = v.InferOutput<typeof postCreateSchema>;
export type PostUpdate = v.InferOutput<typeof postUpdateSchema>;

// PricingRule Schemas (JP)
export const pricingRuleCreateSchema = v.object({
  listingId: v.string(),
  name: v.string()
});

export const pricingRuleUpdateSchema = v.partial(v.object({
  listingId: v.optional(v.string()),
  name: v.optional(v.string()),
  description: v.optional(v.string()),
  ruleType: v.optional(v.string()),
  conditions: v.optional(v.unknown()),
  actions: v.optional(v.unknown()),
  priority: v.optional(v.number()),
  isActive: v.optional(v.boolean()),
  basePrice: v.optional(v.number()),
  strategy: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  minNights: v.optional(v.number()),
  maxNights: v.optional(v.number()),
  weekdayPrices: v.optional(v.unknown()),
  taxRules: v.optional(v.unknown()),
  discountRules: v.optional(v.unknown()),
  currencyId: v.optional(v.string())
}));

export type PricingRuleCreate = v.InferOutput<typeof pricingRuleCreateSchema>;
export type PricingRuleUpdate = v.InferOutput<typeof pricingRuleUpdateSchema>;

// ProjectAlert Schemas (JP)
export const projectAlertCreateSchema = v.object({
  projectId: v.string(),
  alertType: v.string(),
  title: v.string(),
  message: v.string(),
  severity: v.string()
});

export const projectAlertUpdateSchema = v.partial(v.object({
  projectId: v.optional(v.string()),
  alertType: v.optional(v.string()),
  title: v.optional(v.string()),
  message: v.optional(v.string()),
  severity: v.optional(v.string()),
  isRead: v.optional(v.boolean()),
  isResolved: v.optional(v.boolean()),
  resolvedAt: v.optional(v.string())
}));

export type ProjectAlertCreate = v.InferOutput<typeof projectAlertCreateSchema>;
export type ProjectAlertUpdate = v.InferOutput<typeof projectAlertUpdateSchema>;

// ProjectAnalytics Schemas (JP)
export const projectAnalyticsCreateSchema = v.object({
  projectId: v.string(),
  analysisType: v.string(),
  analysisData: v.unknown(),
  insights: v.string(),
  recommendations: v.string()
});

export const projectAnalyticsUpdateSchema = v.partial(v.object({
  projectId: v.optional(v.string()),
  analysisType: v.optional(v.string()),
  analysisData: v.optional(v.unknown()),
  insights: v.optional(v.string()),
  recommendations: v.optional(v.string()),
  score: v.optional(v.number())
}));

export type ProjectAnalyticsCreate = v.InferOutput<typeof projectAnalyticsCreateSchema>;
export type ProjectAnalyticsUpdate = v.InferOutput<typeof projectAnalyticsUpdateSchema>;

// ProjectReport Schemas (JP)
export const projectReportCreateSchema = v.object({
  reportType: v.string(),
  title: v.string(),
  content: v.string(),
  data: v.unknown(),
  generatedBy: v.string()
});

export const projectReportUpdateSchema = v.partial(v.object({
  projectId: v.optional(v.string()),
  reportType: v.optional(v.string()),
  title: v.optional(v.string()),
  content: v.optional(v.string()),
  data: v.optional(v.unknown()),
  generatedBy: v.optional(v.string())
}));

export type ProjectReportCreate = v.InferOutput<typeof projectReportCreateSchema>;
export type ProjectReportUpdate = v.InferOutput<typeof projectReportUpdateSchema>;

// PropertyPromotion Schemas (JP)
export const propertyPromotionCreateSchema = v.object({
  propertyId: v.string(),
  promotionType: v.enum_(PropertyPromotionType),
  startDate: v.string(),
  endDate: v.string(),
  price: v.number(),
  features: v.string()
});

export const propertyPromotionUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  agencyId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  promotionType: v.optional(v.enum_(PropertyPromotionType)),
  status: v.optional(v.enum_(PropertyPromotionStatus)),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  price: v.optional(v.number()),
  currency: v.optional(v.string()),
  isAutoRenew: v.optional(v.boolean()),
  features: v.optional(v.string()),
  paymentHistoryId: v.optional(v.string()),
  userId: v.optional(v.string())
}));

export type PropertyPromotionCreate = v.InferOutput<typeof propertyPromotionCreateSchema>;
export type PropertyPromotionUpdate = v.InferOutput<typeof propertyPromotionUpdateSchema>;

// ReferenceSource Schemas (JP)
export const referenceSourceCreateSchema = v.object({
  name: v.string(),
  commission: v.number(),
  source: v.enum_(BookingSource)
});

export const referenceSourceUpdateSchema = v.partial(v.object({
  name: v.optional(v.string()),
  logo: v.optional(v.string()),
  apiKey: v.optional(v.string()),
  apiSecret: v.optional(v.string()),
  baseUrl: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  commission: v.optional(v.number()),
  source: v.optional(v.enum_(BookingSource))
}));

export type ReferenceSourceCreate = v.InferOutput<typeof referenceSourceCreateSchema>;
export type ReferenceSourceUpdate = v.InferOutput<typeof referenceSourceUpdateSchema>;

// ScrapingJob Schemas (JP)
export const scrapingJobCreateSchema = v.object({
  jobType: v.string(),
  status: v.string(),
  errors: v.string(),
  configuration: v.unknown()
});

export const scrapingJobUpdateSchema = v.partial(v.object({
  jobType: v.optional(v.string()),
  status: v.optional(v.string()),
  startTime: v.optional(v.string()),
  endTime: v.optional(v.string()),
  projectsScraped: v.optional(v.number()),
  errors: v.optional(v.string()),
  configuration: v.optional(v.unknown())
}));

export type ScrapingJobCreate = v.InferOutput<typeof scrapingJobCreateSchema>;
export type ScrapingJobUpdate = v.InferOutput<typeof scrapingJobUpdateSchema>;

// SharedAmenity Schemas (JP)
export const sharedAmenityCreateSchema = v.object({
  facilityId: v.string(),
  name: v.string(),
  type: v.enum_(SharedAmenityType)
});

export const sharedAmenityUpdateSchema = v.partial(v.object({
  facilityId: v.optional(v.string()),
  name: v.optional(v.string()),
  type: v.optional(v.enum_(SharedAmenityType)),
  description: v.optional(v.string()),
  location: v.optional(v.string()),
  capacity: v.optional(v.number()),
  isAvailable: v.optional(v.boolean()),
  operatingHours: v.optional(v.string()),
  accessType: v.optional(v.enum_(AmenityAccessType)),
  price: v.optional(v.number()),
  images: v.optional(v.string())
}));

export type SharedAmenityCreate = v.InferOutput<typeof sharedAmenityCreateSchema>;
export type SharedAmenityUpdate = v.InferOutput<typeof sharedAmenityUpdateSchema>;

// Tenant Schemas (JP)
export const tenantCreateSchema = v.object({
  userId: v.string(),
  firstName: v.string(),
  lastName: v.string(),
  email: v.pipe(v.string(), v.email()),
  leaseStartDate: v.string(),
  leaseEndDate: v.string(),
  propertyId: v.string()
});

export const tenantUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  firstName: v.optional(v.string()),
  lastName: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  phoneNumber: v.optional(v.string()),
  leaseStartDate: v.optional(v.string()),
  leaseEndDate: v.optional(v.string()),
  paymentStatus: v.optional(v.enum_(PaymentStatus)),
  propertyId: v.optional(v.string()),
  isActive: v.optional(v.boolean())
}));

export type TenantCreate = v.InferOutput<typeof tenantCreateSchema>;
export type TenantUpdate = v.InferOutput<typeof tenantUpdateSchema>;

// Ticket Schemas (JP)
export const ticketCreateSchema = v.object({
  subject: v.string(),
  userId: v.string()
});

export const ticketUpdateSchema = v.partial(v.object({
  cuid: v.optional(v.string()),
  subject: v.optional(v.string()),
  description: v.optional(v.string()),
  status: v.optional(v.enum_(TicketStatus)),
  closedAt: v.optional(v.string()),
  userId: v.optional(v.string()),
  agentId: v.optional(v.string())
}));

export type TicketCreate = v.InferOutput<typeof ticketCreateSchema>;
export type TicketUpdate = v.InferOutput<typeof ticketUpdateSchema>;

// Verification Schemas (JP)
export const verificationCreateSchema = v.object({
  identifier: v.string(),
  value: v.string(),
  expiresAt: v.string()
});

export const verificationUpdateSchema = v.partial(v.object({
  identifier: v.optional(v.string()),
  value: v.optional(v.string()),
  expiresAt: v.optional(v.string())
}));

export type VerificationCreate = v.InferOutput<typeof verificationCreateSchema>;
export type VerificationUpdate = v.InferOutput<typeof verificationUpdateSchema>;

// PropertyOwnershipVerification Schemas (JP)
export const propertyOwnershipVerificationCreateSchema = v.object({
  propertyId: v.string(),
  orgId: v.string(),
  verificationMethod: v.enum_(VerificationMethod)
});

export const propertyOwnershipVerificationUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  currentOwnerId: v.optional(v.string()),
  verificationStatus: v.optional(v.enum_(OwnershipVerificationStatus)),
  verificationMethod: v.optional(v.enum_(VerificationMethod)),
  verifiedAt: v.optional(v.string()),
  verifiedBy: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  rejectionReason: v.optional(v.string()),
  governmentTransactionId: v.optional(v.string()),
  aiConfidenceScore: v.optional(v.number()),
  manualReviewRequired: v.optional(v.boolean()),
  priorityVerification: v.optional(v.boolean()),
  verificationNotes: v.optional(v.string()),
  supportingDocuments: v.optional(v.unknown()),
  ownershipHistory: v.optional(v.unknown()),
  legalDescription: v.optional(v.string()),
  parcelNumber: v.optional(v.string()),
  jurisdiction: v.optional(v.string()),
  recordingDate: v.optional(v.string()),
  chainOfCustody: v.optional(v.unknown()),
  verificationMetadata: v.optional(v.unknown())
}));

export type PropertyOwnershipVerificationCreate = v.InferOutput<typeof propertyOwnershipVerificationCreateSchema>;
export type PropertyOwnershipVerificationUpdate = v.InferOutput<typeof propertyOwnershipVerificationUpdateSchema>;

// OwnershipVerificationDocument Schemas (JP)
export const ownershipVerificationDocumentCreateSchema = v.object({
  verificationId: v.string(),
  documentType: v.enum_(OwnershipDocumentType),
  fileName: v.string(),
  filePath: v.string(),
  fileSize: v.number(),
  mimeType: v.string(),
  checksum: v.string(),
  uploadMethod: v.string(),
  validationStatus: v.string(),
  accessLevel: v.string()
});

export const ownershipVerificationDocumentUpdateSchema = v.partial(v.object({
  verificationId: v.optional(v.string()),
  documentType: v.optional(v.enum_(OwnershipDocumentType)),
  fileName: v.optional(v.string()),
  filePath: v.optional(v.string()),
  fileSize: v.optional(v.number()),
  mimeType: v.optional(v.string()),
  checksum: v.optional(v.string()),
  uploadMethod: v.optional(v.string()),
  extractedText: v.optional(v.string()),
  extractedMetadata: v.optional(v.unknown()),
  validationStatus: v.optional(v.string()),
  validationErrors: v.optional(v.unknown()),
  aiAnalysisResults: v.optional(v.unknown()),
  reviewedAt: v.optional(v.string()),
  reviewedBy: v.optional(v.string()),
  reviewNotes: v.optional(v.string()),
  isPublic: v.optional(v.boolean()),
  accessLevel: v.optional(v.string()),
  retentionUntil: v.optional(v.string())
}));

export type OwnershipVerificationDocumentCreate = v.InferOutput<typeof ownershipVerificationDocumentCreateSchema>;
export type OwnershipVerificationDocumentUpdate = v.InferOutput<typeof ownershipVerificationDocumentUpdateSchema>;

// PropertyOwnershipTransfer Schemas (JP)
export const propertyOwnershipTransferCreateSchema = v.object({
  propertyId: v.string(),
  orgId: v.string(),
  transferType: v.string(),
  transferStatus: v.string()
});

export const propertyOwnershipTransferUpdateSchema = v.partial(v.object({
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  fromOwnerId: v.optional(v.string()),
  toOwnerId: v.optional(v.string()),
  transferType: v.optional(v.string()),
  transferStatus: v.optional(v.string()),
  transferDate: v.optional(v.string()),
  recordingDate: v.optional(v.string()),
  considerationAmount: v.optional(v.number()),
  transferDocuments: v.optional(v.unknown()),
  legalDescription: v.optional(v.string()),
  blockchainTransactionId: v.optional(v.string()),
  governmentReference: v.optional(v.string()),
  transferNotes: v.optional(v.string())
}));

export type PropertyOwnershipTransferCreate = v.InferOutput<typeof propertyOwnershipTransferCreateSchema>;
export type PropertyOwnershipTransferUpdate = v.InferOutput<typeof propertyOwnershipTransferUpdateSchema>;

// BookingSecurityScreening Schemas (JP)
export const bookingSecurityScreeningCreateSchema = v.object({
  contactId: v.string(),
  propertyId: v.string(),
  orgId: v.string()
});

export const bookingSecurityScreeningUpdateSchema = v.partial(v.object({
  bookingId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  vacationRentalId: v.optional(v.string()),
  screeningStatus: v.optional(v.enum_(SecurityScreeningStatus)),
  riskLevel: v.optional(v.enum_(SecurityRiskLevel)),
  riskScore: v.optional(v.number()),
  confidenceScore: v.optional(v.number()),
  screeningResults: v.optional(v.unknown()),
  fraudIndicators: v.optional(v.unknown()),
  identityVerification: v.optional(v.unknown()),
  backgroundCheckResults: v.optional(v.unknown()),
  paymentRiskAssessment: v.optional(v.unknown()),
  behavioralAnalysis: v.optional(v.unknown()),
  deviceFingerprint: v.optional(v.string()),
  ipGeolocation: v.optional(v.unknown()),
  verificationMethods: v.optional(v.unknown()),
  manualReviewRequired: v.optional(v.boolean()),
  manualReviewBy: v.optional(v.string()),
  manualReviewNotes: v.optional(v.string()),
  reviewedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  screeningMetadata: v.optional(v.unknown())
}));

export type BookingSecurityScreeningCreate = v.InferOutput<typeof bookingSecurityScreeningCreateSchema>;
export type BookingSecurityScreeningUpdate = v.InferOutput<typeof bookingSecurityScreeningUpdateSchema>;

// VideoVendor Schemas (JP)
export const videoVendorCreateSchema = v.object({
  orgId: v.string(),
  name: v.string(),
  email: v.pipe(v.string(), v.email())
});

export const videoVendorUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  name: v.optional(v.string()),
  email: v.optional(v.pipe(v.string(), v.email())),
  phoneNumber: v.optional(v.string()),
  website: v.optional(v.string()),
  logoUrl: v.optional(v.string()),
  description: v.optional(v.string()),
  tier: v.optional(v.enum_(VendorTier)),
  status: v.optional(v.enum_(VendorStatus)),
  commissionRate: v.optional(v.number()),
  basePrice: v.optional(v.number()),
  qualityLevel: v.optional(v.enum_(VideoQuality)),
  serviceAreas: v.optional(v.string()),
  specialties: v.optional(v.string()),
  equipment: v.optional(v.unknown()),
  teamSize: v.optional(v.number()),
  avgTurnaroundTime: v.optional(v.number()),
  qualityScore: v.optional(v.number()),
  reliabilityScore: v.optional(v.number()),
  totalVideos: v.optional(v.number()),
  totalRevenue: v.optional(v.number()),
  avgRating: v.optional(v.number()),
  responseRate: v.optional(v.number()),
  cancellationPolicy: v.optional(v.string()),
  insuranceCoverage: v.optional(v.boolean()),
  backgroundVerified: v.optional(v.boolean()),
  verifiedAt: v.optional(v.string()),
  contractTerms: v.optional(v.unknown()),
  pricingStructure: v.optional(v.unknown()),
  serviceLevelAgreement: v.optional(v.unknown()),
  apiIntegration: v.optional(v.unknown()),
  metadata: v.optional(v.unknown())
}));

export type VideoVendorCreate = v.InferOutput<typeof videoVendorCreateSchema>;
export type VideoVendorUpdate = v.InferOutput<typeof videoVendorUpdateSchema>;

// VideoVendorPartnership Schemas (JP)
export const videoVendorPartnershipCreateSchema = v.object({
  vendorId: v.string(),
  agentId: v.string(),
  orgId: v.string()
});

export const videoVendorPartnershipUpdateSchema = v.partial(v.object({
  vendorId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  status: v.optional(v.string()),
  tier: v.optional(v.enum_(VendorTier)),
  commissionRate: v.optional(v.number()),
  basePrice: v.optional(v.number()),
  qualityRequirements: v.optional(v.unknown()),
  serviceAreas: v.optional(v.string()),
  exclusivity: v.optional(v.boolean()),
  exclusivityTerms: v.optional(v.unknown()),
  volumeDiscounts: v.optional(v.unknown()),
  performanceMetrics: v.optional(v.unknown()),
  contractStart: v.optional(v.string()),
  contractEnd: v.optional(v.string()),
  autoRenewal: v.optional(v.boolean()),
  terminationNotice: v.optional(v.number()),
  partnershipTerms: v.optional(v.unknown())
}));

export type VideoVendorPartnershipCreate = v.InferOutput<typeof videoVendorPartnershipCreateSchema>;
export type VideoVendorPartnershipUpdate = v.InferOutput<typeof videoVendorPartnershipUpdateSchema>;

// AgentVideo Schemas (JP)
export const agentVideoCreateSchema = v.object({
  agentId: v.string(),
  vendorId: v.string(),
  orgId: v.string(),
  title: v.string(),
  videoUrl: v.string()
});

export const agentVideoUpdateSchema = v.partial(v.object({
  agentId: v.optional(v.string()),
  vendorId: v.optional(v.string()),
  partnershipId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  videoUrl: v.optional(v.string()),
  thumbnailUrl: v.optional(v.string()),
  duration: v.optional(v.number()),
  quality: v.optional(v.enum_(VideoQuality)),
  fileSize: v.optional(v.number()),
  resolution: v.optional(v.string()),
  format: v.optional(v.string()),
  price: v.optional(v.number()),
  commissionAmount: v.optional(v.number()),
  commissionRate: v.optional(v.number()),
  status: v.optional(v.string()),
  priority: v.optional(v.string()),
  requestedAt: v.optional(v.string()),
  promisedBy: v.optional(v.string()),
  completedAt: v.optional(v.string()),
  qualityScore: v.optional(v.number()),
  clientSatisfaction: v.optional(v.number()),
  views: v.optional(v.number()),
  engagement: v.optional(v.unknown()),
  aiAnalysis: v.optional(v.unknown()),
  tags: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  videoContentId: v.optional(v.string())
}));

export type AgentVideoCreate = v.InferOutput<typeof agentVideoCreateSchema>;
export type AgentVideoUpdate = v.InferOutput<typeof agentVideoUpdateSchema>;

// AgentEarning Schemas (JP)
export const agentEarningCreateSchema = v.object({
  agentId: v.string(),
  sourceType: v.string(),
  amount: v.number()
});

export const agentEarningUpdateSchema = v.partial(v.object({
  agentId: v.optional(v.string()),
  sourceType: v.optional(v.string()),
  sourceId: v.optional(v.string()),
  amount: v.optional(v.number()),
  commissionRate: v.optional(v.number()),
  description: v.optional(v.string()),
  status: v.optional(v.string()),
  paymentDate: v.optional(v.string())
}));

export type AgentEarningCreate = v.InferOutput<typeof agentEarningCreateSchema>;
export type AgentEarningUpdate = v.InferOutput<typeof agentEarningUpdateSchema>;

// VendorEarning Schemas (JP)
export const vendorEarningCreateSchema = v.object({
  vendorId: v.string(),
  amount: v.number()
});

export const vendorEarningUpdateSchema = v.partial(v.object({
  vendorId: v.optional(v.string()),
  videoId: v.optional(v.string()),
  amount: v.optional(v.number()),
  commissionRate: v.optional(v.number()),
  description: v.optional(v.string()),
  status: v.optional(v.string()),
  paymentDate: v.optional(v.string())
}));

export type VendorEarningCreate = v.InferOutput<typeof vendorEarningCreateSchema>;
export type VendorEarningUpdate = v.InferOutput<typeof vendorEarningUpdateSchema>;

// PartnershipEarning Schemas (JP)
export const partnershipEarningCreateSchema = v.object({
  partnershipId: v.string(),
  agentId: v.string(),
  vendorId: v.string(),
  amount: v.number()
});

export const partnershipEarningUpdateSchema = v.partial(v.object({
  partnershipId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  vendorId: v.optional(v.string()),
  videoId: v.optional(v.string()),
  amount: v.optional(v.number()),
  commissionRate: v.optional(v.number()),
  splitType: v.optional(v.string()),
  agentShare: v.optional(v.number()),
  vendorShare: v.optional(v.number()),
  description: v.optional(v.string()),
  status: v.optional(v.string()),
  paymentDate: v.optional(v.string())
}));

export type PartnershipEarningCreate = v.InferOutput<typeof partnershipEarningCreateSchema>;
export type PartnershipEarningUpdate = v.InferOutput<typeof partnershipEarningUpdateSchema>;

// VideoQualityReview Schemas (JP)
export const videoQualityReviewCreateSchema = v.object({
  videoId: v.string(),
  vendorId: v.string(),
  qualityScore: v.number()
});

export const videoQualityReviewUpdateSchema = v.partial(v.object({
  videoId: v.optional(v.string()),
  reviewerId: v.optional(v.string()),
  vendorId: v.optional(v.string()),
  qualityScore: v.optional(v.number()),
  technicalScore: v.optional(v.number()),
  contentScore: v.optional(v.number()),
  accuracyScore: v.optional(v.number()),
  completenessScore: v.optional(v.number()),
  comments: v.optional(v.string()),
  recommendations: v.optional(v.string()),
  approved: v.optional(v.boolean()),
  reviewedAt: v.optional(v.string())
}));

export type VideoQualityReviewCreate = v.InferOutput<typeof videoQualityReviewCreateSchema>;
export type VideoQualityReviewUpdate = v.InferOutput<typeof videoQualityReviewUpdateSchema>;

// VendorQualityReview Schemas (JP)
export const vendorQualityReviewCreateSchema = v.object({
  vendorId: v.string(),
  overallScore: v.number()
});

export const vendorQualityReviewUpdateSchema = v.partial(v.object({
  vendorId: v.optional(v.string()),
  reviewerId: v.optional(v.string()),
  overallScore: v.optional(v.number()),
  qualityScore: v.optional(v.number()),
  reliabilityScore: v.optional(v.number()),
  communicationScore: v.optional(v.number()),
  pricingScore: v.optional(v.number()),
  technicalScore: v.optional(v.number()),
  comments: v.optional(v.string()),
  recommendations: v.optional(v.string()),
  approved: v.optional(v.boolean()),
  reviewedAt: v.optional(v.string())
}));

export type VendorQualityReviewCreate = v.InferOutput<typeof vendorQualityReviewCreateSchema>;
export type VendorQualityReviewUpdate = v.InferOutput<typeof vendorQualityReviewUpdateSchema>;

// ValuationRequest Schemas (JP)
export const valuationRequestCreateSchema = v.object({
  valuationId: v.string(),
  userId: v.string(),
  orgId: v.string(),
  requestType: v.string()
});

export const valuationRequestUpdateSchema = v.partial(v.object({
  valuationId: v.optional(v.string()),
  userId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  requestType: v.optional(v.string()),
  priority: v.optional(v.string()),
  contactInfo: v.optional(v.unknown()),
  propertyData: v.optional(v.unknown()),
  videoUrl: v.optional(v.string()),
  images: v.optional(v.string()),
  requirements: v.optional(v.string()),
  status: v.optional(v.string()),
  processingStartedAt: v.optional(v.string()),
  completedAt: v.optional(v.string()),
  estimatedPrice: v.optional(v.number()),
  confidenceScore: v.optional(v.number()),
  errorMessage: v.optional(v.string()),
  processingMetadata: v.optional(v.unknown()),
  userFeedback: v.optional(v.unknown()),
  contactId: v.optional(v.string())
}));

export type ValuationRequestCreate = v.InferOutput<typeof valuationRequestCreateSchema>;
export type ValuationRequestUpdate = v.InferOutput<typeof valuationRequestUpdateSchema>;

// ValuationReport Schemas (JP)
export const valuationReportCreateSchema = v.object({
  valuationId: v.string(),
  orgId: v.string(),
  reportType: v.string()
});

export const valuationReportUpdateSchema = v.partial(v.object({
  valuationId: v.optional(v.string()),
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  reportType: v.optional(v.string()),
  format: v.optional(v.string()),
  content: v.optional(v.unknown()),
  summary: v.optional(v.string()),
  insights: v.optional(v.string()),
  recommendations: v.optional(v.string()),
  charts: v.optional(v.unknown()),
  exportUrl: v.optional(v.string()),
  isPublic: v.optional(v.boolean()),
  shareToken: v.optional(v.string()),
  viewCount: v.optional(v.number()),
  downloadCount: v.optional(v.number()),
  generatedAt: v.optional(v.string()),
  expiresAt: v.optional(v.string()),
  contactId: v.optional(v.string()),
  propertyId: v.optional(v.string())
}));

export type ValuationReportCreate = v.InferOutput<typeof valuationReportCreateSchema>;
export type ValuationReportUpdate = v.InferOutput<typeof valuationReportUpdateSchema>;

// LeadConversion Schemas (JP)
export const leadConversionCreateSchema = v.object({
  valuationId: v.string(),
  orgId: v.string(),
  conversionType: v.string()
});

export const leadConversionUpdateSchema = v.partial(v.object({
  valuationId: v.optional(v.string()),
  userId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  conversionType: v.optional(v.string()),
  status: v.optional(v.string()),
  contactInfo: v.optional(v.unknown()),
  inquiryDetails: v.optional(v.unknown()),
  conversionValue: v.optional(v.number()),
  commissionAmount: v.optional(v.number()),
  followUpActions: v.optional(v.unknown()),
  conversionDate: v.optional(v.string()),
  expectedClosingDate: v.optional(v.string()),
  actualClosingDate: v.optional(v.string()),
  notes: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  contactId: v.optional(v.string())
}));

export type LeadConversionCreate = v.InferOutput<typeof leadConversionCreateSchema>;
export type LeadConversionUpdate = v.InferOutput<typeof leadConversionUpdateSchema>;

// MarketInsight Schemas (JP)
export const marketInsightCreateSchema = v.object({
  region: v.string(),
  propertyType: v.string(),
  insightType: v.string(),
  title: v.string(),
  description: v.string(),
  impact: v.string()
});

export const marketInsightUpdateSchema = v.partial(v.object({
  region: v.optional(v.string()),
  propertyType: v.optional(v.string()),
  insightType: v.optional(v.string()),
  title: v.optional(v.string()),
  description: v.optional(v.string()),
  data: v.optional(v.unknown()),
  confidence: v.optional(v.number()),
  impact: v.optional(v.string()),
  relevanceScore: v.optional(v.number()),
  source: v.optional(v.string()),
  validFrom: v.optional(v.string()),
  validTo: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  tags: v.optional(v.string()),
  organizationId: v.optional(v.string())
}));

export type MarketInsightCreate = v.InferOutput<typeof marketInsightCreateSchema>;
export type MarketInsightUpdate = v.InferOutput<typeof marketInsightUpdateSchema>;

// UserValuationPreference Schemas (JP)
export const userValuationPreferenceCreateSchema = v.object({
  userId: v.string(),
  orgId: v.string()
});

export const userValuationPreferenceUpdateSchema = v.partial(v.object({
  userId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  preferredType: v.optional(v.enum_(ValuationType)),
  notifications: v.optional(v.boolean()),
  autoRefresh: v.optional(v.boolean()),
  refreshInterval: v.optional(v.number()),
  preferredRegions: v.optional(v.string()),
  propertyTypes: v.optional(v.string()),
  priceRange: v.optional(v.unknown()),
  insights: v.optional(v.string()),
  reportFormat: v.optional(v.string()),
  language: v.optional(v.string()),
  timezone: v.optional(v.string()),
  metadata: v.optional(v.unknown())
}));

export type UserValuationPreferenceCreate = v.InferOutput<typeof userValuationPreferenceCreateSchema>;
export type UserValuationPreferenceUpdate = v.InferOutput<typeof userValuationPreferenceUpdateSchema>;

// VideoEarning Schemas (JP)
export const videoEarningCreateSchema = v.object({
  videoId: v.string(),
  vendorId: v.string(),
  orgId: v.string(),
  earningType: v.string(),
  amount: v.number(),
  period: v.string(),
  periodStart: v.string(),
  periodEnd: v.string()
});

export const videoEarningUpdateSchema = v.partial(v.object({
  videoId: v.optional(v.string()),
  vendorId: v.optional(v.string()),
  orgId: v.optional(v.string()),
  agentId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  earningType: v.optional(v.string()),
  amount: v.optional(v.number()),
  currency: v.optional(v.string()),
  rate: v.optional(v.number()),
  units: v.optional(v.number()),
  period: v.optional(v.string()),
  periodStart: v.optional(v.string()),
  periodEnd: v.optional(v.string()),
  status: v.optional(v.string()),
  metadata: v.optional(v.unknown()),
  processedAt: v.optional(v.string()),
  paidAt: v.optional(v.string()),
  agentVideoId: v.optional(v.string())
}));

export type VideoEarningCreate = v.InferOutput<typeof videoEarningCreateSchema>;
export type VideoEarningUpdate = v.InferOutput<typeof videoEarningUpdateSchema>;

// LegalCompliance Schemas (JP)
export const legalComplianceCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  region: v.enum_(Region)
});

export const legalComplianceUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
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

// GlobalTaxRegulation Schemas (JP)
export const globalTaxRegulationCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  taxAuthority: v.string(),
  taxType: v.string(),
  taxRate: v.number()
});

export const globalTaxRegulationUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
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

// SmartLock Schemas (JP)
export const smartLockCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  deviceId: v.string(),
  brand: v.enum_(SmartLockBrand)
});

export const smartLockUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  listingId: v.optional(v.string()),
  name: v.optional(v.string()),
  deviceId: v.optional(v.string()),
  brand: v.optional(v.enum_(SmartLockBrand)),
  status: v.optional(v.enum_(SmartLockStatus)),
  batteryLevel: v.optional(v.number()),
  firmwareVersion: v.optional(v.string()),
  lastSyncAt: v.optional(v.string()),
  lastActivityAt: v.optional(v.string()),
  config: v.optional(v.unknown()),
  autoLockDelay: v.optional(v.number()),
  isMasterCodeSet: v.optional(v.boolean())
}));

export type SmartLockCreate = v.InferOutput<typeof smartLockCreateSchema>;
export type SmartLockUpdate = v.InferOutput<typeof smartLockUpdateSchema>;

// AccessCode Schemas (JP)
export const accessCodeCreateSchema = v.object({
  orgId: v.string(),
  smartLockId: v.string(),
  code: v.string(),
  startsAt: v.string(),
  endsAt: v.string()
});

export const accessCodeUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  smartLockId: v.optional(v.string()),
  contactId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  code: v.optional(v.string()),
  name: v.optional(v.string()),
  status: v.optional(v.enum_(AccessCodeStatus)),
  startsAt: v.optional(v.string()),
  endsAt: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  usedCount: v.optional(v.number()),
  useLimit: v.optional(v.number()),
  metadata: v.optional(v.unknown())
}));

export type AccessCodeCreate = v.InferOutput<typeof accessCodeCreateSchema>;
export type AccessCodeUpdate = v.InferOutput<typeof accessCodeUpdateSchema>;

// AccessLog Schemas (JP)
export const accessLogCreateSchema = v.object({
  orgId: v.string(),
  smartLockId: v.string()
});

export const accessLogUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  smartLockId: v.optional(v.string()),
  accessCodeId: v.optional(v.string()),
  method: v.optional(v.enum_(AccessMethod)),
  event: v.optional(v.enum_(AccessEvent)),
  timestamp: v.optional(v.string()),
  actorName: v.optional(v.string()),
  success: v.optional(v.boolean()),
  failureReason: v.optional(v.string())
}));

export type AccessLogCreate = v.InferOutput<typeof accessLogCreateSchema>;
export type AccessLogUpdate = v.InferOutput<typeof accessLogUpdateSchema>;

// StayOccupant Schemas (JP)
export const stayOccupantCreateSchema = v.object({
  reservationId: v.string(),
  name: v.string()
});

export const stayOccupantUpdateSchema = v.partial(v.object({
  reservationId: v.optional(v.string()),
  name: v.optional(v.string()),
  idNumber: v.optional(v.string()),
  idType: v.optional(v.string()),
  nationality: v.optional(v.string()),
  birthDate: v.optional(v.string()),
  gender: v.optional(v.string()),
  isMinor: v.optional(v.boolean()),
  relationToGuest: v.optional(v.string())
}));

export type StayOccupantCreate = v.InferOutput<typeof stayOccupantCreateSchema>;
export type StayOccupantUpdate = v.InferOutput<typeof stayOccupantUpdateSchema>;

// PoliceReport Schemas (JP)
export const policeReportCreateSchema = v.object({
  orgId: v.string(),
  propertyId: v.string(),
  reservationId: v.string(),
  reportType: v.string()
});

export const policeReportUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  propertyId: v.optional(v.string()),
  reservationId: v.optional(v.string()),
  reportType: v.optional(v.string()),
  status: v.optional(v.enum_(ReportStatus)),
  submittedAt: v.optional(v.string()),
  referenceNumber: v.optional(v.string()),
  responseContent: v.optional(v.unknown()),
  errorMessage: v.optional(v.string())
}));

export type PoliceReportCreate = v.InferOutput<typeof policeReportCreateSchema>;
export type PoliceReportUpdate = v.InferOutput<typeof policeReportUpdateSchema>;

// IdentityDocument Schemas (JP)
export const identityDocumentCreateSchema = v.object({
  documentType: v.string(),
  imageUrl: v.string()
});

export const identityDocumentUpdateSchema = v.partial(v.object({
  guestId: v.optional(v.string()),
  stayOccupantId: v.optional(v.string()),
  documentType: v.optional(v.string()),
  imageUrl: v.optional(v.string()),
  isVerified: v.optional(v.boolean()),
  ocrData: v.optional(v.unknown()),
  verificationNote: v.optional(v.string())
}));

export type IdentityDocumentCreate = v.InferOutput<typeof identityDocumentCreateSchema>;
export type IdentityDocumentUpdate = v.InferOutput<typeof identityDocumentUpdateSchema>;

// MarketRateComparison Schemas (JP)
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

// FeatureAddOn Schemas (JP)
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

// PlatformRevenueRecord Schemas (JP)
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

// AiServiceTask Schemas (JP)
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

// AiVideoGeneration Schemas (JP)
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

// VideoCaption Schemas (JP)
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

// AiBrochureGeneration Schemas (JP)
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

// AiExtractedData Schemas (JP)
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

// Category Schemas (JP)
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

// CategoryTranslation Schemas (JP)
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

// USPublicTaxRecord Schemas (JP)
export const uSPublicTaxRecordCreateSchema = v.object({
  // No required fields
});

export const uSPublicTaxRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type USPublicTaxRecordCreate = v.InferOutput<typeof uSPublicTaxRecordCreateSchema>;
export type USPublicTaxRecordUpdate = v.InferOutput<typeof uSPublicTaxRecordUpdateSchema>;

// USPropertyAssessment Schemas (JP)
export const uSPropertyAssessmentCreateSchema = v.object({
  // No required fields
});

export const uSPropertyAssessmentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type USPropertyAssessmentCreate = v.InferOutput<typeof uSPropertyAssessmentCreateSchema>;
export type USPropertyAssessmentUpdate = v.InferOutput<typeof uSPropertyAssessmentUpdateSchema>;

// UKPropertyCertificateRecord Schemas (JP)
export const uKPropertyCertificateRecordCreateSchema = v.object({
  // No required fields
});

export const uKPropertyCertificateRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type UKPropertyCertificateRecordCreate = v.InferOutput<typeof uKPropertyCertificateRecordCreateSchema>;
export type UKPropertyCertificateRecordUpdate = v.InferOutput<typeof uKPropertyCertificateRecordUpdateSchema>;

// TRPropertyDocumentRecord Schemas (JP)
export const tRPropertyDocumentRecordCreateSchema = v.object({
  // No required fields
});

export const tRPropertyDocumentRecordUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TRPropertyDocumentRecordCreate = v.InferOutput<typeof tRPropertyDocumentRecordCreateSchema>;
export type TRPropertyDocumentRecordUpdate = v.InferOutput<typeof tRPropertyDocumentRecordUpdateSchema>;

// TRTaxDeclaration Schemas (JP)
export const tRTaxDeclarationCreateSchema = v.object({
  // No required fields
});

export const tRTaxDeclarationUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TRTaxDeclarationCreate = v.InferOutput<typeof tRTaxDeclarationCreateSchema>;
export type TRTaxDeclarationUpdate = v.InferOutput<typeof tRTaxDeclarationUpdateSchema>;

// VrpMandate Schemas (JP)
export const vrpMandateCreateSchema = v.object({
  orgId: v.string(),
  tenantId: v.string(),
  bankId: v.string(),
  consentId: v.string(),
  maxAmountPerMonth: v.number(),
  validUntil: v.string()
});

export const vrpMandateUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  tenantId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  bankId: v.optional(v.string()),
  consentId: v.optional(v.string()),
  status: v.optional(v.enum_(MandateStatus)),
  maxAmountPerMonth: v.optional(v.number()),
  currency: v.optional(v.string()),
  validUntil: v.optional(v.string()),
  lastUsedAt: v.optional(v.string())
}));

export type VrpMandateCreate = v.InferOutput<typeof vrpMandateCreateSchema>;
export type VrpMandateUpdate = v.InferOutput<typeof vrpMandateUpdateSchema>;

// IotAccessLog Schemas (JP)
export const iotAccessLogCreateSchema = v.object({
  orgId: v.string(),
  smartLockId: v.string(),
  action: v.enum_(LockAction),
  triggerSource: v.string(),
  status: v.string()
});

export const iotAccessLogUpdateSchema = v.partial(v.object({
  orgId: v.optional(v.string()),
  smartLockId: v.optional(v.string()),
  leaseId: v.optional(v.string()),
  action: v.optional(v.enum_(LockAction)),
  triggerSource: v.optional(v.string()),
  status: v.optional(v.string()),
  reason: v.optional(v.string())
}));

export type IotAccessLogCreate = v.InferOutput<typeof iotAccessLogCreateSchema>;
export type IotAccessLogUpdate = v.InferOutput<typeof iotAccessLogUpdateSchema>;

// GuestVerification Schemas (JP)
export const guestVerificationCreateSchema = v.object({
  // No required fields
});

export const guestVerificationUpdateSchema = v.partial(v.object({
  organizationId: v.optional(v.string())
}));

export type GuestVerificationCreate = v.InferOutput<typeof guestVerificationCreateSchema>;
export type GuestVerificationUpdate = v.InferOutput<typeof guestVerificationUpdateSchema>;

// TenantVerificationStage Schemas (JP)
export const tenantVerificationStageCreateSchema = v.object({
  // No required fields
});

export const tenantVerificationStageUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type TenantVerificationStageCreate = v.InferOutput<typeof tenantVerificationStageCreateSchema>;
export type TenantVerificationStageUpdate = v.InferOutput<typeof tenantVerificationStageUpdateSchema>;

// SecurityIncident Schemas (JP)
export const securityIncidentCreateSchema = v.object({
  // No required fields
});

export const securityIncidentUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type SecurityIncidentCreate = v.InferOutput<typeof securityIncidentCreateSchema>;
export type SecurityIncidentUpdate = v.InferOutput<typeof securityIncidentUpdateSchema>;

// OperatorLicense Schemas (JP)
export const operatorLicenseCreateSchema = v.object({
  // No required fields
});

export const operatorLicenseUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type OperatorLicenseCreate = v.InferOutput<typeof operatorLicenseCreateSchema>;
export type OperatorLicenseUpdate = v.InferOutput<typeof operatorLicenseUpdateSchema>;

// TenantReliabilityScore Schemas (JP)
export const tenantReliabilityScoreCreateSchema = v.object({
  // No required fields
});

export const tenantReliabilityScoreUpdateSchema = v.partial(v.object({
  organizationId: v.optional(v.string())
}));

export type TenantReliabilityScoreCreate = v.InferOutput<typeof tenantReliabilityScoreCreateSchema>;
export type TenantReliabilityScoreUpdate = v.InferOutput<typeof tenantReliabilityScoreUpdateSchema>;

// PropertySecurityConfig Schemas (JP)
export const propertySecurityConfigCreateSchema = v.object({
  // No required fields
});

export const propertySecurityConfigUpdateSchema = v.partial(v.object({
  // No updatable fields
}));

export type PropertySecurityConfigCreate = v.InferOutput<typeof propertySecurityConfigCreateSchema>;
export type PropertySecurityConfigUpdate = v.InferOutput<typeof propertySecurityConfigUpdateSchema>;

// AgentEscrowWallet Schemas (JP)
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

// AgentEscrowTransaction Schemas (JP)
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

// EscrowSplitConfig Schemas (JP)
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

