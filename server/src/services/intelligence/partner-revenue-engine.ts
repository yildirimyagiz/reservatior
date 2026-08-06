import { PropertyInputData, EvaluationResult } from "./hybrid-rental-engine";
import { multiCountryIntelligenceEngine } from './multi-country-intelligence-engine';

export type PartnerRole =
  // ── Original Roles (Turkey) ───────────────────────────────────────────────
  | "PROPERTY_ACQUISITION"   // Mülk sahibini ve portföyü kazandıran
  | "TENANT_ACQUISITION"     // Kiracı / müşteri getiren
  | "TRANSACTION_MANAGER"    // İşlemi yöneten danışman
  | "COMMUNITY_REFERRAL"     // Site görevlisi, residence yönetimi
  | "CORPORATE_REFERRAL"     // Expat / Şirket insan kaynakları yönlendirmesi
  | "PORTFOLIO_MANAGER"      // Sürekli bölgesel portföy yöneten stratejik partner
  | "DIRECT_RESERVATIOR"     // Reservatior kendi reklamı / doğrudan başvuru
  // ── Global Partner Types ──────────────────────────────────────────────────
  | "REAL_ESTATE_AGENT"      // Licensed real estate agent (global)
  | "PROPERTY_MANAGER"       // Third-party property management company
  | "RELOCATION_COMPANY"     // Corporate relocation service provider
  | "CORPORATE_HR_PARTNER"   // HR department of a corporate client
  | "INVESTMENT_ADVISOR"     // Investment advisory firm or wealth manager
  | "BUILDING_MANAGER"       // On-site building or facilities manager
  | "TRAVEL_AGENCY"          // Travel agency or OTA partner
  | "LOCAL_OPERATOR";        // Local hospitality or co-hosting operator

// 5-Tier partner progression system
export type PartnerTier =
  | "REFERRAL"           // Entry level — one-time referrals
  | "SILVER"             // Active partner, 3+ deals/year
  | "GOLD"               // Established partner, 10+ deals/year
  | "PLATINUM"           // Top performer, 25+ deals or strategic markets
  | "STRATEGIC";         // Exclusive strategic alliance (white-label, JV)

export interface PartnerInfo {
  partnerId: string;
  name: string;
  role: PartnerRole;
  tier: PartnerTier;
  performanceScore: number; // 0-100
  organizationName?: string;
  countryCode?: string;      // Country this partner operates in
  currency?: string;         // Partner's preferred payout currency
  specialization?: string;   // e.g. 'corporate_housing', 'short_stay'
}

// Country-specific commission rule override
export interface PartnerCountryCommission {
  partnerId: string;
  countryCode: string;
  baseCommissionRate: number;  // %
  bonusThresholdDeals: number; // Deals/year to trigger bonus
  bonusCommissionRate: number; // % bonus above threshold
  maxCommissionRate: number;   // % cap
  currency: string;
}

export interface SplitItem {
  role: PartnerRole;
  roleLabel: string;
  partnerId: string;
  partnerName: string;
  percentage: number;
  amountTRY: number;
  explanation: string;
}

// ── Prisma Schema Exact Alignment ──────────────────────────────────────────
export interface PrismaCommissionRecord {
  amountBase: number; // Base amount for calculation
  commissionRate: number; // e.g. 10%
  platformRate: number; // e.g. 5%
  partnerRate: number; // e.g. 5%
  platformFee: number;
  partnerFee: number;
  taxAmount: number;
  commissionAmount: number;
  currency: string;
  collectionType: 'UPFRONT' | 'INSTALLMENT';
  upfrontPercent: number; // default 50%
  installmentCount: number; // default 12
  interestRate: number; // default 10%
}

export interface PrismaEscrowSplitConfig {
  agentPayoutRate: number; // default 3.00%
  reservatiorFeeRate: number; // default 4.00%
  blockageDays: number; // default 15 days
  installmentEnabled: boolean;
  upfrontPercent: number;
  installmentCount: number;
  interestRate: number;
  isActive: boolean;
}

export interface PrismaCommissionAdvance {
  isEligible: boolean;
  originalAmount: number;
  feeRate: number;
  feeAmount: number;
  payoutAmount: number;
  type: 'INSTANT' | 'INSTALLMENT';
  status: 'OFFERED' | 'ACCEPTED' | 'PAID' | 'COMPLETED';
}

