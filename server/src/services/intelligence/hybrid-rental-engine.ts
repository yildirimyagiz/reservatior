import fs from 'fs';
import path from 'path';
import { partnerRevenueEngine, PartnerRole, PartnerAttributionResult, CommissionEngineResult, AIProposalResult } from './partner-revenue-engine';
import { multiCountryIntelligenceEngine, CountryRentalPolicy } from './multi-country-intelligence-engine';

export interface PropertyInputData {
  propertyId?: string;
  title?: string;
  neighbourhood: string; // e.g. "Beyoğlu", "Fatih", "Beşiktaş", "Kadıköy", "Şişli"
  roomType: 'Entire home/apt' | 'Private room' | 'Shared room';
  accommodates: number;
  bedrooms: number;
  bathrooms: number;
  sizeSqm: number;
  buildingAge: number;
  isFurnished: boolean;
  hasElevator: boolean;
  hasParking: boolean;
  hasPoolOrGym: boolean;
  proximityToMetroMins: number;
  proximityToAirportMins: number;
  
  // Legal & Regulatory Flags (Turkish Law 7464)
  hasBuildingConsent100Pct: boolean; // 100% kat malikleri rıza belgesi
  hasTourismResidenceLicense: boolean; // Turizm konut kiralama izin belgesi
  hasKabisRegistration: boolean; // Emniyet Kimlik Bildirim Sistemi entegrasyonu
  
  // Custom baseline price overrides if available
  customLongTermRentMonthlyTRY?: number;

  // ── Global Multi-Country Support ────────────────────────────────────────
  countryCode?: string;        // ISO 3166-1 alpha-2. Defaults to 'TR'
  city?: string;               // City for non-TR evaluations
  customAdrLocal?: number;     // Override ADR in local currency
  customOccupancyPct?: number; // Override occupancy %

  // Partner Attribution & Commission Overrides
  primaryPartnerRole?: PartnerRole;
  primaryPartnerId?: string;
}

export interface ScoreBreakdown {
  locationDemandScore: number;    // %25
  shortStayRevenueScore: number;  // %25
  corporateDemandScore: number;   // %20
  longTermStabilityScore: number; // %15
  operationalCostScore: number;   // %10
  riskScore: number;              // %5
  totalScore: number;             // 0-100
}

export type RecommendedModelType =
  | 'REVENUE_SHARE'
  | 'CORPORATE_MASTER_LEASE'
  | 'SERVICED_APARTMENT'
  | 'CORPORATE_HOUSING'
  | 'MASTER_LEASE'
  | 'REJECT';

export interface OwnerEconomics {
  classicLongTermMonthlyNetTRY: number;
  classicLongTermAnnualNetTRY: number;
  classicVacancyRiskCostAnnualTRY: number;
  classicEvictionRiskFactorPct: number;
  
  // Hybrid Proposal
  hybridMinimumGuaranteedMonthlyTRY: number;
  hybridPerformanceSharePct: number;
  hybridEstimatedAnnualRevenueTRY: number;
  hybridAnnualNetValueAddTRY: number; // Advantage over classic rent
}

export interface ReservatiorEconomics {
  expectedGrossAnnualRevenueTRY: number;
  ownerRentalCostAnnualTRY: number; // Guaranteed minimum rent paid to owner
  ownerPerformancePayoutAnnualTRY: number;
  operatingCostAnnualTRY: number; // Cleaning, laundry, maintenance, SaaS, channel manager
  taxAndLegalCostAnnualTRY: number; // %2 accommodation tax, KDV, local fees
  grossMarginAnnualTRY: number;
  grossMarginPct: number;
  netMarginAnnualTRY: number;
  netMarginPct: number;
}

export interface LegalComplianceStatus {
  isFullyCompliant: boolean;
  law7464Status: 'APPROVED' | 'MISSING_CONSENT' | 'LICENSE_PENDING';
  blockerReasons: string[];
  recommendations: string[];
}

export interface EvaluationResult {
  propertyId: string;
  location: string;
  scoreBreakdown: ScoreBreakdown;
  recommendedModel: RecommendedModelType;
  recommendedModelLabel: string;
  modelExplanation: string;

  // ── Global Country Intelligence ──────────────────────────────────────────
  countryCode: string;
  currency: string;
  countryComplianceScore: number;  // 0-100
  legalRiskScore: number;          // 0-100 (higher = riskier)
  estimatedRevenueLift: number;    // % uplift over long-term rent
  marketOpportunity: string;
  countryPolicy?: CountryRentalPolicy;

