# Prisma Schema Analysis & Expansion Recommendations

## Current Schema Analysis

### Property Model - Comprehensive Coverage ✅

**Core Fields:**
- **Identity**: id, orgId, name, type, region
- **Location**: addressLine1, addressLine2, city, state, zip, country, countryIsoCode, lat, lng, neighborhoodId
- **Property Details**: bedrooms, bathrooms, areaSqm, yearBuilt, propertyCategory, listingType
- **AI Precomputed**: aiSummary, aiProsCons, aiNeighborhoodScore, aiROIHint
- **Financial**: listingPrice, originalPrice, priceHistory, hoaFee, propertyTaxRate, assessedValue, marketValue
- **Advanced Details**: schoolDistrict, floodZone, zoningCode, lotSizeAcres, constructionType, roofType, etc.
- **Features**: accessibilityFeatures, smartHomeFeatures, securityFeatures
- **Country Integration**: countryIsoCode, countryConfig, countryOSConfig

### Current Enums

**PropertyType (20 types):**
- Residential: DETACHED_HOUSE, SEMI_DETACHED_HOUSE, TERRACED_HOUSE, FLAT_MAISONETTE, BUNGALOW, COTTAGE, TOWNHOUSE, APARTMENT, STUDIO, PENTHOUSE, SINGLE_FAMILY, CONDO_APARTMENT, MULTI_FAMILY, COMPOUND, VILLA, ADU_GUEST_HOUSE, CABIN_TINY_HOUSE
- Commercial: OFFICE, RETAIL, COMMERCIAL_SPACE, COMMERCIAL

**ListingType (3 types):**
- SALE, RENT, BOOKING

**OpportunityTier (4 levels):**
- LOW_POTENTIAL, MONITOR, HIGH_POTENTIAL, PREMIUM

**AcquisitionUrgency (4 levels):**
- LOW, MEDIUM, HIGH, IMMEDIATE

**ListingLifecycleStatus (8 stages):**
- UNVERIFIED_PROSPECT, OWNER_IDENTIFIED, CONSENT_GRANTED, VALUATION_READY, INVITATION_SENT, PROPERTY_CLAIMED, ACTIVE_LISTING, CONVERTED

### PropertyProspect Model - AI Integration ✅

**Strategic Scoring:**
- acquisitionScore, valuationScore, ownerConfidence, marketOpportunityScore, overallPriority

**AI Integration:**
- aiAnalyzed, aiAnalysisDate, aiConfidenceScore, aiAnalysisMetadata

**Opportunity Classification:**
- opportunityTier, acquisitionUrgency

## Expansion Recommendations

### 1. Listing Type Expansion

**Current:** SALE, RENT, BOOKING
**Recommended Expansion:**

```prisma
enum ListingType {
  SALE
  RENT
  BOOKING
  LONG_TERM_RENT
  SHORT_TERM_RENT
  LEASE
  LEASEHOLD
  FREEHOLD
  AUCTION
  FORECLOSURE
  OFF_PLAN
  RESALE
  COMMERCIAL_LEASE
  GROUND_LEASE
  SHARED_OWNERSHIP
}
```

**Rationale:**
- **LONG_TERM_RENT/SHORT_TERM_RENT**: Rental duration distinction for different AI models
- **LEASE/LEASEHOLD/FREEHOLD**: Legal ownership structure (critical for UK, UAE markets)
- **AUCTION/FORECLOSURE**: Distressed property opportunities
- **OFF_PLAN**: Pre-construction opportunities (important for UAE, Turkey)
- **COMMERCIAL_LEASE**: Commercial property specific
- **SHARED_OWNERSHIP**: Fractional ownership models

### 2. Property Type Expansion

**Current:** 20 types
**Recommended Expansion:**

