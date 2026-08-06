-- CreateTable
CREATE TABLE "compliance_rules" (
    "id" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "region" TEXT,
    "category" TEXT NOT NULL,
    "ruleKey" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "severity" TEXT NOT NULL DEFAULT 'INFO',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "effectiveFrom" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "effectiveTo" TIMESTAMP(3),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "compliance_rules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "compliance_rule_checks" (
    "id" TEXT NOT NULL,
    "ruleId" TEXT NOT NULL,
    "entityType" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "passed" BOOLEAN NOT NULL,
    "severity" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "recommendation" TEXT,
    "metadata" JSONB,
    "checkedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "compliance_rule_checks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "compliance_rules_ruleKey_key" ON "compliance_rules"("ruleKey");

-- CreateIndex
CREATE INDEX "compliance_rules_country_idx" ON "compliance_rules"("country");

-- CreateIndex
CREATE INDEX "compliance_rules_category_idx" ON "compliance_rules"("category");

-- CreateIndex
CREATE INDEX "compliance_rules_isActive_idx" ON "compliance_rules"("isActive");

-- CreateIndex
CREATE INDEX "compliance_rules_effectiveFrom_idx" ON "compliance_rules"("effectiveFrom");

-- CreateIndex
CREATE INDEX "compliance_rules_effectiveTo_idx" ON "compliance_rules"("effectiveTo");

-- CreateIndex
CREATE INDEX "compliance_rule_checks_entityType_entityId_idx" ON "compliance_rule_checks"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "compliance_rule_checks_ruleId_idx" ON "compliance_rule_checks"("ruleId");

-- CreateIndex
CREATE INDEX "compliance_rule_checks_passed_idx" ON "compliance_rule_checks"("passed");

-- CreateIndex
CREATE INDEX "compliance_rule_checks_severity_idx" ON "compliance_rule_checks"("severity");

-- CreateIndex
CREATE INDEX "compliance_rule_checks_checkedAt_idx" ON "compliance_rule_checks"("checkedAt");