  // Projections (primary currency = local, secondary = TRY for TR)
  currentMarketMonthlyRentTRY: number;
  estimatedShortStayMonthlyRevenueTRY: number;
  estimatedCorporateMonthlyRevenueTRY: number;
  estimatedOccupancyRatePct: number;
  estimatedAdrTRY: number; // Average Daily Rate

  ownerOffer: OwnerEconomics;
  reservatiorEconomics: ReservatiorEconomics;
  legalCompliance: LegalComplianceStatus;

  // Partner Revenue & AI Proposal Integration
  partnerAttribution: PartnerAttributionResult;
  commissionEngine: CommissionEngineResult;
  aiProposalGenerator: AIProposalResult;

  createdAt: string;
}

// Regional Benchmark Database loaded from datasets / statistical priors
const NEIGHBOURHOOD_BENCHMARKS: Record<string, { adrTRY: number; occupancyPct: number; corporateScore: number; longTermRentSqmTRY: number }> = {
  "Beyoğlu": { adrTRY: 2850, occupancyPct: 78, corporateScore: 88, longTermRentSqmTRY: 450 },
  "Beşiktaş": { adrTRY: 3400, occupancyPct: 82, corporateScore: 95, longTermRentSqmTRY: 550 },
  "Kadıköy": { adrTRY: 2600, occupancyPct: 84, corporateScore: 90, longTermRentSqmTRY: 480 },
  "Fatih": { adrTRY: 2400, occupancyPct: 75, corporateScore: 70, longTermRentSqmTRY: 380 },
  "Şişli": { adrTRY: 3100, occupancyPct: 80, corporateScore: 94, longTermRentSqmTRY: 520 },
  "Sarıyer": { adrTRY: 4500, occupancyPct: 70, corporateScore: 85, longTermRentSqmTRY: 650 },
  "Üsküdar": { adrTRY: 2200, occupancyPct: 76, corporateScore: 78, longTermRentSqmTRY: 400 },
  "Bakırköy": { adrTRY: 2500, occupancyPct: 74, corporateScore: 82, longTermRentSqmTRY: 420 },
  "Ataşehir": { adrTRY: 2700, occupancyPct: 79, corporateScore: 92, longTermRentSqmTRY: 460 },
  "DEFAULT": { adrTRY: 2100, occupancyPct: 72, corporateScore: 70, longTermRentSqmTRY: 350 }
};

export class HybridRentalEngine {
  private static instance: HybridRentalEngine;

  public static getInstance(): HybridRentalEngine {
    if (!HybridRentalEngine.instance) {
      HybridRentalEngine.instance = new HybridRentalEngine();
    }
    return HybridRentalEngine.instance;
  }

  public evaluateProperty(input: PropertyInputData): EvaluationResult {
    // ── Country Policy Resolution ────────────────────────────────────────────
    const countryCode = (input.countryCode || 'TR').toUpperCase();
    const countryPolicy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);
    const currency = countryPolicy?.currency || 'TRY';
    const marketOpportunityResult = multiCountryIntelligenceEngine.getMarketOpportunity(countryCode);
    const complianceResult = multiCountryIntelligenceEngine.assessCompliance(
      countryCode,
      input.hasTourismResidenceLicense,
      input.hasKabisRegistration
    );
    const countryComplianceScore = complianceResult.complianceScore;
    const legalRiskScore = complianceResult.legalRiskScore;

    const neighbourhoodKey = Object.keys(NEIGHBOURHOOD_BENCHMARKS).find(
      k => k.toLowerCase() === (input.neighbourhood || '').toLowerCase()
    ) || "DEFAULT";
    const benchmark = NEIGHBOURHOOD_BENCHMARKS[neighbourhoodKey];

    // 1. Calculate Revenue Projections
    const sizeMultiplier = Math.max(0.7, input.sizeSqm / 70);
    const roomMultiplier = input.accommodates >= 4 ? 1.25 : input.accommodates >= 2 ? 1.0 : 0.85;
    const amenityMultiplier = (input.isFurnished ? 1.15 : 0.9) * 
                              (input.hasElevator ? 1.05 : 0.95) * 
                              (input.hasParking ? 1.08 : 1.0) * 
                              (input.hasPoolOrGym ? 1.12 : 1.0);

    // Adjusted ADR & Occupancy
    const adrTRY = Math.round(benchmark.adrTRY * roomMultiplier * amenityMultiplier);
    const occupancyRatePct = Math.min(92, Math.max(50, benchmark.occupancyPct + (input.proximityToMetroMins <= 5 ? 5 : -3)));
    
    // Monthly Short Stay Revenue
    const shortStayMonthlyGrossTRY = Math.round((adrTRY * 30.5 * (occupancyRatePct / 100)));
    