export interface CommissionEngineResult {
  totalGrossRevenueTRY: number;
  totalServiceFeeCommissionTRY: number;
  reservatiorSharePct: number;
  reservatiorShareAmountTRY: number;
  partnerPoolPct: number;
  partnerPoolAmountTRY: number;
  splits: SplitItem[];
  settlementStatus: 'PENDING_APPROVAL' | 'SCHEDULED_AUTOMATIC' | 'SETTLED';
  
  // Exact Prisma Schema Mapping
  prismaCommissionRecord: PrismaCommissionRecord;
  prismaEscrowSplitConfig: PrismaEscrowSplitConfig;
  prismaCommissionAdvance: PrismaCommissionAdvance;
}

export interface PartnerAttributionResult {
  primarySourceType: PartnerRole;
  primarySourceLabel: string;
  primaryPartnerId: string;
  primaryPartnerName: string;
  primaryPartnerTier: PartnerTier;
  attributionChain: {
    role: PartnerRole;
    partnerId: string;
    partnerName: string;
    attributedAt: string;
  }[];
}

export interface AIProposalResult {
  ownerPitch: {
    headline: string;
    classicRentMonthlyTRY: number;
    hybridEstimatedAnnualTRY: number;
    netAnnualValueAddTRY: number;
    bulletPoints: string[];
    pitchSummaryText: string;
  };
  partnerProposal: {
    headline: string;
    tierName: PartnerTier;
    commissionSharePct: number;
    estimatedAnnualCommissionTRY: number;
    valueProposition: string;
  };
}

export class PartnerRevenueEngine {
  private static instance: PartnerRevenueEngine;

  public static getInstance(): PartnerRevenueEngine {
    if (!PartnerRevenueEngine.instance) {
      PartnerRevenueEngine.instance = new PartnerRevenueEngine();
    }
    return PartnerRevenueEngine.instance;
  }

