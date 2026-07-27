#!/bin/bash

# Schema Sync Script - Apply AI Expansion to All Country Schemas
# This script copies AI expansion changes from schema.prisma to all country schemas

PRISMA_DIR="/Users/os2026/Downloads/Reservatior/server/prisma"
MASTER_SCHEMA="$PRISMA_DIR/schema.prisma"

# AI Expansion additions
AI_FIELDS_ADDITION="
  // AI Enhanced Fields - Phase 1 Expansion
  // Opportunity Engine Results
  aiOpportunityScore       Float?
  aiOpportunityTier        OpportunityTier?
  aiAcquisitionUrgency    AcquisitionUrgency?
  aiScoreBreakdown        Json?                           // { yieldScore, priceGapScore, demandScore, vacancyScore, riskScore, liquidityScore }

  // Strategic Brain Results
  aiRecommendedStrategy    String?
  aiWhyScore              String?                         @db.Text
  aiRegionalStrengths     String[]
  aiTargetSegments        String[]
  aiRiskFactors           String[]
  aiTimingRecommendations String?
  aiStrategicConfidence   Float?

  // Simulation Agent Results
  aiSimulationScenarios   Json?                           // { scenarioName, scenarioType, estimatedTimeframe, estimatedRevenue, estimatedCost, netProfit, profitMargin, confidence, riskFactors, requirements }
  aiRecommendedScenario   String?
  aiSimulationConfidence  Float?

  // Ranking Engine Results
  aiOverallRankingScore   Float?
  aiRank                  Int?
  aiComponentScores       Json?                           // { opportunityScore, strategicScore, simulationScore, marketScore, userPreferenceScore }
  aiKeyFactors            String[]
  aiRecommendedAction     String?
  aiRankingConfidence     Float?

  // AI Metadata
  aiLastAnalyzedAt        DateTime?
  aiModelVersion          String?
  aiProviderUsed          String?
  aiAnalysisFlags         String[]"

AI_RELATIONS_ADDITION="
  predictionOutcomes      PredictionOutcome[]
  agentTasks               AgentTask[]"

AI_MODELS_ADDITION="
// ─── SCHEMA EXPANSION PHASE 1: AI INTEGRATION ───

// Learning Loop Model - Prediction vs Actual Comparison
model PredictionOutcome {
  id                  String   @id @default(cuid())
  country_code        String
  propertyId          String?
  predictionType      PredictionType
  predictedValue      Float
  predictedUnit       String
  modelVersion        String
  modelType           String
  confidenceScore     Float
  propertyContext     Json?
  marketContext       Json?
  status              PredictionStatus @default(PENDING)
  actualValue         Float?
  actualUnit          String?
  actualAt            DateTime?
  errorDelta          Float?
  accuracyPercentage  Float?
  strategyMatch       Boolean?
  verifiedAt          DateTime?
  verifiedBy          String?
  createdAt           DateTime @default(now())
  updatedAt           DateTime @updatedAt

  property            Property? @relation(fields: [propertyId], references: [id])

  @@index([country_code])
  @@index([propertyId])
  @@index([predictionType])
  @@index([status])
  @@index([modelVersion])
  @@index([createdAt])
}

