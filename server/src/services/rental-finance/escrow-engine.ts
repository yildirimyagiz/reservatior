import { EscrowAccountStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { rentalEventPublisher, RentalFinanceEvents } from "./rental-event-publisher";

/**
 * Escrow Engine — manages RentalEscrowAccount release logic.
 *
 * Money is held in escrow (blockage period) then released on schedule or by
 * manual approval, subject to a risk threshold. Fraud/dispute signals block
 * auto-release.
 */
export class EscrowEngine {
  constructor(private readonly db: typeof prisma = prisma) {}

  async createEscrowForPlan(input: {
    orgId: string;
    rentalPlanId: string;
    currency: string;
    blockageDays?: number;
  }): Promise<any> {
    const policy = await this.db.escrowReleasePolicy.findFirst({
      where: { orgId: input.orgId },
    });
    const blockageDays = input.blockageDays ?? policy?.blockageDays ?? 3;

    const escrow = await this.db.rentalEscrowAccount.create({
      data: {
        orgId: input.orgId,
        rentalPlanId: input.rentalPlanId,
        balance: 0,
        heldAmount: 0,
        currency: input.currency,
        status: EscrowAccountStatus.OPEN,
        releaseDate: new Date(Date.now() + blockageDays * 24 * 3600 * 1000),
        policyId: policy?.id,
      },
    });

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.EscrowCreated,
      countryCode: "US",
      data: { escrowId: escrow.id, rentalPlanId: input.rentalPlanId, orgId: input.orgId },
    });

    return escrow;
  }

  /**
   * Risk check before release. Returns false when fraud/dispute risk is high.
   */
  async evaluateReleaseTrigger(rentalPaymentId: string): Promise<boolean> {
    const payment = await this.db.rentalPayment
      .findUnique({
        where: { id: rentalPaymentId },
        include: { rentalPlan: true },
      })
      .catch(() => null);
    if (!payment) return false;

    // Payment failure or dispute blocks release
    if (payment.status === "FAILED" || payment.status === "LATE") return false;

    const tenantId = payment.rentalPlan?.tenantId;
    if (tenantId) {
      const tenant = await this.db.tenantFinancialProfile
        .findUnique({ where: { tenantId } })
        .catch(() => null);
      if (tenant && tenant.riskLevel === "VERY_HIGH") return false;
    }

    return true;
  }

  /**
   * CRON: release mature, non-risky escrow holdings automatically.
   */
  async processAutoReleases(): Promise<{ released: number; skipped: number }> {
    const due = await this.db.rentalEscrowAccount.findMany({
      where: {
        status: { in: ["OPEN", "HOLDING"] as any },
        releaseDate: { lte: new Date() },
      },
    });

    let released = 0;
    let skipped = 0;

    for (const escrow of due) {
      const payments = await this.db.rentalPayment.findMany({
        where: { escrowAccountId: escrow.id },
      });
      const risky = payments.some((p) => p.status === "FAILED" || p.status === "LATE");
      if (risky) {
        skipped++;
        continue;
      }

      const policy = escrow.policyId
        ? await this.db.escrowReleasePolicy
            .findUnique({ where: { id: escrow.policyId } })
            .catch(() => null)
        : null;

      if (policy && !policy.autoRelease) {
        skipped++;
        continue;
      }

      await this.db.rentalEscrowAccount.update({
        where: { id: escrow.id },
        data: {
          status: EscrowAccountStatus.RELEASING,
          releasedAt: new Date(),
          releasedAmount: escrow.heldAmount,
          balance: 0,
          heldAmount: 0,
        },
      });

      await rentalEventPublisher.publish({
        eventType: RentalFinanceEvents.EscrowReleased,
        countryCode: "US",
        data: {
          escrowId: escrow.id,
          rentalPlanId: escrow.rentalPlanId,
          financialImpact: Number(escrow.heldAmount),
        },
      });

      released++;
    }

    return { released, skipped };
  }

  async manualReleaseApprove(escrowId: string, actorId: string): Promise<any> {
    const escrow = await this.db.rentalEscrowAccount.findUnique({ where: { id: escrowId } });
    if (!escrow) throw new Error("Escrow account not found");

    return this.db.rentalEscrowAccount.update({
      where: { id: escrowId },
      data: {
        status: EscrowAccountStatus.RELEASED,
        releasedAt: new Date(),
        releasedAmount: escrow.heldAmount,
        balance: 0,
        heldAmount: 0,
        metadata: { releasedBy: actorId, manualApproval: true },
      },
    });
  }
}

export const escrowEngine = new EscrowEngine();