  public calculateCommissionAndAttribution(
    input: PropertyInputData,
    recommendedModel: string,
    grossAnnualRevenueTRY: number,
    currentMarketMonthlyRentTRY: number,
    hybridEstimatedAnnualRevenueTRY: number,
    primaryPartnerRole: PartnerRole = "PROPERTY_ACQUISITION",
    customPartnerId: string = "PARTNER-001"
  ): {
    partnerAttribution: PartnerAttributionResult;
    commissionEngine: CommissionEngineResult;
    aiProposalGenerator: AIProposalResult;
  } {
    // 1. Determine Tier & Default Commission Share
    let primaryTier: PartnerTier = "GOLD";
    let propertyAcquisitionSharePct = 35;
    let transactionManagerSharePct = 15;
    let referralSharePct = 0;
    let reservatiorSharePct = 50;

    switch (primaryPartnerRole) {
      case "PROPERTY_ACQUISITION":
        primaryTier = "GOLD";
        propertyAcquisitionSharePct = 35;
        transactionManagerSharePct = 15;
        reservatiorSharePct = 50;
        break;
      case "COMMUNITY_REFERRAL":
        primaryTier = "REFERRAL";
        propertyAcquisitionSharePct = 0;
        referralSharePct = 20;
        transactionManagerSharePct = 20;
        reservatiorSharePct = 60;
        break;
      case "CORPORATE_REFERRAL":
        primaryTier = "SILVER";
        referralSharePct = 25;
        transactionManagerSharePct = 15;
        reservatiorSharePct = 60;
        break;
      case "PORTFOLIO_MANAGER":
        primaryTier = "STRATEGIC";
        propertyAcquisitionSharePct = 50;
        transactionManagerSharePct = 10;
        reservatiorSharePct = 40;
        break;
      case "DIRECT_RESERVATIOR":
      default:
        primaryTier = "REFERRAL";
        propertyAcquisitionSharePct = 0;
        transactionManagerSharePct = 0;
        referralSharePct = 0;
        reservatiorSharePct = 100;
        break;
    }

    // 2. Build Partner Attribution Chain
    const partnerAttribution: PartnerAttributionResult = {
      primarySourceType: primaryPartnerRole,
      primarySourceLabel: this.getRoleLabel(primaryPartnerRole),
      primaryPartnerId: customPartnerId,
      primaryPartnerName: this.getPartnerDefaultName(primaryPartnerRole),
      primaryPartnerTier: primaryTier,
      attributionChain: [
        {
          role: primaryPartnerRole,
          partnerId: customPartnerId,
          partnerName: this.getPartnerDefaultName(primaryPartnerRole),
          attributedAt: new Date().toISOString()
        }
      ]
    };

    // 3. Build Commission Split Breakdown
    const totalServiceFeeCommissionTRY = Math.round(grossAnnualRevenueTRY * 0.25);
    const splits: SplitItem[] = [];

    if (propertyAcquisitionSharePct > 0) {
      splits.push({
        role: "PROPERTY_ACQUISITION",
        roleLabel: "Portföy Kazanım Partneri (Emlak Danışmanı / Ofis)",
        partnerId: customPartnerId,
        partnerName: this.getPartnerDefaultName(primaryPartnerRole),
        percentage: propertyAcquisitionSharePct,
        amountTRY: Math.round(totalServiceFeeCommissionTRY * (propertyAcquisitionSharePct / 100)),
        explanation: "Mülk sahibini Reservatior sistemine kazandırdığı için hak edilen portföy komisyon payı."
      });
    }

    if (referralSharePct > 0) {
      splits.push({
        role: primaryPartnerRole,
        roleLabel: this.getRoleLabel(primaryPartnerRole),
        partnerId: customPartnerId,
        partnerName: this.getPartnerDefaultName(primaryPartnerRole),
        percentage: referralSharePct,
        amountTRY: Math.round(totalServiceFeeCommissionTRY * (referralSharePct / 100)),
        explanation: "Müşteri / Kiracı yönlendirmesi sağladığı için hak edilen tavsiye primi."
      });
    }

    if (transactionManagerSharePct > 0 && primaryPartnerRole !== "DIRECT_RESERVATIOR") {
      splits.push({
        role: "TRANSACTION_MANAGER",
        roleLabel: "Saha Operasyon & Kontrat Danışmanı",
        partnerId: "AGENT-OPS-102",
        partnerName: "Reservatior Saha İşlem Danışmanı",
        percentage: transactionManagerSharePct,
        amountTRY: Math.round(totalServiceFeeCommissionTRY * (transactionManagerSharePct / 100)),
        explanation: "Mülk gösterimi, anahtar teslimi ve E-Devlet sözleşme onay takibi için işlem payı."
      });
    }

    const partnerPoolPct = propertyAcquisitionSharePct + referralSharePct + (primaryPartnerRole !== "DIRECT_RESERVATIOR" ? transactionManagerSharePct : 0);
    const reservatiorAmountTRY = Math.round(totalServiceFeeCommissionTRY * (reservatiorSharePct / 100));

    splits.push({
      role: "DIRECT_RESERVATIOR",
      roleLabel: "Reservatior Platform & Risk Payı",
      partnerId: "RESERVATIOR-CORE",
      partnerName: "Reservatior Enterprise OS",
      percentage: reservatiorSharePct,
      amountTRY: reservatiorAmountTRY,
      explanation: "Yapay zeka fiyatlama, dinamik pazarlama, sigorta ve altyapı işletme payı."
    });

    // 4. Prisma Commission & Escrow Mappings
    const amountBase = grossAnnualRevenueTRY;
    const commissionRate = 25.0; // 25% total fee
    const platformRate = 25.0 * (reservatiorSharePct / 100); // e.g. 12.5%
    const partnerRate = 25.0 * (partnerPoolPct / 100); // e.g. 12.5%
    const platformFee = Math.round(amountBase * (platformRate / 100));
    const partnerFee = Math.round(amountBase * (partnerRate / 100));
    const taxAmount = Math.round(amountBase * 0.02); // 2% accommodation tax
    const commissionAmount = platformFee + partnerFee;

    const prismaCommissionRecord: PrismaCommissionRecord = {
      amountBase,
      commissionRate,
      platformRate,
      partnerRate,
      platformFee,
      partnerFee,
      taxAmount,
      commissionAmount,
      currency: "TRY",
      collectionType: "UPFRONT",
      upfrontPercent: 50.0,
      installmentCount: 12,
      interestRate: 10.0
    };

    const prismaEscrowSplitConfig: PrismaEscrowSplitConfig = {
      agentPayoutRate: partnerRate,
      reservatiorFeeRate: platformRate,
      blockageDays: 15,
      installmentEnabled: true,
      upfrontPercent: 50.0,
      installmentCount: 12,
      interestRate: 10.0,
      isActive: true
    };

    const advanceOriginalAmount = partnerFee;
    const advanceFeeRate = 5.0; // 5% advance fee
    const advanceFeeAmount = Math.round(advanceOriginalAmount * 0.05);

    const prismaCommissionAdvance: PrismaCommissionAdvance = {
      isEligible: primaryTier === "GOLD" || primaryTier === "STRATEGIC",
      originalAmount: advanceOriginalAmount,
      feeRate: advanceFeeRate,
      feeAmount: advanceFeeAmount,
      payoutAmount: advanceOriginalAmount - advanceFeeAmount,
      type: "INSTANT",
      status: "OFFERED"
    };

    const commissionEngine: CommissionEngineResult = {
      totalGrossRevenueTRY: grossAnnualRevenueTRY,
      totalServiceFeeCommissionTRY,
      reservatiorSharePct,
      reservatiorShareAmountTRY: reservatiorAmountTRY,
      partnerPoolPct,
      partnerPoolAmountTRY: totalServiceFeeCommissionTRY - reservatiorAmountTRY,
      splits,
      settlementStatus: "SCHEDULED_AUTOMATIC",
      prismaCommissionRecord,
      prismaEscrowSplitConfig,
      prismaCommissionAdvance
    };

    // 5. Automated AI Proposal Generator
    const netAnnualValueAddTRY = Math.max(0, hybridEstimatedAnnualRevenueTRY - (currentMarketMonthlyRentTRY * 10.5));
    
    const aiProposalGenerator: AIProposalResult = {
      ownerPitch: {
        headline: `${input.neighbourhood} Lokasyonundaki Mülkünüz İçin Yıllık Net ${netAnnualValueAddTRY.toLocaleString('tr-TR')} TL Ekstra Gelir Fırsatı`,
        classicRentMonthlyTRY: currentMarketMonthlyRentTRY,
        hybridEstimatedAnnualTRY: hybridEstimatedAnnualRevenueTRY,
        netAnnualValueAddTRY,
        bulletPoints: [
          `Klasik kiralamadaki 1.5 aylık ortalama boş kalma riski tamamen ortadan kaldırılır.`,
          `7464 Sayılı Kanuna %100 uyumlu, kat malikleri ve E-Devlet onaylı güvenli kiralama altyapısı.`,
          `Tahliye taahhütnamesi ve kiracı ödememe riskine karşı %100 Reservatior kurumsal ödeme garantisi.`,
          `Garantili minimum taban kiranıza ek olarak %${25} performans prim paylaşımı.`
        ],
        pitchSummaryText: `Sayın Mülk Sahibi, AI Değerleme Motorumuza göre ${input.neighbourhood} bölgesindeki mülkünüz klasik kiralama piyasasında aylık ortalama ${currentMarketMonthlyRentTRY.toLocaleString('tr-TR')} TL üretmektedir. Reservatior Hibrit İşletme Modeli ile mülkünüze hem aylık minimum garanti kira tanımlıyor hem de kısa/orta dönem konaklama performansından ek pay vererek yıllık tahmini gelirinizi ${hybridEstimatedAnnualRevenueTRY.toLocaleString('tr-TR')} TL seviyesine çıkarıyoruz.`
      },
      partnerProposal: {
        headline: `Sektör Ortaklığı Teklifi: ${primaryTier} Tier Yetkili Portföy Partnerliği`,
        tierName: primaryTier,
        commissionSharePct: partnerPoolPct,
        estimatedAnnualCommissionTRY: totalServiceFeeCommissionTRY - reservatiorAmountTRY,
        valueProposition: `Reservatior Partner Ağına katılarak sadece tek seferlik kiralama komisyonu değil, mülk sistemde kaldığı sürece her ay düzenli pasif komisyon geliri elde edebilirsiniz. ${this.getPartnerDefaultName(primaryPartnerRole)} olarak bu mülkten yıllık ortalama ${(totalServiceFeeCommissionTRY - reservatiorAmountTRY).toLocaleString('tr-TR')} TL komisyon payı hak edeceksiniz.`
      }
    };

    return {
      partnerAttribution,
      commissionEngine,
      aiProposalGenerator
    };
  }

