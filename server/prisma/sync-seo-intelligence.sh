#!/bin/bash

# SEO Intelligence OS Schema Sync Script
# This script copies SEO Intelligence OS models to all country schemas

PRISMA_DIR="/Users/os2026/Downloads/Reservatior/server/prisma"
MASTER_SCHEMA="$PRISMA_DIR/schema.prisma"

# SEO Intelligence OS additions
SEO_INTELLIGENCE_MODELS="
// ─── SEO INTELLIGENCE OS ───

// SEO Opportunity Score Model - Mathematical scoring for page generation
model SEOOpportunityScore {
  id                    String   @id @default(cuid())
  countryIsoCode        String
  stateCode             String?
  citySlug              String?
  districtSlug          String?
  neighborhoodSlug      String?
  propertyType          PropertyType?
  listingType           ListingType?
  intent                SEOIntent?

  searchDemand          Float
  propertySupply        Float
  competitionLevel      Float
  investmentValue       Float
  conversionProbability Float
  freshnessScore        Float

  finalScore            Float
  shouldCreate          Boolean
  priority              SEOPagePriority
  updateFrequency       String

  calculatedAt          DateTime @default(now())
  expiresAt             DateTime?

  seoPageEntities       SEOPageEntity[]

  @@index([countryIsoCode, citySlug])
  @@index([finalScore])
  @@index([shouldCreate])
  @@index([priority])
  @@index([intent])
}

// SEO Page Entity Model - Dynamic page management
model SEOPageEntity {
  id                    String   @id @default(cuid())
  entityType            SEOPageEntityType
  countryIsoCode        String
  stateCode             String?
  citySlug              String?
  districtSlug          String?
  neighborhoodSlug      String?
  propertyType          PropertyType?
  listingType           ListingType?
  intent                SEOIntent?

  slug                  String
  canonicalUrl          String
  title                 String
  metaDescription       String
  h1                    String
  content               Json?
  schemaMarkup          Json?

  seoOpportunityScoreId String?
  seoOpportunityScore  SEOOpportunityScore? @relation(fields: [seoOpportunityScoreId], references: [id])

  lastGenerated         DateTime @default(now())
  lastUpdated           DateTime @default(now())
  status                SEOPageStatus
  priority              Int?
  changeFrequency       String?

  @@index([countryIsoCode, citySlug])
  @@index([slug])
  @@index([status])
  @@index([priority])
  @@index([intent])
  @@unique([slug])
}

// SEO Knowledge Graph Model - Relationship structure
model SEOKnowledgeGraph {
  id                    String   @id @default(cuid())
  entityType            String
  entityId              String
  entityType2           String?
  entityId2             String?
  relationshipType      String
  relationshipWeight    Float?
  confidence            Float?
  metadata              Json?
  createdAt             DateTime @default(now())
  updatedAt             DateTime @updatedAt

  @@index([entityType, entityId])
  @@index([relationshipType])
  @@index([relationshipWeight])
}

// Enums for SEO Intelligence OS
enum SEOIntent {
  INVESTMENT
  RENTAL
  BUYING
  SELLING
  MARKET_REPORT
  RENTAL_YIELD
  GOLDEN_VISA
  FOREIGN_INVESTOR
  INFRASTRUCTURE
  SCHOOL_DISTRICT
  TRANSPORTATION
  LIFESTYLE
  NEIGHBORHOOD_GUIDE
}

enum SEOPageEntityType {
  COUNTRY_LEVEL
  STATE_LEVEL
  CITY_LEVEL
  DISTRICT_LEVEL
  NEIGHBORHOOD_LEVEL
  PROPERTY_TYPE_LEVEL
  TRANSACTION_TYPE_LEVEL
  INTENT_LEVEL
  COMPOSITE_LEVEL
}

enum SEOPagePriority {
  CRITICAL
  HIGH
  MEDIUM
  LOW
  ROUTINE
}

enum SEOPageStatus {
  PENDING
  GENERATING
  GENERATED
  PUBLISHED
  NEEDS_UPDATE
  UPDATING
  ARCHIVED
  FAILED
}"

