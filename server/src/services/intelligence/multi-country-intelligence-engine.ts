// =============================================================================
// MultiCountryIntelligenceEngine
// Global Hybrid Rental & Revenue OS — Country Policy Layer
// Supports 23 countries with rental regulations, tax, compliance & market data
// =============================================================================

export type TaxSystem = 
  | 'INCOME_TAX'
  | 'FLAT_TAX'
  | 'TERRITORIAL_TAX'
  | 'FEDERAL_STATE'
  | 'VAT_ONLY';

export type EvictionProcessType =
  | 'JUDICIAL_FAST'
  | 'JUDICIAL_MEDIUM'
  | 'JUDICIAL_LENGTHY'
  | 'JUDICIAL_VARYING'
  | 'ADMINISTRATIVE';

export type CorporateHousingDemand = 'VERY_HIGH' | 'HIGH' | 'MEDIUM' | 'LOW';
export type MarketOpportunity = 'VERY_HIGH' | 'HIGH' | 'MEDIUM' | 'LOW' | 'UNKNOWN';

export interface CountryRentalPolicy {
  countryCode: string;
  countryName: string;
  currency: string;
  taxSystem: TaxSystem;
  shortStayAllowed: boolean;
  licenseRequired: boolean;
  maxShortStayDays?: number;
  corporateHousingAllowed: boolean;
  masterLeaseAvailable: boolean;
  withholdingTaxRate: number;   // %
  vatRate: number;              // %
  tourismTaxRate: number;       // %
  evictionProcessType: EvictionProcessType;
  depositRules: string;
  contractRules: string;
  complianceScore: number;      // 0-100
  corporateHousingDemand: CorporateHousingDemand;
  complianceModel?: string;     // e.g. '7464' for Turkey
  notes?: string;
}

export interface CountryComplianceResult {
  countryCode: string;
  isCompliant: boolean;
  complianceScore: number;
  blockers: string[];
  recommendations: string[];
  legalRiskScore: number; // 0-100, higher = riskier
}

export interface GlobalMarketOpportunityResult {
  countryCode: string;
  opportunity: MarketOpportunity;
  estimatedRevenueLiftPct: number;
  primaryModel: 'REVENUE_SHARE' | 'MASTER_LEASE' | 'CORPORATE_HOUSING' | 'SERVICED_APARTMENT';
  reasoning: string;
}

// =============================================================================
// ENGINE CLASS
// =============================================================================
export class MultiCountryIntelligenceEngine {
  private static instance: MultiCountryIntelligenceEngine;
  private policies: Map<string, CountryRentalPolicy> = new Map();

  private constructor() {
    this.initializePolicies();
  }

  public static getInstance(): MultiCountryIntelligenceEngine {
    if (!MultiCountryIntelligenceEngine.instance) {
      MultiCountryIntelligenceEngine.instance = new MultiCountryIntelligenceEngine();
    }
    return MultiCountryIntelligenceEngine.instance;
  }

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  public getCountryPolicy(countryCode: string): CountryRentalPolicy | undefined {
    return this.policies.get(countryCode.toUpperCase());
  }

  public listSupportedCountries(): CountryRentalPolicy[] {
    return Array.from(this.policies.values());
  }

  public getSupportedCountryCodes(): string[] {
    return Array.from(this.policies.keys());
  }

  public assessCompliance(
    countryCode: string,
    hasLicense: boolean = false,
    hasRegistration: boolean = false
  ): CountryComplianceResult {
    const policy = this.getCountryPolicy(countryCode);

    if (!policy) {
      return {
        countryCode,
        isCompliant: false,
        complianceScore: 0,
        blockers: ['Country not supported in MultiCountryIntelligenceEngine'],
        recommendations: ['Add country policy before attempting evaluation'],
        legalRiskScore: 100,
      };
    }

    const blockers: string[] = [];
    const recommendations: string[] = [];
    let score = policy.complianceScore;

    if (policy.licenseRequired && !hasLicense) {
      blockers.push(`License required in ${policy.countryName} but not obtained`);
      score -= 30;
    }

    if (!hasRegistration && policy.complianceModel) {
      blockers.push(`Registration required under ${policy.complianceModel} compliance model`);
      score -= 20;
    }

    if (!policy.shortStayAllowed) {
      blockers.push('Short-term rental not permitted in this country');
      score = 0;
    }

    if (policy.withholdingTaxRate > 25) {
      recommendations.push(`High withholding tax (${policy.withholdingTaxRate}%) — consult local tax advisor`);
    }

    if (policy.evictionProcessType === 'JUDICIAL_LENGTHY') {
      recommendations.push('Eviction process is lengthy — use robust tenant screening');
    }

    const legalRiskScore = Math.max(0, 100 - score);

    return {
      countryCode,
      isCompliant: blockers.length === 0 && score >= 70,
      complianceScore: Math.max(0, score),
      blockers,
      recommendations,
      legalRiskScore,
    };
  }

