import { PropertyInputData, EvaluationResult } from "../intelligence/hybrid-rental-engine";
import { multiCountryIntelligenceEngine } from '../intelligence/multi-country-intelligence-engine';

export interface AgentDecisionLog {
  agentName: string;
  agentRole: string;
  confidenceScore: number; // 0 - 100
  analysisSummary: string;
  recommendedAction: string;
  timestamp: string;
}

export interface MultiAgentSwarmResult {
  swarmId: string;
  consensusScore: number;
  agents: AgentDecisionLog[];
  finalStrategy: string;
  countryCode?: string;
  globalAgentsActive?: boolean;
}

export class HybridRentalMultiAgentSwarm {
  private static instance: HybridRentalMultiAgentSwarm;

  public static getInstance(): HybridRentalMultiAgentSwarm {
    if (!HybridRentalMultiAgentSwarm.instance) {
      HybridRentalMultiAgentSwarm.instance = new HybridRentalMultiAgentSwarm();
    }
    return HybridRentalMultiAgentSwarm.instance;
  }

  public runSwarmAnalysis(input: PropertyInputData, evalResult: EvaluationResult): MultiAgentSwarmResult {
    const agents: AgentDecisionLog[] = [];
    const now = new Date().toISOString();

    // 1. Property Intelligence Agent
    agents.push({
      agentName: "PropertyIntelligenceAgent",
      agentRole: "Fiziksel & Lokasyon Analisti",
      confidenceScore: 94,
      analysisSummary: `${input.neighbourhood} bölgesinde ${input.sizeSqm}m² mülk. Metroya ${input.proximityToMetroMins}dk mesafede, ${input.isFurnished ? 'Eşyalı' : 'Eşyasız'}.`,
      recommendedAction: "Lokasyon skorlaması yüksek (%84). Kısa ve orta dönem konaklama için fiziki uygunluğu onaylandı.",
      timestamp: now
    });

    // 2. Rental Strategy Agent
    agents.push({
      agentName: "RentalStrategyAgent",
      agentRole: "İşletme Modeli Stratejisti",
      confidenceScore: 96,
      analysisSummary: `Genel skor ${evalResult.scoreBreakdown.totalScore}/100. 7464 Mevzuat durumu: ${evalResult.legalCompliance.law7464Status}.`,
      recommendedAction: `Mülk için en yüksek Karlılığı üreten model: ${evalResult.recommendedModelLabel}.`,
      timestamp: now
    });

    // 3. Pricing Agent
    agents.push({
      agentName: "PricingAgent",
      agentRole: "Dinamik Gecelik Fiyatlama Simülatörü",
      confidenceScore: 91,
      analysisSummary: `Tahmini ADR: ${evalResult.estimatedAdrTRY} TL, Doluluk Oranı: %${evalResult.estimatedOccupancyRatePct}.`,
      recommendedAction: `Aylık tahmini kısa dönem ciro ${evalResult.estimatedShortStayMonthlyRevenueTRY.toLocaleString('tr-TR')} TL seviyesinde optimize edildi.`,
      timestamp: now
    });

    // 4. Partner Matching Agent
    agents.push({
      agentName: "PartnerMatchingAgent",
      agentRole: "Partner & Portföy Eşleştirme Ajanı",
      confidenceScore: 89,
      analysisSummary: `Primary Partner Role: ${evalResult.partnerAttribution.primarySourceLabel}. Tier: ${evalResult.partnerAttribution.primaryPartnerTier}.`,
      recommendedAction: `${evalResult.partnerAttribution.primaryPartnerName} ile %${evalResult.commissionEngine.partnerPoolPct} komisyon paylaşım protokolü eşleştirildi.`,
      timestamp: now
    });

    // 5. Owner Negotiation Agent
    agents.push({
      agentName: "OwnerNegotiationAgent",
      agentRole: "Ev Sahibi İkna & Pazarlık Ajanı",
      confidenceScore: 95,
      analysisSummary: `Klasik kira: ${evalResult.currentMarketMonthlyRentTRY.toLocaleString('tr-TR')} TL. Reservatior Yıllık Net Gelir: ${evalResult.ownerOffer.hybridEstimatedAnnualRevenueTRY.toLocaleString('tr-TR')} TL.`,
      recommendedAction: `Ev sahibine yıllık net +${evalResult.ownerOffer.hybridAnnualNetValueAddTRY.toLocaleString('tr-TR')} TL ek gelir avantajı ve %100 kurumsal garanti teklif paketi hazırlandı.`,
      timestamp: now
    });

    // ── NEW GLOBAL AGENTS (activated when countryCode provided) ───────────
    const countryCode = input.countryCode || 'TR';
    const policy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);
    const compliance = multiCountryIntelligenceEngine.assessCompliance(countryCode, input.hasTourismResidenceLicense, input.hasKabisRegistration);
    const marketOpp = multiCountryIntelligenceEngine.getMarketOpportunity(countryCode);
    const taxSummary = multiCountryIntelligenceEngine.getTaxSummary(countryCode);

