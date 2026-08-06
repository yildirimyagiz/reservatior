import { Prisma, RentalServicePlanStatus, EscrowAccountStatus } from "@prisma/client";
import { prisma } from "../../lib/prisma";
import { rentalEventPublisher, RentalFinanceEvents } from "./rental-event-publisher";

/**
 * Rental Plan Service — RentalServicePlan lifecycle.
 */
export class RentalPlanService {
  constructor(private readonly db: typeof prisma = prisma) {}

  async createPlan(input: {
    orgId: string;
    scope: Prisma.RentalServicePlanCreateInput["scope"];
    propertyId?: string;
    leaseId?: string;
    tenantId?: string;
    landlordEntityId?: string;
    tenantFeeRate?: number;
    landlordFeeRate?: number;
    protectionRate?: number;
    currency?: string;
    effectiveFrom?: Date;
    effectiveTo?: Date;
    countryCode?: string;
  }): Promise<any> {
    const plan = await this.db.rentalServicePlan.create({
      data: {
        orgId: input.orgId,
        scope: input.scope,
        propertyId: input.propertyId,
        leaseId: input.leaseId,
        tenantId: input.tenantId,
        landlordEntityId: input.landlordEntityId,
        tenantFeeRate: input.tenantFeeRate ?? 0.035,
        landlordFeeRate: input.landlordFeeRate ?? 0.035,
        protectionRate: input.protectionRate ?? 0.02,
        currency: input.currency ?? "USD",
        status: RentalServicePlanStatus.PENDING,
        effectiveFrom: input.effectiveFrom ?? new Date(),
        effectiveTo: input.effectiveTo,
      },
    });

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.PlanCreated,
      countryCode: input.countryCode ?? "US",
      data: {
        rentalPlanId: plan.id,
        orgId: input.orgId,
        tenantId: input.tenantId,
        landlordId: input.landlordEntityId,
        propertyId: input.propertyId,
      },
    });

    return plan;
  }

  async activatePlan(planId: string, countryCode = "US"): Promise<any> {
    const plan = await this.db.rentalServicePlan.findUnique({ where: { id: planId } });
    if (!plan) throw new Error("RentalServicePlan not found");
    if (!plan.orgId) throw new Error("Plan has no org");

    const escrow = await this.db.rentalEscrowAccount.findUnique({
      where: { rentalPlanId: planId },
    });
    if (!escrow) {
      const { escrowEngine } = await import("./escrow-engine");
      await escrowEngine.createEscrowForPlan({
        orgId: plan.orgId,
        rentalPlanId: planId,
        currency: plan.currency ?? "USD",
      });
    }

    const updated = await this.db.rentalServicePlan.update({
      where: { id: planId },
      data: { status: RentalServicePlanStatus.ACTIVE },
    });

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.PlanActivated,
      countryCode,
      data: {
        rentalPlanId: planId,
        tenantId: plan.tenantId ?? undefined,
        landlordId: plan.landlordEntityId ?? undefined,
        propertyId: plan.propertyId ?? undefined,
      },
    });

    return updated;
  }

  async suspendPlan(planId: string): Promise<any> {
    return this.db.rentalServicePlan.update({
      where: { id: planId },
      data: { status: RentalServicePlanStatus.SUSPENDED },
    });
  }

  async resumePlan(planId: string): Promise<any> {
    return this.db.rentalServicePlan.update({
      where: { id: planId },
      data: { status: RentalServicePlanStatus.ACTIVE },
    });
  }

  async terminatePlan(planId: string, countryCode = "US"): Promise<any> {
    const escrow = await this.db.rentalEscrowAccount
      .findUnique({ where: { rentalPlanId: planId } })
      .catch(() => null);
    if (escrow) {
      await this.db.rentalEscrowAccount.update({
        where: { id: escrow.id },
        data: {
          status: EscrowAccountStatus.CLOSED,
          releasedAt: new Date(),
          releasedAmount: escrow.heldAmount,
          heldAmount: 0,
        },
      });
    }

    const updated = await this.db.rentalServicePlan.update({
      where: { id: planId },
      data: { status: RentalServicePlanStatus.TERMINATED, effectiveTo: new Date() },
    });

    await rentalEventPublisher.publish({
      eventType: RentalFinanceEvents.PlanTerminated,
      countryCode,
      data: {
        rentalPlanId: planId,
        tenantId: updated.tenantId ?? undefined,
        landlordId: updated.landlordEntityId ?? undefined,
        propertyId: updated.propertyId ?? undefined,
      },
    });

    return updated;
  }
}

export const rentalPlanService = new RentalPlanService();