    // Monthly Long Term Market Rent
    const longTermMonthlyMarketRentTRY = input.customLongTermRentMonthlyTRY || 
      Math.round(benchmark.longTermRentSqmTRY * input.sizeSqm * (input.isFurnished ? 1.2 : 1.0));
      
    // Monthly Corporate Revenue Projections (Stable 85% occupancy, premium corporate rate)
    const corporateMonthlyGrossTRY = Math.round(shortStayMonthlyGrossTRY * 0.88);

    // 2. Property Scoring Engine (0 - 100)
    // Weight Distribution:
    // Location Demand Score: 25%
    // Short Stay Revenue Potential: 25%
    // Corporate Demand Score: 20%
    // Long Term Rental Stability: 15%
    // Operational Cost Score: 10%
    // Risk Score: 5%

    const locationDemandScore = Math.min(100, Math.round(
      (benchmark.corporateScore * 0.5) + 
      (input.proximityToMetroMins <= 5 ? 30 : input.proximityToMetroMins <= 15 ? 20 : 10) + 
      (input.proximityToAirportMins <= 35 ? 20 : 10)
    ));

    const revenueRatio = shortStayMonthlyGrossTRY / Math.max(1, longTermMonthlyMarketRentTRY);
    const shortStayRevenueScore = Math.min(100, Math.round(Math.max(30, revenueRatio * 45)));

    const corporateDemandScore = Math.min(100, Math.round(
      benchmark.corporateScore * (input.hasElevator ? 1.05 : 0.9) * (input.isFurnished ? 1.1 : 0.95)
    ));

    const longTermStabilityScore = Math.min(100, Math.round(
      (longTermMonthlyMarketRentTRY > 25000 ? 85 : 70) + (input.buildingAge <= 10 ? 15 : 5)
    ));

    const operationalCostScore = Math.min(100, Math.round(
      100 - (input.buildingAge > 20 ? 25 : 10) - (!input.hasElevator ? 15 : 0) - (input.sizeSqm > 150 ? 15 : 0)
    ));

    const propertyLegalScore = input.hasBuildingConsent100Pct ? 95 : 20;

    const totalScore = Math.round(
      (locationDemandScore * 0.25) +
      (shortStayRevenueScore * 0.25) +
      (corporateDemandScore * 0.20) +
      (longTermStabilityScore * 0.15) +
      (operationalCostScore * 0.10) +
      (propertyLegalScore * 0.05)
    );

    const scoreBreakdown: ScoreBreakdown = {
      locationDemandScore,
      shortStayRevenueScore,
      corporateDemandScore,
      longTermStabilityScore,
      operationalCostScore,
      riskScore: propertyLegalScore,
      totalScore
    };

    // 3. Legal & Regulatory Check (7464 Sayılı Kanun Uyum Matrisi)
    const legalCompliance: LegalComplianceStatus = {
      isFullyCompliant: input.hasBuildingConsent100Pct && input.hasTourismResidenceLicense,
      law7464Status: input.hasBuildingConsent100Pct 
        ? (input.hasTourismResidenceLicense ? 'APPROVED' : 'LICENSE_PENDING') 
        : 'MISSING_CONSENT',
      blockerReasons: [],
      recommendations: []
    };

    if (!input.hasBuildingConsent100Pct) {
      legalCompliance.blockerReasons.push("7464 Sayılı Kanun Uyarınca: Tüm kat maliklerinden oybirliği rıza kararı alınmamış.");
      legalCompliance.recommendations.push("Apartman / Site yönetimi rıza yazısı tamamlanmalı veya kurumsal kiralama (Master Lease) modeline yönlenilmeli.");
    }
    if (!input.hasTourismResidenceLicense) {
      legalCompliance.recommendations.push("Turizm amaçlı konut kiralama izin belgesi başvurusu E-Devlet üzerinden tamamlanmalıdır.");
    }

    // 4. Model Decision Matrix — Country-Aware
    let recommendedModel: RecommendedModelType = 'REJECT';
    let recommendedModelLabel = '';
    let modelExplanation = '';