  private getRoleLabel(role: PartnerRole): string {
    switch (role) {
      case "PROPERTY_ACQUISITION": return "Portföy Kazanım Partneri (Emlak Danışmanı)";
      case "TENANT_ACQUISITION": return "Müşteri / Kiracı Kazanım Partneri";
      case "TRANSACTION_MANAGER": return "İşlem Yönetim Danışmanı";
      case "COMMUNITY_REFERRAL": return "Site / Residence Yöneticisi (Community Partner)";
      case "CORPORATE_REFERRAL": return "Kurumsal Expat Yönlendirme Aentesi";
      case "PORTFOLIO_MANAGER": return "Stratejik Bölge Portföy Partneri";
      case "DIRECT_RESERVATIOR": return "Doğrudan Reservatior (Aracısız)";
      default: return "Partner";
    }
  }

  private getPartnerDefaultName(role: PartnerRole): string {
    switch (role) {
      case "PROPERTY_ACQUISITION": return "Century21 / Coldwell Banker Yetkili Danışman";
      case "COMMUNITY_REFERRAL": return "Residance Site Görevlisi & Danışma";
      case "CORPORATE_REFERRAL": return "DHL / Mercedes Expat HR Relocation Partner";
      case "PORTFOLIO_MANAGER": return "İstanbul Bölge Ana Danışmanlığı";
      case "DIRECT_RESERVATIOR": return "Reservatior Dijital Pazarlama";
      // Global roles
      case "REAL_ESTATE_AGENT": return "Licensed Real Estate Agent";
      case "PROPERTY_MANAGER": return "Property Management Company";
      case "RELOCATION_COMPANY": return "Corporate Relocation Service";
      case "CORPORATE_HR_PARTNER": return "Corporate HR Partner";
      case "INVESTMENT_ADVISOR": return "Investment Advisory Firm";
      case "BUILDING_MANAGER": return "Building Manager";
      case "TRAVEL_AGENCY": return "Travel Agency / OTA Partner";
      case "LOCAL_OPERATOR": return "Local Hospitality Operator";
      default: return "Kayıtlı Yönlendirme Partneri";
    }
  }

