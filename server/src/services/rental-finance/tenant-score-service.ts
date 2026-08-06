import { RiskLevel } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { rentalEventPublisher, RentalFinanceEvents } from "./rental-event-publisher";

/**
 * Tenant Score Service
 *
 * Computes a tenant reliability score 0-100 from real payment behaviour
 * (on-time rate, delays, failures) and persists it on TenantFinancialProfile.
 * The score feeds the Insurance Pricing Engine and rental risk intelligence.
 */
export class TenantScoreService {
  constructor(private readonly db: typeof prisma = prisma) {}

  /**
   * Compute score purely from payment stats (unit-testable, no DB).
   */
  static scoreFromStats(input: {
    paymentCount: number;
    successfulPayments: number;
    latePayments: number;
    failedPayments: number;
    averageDelayDays: number;
    reliabilityScore?: number;
  }): number {
    const { paymentCount, successfulPayments, latePayments, failedPayments, averageDelayDays } =
      input;

    if (paymentCount === 0) return input.reliabilityScore ?? 50;

    const onTimeRate = successfulPayments / paymentCount;
    let score = onTimeRate * 100;

    // Penalty for late payments
    score -= latePayments * 3;
    // Heavy penalty for failures
    score -= failedPayments * 8;
    // Delay length penalty
    if (averageDelayDays > 0) {
      score -= Math.min(20, averageDelayDays * 0.8);
    }

    return Math.max(0, Math.min(100, Math.round(score * 10) / 10));
  }

  getRiskLevel(score: number): RiskLevel {
    if (score >= 90) return "VERY_LOW";
    if (score >= 70) return "LOW";
    if (score >= 50) return "MEDIUM";
    if (score >= 30) return "HIGH";
    return "VERY_HIGH";
  }

  /**
   * Recalculate + persist the tenant's reliability score from payment history.
   */
  async calculateScore(tenantId: string, orgId?: string): Promise<number> {
    const payments = await this.db.rentalPayment.findMany({
      where: { rentalPlan: { is: { tenantId } } },
    });

    const successful = payments.filter((p) => p.status === "COMPLETED").length;
    const late = payments.filter((p) => p.status === "LATE" || (p.daysLate ?? 0) > 0).length;
    const failed = payments.filter((p) => p.status === "FAILED").length;
    const delays = payments
      .map((p) => p.daysLate ?? 0)
      .filter((d) => d > 0);

    const averageDelayDays = delays.length
      ? delays.reduce((a, b) => a + b, 0) / delays.length
      : 0;

    const existing = await this.db.tenantFinancialProfile
      .findUnique({ where: { tenantId } })
      .catch(() => null);

    const score = TenantScoreService.scoreFromStats({
      paymentCount: payments.length,
      successfulPayments: successful,
      latePayments: late,
      failedPayments: failed,
      averageDelayDays,
      reliabilityScore: existing?.reliabilityScore,
    });

    const riskLevel = this.getRiskLevel(score);

    if (existing) {
      await this.db.tenantFinancialProfile.update({
        where: { id: existing.id },
        data: {
          reliabilityScore: score,
          paymentCount: payments.length,
          successfulPayments: successful,
          latePayments: late,
          failedPayments: failed,
          averageDelayDays,
          riskLevel,
          lastCalculatedAt: new Date(),
        },
      });
    } else if (orgId) {
      await this.db.tenantFinancialProfile.create({
        data: {
          tenantId,
          orgId,
          reliabilityScore: score,
          paymentCount: payments.length,
          successfulPayments: successful,
          latePayments: late,
          failedPayments: failed,
          averageDelayDays,
          riskLevel,
          lastCalculatedAt: new Date(),
        },
      });
    }

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.TenantScoreUpdated,
      countryCode: "US",
      data: { tenantId, riskScore: score },
    });

    return score;
  }

  /**
   * Update score after a single payment (on-time / late / failed).
   */
  async updateAfterPayment(tenantId: string, isOnTime: boolean, daysLate = 0): Promise<number> {
    const existing = await this.db.tenantFinancialProfile
      .findUnique({ where: { tenantId } })
      .catch(() => null);

    const current = existing?.reliabilityScore ?? 50;
    let delta = isOnTime ? +0.5 : -1.5 - Math.min(5, daysLate * 0.5);
    const score = Math.max(0, Math.min(100, Math.round((current + delta) * 10) / 10));

    if (existing) {
      await this.db.tenantFinancialProfile.update({
        where: { id: existing.id },
        data: {
          reliabilityScore: score,
          riskLevel: this.getRiskLevel(score),
          lastCalculatedAt: new Date(),
        },
      });
    }

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.TenantScoreUpdated,
      countryCode: "US",
      data: { tenantId, riskScore: score, paymentOutcome: isOnTime ? "ON_TIME" : "LATE" },
    });

    return score;
  }
}

export const tenantScoreService = new TenantScoreService();
