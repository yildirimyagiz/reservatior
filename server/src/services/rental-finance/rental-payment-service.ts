import { Prisma, RentalPaymentStatus, RentalPayerType, EscrowAccountStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { RentalFeeCalculator } from "./rental-fee-calculator";
import { tenantScoreService } from "./tenant-score-service";
import { rentalEventPublisher, RentalFinanceEvents } from "./rental-event-publisher";

/**
 * Rental Payment Service
 *
 * Orchestrates the payment lifecycle: schedule → process (fee split + escrow)
 * → settle → late/failure handling. Tenant score is updated on every outcome.
 */
export class RentalPaymentService {
  constructor(private readonly db: typeof prisma = prisma) {}

  /**
   * Generate monthly scheduled payments for a plan's effective window.
   */
  async scheduleMonthlyPayments(planId: string): Promise<any[]> {
    const plan = await this.db.rentalServicePlan.findUnique({ where: { id: planId } });
    if (!plan) throw new Error("RentalServicePlan not found");
    if (!plan.propertyId || !plan.tenantId) {
      throw new Error("Plan requires propertyId and tenantId to schedule payments");
    }

    // Determine monthly rent from property listing price (fallback) or lease.
    const lease = plan.leaseId
      ? await this.db.lease.findUnique({ where: { id: plan.leaseId } }).catch(() => null)
      : null;
    const monthlyRent = lease ? Number(lease.rent) : 1000;

    const start = plan.effectiveFrom ?? new Date();
    const end = plan.effectiveTo ?? new Date(Date.now() + 12 * 30 * 24 * 3600 * 1000);

    const feeCalc = new RentalFeeCalculator();
    const fees = feeCalc.calculateFees(monthlyRent, plan.currency ?? "USD", plan);

    const scheduled: any[] = [];
    const cursor = new Date(start);
    let monthIndex = 0;

    while (cursor <= end && monthIndex < 120) {
      const scheduledDate = new Date(cursor);
      scheduledDate.setDate(Math.min(scheduledDate.getDate(), 28));

      scheduled.push(
        await this.db.rentalPayment.create({
          data: {
            orgId: plan.orgId!,
            rentalPlanId: plan.id,
            payerType: RentalPayerType.TENANT,
            amount: monthlyRent,
            feeAmount: fees.tenantFee,
            protectionAmount: fees.protectionFee,
            feeRate: Number(plan.tenantFeeRate),
            currency: plan.currency ?? "USD",
            status: RentalPaymentStatus.SCHEDULED,
            scheduledDate,
            idempotencyKey: `rental_${plan.id}_${monthIndex}_${scheduledDate.toISOString().slice(0, 10)}`,
          },
        }),
      );

      cursor.setMonth(cursor.getMonth() + 1);
      monthIndex++;
    }

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.PaymentScheduled,
      countryCode: "US",
      data: {
        rentalPlanId: plan.id,
        tenantId: plan.tenantId!,
        propertyId: plan.propertyId ?? undefined,
        paymentIds: scheduled.map((p) => p.id),
        financialImpact: monthlyRent,
      },
    });

    return scheduled;
  }

  /**
   * Process a scheduled/pending payment:
   *  1. Mark PROCESSING
   *  2. Split platform fee vs protection contribution (never mixed with premium)
   *  3. Deposit to escrow (blocked)
   *  4. Update tenant score
   *  5. Mark COMPLETED + publish event
   */
  async processPayment(rentalPaymentId: string): Promise<any> {
    const payment = await this.db.rentalPayment.findUnique({
      where: { id: rentalPaymentId },
      include: { rentalPlan: true },
    });
    if (!payment) throw new Error("RentalPayment not found");
    if (!payment.rentalPlan.orgId) throw new Error("Plan has no org");

    await this.db.rentalPayment.update({
      where: { id: payment.id },
      data: { status: RentalPaymentStatus.PROCESSING },
    });

    // Escrow deposit
    let escrow = await this.db.rentalEscrowAccount.findUnique({
      where: { rentalPlanId: payment.rentalPlanId },
    });
    if (!escrow) {
      const escrowEngine = await import("./escrow-engine");
      escrow = await escrowEngine.escrowEngine.createEscrowForPlan({
        orgId: payment.rentalPlan.orgId,
        rentalPlanId: payment.rentalPlanId,
        currency: payment.currency,
      });
    }

    if (!escrow) throw new Error("Failed to create escrow account");

    const heldAmount = Number(payment.amount) - Number(payment.feeAmount);
    await this.db.rentalEscrowAccount.update({
      where: { id: escrow.id },
      data: {
        balance: Number(escrow.balance) + Number(payment.amount),
        heldAmount: Number(escrow.heldAmount) + heldAmount,
        status: EscrowAccountStatus.HOLDING,
      },
    });

    await this.db.rentalPayment.update({
      where: { id: payment.id },
      data: {
        status: RentalPaymentStatus.COMPLETED,
        paidAt: new Date(),
        escrowAccountId: escrow.id,
      },
    });

    // Tenant score update
    if (payment.rentalPlan.tenantId) {
      await tenantScoreService.updateAfterPayment(payment.rentalPlan.tenantId, true, 0);
    }

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.PaymentProcessed,
      countryCode: "US",
      data: {
        paymentId: payment.id,
        rentalPlanId: payment.rentalPlanId,
        tenantId: payment.rentalPlan.tenantId ?? undefined,
        escrowId: escrow.id,
        propertyId: payment.rentalPlan.propertyId ?? undefined,
        financialImpact: Number(payment.amount),
        split: {
          platformFee: Number(payment.feeAmount),
          protection: Number(payment.protectionAmount ?? 0),
          escrowHold: heldAmount,
        },
      },
    });

    return this.db.rentalPayment.findUnique({ where: { id: payment.id } });
  }

  /**
   * CRON: mark overdue scheduled payments as LATE.
   */
  async markLatePayments(graceDays = 3): Promise<number> {
    const cutoff = new Date();
    cutoff.setDate(cutoff.getDate() - graceDays);

    const overdue = await this.db.rentalPayment.findMany({
      where: {
        status: RentalPaymentStatus.SCHEDULED,
        scheduledDate: { lte: cutoff },
      },
      include: { rentalPlan: true },
    });

    for (const payment of overdue) {
      const daysLate = Math.floor(
        (Date.now() - new Date(payment.scheduledDate).getTime()) / (24 * 3600 * 1000),
      );
      await this.db.rentalPayment.update({
        where: { id: payment.id },
        data: { status: RentalPaymentStatus.LATE, daysLate },
      });

      if (payment.rentalPlan.tenantId) {
        await tenantScoreService.updateAfterPayment(payment.rentalPlan.tenantId, false, daysLate);
      }

      await rentalEventPublisher.publish({
        eventType: RentalFinanceEvents.PaymentLate,
        countryCode: "US",
        data: {
          paymentId: payment.id,
          rentalPlanId: payment.rentalPlanId,
          tenantId: payment.rentalPlan.tenantId ?? undefined,
          daysLate,
        },
      });
    }

    return overdue.length;
  }
}

export const rentalPaymentService = new RentalPaymentService();