    if (countryCode === 'TR') {
      // ── Turkey path: 7464 law logic preserved ──────────────────────────────
      if (totalScore >= 80 && input.hasBuildingConsent100Pct) {
        recommendedModel = 'REVENUE_SHARE';
        recommendedModelLabel = 'Revenue Share Model (%70 Performans + Garanti)';
        modelExplanation = 'Yüksek kısa ve orta dönem turist/expat konaklama potansiyeline sahip. Ev sahibine taban garanti kira sunularak kalan cirodan %20-%30 komisyon payı alınması en yüksek karı üretir.';
      } else if (totalScore >= 50) {
        recommendedModel = 'CORPORATE_MASTER_LEASE';
        recommendedModelLabel = 'Corporate Master Lease Model (Sabit Marjlı Kurumsal Kiralama)';
        modelExplanation = 'Orta ve yüksek kurumsal expat talebine uygun. Reservatior mülkü kurumsal kontratla kiralar, expat ve şirket çalışanlarına alt kiralama (sub-lease) yaparak sabit marj elde eder.';
      } else {
        recommendedModel = 'REJECT';
        recommendedModelLabel = 'Reject / Do Not Operate (Sisteme Almama)';
        modelExplanation = 'Yetersiz lokasyon talebi, yüksek operasyon maliyeti veya kat malikleri rıza eksikliği nedeniyle Reservatior standartlarını karşılamamaktadır.';
      }
    } else if (countryCode === 'SG' || (countryPolicy && !countryPolicy.shortStayAllowed)) {
      // ── Short-stay banned (e.g. Singapore) ────────────────────────────────
      if (totalScore >= 55 && countryPolicy?.corporateHousingAllowed) {
        recommendedModel = 'CORPORATE_HOUSING';
        recommendedModelLabel = `Corporate Housing Model (${countryPolicy?.countryName || countryCode})`;
        modelExplanation = `Short-term rental not permitted in ${countryPolicy?.countryName || countryCode}. Corporate housing with minimum ${countryPolicy?.maxShortStayDays ? 'long-term' : '3-month'} contracts is the primary viable model.`;
      } else {
        recommendedModel = 'REJECT';
        recommendedModelLabel = 'Not Viable — Short-stay Banned';
        modelExplanation = `Short-term rentals are prohibited in ${countryPolicy?.countryName || countryCode} and property score is insufficient for corporate housing.`;
      }
    } else if (marketOpportunityResult.primaryModel === 'CORPORATE_HOUSING' && totalScore >= 60) {
      recommendedModel = 'CORPORATE_HOUSING';
      recommendedModelLabel = `Corporate Housing Model — ${marketOpportunityResult.opportunity} Demand`;
      modelExplanation = marketOpportunityResult.reasoning;
    } else if (countryPolicy?.masterLeaseAvailable && totalScore >= 70) {
      recommendedModel = 'MASTER_LEASE';
      recommendedModelLabel = `Master Lease Model (${currency})`;
      modelExplanation = `Master lease available in ${countryPolicy?.countryName || countryCode}. Stable guaranteed income with ${countryPolicy?.withholdingTaxRate}% withholding tax.`;
    } else if (totalScore >= 75 && countryPolicy?.shortStayAllowed) {
      recommendedModel = 'REVENUE_SHARE';
      recommendedModelLabel = `Revenue Share Model (${currency})`;
      modelExplanation = marketOpportunityResult.reasoning;
    } else if (totalScore >= 50) {
      recommendedModel = 'SERVICED_APARTMENT';
      recommendedModelLabel = `Serviced Apartment Model (${currency})`;
      modelExplanation = `Medium opportunity in ${countryPolicy?.countryName || countryCode}. Serviced apartment format with mid-term stays recommended.`;
    } else {
      recommendedModel = 'REJECT';
      recommendedModelLabel = 'Not Viable for Global Hybrid Rental OS';
      modelExplanation = `Property score (${totalScore}/100) insufficient. Compliance score: ${countryComplianceScore}/100. Legal risk: ${legalRiskScore}/100.`;
    }

    // 5. Owner Economics Calculation
    const classicVacancyRiskCostAnnualTRY = Math.round(longTermMonthlyMarketRentTRY * 1.5); // Average 1.5 months vacant per year
    const classicEvictionRiskFactorPct = 12; // 12% legal eviction delay risk in Turkey
    const classicLongTermAnnualNetTRY = (longTermMonthlyMarketRentTRY * 12) - classicVacancyRiskCostAnnualTRY;

    // Hybrid Proposal
    const guaranteedRentTRY = Math.round(longTermMonthlyMarketRentTRY * 0.90); // 90% guaranteed
    const performanceSharePct = 25; // 25% share above threshold
    const projectedGrossAnnualRevenueTRY = shortStayMonthlyGrossTRY * 12;
    const ownerPerformanceBonusTRY = Math.max(0, Math.round((projectedGrossAnnualRevenueTRY - (guaranteedRentTRY * 12 * 1.3)) * (performanceSharePct / 100)));
    const hybridEstimatedAnnualRevenueTRY = (guaranteedRentTRY * 12) + ownerPerformanceBonusTRY;