echo "Starting SEO Intelligence OS sync to all country schemas..."

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
  
  # Check if schema already has SEO Intelligence OS
  if grep -q "SEO INTELLIGENCE OS" "$schema_path"; then
    echo "  ✓ $schema already has SEO Intelligence OS - skipping"
    continue
  fi
  
  # Add SEO Intelligence OS models at end of file
  echo "" >> "$schema_path"
  echo "// ─── SEO INTELLIGENCE OS ───" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// SEO Opportunity Score Model - Mathematical scoring for page generation" >> "$schema_path"
  echo "model SEOOpportunityScore {" >> "$schema_path"
  echo "  id                    String   @id @default(cuid())" >> "$schema_path"
  echo "  countryIsoCode        String" >> "$schema_path"
  echo "  stateCode             String?" >> "$schema_path"
  echo "  citySlug              String?" >> "$schema_path"
  echo "  districtSlug          String?" >> "$schema_path"
  echo "  neighborhoodSlug      String?" >> "$schema_path"
  echo "  propertyType          PropertyType?" >> "$schema_path"
  echo "  listingType           ListingType?" >> "$schema_path"
  echo "  intent                SEOIntent?" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  searchDemand          Float" >> "$schema_path"
  echo "  propertySupply        Float" >> "$schema_path"
  echo "  competitionLevel      Float" >> "$schema_path"
  echo "  investmentValue       Float" >> "$schema_path"
  echo "  conversionProbability Float" >> "$schema_path"
  echo "  freshnessScore        Float" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  finalScore            Float" >> "$schema_path"
  echo "  shouldCreate          Boolean" >> "$schema_path"
  echo "  priority              SEOPagePriority" >> "$schema_path"
  echo "  updateFrequency       String" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  calculatedAt          DateTime @default(now())" >> "$schema_path"
  echo "  expiresAt             DateTime?" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  seoPageEntities       SEOPageEntity[]" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  @@index([countryIsoCode, citySlug])" >> "$schema_path"
  echo "  @@index([finalScore])" >> "$schema_path"
  echo "  @@index([shouldCreate])" >> "$schema_path"
  echo "  @@index([priority])" >> "$schema_path"
  echo "  @@index([intent])" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// SEO Page Entity Model - Dynamic page management" >> "$schema_path"
  echo "model SEOPageEntity {" >> "$schema_path"
  echo "  id                    String   @id @default(cuid())" >> "$schema_path"
  echo "  entityType            SEOPageEntityType" >> "$schema_path"
  echo "  countryIsoCode        String" >> "$schema_path"
  echo "  stateCode             String?" >> "$schema_path"
  echo "  citySlug              String?" >> "$schema_path"
  echo "  districtSlug          String?" >> "$schema_path"
  echo "  neighborhoodSlug      String?" >> "$schema_path"
  echo "  propertyType          PropertyType?" >> "$schema_path"
  echo "  listingType           ListingType?" >> "$schema_path"
  echo "  intent                SEOIntent?" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  slug                  String" >> "$schema_path"
  echo "  canonicalUrl          String" >> "$schema_path"
  echo "  title                 String" >> "$schema_path"
  echo "  metaDescription       String" >> "$schema_path"
  echo "  h1                    String" >> "$schema_path"
  echo "  content               Json?" >> "$schema_path"
  echo "  schemaMarkup          Json?" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  seoOpportunityScoreId String?" >> "$schema_path"
  echo "  seoOpportunityScore  SEOOpportunityScore? @relation(fields: [seoOpportunityScoreId], references: [id])" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  lastGenerated         DateTime @default(now())" >> "$schema_path"
  echo "  lastUpdated           DateTime @default(now())" >> "$schema_path"
  echo "  status                SEOPageStatus" >> "$schema_path"
  echo "  priority              Int?" >> "$schema_path"
  echo "  changeFrequency       String?" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  @@index([countryIsoCode, citySlug])" >> "$schema_path"
  echo "  @@index([slug])" >> "$schema_path"
  echo "  @@index([status])" >> "$schema_path"
  echo "  @@index([priority])" >> "$schema_path"
  echo "  @@index([intent])" >> "$schema_path"
  echo "  @@unique([slug])" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// SEO Knowledge Graph Model - Relationship structure" >> "$schema_path"
  echo "model SEOKnowledgeGraph {" >> "$schema_path"
  echo "  id                    String   @id @default(cuid())" >> "$schema_path"
  echo "  entityType            String" >> "$schema_path"
  echo "  entityId              String" >> "$schema_path"
  echo "  entityType2           String?" >> "$schema_path"
  echo "  entityId2             String?" >> "$schema_path"
  echo "  relationshipType      String" >> "$schema_path"
  echo "  relationshipWeight    Float?" >> "$schema_path"
  echo "  confidence            Float?" >> "$schema_path"
  echo "  metadata              Json?" >> "$schema_path"
  echo "  createdAt             DateTime @default(now())" >> "$schema_path"
  echo "  updatedAt             DateTime @updatedAt" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "  @@index([entityType, entityId])" >> "$schema_path"
  echo "  @@index([relationshipType])" >> "$schema_path"
  echo "  @@index([relationshipWeight])" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "// Enums for SEO Intelligence OS" >> "$schema_path"
  echo "enum SEOIntent {" >> "$schema_path"
  echo "  INVESTMENT" >> "$schema_path"
  echo "  RENTAL" >> "$schema_path"
  echo "  BUYING" >> "$schema_path"
  echo "  SELLING" >> "$schema_path"
  echo "  MARKET_REPORT" >> "$schema_path"
  echo "  RENTAL_YIELD" >> "$schema_path"
  echo "  GOLDEN_VISA" >> "$schema_path"
  echo "  FOREIGN_INVESTOR" >> "$schema_path"
  echo "  INFRASTRUCTURE" >> "$schema_path"
  echo "  SCHOOL_DISTRICT" >> "$schema_path"
  echo "  TRANSPORTATION" >> "$schema_path"
  echo "  LIFESTYLE" >> "$schema_path"
  echo "  NEIGHBORHOOD_GUIDE" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "enum SEOPageEntityType {" >> "$schema_path"
  echo "  COUNTRY_LEVEL" >> "$schema_path"
  echo "  STATE_LEVEL" >> "$schema_path"
  echo "  CITY_LEVEL" >> "$schema_path"
  echo "  DISTRICT_LEVEL" >> "$schema_path"
  echo "  NEIGHBORHOOD_LEVEL" >> "$schema_path"
  echo "  PROPERTY_TYPE_LEVEL" >> "$schema_path"
  echo "  TRANSACTION_TYPE_LEVEL" >> "$schema_path"
  echo "  INTENT_LEVEL" >> "$schema_path"
  echo "  COMPOSITE_LEVEL" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "enum SEOPagePriority {" >> "$schema_path"
  echo "  CRITICAL" >> "$schema_path"
  echo "  HIGH" >> "$schema_path"
  echo "  MEDIUM" >> "$schema_path"
  echo "  LOW" >> "$schema_path"
  echo "  ROUTINE" >> "$schema_path"
  echo "}" >> "$schema_path"
  echo "" >> "$schema_path"
  echo "enum SEOPageStatus {" >> "$schema_path"
  echo "  PENDING" >> "$schema_path"
  echo "  GENERATING" >> "$schema_path"
  echo "  GENERATED" >> "$schema_path"
  echo "  PUBLISHED" >> "$schema_path"
  echo "  NEEDS_UPDATE" >> "$schema_path"
  echo "  UPDATING" >> "$schema_path"
  echo "  ARCHIVED" >> "$schema_path"
  echo "  FAILED" >> "$schema_path"
  echo "}" >> "$schema_path"
  
  echo "  ✓ $schema updated successfully"
done

echo ""
echo "SEO Intelligence OS sync completed!"
echo "Run 'bun prisma generate' to regenerate Prisma Client."
