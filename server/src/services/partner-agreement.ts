import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import * as crypto from "crypto";

// AES-256-GCM Encryption Setup
const ALGORITHM = "aes-256-gcm";
const ENCRYPTION_KEY = process.env.ENCRYPTION_KEY 
  ? crypto.scryptSync(process.env.ENCRYPTION_KEY, "salt", 32)
  : crypto.randomBytes(32); // Fallback for development if not in env

export interface CommissionSchedule {
  initial_move_in_cost_subsidy: number;
  monthly_commission_schedule: Array<{
    month: number;
    rate: number;
  }>;
  loyalty_yield_multipliers: Array<{
    month: number;
    multiplier: number;
  }>;
}

export interface RevenueDAGParams {
  exposureScore: number;         // 0.0 to 1.0 (Listing visibility score)
  engagementRate: number;        // 0.0 to 1.0 (Interaction rate)
  conversionProbability: number; // 0.0 to 1.0 (Lead to Booking probability)
  timeDecay: number;             // Decay multiplier (e.g. 0.95 per month)
  tenantBehaviorScore: number;   // 0.0 to 1.5 (Multiplier based on reliability/loyalty)
}

export type ListingPerformanceEvent = {
  type: "LISTING_PERFORMANCE_THRESHOLD_REACHED";
  listingId: string;
  contractId: string;

  metrics: {
    views: number;
    leads: number;
    conversions: number;
    avgTimeToLead: number; // hours
    vacancyDays: number;
  };

  thresholds: {
    conversionRate: number;
    maxVacancyDays: number;
  };

  timestamp: number;
};

export type PortfolioAggregationEvent = {
  type: "PORTFOLIO_AGGREGATION_EVENT";
  agencyId: string;
  contractId: string;

  snapshot: {
    totalListings: number;
    activeListings: number;
    avgOccupancyRate: number;
    avgConversionRate: number;
    churnRate: number;
    revenueVelocity: number; // revenue per day
  };

  deltas: {
    occupancyChange: number;
    conversionChange: number;
    churnChange: number;
  };

  timestamp: number;
};