    const ownerOffer: OwnerEconomics = {
      classicLongTermMonthlyNetTRY: Math.round(classicLongTermAnnualNetTRY / 12),
      classicLongTermAnnualNetTRY,
      classicVacancyRiskCostAnnualTRY,
      classicEvictionRiskFactorPct,
      hybridMinimumGuaranteedMonthlyTRY: guaranteedRentTRY,
      hybridPerformanceSharePct: performanceSharePct,
      hybridEstimatedAnnualRevenueTRY,
      hybridAnnualNetValueAddTRY: Math.max(0, hybridEstimatedAnnualRevenueTRY - classicLongTermAnnualNetTRY)
    };

    // 6. Reservatior Economics Calculation
    const expectedGrossAnnualRevenueTRY = projectedGrossAnnualRevenueTRY;
    const ownerRentalCostAnnualTRY = guaranteedRentTRY * 12;
    const ownerPerformancePayoutAnnualTRY = ownerPerformanceBonusTRY;
    const operatingCostAnnualTRY = Math.round(expectedGrossAnnualRevenueTRY * 0.15); // Cleaning, laundry, maintenance
    const taxAndLegalCostAnnualTRY = Math.round(expectedGrossAnnualRevenueTRY * 0.08); // Accommodation tax (%2), KDV, legal
    const totalExpensesAnnualTRY = ownerRentalCostAnnualTRY + ownerPerformancePayoutAnnualTRY + operatingCostAnnualTRY + taxAndLegalCostAnnualTRY;

    const grossMarginAnnualTRY = expectedGrossAnnualRevenueTRY - (ownerRentalCostAnnualTRY + ownerPerformancePayoutAnnualTRY);
    const grossMarginPct = Math.round((grossMarginAnnualTRY / expectedGrossAnnualRevenueTRY) * 100);
    const netMarginAnnualTRY = expectedGrossAnnualRevenueTRY - totalExpensesAnnualTRY;
    const netMarginPct = Math.round((netMarginAnnualTRY / expectedGrossAnnualRevenueTRY) * 100);

    const reservatiorEconomics: ReservatiorEconomics = {
      expectedGrossAnnualRevenueTRY,
      ownerRentalCostAnnualTRY,
      ownerPerformancePayoutAnnualTRY,
      operatingCostAnnualTRY,
      taxAndLegalCostAnnualTRY,
      grossMarginAnnualTRY,
      grossMarginPct,
      netMarginAnnualTRY,
      netMarginPct
    };

    // 7. Partner Revenue Engine & AI Proposal Generation
    const partnerRole: PartnerRole = input.primaryPartnerRole || "PROPERTY_ACQUISITION";
    const partnerId = input.primaryPartnerId || "PARTNER-001";

    const { partnerAttribution, commissionEngine, aiProposalGenerator } = partnerRevenueEngine.calculateCommissionAndAttribution(
      input,
      recommendedModel,
      expectedGrossAnnualRevenueTRY,
      longTermMonthlyMarketRentTRY,
      hybridEstimatedAnnualRevenueTRY,
      partnerRole,
      partnerId
    );

    const estimatedRevenueLift = Math.round(
      ((shortStayMonthlyGrossTRY - longTermMonthlyMarketRentTRY) / Math.max(1, longTermMonthlyMarketRentTRY)) * 100
    );

    return {
      propertyId: input.propertyId || `PROP-${Math.floor(100000 + Math.random() * 900000)}`,
      location: input.city ? `${input.neighbourhood || input.city}, ${countryPolicy?.countryName || countryCode}` : `${input.neighbourhood}, İstanbul`,
      scoreBreakdown,
      recommendedModel,
      recommendedModelLabel,
      modelExplanation,
      // ── Global Country Intelligence Fields ──────────────────────────────────
      countryCode,
      currency,
      countryComplianceScore,
      legalRiskScore,
      estimatedRevenueLift,
      marketOpportunity: marketOpportunityResult.opportunity,
      countryPolicy,
      // Projections
      currentMarketMonthlyRentTRY: longTermMonthlyMarketRentTRY,
      estimatedShortStayMonthlyRevenueTRY: shortStayMonthlyGrossTRY,
      estimatedCorporateMonthlyRevenueTRY: corporateMonthlyGrossTRY,
      estimatedOccupancyRatePct: occupancyRatePct,
      estimatedAdrTRY: adrTRY,
      ownerOffer,
      reservatiorEconomics,
      legalCompliance,
      partnerAttribution,
      commissionEngine,
      aiProposalGenerator,
      createdAt: new Date().toISOString()
    };
  }
}

export const hybridRentalEngine = HybridRentalEngine.getInstance();