  public getMarketOpportunity(countryCode: string): GlobalMarketOpportunityResult {
    const policy = this.getCountryPolicy(countryCode);

    if (!policy) {
      return {
        countryCode,
        opportunity: 'UNKNOWN',
        estimatedRevenueLiftPct: 0,
        primaryModel: 'REVENUE_SHARE',
        reasoning: 'Country not in policy registry',
      };
    }

    let opportunity: MarketOpportunity = 'LOW';
    let revenueLift = 10;
    let primaryModel: GlobalMarketOpportunityResult['primaryModel'] = 'REVENUE_SHARE';
    let reasoning = '';

    if (policy.corporateHousingDemand === 'VERY_HIGH') {
      opportunity = 'VERY_HIGH';
      revenueLift = 55;
      primaryModel = 'CORPORATE_HOUSING';
      reasoning = `Very high corporate housing demand in ${policy.countryName}. Master lease + corporate housing combination recommended.`;
    } else if (policy.corporateHousingDemand === 'HIGH') {
      opportunity = 'HIGH';
      revenueLift = 40;
      primaryModel = policy.masterLeaseAvailable ? 'MASTER_LEASE' : 'REVENUE_SHARE';
      reasoning = `High corporate housing demand. Master lease available: ${policy.masterLeaseAvailable}`;
    } else if (policy.masterLeaseAvailable && policy.shortStayAllowed) {
      opportunity = 'MEDIUM';
      revenueLift = 25;
      primaryModel = 'MASTER_LEASE';
      reasoning = 'Short-term rentals and master lease both available — balanced opportunity.';
    } else if (policy.shortStayAllowed) {
      opportunity = 'MEDIUM';
      revenueLift = 20;
      primaryModel = 'REVENUE_SHARE';
      reasoning = 'Short-term rental enabled. Revenue share model applicable.';
    } else {
      opportunity = 'LOW';
      revenueLift = 5;
      primaryModel = 'SERVICED_APARTMENT';
      reasoning = 'Short-term rental restricted — serviced apartments may be viable.';
    }

    return { countryCode, opportunity, estimatedRevenueLiftPct: revenueLift, primaryModel, reasoning };
  }

  public getTaxSummary(countryCode: string): {
    effectiveTaxBurdenPct: number;
    vatRate: number;
    withholdingTaxRate: number;
    tourismTaxRate: number;
    totalDeductionRate: number;
  } {
    const policy = this.getCountryPolicy(countryCode);
    if (!policy) {
      return { effectiveTaxBurdenPct: 0, vatRate: 0, withholdingTaxRate: 0, tourismTaxRate: 0, totalDeductionRate: 0 };
    }

    const totalDeductionRate = policy.vatRate + policy.tourismTaxRate + policy.withholdingTaxRate;

    return {
      effectiveTaxBurdenPct: totalDeductionRate,
      vatRate: policy.vatRate,
      withholdingTaxRate: policy.withholdingTaxRate,
      tourismTaxRate: policy.tourismTaxRate,
      totalDeductionRate,
    };
  }