  // ---------------------------------------------------------------------------
  // Country-based commission calculation
  // ---------------------------------------------------------------------------
  public calculateCountryCommission(
    partnerId: string,
    countryCode: string,
    grossRevenueLocal: number,
    role: PartnerRole,
    tier: PartnerTier,
    dealsThisYear: number = 0
  ): PartnerCountryCommission {
    const policy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);
    const currency = policy?.currency || 'TRY';

    // Base rate by tier
    const tierBaseRates: Record<PartnerTier, number> = {
      REFERRAL: 5,
      SILVER: 8,
      GOLD: 10,
      PLATINUM: 12,
      STRATEGIC: 15,
    };

    // Role multiplier (global roles get slight premium)
    const roleMultipliers: Partial<Record<PartnerRole, number>> = {
      REAL_ESTATE_AGENT: 1.1,
      RELOCATION_COMPANY: 1.2,
      CORPORATE_HR_PARTNER: 1.15,
      INVESTMENT_ADVISOR: 1.1,
      LOCAL_OPERATOR: 0.9,
      TRAVEL_AGENCY: 0.85,
    };

    const baseRate = tierBaseRates[tier] ?? 8;
    const multiplier = roleMultipliers[role] ?? 1.0;
    const baseCommissionRate = Math.min(20, baseRate * multiplier);

    // Country-specific cap adjustment (high-tax countries get lower cap)
    const taxBurden = (policy?.vatRate ?? 0) + (policy?.withholdingTaxRate ?? 0);
    const maxCommissionRate = taxBurden > 30 ? 12 : taxBurden > 15 ? 15 : 18;

    // Bonus for high-volume partners
    const bonusThresholdDeals = tier === 'STRATEGIC' ? 10 : tier === 'PLATINUM' ? 20 : 30;
    const bonusCommissionRate = Math.min(maxCommissionRate, baseCommissionRate + 3);

    return {
      partnerId,
      countryCode,
      baseCommissionRate: Math.round(baseCommissionRate * 100) / 100,
      bonusThresholdDeals,
      bonusCommissionRate: Math.round(bonusCommissionRate * 100) / 100,
      maxCommissionRate,
      currency,
    };
  }
}

export const partnerRevenueEngine = PartnerRevenueEngine.getInstance();
