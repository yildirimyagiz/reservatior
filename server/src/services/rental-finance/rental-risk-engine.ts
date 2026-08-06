import { RiskLevel } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { TenantScoreService } from "./tenant-score-service";
import { rentalEventPublisher, RentalFinanceEvents } from "./rental-event-publisher";

/**
 * Rental Risk Engine
 *
 * Produces risk intelligence from payment behaviour + tenant financial profile
 * and emits Security OS-compatible risk events. Feeds insurance pricing and
 * escrow release decisions.
 */
export class RentalRiskEngine {
  constructor(private readonly db: typeof prisma = prisma) {}

  /**
   * Assess a tenant's current risk from their financial profile.
   */
  async assessTenantRisk(tenantId: string): Promise<{ score: number; riskLevel: RiskLevel }> {
    const profile = await this.db.tenantFinancialProfile
      .findUnique({ where: { tenantId } })
      .catch(() => null);

    const score = profile?.reliabilityScore ?? (await new TenantScoreService(this.db).calculateScore(tenantId));

    let riskLevel = profile?.riskLevel ?? "MEDIUM";
    if (!profile) {
      riskLevel = new TenantScoreService(this.db).getRiskLevel(score);
    }

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.RiskScored,
      countryCode: "US",
      data: { tenantId, riskScore: score, riskLevel },
    });

    return { score, riskLevel };
  }

  /**
   * Escalate risk when a payment goes late — used by the escrow/insurance layers.
   */
  async propagateLatePayment(rentalPaymentId: string): Promise<{ score: number; riskLevel: RiskLevel }> {
    const payment = await this.db.rentalPayment.findUnique({
      where: { id: rentalPaymentId },
      include: { rentalPlan: true },
    });
    const tenantId = payment?.rentalPlan.tenantId;
    if (!tenantId) throw new Error("Payment has no tenant");

    const score = await new TenantScoreService(this.db).updateAfterPayment(
      tenantId,
      false,
      payment.daysLate ?? 3,
    );
    const riskLevel = new TenantScoreService(this.db).getRiskLevel(score);

    await this.generateRiskAlert(tenantId, riskLevel);
    return { score, riskLevel };
  }

  /**
   * Generate a Security OS risk alert (event-driven, outbox persisted).
   */
  async generateRiskAlert(tenantId: string, riskLevel: RiskLevel): Promise<void> {
    if (riskLevel === "LOW" || riskLevel === "VERY_LOW") return;

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.RiskScored,
      countryCode: "US",
      data: {
        tenantId,
        riskScore: riskLevel === "VERY_HIGH" ? 20 : riskLevel === "HIGH" ? 40 : 60,
        riskLevel,
        alert: true,
        producer: "rental-risk-engine",
      },
    });
  }
}

export const rentalRiskEngine = new RentalRiskEngine();
