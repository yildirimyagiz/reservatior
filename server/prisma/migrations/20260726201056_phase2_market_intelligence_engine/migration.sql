-- CreateTable
CREATE TABLE "MarketIntelligenceProfile" (
    "id" TEXT NOT NULL,
    "countryIsoCode" TEXT NOT NULL,
    "citySlug" TEXT NOT NULL,
    "districtSlug" TEXT,
    "neighborhoodSlug" TEXT,
    "averagePricePerSqm" DECIMAL(15,2),
    "medianPrice" DECIMAL(15,2),
    "supplyScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "demandScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "transactionVelocity" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "liquidityScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "averageRentalYield" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "occupancyRate" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "foreignBuyerRatio" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "internationalDemandScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "priceGrowth1Y" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "priceGrowth3Y" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "priceGrowth5Y" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "marketPhase" TEXT,
    "aiRecommendation" TEXT,
    "confidenceScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "intelligenceVersion" TEXT NOT NULL DEFAULT 'v1',
    "analysisStatus" TEXT NOT NULL DEFAULT 'PENDING',
    "lastAnalyzedAt" TIMESTAMP(3),
    "dataSources" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MarketIntelligenceProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MarketTrend" (
    "id" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "metric" TEXT NOT NULL,
    "previousValue" DOUBLE PRECISION NOT NULL,
    "currentValue" DOUBLE PRECISION NOT NULL,
    "changePercentage" DOUBLE PRECISION NOT NULL,
    "trendDirection" TEXT NOT NULL,
    "confidence" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "aiInsight" TEXT,
    "detectedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MarketTrend_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MarketOpportunityScore" (
    "id" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "growthScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "rentalScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "demandScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "liquidityScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "riskScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "overallScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "recommendation" TEXT,
    "confidence" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "modelVersion" TEXT NOT NULL DEFAULT 'v1.0',
    "calculatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MarketOpportunityScore_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MarketDigitalTwin" (
    "id" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "currentState" JSONB NOT NULL,
    "scenarios" JSONB NOT NULL,
    "predictions" JSONB NOT NULL,
    "assumptions" JSONB NOT NULL,
    "modelVersion" TEXT NOT NULL DEFAULT 'v1.0',
    "confidenceScore" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "priceForecast1Y" DECIMAL(15,2),
    "priceForecast3Y" DECIMAL(15,2),
    "priceForecast5Y" DECIMAL(15,2),
    "demandForecast1Y" DOUBLE PRECISION,
    "demandForecast3Y" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastSimulatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "MarketDigitalTwin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "MarketIntelligenceProfile_countryIsoCode_citySlug_idx" ON "MarketIntelligenceProfile"("countryIsoCode", "citySlug");

-- CreateIndex
CREATE INDEX "MarketIntelligenceProfile_demandScore_idx" ON "MarketIntelligenceProfile"("demandScore");

-- CreateIndex
CREATE INDEX "MarketIntelligenceProfile_priceGrowth1Y_idx" ON "MarketIntelligenceProfile"("priceGrowth1Y");

-- CreateIndex
CREATE INDEX "MarketIntelligenceProfile_analysisStatus_idx" ON "MarketIntelligenceProfile"("analysisStatus");

-- CreateIndex
CREATE UNIQUE INDEX "MarketIntelligenceProfile_countryIsoCode_citySlug_districtS_key" ON "MarketIntelligenceProfile"("countryIsoCode", "citySlug", "districtSlug", "neighborhoodSlug");

-- CreateIndex
CREATE INDEX "MarketTrend_locationId_idx" ON "MarketTrend"("locationId");

-- CreateIndex
CREATE INDEX "MarketTrend_metric_idx" ON "MarketTrend"("metric");

-- CreateIndex
CREATE INDEX "MarketTrend_detectedAt_idx" ON "MarketTrend"("detectedAt");

-- CreateIndex
CREATE INDEX "MarketOpportunityScore_overallScore_idx" ON "MarketOpportunityScore"("overallScore");

-- CreateIndex
CREATE INDEX "MarketOpportunityScore_growthScore_idx" ON "MarketOpportunityScore"("growthScore");

-- CreateIndex
CREATE INDEX "MarketOpportunityScore_calculatedAt_idx" ON "MarketOpportunityScore"("calculatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "MarketOpportunityScore_locationId_key" ON "MarketOpportunityScore"("locationId");

-- CreateIndex
CREATE UNIQUE INDEX "MarketDigitalTwin_locationId_key" ON "MarketDigitalTwin"("locationId");

-- CreateIndex
CREATE INDEX "MarketDigitalTwin_locationId_idx" ON "MarketDigitalTwin"("locationId");

-- CreateIndex
CREATE INDEX "MarketDigitalTwin_modelVersion_idx" ON "MarketDigitalTwin"("modelVersion");