  // ---------------------------------------------------------------------------
  // 23-Country Policy Registry
  // ---------------------------------------------------------------------------
  private initializePolicies() {
    const countries: CountryRentalPolicy[] = [
      // ── Americas ──────────────────────────────────────────────────────────
      {
        countryCode: 'US',
        countryName: 'United States',
        currency: 'USD',
        taxSystem: 'FEDERAL_STATE',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 0,
        vatRate: 0,
        tourismTaxRate: 14,
        evictionProcessType: 'JUDICIAL_VARYING',
        depositRules: 'STATE_DEPENDENT_MAX_2_MONTHS',
        contractRules: 'COMMON_LAW',
        complianceScore: 85,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'Airbnb regulations vary widely by city. NYC, SF, LA have strict limits.',
      },
      {
        countryCode: 'CA',
        countryName: 'Canada',
        currency: 'CAD',
        taxSystem: 'FEDERAL_STATE',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 25,
        vatRate: 5,
        tourismTaxRate: 10,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'PROVINCE_DEPENDENT',
        contractRules: 'COMMON_LAW',
        complianceScore: 82,
        corporateHousingDemand: 'HIGH',
        notes: 'GST 5%, provincial HST varies. Foreign non-resident withholding 25%.',
      },
      {
        countryCode: 'MX',
        countryName: 'Mexico',
        currency: 'MXN',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: false,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 25,
        vatRate: 16,
        tourismTaxRate: 3,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 65,
        corporateHousingDemand: 'MEDIUM',
      },
      {
        countryCode: 'BR',
        countryName: 'Brazil',
        currency: 'BRL',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: false,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 15,
        vatRate: 12,
        tourismTaxRate: 5,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_3_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 60,
        corporateHousingDemand: 'MEDIUM',
        notes: 'Complex tax system with ISS municipal service tax.',
      },
      // ── Europe ────────────────────────────────────────────────────────────
      {
        countryCode: 'GB',
        countryName: 'United Kingdom',
        currency: 'GBP',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: false,
        maxShortStayDays: 90,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 20,
        vatRate: 20,
        tourismTaxRate: 0,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'MAX_5_WEEKS',
        contractRules: 'COMMON_LAW',
        complianceScore: 88,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'London 90-day Airbnb limit. Rent a Room scheme £7,500 exemption.',
      },
      {
        countryCode: 'DE',
        countryName: 'Germany',
        currency: 'EUR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 25,
        vatRate: 19,
        tourismTaxRate: 5,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'MAX_3_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 80,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'Zweckentfremdungsverbot in Berlin/Munich. Rental law heavily tenant-favored.',
      },
      {
        countryCode: 'NL',
        countryName: 'Netherlands',
        currency: 'EUR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        maxShortStayDays: 60,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 15,
        vatRate: 21,
        tourismTaxRate: 7,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 78,
        corporateHousingDemand: 'HIGH',
        notes: 'Amsterdam 60-day limit, registration required.',
      },
      {
        countryCode: 'FR',
        countryName: 'France',
        currency: 'EUR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        maxShortStayDays: 120,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 20,
        vatRate: 20,
        tourismTaxRate: 3,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_1_MONTH',
        contractRules: 'CIVIL_LAW',
        complianceScore: 75,
        corporateHousingDemand: 'HIGH',
        notes: 'Paris 120-day limit. LMNP/LMP meublé régime fiscaux.',
      },
      {
        countryCode: 'ES',
        countryName: 'Spain',
        currency: 'EUR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 24,
        vatRate: 10,
        tourismTaxRate: 4,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 72,
        corporateHousingDemand: 'HIGH',
        notes: 'Autonomous community licenses required. Barcelona strict zoning.',
      },
      {
        countryCode: 'PT',
        countryName: 'Portugal',
        currency: 'EUR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 28,
        vatRate: 23,
        tourismTaxRate: 2,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 78,
        corporateHousingDemand: 'HIGH',
        notes: 'AL (Alojamento Local) license. NHR tax regime for foreigners.',
      },
      {
        countryCode: 'IT',
        countryName: 'Italy',
        currency: 'EUR',
        taxSystem: 'FLAT_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        maxShortStayDays: 30,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 21,
        vatRate: 10,
        tourismTaxRate: 5,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_3_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 68,
        corporateHousingDemand: 'HIGH',
        notes: 'Cedolare secca flat tax 21%. CIR code required for tourists.',
      },
      {
        countryCode: 'GR',
        countryName: 'Greece',
        currency: 'EUR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 15,
        vatRate: 24,
        tourismTaxRate: 4,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 70,
        corporateHousingDemand: 'MEDIUM',
        notes: 'AADE registration required. Golden Visa drives foreign investment.',
      },
      {
        countryCode: 'CH',
        countryName: 'Switzerland',
        currency: 'CHF',
        taxSystem: 'FEDERAL_STATE',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 35,
        vatRate: 7.7,
        tourismTaxRate: 3,
        evictionProcessType: 'JUDICIAL_FAST',
        depositRules: 'MAX_3_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 90,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'Very high corporate housing for expats. Cantonal tax variations.',
      },
      // ── Turkey ────────────────────────────────────────────────────────────
      {
        countryCode: 'TR',
        countryName: 'Turkey',
        currency: 'TRY',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        maxShortStayDays: 100,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 20,
        vatRate: 20,
        tourismTaxRate: 2,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'STRICT_MAX_3_MONTHS',
        contractRules: 'CIVIL_LAW',
        complianceScore: 90,
        corporateHousingDemand: 'HIGH',
        complianceModel: '7464',
        notes: 'Law 7464 requires 100% katmalikleri consent + tourism license + KABİS registration.',
      },
      // ── Middle East ───────────────────────────────────────────────────────
      {
        countryCode: 'AE',
        countryName: 'UAE',
        currency: 'AED',
        taxSystem: 'TERRITORIAL_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 0,
        vatRate: 5,
        tourismTaxRate: 10,
        evictionProcessType: 'ADMINISTRATIVE',
        depositRules: 'MAX_5_PERCENT',
        contractRules: 'CIVIL_LAW',
        complianceScore: 92,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'DTCM license for short-term. No personal income tax. Dubai huge expat demand.',
      },
      {
        countryCode: 'SA',
        countryName: 'Saudi Arabia',
        currency: 'SAR',
        taxSystem: 'TERRITORIAL_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 5,
        vatRate: 15,
        tourismTaxRate: 5,
        evictionProcessType: 'ADMINISTRATIVE',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'SHARIA_LAW',
        complianceScore: 80,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'Vision 2030 driving massive corporate housing demand. GOSI regulations.',
      },
      {
        countryCode: 'QA',
        countryName: 'Qatar',
        currency: 'QAR',
        taxSystem: 'TERRITORIAL_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 5,
        vatRate: 0,
        tourismTaxRate: 5,
        evictionProcessType: 'ADMINISTRATIVE',
        depositRules: 'MAX_1_MONTH',
        contractRules: 'CIVIL_LAW',
        complianceScore: 85,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'No VAT. Large expat workforce. FIFA World Cup legacy demand for serviced apts.',
      },
      // ── Asia-Pacific ──────────────────────────────────────────────────────
      {
        countryCode: 'AU',
        countryName: 'Australia',
        currency: 'AUD',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: false,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 10,
        vatRate: 10,
        tourismTaxRate: 0,
        evictionProcessType: 'JUDICIAL_FAST',
        depositRules: 'STATE_DEPENDENT_MAX_4_WEEKS',
        contractRules: 'COMMON_LAW',
        complianceScore: 87,
        corporateHousingDemand: 'HIGH',
        notes: 'GST 10%. State-based legislation. Strong corporate travel market.',
      },
      {
        countryCode: 'SG',
        countryName: 'Singapore',
        currency: 'SGD',
        taxSystem: 'FLAT_TAX',
        shortStayAllowed: false,
        licenseRequired: true,
        maxShortStayDays: 0,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 15,
        vatRate: 9,
        tourismTaxRate: 0,
        evictionProcessType: 'JUDICIAL_FAST',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'COMMON_LAW',
        complianceScore: 88,
        corporateHousingDemand: 'VERY_HIGH',
        notes: 'Airbnb banned. Min 3-month rental for private properties. Massive corporate demand.',
      },
      {
        countryCode: 'JP',
        countryName: 'Japan',
        currency: 'JPY',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        maxShortStayDays: 180,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 20,
        vatRate: 10,
        tourismTaxRate: 2,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'TRADITIONAL_SHIKIKIN',
        contractRules: 'CIVIL_LAW',
        complianceScore: 82,
        corporateHousingDemand: 'HIGH',
        notes: 'Minpaku law — 180-day cap. Shikikin (key money) deposit system.',
      },
      {
        countryCode: 'KR',
        countryName: 'South Korea',
        currency: 'KRW',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: true,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 22,
        vatRate: 10,
        tourismTaxRate: 3,
        evictionProcessType: 'JUDICIAL_MEDIUM',
        depositRules: 'JEONSE_OR_MONTHLY',
        contractRules: 'CIVIL_LAW',
        complianceScore: 80,
        corporateHousingDemand: 'HIGH',
        notes: 'Unique Jeonse (lump-sum deposit) system. Corporate housing strong in Seoul.',
      },
      {
        countryCode: 'IN',
        countryName: 'India',
        currency: 'INR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: false,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 30,
        vatRate: 18,
        tourismTaxRate: 12,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_3_MONTHS',
        contractRules: 'COMMON_LAW',
        complianceScore: 60,
        corporateHousingDemand: 'HIGH',
        notes: 'Rapidly growing serviced apartment market. IT sector drives corporate housing.',
      },
      {
        countryCode: 'PK',
        countryName: 'Pakistan',
        currency: 'PKR',
        taxSystem: 'INCOME_TAX',
        shortStayAllowed: true,
        licenseRequired: false,
        corporateHousingAllowed: true,
        masterLeaseAvailable: true,
        withholdingTaxRate: 15,
        vatRate: 17,
        tourismTaxRate: 5,
        evictionProcessType: 'JUDICIAL_LENGTHY',
        depositRules: 'MAX_2_MONTHS',
        contractRules: 'COMMON_LAW',
        complianceScore: 50,
        corporateHousingDemand: 'MEDIUM',
        notes: 'Emerging market. Embassy and corporate housing in Islamabad.',
      },
    ];

    for (const policy of countries) {
      this.policies.set(policy.countryCode, policy);
    }
  }
}

export const multiCountryIntelligenceEngine = MultiCountryIntelligenceEngine.getInstance();
