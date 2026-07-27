/*
  Warnings:

  - The `solicitorType` column on the `SolicitorManagement` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `SolicitorManagement` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[listingId]` on the table `AIPriceOptimization` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `barRegistrationNo` to the `SolicitorManagement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `countryCode` to the `SolicitorManagement` table without a default value. This is not possible if the table is not empty.
  - Added the required column `legalNoticeAddress` to the `SolicitorManagement` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "SolicitorType" AS ENUM ('LOCAL_LEGAL_COUNSEL', 'TENANT_INTERNATIONAL_LAWYER', 'LANDLORD_REPRESENTATIVE');

-- CreateEnum
CREATE TYPE "SolicitorStatus" AS ENUM ('ENGAGED', 'VERIFIED', 'DISPUTE_OPEN', 'COMPLETED', 'TERMINATED');

-- CreateEnum
CREATE TYPE "CommissionAdvanceType" AS ENUM ('INSTANT', 'INSTALLMENT');

-- CreateEnum
CREATE TYPE "CommissionAdvanceStatus" AS ENUM ('OFFERED', 'ACCEPTED', 'PAID', 'COMPLETED');

-- CreateEnum
CREATE TYPE "AgentType" AS ENUM ('FREELANCE', 'OFFICE', 'ENTERPRISE');

-- CreateEnum
CREATE TYPE "OptimizationStatus" AS ENUM ('NONE', 'SUGGESTED', 'ACCEPTED', 'ACTIVE', 'EXPIRED');

-- CreateEnum
CREATE TYPE "OptimizationSource" AS ENUM ('AI', 'OWNER', 'AGENT', 'SYSTEM');

-- CreateEnum
CREATE TYPE "KumbaraDepositStatus" AS ENUM ('ACTIVE', 'COMPLETED', 'DEFAULTED', 'REFUNDED', 'DISPUTED', 'FROZEN');

-- CreateEnum
CREATE TYPE "KumbaraContributionStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED', 'LATE');

-- CreateEnum
CREATE TYPE "KumbaraRuleType" AS ENUM ('PERCENTAGE_OF_RENT', 'FIXED_AMOUNT', 'TIERED', 'INCOME_BASED', 'DYNAMIC');

-- CreateEnum
CREATE TYPE "TrustEntityType" AS ENUM ('TENANT', 'LANDLORD', 'AGENT', 'PROPERTY', 'ORGANIZATION', 'VENDOR');

-- CreateEnum
CREATE TYPE "TrustScoreStatus" AS ENUM ('ACTIVE', 'DECAYED', 'FROZEN', 'UNDER_REVIEW', 'APPEALED');

-- CreateEnum
CREATE TYPE "TrustSignalCategory" AS ENUM ('PAYMENT', 'BEHAVIOR', 'VERIFICATION', 'OPERATIONAL', 'FINANCIAL', 'COMPLIANCE', 'SOCIAL', 'MAINTENANCE');

-- CreateEnum
CREATE TYPE "PurchaseIntentStatus" AS ENUM ('INTENT_DECLARED', 'PRE_QUALIFIED', 'SAVINGS_ACTIVE', 'MORTGAGE_READY', 'OFFER_SUBMITTED', 'UNDER_CONTRACT', 'OWNERSHIP_TRANSFERRED', 'EXPIRED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "BuyerReadinessTier" AS ENUM ('EXPLORING', 'SAVING', 'QUALIFIED', 'ACTIVE_BUYER', 'MORTGAGE_APPROVED', 'CLOSING');

-- CreateEnum
CREATE TYPE "ConsentType" AS ENUM ('MARKETING', 'DATA_PROCESSING', 'COMMUNICATION', 'VALUATION_ACCESS', 'PROPERTY_CLAIM', 'AI_ANALYSIS');

-- CreateEnum
CREATE TYPE "ConsentStatus" AS ENUM ('ACTIVE', 'REVOKED', 'EXPIRED', 'PENDING', 'DECLINED');

-- CreateEnum
CREATE TYPE "ConsentMethod" AS ENUM ('EMAIL', 'PHONE', 'MAGIC_LINK', 'WEB_FORM', 'API', 'SMS');

-- CreateEnum
CREATE TYPE "ConsentEntityType" AS ENUM ('USER', 'PROPERTY_PROSPECT', 'OWNER_PROFILE', 'AGENT_PROFILE', 'PROPERTY', 'ORGANIZATION');

-- CreateEnum
CREATE TYPE "CorporateAccountType" AS ENUM ('CORPORATE_HOUSING', 'MULTI_FAMILY', 'BANK_REO', 'PROPERTY_MANAGEMENT', 'REAL_ESTATE_INVESTMENT');

-- CreateEnum
CREATE TYPE "BulkUploadStatus" AS ENUM ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'PARTIALLY_COMPLETED');

-- CreateEnum
CREATE TYPE "InvitationStatus" AS ENUM ('PENDING', 'ACCEPTED', 'EXPIRED', 'REVOKED');

-- CreateEnum
CREATE TYPE "PropertyNormalizationStatus" AS ENUM ('PENDING', 'NORMALIZING', 'COMPLETED', 'FAILED', 'MANUAL_REVIEW');

-- CreateEnum
CREATE TYPE "CampaignTriggerType" AS ENUM ('PROPERTY_VACANCY_RISK', 'VALUATION_INCREASE', 'MARKET_OPPORTUNITY', 'OWNER_CONSENT_GRANTED', 'LISTING_EXPIRED', 'PRICE_DROP', 'NEW_LISTING_INGESTED', 'CUSTOM');

-- CreateEnum
CREATE TYPE "CampaignRuleStatus" AS ENUM ('ACTIVE', 'PAUSED', 'DISABLED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "CampaignObjectiveType" AS ENUM ('ACQUISITION', 'RETENTION', 'VACANCY_FILL', 'BRAND_AWARENESS', 'LEAD_GENERATION', 'CONVERSION', 'RE_ENGAGEMENT');

-- CreateEnum
CREATE TYPE "CampaignObjective" AS ENUM ('BRAND_AWARENESS', 'TRAFFIC', 'ENGAGEMENT', 'LEADS', 'CONVERSIONS', 'APP_INSTALLS', 'CATALOG_SALES', 'STORE_VISITS');

-- CreateEnum
CREATE TYPE "TrustConfidenceLevel" AS ENUM ('VERY_LOW', 'LOW', 'MEDIUM', 'HIGH', 'VERY_HIGH');

-- CreateEnum
CREATE TYPE "TrustRiskLevel" AS ENUM ('UNKNOWN', 'LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "MLSFraudPatternType" AS ENUM ('DUPLICATE_LISTING', 'FAKE_OWNER_DETECTION', 'PRICE_MANIPULATION', 'IMAGE_REUSE_DETECTION', 'OWNERSHIP_CONFLICT', 'PHANTOM_PROPERTY', 'ADDRESS_MISMATCH', 'SQUARE_FOOTAGE_ANOMALY', 'PRICE_ANOMALY', 'CONTACT_FRAUD');

-- CreateEnum
CREATE TYPE "FraudSeverity" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "REOPropertyStatus" AS ENUM ('BANK_OWNED', 'FORECLOSURE_PENDING', 'PRE_FORECLOSURE', 'SHORT_SALE_LISTED', 'REO_INVENTORY', 'UNDER_MAINTENANCE', 'RENOVATION_PENDING', 'RENOVATION_ACTIVE', 'LISTED_FOR_SALE', 'SOLD', 'TRANSFERRED');

-- CreateEnum
CREATE TYPE "REOPropertyType" AS ENUM ('FORECLOSED', 'REO_BANK_OWNED', 'SHORT_SALE', 'JUDICIAL_SALE', 'DISTRESSED', 'NON_PERFORMING_LOAN', 'CONVEYED_DEED');

-- CreateEnum
CREATE TYPE "InstitutionalOwnerType" AS ENUM ('BANK', 'CREDIT_UNION', 'GYO', 'REIT', 'PENSION_FUND', 'SOVEREIGN_FUND', 'PRIVATE_EQUITY', 'FOUNDATION', 'ASSOCIATION', 'CORPORATE');

-- CreateEnum
CREATE TYPE "FinancialAuditAction" AS ENUM ('PAYMENT_CREATED', 'PAYMENT_COMPLETED', 'PAYMENT_FAILED', 'PAYMENT_REFUNDED', 'ESCROW_FUNDED', 'ESCROW_PARTIALLY_RELEASED', 'ESCROW_FULLY_RELEASED', 'ESCROW_DISPUTED', 'ESCROW_RESOLVED', 'SCHEDULED_RELEASE_TRIGGERED', 'COMMISSION_CALCULATED', 'COMMISSION_PAID', 'PAYOUT_INITIATED', 'PAYOUT_COMPLETED', 'PAYOUT_FAILED', 'SPLIT_DISBURSED', 'KUMBARA_CONTRIBUTION', 'KUMBARA_COMPLETED', 'DEPOSIT_HELD', 'DEPOSIT_REFUNDED', 'MORTGAGE_PRE_APPROVED', 'MORTGAGE_OFFERED', 'OWNERSHIP_TRANSFERRED', 'EQUITY_ACCUMULATED', 'TRUST_SCORE_UPDATED', 'REO_ACQUIRED', 'REO_DISPOSED', 'RATE_CHANGED', 'TAX_RECORDED', 'ADJUSTMENT_MADE');

-- CreateEnum
CREATE TYPE "BankAccountType" AS ENUM ('CHECKING', 'SAVINGS', 'ESCROW', 'BUSINESS', 'MERCHANT');

-- CreateEnum
CREATE TYPE "BankAccountStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'CLOSED', 'PENDING_VERIFICATION');

-- CreateEnum
CREATE TYPE "ProductCategory" AS ENUM ('FURNITURE', 'APPLIANCE', 'ELECTRONICS', 'DECOR', 'LIGHTING', 'KITCHENWARE', 'LINEN', 'ACCESSORY', 'SMART_HOME', 'OUTDOOR');

-- CreateEnum
CREATE TYPE "ProductStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'DISCONTINUED', 'OUT_OF_STOCK');

-- CreateEnum
CREATE TYPE "SupplierStatus" AS ENUM ('ACTIVE', 'PENDING', 'SUSPENDED', 'INACTIVE');

-- CreateEnum
CREATE TYPE "BundleType" AS ENUM ('STAGING_BASIC', 'STAGING_PREMIUM', 'STAGING_LUXURY', 'MOVE_IN_READY', 'INCOME_READY', 'INVESTMENT_READY', 'CUSTOM');

-- CreateEnum
CREATE TYPE "CommissionType" AS ENUM ('AGENT_SALE', 'FURNITURE_COMMISSION', 'REFERRAL', 'PLATFORM_FEE', 'REVENUE_SHARE', 'BONUS');

-- CreateEnum
CREATE TYPE "CommerceCommissionStatus" AS ENUM ('PENDING', 'CALCULATED', 'APPROVED', 'PAID', 'DISPUTED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'CONFIRMED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'INSTALLED', 'CANCELLED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "AgentStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'PENDING_APPROVAL');

-- CreateEnum
CREATE TYPE "CommerceCampaignStatus" AS ENUM ('DRAFT', 'ACTIVE', 'PAUSED', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "CertificateTier" AS ENUM ('MOVE_IN_READY', 'INCOME_READY', 'INVESTMENT_READY');

-- CreateEnum
CREATE TYPE "CertificateStatus" AS ENUM ('PENDING', 'ISSUED', 'EXPIRED', 'REVOKED', 'RENEWED');

-- CreateEnum
CREATE TYPE "RevenueShareType" AS ENUM ('PLATFORM', 'AGENT', 'SUPPLIER', 'PARTNER', 'BANK', 'REFERRAL');

-- CreateEnum
CREATE TYPE "OpportunityTier" AS ENUM ('LOW_POTENTIAL', 'MONITOR', 'HIGH_POTENTIAL', 'PREMIUM');

-- CreateEnum
CREATE TYPE "AcquisitionUrgency" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'IMMEDIATE');

-- CreateEnum
CREATE TYPE "ListingLifecycleStatus" AS ENUM ('UNVERIFIED_PROSPECT', 'OWNER_IDENTIFIED', 'CONSENT_GRANTED', 'VALUATION_READY', 'INVITATION_SENT', 'PROPERTY_CLAIMED', 'ACTIVE_LISTING', 'CONVERTED');

-- CreateEnum
CREATE TYPE "MLSEventType" AS ENUM ('LISTING_ADDED', 'LISTING_UPDATED', 'LISTING_REMOVED', 'PRICE_CHANGED', 'STATUS_CHANGED', 'PHOTO_ADDED', 'OPENHOUSE_SCHEDULED', 'CONTRACT_PENDING', 'CONTRACT_SOLD');

-- CreateEnum
CREATE TYPE "OwnershipClaimStatus" AS ENUM ('PENDING', 'VERIFIED', 'REJECTED', 'DISPUTED');

-- CreateEnum
CREATE TYPE "AdPlatform" AS ENUM ('FACEBOOK', 'GOOGLE', 'LINKEDIN', 'TWITTER', 'TIKTOK', 'INSTAGRAM');

-- CreateEnum
CREATE TYPE "FraudRuleType" AS ENUM ('DUPLICATE_LISTING', 'FAKE_OWNER', 'PRICE_MANIPULATION', 'IMAGE_REUSE', 'OWNERSHIP_CONFLICT', 'CONTACT_FRAUD', 'SQUARE_FOOTAGE_ANOMALY', 'PRICE_ANOMALY');

-- CreateEnum
CREATE TYPE "PredictionType" AS ENUM ('OPPORTUNITY_SCORE', 'VALUATION', 'RENTAL_YIELD', 'TIME_TO_RENT', 'SALE_PRICE', 'APPRECIATION_RATE', 'LIQUIDITY_SCORE', 'RISK_SCORE', 'MARKET_TREND', 'PRICE_PREDICTION');

-- CreateEnum
CREATE TYPE "PredictionStatus" AS ENUM ('PENDING', 'VERIFIED', 'FAILED', 'EXPIRED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "AgentTaskType" AS ENUM ('VALUATION', 'OPPORTUNITY_ANALYSIS', 'STRATEGIC_REVIEW', 'SIMULATION', 'RANKING', 'MARKET_RESEARCH', 'OWNER_IDENTIFICATION', 'CONSENT_ACQUISITION', 'DOCUMENT_VERIFICATION', 'LISTING_PREPARATION', 'MARKETING_SETUP', 'BUYER_MATCHING', 'NEGOTIATION_SUPPORT', 'CLOSING_COORDINATION', 'POST_ACQUISITION_ANALYSIS', 'KNOWLEDGE_GRAPH_UPDATE', 'VECTOR_INDEX_UPDATE', 'OUTCOME_TRACKING', 'MODEL_RETRAINING', 'COUNTRY_CONTEXT_UPDATE');

-- CreateEnum
CREATE TYPE "AgentTaskStatus" AS ENUM ('PENDING', 'SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'FAILED', 'CANCELLED', 'BLOCKED', 'RETRYING');

-- CreateEnum
CREATE TYPE "SEOIntent" AS ENUM ('INVESTMENT', 'RENTAL', 'BUYING', 'SELLING', 'MARKET_REPORT', 'RENTAL_YIELD', 'GOLDEN_VISA', 'FOREIGN_INVESTOR', 'INFRASTRUCTURE', 'SCHOOL_DISTRICT', 'TRANSPORTATION', 'LIFESTYLE', 'NEIGHBORHOOD_GUIDE');

-- CreateEnum
CREATE TYPE "SEOPageEntityType" AS ENUM ('COUNTRY_LEVEL', 'STATE_LEVEL', 'CITY_LEVEL', 'DISTRICT_LEVEL', 'NEIGHBORHOOD_LEVEL', 'PROPERTY_TYPE_LEVEL', 'TRANSACTION_TYPE_LEVEL', 'INTENT_LEVEL', 'COMPOSITE_LEVEL');

-- CreateEnum
CREATE TYPE "SEOPagePriority" AS ENUM ('CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'ROUTINE');

-- CreateEnum
CREATE TYPE "SEOPageStatus" AS ENUM ('PENDING', 'GENERATING', 'GENERATED', 'PUBLISHED', 'NEEDS_UPDATE', 'UPDATING', 'ARCHIVED', 'FAILED');

-- CreateEnum
CREATE TYPE "ProcessingStatus" AS ENUM ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED', 'SKIPPED');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "AiTaskType" ADD VALUE 'META_ADS_CREATIVE_GEN';
ALTER TYPE "AiTaskType" ADD VALUE 'META_COPY_GENERATION';
ALTER TYPE "AiTaskType" ADD VALUE 'META_AUDIENCE_SELECTION';
ALTER TYPE "AiTaskType" ADD VALUE 'META_BUDGET_OPTIMIZATION';
ALTER TYPE "AiTaskType" ADD VALUE 'WHATSAPP_LEAD_RESPONSE';

-- AlterEnum
ALTER TYPE "MLSProviderKey" ADD VALUE 'NWMLS';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "PermissionKey" ADD VALUE 'KUMBARA_MANAGE';
ALTER TYPE "PermissionKey" ADD VALUE 'TRUST_SCORE_VIEW';
ALTER TYPE "PermissionKey" ADD VALUE 'TRUST_SCORE_MANAGE';
ALTER TYPE "PermissionKey" ADD VALUE 'RTO_MANAGE';
ALTER TYPE "PermissionKey" ADD VALUE 'REO_MANAGE';
ALTER TYPE "PermissionKey" ADD VALUE 'COMMERCE_MANAGE';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "SocialPlatform" ADD VALUE 'TIKTOK';
ALTER TYPE "SocialPlatform" ADD VALUE 'YOUTUBE';

-- DropForeignKey
ALTER TABLE "AiVideoGeneration" DROP CONSTRAINT "AiVideoGeneration_propertyId_fkey";

-- DropIndex
DROP INDEX "AIPriceOptimization_listingId_idx";

-- AlterTable
ALTER TABLE "AIPriceOptimization" ADD COLUMN     "acceptedAt" TIMESTAMP(3),
ADD COLUMN     "actualOutcomePrice" DECIMAL(14,2),
ADD COLUMN     "actualRevenueImpact" DECIMAL(14,2),
ADD COLUMN     "actualVacancyReduction" DOUBLE PRECISION,
ADD COLUMN     "declinedAt" TIMESTAMP(3),
ADD COLUMN     "estimatedRentalProbability" DOUBLE PRECISION,
ADD COLUMN     "estimatedRevenueImpact" DECIMAL(14,2),
ADD COLUMN     "estimatedVacancyReduction" DOUBLE PRECISION,
ADD COLUMN     "lastAnalyzedAt" TIMESTAMP(3),
ADD COLUMN     "learnedAt" TIMESTAMP(3),
ADD COLUMN     "marketData" JSONB,
ADD COLUMN     "marketDemandScore" DOUBLE PRECISION,
ADD COLUMN     "predictionError" DOUBLE PRECISION,
ADD COLUMN     "propertyId" TEXT,
ADD COLUMN     "recommendedDiscount" DECIMAL(5,4),
ADD COLUMN     "rejectionReason" TEXT,
ADD COLUMN     "vacancyDaysAtAnalysis" INTEGER;

-- AlterTable
ALTER TABLE "Agency" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "AiServiceTask" ADD COLUMN     "entityId" TEXT,
ADD COLUMN     "entityType" TEXT,
ADD COLUMN     "payload" JSONB,
ADD COLUMN     "result" JSONB;

-- AlterTable
ALTER TABLE "AiVideoGeneration" ADD COLUMN     "listingId" TEXT,
ADD COLUMN     "outputUrls" TEXT[],
ALTER COLUMN "propertyId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Booking" ADD COLUMN     "regionalPricingId" TEXT,
ADD COLUMN     "timezone" TEXT DEFAULT 'America/New_York';

-- AlterTable
ALTER TABLE "Commission" ADD COLUMN     "countryCode" VARCHAR(2);

-- AlterTable
ALTER TABLE "Contract" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Lead" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Listing" ADD COLUMN     "boostScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "isOptimizedForSpeed" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "lastPriceOptimizationAt" TIMESTAMP(3),
ADD COLUMN     "optimizationRate" DECIMAL(5,4),
ADD COLUMN     "optimizationReason" TEXT,
ADD COLUMN     "optimizationStatus" "OptimizationStatus" NOT NULL DEFAULT 'NONE',
ADD COLUMN     "priceOptimizationSource" "OptimizationSource",
ADD COLUMN     "rankingScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "regionalPricingId" TEXT,
ADD COLUMN     "vacancyDays" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "vacancyScore" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "MarketingCampaign" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Notification" ADD COLUMN     "contactId" TEXT,
ADD COLUMN     "dealId" TEXT,
ADD COLUMN     "leadId" TEXT;

-- AlterTable
ALTER TABLE "Organization" ADD COLUMN     "timezone" TEXT NOT NULL DEFAULT 'America/New_York';

-- AlterTable
ALTER TABLE "Project" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Property" ADD COLUMN     "aiAcquisitionUrgency" "AcquisitionUrgency",
ADD COLUMN     "aiAnalysisFlags" TEXT[],
ADD COLUMN     "aiComponentScores" JSONB,
ADD COLUMN     "aiKeyFactors" TEXT[],
ADD COLUMN     "aiLastAnalyzedAt" TIMESTAMP(3),
ADD COLUMN     "aiModelVersion" TEXT,
ADD COLUMN     "aiOpportunityScore" DOUBLE PRECISION,
ADD COLUMN     "aiOpportunityTier" "OpportunityTier",
ADD COLUMN     "aiOverallRankingScore" DOUBLE PRECISION,
ADD COLUMN     "aiProviderUsed" TEXT,
ADD COLUMN     "aiRank" INTEGER,
ADD COLUMN     "aiRankingConfidence" DOUBLE PRECISION,
ADD COLUMN     "aiRecommendedAction" TEXT,
ADD COLUMN     "aiRecommendedScenario" TEXT,
ADD COLUMN     "aiRecommendedStrategy" TEXT,
ADD COLUMN     "aiRegionalStrengths" TEXT[],
ADD COLUMN     "aiRiskFactors" TEXT[],
ADD COLUMN     "aiScoreBreakdown" JSONB,
ADD COLUMN     "aiSimulationConfidence" DOUBLE PRECISION,
ADD COLUMN     "aiSimulationScenarios" JSONB,
ADD COLUMN     "aiStrategicConfidence" DOUBLE PRECISION,
ADD COLUMN     "aiTargetSegments" TEXT[],
ADD COLUMN     "aiTimingRecommendations" TEXT,
ADD COLUMN     "aiWhyScore" TEXT,
ADD COLUMN     "timezone" TEXT NOT NULL DEFAULT 'America/New_York';

-- AlterTable
ALTER TABLE "Reservation" ADD COLUMN     "analyticsMetricId" TEXT;

-- AlterTable
ALTER TABLE "SolicitorManagement" ADD COLUMN     "barRegistrationNo" TEXT NOT NULL,
ADD COLUMN     "countryCode" TEXT NOT NULL,
ADD COLUMN     "legalNoticeAddress" TEXT NOT NULL,
ADD COLUMN     "referredByAgencyId" TEXT,
DROP COLUMN "solicitorType",
ADD COLUMN     "solicitorType" "SolicitorType" NOT NULL DEFAULT 'TENANT_INTERNATIONAL_LAWYER',
DROP COLUMN "status",
ADD COLUMN     "status" "SolicitorStatus" NOT NULL DEFAULT 'ENGAGED',
ALTER COLUMN "currency" SET DEFAULT 'USD';

-- AlterTable
ALTER TABLE "Task" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "VendorProfile" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- CreateTable
CREATE TABLE "CommissionAdvance" (
    "id" TEXT NOT NULL,
    "commissionId" TEXT NOT NULL,
    "originalAmount" DECIMAL(14,2) NOT NULL,
    "feeRate" DECIMAL(5,2) NOT NULL,
    "feeAmount" DECIMAL(14,2) NOT NULL,
    "payoutAmount" DECIMAL(14,2) NOT NULL,
    "type" "CommissionAdvanceType" NOT NULL,
    "status" "CommissionAdvanceStatus" NOT NULL,
    "approvedAt" TIMESTAMP(3),
    "paidAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommissionAdvance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CountryCommissionRule" (
    "id" TEXT NOT NULL,
    "countryCode" TEXT NOT NULL,
    "agentType" "AgentType" NOT NULL,
    "baseCommissionRate" DECIMAL(5,4) NOT NULL,
    "regulatoryCeiling" DECIMAL(5,4),
    "marketAdjustment" DECIMAL(5,4),
    "volumeIncentives" JSONB,
    "campaignTags" JSONB,
    "effectiveFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "effectiveUntil" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "CountryCommissionRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommissionPolicy" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "countryCode" VARCHAR(2) NOT NULL,
    "agentType" "AgentType",
    "platformRate" DECIMAL(5,4) NOT NULL DEFAULT 0.05,
    "partnerRate" DECIMAL(5,4) NOT NULL DEFAULT 0.05,
    "settlementTiming" TEXT NOT NULL DEFAULT 'INSTALLMENT',
    "maxInstallments" INTEGER NOT NULL DEFAULT 12,
    "defaultInstallments" INTEGER NOT NULL DEFAULT 6,
    "installmentInterest" DECIMAL(5,4) NOT NULL DEFAULT 0.10,
    "minCommission" DECIMAL(14,2),
    "maxCommission" DECIMAL(14,2),
    "requiresApproval" BOOLEAN NOT NULL DEFAULT false,
    "approvalThreshold" DECIMAL(14,2),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "effectiveFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "effectiveUntil" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "CommissionPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SettlementPolicy" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "countryCode" VARCHAR(2) NOT NULL,
    "settlementType" TEXT NOT NULL DEFAULT 'INSTALLMENT',
    "upfrontPercent" DECIMAL(5,2) NOT NULL DEFAULT 50.00,
    "installmentCount" INTEGER NOT NULL DEFAULT 6,
    "installmentFrequency" TEXT NOT NULL DEFAULT 'MONTHLY',
    "interestRate" DECIMAL(5,4) NOT NULL DEFAULT 0.10,
    "earlySettlementDiscount" DECIMAL(5,4) NOT NULL DEFAULT 0.05,
    "earlySettlementDays" INTEGER NOT NULL DEFAULT 30,
    "latePenaltyRate" DECIMAL(5,4) NOT NULL DEFAULT 0.02,
    "lateGraceDays" INTEGER NOT NULL DEFAULT 15,
    "minCommissionAmount" DECIMAL(14,2),
    "minInstallmentAmount" DECIMAL(14,2),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "effectiveFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "effectiveUntil" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "SettlementPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingPolicy" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "countryCode" VARCHAR(2) NOT NULL,
    "maxDiscountPct" DECIMAL(5,4) NOT NULL DEFAULT 0.30,
    "minPriceFloor" DECIMAL(5,4),
    "strategy" TEXT NOT NULL DEFAULT 'DYNAMIC',
    "minAdjustmentPct" DECIMAL(5,4) NOT NULL DEFAULT -0.20,
    "maxAdjustmentPct" DECIMAL(5,4) NOT NULL DEFAULT 0.20,
    "adjustmentFrequency" TEXT NOT NULL DEFAULT 'DAILY',
    "highSeasonMultiplier" DECIMAL(5,4) NOT NULL DEFAULT 1.20,
    "lowSeasonMultiplier" DECIMAL(5,4) NOT NULL DEFAULT 0.85,
    "aiOptimizationEnabled" BOOLEAN NOT NULL DEFAULT false,
    "minConfidenceThreshold" DOUBLE PRECISION DEFAULT 0.7,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "effectiveFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "effectiveUntil" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "PricingPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EventLog" (
    "id" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "aggregateType" TEXT NOT NULL,
    "aggregateId" TEXT NOT NULL,
    "payload" JSONB NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" TIMESTAMP(3),
    "retryCount" INTEGER NOT NULL DEFAULT 0,
    "error" TEXT,

    CONSTRAINT "EventLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SagaState" (
    "id" TEXT NOT NULL,
    "sagaType" TEXT NOT NULL,
    "correlationId" TEXT NOT NULL,
    "currentStep" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "context" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SagaState_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnalyticsMetric" (
    "id" TEXT NOT NULL,
    "metricType" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "previousValue" DOUBLE PRECISION,
    "changePercent" DOUBLE PRECISION,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dimensions" JSONB,
    "orgId" TEXT,
    "financialRecordId" TEXT,
    "taskId" TEXT,
    "propertyId" TEXT,
    "reservationId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AnalyticsMetric_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KPIConfig" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "metricType" TEXT NOT NULL,
    "formula" TEXT NOT NULL,
    "target" DOUBLE PRECISION,
    "threshold" DOUBLE PRECISION,
    "alertEnabled" BOOLEAN NOT NULL DEFAULT false,
    "organizationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "KPIConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AIInsight" (
    "id" TEXT NOT NULL,
    "insightType" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "confidence" DOUBLE PRECISION NOT NULL,
    "impact" TEXT NOT NULL,
    "actionable" BOOLEAN NOT NULL DEFAULT false,
    "suggestedActions" JSONB,
    "relatedMetrics" JSONB,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "organizationId" TEXT,

    CONSTRAINT "AIInsight_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentApproval" (
    "id" TEXT NOT NULL,
    "documentId" TEXT NOT NULL,
    "approverId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "comments" TEXT,
    "approvedAt" TIMESTAMP(3),
    "organizationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DocumentApproval_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DocumentVersion" (
    "id" TEXT NOT NULL,
    "documentId" TEXT NOT NULL,
    "versionNumber" INTEGER NOT NULL,
    "fileUrl" TEXT NOT NULL,
    "changes" TEXT,
    "createdBy" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DocumentVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationRule" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "conditions" JSONB NOT NULL,
    "channels" JSONB NOT NULL,
    "templateId" TEXT,
    "priority" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL,
    "organizationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NotificationRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NotificationTemplate" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "subject" TEXT,
    "body" TEXT NOT NULL,
    "variables" JSONB,
    "organizationId" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "NotificationTemplate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserNotificationPreferences" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "channelPreferences" JSONB,
    "quietHoursStart" TEXT,
    "quietHoursEnd" TEXT,
    "digestFrequency" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserNotificationPreferences_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Team" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "parentId" TEXT,
    "permissions" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRole" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "roleId" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT,

    CONSTRAINT "UserRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Device" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "deviceIdentifier" TEXT NOT NULL,
    "deviceType" TEXT,
    "deviceName" TEXT,
    "isTrusted" BOOLEAN NOT NULL DEFAULT false,
    "lastUsedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Device_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IdentityEvent" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "metadata" JSONB,
    "riskLevel" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "IdentityEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SSOConfig" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "config" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SSOConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CountryConfig" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "nativeName" TEXT NOT NULL,
    "currency" TEXT NOT NULL,
    "currencySymbol" TEXT NOT NULL,
    "language" TEXT NOT NULL,
    "timezone" TEXT NOT NULL,
    "dateFormat" TEXT NOT NULL,
    "numberFormat" TEXT NOT NULL,
    "weekendDays" JSONB NOT NULL,
    "workingDays" JSONB NOT NULL,
    "taxRate" DOUBLE PRECISION,
    "vatRate" DOUBLE PRECISION,
    "legalRequirements" JSONB NOT NULL,
    "rentalRules" JSONB NOT NULL,
    "paymentProviders" JSONB NOT NULL,
    "propertyTypes" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CountryConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LanguageConfig" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "nativeName" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LanguageConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CurrencyConfig" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "exchangeRate" DOUBLE PRECISION NOT NULL,
    "lastUpdated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CurrencyConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocalizedContent" (
    "id" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "language" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "translatedBy" TEXT,
    "confidence" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocalizedContent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RegionalPricing" (
    "id" TEXT NOT NULL,
    "countryCode" TEXT NOT NULL,
    "propertyType" TEXT NOT NULL,
    "basePrice" DOUBLE PRECISION NOT NULL,
    "adjustment" DOUBLE PRECISION NOT NULL,
    "season" TEXT,
    "effectiveFrom" TIMESTAMP(3) NOT NULL,
    "effectiveTo" TIMESTAMP(3),
    "listingId" TEXT,
    "propertyId" TEXT,
    "bookingId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RegionalPricing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SEOMetadata" (
    "id" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "language" TEXT NOT NULL,
    "countryCode" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "keywords" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SEOMetadata_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MetricDefinition" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "labels" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MetricDefinition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MetricData" (
    "id" TEXT NOT NULL,
    "metricName" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "labels" JSONB,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MetricData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "APIEndpoint" (
    "id" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "method" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "rateLimit" INTEGER,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "APIEndpoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlatformDashboard" (
    "id" TEXT NOT NULL,
    "dashboardId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "osModule" TEXT NOT NULL,
    "refreshInterval" INTEGER NOT NULL,
    "widgets" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlatformDashboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KumbaraDeposit" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "leaseId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "status" "KumbaraDepositStatus" NOT NULL DEFAULT 'ACTIVE',
    "totalTarget" DECIMAL(12,2) NOT NULL,
    "totalContributed" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "remainingBalance" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "ruleType" "KumbaraRuleType" NOT NULL DEFAULT 'PERCENTAGE_OF_RENT',
    "contributionRate" DOUBLE PRECISION NOT NULL DEFAULT 0.035,
    "fixedAmount" DECIMAL(12,2),
    "contributionDay" INTEGER NOT NULL DEFAULT 1,
    "escrowAccountId" TEXT,
    "ownerProtectionEnabled" BOOLEAN NOT NULL DEFAULT true,
    "maxMissedPayments" INTEGER NOT NULL DEFAULT 3,
    "currentMissedPayments" INTEGER NOT NULL DEFAULT 0,
    "autoDefaultOnMiss" BOOLEAN NOT NULL DEFAULT false,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),
    "nextDueDate" TIMESTAMP(3) NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "KumbaraDeposit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KumbaraContribution" (
    "id" TEXT NOT NULL,
    "depositId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" "KumbaraContributionStatus" NOT NULL DEFAULT 'PENDING',
    "dueDate" TIMESTAMP(3) NOT NULL,
    "paidAt" TIMESTAMP(3),
    "paymentMethod" TEXT,
    "paymentRail" "PaymentRail",
    "gatewayRef" TEXT,
    "installmentNo" INTEGER,
    "escrowAccountId" TEXT,
    "failureReason" TEXT,
    "retryCount" INTEGER NOT NULL DEFAULT 0,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "KumbaraContribution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KumbaraRule" (
    "id" TEXT NOT NULL,
    "depositId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "ruleType" "KumbaraRuleType" NOT NULL DEFAULT 'PERCENTAGE_OF_RENT',
    "rate" DOUBLE PRECISION,
    "amount" DECIMAL(12,2),
    "minAmount" DECIMAL(12,2),
    "maxAmount" DECIMAL(12,2),
    "conditions" JSONB,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "validUntil" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "KumbaraRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UniversalTrustScore" (
    "id" TEXT NOT NULL,
    "orgId" TEXT,
    "entityType" "TrustEntityType" NOT NULL,
    "entityId" TEXT NOT NULL,
    "version" INTEGER NOT NULL DEFAULT 1,
    "overallScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "confidenceLevel" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "scoreBreakdown" JSONB NOT NULL,
    "tier" TEXT NOT NULL DEFAULT 'BRONZE',
    "status" "TrustScoreStatus" NOT NULL DEFAULT 'ACTIVE',
    "lastCalculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastDecayAt" TIMESTAMP(3),
    "decayRate" DOUBLE PRECISION NOT NULL DEFAULT 0.05,
    "inactivityDays" INTEGER NOT NULL DEFAULT 30,
    "signalCount" INTEGER NOT NULL DEFAULT 0,
    "lastSignalAt" TIMESTAMP(3),
    "isExplainable" BOOLEAN NOT NULL DEFAULT true,
    "explanationData" JSONB,
    "apiAccessEnabled" BOOLEAN NOT NULL DEFAULT true,
    "lastAccessedAt" TIMESTAMP(3),
    "accessCount" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UniversalTrustScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrustScoreEvent" (
    "id" TEXT NOT NULL,
    "scoreId" TEXT NOT NULL,
    "orgId" TEXT,
    "signalKey" TEXT NOT NULL,
    "category" "TrustSignalCategory" NOT NULL,
    "weight" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "rawValue" JSONB NOT NULL,
    "normalizedScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "scoreDelta" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "previousScore" DOUBLE PRECISION,
    "newScore" DOUBLE PRECISION,
    "sourceEntityId" TEXT,
    "sourceEntityType" TEXT,
    "description" TEXT,
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isValid" BOOLEAN NOT NULL DEFAULT true,
    "invalidatedBy" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TrustScoreEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrustScoreVersion" (
    "id" TEXT NOT NULL,
    "scoreId" TEXT NOT NULL,
    "orgId" TEXT,
    "version" INTEGER NOT NULL,
    "overallScore" DOUBLE PRECISION NOT NULL,
    "tier" TEXT NOT NULL,
    "scoreBreakdown" JSONB NOT NULL,
    "triggerEvent" TEXT NOT NULL,
    "eventId" TEXT,
    "explanation" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TrustScoreVersion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseIntent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "leaseId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "tenantId" TEXT NOT NULL,
    "status" "PurchaseIntentStatus" NOT NULL DEFAULT 'INTENT_DECLARED',
    "readinessTier" "BuyerReadinessTier" NOT NULL DEFAULT 'EXPLORING',
    "targetPrice" DECIMAL(12,2),
    "estimatedDownPmt" DECIMAL(12,2),
    "monthlySavings" DECIMAL(12,2),
    "savingsGoal" DECIMAL(12,2),
    "currentSavings" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "mortgagePreApproved" BOOLEAN NOT NULL DEFAULT false,
    "mortgagePreApprovalId" TEXT,
    "maxMortgageAmount" DECIMAL(12,2),
    "preferredLender" TEXT,
    "trustScoreAtIntent" DOUBLE PRECISION,
    "buyerReadinessScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "targetPurchaseDate" TIMESTAMP(3),
    "leaseEndSynchronizes" BOOLEAN NOT NULL DEFAULT true,
    "declaredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastActivityAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PurchaseIntent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EquityAccumulation" (
    "id" TEXT NOT NULL,
    "intentId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "rentPaid" DECIMAL(12,2) NOT NULL,
    "equityPortion" DECIMAL(12,2) NOT NULL,
    "cumulativeEquity" DECIMAL(12,2) NOT NULL,
    "savingsAdded" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "paymentId" TEXT,
    "paymentStatus" TEXT NOT NULL DEFAULT 'COMPLETED',
    "verifiedAt" TIMESTAMP(3),
    "verifiedBy" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "EquityAccumulation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OwnershipConversion" (
    "id" TEXT NOT NULL,
    "intentId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "purchasePrice" DECIMAL(12,2) NOT NULL,
    "equityApplied" DECIMAL(12,2) NOT NULL,
    "remainingBalance" DECIMAL(12,2) NOT NULL,
    "downPayment" DECIMAL(12,2) NOT NULL,
    "mortgageAmount" DECIMAL(12,2) NOT NULL,
    "buyerContactId" TEXT NOT NULL,
    "sellerOrgId" TEXT,
    "bankPartnerId" TEXT,
    "solicitorContactId" TEXT,
    "purchaseAgreed" BOOLEAN NOT NULL DEFAULT false,
    "surveyOrdered" BOOLEAN NOT NULL DEFAULT false,
    "surveyComplete" BOOLEAN NOT NULL DEFAULT false,
    "mortgageOffered" BOOLEAN NOT NULL DEFAULT false,
    "mortgageAccepted" BOOLEAN NOT NULL DEFAULT false,
    "contractsExchanged" BOOLEAN NOT NULL DEFAULT false,
    "completionDate" TIMESTAMP(3),
    "keysHandedOver" BOOLEAN NOT NULL DEFAULT false,
    "contractId" TEXT,
    "mortgageOfferId" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OwnershipConversion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OwnerProfile" (
    "id" TEXT NOT NULL,
    "propertyProspectId" TEXT,
    "userId" TEXT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "verified" BOOLEAN NOT NULL DEFAULT false,
    "verifiedAt" TIMESTAMP(3),
    "verificationMethod" TEXT,
    "verificationScore" DOUBLE PRECISION,
    "verificationMetadata" JSONB,
    "communicationConsent" BOOLEAN NOT NULL DEFAULT false,
    "consentDate" TIMESTAMP(3),
    "consentMethod" TEXT,
    "marketingOptIn" BOOLEAN NOT NULL DEFAULT false,
    "marketingOptInAt" TIMESTAMP(3),
    "propertyCount" INTEGER NOT NULL DEFAULT 0,
    "estimatedPortfolioValue" DOUBLE PRECISION,
    "primaryLocation" TEXT,
    "locationRadius" DOUBLE PRECISION,
    "source" TEXT,
    "sourceMetadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "OwnerProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AgentProfile" (
    "id" TEXT NOT NULL,
    "propertyProspectId" TEXT,
    "agentId" TEXT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "licenseNumber" TEXT,
    "brokerage" TEXT,
    "verified" BOOLEAN NOT NULL DEFAULT false,
    "verifiedAt" TIMESTAMP(3),
    "verificationMethod" TEXT,
    "verificationScore" DOUBLE PRECISION,
    "communicationConsent" BOOLEAN NOT NULL DEFAULT false,
    "consentDate" TIMESTAMP(3),
    "consentMethod" TEXT,
    "activeListings" INTEGER NOT NULL DEFAULT 0,
    "soldProperties" INTEGER NOT NULL DEFAULT 0,
    "avgDaysToSell" DOUBLE PRECISION,
    "responseRate" DOUBLE PRECISION,
    "clientSatisfaction" DOUBLE PRECISION,
    "source" TEXT,
    "sourceMetadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AgentProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Consent" (
    "id" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "entityType" "ConsentEntityType" NOT NULL,
    "entityContext" JSONB,
    "userId" TEXT,
    "propertyProspectId" TEXT,
    "ownerProfileId" TEXT,
    "agentProfileId" TEXT,
    "consentType" "ConsentType" NOT NULL,
    "consentPurpose" TEXT NOT NULL,
    "consentChannel" TEXT NOT NULL,
    "status" "ConsentStatus" NOT NULL DEFAULT 'PENDING',
    "grantedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "revokedAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3),
    "consentMethod" "ConsentMethod" NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "locationData" JSONB,
    "gdprConsent" BOOLEAN NOT NULL DEFAULT false,
    "gdprArticle" TEXT,
    "ccpaOptOut" BOOLEAN NOT NULL DEFAULT false,
    "ccpaRight" TEXT,
    "kvkkConsent" BOOLEAN NOT NULL DEFAULT false,
    "kvkkArticle" TEXT,
    "scope" JSONB,
    "restrictions" JSONB,
    "emailConsent" BOOLEAN NOT NULL DEFAULT false,
    "phoneConsent" BOOLEAN NOT NULL DEFAULT false,
    "smsConsent" BOOLEAN NOT NULL DEFAULT false,
    "pushConsent" BOOLEAN NOT NULL DEFAULT false,
    "whatsappConsent" BOOLEAN NOT NULL DEFAULT false,
    "adsConsent" BOOLEAN NOT NULL DEFAULT false,
    "aiCommunicationConsent" BOOLEAN NOT NULL DEFAULT false,
    "revocationReason" TEXT,
    "revocationMethod" "ConsentMethod",
    "consentVersion" INTEGER NOT NULL DEFAULT 1,
    "previousConsentId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Consent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommunicationUnsubscribe" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "email" TEXT NOT NULL,
    "unsubscribeReason" TEXT,
    "unsubscribeMethod" "ConsentMethod" NOT NULL,
    "unsubscribeAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "emailUnsubscribed" BOOLEAN NOT NULL DEFAULT true,
    "phoneUnsubscribed" BOOLEAN NOT NULL DEFAULT false,
    "smsUnsubscribed" BOOLEAN NOT NULL DEFAULT false,
    "pushUnsubscribed" BOOLEAN NOT NULL DEFAULT false,
    "campaignId" TEXT,
    "messageId" TEXT,
    "dataDeletionRequested" BOOLEAN NOT NULL DEFAULT false,
    "dataDeletionRequestedAt" TIMESTAMP(3),
    "dataDeletionCompleted" BOOLEAN NOT NULL DEFAULT false,
    "dataDeletionCompletedAt" TIMESTAMP(3),
    "reEngagementAllowed" BOOLEAN NOT NULL DEFAULT false,
    "reEngagementAfter" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommunicationUnsubscribe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DataProcessingRecord" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "propertyProspectId" TEXT,
    "consentId" TEXT,
    "processingType" TEXT NOT NULL,
    "processingPurpose" TEXT NOT NULL,
    "legalBasis" TEXT NOT NULL,
    "dataCategories" JSONB NOT NULL,
    "recipients" JSONB,
    "thirdPartyTransfers" BOOLEAN NOT NULL DEFAULT false,
    "thirdPartyDetails" JSONB,
    "crossBorderTransfer" BOOLEAN NOT NULL DEFAULT false,
    "transferCountries" TEXT[],
    "retentionPeriod" TEXT,
    "retentionUntil" TIMESTAMP(3),
    "processedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedBy" TEXT,
    "encryptionUsed" TEXT,
    "accessLog" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DataProcessingRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConsentAuditLog" (
    "id" TEXT NOT NULL,
    "consentId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "performedBy" TEXT,
    "performedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "previousStatus" "ConsentStatus",
    "newStatus" "ConsentStatus" NOT NULL,
    "changes" JSONB,
    "reason" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ConsentAuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CorporateAccount" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "accountType" "CorporateAccountType" NOT NULL,
    "tier" TEXT NOT NULL DEFAULT 'standard',
    "whitelisted" BOOLEAN NOT NULL DEFAULT false,
    "priorityLevel" INTEGER NOT NULL DEFAULT 0,
    "primaryContactName" TEXT NOT NULL,
    "primaryContactEmail" TEXT NOT NULL,
    "primaryContactPhone" TEXT,
    "billingContactName" TEXT,
    "billingContactEmail" TEXT,
    "totalProperties" INTEGER NOT NULL DEFAULT 0,
    "activeProperties" INTEGER NOT NULL DEFAULT 0,
    "totalUnits" INTEGER NOT NULL DEFAULT 0,
    "avgOccupancyRate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "annualRevenue" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "apiEnabled" BOOLEAN NOT NULL DEFAULT false,
    "apiKey" TEXT,
    "webhookUrl" TEXT,
    "webhookSecret" TEXT,
    "seattleMarketFocus" BOOLEAN NOT NULL DEFAULT false,
    "targetNeighborhoods" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "CorporateAccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PortfolioBatch" (
    "id" TEXT NOT NULL,
    "corporateAccountId" TEXT NOT NULL,
    "batchName" TEXT NOT NULL,
    "batchType" TEXT NOT NULL,
    "status" "BulkUploadStatus" NOT NULL DEFAULT 'PENDING',
    "fileName" TEXT NOT NULL,
    "fileSize" INTEGER NOT NULL,
    "fileType" TEXT NOT NULL,
    "fileUrl" TEXT,
    "s3Key" TEXT,
    "totalRows" INTEGER NOT NULL,
    "processedRows" INTEGER NOT NULL DEFAULT 0,
    "successfulRows" INTEGER NOT NULL DEFAULT 0,
    "failedRows" INTEGER NOT NULL DEFAULT 0,
    "skippedRows" INTEGER NOT NULL DEFAULT 0,
    "processingStartedAt" TIMESTAMP(3),
    "processingCompletedAt" TIMESTAMP(3),
    "errorLog" TEXT,
    "validationErrors" JSONB,
    "normalizationStatus" "PropertyNormalizationStatus" NOT NULL DEFAULT 'PENDING',
    "normalizedProperties" INTEGER NOT NULL DEFAULT 0,
    "manualReviewRequired" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PortfolioBatch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BulkInvitation" (
    "id" TEXT NOT NULL,
    "corporateAccountId" TEXT NOT NULL,
    "invitedEmail" TEXT NOT NULL,
    "invitedName" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'property_manager',
    "magicLinkToken" TEXT NOT NULL,
    "magicLinkExpiresAt" TIMESTAMP(3) NOT NULL,
    "magicLinkUsedAt" TIMESTAMP(3),
    "magicLinkUsedIp" TEXT,
    "status" "InvitationStatus" NOT NULL DEFAULT 'PENDING',
    "invitationMessage" TEXT,
    "customWelcomeText" TEXT,
    "portfolioPreviewUrl" TEXT,
    "seattlePilotCampaign" BOOLEAN NOT NULL DEFAULT false,
    "priorityAccess" BOOLEAN NOT NULL DEFAULT false,
    "sentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BulkInvitation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CorporateProperty" (
    "id" TEXT NOT NULL,
    "corporateAccountId" TEXT NOT NULL,
    "portfolioBatchId" TEXT,
    "propertyId" TEXT,
    "rawImportData" JSONB NOT NULL,
    "normalizationStatus" "PropertyNormalizationStatus" NOT NULL DEFAULT 'PENDING',
    "normalizedAt" TIMESTAMP(3),
    "normalizedBy" TEXT,
    "propertyType" TEXT,
    "furnishingStatus" TEXT,
    "amenities" TEXT[],
    "seattleNeighborhood" TEXT,
    "buildingName" TEXT,
    "buildingType" TEXT,
    "floorNumber" INTEGER,
    "unitNumber" TEXT,
    "corporateRate" DOUBLE PRECISION,
    "longTermRate" DOUBLE PRECISION,
    "midTermRate" DOUBLE PRECISION,
    "minStayDuration" INTEGER,
    "maxStayDuration" INTEGER,
    "aiEstimatedValue" DOUBLE PRECISION,
    "aiEstimatedYield" DOUBLE PRECISION,
    "aiConfidenceScore" DOUBLE PRECISION,
    "aiValuationAt" TIMESTAMP(3),
    "longTermYield" DOUBLE PRECISION,
    "midTermYield" DOUBLE PRECISION,
    "corporateYield" DOUBLE PRECISION,
    "yieldOpportunity" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CorporateProperty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AIPitchDeck" (
    "id" TEXT NOT NULL,
    "corporateAccountId" TEXT NOT NULL,
    "deckName" TEXT NOT NULL,
    "deckType" TEXT NOT NULL,
    "executiveSummary" TEXT NOT NULL,
    "portfolioOverview" JSONB NOT NULL,
    "financialProjections" JSONB NOT NULL,
    "yieldAnalysis" JSONB NOT NULL,
    "marketComparison" JSONB NOT NULL,
    "seattleMarketInsights" JSONB,
    "techTenantDemand" JSONB,
    "neighborhoodAnalysis" JSONB,
    "status" TEXT NOT NULL DEFAULT 'draft',
    "generatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "sentAt" TIMESTAMP(3),
    "viewedAt" TIMESTAMP(3),
    "deliveryMethod" TEXT NOT NULL,
    "deliveryEmail" TEXT,

    CONSTRAINT "AIPitchDeck_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CorporateTenantMatch" (
    "id" TEXT NOT NULL,
    "corporateAccountId" TEXT NOT NULL,
    "corporatePropertyId" TEXT NOT NULL,
    "companyName" TEXT NOT NULL,
    "industry" TEXT NOT NULL,
    "employeeCount" INTEGER,
    "matchScore" DOUBLE PRECISION NOT NULL,
    "matchReason" TEXT[],
    "estimatedContractValue" DOUBLE PRECISION,
    "contractDuration" INTEGER,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "techCompany" BOOLEAN NOT NULL DEFAULT false,
    "amazonEmployee" BOOLEAN NOT NULL DEFAULT false,
    "microsoftEmployee" BOOLEAN NOT NULL DEFAULT false,
    "googleEmployee" BOOLEAN NOT NULL DEFAULT false,
    "metaEmployee" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CorporateTenantMatch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CampaignAutomationRule" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "status" "CampaignRuleStatus" NOT NULL DEFAULT 'ACTIVE',
    "triggerType" "CampaignTriggerType" NOT NULL,
    "triggerConditions" JSONB NOT NULL,
    "targetEntityType" TEXT NOT NULL,
    "targetFilters" JSONB,
    "campaignType" "CampaignObjectiveType" NOT NULL,
    "campaignObjective" "CampaignObjective" NOT NULL,
    "budget" DOUBLE PRECISION,
    "duration" INTEGER,
    "googleAdsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "metaAdsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "tiktokAdsEnabled" BOOLEAN NOT NULL DEFAULT false,
    "autoGenerateCreative" BOOLEAN NOT NULL DEFAULT false,
    "creativeTemplate" JSONB,
    "autoBuildAudience" BOOLEAN NOT NULL DEFAULT false,
    "audienceCriteria" JSONB,
    "executionDelay" INTEGER,
    "executionFrequency" TEXT,
    "requireConsent" BOOLEAN NOT NULL DEFAULT true,
    "consentType" TEXT,
    "minConversionRate" DOUBLE PRECISION,
    "maxCostPerAcquisition" DOUBLE PRECISION,
    "totalCampaignsGenerated" INTEGER NOT NULL DEFAULT 0,
    "totalSpend" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "totalConversions" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastExecutedAt" TIMESTAMP(3),

    CONSTRAINT "CampaignAutomationRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TrustScore" (
    "id" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "entityType" "TrustEntityType" NOT NULL,
    "entityContext" JSONB,
    "overallScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "confidenceLevel" "TrustConfidenceLevel" NOT NULL DEFAULT 'LOW',
    "ownershipConfidence" DOUBLE PRECISION,
    "dataAccuracy" DOUBLE PRECISION,
    "marketConfidence" DOUBLE PRECISION,
    "identityVerified" BOOLEAN NOT NULL DEFAULT false,
    "communicationConsent" BOOLEAN NOT NULL DEFAULT false,
    "factors" JSONB NOT NULL,
    "weights" JSONB NOT NULL,
    "previousScore" DOUBLE PRECISION,
    "scoreChange" DOUBLE PRECISION,
    "scoreTrend" TEXT,
    "verifiedBy" TEXT,
    "verifiedAt" TIMESTAMP(3),
    "verificationMethod" TEXT,
    "riskLevel" "TrustRiskLevel" NOT NULL DEFAULT 'UNKNOWN',
    "riskFactors" JSONB,
    "lastCalculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "calculationMethod" TEXT,
    "calculationVersion" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TrustScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MLSFraudPattern" (
    "id" TEXT NOT NULL,
    "patternType" "MLSFraudPatternType" NOT NULL,
    "severity" "FraudSeverity" NOT NULL DEFAULT 'MEDIUM',
    "detectionRules" JSONB NOT NULL,
    "thresholds" JSONB,
    "matchCriteria" JSONB,
    "autoFlag" BOOLEAN NOT NULL DEFAULT true,
    "autoBlock" BOOLEAN NOT NULL DEFAULT false,
    "requireManualReview" BOOLEAN NOT NULL DEFAULT true,
    "totalDetections" INTEGER NOT NULL DEFAULT 0,
    "truePositives" INTEGER NOT NULL DEFAULT 0,
    "falsePositives" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastTriggeredAt" TIMESTAMP(3),

    CONSTRAINT "MLSFraudPattern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "REOProperty" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT,
    "portfolioId" TEXT,
    "status" "REOPropertyStatus" NOT NULL DEFAULT 'BANK_OWNED',
    "propertyType" "REOPropertyType" NOT NULL,
    "loanId" TEXT,
    "borrowerName" TEXT,
    "originalLoanAmount" DECIMAL(14,2),
    "outstandingBalance" DECIMAL(14,2),
    "asIsValue" DECIMAL(14,2),
    "afterRepairValue" DECIMAL(14,2),
    "estimatedRepairCost" DECIMAL(12,2),
    "lastAppraisalDate" TIMESTAMP(3),
    "appraisalCompany" TEXT,
    "assetManagerId" TEXT,
    "propertyManagerId" TEXT,
    "maintenanceVendorId" TEXT,
    "carryingCost" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "insuranceCost" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "taxLiability" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "acquiredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "listedAt" TIMESTAMP(3),
    "soldAt" TIMESTAMP(3),
    "targetDisposalDate" TIMESTAMP(3),
    "dispositionStrategy" TEXT,
    "expectedRecoveryRate" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "REOProperty_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InstitutionalPortfolio" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "ownerType" "InstitutionalOwnerType" NOT NULL,
    "totalProperties" INTEGER NOT NULL DEFAULT 0,
    "totalValue" DECIMAL(16,2) NOT NULL DEFAULT 0,
    "totalDebt" DECIMAL(16,2) NOT NULL DEFAULT 0,
    "equity" DECIMAL(16,2) NOT NULL DEFAULT 0,
    "occupancyRate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "averageNOI" DECIMAL(12,2),
    "weightedCapRate" DOUBLE PRECISION,
    "monthlyRentalIncome" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "monthlyOperatingExpenses" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "netOperatingIncome" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "ytdReturn" DOUBLE PRECISION,
    "irr" DOUBLE PRECISION,
    "totalAppreciation" DECIMAL(16,2),
    "primaryCountry" TEXT,
    "primaryRegion" TEXT,
    "assetMix" JSONB,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InstitutionalPortfolio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PortfolioHolding" (
    "id" TEXT NOT NULL,
    "portfolioId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "purchasePrice" DECIMAL(14,2) NOT NULL,
    "currentValue" DECIMAL(14,2) NOT NULL,
    "equityStake" DOUBLE PRECISION NOT NULL DEFAULT 1.0,
    "acquisitionDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "monthlyIncome" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "annualIncome" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "capRate" DOUBLE PRECISION,
    "noi" DECIMAL(12,2),
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "occupancyStatus" TEXT NOT NULL DEFAULT 'VACANT',
    "leaseEndDate" TIMESTAMP(3),
    "unrealizedGain" DECIMAL(14,2),
    "totalReturnPct" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PortfolioHolding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FinancialAuditLog" (
    "id" TEXT NOT NULL,
    "orgId" TEXT,
    "action" "FinancialAuditAction" NOT NULL,
    "entityType" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "userId" TEXT,
    "actorType" TEXT NOT NULL DEFAULT 'USER',
    "amount" DECIMAL(14,2),
    "currency" TEXT,
    "oldAmount" DECIMAL(14,2),
    "newAmount" DECIMAL(14,2),
    "oldStatus" TEXT,
    "newStatus" TEXT,
    "oldValues" JSONB,
    "newValues" JSONB,
    "changeDelta" JSONB,
    "reservationId" TEXT,
    "leaseId" TEXT,
    "escrowId" TEXT,
    "paymentId" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "sessionId" TEXT,
    "requestId" TEXT,
    "idempotencyKey" TEXT,
    "checksum" TEXT,
    "previousHash" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FinancialAuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BankAccount" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "accountType" "BankAccountType" NOT NULL DEFAULT 'CHECKING',
    "bankName" TEXT NOT NULL,
    "bankCode" TEXT,
    "accountName" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "iban" TEXT,
    "routingNumber" TEXT,
    "sortCode" TEXT,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "country" TEXT NOT NULL,
    "status" "BankAccountStatus" NOT NULL DEFAULT 'PENDING_VERIFICATION',
    "verifiedAt" TIMESTAMP(3),
    "verifiedBy" TEXT,
    "isDefaultForPayouts" BOOLEAN NOT NULL DEFAULT false,
    "isDefaultForReceipts" BOOLEAN NOT NULL DEFAULT false,
    "lastUsedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BankAccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "category" "ProductCategory" NOT NULL,
    "sku" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "images" JSONB,
    "attributes" JSONB,
    "supplierId" TEXT,
    "status" "ProductStatus" NOT NULL DEFAULT 'ACTIVE',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "weight" DOUBLE PRECISION,
    "dimensions" JSONB,
    "commissionRate" DOUBLE PRECISION DEFAULT 0,
    "wholesalePrice" DECIMAL(10,2),
    "retailPrice" DECIMAL(10,2),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Supplier" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "contactName" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "website" TEXT,
    "logo" TEXT,
    "taxId" TEXT,
    "businessType" TEXT,
    "country" TEXT,
    "city" TEXT,
    "paymentTerms" TEXT,
    "minimumOrder" DECIMAL(10,2),
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "leadTimeDays" INTEGER,
    "commissionRate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "status" "SupplierStatus" NOT NULL DEFAULT 'ACTIVE',
    "rating" DOUBLE PRECISION,
    "verifiedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Supplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductBundle" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "bundleType" "BundleType" NOT NULL,
    "totalPrice" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "propertyId" TEXT,
    "propertyType" TEXT,
    "bedrooms" INTEGER,
    "originalPrice" DECIMAL(12,2),
    "discountPct" DOUBLE PRECISION,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "images" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProductBundle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BundleItem" (
    "id" TEXT NOT NULL,
    "bundleId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "unitPrice" DECIMAL(10,2) NOT NULL,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "metadata" JSONB,

    CONSTRAINT "BundleItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommerceAgent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "userId" TEXT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "imageUrl" TEXT,
    "licenseNumber" TEXT,
    "agencyName" TEXT,
    "specializations" JSONB,
    "baseCommissionRate" DOUBLE PRECISION NOT NULL DEFAULT 3.0,
    "bonusThreshold" DECIMAL(12,2),
    "bonusRate" DOUBLE PRECISION DEFAULT 0.5,
    "totalSales" INTEGER NOT NULL DEFAULT 0,
    "totalRevenue" DECIMAL(14,2) NOT NULL DEFAULT 0,
    "averageRating" DOUBLE PRECISION,
    "responseTimeHours" DOUBLE PRECISION,
    "status" "AgentStatus" NOT NULL DEFAULT 'ACTIVE',
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastActiveAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommerceAgent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommerceCommission" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "sourceType" TEXT NOT NULL,
    "sourceId" TEXT NOT NULL,
    "agentId" TEXT,
    "type" "CommissionType" NOT NULL,
    "basis" TEXT,
    "basisAmount" DECIMAL(12,2) NOT NULL,
    "rate" DOUBLE PRECISION NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "platformShare" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "agentShare" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "supplierShare" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "partnerShare" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "status" "CommerceCommissionStatus" NOT NULL DEFAULT 'PENDING',
    "calculatedAt" TIMESTAMP(3),
    "approvedAt" TIMESTAMP(3),
    "paidAt" TIMESTAMP(3),
    "paymentRef" TEXT,
    "orderId" TEXT,
    "productId" TEXT,
    "campaignId" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommerceCommission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommerceOrder" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "orderNumber" TEXT NOT NULL,
    "status" "OrderStatus" NOT NULL DEFAULT 'PENDING',
    "buyerType" TEXT NOT NULL,
    "buyerId" TEXT NOT NULL,
    "buyerName" TEXT,
    "buyerEmail" TEXT,
    "agentId" TEXT,
    "bundleId" TEXT,
    "propertyId" TEXT,
    "subtotal" DECIMAL(12,2) NOT NULL,
    "discount" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "tax" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "total" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "paymentMethod" TEXT,
    "paymentStatus" TEXT NOT NULL DEFAULT 'PENDING',
    "paidAt" TIMESTAMP(3),
    "paymentRef" TEXT,
    "deliveryAddress" JSONB,
    "deliveryDate" TIMESTAMP(3),
    "installationDate" TIMESTAMP(3),
    "financingOption" TEXT,
    "financingTerm" INTEGER,
    "monthlyPayment" DECIMAL(10,2),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommerceOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommerceOrderItem" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "unitPrice" DECIMAL(10,2) NOT NULL,
    "totalAmount" DECIMAL(10,2) NOT NULL,
    "metadata" JSONB,

    CONSTRAINT "CommerceOrderItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommerceCampaign" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "type" TEXT NOT NULL,
    "status" "CommerceCampaignStatus" NOT NULL DEFAULT 'DRAFT',
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),
    "discountType" TEXT,
    "discountValue" DOUBLE PRECISION,
    "maxDiscount" DECIMAL(10,2),
    "minPurchase" DECIMAL(10,2),
    "targetProducts" JSONB,
    "targetBundles" JSONB,
    "targetRegions" JSONB,
    "targetSegments" JSONB,
    "maxUses" INTEGER,
    "currentUses" INTEGER NOT NULL DEFAULT 0,
    "perUserLimit" INTEGER,
    "agentBonusRate" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CommerceCampaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RevenueShare" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "commissionId" TEXT NOT NULL,
    "type" "RevenueShareType" NOT NULL,
    "entityId" TEXT,
    "entityType" TEXT,
    "amount" DECIMAL(12,2) NOT NULL,
    "percentage" DOUBLE PRECISION,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "paidAt" TIMESTAMP(3),
    "paymentRef" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RevenueShare_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "IncomeReadyCertificate" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "propertyName" TEXT,
    "tier" "CertificateTier" NOT NULL,
    "status" "CertificateStatus" NOT NULL DEFAULT 'PENDING',
    "certificateNumber" TEXT NOT NULL,
    "moveInReady" BOOLEAN NOT NULL DEFAULT false,
    "moveInReadyAt" TIMESTAMP(3),
    "incomeReady" BOOLEAN NOT NULL DEFAULT false,
    "incomeReadyAt" TIMESTAMP(3),
    "investmentReady" BOOLEAN NOT NULL DEFAULT false,
    "investmentReadyAt" TIMESTAMP(3),
    "trustScore" DOUBLE PRECISION,
    "annualIncome" DECIMAL(12,2),
    "occupancyRate" DOUBLE PRECISION,
    "maintenanceScore" DOUBLE PRECISION,
    "complianceStatus" TEXT,
    "monthsRented" INTEGER NOT NULL DEFAULT 0,
    "totalIncome" DECIMAL(14,2) NOT NULL DEFAULT 0,
    "averageMonthlyRent" DECIMAL(10,2),
    "yieldRate" DOUBLE PRECISION,
    "furnishedBy" TEXT,
    "furnitureValue" DECIMAL(10,2),
    "furnitureSupplierId" TEXT,
    "documents" JSONB,
    "issuedAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3),
    "renewedAt" TIMESTAMP(3),
    "digitalSignature" TEXT,
    "verificationUrl" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "IncomeReadyCertificate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestmentDeal" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "propertyId" TEXT,
    "name" TEXT NOT NULL,
    "dealType" TEXT DEFAULT 'ACQUISITION',
    "status" TEXT DEFAULT 'DRAFT',
    "investmentAmount" DOUBLE PRECISION,
    "expectedReturn" DOUBLE PRECISION,
    "riskLevel" TEXT DEFAULT 'MEDIUM',
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InvestmentDeal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestmentProjection" (
    "id" TEXT NOT NULL,
    "dealId" TEXT NOT NULL,
    "year" INTEGER NOT NULL,
    "projectedValue" DOUBLE PRECISION,
    "projectedRentalIncome" DOUBLE PRECISION,
    "projectedROI" DOUBLE PRECISION,
    "growthRate" DOUBLE PRECISION,
    "rentalYield" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "InvestmentProjection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MarketComparables" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "comparablePropertyId" TEXT,
    "address" TEXT,
    "price" DOUBLE PRECISION,
    "squareFootage" DOUBLE PRECISION,
    "bedrooms" INTEGER,
    "bathrooms" DOUBLE PRECISION,
    "distance" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MarketComparables_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvestmentInsight" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "region" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "insightType" TEXT NOT NULL DEFAULT 'PRICE_TREND',
    "title" TEXT NOT NULL,
    "description" TEXT,
    "data" JSONB NOT NULL,
    "confidence" DECIMAL(3,2),
    "validFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "validUntil" TIMESTAMP(3),
    "source" TEXT,
    "aiGenerated" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InvestmentInsight_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MaintenanceSchedule" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "vendorId" TEXT,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "scheduledDate" TIMESTAMP(3),
    "completedDate" TIMESTAMP(3),
    "priority" TEXT DEFAULT 'MEDIUM',
    "status" TEXT DEFAULT 'PENDING',
    "cost" DOUBLE PRECISION,
    "notes" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MaintenanceSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VendorRating" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "vendorId" TEXT NOT NULL,
    "userId" TEXT,
    "rating" DOUBLE PRECISION NOT NULL,
    "review" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "VendorRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyInspection" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "inspectorId" TEXT,
    "inspectionType" TEXT NOT NULL,
    "scheduledDate" TIMESTAMP(3),
    "completedDate" TIMESTAMP(3),
    "result" TEXT,
    "status" TEXT DEFAULT 'SCHEDULED',
    "notes" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PropertyInspection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CleaningSchedule" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "cleanerId" TEXT,
    "scheduledDate" TIMESTAMP(3),
    "completedDate" TIMESTAMP(3),
    "status" TEXT DEFAULT 'SCHEDULED',
    "notes" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CleaningSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ServiceProvider" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "rating" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ServiceProvider_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KYCVerification" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "documentType" TEXT NOT NULL,
    "documentNumber" TEXT,
    "documentUrl" TEXT,
    "status" TEXT DEFAULT 'PENDING',
    "reviewerId" TEXT,
    "rejectionReason" TEXT,
    "reviewedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "KYCVerification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudDetection" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "entityType" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "riskLevel" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "evidence" JSONB,
    "status" TEXT DEFAULT 'OPEN',
    "reviewerId" TEXT,
    "resolution" TEXT,
    "resolvedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FraudDetection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AccessAuditLog" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "resource" TEXT NOT NULL,
    "resourceId" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AccessAuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SecurityPolicy" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "policyType" TEXT NOT NULL,
    "rules" JSONB,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SecurityPolicy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GlobalAuditLog" (
    "id" TEXT NOT NULL,
    "orgId" TEXT,
    "userId" TEXT,
    "module" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "entityType" TEXT,
    "entityId" TEXT,
    "severity" TEXT DEFAULT 'INFO',
    "description" TEXT,
    "metadata" JSONB,
    "ipAddress" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GlobalAuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpatialAnalysis" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "healthScore" DOUBLE PRECISION,
    "structuralScore" DOUBLE PRECISION,
    "cosmeticScore" DOUBLE PRECISION,
    "systemsScore" DOUBLE PRECISION,
    "overallGrade" TEXT,
    "defects" JSONB,
    "recommendations" JSONB,
    "estimatedRepairCost" DECIMAL(12,2),
    "estimatedRepairCurrency" TEXT,
    "geminiResponse" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SpatialAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyHealthReport" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "spatialAnalysisId" TEXT,
    "baselineId" TEXT,
    "healthScore" DOUBLE PRECISION NOT NULL,
    "structuralScore" DOUBLE PRECISION NOT NULL,
    "cosmeticScore" DOUBLE PRECISION NOT NULL,
    "systemsScore" DOUBLE PRECISION NOT NULL,
    "overallGrade" TEXT NOT NULL,
    "defects" JSONB,
    "repairEstimate" DECIMAL(12,2),
    "repairCurrency" TEXT,
    "comparisonDelta" DOUBLE PRECISION,
    "geminiSummary" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PropertyHealthReport_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpatialAsset" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "spatialAnalysisId" TEXT,
    "assetType" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "thumbnailUrl" TEXT,
    "roomType" TEXT,
    "dimensions" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SpatialAsset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RoomAnalysis" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "spatialAnalysisId" TEXT NOT NULL,
    "roomName" TEXT NOT NULL,
    "roomType" TEXT,
    "area" DOUBLE PRECISION,
    "condition" TEXT,
    "defects" JSONB,
    "recommendations" JSONB,
    "photos" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "RoomAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InsuranceRiskProfile" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "spatialAnalysisId" TEXT,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "riskLevel" TEXT NOT NULL,
    "factors" JSONB,
    "recommendations" JSONB,
    "premiumEstimate" DECIMAL(12,2),
    "premiumCurrency" TEXT,
    "geminiAnalysis" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InsuranceRiskProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InsuranceProduct" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "productType" TEXT NOT NULL,
    "coverageTypes" JSONB,
    "minPremium" DECIMAL(12,2),
    "maxPremium" DECIMAL(12,2),
    "currency" TEXT,
    "description" TEXT,
    "features" JSONB,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InsuranceProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InsuranceAttachment" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "holderType" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "policyNumber" TEXT,
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),
    "premium" DECIMAL(12,2),
    "currency" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InsuranceAttachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MediaLocalization" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "spatialAssetId" TEXT NOT NULL,
    "targetLanguage" TEXT NOT NULL,
    "translatedTitle" TEXT,
    "translatedDesc" TEXT,
    "altText" TEXT,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "geminiResponse" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MediaLocalization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BrochureAsset" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "language" TEXT NOT NULL,
    "demographicTarget" TEXT,
    "title" TEXT,
    "content" JSONB,
    "pdfUrl" TEXT,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "geminiResponse" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "BrochureAsset_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdCampaign" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "propertyId" TEXT,
    "campaignType" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'DRAFT',
    "network" TEXT,
    "accountId" TEXT,
    "budget" DECIMAL(12,2) NOT NULL,
    "dailyBudget" DECIMAL(12,2),
    "spent" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "impressions" INTEGER NOT NULL DEFAULT 0,
    "clicks" INTEGER NOT NULL DEFAULT 0,
    "conversions" INTEGER NOT NULL DEFAULT 0,
    "cpet" DOUBLE PRECISION,
    "roas" DOUBLE PRECISION,
    "targetDemographics" JSONB,
    "targetingConfig" JSONB,
    "creatives" JSONB,
    "startDate" TIMESTAMP(3),
    "endDate" TIMESTAMP(3),
    "pausedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "AdCampaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdNetworkConfig" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "network" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "apiKey" TEXT,
    "isConnected" BOOLEAN NOT NULL DEFAULT true,
    "lastSyncAt" TIMESTAMP(3),
    "config" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AdNetworkConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdBudgetShiftEvent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL,
    "fromNetwork" TEXT NOT NULL,
    "toNetwork" TEXT NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "reason" TEXT,
    "cpetBefore" DOUBLE PRECISION,
    "cpetAfter" DOUBLE PRECISION,
    "status" TEXT NOT NULL DEFAULT 'EXECUTED',
    "executedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdBudgetShiftEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OfflineConversionEvent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "conversionValue" DECIMAL(12,2),
    "currency" TEXT,
    "gclid" TEXT,
    "externalId" TEXT,
    "sentToNetwork" BOOLEAN NOT NULL DEFAULT false,
    "sentAt" TIMESTAMP(3),
    "networkResponse" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "OfflineConversionEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CreatorProfile" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "userId" TEXT,
    "name" TEXT NOT NULL,
    "email" TEXT,
    "avatarUrl" TEXT,
    "platform" TEXT,
    "handle" TEXT,
    "followers" INTEGER NOT NULL DEFAULT 0,
    "engagementRate" DOUBLE PRECISION,
    "niche" TEXT,
    "tier" TEXT NOT NULL DEFAULT 'STANDARD',
    "commissionRate" DECIMAL(5,2),
    "totalEarnings" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "totalLeads" INTEGER NOT NULL DEFAULT 0,
    "totalConversions" INTEGER NOT NULL DEFAULT 0,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "socialLinks" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "CreatorProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CreatorContent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "creatorId" TEXT NOT NULL,
    "contentType" TEXT NOT NULL,
    "title" TEXT,
    "contentUrl" TEXT,
    "thumbnailUrl" TEXT,
    "propertyId" TEXT,
    "campaignId" TEXT,
    "impressions" INTEGER NOT NULL DEFAULT 0,
    "clicks" INTEGER NOT NULL DEFAULT 0,
    "conversions" INTEGER NOT NULL DEFAULT 0,
    "commission" DECIMAL(12,2),
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "publishedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CreatorContent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LeadRecord" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "creatorId" TEXT NOT NULL,
    "propertyId" TEXT,
    "source" TEXT NOT NULL,
    "contactName" TEXT,
    "contactEmail" TEXT,
    "contactPhone" TEXT,
    "status" TEXT NOT NULL DEFAULT 'NEW',
    "score" DOUBLE PRECISION,
    "convertedAt" TIMESTAMP(3),
    "commission" DECIMAL(12,2),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LeadRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CreatorPayout" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "creatorId" TEXT NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "period" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "processedAt" TIMESTAMP(3),
    "method" TEXT,
    "reference" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CreatorPayout_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdLiquidityPool" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "balance" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "totalFunded" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "totalSpent" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AdLiquidityPool_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ZeroUpfrontCampaign" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "creatorId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "campaignType" TEXT NOT NULL,
    "networks" JSONB,
    "targetDemographics" JSONB,
    "budget" DECIMAL(12,2),
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "impressions" INTEGER NOT NULL DEFAULT 0,
    "clicks" INTEGER NOT NULL DEFAULT 0,
    "conversions" INTEGER NOT NULL DEFAULT 0,
    "roi" DOUBLE PRECISION,
    "settledAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ZeroUpfrontCampaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClosedLoopSettlement" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "reservationId" TEXT NOT NULL,
    "creatorId" TEXT,
    "campaignId" TEXT,
    "bookingAmount" DECIMAL(12,2) NOT NULL,
    "commissionAmount" DECIMAL(12,2) NOT NULL,
    "platformFee" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "netPayout" DECIMAL(12,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "processedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClosedLoopSettlement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TelemetryEvent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "entityType" TEXT,
    "entityId" TEXT,
    "severity" TEXT NOT NULL DEFAULT 'INFO',
    "title" TEXT NOT NULL,
    "description" TEXT,
    "source" TEXT,
    "metadata" JSONB,
    "acknowledgedBy" TEXT,
    "acknowledgedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TelemetryEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GamificationState" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "userId" TEXT,
    "points" INTEGER NOT NULL DEFAULT 0,
    "level" INTEGER NOT NULL DEFAULT 1,
    "streak" INTEGER NOT NULL DEFAULT 0,
    "lastActiveAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GamificationState_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GrowthAchievement" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "userId" TEXT,
    "achievementType" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "points" INTEGER NOT NULL DEFAULT 0,
    "unlockedAt" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GrowthAchievement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConversionFunnel" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "funnelStage" TEXT NOT NULL,
    "count" INTEGER NOT NULL DEFAULT 0,
    "conversionRate" DOUBLE PRECISION,
    "period" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ConversionFunnel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GrowthWidget" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "widgetType" TEXT NOT NULL,
    "title" TEXT,
    "config" JSONB,
    "position" INTEGER NOT NULL DEFAULT 0,
    "isVisible" BOOLEAN NOT NULL DEFAULT true,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GrowthWidget_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyProspect" (
    "id" TEXT NOT NULL,
    "externalListingId" TEXT,
    "propertyFingerprint" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "sourceListingId" TEXT NOT NULL,
    "ingestionDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acquisitionScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "valuationScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "ownerConfidence" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "marketOpportunityScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "overallPriority" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "opportunityTier" "OpportunityTier" NOT NULL DEFAULT 'LOW_POTENTIAL',
    "acquisitionUrgency" "AcquisitionUrgency" NOT NULL DEFAULT 'LOW',
    "ownershipStatus" "ListingLifecycleStatus" NOT NULL DEFAULT 'UNVERIFIED_PROSPECT',
    "complianceStatus" "ComplianceStatus" NOT NULL DEFAULT 'PENDING',
    "propertyId" TEXT,
    "aiAnalyzed" BOOLEAN NOT NULL DEFAULT false,
    "aiAnalysisDate" TIMESTAMP(3),
    "aiConfidenceScore" DOUBLE PRECISION,
    "aiAnalysisMetadata" JSONB,
    "identifiedOwner" BOOLEAN NOT NULL DEFAULT false,
    "identifiedAgent" BOOLEAN NOT NULL DEFAULT false,
    "ownerProfileId" TEXT,
    "agentProfileId" TEXT,
    "valuationReady" BOOLEAN NOT NULL DEFAULT false,
    "valuationId" TEXT,
    "invitationGenerated" BOOLEAN NOT NULL DEFAULT false,
    "invitationId" TEXT,
    "invitationSent" BOOLEAN NOT NULL DEFAULT false,
    "invitationSentAt" TIMESTAMP(3),
    "invitationType" TEXT,
    "optedIn" BOOLEAN NOT NULL DEFAULT false,
    "optedInAt" TIMESTAMP(3),
    "consentId" TEXT,
    "propertyClaimed" BOOLEAN NOT NULL DEFAULT false,
    "claimedAt" TIMESTAMP(3),
    "claimedBy" TEXT,
    "claimMethod" TEXT,
    "fraudFlagged" BOOLEAN NOT NULL DEFAULT false,
    "fraudScore" DOUBLE PRECISION,
    "fraudDetectionId" TEXT,
    "duplicateOf" TEXT,
    "duplicateScore" DOUBLE PRECISION,
    "sourceAttribution" JSONB,
    "sourceMetadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "PropertyProspect_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MLSEvent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "eventType" "MLSEventType" NOT NULL,
    "externalListingId" TEXT NOT NULL,
    "propertyProspectId" TEXT,
    "eventData" JSONB NOT NULL,
    "previousData" JSONB,
    "processed" BOOLEAN NOT NULL DEFAULT false,
    "processedAt" TIMESTAMP(3),
    "processingError" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MLSEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OwnershipClaim" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "propertyProspectId" TEXT NOT NULL,
    "ownerProfileId" TEXT,
    "claimType" TEXT NOT NULL,
    "claimStatus" "OwnershipClaimStatus" NOT NULL DEFAULT 'PENDING',
    "confidenceScore" DOUBLE PRECISION,
    "documents" JSONB,
    "verificationData" JSONB,
    "verifiedBy" TEXT,
    "verifiedAt" TIMESTAMP(3),
    "verificationNotes" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OwnershipClaim_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProspectAIAnalysis" (
    "id" TEXT NOT NULL,
    "propertyProspectId" TEXT NOT NULL,
    "acquisitionScore" DOUBLE PRECISION NOT NULL,
    "valuationScore" DOUBLE PRECISION NOT NULL,
    "ownerConfidence" DOUBLE PRECISION NOT NULL,
    "marketOpportunityScore" DOUBLE PRECISION NOT NULL,
    "overallPriority" DOUBLE PRECISION NOT NULL,
    "opportunityTier" "OpportunityTier" NOT NULL,
    "acquisitionUrgency" "AcquisitionUrgency" NOT NULL,
    "modelVersion" TEXT NOT NULL,
    "modelConfidence" DOUBLE PRECISION NOT NULL,
    "processingTimeMs" INTEGER NOT NULL,
    "keyInsights" JSONB,
    "riskFactors" JSONB,
    "recommendations" JSONB,
    "analyzedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metadata" JSONB,

    CONSTRAINT "ProspectAIAnalysis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ValuationAI" (
    "id" TEXT NOT NULL,
    "propertyProspectId" TEXT,
    "propertyId" TEXT,
    "estimatedValue" DECIMAL(14,2) NOT NULL,
    "valueRangeLow" DECIMAL(14,2) NOT NULL,
    "valueRangeHigh" DECIMAL(14,2) NOT NULL,
    "confidenceScore" DOUBLE PRECISION NOT NULL,
    "marketTrend" TEXT NOT NULL,
    "comparableSales" JSONB,
    "locationScore" DOUBLE PRECISION NOT NULL,
    "conditionScore" DOUBLE PRECISION NOT NULL,
    "amenitiesScore" DOUBLE PRECISION NOT NULL,
    "modelVersion" TEXT NOT NULL,
    "modelType" TEXT NOT NULL,
    "processingTimeMs" INTEGER NOT NULL,
    "valuedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "ValuationAI_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "YieldModel" (
    "id" TEXT NOT NULL,
    "propertyProspectId" TEXT,
    "propertyId" TEXT,
    "capRate" DOUBLE PRECISION NOT NULL,
    "cashOnCashReturn" DOUBLE PRECISION NOT NULL,
    "grossYield" DOUBLE PRECISION NOT NULL,
    "netYield" DOUBLE PRECISION NOT NULL,
    "irr" DOUBLE PRECISION,
    "projectedAnnualIncome" DECIMAL(14,2) NOT NULL,
    "projectedExpenses" DECIMAL(14,2) NOT NULL,
    "projectedNetIncome" DECIMAL(14,2) NOT NULL,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "riskFactors" JSONB,
    "modelVersion" TEXT NOT NULL,
    "confidenceScore" DOUBLE PRECISION NOT NULL,
    "processingTimeMs" INTEGER NOT NULL,
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "YieldModel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OpportunityScore" (
    "id" TEXT NOT NULL,
    "propertyProspectId" TEXT NOT NULL,
    "overallScore" DOUBLE PRECISION NOT NULL,
    "marketScore" DOUBLE PRECISION NOT NULL,
    "competitionScore" DOUBLE PRECISION NOT NULL,
    "timingScore" DOUBLE PRECISION NOT NULL,
    "financialScore" DOUBLE PRECISION NOT NULL,
    "opportunityType" TEXT NOT NULL,
    "estimatedROI" DOUBLE PRECISION,
    "timeToRealization" INTEGER,
    "keyDrivers" JSONB,
    "successProbability" DOUBLE PRECISION NOT NULL,
    "recommendedActions" JSONB,
    "modelVersion" TEXT NOT NULL,
    "confidenceScore" DOUBLE PRECISION NOT NULL,
    "processingTimeMs" INTEGER NOT NULL,
    "scoredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "OpportunityScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AcquisitionCampaign" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "type" "CampaignType" NOT NULL,
    "status" "CampaignStatus" NOT NULL DEFAULT 'DRAFT',
    "targetPropertyProspects" TEXT[],
    "targetOwnerProfiles" TEXT[],
    "targetSegments" JSONB,
    "budget" DECIMAL(14,2) NOT NULL,
    "spentBudget" DECIMAL(14,2) NOT NULL DEFAULT 0,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "impressions" INTEGER NOT NULL DEFAULT 0,
    "clicks" INTEGER NOT NULL DEFAULT 0,
    "conversions" INTEGER NOT NULL DEFAULT 0,
    "conversionRate" DOUBLE PRECISION,
    "costPerConversion" DECIMAL(14,2),
    "aiOptimized" BOOLEAN NOT NULL DEFAULT false,
    "aiOptimizationScore" DOUBLE PRECISION,
    "aiRecommendations" JSONB,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AcquisitionCampaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdAccount" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "platform" "AdPlatform" NOT NULL,
    "accountId" TEXT NOT NULL,
    "accountName" TEXT NOT NULL,
    "credentials" JSONB,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "status" TEXT,
    "dailyBudgetLimit" DECIMAL(14,2),
    "monthlyBudgetLimit" DECIMAL(14,2),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AdAccount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdRoutingRule" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "conditions" JSONB NOT NULL,
    "targetCampaignId" TEXT,
    "targetAdAccountId" TEXT,
    "routingStrategy" TEXT NOT NULL,
    "totalRouted" INTEGER NOT NULL DEFAULT 0,
    "conversionRate" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AdRoutingRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConversionEvent" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "propertyProspectId" TEXT,
    "ownerProfileId" TEXT,
    "campaignId" TEXT,
    "eventData" JSONB NOT NULL,
    "conversionValue" DECIMAL(14,2),
    "attributedTo" TEXT,
    "attributionModel" TEXT,
    "occurredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metadata" JSONB,

    CONSTRAINT "ConversionEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AttributionData" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "conversionEventId" TEXT NOT NULL,
    "touchpointType" TEXT NOT NULL,
    "touchpointSource" TEXT,
    "touchpointValue" DOUBLE PRECISION NOT NULL,
    "touchpointPosition" INTEGER NOT NULL,
    "timeToConversion" INTEGER,
    "journeyId" TEXT,
    "journeyLength" INTEGER,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AttributionData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FraudDetectionRule" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "ruleType" "FraudRuleType" NOT NULL,
    "severity" "FraudSeverity" NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "conditions" JSONB NOT NULL,
    "actions" JSONB NOT NULL,
    "totalDetections" INTEGER NOT NULL DEFAULT 0,
    "truePositives" INTEGER NOT NULL DEFAULT 0,
    "falsePositives" INTEGER NOT NULL DEFAULT 0,
    "accuracyRate" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FraudDetectionRule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PortfolioIntelligence" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "portfolioName" TEXT NOT NULL,
    "propertyCount" INTEGER NOT NULL,
    "totalValue" DECIMAL(14,2) NOT NULL,
    "totalRevenue" DECIMAL(14,2) NOT NULL,
    "totalExpenses" DECIMAL(14,2) NOT NULL,
    "netIncome" DECIMAL(14,2) NOT NULL,
    "averageYield" DOUBLE PRECISION NOT NULL,
    "portfolioIRR" DOUBLE PRECISION,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "diversificationScore" DOUBLE PRECISION NOT NULL,
    "concentrationRisk" JSONB,
    "aiRecommendations" JSONB,
    "optimizationOpportunities" JSONB,
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "PortfolioIntelligence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnalyticsDashboard" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "dashboardType" TEXT NOT NULL,
    "layout" JSONB NOT NULL,
    "widgets" JSONB NOT NULL,
    "defaultFilters" JSONB,
    "sharedWith" TEXT[],
    "isPublic" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AnalyticsDashboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PredictionOutcome" (
    "id" TEXT NOT NULL,
    "country_code" TEXT NOT NULL,
    "propertyId" TEXT,
    "predictionType" "PredictionType" NOT NULL,
    "predictedValue" DOUBLE PRECISION NOT NULL,
    "predictedUnit" TEXT NOT NULL,
    "modelVersion" TEXT NOT NULL,
    "modelType" TEXT NOT NULL,
    "confidenceScore" DOUBLE PRECISION NOT NULL,
    "propertyContext" JSONB,
    "marketContext" JSONB,
    "status" "PredictionStatus" NOT NULL DEFAULT 'PENDING',
    "actualValue" DOUBLE PRECISION,
    "actualUnit" TEXT,
    "actualAt" TIMESTAMP(3),
    "errorDelta" DOUBLE PRECISION,
    "accuracyPercentage" DOUBLE PRECISION,
    "strategyMatch" BOOLEAN,
    "verifiedAt" TIMESTAMP(3),
    "verifiedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PredictionOutcome_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AgentTask" (
    "id" TEXT NOT NULL,
    "agentType" "AgentType" NOT NULL,
    "propertyId" TEXT,
    "taskType" "AgentTaskType" NOT NULL,
    "taskStatus" "AgentTaskStatus" NOT NULL,
    "priority" "TaskPriority" NOT NULL,
    "assignedTo" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "scheduledAt" TIMESTAMP(3),
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "dueDate" TIMESTAMP(3),
    "estimatedHours" DOUBLE PRECISION,
    "actualHours" DOUBLE PRECISION,
    "taskData" JSONB,
    "resultData" JSONB,
    "errorMessage" TEXT,
    "retryCount" INTEGER NOT NULL DEFAULT 0,
    "maxRetries" INTEGER NOT NULL DEFAULT 3,
    "parentTaskId" TEXT,
    "correlationId" TEXT,
    "country_code" TEXT,

    CONSTRAINT "AgentTask_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SEOOpportunityScore" (
    "id" TEXT NOT NULL,
    "countryIsoCode" TEXT NOT NULL,
    "stateCode" TEXT,
    "citySlug" TEXT,
    "districtSlug" TEXT,
    "neighborhoodSlug" TEXT,
    "propertyType" "PropertyType",
    "listingType" "ListingType",
    "intent" "SEOIntent",
    "searchDemand" DOUBLE PRECISION NOT NULL,
    "propertySupply" DOUBLE PRECISION NOT NULL,
    "competitionLevel" DOUBLE PRECISION NOT NULL,
    "investmentValue" DOUBLE PRECISION NOT NULL,
    "conversionProbability" DOUBLE PRECISION NOT NULL,
    "freshnessScore" DOUBLE PRECISION NOT NULL,
    "finalScore" DOUBLE PRECISION NOT NULL,
    "shouldCreate" BOOLEAN NOT NULL,
    "priority" "SEOPagePriority" NOT NULL,
    "updateFrequency" TEXT NOT NULL,
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3),

    CONSTRAINT "SEOOpportunityScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SEOPageEntity" (
    "id" TEXT NOT NULL,
    "entityType" "SEOPageEntityType" NOT NULL,
    "countryIsoCode" TEXT NOT NULL,
    "stateCode" TEXT,
    "citySlug" TEXT,
    "districtSlug" TEXT,
    "neighborhoodSlug" TEXT,
    "propertyType" "PropertyType",
    "listingType" "ListingType",
    "intent" "SEOIntent",
    "slug" TEXT NOT NULL,
    "canonicalUrl" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "metaDescription" TEXT NOT NULL,
    "h1" TEXT NOT NULL,
    "content" JSONB,
    "schemaMarkup" JSONB,
    "seoOpportunityScoreId" TEXT,
    "lastGenerated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUpdated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "SEOPageStatus" NOT NULL,
    "priority" INTEGER,
    "changeFrequency" TEXT,

    CONSTRAINT "SEOPageEntity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SEOKnowledgeGraph" (
    "id" TEXT NOT NULL,
    "entityType" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "entityType2" TEXT,
    "entityId2" TEXT,
    "relationshipType" TEXT NOT NULL,
    "relationshipWeight" DOUBLE PRECISION,
    "confidence" DOUBLE PRECISION,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SEOKnowledgeGraph_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EventIdempotency" (
    "id" TEXT NOT NULL,
    "idempotencyKey" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "eventId" TEXT NOT NULL,
    "aggregateId" TEXT NOT NULL,
    "processedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processingStatus" "ProcessingStatus" NOT NULL,
    "retryCount" INTEGER NOT NULL DEFAULT 0,
    "lastRetryAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "EventIdempotency_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyIntelligenceProfile" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "countryIsoCode" TEXT NOT NULL,
    "citySlug" TEXT NOT NULL,
    "districtSlug" TEXT,
    "neighborhoodSlug" TEXT,
    "intelligenceVersion" TEXT NOT NULL DEFAULT 'v1',
    "confidenceScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "lastAnalyzedAt" TIMESTAMP(3),
    "dataSources" JSONB,
    "analysisStatus" TEXT NOT NULL DEFAULT 'PENDING',
    "buildingType" TEXT,
    "yearBuilt" INTEGER,
    "totalArea" DECIMAL(10,2) NOT NULL,
    "bedroomCount" INTEGER,
    "bathroomCount" INTEGER,
    "currentValue" DECIMAL(15,2) NOT NULL,
    "historicalValue" JSONB,
    "rentalIncome" DECIMAL(12,2),
    "rentalYield" DECIMAL(5,2),
    "estimatedROI" DECIMAL(5,2),
    "marketPosition" TEXT,
    "comparableCount" INTEGER NOT NULL DEFAULT 0,
    "daysOnMarket" INTEGER NOT NULL DEFAULT 0,
    "investmentScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "growthPotential" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "riskScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "liquidityScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "schoolScore" DOUBLE PRECISION,
    "transportScore" DOUBLE PRECISION,
    "healthcareScore" DOUBLE PRECISION,
    "lifestyleScore" DOUBLE PRECISION,
    "aiRecommendation" TEXT,
    "targetBuyerPersona" TEXT,
    "bestMarketingAngle" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PropertyIntelligenceProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyCurrentScore" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "investmentScore" DOUBLE PRECISION NOT NULL,
    "rentalScore" DOUBLE PRECISION NOT NULL,
    "demandScore" DOUBLE PRECISION NOT NULL,
    "locationScore" DOUBLE PRECISION NOT NULL,
    "liquidityScore" DOUBLE PRECISION NOT NULL,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "overallScore" DOUBLE PRECISION NOT NULL,
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modelVersion" TEXT NOT NULL DEFAULT 'v1.0',
    "confidenceScore" DOUBLE PRECISION NOT NULL DEFAULT 0,

    CONSTRAINT "PropertyCurrentScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyScoreHistory" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "investmentScore" DOUBLE PRECISION NOT NULL,
    "rentalScore" DOUBLE PRECISION NOT NULL,
    "demandScore" DOUBLE PRECISION NOT NULL,
    "locationScore" DOUBLE PRECISION NOT NULL,
    "liquidityScore" DOUBLE PRECISION NOT NULL,
    "riskScore" DOUBLE PRECISION NOT NULL,
    "overallScore" DOUBLE PRECISION NOT NULL,
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "modelVersion" TEXT NOT NULL,
    "confidenceScore" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "PropertyScoreHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyDigitalTwin" (
    "id" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    "currentState" JSONB NOT NULL,
    "scenarios" JSONB NOT NULL,
    "predictions" JSONB NOT NULL,
    "assumptions" JSONB NOT NULL,
    "modelVersion" TEXT NOT NULL DEFAULT 'v1.0',
    "confidenceScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "projectedYield" DECIMAL(5,2) NOT NULL,
    "renovationRoiImpact" DECIMAL(5,2),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastSimulatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PropertyDigitalTwin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "CountryCommissionRule_countryCode_idx" ON "CountryCommissionRule"("countryCode");

-- CreateIndex
CREATE INDEX "CountryCommissionRule_agentType_idx" ON "CountryCommissionRule"("agentType");

-- CreateIndex
CREATE INDEX "CountryCommissionRule_isActive_idx" ON "CountryCommissionRule"("isActive");

-- CreateIndex
CREATE INDEX "CountryCommissionRule_effectiveFrom_effectiveUntil_idx" ON "CountryCommissionRule"("effectiveFrom", "effectiveUntil");

-- CreateIndex
CREATE UNIQUE INDEX "CountryCommissionRule_countryCode_agentType_effectiveFrom_key" ON "CountryCommissionRule"("countryCode", "agentType", "effectiveFrom");

-- CreateIndex
CREATE INDEX "CommissionPolicy_orgId_idx" ON "CommissionPolicy"("orgId");

-- CreateIndex
CREATE INDEX "CommissionPolicy_countryCode_idx" ON "CommissionPolicy"("countryCode");

-- CreateIndex
CREATE INDEX "CommissionPolicy_isActive_idx" ON "CommissionPolicy"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "CommissionPolicy_orgId_countryCode_effectiveFrom_key" ON "CommissionPolicy"("orgId", "countryCode", "effectiveFrom");

-- CreateIndex
CREATE INDEX "SettlementPolicy_orgId_idx" ON "SettlementPolicy"("orgId");

-- CreateIndex
CREATE INDEX "SettlementPolicy_countryCode_idx" ON "SettlementPolicy"("countryCode");

-- CreateIndex
CREATE INDEX "SettlementPolicy_isActive_idx" ON "SettlementPolicy"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "SettlementPolicy_orgId_countryCode_settlementType_effective_key" ON "SettlementPolicy"("orgId", "countryCode", "settlementType", "effectiveFrom");

-- CreateIndex
CREATE INDEX "PricingPolicy_orgId_idx" ON "PricingPolicy"("orgId");

-- CreateIndex
CREATE INDEX "PricingPolicy_countryCode_idx" ON "PricingPolicy"("countryCode");

-- CreateIndex
CREATE INDEX "PricingPolicy_isActive_idx" ON "PricingPolicy"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "PricingPolicy_orgId_countryCode_effectiveFrom_key" ON "PricingPolicy"("orgId", "countryCode", "effectiveFrom");

-- CreateIndex
CREATE INDEX "EventLog_status_idx" ON "EventLog"("status");

-- CreateIndex
CREATE INDEX "EventLog_eventType_idx" ON "EventLog"("eventType");

-- CreateIndex
CREATE UNIQUE INDEX "SagaState_correlationId_key" ON "SagaState"("correlationId");

-- CreateIndex
CREATE INDEX "SagaState_sagaType_idx" ON "SagaState"("sagaType");

-- CreateIndex
CREATE INDEX "SagaState_status_idx" ON "SagaState"("status");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_metricType_idx" ON "AnalyticsMetric"("metricType");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_timestamp_idx" ON "AnalyticsMetric"("timestamp");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_orgId_idx" ON "AnalyticsMetric"("orgId");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_financialRecordId_idx" ON "AnalyticsMetric"("financialRecordId");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_taskId_idx" ON "AnalyticsMetric"("taskId");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_propertyId_idx" ON "AnalyticsMetric"("propertyId");

-- CreateIndex
CREATE INDEX "AnalyticsMetric_reservationId_idx" ON "AnalyticsMetric"("reservationId");

-- CreateIndex
CREATE INDEX "KPIConfig_organizationId_idx" ON "KPIConfig"("organizationId");

-- CreateIndex
CREATE INDEX "AIInsight_insightType_idx" ON "AIInsight"("insightType");

-- CreateIndex
CREATE INDEX "AIInsight_timestamp_idx" ON "AIInsight"("timestamp");

-- CreateIndex
CREATE INDEX "AIInsight_organizationId_idx" ON "AIInsight"("organizationId");

-- CreateIndex
CREATE INDEX "DocumentApproval_documentId_idx" ON "DocumentApproval"("documentId");

-- CreateIndex
CREATE INDEX "DocumentApproval_approverId_idx" ON "DocumentApproval"("approverId");

-- CreateIndex
CREATE INDEX "DocumentApproval_status_idx" ON "DocumentApproval"("status");

-- CreateIndex
CREATE INDEX "DocumentVersion_documentId_idx" ON "DocumentVersion"("documentId");

-- CreateIndex
CREATE INDEX "DocumentVersion_versionNumber_idx" ON "DocumentVersion"("versionNumber");

-- CreateIndex
CREATE INDEX "NotificationRule_organizationId_idx" ON "NotificationRule"("organizationId");

-- CreateIndex
CREATE INDEX "NotificationRule_eventType_idx" ON "NotificationRule"("eventType");

-- CreateIndex
CREATE INDEX "NotificationRule_enabled_idx" ON "NotificationRule"("enabled");

-- CreateIndex
CREATE INDEX "NotificationTemplate_organizationId_idx" ON "NotificationTemplate"("organizationId");

-- CreateIndex
CREATE INDEX "NotificationTemplate_type_idx" ON "NotificationTemplate"("type");

-- CreateIndex
CREATE UNIQUE INDEX "UserNotificationPreferences_userId_key" ON "UserNotificationPreferences"("userId");

-- CreateIndex
CREATE INDEX "Team_organizationId_idx" ON "Team"("organizationId");

-- CreateIndex
CREATE INDEX "Team_parentId_idx" ON "Team"("parentId");

-- CreateIndex
CREATE INDEX "UserRole_userId_idx" ON "UserRole"("userId");

-- CreateIndex
CREATE INDEX "UserRole_roleId_idx" ON "UserRole"("roleId");

-- CreateIndex
CREATE INDEX "UserRole_organizationId_idx" ON "UserRole"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "UserRole_userId_roleId_organizationId_key" ON "UserRole"("userId", "roleId", "organizationId");

-- CreateIndex
CREATE INDEX "Device_userId_idx" ON "Device"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Device_userId_deviceIdentifier_key" ON "Device"("userId", "deviceIdentifier");

-- CreateIndex
CREATE INDEX "IdentityEvent_userId_idx" ON "IdentityEvent"("userId");

-- CreateIndex
CREATE INDEX "IdentityEvent_eventType_idx" ON "IdentityEvent"("eventType");

-- CreateIndex
CREATE INDEX "IdentityEvent_createdAt_idx" ON "IdentityEvent"("createdAt");

-- CreateIndex
CREATE INDEX "SSOConfig_organizationId_idx" ON "SSOConfig"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "CountryConfig_code_key" ON "CountryConfig"("code");

-- CreateIndex
CREATE INDEX "CountryConfig_code_idx" ON "CountryConfig"("code");

-- CreateIndex
CREATE INDEX "CountryConfig_isActive_idx" ON "CountryConfig"("isActive");

-- CreateIndex
CREATE UNIQUE INDEX "LanguageConfig_code_key" ON "LanguageConfig"("code");

-- CreateIndex
CREATE INDEX "LanguageConfig_code_idx" ON "LanguageConfig"("code");

-- CreateIndex
CREATE UNIQUE INDEX "CurrencyConfig_code_key" ON "CurrencyConfig"("code");

-- CreateIndex
CREATE INDEX "CurrencyConfig_code_idx" ON "CurrencyConfig"("code");

-- CreateIndex
CREATE INDEX "CurrencyConfig_isActive_idx" ON "CurrencyConfig"("isActive");

-- CreateIndex
CREATE INDEX "LocalizedContent_key_idx" ON "LocalizedContent"("key");

-- CreateIndex
CREATE INDEX "LocalizedContent_language_idx" ON "LocalizedContent"("language");

-- CreateIndex
CREATE UNIQUE INDEX "LocalizedContent_key_language_key" ON "LocalizedContent"("key", "language");

-- CreateIndex
CREATE INDEX "RegionalPricing_countryCode_idx" ON "RegionalPricing"("countryCode");

-- CreateIndex
CREATE INDEX "RegionalPricing_propertyType_idx" ON "RegionalPricing"("propertyType");

-- CreateIndex
CREATE INDEX "RegionalPricing_listingId_idx" ON "RegionalPricing"("listingId");

-- CreateIndex
CREATE INDEX "RegionalPricing_propertyId_idx" ON "RegionalPricing"("propertyId");

-- CreateIndex
CREATE INDEX "RegionalPricing_bookingId_idx" ON "RegionalPricing"("bookingId");

-- CreateIndex
CREATE INDEX "SEOMetadata_path_idx" ON "SEOMetadata"("path");

-- CreateIndex
CREATE INDEX "SEOMetadata_countryCode_idx" ON "SEOMetadata"("countryCode");

-- CreateIndex
CREATE UNIQUE INDEX "SEOMetadata_path_language_countryCode_key" ON "SEOMetadata"("path", "language", "countryCode");

-- CreateIndex
CREATE UNIQUE INDEX "MetricDefinition_name_key" ON "MetricDefinition"("name");

-- CreateIndex
CREATE INDEX "MetricData_metricName_idx" ON "MetricData"("metricName");

-- CreateIndex
CREATE INDEX "MetricData_timestamp_idx" ON "MetricData"("timestamp");

-- CreateIndex
CREATE UNIQUE INDEX "APIEndpoint_path_method_key" ON "APIEndpoint"("path", "method");

-- CreateIndex
CREATE UNIQUE INDEX "PlatformDashboard_dashboardId_key" ON "PlatformDashboard"("dashboardId");

-- CreateIndex
CREATE INDEX "PlatformDashboard_osModule_idx" ON "PlatformDashboard"("osModule");

-- CreateIndex
CREATE INDEX "KumbaraDeposit_orgId_idx" ON "KumbaraDeposit"("orgId");

-- CreateIndex
CREATE INDEX "KumbaraDeposit_leaseId_idx" ON "KumbaraDeposit"("leaseId");

-- CreateIndex
CREATE INDEX "KumbaraDeposit_propertyId_idx" ON "KumbaraDeposit"("propertyId");

-- CreateIndex
CREATE INDEX "KumbaraDeposit_tenantId_idx" ON "KumbaraDeposit"("tenantId");

-- CreateIndex
CREATE INDEX "KumbaraDeposit_status_idx" ON "KumbaraDeposit"("status");

-- CreateIndex
CREATE INDEX "KumbaraDeposit_nextDueDate_idx" ON "KumbaraDeposit"("nextDueDate");

-- CreateIndex
CREATE INDEX "KumbaraContribution_depositId_idx" ON "KumbaraContribution"("depositId");

-- CreateIndex
CREATE INDEX "KumbaraContribution_orgId_idx" ON "KumbaraContribution"("orgId");

-- CreateIndex
CREATE INDEX "KumbaraContribution_status_idx" ON "KumbaraContribution"("status");

-- CreateIndex
CREATE INDEX "KumbaraContribution_dueDate_idx" ON "KumbaraContribution"("dueDate");

-- CreateIndex
CREATE INDEX "KumbaraContribution_paidAt_idx" ON "KumbaraContribution"("paidAt");

-- CreateIndex
CREATE INDEX "KumbaraRule_depositId_idx" ON "KumbaraRule"("depositId");

-- CreateIndex
CREATE INDEX "KumbaraRule_orgId_idx" ON "KumbaraRule"("orgId");

-- CreateIndex
CREATE INDEX "UniversalTrustScore_orgId_idx" ON "UniversalTrustScore"("orgId");

-- CreateIndex
CREATE INDEX "UniversalTrustScore_entityType_entityId_idx" ON "UniversalTrustScore"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "UniversalTrustScore_overallScore_idx" ON "UniversalTrustScore"("overallScore");

-- CreateIndex
CREATE INDEX "UniversalTrustScore_tier_idx" ON "UniversalTrustScore"("tier");

-- CreateIndex
CREATE INDEX "UniversalTrustScore_status_idx" ON "UniversalTrustScore"("status");

-- CreateIndex
CREATE INDEX "UniversalTrustScore_lastCalculatedAt_idx" ON "UniversalTrustScore"("lastCalculatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "UniversalTrustScore_entityType_entityId_orgId_key" ON "UniversalTrustScore"("entityType", "entityId", "orgId");

-- CreateIndex
CREATE INDEX "TrustScoreEvent_scoreId_idx" ON "TrustScoreEvent"("scoreId");

-- CreateIndex
CREATE INDEX "TrustScoreEvent_orgId_idx" ON "TrustScoreEvent"("orgId");

-- CreateIndex
CREATE INDEX "TrustScoreEvent_signalKey_idx" ON "TrustScoreEvent"("signalKey");

-- CreateIndex
CREATE INDEX "TrustScoreEvent_category_idx" ON "TrustScoreEvent"("category");

-- CreateIndex
CREATE INDEX "TrustScoreEvent_calculatedAt_idx" ON "TrustScoreEvent"("calculatedAt");

-- CreateIndex
CREATE INDEX "TrustScoreEvent_isValid_idx" ON "TrustScoreEvent"("isValid");

-- CreateIndex
CREATE INDEX "TrustScoreVersion_scoreId_idx" ON "TrustScoreVersion"("scoreId");

-- CreateIndex
CREATE INDEX "TrustScoreVersion_orgId_idx" ON "TrustScoreVersion"("orgId");

-- CreateIndex
CREATE INDEX "TrustScoreVersion_version_idx" ON "TrustScoreVersion"("version");

-- CreateIndex
CREATE UNIQUE INDEX "TrustScoreVersion_scoreId_version_key" ON "TrustScoreVersion"("scoreId", "version");

-- CreateIndex
CREATE INDEX "PurchaseIntent_orgId_idx" ON "PurchaseIntent"("orgId");

-- CreateIndex
CREATE INDEX "PurchaseIntent_leaseId_idx" ON "PurchaseIntent"("leaseId");

-- CreateIndex
CREATE INDEX "PurchaseIntent_propertyId_idx" ON "PurchaseIntent"("propertyId");

-- CreateIndex
CREATE INDEX "PurchaseIntent_tenantId_idx" ON "PurchaseIntent"("tenantId");

-- CreateIndex
CREATE INDEX "PurchaseIntent_status_idx" ON "PurchaseIntent"("status");

-- CreateIndex
CREATE INDEX "PurchaseIntent_readinessTier_idx" ON "PurchaseIntent"("readinessTier");

-- CreateIndex
CREATE INDEX "PurchaseIntent_buyerReadinessScore_idx" ON "PurchaseIntent"("buyerReadinessScore");

-- CreateIndex
CREATE INDEX "EquityAccumulation_intentId_idx" ON "EquityAccumulation"("intentId");

-- CreateIndex
CREATE INDEX "EquityAccumulation_orgId_idx" ON "EquityAccumulation"("orgId");

-- CreateIndex
CREATE INDEX "EquityAccumulation_periodStart_idx" ON "EquityAccumulation"("periodStart");

-- CreateIndex
CREATE UNIQUE INDEX "OwnershipConversion_intentId_key" ON "OwnershipConversion"("intentId");

-- CreateIndex
CREATE INDEX "OwnershipConversion_orgId_idx" ON "OwnershipConversion"("orgId");

-- CreateIndex
CREATE INDEX "OwnershipConversion_buyerContactId_idx" ON "OwnershipConversion"("buyerContactId");

-- CreateIndex
CREATE UNIQUE INDEX "OwnerProfile_userId_key" ON "OwnerProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "OwnerProfile_email_key" ON "OwnerProfile"("email");

-- CreateIndex
CREATE INDEX "OwnerProfile_email_idx" ON "OwnerProfile"("email");

-- CreateIndex
CREATE INDEX "OwnerProfile_userId_idx" ON "OwnerProfile"("userId");

-- CreateIndex
CREATE INDEX "OwnerProfile_verified_idx" ON "OwnerProfile"("verified");

-- CreateIndex
CREATE INDEX "OwnerProfile_communicationConsent_idx" ON "OwnerProfile"("communicationConsent");

-- CreateIndex
CREATE INDEX "OwnerProfile_marketingOptIn_idx" ON "OwnerProfile"("marketingOptIn");

-- CreateIndex
CREATE INDEX "OwnerProfile_createdAt_idx" ON "OwnerProfile"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "AgentProfile_agentId_key" ON "AgentProfile"("agentId");

-- CreateIndex
CREATE UNIQUE INDEX "AgentProfile_email_key" ON "AgentProfile"("email");

-- CreateIndex
CREATE INDEX "AgentProfile_email_idx" ON "AgentProfile"("email");

-- CreateIndex
CREATE INDEX "AgentProfile_agentId_idx" ON "AgentProfile"("agentId");

-- CreateIndex
CREATE INDEX "AgentProfile_licenseNumber_idx" ON "AgentProfile"("licenseNumber");

-- CreateIndex
CREATE INDEX "AgentProfile_verified_idx" ON "AgentProfile"("verified");

-- CreateIndex
CREATE INDEX "AgentProfile_communicationConsent_idx" ON "AgentProfile"("communicationConsent");

-- CreateIndex
CREATE INDEX "AgentProfile_createdAt_idx" ON "AgentProfile"("createdAt");

-- CreateIndex
CREATE INDEX "Consent_entityId_idx" ON "Consent"("entityId");

-- CreateIndex
CREATE INDEX "Consent_entityType_idx" ON "Consent"("entityType");

-- CreateIndex
CREATE INDEX "Consent_userId_idx" ON "Consent"("userId");

-- CreateIndex
CREATE INDEX "Consent_propertyProspectId_idx" ON "Consent"("propertyProspectId");

-- CreateIndex
CREATE INDEX "Consent_ownerProfileId_idx" ON "Consent"("ownerProfileId");

-- CreateIndex
CREATE INDEX "Consent_agentProfileId_idx" ON "Consent"("agentProfileId");

-- CreateIndex
CREATE INDEX "Consent_consentType_idx" ON "Consent"("consentType");

-- CreateIndex
CREATE INDEX "Consent_consentPurpose_idx" ON "Consent"("consentPurpose");

-- CreateIndex
CREATE INDEX "Consent_consentChannel_idx" ON "Consent"("consentChannel");

-- CreateIndex
CREATE INDEX "Consent_status_idx" ON "Consent"("status");

-- CreateIndex
CREATE INDEX "Consent_gdprConsent_idx" ON "Consent"("gdprConsent");

-- CreateIndex
CREATE INDEX "Consent_ccpaOptOut_idx" ON "Consent"("ccpaOptOut");

-- CreateIndex
CREATE INDEX "Consent_kvkkConsent_idx" ON "Consent"("kvkkConsent");

-- CreateIndex
CREATE INDEX "Consent_grantedAt_idx" ON "Consent"("grantedAt");

-- CreateIndex
CREATE INDEX "Consent_expiresAt_idx" ON "Consent"("expiresAt");

-- CreateIndex
CREATE INDEX "Consent_revokedAt_idx" ON "Consent"("revokedAt");

-- CreateIndex
CREATE UNIQUE INDEX "CommunicationUnsubscribe_email_key" ON "CommunicationUnsubscribe"("email");

-- CreateIndex
CREATE INDEX "CommunicationUnsubscribe_userId_idx" ON "CommunicationUnsubscribe"("userId");

-- CreateIndex
CREATE INDEX "CommunicationUnsubscribe_email_idx" ON "CommunicationUnsubscribe"("email");

-- CreateIndex
CREATE INDEX "CommunicationUnsubscribe_dataDeletionRequested_idx" ON "CommunicationUnsubscribe"("dataDeletionRequested");

-- CreateIndex
CREATE INDEX "CommunicationUnsubscribe_unsubscribeAt_idx" ON "CommunicationUnsubscribe"("unsubscribeAt");

-- CreateIndex
CREATE INDEX "DataProcessingRecord_userId_idx" ON "DataProcessingRecord"("userId");

-- CreateIndex
CREATE INDEX "DataProcessingRecord_propertyProspectId_idx" ON "DataProcessingRecord"("propertyProspectId");

-- CreateIndex
CREATE INDEX "DataProcessingRecord_consentId_idx" ON "DataProcessingRecord"("consentId");

-- CreateIndex
CREATE INDEX "DataProcessingRecord_processingType_idx" ON "DataProcessingRecord"("processingType");

-- CreateIndex
CREATE INDEX "DataProcessingRecord_legalBasis_idx" ON "DataProcessingRecord"("legalBasis");

-- CreateIndex
CREATE INDEX "DataProcessingRecord_processedAt_idx" ON "DataProcessingRecord"("processedAt");

-- CreateIndex
CREATE INDEX "ConsentAuditLog_consentId_idx" ON "ConsentAuditLog"("consentId");

-- CreateIndex
CREATE INDEX "ConsentAuditLog_action_idx" ON "ConsentAuditLog"("action");

-- CreateIndex
CREATE INDEX "ConsentAuditLog_performedAt_idx" ON "ConsentAuditLog"("performedAt");

-- CreateIndex
CREATE UNIQUE INDEX "CorporateAccount_organizationId_key" ON "CorporateAccount"("organizationId");

-- CreateIndex
CREATE UNIQUE INDEX "CorporateAccount_apiKey_key" ON "CorporateAccount"("apiKey");

-- CreateIndex
CREATE INDEX "CorporateAccount_organizationId_idx" ON "CorporateAccount"("organizationId");

-- CreateIndex
CREATE INDEX "CorporateAccount_whitelisted_idx" ON "CorporateAccount"("whitelisted");

-- CreateIndex
CREATE INDEX "CorporateAccount_seattleMarketFocus_idx" ON "CorporateAccount"("seattleMarketFocus");

-- CreateIndex
CREATE INDEX "PortfolioBatch_corporateAccountId_idx" ON "PortfolioBatch"("corporateAccountId");

-- CreateIndex
CREATE INDEX "PortfolioBatch_status_idx" ON "PortfolioBatch"("status");

-- CreateIndex
CREATE INDEX "PortfolioBatch_createdAt_idx" ON "PortfolioBatch"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "BulkInvitation_magicLinkToken_key" ON "BulkInvitation"("magicLinkToken");

-- CreateIndex
CREATE INDEX "BulkInvitation_corporateAccountId_idx" ON "BulkInvitation"("corporateAccountId");

-- CreateIndex
CREATE INDEX "BulkInvitation_magicLinkToken_idx" ON "BulkInvitation"("magicLinkToken");

-- CreateIndex
CREATE INDEX "BulkInvitation_status_idx" ON "BulkInvitation"("status");

-- CreateIndex
CREATE INDEX "BulkInvitation_seattlePilotCampaign_idx" ON "BulkInvitation"("seattlePilotCampaign");

-- CreateIndex
CREATE UNIQUE INDEX "CorporateProperty_propertyId_key" ON "CorporateProperty"("propertyId");

-- CreateIndex
CREATE INDEX "CorporateProperty_corporateAccountId_idx" ON "CorporateProperty"("corporateAccountId");

-- CreateIndex
CREATE INDEX "CorporateProperty_portfolioBatchId_idx" ON "CorporateProperty"("portfolioBatchId");

-- CreateIndex
CREATE INDEX "CorporateProperty_propertyId_idx" ON "CorporateProperty"("propertyId");

-- CreateIndex
CREATE INDEX "CorporateProperty_normalizationStatus_idx" ON "CorporateProperty"("normalizationStatus");

-- CreateIndex
CREATE INDEX "CorporateProperty_seattleNeighborhood_idx" ON "CorporateProperty"("seattleNeighborhood");

-- CreateIndex
CREATE INDEX "AIPitchDeck_corporateAccountId_idx" ON "AIPitchDeck"("corporateAccountId");

-- CreateIndex
CREATE INDEX "AIPitchDeck_status_idx" ON "AIPitchDeck"("status");

-- CreateIndex
CREATE INDEX "AIPitchDeck_generatedAt_idx" ON "AIPitchDeck"("generatedAt");

-- CreateIndex
CREATE INDEX "CorporateTenantMatch_corporateAccountId_idx" ON "CorporateTenantMatch"("corporateAccountId");

-- CreateIndex
CREATE INDEX "CorporateTenantMatch_corporatePropertyId_idx" ON "CorporateTenantMatch"("corporatePropertyId");

-- CreateIndex
CREATE INDEX "CorporateTenantMatch_status_idx" ON "CorporateTenantMatch"("status");

-- CreateIndex
CREATE INDEX "CorporateTenantMatch_matchScore_idx" ON "CorporateTenantMatch"("matchScore");

-- CreateIndex
CREATE INDEX "CampaignAutomationRule_orgId_idx" ON "CampaignAutomationRule"("orgId");

-- CreateIndex
CREATE INDEX "CampaignAutomationRule_status_idx" ON "CampaignAutomationRule"("status");

-- CreateIndex
CREATE INDEX "CampaignAutomationRule_triggerType_idx" ON "CampaignAutomationRule"("triggerType");

-- CreateIndex
CREATE INDEX "CampaignAutomationRule_targetEntityType_idx" ON "CampaignAutomationRule"("targetEntityType");

-- CreateIndex
CREATE INDEX "CampaignAutomationRule_lastExecutedAt_idx" ON "CampaignAutomationRule"("lastExecutedAt");

-- CreateIndex
CREATE INDEX "TrustScore_entityId_idx" ON "TrustScore"("entityId");

-- CreateIndex
CREATE INDEX "TrustScore_entityType_idx" ON "TrustScore"("entityType");

-- CreateIndex
CREATE INDEX "TrustScore_overallScore_idx" ON "TrustScore"("overallScore");

-- CreateIndex
CREATE INDEX "TrustScore_confidenceLevel_idx" ON "TrustScore"("confidenceLevel");

-- CreateIndex
CREATE INDEX "TrustScore_riskLevel_idx" ON "TrustScore"("riskLevel");

-- CreateIndex
CREATE INDEX "TrustScore_lastCalculatedAt_idx" ON "TrustScore"("lastCalculatedAt");

-- CreateIndex
CREATE INDEX "MLSFraudPattern_patternType_idx" ON "MLSFraudPattern"("patternType");

-- CreateIndex
CREATE INDEX "MLSFraudPattern_severity_idx" ON "MLSFraudPattern"("severity");

-- CreateIndex
CREATE INDEX "MLSFraudPattern_totalDetections_idx" ON "MLSFraudPattern"("totalDetections");

-- CreateIndex
CREATE INDEX "MLSFraudPattern_lastTriggeredAt_idx" ON "MLSFraudPattern"("lastTriggeredAt");

-- CreateIndex
CREATE INDEX "REOProperty_orgId_idx" ON "REOProperty"("orgId");

-- CreateIndex
CREATE INDEX "REOProperty_portfolioId_idx" ON "REOProperty"("portfolioId");

-- CreateIndex
CREATE INDEX "REOProperty_propertyId_idx" ON "REOProperty"("propertyId");

-- CreateIndex
CREATE INDEX "REOProperty_status_idx" ON "REOProperty"("status");

-- CreateIndex
CREATE INDEX "REOProperty_propertyType_idx" ON "REOProperty"("propertyType");

-- CreateIndex
CREATE INDEX "REOProperty_acquiredAt_idx" ON "REOProperty"("acquiredAt");

-- CreateIndex
CREATE INDEX "REOProperty_targetDisposalDate_idx" ON "REOProperty"("targetDisposalDate");

-- CreateIndex
CREATE INDEX "InstitutionalPortfolio_orgId_idx" ON "InstitutionalPortfolio"("orgId");

-- CreateIndex
CREATE INDEX "InstitutionalPortfolio_ownerType_idx" ON "InstitutionalPortfolio"("ownerType");

-- CreateIndex
CREATE INDEX "InstitutionalPortfolio_status_idx" ON "InstitutionalPortfolio"("status");

-- CreateIndex
CREATE INDEX "PortfolioHolding_portfolioId_idx" ON "PortfolioHolding"("portfolioId");

-- CreateIndex
CREATE INDEX "PortfolioHolding_propertyId_idx" ON "PortfolioHolding"("propertyId");

-- CreateIndex
CREATE INDEX "PortfolioHolding_orgId_idx" ON "PortfolioHolding"("orgId");

-- CreateIndex
CREATE UNIQUE INDEX "PortfolioHolding_portfolioId_propertyId_key" ON "PortfolioHolding"("portfolioId", "propertyId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_orgId_idx" ON "FinancialAuditLog"("orgId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_entityType_entityId_idx" ON "FinancialAuditLog"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_action_idx" ON "FinancialAuditLog"("action");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_userId_idx" ON "FinancialAuditLog"("userId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_createdAt_idx" ON "FinancialAuditLog"("createdAt");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_reservationId_idx" ON "FinancialAuditLog"("reservationId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_leaseId_idx" ON "FinancialAuditLog"("leaseId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_escrowId_idx" ON "FinancialAuditLog"("escrowId");

-- CreateIndex
CREATE INDEX "FinancialAuditLog_idempotencyKey_idx" ON "FinancialAuditLog"("idempotencyKey");

-- CreateIndex
CREATE INDEX "BankAccount_orgId_idx" ON "BankAccount"("orgId");

-- CreateIndex
CREATE INDEX "BankAccount_status_idx" ON "BankAccount"("status");

-- CreateIndex
CREATE INDEX "BankAccount_isDefaultForPayouts_idx" ON "BankAccount"("isDefaultForPayouts");

-- CreateIndex
CREATE UNIQUE INDEX "Product_sku_key" ON "Product"("sku");

-- CreateIndex
CREATE INDEX "Product_orgId_idx" ON "Product"("orgId");

-- CreateIndex
CREATE INDEX "Product_category_idx" ON "Product"("category");

-- CreateIndex
CREATE INDEX "Product_supplierId_idx" ON "Product"("supplierId");

-- CreateIndex
CREATE INDEX "Product_status_idx" ON "Product"("status");

-- CreateIndex
CREATE INDEX "Supplier_orgId_idx" ON "Supplier"("orgId");

-- CreateIndex
CREATE INDEX "Supplier_status_idx" ON "Supplier"("status");

-- CreateIndex
CREATE INDEX "Supplier_country_idx" ON "Supplier"("country");

-- CreateIndex
CREATE INDEX "ProductBundle_orgId_idx" ON "ProductBundle"("orgId");

-- CreateIndex
CREATE INDEX "ProductBundle_bundleType_idx" ON "ProductBundle"("bundleType");

-- CreateIndex
CREATE INDEX "ProductBundle_propertyId_idx" ON "ProductBundle"("propertyId");

-- CreateIndex
CREATE INDEX "BundleItem_bundleId_idx" ON "BundleItem"("bundleId");

-- CreateIndex
CREATE INDEX "BundleItem_productId_idx" ON "BundleItem"("productId");

-- CreateIndex
CREATE UNIQUE INDEX "BundleItem_bundleId_productId_key" ON "BundleItem"("bundleId", "productId");

-- CreateIndex
CREATE INDEX "CommerceAgent_orgId_idx" ON "CommerceAgent"("orgId");

-- CreateIndex
CREATE INDEX "CommerceAgent_userId_idx" ON "CommerceAgent"("userId");

-- CreateIndex
CREATE INDEX "CommerceAgent_status_idx" ON "CommerceAgent"("status");

-- CreateIndex
CREATE INDEX "CommerceAgent_email_idx" ON "CommerceAgent"("email");

-- CreateIndex
CREATE INDEX "CommerceCommission_orgId_idx" ON "CommerceCommission"("orgId");

-- CreateIndex
CREATE INDEX "CommerceCommission_agentId_idx" ON "CommerceCommission"("agentId");

-- CreateIndex
CREATE INDEX "CommerceCommission_sourceType_sourceId_idx" ON "CommerceCommission"("sourceType", "sourceId");

-- CreateIndex
CREATE INDEX "CommerceCommission_type_idx" ON "CommerceCommission"("type");

-- CreateIndex
CREATE INDEX "CommerceCommission_status_idx" ON "CommerceCommission"("status");

-- CreateIndex
CREATE INDEX "CommerceCommission_createdAt_idx" ON "CommerceCommission"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "CommerceOrder_orderNumber_key" ON "CommerceOrder"("orderNumber");

-- CreateIndex
CREATE INDEX "CommerceOrder_orgId_idx" ON "CommerceOrder"("orgId");

-- CreateIndex
CREATE INDEX "CommerceOrder_orderNumber_idx" ON "CommerceOrder"("orderNumber");

-- CreateIndex
CREATE INDEX "CommerceOrder_status_idx" ON "CommerceOrder"("status");

-- CreateIndex
CREATE INDEX "CommerceOrder_buyerType_buyerId_idx" ON "CommerceOrder"("buyerType", "buyerId");

-- CreateIndex
CREATE INDEX "CommerceOrder_agentId_idx" ON "CommerceOrder"("agentId");

-- CreateIndex
CREATE INDEX "CommerceOrder_propertyId_idx" ON "CommerceOrder"("propertyId");

-- CreateIndex
CREATE INDEX "CommerceOrder_createdAt_idx" ON "CommerceOrder"("createdAt");

-- CreateIndex
CREATE INDEX "CommerceOrderItem_orderId_idx" ON "CommerceOrderItem"("orderId");

-- CreateIndex
CREATE INDEX "CommerceOrderItem_productId_idx" ON "CommerceOrderItem"("productId");

-- CreateIndex
CREATE INDEX "CommerceCampaign_orgId_idx" ON "CommerceCampaign"("orgId");

-- CreateIndex
CREATE INDEX "CommerceCampaign_status_idx" ON "CommerceCampaign"("status");

-- CreateIndex
CREATE INDEX "CommerceCampaign_startDate_endDate_idx" ON "CommerceCampaign"("startDate", "endDate");

-- CreateIndex
CREATE INDEX "RevenueShare_orgId_idx" ON "RevenueShare"("orgId");

-- CreateIndex
CREATE INDEX "RevenueShare_commissionId_idx" ON "RevenueShare"("commissionId");

-- CreateIndex
CREATE INDEX "RevenueShare_type_idx" ON "RevenueShare"("type");

-- CreateIndex
CREATE INDEX "RevenueShare_entityType_entityId_idx" ON "RevenueShare"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "RevenueShare_status_idx" ON "RevenueShare"("status");

-- CreateIndex
CREATE UNIQUE INDEX "IncomeReadyCertificate_certificateNumber_key" ON "IncomeReadyCertificate"("certificateNumber");

-- CreateIndex
CREATE INDEX "IncomeReadyCertificate_orgId_idx" ON "IncomeReadyCertificate"("orgId");

-- CreateIndex
CREATE INDEX "IncomeReadyCertificate_propertyId_idx" ON "IncomeReadyCertificate"("propertyId");

-- CreateIndex
CREATE INDEX "IncomeReadyCertificate_tier_idx" ON "IncomeReadyCertificate"("tier");

-- CreateIndex
CREATE INDEX "IncomeReadyCertificate_status_idx" ON "IncomeReadyCertificate"("status");

-- CreateIndex
CREATE INDEX "IncomeReadyCertificate_certificateNumber_idx" ON "IncomeReadyCertificate"("certificateNumber");

-- CreateIndex
CREATE INDEX "IncomeReadyCertificate_issuedAt_idx" ON "IncomeReadyCertificate"("issuedAt");

-- CreateIndex
CREATE INDEX "InvestmentDeal_orgId_idx" ON "InvestmentDeal"("orgId");

-- CreateIndex
CREATE INDEX "InvestmentDeal_userId_idx" ON "InvestmentDeal"("userId");

-- CreateIndex
CREATE INDEX "InvestmentDeal_propertyId_idx" ON "InvestmentDeal"("propertyId");

-- CreateIndex
CREATE INDEX "InvestmentDeal_status_idx" ON "InvestmentDeal"("status");

-- CreateIndex
CREATE INDEX "InvestmentProjection_dealId_idx" ON "InvestmentProjection"("dealId");

-- CreateIndex
CREATE INDEX "InvestmentProjection_year_idx" ON "InvestmentProjection"("year");

-- CreateIndex
CREATE INDEX "MarketComparables_propertyId_idx" ON "MarketComparables"("propertyId");

-- CreateIndex
CREATE INDEX "MarketComparables_comparablePropertyId_idx" ON "MarketComparables"("comparablePropertyId");

-- CreateIndex
CREATE INDEX "InvestmentInsight_orgId_idx" ON "InvestmentInsight"("orgId");

-- CreateIndex
CREATE INDEX "InvestmentInsight_region_country_idx" ON "InvestmentInsight"("region", "country");

-- CreateIndex
CREATE INDEX "InvestmentInsight_insightType_idx" ON "InvestmentInsight"("insightType");

-- CreateIndex
CREATE INDEX "MaintenanceSchedule_orgId_idx" ON "MaintenanceSchedule"("orgId");

-- CreateIndex
CREATE INDEX "MaintenanceSchedule_propertyId_idx" ON "MaintenanceSchedule"("propertyId");

-- CreateIndex
CREATE INDEX "MaintenanceSchedule_vendorId_idx" ON "MaintenanceSchedule"("vendorId");

-- CreateIndex
CREATE INDEX "MaintenanceSchedule_status_idx" ON "MaintenanceSchedule"("status");

-- CreateIndex
CREATE INDEX "MaintenanceSchedule_scheduledDate_idx" ON "MaintenanceSchedule"("scheduledDate");

-- CreateIndex
CREATE INDEX "VendorRating_orgId_idx" ON "VendorRating"("orgId");

-- CreateIndex
CREATE INDEX "VendorRating_vendorId_idx" ON "VendorRating"("vendorId");

-- CreateIndex
CREATE INDEX "VendorRating_rating_idx" ON "VendorRating"("rating");

-- CreateIndex
CREATE INDEX "PropertyInspection_orgId_idx" ON "PropertyInspection"("orgId");

-- CreateIndex
CREATE INDEX "PropertyInspection_propertyId_idx" ON "PropertyInspection"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyInspection_status_idx" ON "PropertyInspection"("status");

-- CreateIndex
CREATE INDEX "CleaningSchedule_orgId_idx" ON "CleaningSchedule"("orgId");

-- CreateIndex
CREATE INDEX "CleaningSchedule_propertyId_idx" ON "CleaningSchedule"("propertyId");

-- CreateIndex
CREATE INDEX "CleaningSchedule_status_idx" ON "CleaningSchedule"("status");

-- CreateIndex
CREATE INDEX "ServiceProvider_orgId_idx" ON "ServiceProvider"("orgId");

-- CreateIndex
CREATE INDEX "ServiceProvider_category_idx" ON "ServiceProvider"("category");

-- CreateIndex
CREATE INDEX "ServiceProvider_name_idx" ON "ServiceProvider"("name");

-- CreateIndex
CREATE INDEX "KYCVerification_userId_idx" ON "KYCVerification"("userId");

-- CreateIndex
CREATE INDEX "KYCVerification_orgId_idx" ON "KYCVerification"("orgId");

-- CreateIndex
CREATE INDEX "KYCVerification_status_idx" ON "KYCVerification"("status");

-- CreateIndex
CREATE INDEX "FraudDetection_orgId_idx" ON "FraudDetection"("orgId");

-- CreateIndex
CREATE INDEX "FraudDetection_entityType_entityId_idx" ON "FraudDetection"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "FraudDetection_riskLevel_idx" ON "FraudDetection"("riskLevel");

-- CreateIndex
CREATE INDEX "FraudDetection_status_idx" ON "FraudDetection"("status");

-- CreateIndex
CREATE INDEX "AccessAuditLog_orgId_idx" ON "AccessAuditLog"("orgId");

-- CreateIndex
CREATE INDEX "AccessAuditLog_userId_idx" ON "AccessAuditLog"("userId");

-- CreateIndex
CREATE INDEX "AccessAuditLog_action_idx" ON "AccessAuditLog"("action");

-- CreateIndex
CREATE INDEX "AccessAuditLog_resource_idx" ON "AccessAuditLog"("resource");

-- CreateIndex
CREATE INDEX "AccessAuditLog_createdAt_idx" ON "AccessAuditLog"("createdAt");

-- CreateIndex
CREATE INDEX "SecurityPolicy_orgId_idx" ON "SecurityPolicy"("orgId");

-- CreateIndex
CREATE INDEX "SecurityPolicy_policyType_idx" ON "SecurityPolicy"("policyType");

-- CreateIndex
CREATE INDEX "SecurityPolicy_isActive_idx" ON "SecurityPolicy"("isActive");

-- CreateIndex
CREATE INDEX "GlobalAuditLog_orgId_idx" ON "GlobalAuditLog"("orgId");

-- CreateIndex
CREATE INDEX "GlobalAuditLog_userId_idx" ON "GlobalAuditLog"("userId");

-- CreateIndex
CREATE INDEX "GlobalAuditLog_module_idx" ON "GlobalAuditLog"("module");

-- CreateIndex
CREATE INDEX "GlobalAuditLog_entityType_entityId_idx" ON "GlobalAuditLog"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "GlobalAuditLog_severity_idx" ON "GlobalAuditLog"("severity");

-- CreateIndex
CREATE INDEX "GlobalAuditLog_createdAt_idx" ON "GlobalAuditLog"("createdAt");

-- CreateIndex
CREATE INDEX "SpatialAnalysis_orgId_idx" ON "SpatialAnalysis"("orgId");

-- CreateIndex
CREATE INDEX "SpatialAnalysis_propertyId_idx" ON "SpatialAnalysis"("propertyId");

-- CreateIndex
CREATE INDEX "SpatialAnalysis_status_idx" ON "SpatialAnalysis"("status");

-- CreateIndex
CREATE INDEX "PropertyHealthReport_orgId_idx" ON "PropertyHealthReport"("orgId");

-- CreateIndex
CREATE INDEX "PropertyHealthReport_propertyId_idx" ON "PropertyHealthReport"("propertyId");

-- CreateIndex
CREATE INDEX "SpatialAsset_orgId_idx" ON "SpatialAsset"("orgId");

-- CreateIndex
CREATE INDEX "SpatialAsset_propertyId_idx" ON "SpatialAsset"("propertyId");

-- CreateIndex
CREATE INDEX "RoomAnalysis_orgId_idx" ON "RoomAnalysis"("orgId");

-- CreateIndex
CREATE INDEX "RoomAnalysis_spatialAnalysisId_idx" ON "RoomAnalysis"("spatialAnalysisId");

-- CreateIndex
CREATE INDEX "InsuranceRiskProfile_orgId_idx" ON "InsuranceRiskProfile"("orgId");

-- CreateIndex
CREATE INDEX "InsuranceRiskProfile_propertyId_idx" ON "InsuranceRiskProfile"("propertyId");

-- CreateIndex
CREATE INDEX "InsuranceProduct_orgId_idx" ON "InsuranceProduct"("orgId");

-- CreateIndex
CREATE INDEX "InsuranceProduct_productType_idx" ON "InsuranceProduct"("productType");

-- CreateIndex
CREATE INDEX "InsuranceProduct_isActive_idx" ON "InsuranceProduct"("isActive");

-- CreateIndex
CREATE INDEX "InsuranceAttachment_orgId_idx" ON "InsuranceAttachment"("orgId");

-- CreateIndex
CREATE INDEX "InsuranceAttachment_propertyId_idx" ON "InsuranceAttachment"("propertyId");

-- CreateIndex
CREATE INDEX "InsuranceAttachment_productId_idx" ON "InsuranceAttachment"("productId");

-- CreateIndex
CREATE INDEX "MediaLocalization_orgId_idx" ON "MediaLocalization"("orgId");

-- CreateIndex
CREATE INDEX "MediaLocalization_spatialAssetId_idx" ON "MediaLocalization"("spatialAssetId");

-- CreateIndex
CREATE INDEX "MediaLocalization_targetLanguage_idx" ON "MediaLocalization"("targetLanguage");

-- CreateIndex
CREATE INDEX "BrochureAsset_orgId_idx" ON "BrochureAsset"("orgId");

-- CreateIndex
CREATE INDEX "BrochureAsset_propertyId_idx" ON "BrochureAsset"("propertyId");

-- CreateIndex
CREATE INDEX "BrochureAsset_language_idx" ON "BrochureAsset"("language");

-- CreateIndex
CREATE INDEX "AdCampaign_orgId_idx" ON "AdCampaign"("orgId");

-- CreateIndex
CREATE INDEX "AdCampaign_propertyId_idx" ON "AdCampaign"("propertyId");

-- CreateIndex
CREATE INDEX "AdCampaign_status_idx" ON "AdCampaign"("status");

-- CreateIndex
CREATE INDEX "AdCampaign_network_idx" ON "AdCampaign"("network");

-- CreateIndex
CREATE INDEX "AdCampaign_campaignType_idx" ON "AdCampaign"("campaignType");

-- CreateIndex
CREATE INDEX "AdNetworkConfig_orgId_idx" ON "AdNetworkConfig"("orgId");

-- CreateIndex
CREATE INDEX "AdNetworkConfig_network_idx" ON "AdNetworkConfig"("network");

-- CreateIndex
CREATE UNIQUE INDEX "AdNetworkConfig_orgId_network_accountId_key" ON "AdNetworkConfig"("orgId", "network", "accountId");

-- CreateIndex
CREATE INDEX "AdBudgetShiftEvent_orgId_idx" ON "AdBudgetShiftEvent"("orgId");

-- CreateIndex
CREATE INDEX "AdBudgetShiftEvent_campaignId_idx" ON "AdBudgetShiftEvent"("campaignId");

-- CreateIndex
CREATE INDEX "AdBudgetShiftEvent_fromNetwork_toNetwork_idx" ON "AdBudgetShiftEvent"("fromNetwork", "toNetwork");

-- CreateIndex
CREATE INDEX "AdBudgetShiftEvent_createdAt_idx" ON "AdBudgetShiftEvent"("createdAt");

-- CreateIndex
CREATE INDEX "OfflineConversionEvent_orgId_idx" ON "OfflineConversionEvent"("orgId");

-- CreateIndex
CREATE INDEX "OfflineConversionEvent_campaignId_idx" ON "OfflineConversionEvent"("campaignId");

-- CreateIndex
CREATE INDEX "OfflineConversionEvent_sentToNetwork_idx" ON "OfflineConversionEvent"("sentToNetwork");

-- CreateIndex
CREATE INDEX "OfflineConversionEvent_createdAt_idx" ON "OfflineConversionEvent"("createdAt");

-- CreateIndex
CREATE INDEX "CreatorProfile_orgId_idx" ON "CreatorProfile"("orgId");

-- CreateIndex
CREATE INDEX "CreatorProfile_status_idx" ON "CreatorProfile"("status");

-- CreateIndex
CREATE INDEX "CreatorProfile_tier_idx" ON "CreatorProfile"("tier");

-- CreateIndex
CREATE INDEX "CreatorContent_orgId_idx" ON "CreatorContent"("orgId");

-- CreateIndex
CREATE INDEX "CreatorContent_creatorId_idx" ON "CreatorContent"("creatorId");

-- CreateIndex
CREATE INDEX "CreatorContent_contentType_idx" ON "CreatorContent"("contentType");

-- CreateIndex
CREATE INDEX "CreatorContent_propertyId_idx" ON "CreatorContent"("propertyId");

-- CreateIndex
CREATE INDEX "LeadRecord_orgId_idx" ON "LeadRecord"("orgId");

-- CreateIndex
CREATE INDEX "LeadRecord_creatorId_idx" ON "LeadRecord"("creatorId");

-- CreateIndex
CREATE INDEX "LeadRecord_status_idx" ON "LeadRecord"("status");

-- CreateIndex
CREATE INDEX "CreatorPayout_orgId_idx" ON "CreatorPayout"("orgId");

-- CreateIndex
CREATE INDEX "CreatorPayout_creatorId_idx" ON "CreatorPayout"("creatorId");

-- CreateIndex
CREATE INDEX "CreatorPayout_status_idx" ON "CreatorPayout"("status");

-- CreateIndex
CREATE UNIQUE INDEX "AdLiquidityPool_orgId_key" ON "AdLiquidityPool"("orgId");

-- CreateIndex
CREATE INDEX "AdLiquidityPool_orgId_idx" ON "AdLiquidityPool"("orgId");

-- CreateIndex
CREATE INDEX "ZeroUpfrontCampaign_orgId_idx" ON "ZeroUpfrontCampaign"("orgId");

-- CreateIndex
CREATE INDEX "ZeroUpfrontCampaign_creatorId_idx" ON "ZeroUpfrontCampaign"("creatorId");

-- CreateIndex
CREATE INDEX "ZeroUpfrontCampaign_propertyId_idx" ON "ZeroUpfrontCampaign"("propertyId");

-- CreateIndex
CREATE INDEX "ZeroUpfrontCampaign_status_idx" ON "ZeroUpfrontCampaign"("status");

-- CreateIndex
CREATE INDEX "ClosedLoopSettlement_orgId_idx" ON "ClosedLoopSettlement"("orgId");

-- CreateIndex
CREATE INDEX "ClosedLoopSettlement_reservationId_idx" ON "ClosedLoopSettlement"("reservationId");

-- CreateIndex
CREATE INDEX "ClosedLoopSettlement_creatorId_idx" ON "ClosedLoopSettlement"("creatorId");

-- CreateIndex
CREATE INDEX "ClosedLoopSettlement_status_idx" ON "ClosedLoopSettlement"("status");

-- CreateIndex
CREATE INDEX "TelemetryEvent_orgId_idx" ON "TelemetryEvent"("orgId");

-- CreateIndex
CREATE INDEX "TelemetryEvent_eventType_idx" ON "TelemetryEvent"("eventType");

-- CreateIndex
CREATE INDEX "TelemetryEvent_entityType_entityId_idx" ON "TelemetryEvent"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "TelemetryEvent_severity_idx" ON "TelemetryEvent"("severity");

-- CreateIndex
CREATE INDEX "TelemetryEvent_createdAt_idx" ON "TelemetryEvent"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "GamificationState_orgId_key" ON "GamificationState"("orgId");

-- CreateIndex
CREATE INDEX "GamificationState_orgId_idx" ON "GamificationState"("orgId");

-- CreateIndex
CREATE INDEX "GamificationState_userId_idx" ON "GamificationState"("userId");

-- CreateIndex
CREATE INDEX "GrowthAchievement_orgId_idx" ON "GrowthAchievement"("orgId");

-- CreateIndex
CREATE INDEX "GrowthAchievement_userId_idx" ON "GrowthAchievement"("userId");

-- CreateIndex
CREATE INDEX "GrowthAchievement_achievementType_idx" ON "GrowthAchievement"("achievementType");

-- CreateIndex
CREATE INDEX "ConversionFunnel_orgId_idx" ON "ConversionFunnel"("orgId");

-- CreateIndex
CREATE INDEX "ConversionFunnel_funnelStage_idx" ON "ConversionFunnel"("funnelStage");

-- CreateIndex
CREATE INDEX "ConversionFunnel_period_idx" ON "ConversionFunnel"("period");

-- CreateIndex
CREATE INDEX "ConversionFunnel_startDate_endDate_idx" ON "ConversionFunnel"("startDate", "endDate");

-- CreateIndex
CREATE INDEX "GrowthWidget_orgId_idx" ON "GrowthWidget"("orgId");

-- CreateIndex
CREATE INDEX "GrowthWidget_widgetType_idx" ON "GrowthWidget"("widgetType");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyProspect_propertyFingerprint_key" ON "PropertyProspect"("propertyFingerprint");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyProspect_propertyId_key" ON "PropertyProspect"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyProspect_propertyFingerprint_idx" ON "PropertyProspect"("propertyFingerprint");

-- CreateIndex
CREATE INDEX "PropertyProspect_sourceListingId_idx" ON "PropertyProspect"("sourceListingId");

-- CreateIndex
CREATE INDEX "PropertyProspect_ownershipStatus_idx" ON "PropertyProspect"("ownershipStatus");

-- CreateIndex
CREATE INDEX "PropertyProspect_complianceStatus_idx" ON "PropertyProspect"("complianceStatus");

-- CreateIndex
CREATE INDEX "PropertyProspect_opportunityTier_idx" ON "PropertyProspect"("opportunityTier");

-- CreateIndex
CREATE INDEX "PropertyProspect_acquisitionUrgency_idx" ON "PropertyProspect"("acquisitionUrgency");

-- CreateIndex
CREATE INDEX "PropertyProspect_acquisitionScore_idx" ON "PropertyProspect"("acquisitionScore");

-- CreateIndex
CREATE INDEX "PropertyProspect_aiAnalyzed_idx" ON "PropertyProspect"("aiAnalyzed");

-- CreateIndex
CREATE INDEX "PropertyProspect_valuationReady_idx" ON "PropertyProspect"("valuationReady");

-- CreateIndex
CREATE INDEX "PropertyProspect_optedIn_idx" ON "PropertyProspect"("optedIn");

-- CreateIndex
CREATE INDEX "PropertyProspect_propertyClaimed_idx" ON "PropertyProspect"("propertyClaimed");

-- CreateIndex
CREATE INDEX "PropertyProspect_fraudFlagged_idx" ON "PropertyProspect"("fraudFlagged");

-- CreateIndex
CREATE INDEX "PropertyProspect_duplicateOf_idx" ON "PropertyProspect"("duplicateOf");

-- CreateIndex
CREATE INDEX "PropertyProspect_createdAt_idx" ON "PropertyProspect"("createdAt");

-- CreateIndex
CREATE INDEX "MLSEvent_orgId_idx" ON "MLSEvent"("orgId");

-- CreateIndex
CREATE INDEX "MLSEvent_externalListingId_idx" ON "MLSEvent"("externalListingId");

-- CreateIndex
CREATE INDEX "MLSEvent_eventType_idx" ON "MLSEvent"("eventType");

-- CreateIndex
CREATE INDEX "MLSEvent_processed_idx" ON "MLSEvent"("processed");

-- CreateIndex
CREATE INDEX "MLSEvent_createdAt_idx" ON "MLSEvent"("createdAt");

-- CreateIndex
CREATE INDEX "OwnershipClaim_orgId_idx" ON "OwnershipClaim"("orgId");

-- CreateIndex
CREATE INDEX "OwnershipClaim_propertyProspectId_idx" ON "OwnershipClaim"("propertyProspectId");

-- CreateIndex
CREATE INDEX "OwnershipClaim_ownerProfileId_idx" ON "OwnershipClaim"("ownerProfileId");

-- CreateIndex
CREATE INDEX "OwnershipClaim_claimStatus_idx" ON "OwnershipClaim"("claimStatus");

-- CreateIndex
CREATE INDEX "OwnershipClaim_confidenceScore_idx" ON "OwnershipClaim"("confidenceScore");

-- CreateIndex
CREATE INDEX "ProspectAIAnalysis_propertyProspectId_idx" ON "ProspectAIAnalysis"("propertyProspectId");

-- CreateIndex
CREATE INDEX "ProspectAIAnalysis_opportunityTier_idx" ON "ProspectAIAnalysis"("opportunityTier");

-- CreateIndex
CREATE INDEX "ProspectAIAnalysis_acquisitionUrgency_idx" ON "ProspectAIAnalysis"("acquisitionUrgency");

-- CreateIndex
CREATE INDEX "ProspectAIAnalysis_overallPriority_idx" ON "ProspectAIAnalysis"("overallPriority");

-- CreateIndex
CREATE INDEX "ProspectAIAnalysis_analyzedAt_idx" ON "ProspectAIAnalysis"("analyzedAt");

-- CreateIndex
CREATE INDEX "ValuationAI_propertyProspectId_idx" ON "ValuationAI"("propertyProspectId");

-- CreateIndex
CREATE INDEX "ValuationAI_propertyId_idx" ON "ValuationAI"("propertyId");

-- CreateIndex
CREATE INDEX "ValuationAI_valuedAt_idx" ON "ValuationAI"("valuedAt");

-- CreateIndex
CREATE INDEX "ValuationAI_confidenceScore_idx" ON "ValuationAI"("confidenceScore");

-- CreateIndex
CREATE INDEX "YieldModel_propertyProspectId_idx" ON "YieldModel"("propertyProspectId");

-- CreateIndex
CREATE INDEX "YieldModel_propertyId_idx" ON "YieldModel"("propertyId");

-- CreateIndex
CREATE INDEX "YieldModel_capRate_idx" ON "YieldModel"("capRate");

-- CreateIndex
CREATE INDEX "YieldModel_calculatedAt_idx" ON "YieldModel"("calculatedAt");

-- CreateIndex
CREATE INDEX "OpportunityScore_propertyProspectId_idx" ON "OpportunityScore"("propertyProspectId");

-- CreateIndex
CREATE INDEX "OpportunityScore_overallScore_idx" ON "OpportunityScore"("overallScore");

-- CreateIndex
CREATE INDEX "OpportunityScore_opportunityType_idx" ON "OpportunityScore"("opportunityType");

-- CreateIndex
CREATE INDEX "OpportunityScore_scoredAt_idx" ON "OpportunityScore"("scoredAt");

-- CreateIndex
CREATE INDEX "AcquisitionCampaign_orgId_idx" ON "AcquisitionCampaign"("orgId");

-- CreateIndex
CREATE INDEX "AcquisitionCampaign_type_idx" ON "AcquisitionCampaign"("type");

-- CreateIndex
CREATE INDEX "AcquisitionCampaign_status_idx" ON "AcquisitionCampaign"("status");

-- CreateIndex
CREATE INDEX "AcquisitionCampaign_startDate_idx" ON "AcquisitionCampaign"("startDate");

-- CreateIndex
CREATE INDEX "AcquisitionCampaign_aiOptimized_idx" ON "AcquisitionCampaign"("aiOptimized");

-- CreateIndex
CREATE INDEX "AdAccount_orgId_idx" ON "AdAccount"("orgId");

-- CreateIndex
CREATE INDEX "AdAccount_platform_idx" ON "AdAccount"("platform");

-- CreateIndex
CREATE INDEX "AdAccount_isActive_idx" ON "AdAccount"("isActive");

-- CreateIndex
CREATE INDEX "AdRoutingRule_orgId_idx" ON "AdRoutingRule"("orgId");

-- CreateIndex
CREATE INDEX "AdRoutingRule_priority_idx" ON "AdRoutingRule"("priority");

-- CreateIndex
CREATE INDEX "AdRoutingRule_isActive_idx" ON "AdRoutingRule"("isActive");

-- CreateIndex
CREATE INDEX "ConversionEvent_orgId_idx" ON "ConversionEvent"("orgId");

-- CreateIndex
CREATE INDEX "ConversionEvent_eventType_idx" ON "ConversionEvent"("eventType");

-- CreateIndex
CREATE INDEX "ConversionEvent_propertyProspectId_idx" ON "ConversionEvent"("propertyProspectId");

-- CreateIndex
CREATE INDEX "ConversionEvent_campaignId_idx" ON "ConversionEvent"("campaignId");

-- CreateIndex
CREATE INDEX "ConversionEvent_occurredAt_idx" ON "ConversionEvent"("occurredAt");

-- CreateIndex
CREATE INDEX "AttributionData_orgId_idx" ON "AttributionData"("orgId");

-- CreateIndex
CREATE INDEX "AttributionData_conversionEventId_idx" ON "AttributionData"("conversionEventId");

-- CreateIndex
CREATE INDEX "AttributionData_touchpointType_idx" ON "AttributionData"("touchpointType");

-- CreateIndex
CREATE INDEX "AttributionData_journeyId_idx" ON "AttributionData"("journeyId");

-- CreateIndex
CREATE INDEX "FraudDetectionRule_orgId_idx" ON "FraudDetectionRule"("orgId");

-- CreateIndex
CREATE INDEX "FraudDetectionRule_ruleType_idx" ON "FraudDetectionRule"("ruleType");

-- CreateIndex
CREATE INDEX "FraudDetectionRule_severity_idx" ON "FraudDetectionRule"("severity");

-- CreateIndex
CREATE INDEX "FraudDetectionRule_isActive_idx" ON "FraudDetectionRule"("isActive");

-- CreateIndex
CREATE INDEX "PortfolioIntelligence_orgId_idx" ON "PortfolioIntelligence"("orgId");

-- CreateIndex
CREATE INDEX "PortfolioIntelligence_calculatedAt_idx" ON "PortfolioIntelligence"("calculatedAt");

-- CreateIndex
CREATE INDEX "AnalyticsDashboard_orgId_idx" ON "AnalyticsDashboard"("orgId");

-- CreateIndex
CREATE INDEX "AnalyticsDashboard_dashboardType_idx" ON "AnalyticsDashboard"("dashboardType");

-- CreateIndex
CREATE INDEX "AnalyticsDashboard_isPublic_idx" ON "AnalyticsDashboard"("isPublic");

-- CreateIndex
CREATE INDEX "PredictionOutcome_country_code_idx" ON "PredictionOutcome"("country_code");

-- CreateIndex
CREATE INDEX "PredictionOutcome_propertyId_idx" ON "PredictionOutcome"("propertyId");

-- CreateIndex
CREATE INDEX "PredictionOutcome_predictionType_idx" ON "PredictionOutcome"("predictionType");

-- CreateIndex
CREATE INDEX "PredictionOutcome_status_idx" ON "PredictionOutcome"("status");

-- CreateIndex
CREATE INDEX "PredictionOutcome_modelVersion_idx" ON "PredictionOutcome"("modelVersion");

-- CreateIndex
CREATE INDEX "PredictionOutcome_createdAt_idx" ON "PredictionOutcome"("createdAt");

-- CreateIndex
CREATE INDEX "AgentTask_agentType_idx" ON "AgentTask"("agentType");

-- CreateIndex
CREATE INDEX "AgentTask_taskStatus_idx" ON "AgentTask"("taskStatus");

-- CreateIndex
CREATE INDEX "AgentTask_propertyId_idx" ON "AgentTask"("propertyId");

-- CreateIndex
CREATE INDEX "AgentTask_dueDate_idx" ON "AgentTask"("dueDate");

-- CreateIndex
CREATE INDEX "AgentTask_country_code_idx" ON "AgentTask"("country_code");

-- CreateIndex
CREATE INDEX "AgentTask_correlationId_idx" ON "AgentTask"("correlationId");

-- CreateIndex
CREATE INDEX "SEOOpportunityScore_countryIsoCode_citySlug_idx" ON "SEOOpportunityScore"("countryIsoCode", "citySlug");

-- CreateIndex
CREATE INDEX "SEOOpportunityScore_finalScore_idx" ON "SEOOpportunityScore"("finalScore");

-- CreateIndex
CREATE INDEX "SEOOpportunityScore_shouldCreate_idx" ON "SEOOpportunityScore"("shouldCreate");

-- CreateIndex
CREATE INDEX "SEOOpportunityScore_priority_idx" ON "SEOOpportunityScore"("priority");

-- CreateIndex
CREATE INDEX "SEOOpportunityScore_intent_idx" ON "SEOOpportunityScore"("intent");

-- CreateIndex
CREATE INDEX "SEOPageEntity_countryIsoCode_citySlug_idx" ON "SEOPageEntity"("countryIsoCode", "citySlug");

-- CreateIndex
CREATE INDEX "SEOPageEntity_slug_idx" ON "SEOPageEntity"("slug");

-- CreateIndex
CREATE INDEX "SEOPageEntity_status_idx" ON "SEOPageEntity"("status");

-- CreateIndex
CREATE INDEX "SEOPageEntity_priority_idx" ON "SEOPageEntity"("priority");

-- CreateIndex
CREATE INDEX "SEOPageEntity_intent_idx" ON "SEOPageEntity"("intent");

-- CreateIndex
CREATE UNIQUE INDEX "SEOPageEntity_slug_key" ON "SEOPageEntity"("slug");

-- CreateIndex
CREATE INDEX "SEOKnowledgeGraph_entityType_entityId_idx" ON "SEOKnowledgeGraph"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "SEOKnowledgeGraph_relationshipType_idx" ON "SEOKnowledgeGraph"("relationshipType");

-- CreateIndex
CREATE INDEX "SEOKnowledgeGraph_relationshipWeight_idx" ON "SEOKnowledgeGraph"("relationshipWeight");

-- CreateIndex
CREATE UNIQUE INDEX "EventIdempotency_idempotencyKey_key" ON "EventIdempotency"("idempotencyKey");

-- CreateIndex
CREATE INDEX "EventIdempotency_idempotencyKey_idx" ON "EventIdempotency"("idempotencyKey");

-- CreateIndex
CREATE INDEX "EventIdempotency_eventType_idx" ON "EventIdempotency"("eventType");

-- CreateIndex
CREATE INDEX "EventIdempotency_aggregateId_idx" ON "EventIdempotency"("aggregateId");

-- CreateIndex
CREATE INDEX "EventIdempotency_processedAt_idx" ON "EventIdempotency"("processedAt");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyIntelligenceProfile_propertyId_key" ON "PropertyIntelligenceProfile"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyIntelligenceProfile_countryIsoCode_citySlug_idx" ON "PropertyIntelligenceProfile"("countryIsoCode", "citySlug");

-- CreateIndex
CREATE INDEX "PropertyIntelligenceProfile_investmentScore_idx" ON "PropertyIntelligenceProfile"("investmentScore");

-- CreateIndex
CREATE INDEX "PropertyIntelligenceProfile_currentValue_idx" ON "PropertyIntelligenceProfile"("currentValue");

-- CreateIndex
CREATE INDEX "PropertyIntelligenceProfile_analysisStatus_idx" ON "PropertyIntelligenceProfile"("analysisStatus");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyCurrentScore_propertyId_key" ON "PropertyCurrentScore"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyCurrentScore_propertyId_idx" ON "PropertyCurrentScore"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyCurrentScore_overallScore_idx" ON "PropertyCurrentScore"("overallScore");

-- CreateIndex
CREATE INDEX "PropertyCurrentScore_investmentScore_idx" ON "PropertyCurrentScore"("investmentScore");

-- CreateIndex
CREATE INDEX "PropertyScoreHistory_propertyId_calculatedAt_idx" ON "PropertyScoreHistory"("propertyId", "calculatedAt");

-- CreateIndex
CREATE INDEX "PropertyScoreHistory_calculatedAt_idx" ON "PropertyScoreHistory"("calculatedAt");

-- CreateIndex
CREATE INDEX "PropertyScoreHistory_overallScore_idx" ON "PropertyScoreHistory"("overallScore");

-- CreateIndex
CREATE UNIQUE INDEX "PropertyDigitalTwin_propertyId_key" ON "PropertyDigitalTwin"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyDigitalTwin_propertyId_idx" ON "PropertyDigitalTwin"("propertyId");

-- CreateIndex
CREATE INDEX "PropertyDigitalTwin_modelVersion_idx" ON "PropertyDigitalTwin"("modelVersion");

-- CreateIndex
CREATE UNIQUE INDEX "AIPriceOptimization_listingId_key" ON "AIPriceOptimization"("listingId");

-- CreateIndex
CREATE INDEX "AIPriceOptimization_propertyId_idx" ON "AIPriceOptimization"("propertyId");

-- CreateIndex
CREATE INDEX "Agency_countryCode_idx" ON "Agency"("countryCode");

-- CreateIndex
CREATE INDEX "Agency_language_idx" ON "Agency"("language");

-- CreateIndex
CREATE INDEX "AiServiceTask_listingId_idx" ON "AiServiceTask"("listingId");

-- CreateIndex
CREATE INDEX "AiVideoGeneration_listingId_idx" ON "AiVideoGeneration"("listingId");

-- CreateIndex
CREATE INDEX "Commission_countryCode_idx" ON "Commission"("countryCode");

-- CreateIndex
CREATE INDEX "Contract_countryCode_idx" ON "Contract"("countryCode");

-- CreateIndex
CREATE INDEX "Contract_language_idx" ON "Contract"("language");

-- CreateIndex
CREATE INDEX "Lead_countryCode_idx" ON "Lead"("countryCode");

-- CreateIndex
CREATE INDEX "Lead_language_idx" ON "Lead"("language");

-- CreateIndex
CREATE INDEX "MarketingCampaign_countryCode_idx" ON "MarketingCampaign"("countryCode");

-- CreateIndex
CREATE INDEX "MarketingCampaign_language_idx" ON "MarketingCampaign"("language");

-- CreateIndex
CREATE INDEX "Project_countryCode_idx" ON "Project"("countryCode");

-- CreateIndex
CREATE INDEX "Project_language_idx" ON "Project"("language");

-- CreateIndex
CREATE INDEX "SolicitorManagement_status_idx" ON "SolicitorManagement"("status");

-- CreateIndex
CREATE INDEX "SolicitorManagement_countryCode_idx" ON "SolicitorManagement"("countryCode");

-- CreateIndex
CREATE INDEX "SolicitorManagement_referredByAgencyId_idx" ON "SolicitorManagement"("referredByAgencyId");

-- CreateIndex
CREATE INDEX "Task_countryCode_idx" ON "Task"("countryCode");

-- CreateIndex
CREATE INDEX "Task_language_idx" ON "Task"("language");

-- CreateIndex
CREATE INDEX "VendorProfile_countryCode_idx" ON "VendorProfile"("countryCode");

-- CreateIndex
CREATE INDEX "VendorProfile_language_idx" ON "VendorProfile"("language");

-- RenameForeignKey
ALTER TABLE "Property" RENAME CONSTRAINT "Property_countryIsoCode_fkey" TO "Property_countryConfig_fkey";

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_countryOSConfig_fkey" FOREIGN KEY ("countryIsoCode") REFERENCES "CountryConfig"("code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Listing" ADD CONSTRAINT "Listing_regionalPricingId_fkey" FOREIGN KEY ("regionalPricingId") REFERENCES "RegionalPricing"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Booking" ADD CONSTRAINT "Booking_regionalPricingId_fkey" FOREIGN KEY ("regionalPricingId") REFERENCES "RegionalPricing"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "Contact"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_leadId_fkey" FOREIGN KEY ("leadId") REFERENCES "Lead"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_dealId_fkey" FOREIGN KEY ("dealId") REFERENCES "Deal"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommissionAdvance" ADD CONSTRAINT "CommissionAdvance_commissionId_fkey" FOREIGN KEY ("commissionId") REFERENCES "Commission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_analyticsMetricId_fkey" FOREIGN KEY ("analyticsMetricId") REFERENCES "AnalyticsMetric"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommissionPolicy" ADD CONSTRAINT "CommissionPolicy_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SettlementPolicy" ADD CONSTRAINT "SettlementPolicy_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingPolicy" ADD CONSTRAINT "PricingPolicy_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AiServiceTask" ADD CONSTRAINT "AiServiceTask_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AiVideoGeneration" ADD CONSTRAINT "AiVideoGeneration_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AiVideoGeneration" ADD CONSTRAINT "AiVideoGeneration_listingId_fkey" FOREIGN KEY ("listingId") REFERENCES "Listing"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnalyticsMetric" ADD CONSTRAINT "AnalyticsMetric_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KPIConfig" ADD CONSTRAINT "KPIConfig_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentApproval" ADD CONSTRAINT "DocumentApproval_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DocumentVersion" ADD CONSTRAINT "DocumentVersion_documentId_fkey" FOREIGN KEY ("documentId") REFERENCES "Document"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationRule" ADD CONSTRAINT "NotificationRule_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NotificationTemplate" ADD CONSTRAINT "NotificationTemplate_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserNotificationPreferences" ADD CONSTRAINT "UserNotificationPreferences_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Team" ADD CONSTRAINT "Team_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRole" ADD CONSTRAINT "UserRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRole" ADD CONSTRAINT "UserRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRole" ADD CONSTRAINT "UserRole_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Device" ADD CONSTRAINT "Device_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "IdentityEvent" ADD CONSTRAINT "IdentityEvent_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SSOConfig" ADD CONSTRAINT "SSOConfig_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KumbaraContribution" ADD CONSTRAINT "KumbaraContribution_depositId_fkey" FOREIGN KEY ("depositId") REFERENCES "KumbaraDeposit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KumbaraRule" ADD CONSTRAINT "KumbaraRule_depositId_fkey" FOREIGN KEY ("depositId") REFERENCES "KumbaraDeposit"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrustScoreEvent" ADD CONSTRAINT "TrustScoreEvent_scoreId_fkey" FOREIGN KEY ("scoreId") REFERENCES "UniversalTrustScore"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrustScoreVersion" ADD CONSTRAINT "TrustScoreVersion_scoreId_fkey" FOREIGN KEY ("scoreId") REFERENCES "UniversalTrustScore"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EquityAccumulation" ADD CONSTRAINT "EquityAccumulation_intentId_fkey" FOREIGN KEY ("intentId") REFERENCES "PurchaseIntent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OwnershipConversion" ADD CONSTRAINT "OwnershipConversion_intentId_fkey" FOREIGN KEY ("intentId") REFERENCES "PurchaseIntent"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OwnerProfile" ADD CONSTRAINT "OwnerProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommunicationUnsubscribe" ADD CONSTRAINT "CommunicationUnsubscribe_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PortfolioBatch" ADD CONSTRAINT "PortfolioBatch_corporateAccountId_fkey" FOREIGN KEY ("corporateAccountId") REFERENCES "CorporateAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BulkInvitation" ADD CONSTRAINT "BulkInvitation_corporateAccountId_fkey" FOREIGN KEY ("corporateAccountId") REFERENCES "CorporateAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CorporateProperty" ADD CONSTRAINT "CorporateProperty_corporateAccountId_fkey" FOREIGN KEY ("corporateAccountId") REFERENCES "CorporateAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CorporateProperty" ADD CONSTRAINT "CorporateProperty_portfolioBatchId_fkey" FOREIGN KEY ("portfolioBatchId") REFERENCES "PortfolioBatch"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AIPitchDeck" ADD CONSTRAINT "AIPitchDeck_corporateAccountId_fkey" FOREIGN KEY ("corporateAccountId") REFERENCES "CorporateAccount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "REOProperty" ADD CONSTRAINT "REOProperty_portfolioId_fkey" FOREIGN KEY ("portfolioId") REFERENCES "InstitutionalPortfolio"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PortfolioHolding" ADD CONSTRAINT "PortfolioHolding_portfolioId_fkey" FOREIGN KEY ("portfolioId") REFERENCES "InstitutionalPortfolio"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES "Supplier"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BundleItem" ADD CONSTRAINT "BundleItem_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "ProductBundle"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BundleItem" ADD CONSTRAINT "BundleItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommerceCommission" ADD CONSTRAINT "CommerceCommission_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "CommerceAgent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommerceCommission" ADD CONSTRAINT "CommerceCommission_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "CommerceOrder"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommerceOrder" ADD CONSTRAINT "CommerceOrder_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "CommerceAgent"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommerceOrder" ADD CONSTRAINT "CommerceOrder_bundleId_fkey" FOREIGN KEY ("bundleId") REFERENCES "ProductBundle"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommerceOrderItem" ADD CONSTRAINT "CommerceOrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "CommerceOrder"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommerceOrderItem" ADD CONSTRAINT "CommerceOrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RevenueShare" ADD CONSTRAINT "RevenueShare_commissionId_fkey" FOREIGN KEY ("commissionId") REFERENCES "CommerceCommission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PredictionOutcome" ADD CONSTRAINT "PredictionOutcome_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AgentTask" ADD CONSTRAINT "AgentTask_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AgentTask" ADD CONSTRAINT "AgentTask_parentTaskId_fkey" FOREIGN KEY ("parentTaskId") REFERENCES "AgentTask"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SEOPageEntity" ADD CONSTRAINT "SEOPageEntity_seoOpportunityScoreId_fkey" FOREIGN KEY ("seoOpportunityScoreId") REFERENCES "SEOOpportunityScore"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyIntelligenceProfile" ADD CONSTRAINT "PropertyIntelligenceProfile_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyCurrentScore" ADD CONSTRAINT "PropertyCurrentScore_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyScoreHistory" ADD CONSTRAINT "PropertyScoreHistory_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyDigitalTwin" ADD CONSTRAINT "PropertyDigitalTwin_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;