```prisma
enum PropertyType {
  // Residential (existing)
  DETACHED_HOUSE
  SEMI_DETACHED_HOUSE
  TERRACED_HOUSE
  FLAT_MAISONETTE
  BUNGALOW
  COTTAGE
  TOWNHOUSE
  APARTMENT
  STUDIO
  PENTHOUSE
  SINGLE_FAMILY
  CONDO_APARTMENT
  MULTI_FAMILY
  COMPOUND
  VILLA
  ADU_GUEST_HOUSE
  CABIN_TINY_HOUSE
  
  // Commercial (existing)
  OFFICE
  RETAIL
  COMMERCIAL_SPACE
  COMMERCIAL
  
  // New Commercial Types
  WAREHOUSE
  INDUSTRIAL
  HOTEL
  MOTEL
  RESORT
  RESTAURANT
  CAFE
  SHOPPING_CENTER
  MIXED_USE
  CO_WORKING_SPACE
  DATA_CENTER
  LOGISTICS_CENTER
  MANUFACTURING_FACILITY
  MEDICAL_FACILITY
  EDUCATIONAL_FACILITY
  GOVERNMENT_BUILDING
  
  // Land & Development
  LAND
  DEVELOPMENT_SITE
  AGRICULTURAL_LAND
  VACANT_LOT
  SUBDIVISION
  
  // Special Purpose
  SENIOR_LIVING
  STUDENT_HOUSING
  SELF_STORAGE
  PARKING_GARAGE
  MARINA
  GOLF_COURSE
  FARM
  RANCH
  VINEYARD
  HISTORIC_PROPERTY
  LUXURY_ESTATE
  ISLAND
}
```

**Rationale:**
- **Commercial diversity**: Different commercial property types require different AI models
- **Land & Development**: Important for acquisition opportunities
- **Special Purpose**: Niche markets with specific AI requirements
- **Country-specific**: Some types are more relevant in certain countries (e.g., VINEYARD in France, ISLAND in UAE)

### 3. Opportunity Tier Expansion

**Current:** 4 levels
**Recommended Expansion:**

```prisma
enum OpportunityTier {
  LOW_POTENTIAL
  MONITOR
  MODERATE_POTENTIAL
  HIGH_POTENTIAL
  PREMIUM
  STRATEGIC
  DISTRESSED
  DEVELOPMENT
  LAND_BANK
}
```

**Rationale:**
- **MODERATE_POTENTIAL**: Better granularity between MONITOR and HIGH_POTENTIAL
- **STRATEGIC**: Long-term strategic acquisitions
- **DISTRESSED**: Foreclosure, auction opportunities
- **DEVELOPMENT**: Development opportunities
- **LAND_BANK**: Land banking for future development

### 4. Acquisition Urgency Expansion

**Current:** 4 levels
**Recommended Expansion:**

```prisma
enum AcquisitionUrgency {
  LOW
  MEDIUM
  HIGH
  IMMEDIATE
  URGENT
  TIME_SENSITIVE
  MARKET_TIMING
  COMPETITIVE
}
```

**Rationale:**
- **URGENT**: Between HIGH and IMMEDIATE
- **TIME_SENSITIVE**: Market cycle dependent
- **MARKET_TIMING**: Based on market conditions
- **COMPETITIVE**: Multiple buyers interested

### 5. AI Field Expansion

**Current:** aiSummary, aiProsCons, aiNeighborhoodScore, aiROIHint
**Recommended Expansion:**

```prisma
model Property {
  // Existing AI fields
  aiSummary                String?                         @db.Text
  aiProsCons               String?                         @db.Text
  aiNeighborhoodScore      Float?
  aiROIHint                String?                         @db.Text
  
  // New AI fields
  aiOpportunityScore       Float?                          // Overall opportunity score (0-100)
  aiRiskScore              Float?                          // Risk score (0-100)
  aiLiquidityScore         Float?                          // Liquidity score (0-100)
  aiMarketTrend           String?                         // GROWING, STABLE, DECLINING
  aiPricePrediction       Decimal?                        @db.Decimal(14, 2)
  aiRentalYieldPrediction  Float?
  aiAppreciationPrediction Float?                         // Annual appreciation rate
  aiTimeToSell            Int?                            // Predicted days to sell
  aiBestListingType        ListingType?
  aiOptimalPriceRange     Json?                           // { min: Decimal, max: Decimal }
  aiCompetitiveAnalysis   Json?                           // { competitorCount: Int, avgPrice: Decimal }
  aiInvestmentStrategy    String?                         // NORMAL_SALE, LUXURY_RENTAL, CORPORATE_TENANT
  aiConfidenceLevel       Float?                          // 0-1
  aiModelVersion          String?                         // Model version used
  aiLastAnalyzedAt        DateTime?
  aiAnalysisFlags         String[]                        // Flags for special conditions
  aiCountrySpecificFactors Json?                          // Country-specific AI insights
  aiSeasonalFactors       Json?                           // Seasonal considerations
  aiRegulatoryRisks       String[]                        // Regulatory risk factors
  aiMarketSentiment       String?                         // BULLISH, BEARISH, NEUTRAL
  aiSimilarProperties      String[]                        // IDs of similar properties
  aiRecommendedActions    Json?                           // Recommended actions
}
```

