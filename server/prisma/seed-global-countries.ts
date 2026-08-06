// =============================================================================
// seed-global-countries.ts
// Phase 6 — Seed data for 23-country Global Hybrid Rental OS
// Run: bunx ts-node prisma/seed-global-countries.ts
// =============================================================================

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

const countryPolicies = [
  // ── Americas ──────────────────────────────────────────────────────────
  { countryCode: 'US', countryName: 'United States', currency: 'USD', taxSystem: 'FEDERAL_STATE', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 0, vatRate: 0, tourismTaxRate: 14, evictionProcessType: 'JUDICIAL_VARYING', depositRules: 'STATE_DEPENDENT_MAX_2_MONTHS', contractRules: 'COMMON_LAW', complianceScore: 85, corporateHousingDemand: 'VERY_HIGH', notes: 'Airbnb regulations vary by city. NYC/SF/LA strict.' },
  { countryCode: 'CA', countryName: 'Canada', currency: 'CAD', taxSystem: 'FEDERAL_STATE', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 25, vatRate: 5, tourismTaxRate: 10, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'PROVINCE_DEPENDENT', contractRules: 'COMMON_LAW', complianceScore: 82, corporateHousingDemand: 'HIGH', notes: 'GST 5%, provincial HST. Foreign non-resident WHT 25%.' },
  { countryCode: 'MX', countryName: 'Mexico', currency: 'MXN', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: false, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 25, vatRate: 16, tourismTaxRate: 3, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_2_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 65, corporateHousingDemand: 'MEDIUM' },
  { countryCode: 'BR', countryName: 'Brazil', currency: 'BRL', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: false, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 15, vatRate: 12, tourismTaxRate: 5, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_3_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 60, corporateHousingDemand: 'MEDIUM', notes: 'Complex tax system with ISS municipal service tax.' },
  // ── Europe ────────────────────────────────────────────────────────────
  { countryCode: 'GB', countryName: 'United Kingdom', currency: 'GBP', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: false, maxShortStayDays: 90, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 20, vatRate: 20, tourismTaxRate: 0, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'MAX_5_WEEKS', contractRules: 'COMMON_LAW', complianceScore: 88, corporateHousingDemand: 'VERY_HIGH', notes: 'London 90-day Airbnb limit. Rent a Room £7,500 exemption.' },
  { countryCode: 'DE', countryName: 'Germany', currency: 'EUR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 25, vatRate: 19, tourismTaxRate: 5, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'MAX_3_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 80, corporateHousingDemand: 'VERY_HIGH', notes: 'Zweckentfremdungsverbot in Berlin/Munich.' },
  { countryCode: 'NL', countryName: 'Netherlands', currency: 'EUR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, maxShortStayDays: 60, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 15, vatRate: 21, tourismTaxRate: 7, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'MAX_2_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 78, corporateHousingDemand: 'HIGH', notes: 'Amsterdam 60-day limit, registration required.' },
  { countryCode: 'FR', countryName: 'France', currency: 'EUR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, maxShortStayDays: 120, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 20, vatRate: 20, tourismTaxRate: 3, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_1_MONTH', contractRules: 'CIVIL_LAW', complianceScore: 75, corporateHousingDemand: 'HIGH', notes: 'Paris 120-day limit. LMNP/LMP meublé fiscaux.' },
  { countryCode: 'ES', countryName: 'Spain', currency: 'EUR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 24, vatRate: 10, tourismTaxRate: 4, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_2_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 72, corporateHousingDemand: 'HIGH', notes: 'Autonomous community licenses. Barcelona strict zoning.' },
  { countryCode: 'PT', countryName: 'Portugal', currency: 'EUR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 28, vatRate: 23, tourismTaxRate: 2, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'MAX_2_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 78, corporateHousingDemand: 'HIGH', notes: 'AL (Alojamento Local) license. NHR tax regime.' },
  { countryCode: 'IT', countryName: 'Italy', currency: 'EUR', taxSystem: 'FLAT_TAX', shortStayAllowed: true, licenseRequired: true, maxShortStayDays: 30, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 21, vatRate: 10, tourismTaxRate: 5, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_3_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 68, corporateHousingDemand: 'HIGH', notes: 'Cedolare secca 21%. CIR code for tourists.' },
  { countryCode: 'GR', countryName: 'Greece', currency: 'EUR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 15, vatRate: 24, tourismTaxRate: 4, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'MAX_2_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 70, corporateHousingDemand: 'MEDIUM', notes: 'AADE registration required. Golden Visa drives investment.' },
  { countryCode: 'CH', countryName: 'Switzerland', currency: 'CHF', taxSystem: 'FEDERAL_STATE', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 35, vatRate: 7.7, tourismTaxRate: 3, evictionProcessType: 'JUDICIAL_FAST', depositRules: 'MAX_3_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 90, corporateHousingDemand: 'VERY_HIGH', notes: 'Very high corporate housing for expats. Cantonal tax variations.' },
  // ── Turkey ────────────────────────────────────────────────────────────
  { countryCode: 'TR', countryName: 'Turkey', currency: 'TRY', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, maxShortStayDays: 100, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 20, vatRate: 20, tourismTaxRate: 2, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'STRICT_MAX_3_MONTHS', contractRules: 'CIVIL_LAW', complianceScore: 90, corporateHousingDemand: 'HIGH', complianceModel: '7464', notes: 'Law 7464: 100% kat malikleri consent + tourism license + KABİS.' },
  // ── Middle East ───────────────────────────────────────────────────────
  { countryCode: 'AE', countryName: 'UAE', currency: 'AED', taxSystem: 'TERRITORIAL_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 0, vatRate: 5, tourismTaxRate: 10, evictionProcessType: 'ADMINISTRATIVE', depositRules: 'MAX_5_PERCENT', contractRules: 'CIVIL_LAW', complianceScore: 92, corporateHousingDemand: 'VERY_HIGH', notes: 'DTCM license. No personal income tax. Dubai huge expat demand.' },
  { countryCode: 'SA', countryName: 'Saudi Arabia', currency: 'SAR', taxSystem: 'TERRITORIAL_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 5, vatRate: 15, tourismTaxRate: 5, evictionProcessType: 'ADMINISTRATIVE', depositRules: 'MAX_2_MONTHS', contractRules: 'SHARIA_LAW', complianceScore: 80, corporateHousingDemand: 'VERY_HIGH', notes: 'Vision 2030 corporate housing demand. GOSI regulations.' },
  { countryCode: 'QA', countryName: 'Qatar', currency: 'QAR', taxSystem: 'TERRITORIAL_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 5, vatRate: 0, tourismTaxRate: 5, evictionProcessType: 'ADMINISTRATIVE', depositRules: 'MAX_1_MONTH', contractRules: 'CIVIL_LAW', complianceScore: 85, corporateHousingDemand: 'VERY_HIGH', notes: 'No VAT. Large expat workforce. FIFA legacy demand for serviced apts.' },
  // ── Asia-Pacific ──────────────────────────────────────────────────────
  { countryCode: 'AU', countryName: 'Australia', currency: 'AUD', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: false, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 10, vatRate: 10, tourismTaxRate: 0, evictionProcessType: 'JUDICIAL_FAST', depositRules: 'STATE_DEPENDENT_MAX_4_WEEKS', contractRules: 'COMMON_LAW', complianceScore: 87, corporateHousingDemand: 'HIGH', notes: 'GST 10%. State-based legislation. Strong corporate travel.' },
  { countryCode: 'SG', countryName: 'Singapore', currency: 'SGD', taxSystem: 'FLAT_TAX', shortStayAllowed: false, licenseRequired: true, maxShortStayDays: 0, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 15, vatRate: 9, tourismTaxRate: 0, evictionProcessType: 'JUDICIAL_FAST', depositRules: 'MAX_2_MONTHS', contractRules: 'COMMON_LAW', complianceScore: 88, corporateHousingDemand: 'VERY_HIGH', notes: 'Airbnb banned. Min 3-month rental. Massive corporate demand.' },
  { countryCode: 'JP', countryName: 'Japan', currency: 'JPY', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, maxShortStayDays: 180, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 20, vatRate: 10, tourismTaxRate: 2, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'TRADITIONAL_SHIKIKIN', contractRules: 'CIVIL_LAW', complianceScore: 82, corporateHousingDemand: 'HIGH', notes: 'Minpaku law 180-day cap. Shikikin deposit system.' },
  { countryCode: 'KR', countryName: 'South Korea', currency: 'KRW', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: true, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 22, vatRate: 10, tourismTaxRate: 3, evictionProcessType: 'JUDICIAL_MEDIUM', depositRules: 'JEONSE_OR_MONTHLY', contractRules: 'CIVIL_LAW', complianceScore: 80, corporateHousingDemand: 'HIGH', notes: 'Unique Jeonse (lump-sum deposit) system. Strong Seoul corporate.' },
  { countryCode: 'IN', countryName: 'India', currency: 'INR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: false, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 30, vatRate: 18, tourismTaxRate: 12, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_3_MONTHS', contractRules: 'COMMON_LAW', complianceScore: 60, corporateHousingDemand: 'HIGH', notes: 'Rapidly growing serviced apartments. IT sector corporate housing.' },
  { countryCode: 'PK', countryName: 'Pakistan', currency: 'PKR', taxSystem: 'INCOME_TAX', shortStayAllowed: true, licenseRequired: false, corporateHousingAllowed: true, masterLeaseAvailable: true, withholdingTaxRate: 15, vatRate: 17, tourismTaxRate: 5, evictionProcessType: 'JUDICIAL_LENGTHY', depositRules: 'MAX_2_MONTHS', contractRules: 'COMMON_LAW', complianceScore: 50, corporateHousingDemand: 'MEDIUM', notes: 'Emerging market. Embassy and corporate housing in Islamabad.' },
];

// City-level market data for key markets
const rentalMarkets = [
  { countryCode: 'US', city: 'New York', demandLevel: 'VERY_HIGH', avgAdrUsd: 280, avgOccupancyPct: 76, avgMonthlyRentUsd: 4200, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'CORPORATE_HOUSING' },
  { countryCode: 'US', city: 'Los Angeles', demandLevel: 'HIGH', avgAdrUsd: 220, avgOccupancyPct: 72, avgMonthlyRentUsd: 3200, corporateHousingDemand: 'HIGH', primaryRentalModel: 'REVENUE_SHARE' },
  { countryCode: 'GB', city: 'London', demandLevel: 'VERY_HIGH', avgAdrUsd: 310, avgOccupancyPct: 78, avgMonthlyRentUsd: 4500, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'CORPORATE_HOUSING' },
  { countryCode: 'DE', city: 'Berlin', demandLevel: 'HIGH', avgAdrUsd: 165, avgOccupancyPct: 74, avgMonthlyRentUsd: 2100, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'MASTER_LEASE' },
  { countryCode: 'DE', city: 'Munich', demandLevel: 'HIGH', avgAdrUsd: 195, avgOccupancyPct: 76, avgMonthlyRentUsd: 2800, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'MASTER_LEASE' },
  { countryCode: 'AE', city: 'Dubai', demandLevel: 'VERY_HIGH', avgAdrUsd: 350, avgOccupancyPct: 82, avgMonthlyRentUsd: 5500, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'CORPORATE_HOUSING' },
  { countryCode: 'AE', city: 'Abu Dhabi', demandLevel: 'HIGH', avgAdrUsd: 280, avgOccupancyPct: 75, avgMonthlyRentUsd: 4200, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'CORPORATE_HOUSING' },
  { countryCode: 'TR', city: 'Istanbul', demandLevel: 'HIGH', avgAdrUsd: 90, avgOccupancyPct: 79, avgMonthlyRentUsd: 1200, corporateHousingDemand: 'HIGH', primaryRentalModel: 'REVENUE_SHARE' },
  { countryCode: 'SG', city: 'Singapore', demandLevel: 'VERY_HIGH', avgAdrUsd: 290, avgOccupancyPct: 85, avgMonthlyRentUsd: 4800, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'CORPORATE_HOUSING' },
  { countryCode: 'JP', city: 'Tokyo', demandLevel: 'HIGH', avgAdrUsd: 210, avgOccupancyPct: 74, avgMonthlyRentUsd: 2800, corporateHousingDemand: 'HIGH', primaryRentalModel: 'MASTER_LEASE' },
  { countryCode: 'AU', city: 'Sydney', demandLevel: 'HIGH', avgAdrUsd: 240, avgOccupancyPct: 73, avgMonthlyRentUsd: 2900, corporateHousingDemand: 'HIGH', primaryRentalModel: 'REVENUE_SHARE' },
  { countryCode: 'CH', city: 'Zurich', demandLevel: 'VERY_HIGH', avgAdrUsd: 420, avgOccupancyPct: 80, avgMonthlyRentUsd: 6200, corporateHousingDemand: 'VERY_HIGH', primaryRentalModel: 'CORPORATE_HOUSING' },
];

async function main() {
  console.log('🌍 Seeding Global Hybrid Rental OS — 23 Country Policies...');

  let created = 0;
  let updated = 0;

  for (const policy of countryPolicies) {
    await prisma.countryPolicy.upsert({
      where: { countryCode: policy.countryCode },
      update: policy,
      create: policy,
    });
    created++;
    process.stdout.write(`  ✓ ${policy.countryCode} — ${policy.countryName}\n`);
  }

  console.log(`\n🏙️ Seeding ${rentalMarkets.length} City Rental Markets...`);

  for (const market of rentalMarkets) {
    await prisma.countryRentalMarket.upsert({
      where: { countryCode_city: { countryCode: market.countryCode, city: market.city } },
      update: market,
      create: market,
    });
    process.stdout.write(`  ✓ ${market.city}, ${market.countryCode}\n`);
  }

  console.log(`\n✅ Seed complete: ${countryPolicies.length} countries + ${rentalMarkets.length} cities`);
}

main()
  .catch(e => { console.error(e); process.exit(1); })
  .finally(() => prisma.$disconnect());