// Agent Task Tracking Model
model AgentTask {
  id              String       @id @default(cuid())
  agentType       AgentType
  propertyId      String?
  taskType        AgentTaskType
  taskStatus      AgentTaskStatus
  priority        TaskPriority
  assignedTo      String?
  createdAt       DateTime     @default(now())
  scheduledAt     DateTime?
  startedAt       DateTime?
  completedAt     DateTime?
  dueDate         DateTime?
  estimatedHours   Float?
  actualHours     Float?
  taskData        Json?
  resultData      Json?
  errorMessage    String?
  retryCount      Int          @default(0)
  maxRetries      Int          @default(3)
  parentTaskId    String?
  correlationId   String?
  country_code    String?

  property        Property?    @relation(fields: [propertyId], references: [id])
  subTasks        AgentTask[]  @relation(\"SubTasks\")
  parentTask      AgentTask?   @relation(\"SubTasks\", fields: [parentTaskId], references: [id])

  @@index([agentType])
  @@index([taskStatus])
  @@index([propertyId])
  @@index([dueDate])
  @@index([country_code])
  @@index([correlationId])
}

// Enums for Prediction Outcome
enum PredictionType {
  OPPORTUNITY_SCORE
  VALUATION
  RENTAL_YIELD
  TIME_TO_RENT
  SALE_PRICE
  APPRECIATION_RATE
  LIQUIDITY_SCORE
  RISK_SCORE
  MARKET_TREND
  PRICE_PREDICTION
}

enum PredictionStatus {
  PENDING
  VERIFIED
  FAILED
  EXPIRED
  CANCELLED
}

// Enums for Agent Task
enum AgentTaskType {
  VALUATION
  OPPORTUNITY_ANALYSIS
  STRATEGIC_REVIEW
  SIMULATION
  RANKING
  MARKET_RESEARCH
  OWNER_IDENTIFICATION
  CONSENT_ACQUISITION
  DOCUMENT_VERIFICATION
  LISTING_PREPARATION
  MARKETING_SETUP
  BUYER_MATCHING
  NEGOTIATION_SUPPORT
  CLOSING_COORDINATION
  POST_ACQUISITION_ANALYSIS
  KNOWLEDGE_GRAPH_UPDATE
  VECTOR_INDEX_UPDATE
  OUTCOME_TRACKING
  MODEL_RETRAINING
  COUNTRY_CONTEXT_UPDATE
}

enum AgentTaskStatus {
  PENDING
  SCHEDULED
  IN_PROGRESS
  COMPLETED
  FAILED
  CANCELLED
  BLOCKED
  RETRYING
}"

echo "Starting AI expansion sync to all country schemas..."

# List of country schemas (excluding master schema)
COUNTRY_SCHEMAS=(
  "schema_ar.prisma"
  "schema_ae.prisma"
  "schema_au.prisma"
  "schema_br.prisma"
  "schema_ca.prisma"
  "schema_cn.prisma"
  "schema_de.prisma"
  "schema_es.prisma"
  "schema_fr.prisma"
  "schema_in.prisma"
  "schema_it.prisma"
  "schema_jp.prisma"
  "schema_kr.prisma"
  "schema_mx.prisma"
  "schema_my.prisma"
  "schema_nz.prisma"
  "schema_nl.prisma"
  "schema_sa.prisma"
  "schema_sg.prisma"
  "schema_th.prisma"
  "schema_tr.prisma"
  "schema_uk.prisma"
  "schema_usa.prisma"
)

for schema in "${COUNTRY_SCHEMAS[@]}"; do
  schema_path="$PRISMA_DIR/$schema"
  
  echo "Processing $schema..."
  
  # Check if schema already has AI expansion
  if grep -q "SCHEMA EXPANSION PHASE 1: AI INTEGRATION" "$schema_path"; then
    echo "  ✓ $schema already has AI expansion - skipping"
    continue
  fi
  
  # Add AI fields to Property model (after aiROIHint)
  sed -i '' '/aiROIHint.*@db\.Text/a\
\
  // AI Enhanced Fields - Phase 1 Expansion\
  // Opportunity Engine Results\
  aiOpportunityScore       Float?\
  aiOpportunityTier        OpportunityTier?\
  aiAcquisitionUrgency    AcquisitionUrgency?\
  aiScoreBreakdown        Json?                           // { yieldScore, priceGapScore, demandScore, vacancyScore, riskScore, liquidityScore }\
\
  // Strategic Brain Results\
  aiRecommendedStrategy    String?\
  aiWhyScore              String?                         @db.Text\
  aiRegionalStrengths     String[]\
  aiTargetSegments        String[]\
  aiRiskFactors           String[]\
  aiTimingRecommendations String?\
  aiStrategicConfidence   Float?\
\
  // Simulation Agent Results\
  aiSimulationScenarios   Json?                           // { scenarioName, scenarioType, estimatedTimeframe, estimatedRevenue, estimatedCost, netProfit, profitMargin, confidence, riskFactors, requirements }\
  aiRecommendedScenario   String?\
  aiSimulationConfidence  Float?\
\
  // Ranking Engine Results\
  aiOverallRankingScore   Float?\
  aiRank                  Int?\
  aiComponentScores       Json?                           // { opportunityScore, strategicScore, simulationScore, marketScore, userPreferenceScore }\
  aiKeyFactors            String[]\
  aiRecommendedAction     String?\
  aiRankingConfidence     Float?\
\
  // AI Metadata\
  aiLastAnalyzedAt        DateTime?\
  aiModelVersion          String?\
  aiProviderUsed          String?\
  aiAnalysisFlags         String[]
' "$schema_path"
  
  # Add AI relations to Property model (after propertySecurityConfig)
  sed -i '' '/propertySecurityConfig?$/a\
  predictionOutcomes      PredictionOutcome[]\
  agentTasks               AgentTask[]
' "$schema_path"
  
  # Add AI models and enums at end of file
  echo "" >> "$schema_path"
  echo "// ─── SCHEMA EXPANSION PHASE 1: AI INTEGRATION ───" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// Learning Loop Model - Prediction vs Actual Comparison" >> "$schema_path"
  echo "model PredictionOutcome {" >> "$schema_path"
  echo "  id                  String   @id @default(cuid())" >> "$schema_path"
  echo "  country_code        String" >> "$schema_path"
  echo "  propertyId          String?" >> "$schema_path"
  echo "  predictionType      PredictionType" >> "$schema_path"
  echo "  predictedValue      Float" >> "$schema_path"
  echo "  predictedUnit       String" >> "$schema_path"
  echo "  modelVersion        String" >> "$schema_path"
  echo "  modelType           String" >> "$schema_path"
  echo "  confidenceScore     Float" >> "$schema_path"
  echo "  propertyContext     Json?" >> "$schema_path"
  echo "  marketContext       Json?" >> "$schema_path"
  echo "  status              PredictionStatus @default(PENDING)" >> "$schema_path"
  echo "  actualValue         Float?" >> "$schema_path"
  echo "  actualUnit          String?" >> "$schema_path"
  echo "  actualAt            DateTime?" >> "$schema_path"
  echo "  errorDelta          Float?" >> "$schema_path"
  echo "  accuracyPercentage  Float?" >> "$schema_path"
  echo "  strategyMatch       Boolean?" >> "$schema_path"
  echo "  verifiedAt          DateTime?" >> "$schema_path"
  echo "  verifiedBy          String?" >> "$schema_path"
  echo "  createdAt           DateTime @default(now())" >> "$schema_path"
  echo "  updatedAt           DateTime @updatedAt" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  property            Property? @relation(fields: [propertyId], references: [id])" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  @@index([country_code])" >> "$schema_path"
  echo "  @@index([propertyId])" >> "$schema_path"
  echo "  @@index([predictionType])" >> "$schema_path"
  echo "  @@index([status])" >> "$schema_path"
  echo "  @@index([modelVersion])" >> "$schema_path"
  echo "  @@index([createdAt])" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// Agent Task Tracking Model" >> "$schema_path"
  echo "model AgentTask {" >> "$schema_path"
  echo "  id              String       @id @default(cuid())" >> "$schema_path"
  echo "  agentType       AgentType" >> "$schema_path"
  echo "  propertyId      String?" >> "$schema_path"
  echo "  taskType        AgentTaskType" >> "$schema_path"
  echo "  taskStatus      AgentTaskStatus" >> "$schema_path"
  echo "  priority        TaskPriority" >> "$schema_path"
  echo "  assignedTo      String?" >> "$schema_path"
  echo "  createdAt       DateTime     @default(now())" >> "$schema_path"
  echo "  scheduledAt     DateTime?" >> "$schema_path"
  echo "  startedAt       DateTime?" >> "$schema_path"
  echo "  completedAt     DateTime?" >> "$schema_path"
  echo "  dueDate         DateTime?" >> "$schema_path"
  echo "  estimatedHours   Float?" >> "$schema_path"
  echo "  actualHours     Float?" >> "$schema_path"
  echo "  taskData        Json?" >> "$schema_path"
  echo "  resultData      Json?" >> "$schema_path"
  echo "  errorMessage    String?" >> "$schema_path"
  echo "  retryCount      Int          @default(0)" >> "$schema_path"
  echo "  maxRetries      Int          @default(3)" >> "$schema_path"
  echo "  parentTaskId    String?" >> "$schema_path"
  echo "  correlationId   String?" >> "$schema_path"
  echo "  country_code    String?" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  property        Property?    @relation(fields: [propertyId], references: [id])" >> "$schema_path"
  echo "  subTasks        AgentTask[]  @relation(\"SubTasks\")" >> "$schema_path"
  echo "  parentTask      AgentTask?   @relation(\"SubTasks\", fields: [parentTaskId], references: [id])" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  @@index([agentType])" >> "$schema_path"
  echo "  @@index([taskStatus])" >> "$schema_path"
  echo "  @@index([propertyId])" >> "$schema_path"
  echo "  @@index([dueDate])" >> "$schema_path"
  echo "  @@index([country_code])" >> "$schema_path"
  echo "  @@index([correlationId])" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// Enums for Prediction Outcome" >> "$schema_path"
  echo "enum PredictionType {" >> "$schema_path"
  echo "  OPPORTUNITY_SCORE" >> "$schema_path"
  echo "  VALUATION" >> "$schema_path"
  echo "  RENTAL_YIELD" >> "$schema_path"
  echo "  TIME_TO_RENT" >> "$schema_path"
  echo "  SALE_PRICE" >> "$schema_path"
  echo "  APPRECIATION_RATE" >> "$schema_path"
  echo "  LIQUIDITY_SCORE" >> "$schema_path"
  echo "  RISK_SCORE" >> "$schema_path"
  echo "  MARKET_TREND" >> "$schema_path"
  echo "  PRICE_PREDICTION" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "enum PredictionStatus {" >> "$schema_path"
  echo "  PENDING" >> "$schema_path"
  echo "  VERIFIED" >> "$schema_path"
  echo "  FAILED" >> "$schema_path"
  echo "  EXPIRED" >> "$schema_path"
  echo "  CANCELLED" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// Enums for Agent Task" >> "$schema_path"
  echo "enum AgentTaskType {" >> "$schema_path"
  echo "  VALUATION" >> "$schema_path"
  echo "  OPPORTUNITY_ANALYSIS" >> "$schema_path"
  echo "  STRATEGIC_REVIEW" >> "$schema_path"
  echo "  SIMULATION" >> "$schema_path"
  echo "  RANKING" >> "$schema_path"
  echo "  MARKET_RESEARCH" >> "$schema_path"
  echo "  OWNER_IDENTIFICATION" >> "$schema_path"
  echo "  CONSENT_ACQUISITION" >> "$schema_path"
  echo "  DOCUMENT_VERIFICATION" >> "$schema_path"
  echo "  LISTING_PREPARATION" >> "$schema_path"
  echo "  MARKETING_SETUP" >> "$schema_path"
  echo "  BUYER_MATCHING" >> "$schema_path"
  echo "  NEGOTIATION_SUPPORT" >> "$schema_path"
  echo "  CLOSING_COORDINATION" >> "$schema_path"
  echo "  POST_ACQUISITION_ANALYSIS" >> "$schema_path"
  echo "  KNOWLEDGE_GRAPH_UPDATE" >> "$schema_path"
  echo "  VECTOR_INDEX_UPDATE" >> "$schema_path"
  echo "  OUTCOME_TRACKING" >> "$schema_path"
  echo "  MODEL_RETRAINING" >> "$schema_path"
  echo "  COUNTRY_CONTEXT_UPDATE" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "enum AgentTaskStatus {" >> "$schema_path"
  echo "  PENDING" >> "$schema_path"
  echo "  SCHEDULED" >> "$schema_path"
  echo "  IN_PROGRESS" >> "$schema_path"
  echo "  COMPLETED" >> "$schema_path"
  echo "  FAILED" >> "$schema_path"
  echo "  CANCELLED" >> "$schema_path"
  echo "  BLOCKED" >> "$schema_path"
  echo "  RETRYING" >> "$schema_path"
  echo "}" >> "$schema_path"
  
  echo "  ✓ $schema updated successfully"
done

echo ""
echo "AI expansion sync completed!"
echo "Run 'bun prisma generate' to regenerate Prisma Client."