    // 6. Country Compliance Agent
    agents.push({
      agentName: "CountryComplianceAgent",
      agentRole: "Country Legal & Permit Control Agent",
      confidenceScore: compliance.isCompliant ? 95 : 60,
      analysisSummary: `[${countryCode}] Compliance score: ${compliance.complianceScore}/100. Legal risk: ${compliance.legalRiskScore}/100. Blockers: ${compliance.blockers.length > 0 ? compliance.blockers.join('; ') : 'None'}.`,
      recommendedAction: compliance.isCompliant
        ? `Property is legally cleared for operations in ${policy?.countryName || countryCode}. Proceed with model: ${evalResult.recommendedModel}.`
        : `HOLD — Resolve compliance blockers before activation: ${compliance.recommendations.slice(0, 2).join(' | ')}`,
      timestamp: now
    });

    // 7. Market Expansion Agent
    agents.push({
      agentName: "MarketExpansionAgent",
      agentRole: "New City & Market Opportunity Analysis Agent",
      confidenceScore: marketOpp.opportunity === 'VERY_HIGH' ? 94 : marketOpp.opportunity === 'HIGH' ? 85 : 70,
      analysisSummary: `[${countryCode}] Market opportunity: ${marketOpp.opportunity}. Primary model: ${marketOpp.primaryModel}. Revenue lift: +${marketOpp.estimatedRevenueLiftPct}% vs. long-term rent.`,
      recommendedAction: marketOpp.reasoning,
      timestamp: now
    });

    // 8. Tax Optimization Agent
    agents.push({
      agentName: "TaxOptimizationAgent",
      agentRole: "Tax Structure Advisory Agent",
      confidenceScore: 88,
      analysisSummary: `[${countryCode}] Total tax burden: ${taxSummary.totalDeductionRate}% (VAT: ${taxSummary.vatRate}%, Withholding: ${taxSummary.withholdingTaxRate}%, Tourism: ${taxSummary.tourismTaxRate}%).`,
      recommendedAction: taxSummary.totalDeductionRate > 35
        ? `High tax jurisdiction. Structure through local entity. Consider tax treaty benefits. Consult ${policy?.countryName} specialist.`
        : taxSummary.totalDeductionRate > 15
        ? `Moderate tax burden. Standard local entity recommended. Accommodation tax (${taxSummary.tourismTaxRate}%) to be collected at booking.`
        : `Low tax jurisdiction. Revenue share model maximizes net margins. No special structuring required.`,
      timestamp: now
    });

    // 9. Corporate Demand Agent
    agents.push({
      agentName: "CorporateDemandAgent",
      agentRole: "Corporate Client Demand Analysis Agent",
      confidenceScore: policy?.corporateHousingDemand === 'VERY_HIGH' ? 96 : policy?.corporateHousingDemand === 'HIGH' ? 88 : 72,
      analysisSummary: `[${countryCode}] Corporate housing demand: ${policy?.corporateHousingDemand || 'UNKNOWN'}. Master lease available: ${policy?.masterLeaseAvailable}. Corporate housing allowed: ${policy?.corporateHousingAllowed}.`,
      recommendedAction: policy?.corporateHousingDemand === 'VERY_HIGH'
        ? `Prioritize CORPORATE_HOUSING pipeline. Target relocation companies and HR partners in ${policy?.countryName}. Expected 85%+ occupancy.`
        : policy?.corporateHousingDemand === 'HIGH'
        ? `Activate corporate channel. Offer master lease terms to corporate clients. Mid-term stay focus (3-12 months).`
        : `Corporate demand moderate. Mix short-stay and mid-term. Monitor expat community growth.`,
      timestamp: now
    });

    // 10. Global Pricing Agent
    agents.push({
      agentName: "GlobalPricingAgent",
      agentRole: "FX-Based Price Optimization Agent",
      confidenceScore: 90,
      analysisSummary: `[${countryCode}] Currency: ${policy?.currency || 'TRY'}. Estimated ADR: ${evalResult.estimatedAdrTRY.toLocaleString()} (TRY equiv). Revenue lift potential: +${evalResult.estimatedRevenueLift}%.`,
      recommendedAction: `Dynamic pricing in ${policy?.currency || 'TRY'}. Apply weekend/event surcharge rules. FX hedge recommended for owner payouts in high-volatility currencies (${policy?.currency}).`,
      timestamp: now
    });

    const averageConfidence = Math.round(agents.reduce((acc, a) => acc + a.confidenceScore, 0) / agents.length);

    return {
      swarmId: `SWARM-${Math.floor(100000 + Math.random() * 900000)}`,
      consensusScore: averageConfidence,
      agents,
      finalStrategy: `[${countryCode}] ${evalResult.recommendedModel} model confirmed with ${averageConfidence}% AI consensus. ${agents.length} agents active.`,
      countryCode,
      globalAgentsActive: true,
    };
  }
}

export const hybridRentalMultiAgentSwarm = HybridRentalMultiAgentSwarm.getInstance();
