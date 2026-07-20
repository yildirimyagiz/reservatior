/*
  Warnings:

  - The `solicitorType` column on the `SolicitorManagement` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `SolicitorManagement` table would be dropped and recreated. This will lead to data loss if there is data in the column.
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


ALTER TYPE "SocialPlatform" ADD VALUE 'TIKTOK';
ALTER TYPE "SocialPlatform" ADD VALUE 'YOUTUBE';

-- DropForeignKey
ALTER TABLE "AiVideoGeneration" DROP CONSTRAINT "AiVideoGeneration_propertyId_fkey";

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
ALTER TABLE "Booking" ADD COLUMN     "regionalPricingId" TEXT;

-- AlterTable
ALTER TABLE "Listing" ADD COLUMN     "regionalPricingId" TEXT;

-- AlterTable
ALTER TABLE "Notification" ADD COLUMN     "contactId" TEXT,
ADD COLUMN     "dealId" TEXT,
ADD COLUMN     "leadId" TEXT;

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
CREATE INDEX "AiServiceTask_listingId_idx" ON "AiServiceTask"("listingId");

-- CreateIndex
CREATE INDEX "AiVideoGeneration_listingId_idx" ON "AiVideoGeneration"("listingId");

-- CreateIndex
CREATE INDEX "SolicitorManagement_status_idx" ON "SolicitorManagement"("status");

-- CreateIndex
CREATE INDEX "SolicitorManagement_countryCode_idx" ON "SolicitorManagement"("countryCode");

-- CreateIndex
CREATE INDEX "SolicitorManagement_referredByAgencyId_idx" ON "SolicitorManagement"("referredByAgencyId");

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
