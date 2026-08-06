// =============================================================================
// Global Hybrid Rental OS — API Routes
// Phase 4: 5 endpoints for country analysis, evaluation, simulation, saga, list
// =============================================================================

import Elysia, { t } from 'elysia';
import { multiCountryIntelligenceEngine } from '../services/intelligence/multi-country-intelligence-engine';
import { hybridRentalEngine } from '../services/intelligence/hybrid-rental-engine';
import { revenueDAGEngine } from '../services/intelligence/revenue-dag-engine';
import { globalHybridRentalSaga } from '../services/intelligence/global-hybrid-rental-saga';
import { hybridRentalMultiAgentSwarm } from '../services/ai/hybrid-rental-multi-agent';

export const globalHybridRentalRoutes = new Elysia({ prefix: '/api/os/global-hybrid-rental' })

  // ─────────────────────────────────────────────────────────────────────────
  // GET /countries — list all 23 supported countries with policies
  // ─────────────────────────────────────────────────────────────────────────
  .get('/countries', () => {
    const countries = multiCountryIntelligenceEngine.listSupportedCountries();
    return {
      success: true,
      count: countries.length,
      countries: countries.map(c => ({
        countryCode: c.countryCode,
        countryName: c.countryName,
        currency: c.currency,
        taxSystem: c.taxSystem,
        shortStayAllowed: c.shortStayAllowed,
        licenseRequired: c.licenseRequired,
        maxShortStayDays: c.maxShortStayDays,
        corporateHousingAllowed: c.corporateHousingAllowed,
        masterLeaseAvailable: c.masterLeaseAvailable,
        vatRate: c.vatRate,
        tourismTaxRate: c.tourismTaxRate,
        withholdingTaxRate: c.withholdingTaxRate,
        corporateHousingDemand: c.corporateHousingDemand,
        complianceScore: c.complianceScore,
        notes: c.notes,
      })),
    };
  })

  // ─────────────────────────────────────────────────────────────────────────
  // POST /country-analysis — get full country intelligence report
  // ─────────────────────────────────────────────────────────────────────────
  .post(
    '/country-analysis',
    async ({ body }) => {
      const { countryCode, hasLicense = false, hasRegistration = false } = body;
      const policy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);

      if (!policy) {
        return {
          success: false,
          error: `Country '${countryCode}' is not supported. Call GET /countries for supported list.`,
        };
      }

      const compliance = multiCountryIntelligenceEngine.assessCompliance(countryCode, hasLicense, hasRegistration);
      const marketOpp = multiCountryIntelligenceEngine.getMarketOpportunity(countryCode);
      const taxSummary = multiCountryIntelligenceEngine.getTaxSummary(countryCode);

      return {
        success: true,
        countryCode,
        policy,
        compliance,
        marketOpportunity: marketOpp,
        taxSummary,
        timestamp: new Date().toISOString(),
      };
    },
    {
      body: t.Object({
        countryCode: t.String(),
        hasLicense: t.Optional(t.Boolean()),
        hasRegistration: t.Optional(t.Boolean()),
      }),
    }
  )

  // ─────────────────────────────────────────────────────────────────────────
  // POST /evaluate — run full property evaluation for given country
  // ─────────────────────────────────────────────────────────────────────────
  .post(
    '/evaluate',
    async ({ body }) => {
      const {
        countryCode = 'TR',
        neighbourhood = 'DEFAULT',
        city,
        accommodates = 2,
        bedrooms = 1,
        bathrooms = 1,
        sizeSqm = 60,
        buildingAge = 5,
        isFurnished = true,
        hasElevator = true,
        hasParking = false,
        hasPoolOrGym = false,
        proximityToMetroMins = 10,
        proximityToAirportMins = 45,
        hasBuildingConsent100Pct = true,
        hasTourismResidenceLicense = false,
        hasKabisRegistration = false,
        roomType = 'Entire home/apt',
        primaryPartnerRole,
        primaryPartnerId,
      } = body;

      const evalResult = hybridRentalEngine.evaluateProperty({
        countryCode,
        neighbourhood,
        city,
        accommodates,
        bedrooms: bedrooms ?? 1,
        bathrooms: bathrooms ?? 1,
        sizeSqm,
        buildingAge,
        isFurnished,
        hasElevator,
        hasParking,
        hasPoolOrGym,
        proximityToMetroMins,
        proximityToAirportMins,
        hasBuildingConsent100Pct,
        hasTourismResidenceLicense,
        hasKabisRegistration,
        roomType: roomType as any,
        primaryPartnerRole: primaryPartnerRole as any,
        primaryPartnerId,
      });

      const swarmResult = hybridRentalMultiAgentSwarm.runSwarmAnalysis(
        { countryCode, neighbourhood, city, accommodates, bedrooms: bedrooms ?? 1, bathrooms: bathrooms ?? 1, sizeSqm, buildingAge, isFurnished, hasElevator, hasParking, hasPoolOrGym, proximityToMetroMins, proximityToAirportMins, hasBuildingConsent100Pct, hasTourismResidenceLicense, hasKabisRegistration, roomType: roomType as any },
        evalResult
      );

      return {
        success: true,
        evaluation: evalResult,
        aiSwarm: swarmResult,
        timestamp: new Date().toISOString(),
      };
    },
    {
      body: t.Object({
        countryCode: t.Optional(t.String()),
        neighbourhood: t.Optional(t.String()),
        city: t.Optional(t.String()),
        accommodates: t.Optional(t.Number()),
        bedrooms: t.Optional(t.Number()),
        bathrooms: t.Optional(t.Number()),
        sizeSqm: t.Optional(t.Number()),
        buildingAge: t.Optional(t.Number()),
        isFurnished: t.Optional(t.Boolean()),
        hasElevator: t.Optional(t.Boolean()),
        hasParking: t.Optional(t.Boolean()),
        hasPoolOrGym: t.Optional(t.Boolean()),
        proximityToMetroMins: t.Optional(t.Number()),
        proximityToAirportMins: t.Optional(t.Number()),
        hasBuildingConsent100Pct: t.Optional(t.Boolean()),
        hasTourismResidenceLicense: t.Optional(t.Boolean()),
        hasKabisRegistration: t.Optional(t.Boolean()),
        roomType: t.Optional(t.String()),
        primaryPartnerRole: t.Optional(t.String()),
        primaryPartnerId: t.Optional(t.String()),
      }),
    }
  )

  // ─────────────────────────────────────────────────────────────────────────
  // POST /revenue-simulation — simulate Revenue DAG for a country + gross rev
  // ─────────────────────────────────────────────────────────────────────────
  .post(
    '/revenue-simulation',
    async ({ body }) => {
      const {
        propertyId = `PROP-${Math.floor(100000 + Math.random() * 900000)}`,
        countryCode = 'TR',
        grossRevenueLocal,
        ownerSharePct = 55,
        partnerCommissionRatePct = 10,
      } = body;

      const dagResult = revenueDAGEngine.processGlobalRevenueDAG({
        propertyId,
        countryCode,
        grossRevenueLocal,
        ownerSharePct,
        partnerCommissionRatePct,
      });

      const policy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);

      return {
        success: true,
        simulation: {
          countryCode,
          countryName: policy?.countryName || countryCode,
          currency: dagResult.currency,
          grossRevenueLocal: dagResult.grossRevenueLocal,
          grossRevenueTRY: dagResult.grossRevenueTRY,
          totalTaxDeductedLocal: dagResult.totalTaxDeductedLocal,
          totalTaxDeductedPct: dagResult.totalTaxDeductedPct,
          netRevenueAfterTaxLocal: dagResult.netRevenueAfterTaxLocal,
          dagNodes: dagResult.dagNodes,
          ledgerCommitHash: dagResult.ledgerCommitHash,
        },
        timestamp: new Date().toISOString(),
      };
    },
    {
      body: t.Object({
        propertyId: t.Optional(t.String()),
        countryCode: t.Optional(t.String()),
        grossRevenueLocal: t.Number(),
        ownerSharePct: t.Optional(t.Number()),
        partnerCommissionRatePct: t.Optional(t.Number()),
      }),
    }
  )

  // ─────────────────────────────────────────────────────────────────────────
  // POST /start-saga — trigger GlobalHybridRentalOnboardingSaga
  // ─────────────────────────────────────────────────────────────────────────
  .post(
    '/start-saga',
    async ({ body }) => {
      const {
        countryCode = 'TR',
        neighbourhood = 'DEFAULT',
        city,
        accommodates = 2,
        bedrooms = 1,
        bathrooms = 1,
        sizeSqm = 60,
        buildingAge = 5,
        isFurnished = true,
        hasElevator = true,
        hasParking = false,
        hasPoolOrGym = false,
        proximityToMetroMins = 10,
        proximityToAirportMins = 45,
        hasBuildingConsent100Pct = true,
        hasTourismResidenceLicense = false,
        hasKabisRegistration = false,
        roomType = 'Entire home/apt',
        grossRevenueLocal,
        primaryPartnerId,
        primaryPartnerRole,
      } = body;

      const sagaResult = await globalHybridRentalSaga.execute({
        countryCode,
        neighbourhood,
        city,
        accommodates,
        bedrooms: bedrooms ?? 1,
        bathrooms: bathrooms ?? 1,
        sizeSqm,
        buildingAge,
        isFurnished,
        hasElevator,
        hasParking,
        hasPoolOrGym,
        proximityToMetroMins,
        proximityToAirportMins,
        hasBuildingConsent100Pct,
        hasTourismResidenceLicense,
        hasKabisRegistration,
        roomType: roomType as any,
        grossRevenueLocal,
        primaryPartnerId,
        primaryPartnerRole: primaryPartnerRole as any,
      });

      return {
        success: sagaResult.status === 'COMPLETED',
        saga: sagaResult,
        timestamp: new Date().toISOString(),
      };
    },
    {
      body: t.Object({
        countryCode: t.Optional(t.String()),
        neighbourhood: t.Optional(t.String()),
        city: t.Optional(t.String()),
        accommodates: t.Optional(t.Number()),
        bedrooms: t.Optional(t.Number()),
        bathrooms: t.Optional(t.Number()),
        sizeSqm: t.Optional(t.Number()),
        buildingAge: t.Optional(t.Number()),
        isFurnished: t.Optional(t.Boolean()),
        hasElevator: t.Optional(t.Boolean()),
        hasParking: t.Optional(t.Boolean()),
        hasPoolOrGym: t.Optional(t.Boolean()),
        proximityToMetroMins: t.Optional(t.Number()),
        proximityToAirportMins: t.Optional(t.Number()),
        hasBuildingConsent100Pct: t.Optional(t.Boolean()),
        hasTourismResidenceLicense: t.Optional(t.Boolean()),
        hasKabisRegistration: t.Optional(t.Boolean()),
        roomType: t.Optional(t.String()),
        grossRevenueLocal: t.Optional(t.Number()),
        primaryPartnerId: t.Optional(t.String()),
        primaryPartnerRole: t.Optional(t.String()),
      }),
    }
  );
