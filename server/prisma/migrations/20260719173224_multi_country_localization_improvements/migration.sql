-- AlterTable
ALTER TABLE "Agency" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Booking" ADD COLUMN     "timezone" TEXT DEFAULT 'America/New_York';

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
ALTER TABLE "MarketingCampaign" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Organization" ADD COLUMN     "timezone" TEXT NOT NULL DEFAULT 'America/New_York';

-- AlterTable
ALTER TABLE "Project" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "Property" ADD COLUMN     "timezone" TEXT NOT NULL DEFAULT 'America/New_York';

-- AlterTable
ALTER TABLE "Task" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- AlterTable
ALTER TABLE "VendorProfile" ADD COLUMN     "countryCode" VARCHAR(2),
ADD COLUMN     "currency" TEXT DEFAULT 'USD',
ADD COLUMN     "language" TEXT DEFAULT 'en';

-- CreateIndex
CREATE INDEX "Agency_countryCode_idx" ON "Agency"("countryCode");

-- CreateIndex
CREATE INDEX "Agency_language_idx" ON "Agency"("language");

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
CREATE INDEX "Task_countryCode_idx" ON "Task"("countryCode");

-- CreateIndex
CREATE INDEX "Task_language_idx" ON "Task"("language");

-- CreateIndex
CREATE INDEX "VendorProfile_countryCode_idx" ON "VendorProfile"("countryCode");

-- CreateIndex
CREATE INDEX "VendorProfile_language_idx" ON "VendorProfile"("language");