**Rationale:**
- **Comprehensive scoring**: Multiple AI scores for different aspects
- **Predictive analytics**: Price, rental yield, appreciation predictions
- **Strategic guidance**: Investment strategy recommendations
- **Country-specific**: Country-specific factors and risks
- **Market intelligence**: Competitive analysis, market sentiment
- **Actionable insights**: Recommended actions

### 6. Country-Specific Property Types

**Recommended:** Add country-specific property type mappings

```prisma
model CountryPropertyTypeMapping {
  id               String      @id @default(cuid())
  countryIsoCode   String      @db.VarChar(2)
  propertyType     PropertyType
  localTypeName    String      // Local name (e.g., "Daire" for TR)
  localCategory    String?     // Local category
  legalStructure   String?     // Legal structure (e.g., "Tapu" for TR)
  taxImplications  Json?       // Tax implications
  regulations      Json?       // Local regulations
  aiWeights        Json?       // AI scoring weights for this type
  
  @@unique([countryIsoCode, propertyType])
  @@index([countryIsoCode])
}
```

**Rationale:**
- **Local terminology**: Country-specific property names
- **Legal structures**: Different legal structures per country
- **Tax implications**: Country-specific tax rules
- **AI customization**: Different AI weights per country/property type

### 7. Commercial Property Specific Fields

**Recommended:** Add commercial-specific model

```prisma
model CommercialPropertyDetails {
  id                  String   @id @default(cuid())
  propertyId          String   @unique
  commercialType      CommercialPropertyType
  buildingClass       String?  // Class A, B, C
  totalSquareFootage  Float?
  rentableSquareFootage Float?
  officeSpace         Float?
  retailSpace         Float?
  warehouseSpace      Float?
  parkingSpaces       Int?
  loadingDocks        Int?
  ceilingHeight       Float?
  floorLoadCapacity   Float?
  powerCapacity       Float?
  hvacSystem          String?
  fireSuppression     String?
  securitySystem      String?
  accessibilityRating String?
  greenCertification  String? // LEED, BREEAM
  zoning              String?
  permittedUses       String[]
  anchorTenants       String[]
  currentOccupancy     Float?
  noi                 Decimal? @db.Decimal(14, 2) // Net Operating Income
  capRate             Float?
  tripleNetLease       Boolean @default(false)
  leaseTerms          Json?
  
  property            Property @relation(fields: [propertyId], references: [id])
}

enum CommercialPropertyType {
  OFFICE
  RETAIL
  INDUSTRIAL
  WAREHOUSE
  HOTEL
  RESTAURANT
  MIXED_USE
  MEDICAL
  EDUCATIONAL
  DATA_CENTER
  LOGISTICS
  SELF_STORAGE
  SENIOR_LIVING
  STUDENT_HOUSING
  CO_WORKING
  RECREATIONAL
  SPECIAL_PURPOSE
}
```

**Rationale:**
- **Commercial-specific metrics**: NOI, cap rate, occupancy
- **Physical specifications**: Ceiling height, floor load, power capacity
- **Lease information**: Triple net lease, anchor tenants
- **Certifications**: Green building certifications
- **Zoning and uses**: Permitted uses, zoning information

### 8. Agent Task Integration

**Recommended:** Add agent task tracking model

```prisma
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
  
  property        Property?    @relation(fields: [propertyId], references: [id])
  subTasks        AgentTask[]  @relation("SubTasks")
  parentTask      AgentTask?   @relation("SubTasks", fields: [parentTaskId], references: [id])
  
  @@index([agentType])
  @@index([taskStatus])
  @@index([propertyId])
  @@index([dueDate])
}

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
}

enum TaskPriority {
  CRITICAL
  HIGH
  MEDIUM
  LOW
  ROUTINE
}
```

