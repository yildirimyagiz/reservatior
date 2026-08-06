import { RentalPlanScope, RentalServicePlan } from "@prisma/client";
import { prisma } from "../../lib/prisma";

/**
 * Rental Fee Calculator
 *
 * Resolves fee rates by plan scope (GLOBAL → ORGANIZATION → PROPERTY → LEASE)
 * and computes the fee split for a payment. Platform fees and protection
 * contributions are kept separate from any insurance premium (never mixed).
 */
export interface ResolvedRates {
  tenantFeeRate: number;
  landlordFeeRate: number;
  protectionRate: number;
  sourceScope: RentalPlanScope;
}

export class RentalFeeCalculator {
  constructor(private readonly db: typeof prisma = prisma) {}

  /**
   * Resolve effective rates by descending scope specificity.
   */
  async resolvePlanRates(
    planScope: RentalPlanScope,
    orgId?: string,
    propertyId?: string,
    leaseId?: string,
  ): Promise<ResolvedRates> {
    // Most specific first: LEASE → PROPERTY → ORGANIZATION → GLOBAL
    const scopes: RentalPlanScope[] = ["LEASE", "PROPERTY", "ORGANIZATION", "GLOBAL"];

    for (const scope of scopes) {
      const plan = await this.db.rentalServicePlan.findFirst({
        where: {
          scope,
          status: "ACTIVE",
          ...(scope === "GLOBAL"
            ? { orgId: null }
            : scope === "ORGANIZATION"
              ? { orgId }
              : scope === "PROPERTY"
                ? { orgId, propertyId }
                : { orgId, leaseId }),
        },
      });

      if (plan) {
        return {
          tenantFeeRate: Number(plan.tenantFeeRate),
          landlordFeeRate: Number(plan.landlordFeeRate),
          protectionRate: Number(plan.protectionRate),
          sourceScope: scope,
        };
      }
    }

    // Defaults
    return {
      tenantFeeRate: 0.035,
      landlordFeeRate: 0.035,
      protectionRate: 0.02,
      sourceScope: "GLOBAL",
    };
  }

  calculateFees(amount: number, currency: string, plan: RentalServicePlan) {
    const tenantFee = amount * Number(plan.tenantFeeRate);
    const landlordFee = amount * Number(plan.landlordFeeRate);
    const protectionFee = amount * Number(plan.protectionRate);
    const netAmount = amount - landlordFee;

    return {
      tenantFee: Math.round(tenantFee * 100) / 100,
      landlordFee: Math.round(landlordFee * 100) / 100,
      protectionFee: Math.round(protectionFee * 100) / 100,
      netAmount: Math.round(netAmount * 100) / 100,
    };
  }
}

export const rentalFeeCalculator = new RentalFeeCalculator();
