import { prisma } from "../../lib/prisma";

/**
 * Insurance Pricing Engine
 *
 * Risk-based, EXPLAINABLE premium calculation. Reservatior NEVER underwrites —
 * it only prices distribution using its risk intelligence.
 *
 * Banding (from update2.md):
 *   LOW    score > 90   → 1%
 *   MEDIUM score 70-90  → 2%
 *   HIGH   score < 70   → 3-5% (up to maxPremiumRate)
 *
 * The calculation is PURE (no DB) so it can be unit-tested without a database;
 * `persistExplanation` is separate and optional.
 */
export interface PricingTenantProfile {
  reliabilityScore?: number;
  paymentCount?: number;
  successfulPayments?: number;
  latePayments?: number;
  failedPayments?: number;
  averageDelayDays?: number;
  incomeStability?: number;
}

export interface PricingLandlordProfile {
  paymentHealth?: number;
  riskScore?: number;
  propertyCount?: number;
}

export interface PricingPaymentRecord {
  status?: string;
  daysLate?: number | null;
  amount?: number;
}

export interface InsurancePricingInput {
  tenantProfile?: PricingTenantProfile | null;
  landlordProfile?: PricingLandlordProfile | null;
  paymentHistory?: PricingPaymentRecord[];
  /** Risk Engine score 0-100 (Security OS risk intelligence). */
  riskEngineScore?: number;
  /** Fraud score 0-100 — higher means more fraud risk. */
  fraudScore?: number;
  propertyData?: Record<string, any> | null;
  locationRisk?: Record<string, any> | null;
  /** Product base premium rate (e.g. 0.02 = 2%). */
  basePremiumRate?: number;
  /** Absolute cap for the computed rate (default 5%). */
  maxPremiumRate?: number;
}

export interface InsurancePricingResult {
  premiumRate: number;
  riskBand: "LOW" | "MEDIUM" | "HIGH";
  riskEngineScore: number;
  explanation: Record<string, number>;
}

export class InsurancePricingEngine {
  /**
   * Pure premium calculation — safe to unit test.
   */
  calculatePremium(input: InsurancePricingInput): InsurancePricingResult {
    const score = Math.max(
      0,
      Math.min(100, input.riskEngineScore ?? input.tenantProfile?.reliabilityScore ?? 50),
    );
    const baseRate = input.basePremiumRate ?? 0.02;
    const maxRate = input.maxPremiumRate ?? 0.05;

    const explanation: Record<string, number> = {};

    // 1. Risk band from score
    let band: "LOW" | "MEDIUM" | "HIGH";
    let bandRate: number;
    if (score > 90) {
      band = "LOW";
      bandRate = 0.01;
      explanation.band = +0.01;
      explanation.tenantReliability = +0.01;
    } else if (score > 70) {
      band = "MEDIUM";
      bandRate = 0.02;
      explanation.band = 0;
      explanation.tenantReliability = 0;
    } else {
      band = "HIGH";
      bandRate = 0.03;
      explanation.band = -0.01;
      explanation.tenantReliability = -0.01;
    }

    let rate = bandRate;

    // 2. Payment history adjustments
    const history = input.paymentHistory ?? [];
    const onTime = history.filter((p) => p.status === "COMPLETED" || (p.daysLate ?? 0) <= 0).length;
    const late = history.filter((p) => (p.daysLate ?? 0) > 0).length;

    if (onTime > 0) {
      explanation.paymentHistory = +Math.min(0.01, onTime * 0.002);
      rate += explanation.paymentHistory;
    }
    if (late > 0) {
      explanation.previousLatePayments = -Math.min(0.015, late * 0.005);
      rate += explanation.previousLatePayments;
    }

    // 3. Income stability
    const incomeStability = input.tenantProfile?.incomeStability ?? 0.5;
    if (incomeStability >= 0.8) {
      explanation.incomeStability = -0.005;
      rate += explanation.incomeStability;
    } else if (incomeStability < 0.3) {
      explanation.incomeStability = +0.008;
      rate += explanation.incomeStability;
    }

    // 4. Fraud score
    const fraudScore = input.fraudScore ?? 0;
    if (fraudScore > 60) {
      explanation.fraudRisk = -0.02;
      rate += explanation.fraudRisk;
      band = "HIGH";
    } else if (fraudScore > 30) {
      explanation.fraudRisk = -0.008;
      rate += explanation.fraudRisk;
    }

    // 5. Location risk — modest uplift when flagged
    const locationRisk = input.locationRisk as Record<string, any> | null;
    if (locationRisk && typeof locationRisk.level === "string") {
      if (locationRisk.level === "HIGH" || locationRisk.level === "VERY_HIGH") {
        explanation.locationRisk = +0.005;
        rate += explanation.locationRisk;
      }
    }

    // Clamp: keep the product's base rate meaningful, never exceed the cap.
    rate = Math.max(Math.min(rate, maxRate), 0.005);

    return {
      premiumRate: Math.round(rate * 10000) / 10000,
      riskBand: band,
      riskEngineScore: score,
      explanation,
    };
  }

  /**
   * Persist the pricing decision for auditability (RiskPricingExplanation).
   */
  async persistExplanation(input: {
    tenantId?: string;
    landlordEntityId?: string;
    result: InsurancePricingResult;
    fraudScore?: number;
    correlationId?: string;
    tx?: typeof prisma;
  }): Promise<void> {
    const db = input.tx ?? prisma;
    try {
      await db.riskPricingExplanation.create({
        data: {
          tenantId: input.tenantId,
          landlordEntityId: input.landlordEntityId,
          riskEngineScore: input.result.riskEngineScore,
          fraudScore: input.fraudScore,
          computedRate: input.result.premiumRate,
          riskBand: input.result.riskBand,
          explanation: input.result.explanation as any,
        },
      });
    } catch (err) {
      console.error("[InsurancePricingEngine] persistExplanation failed:", err);
    }
  }
}

export const insurancePricingEngine = new InsurancePricingEngine();