export class PartnerAgreementService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).partnerAgreement, "partnerAgreement");
  }

  /**
   * Encrypts terms object to AES-256-GCM hex string
   */
  encryptTerms(terms: any): string {
    const iv = crypto.randomBytes(12);
    const cipher = crypto.createCipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
    let encrypted = cipher.update(JSON.stringify(terms), "utf8", "hex");
    encrypted += cipher.final("hex");
    const authTag = cipher.getAuthTag().toString("hex");
    return `${iv.toString("hex")}:${authTag}:${encrypted}`;
  }

  /**
   * Decrypts AES-256-GCM terms string back to object
   */
  decryptTerms(encryptedBlob: string): any {
    try {
      const [ivHex, authTagHex, encryptedHex] = encryptedBlob.split(":");
      if (!ivHex || !authTagHex || !encryptedHex) {
        throw new Error("Invalid encrypted blob format");
      }
      const iv = Buffer.from(ivHex, "hex");
      const authTag = Buffer.from(authTagHex, "hex");
      const decipher = crypto.createDecipheriv(ALGORITHM, ENCRYPTION_KEY, iv);
      decipher.setAuthTag(authTag);
      let decrypted = decipher.update(encryptedHex, "hex", "utf8");
      decrypted += decipher.final("utf8");
      return JSON.parse(decrypted);
    } catch (e) {
      console.error("Decryption failed:", e);
      return null;
    }
  }

  /**
   * Computes monthly commission using the dynamic schedule and loyalty multipliers
   */
  computeMonthlyCommission(
    agreement: CommissionSchedule,
    baseRevenue: number,
    monthIndex: number
  ): number {
    const schedule = agreement.monthly_commission_schedule || [];
    const multipliers = agreement.loyalty_yield_multipliers || [];

    const rate = schedule.find(m => m.month === monthIndex)?.rate 
      ?? schedule[schedule.length - 1]?.rate 
      ?? 0;

    const loyalty = multipliers.find(m => m.month === monthIndex)?.multiplier 
      ?? 1;

    return baseRevenue * rate * loyalty;
  }

  /**
   * Revenue DAG (Deterministic Financial Flow) Formula
   * Revenue = f(exposure, engagement, conversion, time_decay, contract_rules, tenant_behavior)
   */
  computeMonthlyRevenueDAG(
    baseEstimate: number,
    params: RevenueDAGParams,
    agreement: CommissionSchedule,
    monthIndex: number
  ): {
    grossRevenue: number;
    commissionSplit: number;
    netPayout: number;
  } {
    const { exposureScore, engagementRate, conversionProbability, timeDecay, tenantBehaviorScore } = params;

    // Apply revenue formula factors
    const exposureFactor = exposureScore > 0 ? exposureScore : 1.0;
    const engagementFactor = engagementRate > 0 ? engagementRate : 1.0;
    const conversionFactor = conversionProbability > 0 ? conversionProbability : 1.0;
    const decayFactor = Math.pow(timeDecay || 0.95, monthIndex);
    const behaviorFactor = tenantBehaviorScore > 0 ? tenantBehaviorScore : 1.0;

    const grossRevenue = baseEstimate * exposureFactor * engagementFactor * conversionFactor * decayFactor * behaviorFactor;

    // Calculate commission and payout splits
    const commissionSplit = this.computeMonthlyCommission(agreement, grossRevenue, monthIndex);
    const netPayout = grossRevenue - commissionSplit;

    return {
      grossRevenue: Math.round(grossRevenue * 100) / 100,
      commissionSplit: Math.round(commissionSplit * 100) / 100,
      netPayout: Math.round(netPayout * 100) / 100
    };
  }

  /**
   * Transitions agreement state validating allowed transitions
   */
  async transitionState(agreementId: string, nextState: string, tenantId: string) {
    const agreement = await this.getById(agreementId);
    if (!agreement) throw new Error("Agreement not found");
    if (agreement.tenantId !== tenantId) throw new Error("Unauthorized tenant access");

    const validTransitions: Record<string, string[]> = {
      CREATED: ["PENDING"],
      PENDING: ["ACTIVE", "ARCHIVED"],
      ACTIVE: ["SUSPENDED", "MODIFIED", "ESCALATED", "ARCHIVED"],
      SUSPENDED: ["ACTIVE", "RE_EXECUTED", "ARCHIVED"],
      MODIFIED: ["ACTIVE", "RE_EXECUTED"],
      ESCALATED: ["ACTIVE", "SUSPENDED", "RE_EXECUTED"],
      RE_EXECUTED: ["SETTLED"],
      SETTLED: ["ARCHIVED"],
      ARCHIVED: []
    };

    const allowed = validTransitions[agreement.status] || [];
    if (!allowed.includes(nextState)) {
      throw new Error(`Invalid state transition from ${agreement.status} to ${nextState}`);
    }

    return this.update(agreementId, { status: nextState });
  }

  /**
   * Evolve Contract Hook (Performance-Driven Mutation)
   * This is the core engine for mutating the contract based on listing performance.
   * Modifies the underlying agreement rules and dynamically lowers commission rates
   * or increases loyalty yields as a reward for performance.
   */
  async evolve(event: ListingPerformanceEvent) {
    const agreement = await this.getById(event.contractId);
    if (!agreement) throw new Error("Agreement not found");

    let currentTerms = this.decryptTerms(agreement.encryptedTerms) as CommissionSchedule;
    if (!currentTerms) throw new Error("Could not decrypt terms");

    const conversionRate = event.metrics.leads > 0 ? event.metrics.conversions / event.metrics.leads : 0;
    
    // Check if the threshold is met
    const thresholdReached =
      conversionRate >= event.thresholds.conversionRate ||
      event.metrics.vacancyDays <= event.thresholds.maxVacancyDays;

    if (thresholdReached) {
      // Mutate the commission schedule (Lower the rate by 0.5%, with a floor of 2%)
      const schedule = currentTerms.monthly_commission_schedule || [];
      const currentRate = schedule[schedule.length - 1]?.rate || 0.10;
      const newRate = Math.max(0.02, currentRate - 0.005); 
      
      const nextMonth = schedule.length > 0 ? schedule[schedule.length - 1].month + 1 : 1;
      schedule.push({ month: nextMonth, rate: newRate });
      currentTerms.monthly_commission_schedule = schedule;

      // Mutate loyalty multiplier (Increase by 5%)
      const multipliers = currentTerms.loyalty_yield_multipliers || [];
      const currentMultiplier = multipliers[multipliers.length - 1]?.multiplier || 1.0;
      
      const nextMultiplierMonth = multipliers.length > 0 ? multipliers[multipliers.length - 1].month + 1 : 1;
      multipliers.push({ month: nextMultiplierMonth, multiplier: currentMultiplier * 1.05 });
      currentTerms.loyalty_yield_multipliers = multipliers;
      
      // Encrypt and persist mutated terms
      const mutatedEncryptedTerms = this.encryptTerms(currentTerms);
      await this.update(event.contractId, { encryptedTerms: mutatedEncryptedTerms });
      
      console.log(`[CONTRACT_MUTATION] Contract ${event.contractId} evolved! New rate: ${newRate}, Multiplier: ${currentMultiplier * 1.05}`);
    }
    
    return currentTerms;
  }

  /**
   * Mock of evaluating listing performance. In production, this would pull stats from an analytics DB.
   */
  async evaluateListingPerformance(listingId: string, contractId: string) {
    // Mock analytics fetch
    const mockStats = {
      views: 1200,
      leads: 50,
      conversions: 8, // 16% conversion rate
      avgTimeToLead: 24,
      vacancyDays: 3,
    };
    
    const mockThresholds = {
      conversionRate: 0.10, // 10%
      maxVacancyDays: 7
    };

    const conversionRate = mockStats.leads > 0 ? mockStats.conversions / mockStats.leads : 0;
    const thresholdReached =
      conversionRate >= mockThresholds.conversionRate ||
      mockStats.vacancyDays <= mockThresholds.maxVacancyDays;

    if (thresholdReached) {
      const event: ListingPerformanceEvent = {
        type: "LISTING_PERFORMANCE_THRESHOLD_REACHED",
        listingId,
        contractId,
        metrics: mockStats,
        thresholds: mockThresholds,
        timestamp: Date.now()
      };
      
      return await this.evolve(event); // Mutasyon burada gerçekleşiyor!
    }
    return null;
  }

  /**
   * EXTENDED EVOLVE ENGINE: Portfolio Level Evolution
   * Evaluates the entire portfolio's performance index to apply macro-level contract changes.
   */
  evolveContractWithPortfolio(state: any, event: PortfolioAggregationEvent) {
    const performanceIndex =
      event.snapshot.avgOccupancyRate * 0.35 +
      event.snapshot.avgConversionRate * 0.35 +
      (1 - event.snapshot.churnRate) * 0.2 +
      Math.min(event.snapshot.revenueVelocity / 10000, 1) * 0.1;

    const stabilityBonus =
      event.deltas.occupancyChange > 0 &&
      event.deltas.conversionChange > 0
        ? 0.02
        : 0;

    const riskPenalty =
      event.snapshot.churnRate > 0.2 ? 0.03 : 0;

    const delta = performanceIndex * 0.01 + stabilityBonus - riskPenalty;

    return {
      ...state,
      
      // We adapt these generic terms into our existing model, but this logic can easily
      // map to our `monthly_commission_schedule` and `loyalty_yield_multipliers`.
      baseCommission: Math.max(0.008, (state.baseCommission || 0.10) - delta),
      
      currentMultiplier:
        (state.currentMultiplier || 1.0) + performanceIndex * 0.15,

      portfolioHealthScore: performanceIndex,

      loyaltyYield:
        (state.loyaltyYield ?? 0) + stabilityBonus * 10,
    };
  }

  /**
   * Portfolio Event Consumer
   */
  async onPortfolioAggregationEvent(event: PortfolioAggregationEvent) {
    const agreement = await this.getById(event.contractId);
    if (!agreement) throw new Error("Agreement not found");

    let currentTerms = this.decryptTerms(agreement.encryptedTerms);
    if (!currentTerms) throw new Error("Could not decrypt terms");

    const updatedTerms = this.evolveContractWithPortfolio(currentTerms, event);

    const mutatedEncryptedTerms = this.encryptTerms(updatedTerms);
    await this.update(event.contractId, { encryptedTerms: mutatedEncryptedTerms });

    console.log(`[PORTFOLIO_MUTATION] Contract ${event.contractId} evolved via portfolio metrics. Score: ${updatedTerms.portfolioHealthScore}`);
    
    return updatedTerms;
  }

  /**
   * TRIGGER: Portfolio Level Evaluation
   */
  async evaluatePortfolio(agencyId: string, contractId: string) {
    // Mock portfolio fetch
    const mockPortfolio = {
      totalListings: 150,
      activeListings: 120,
      avgOccupancyRate: 0.85,
      avgConversionRate: 0.12,
      churnRate: 0.05,
      revenueVelocity: 15000,
      occupancyChange30d: 0.06,
      conversionChange30d: 0.04,
      churnChange30d: -0.01,
    };

    const mockThresholds = {
      revenueVelocity: 10000
    };

    const event: PortfolioAggregationEvent = {
      type: "PORTFOLIO_AGGREGATION_EVENT",
      agencyId,
      contractId,
      
      snapshot: {
        totalListings: mockPortfolio.totalListings,
        activeListings: mockPortfolio.activeListings,
        avgOccupancyRate: mockPortfolio.avgOccupancyRate,
        avgConversionRate: mockPortfolio.avgConversionRate,
        churnRate: mockPortfolio.churnRate,
        revenueVelocity: mockPortfolio.revenueVelocity,
      },
      
      deltas: {
        occupancyChange: mockPortfolio.occupancyChange30d,
        conversionChange: mockPortfolio.conversionChange30d,
        churnChange: mockPortfolio.churnChange30d,
      },
      
      timestamp: Date.now(),
    };

    const isSignificant =
      Math.abs(mockPortfolio.occupancyChange30d) > 0.05 ||
      Math.abs(mockPortfolio.conversionChange30d) > 0.03 ||
      mockPortfolio.revenueVelocity > mockThresholds.revenueVelocity;

    if (!isSignificant) return null;

    return await this.onPortfolioAggregationEvent(event);
  }
}

export const partnerAgreementService = new PartnerAgreementService();