**Rationale:**
- **Task orchestration**: Track agent tasks across the system
- **Performance monitoring**: Track task completion times and success rates
- **Error handling**: Retry logic and error tracking
- **Workflow management**: Parent-child task relationships
- **Agent coordination**: Coordinate multiple agents for complex workflows

### 9. Country-Specific AI Models

**Recommended:** Add country-specific AI model configuration

```prisma
model CountryAIModelConfig {
  id                    String   @id @default(cuid())
  countryIsoCode        String   @db.VarChar(2)
  modelType             AIModelType
  modelName             String
  modelVersion          String
  isActive              Boolean  @default(true)
  accuracy              Float?
  lastTrainedAt         DateTime?
  trainingDataSize       Int?
  features              String[]
  weights               Json?
  hyperparameters        Json?
  performanceMetrics    Json?
  deploymentStatus      String?
  apiEndpoint           String?
  costPerCall           Decimal? @db.Decimal(10, 4)
  rateLimit             Int?
  fallbackModelId       String?
  
  @@unique([countryIsoCode, modelType, modelVersion])
  @@index([countryIsoCode])
  @@index([modelType])
}

enum AIModelType {
  OPPORTUNITY_ENGINE
  STRATEGIC_BRAIN
  VALUATION_MODEL
  SIMULATION_AGENT
  RANKING_ENGINE
  EMBEDDING_MODEL
  CLASSIFICATION_MODEL
  REGRESSION_MODEL
  NLP_MODEL
  VISION_MODEL
}
```

**Rationale:**
- **Model versioning**: Track different model versions per country
- **Performance tracking**: Accuracy, training data size
- **Cost management**: Cost per call, rate limits
- **Fallback mechanisms**: Fallback models for reliability
- **A/B testing**: Multiple models per country for testing

### 10. Expansion Priority Matrix

| Priority | Expansion | Impact | Complexity | Country Relevance |
|----------|-----------|--------|------------|-------------------|
| **HIGH** | AI Field Expansion | Very High | Low | All Countries |
| **HIGH** | Agent Task Integration | High | Medium | All Countries |
| **HIGH** | Listing Type Expansion | High | Low | TR, AE, GB |
| **MEDIUM** | Commercial Property Details | High | Medium | US, AE, GB |
| **MEDIUM** | Country-Specific Property Types | Medium | Low | All Countries |
| **MEDIUM** | Opportunity Tier Expansion | Medium | Low | All Countries |
| **LOW** | Property Type Expansion | Low | Low | Country-Specific |
| **LOW** | Country AI Model Config | Medium | High | All Countries |

## Implementation Recommendations

### Phase 1: Immediate (High Priority)
1. **AI Field Expansion** - Add comprehensive AI fields to Property model
2. **Agent Task Integration** - Implement agent task tracking
3. **Listing Type Expansion** - Add critical listing types

### Phase 2: Short-term (Medium Priority)
1. **Commercial Property Details** - Add commercial-specific model
2. **Country-Specific Property Types** - Implement local terminology
3. **Opportunity Tier Expansion** - Add more granularity

### Phase 3: Long-term (Low Priority)
1. **Property Type Expansion** - Add niche property types
2. **Country AI Model Config** - Implement model versioning
3. **Acquisition Urgency Expansion** - Add more urgency levels

## Conclusion

Current Prisma schema is already comprehensive and well-structured for the AI Acquisition OS. The recommended expansions focus on:

1. **AI Enhancement**: More AI fields for better decision-making
2. **Agent Orchestration**: Task tracking for agent coordination
3. **Commercial Support**: Better commercial property handling
4. **Country Specificity**: Local terminology and regulations
5. **Granularity**: More detailed classification and scoring

The expansions are designed to be incremental and backward-compatible, allowing for gradual implementation without disrupting existing functionality.

**Recommended Starting Point:** Begin with AI Field Expansion and Agent Task Integration, as these provide the highest impact with lowest complexity and benefit all countries equally.
