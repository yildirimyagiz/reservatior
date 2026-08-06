import { RiskLevel } from "@prisma/client";
import { prisma } from "../../lib/prisma";

/**
 * Landlord Analytics Service
 *
 * Aggregates portfolio metrics across a landlord's properties and tenants and
 * persists them to LandlordFinancialProfile.
 */
export class LandlordAnalyticsService {
  constructor(private readonly db: typeof prisma = prisma) {}

  async refreshProfile(landlordEntityId: string, orgId: string): Promise<any> {
    // Aggregate over the landlord's rental plans
    const plans = await this.db.rentalServicePlan.findMany({
      where: { landlordEntityId },
      include: { rentalPayments: true },
    });

    const propertyCount = plans.length;
    const activePlans = plans.filter((p) => p.status === "ACTIVE").length;
    const occupancyRate = propertyCount ? activePlans / propertyCount : 0;

    const allPayments = plans.flatMap((p) => p.rentalPayments);
    const completed = allPayments.filter((p) => p.status === "COMPLETED").length;
    const late = allPayments.filter((p) => p.status === "LATE" || (p.daysLate ?? 0) > 0).length;
    const totalRevenue = allPayments.reduce((s, p) => s + Number(p.amount), 0);

    const paymentHealth = allPayments.length
      ? ((completed - late * 0.5) / allPayments.length) * 100
      : 0;

    const existing = await this.db.landlordFinancialProfile
      .findUnique({ where: { landlordEntityId } })
      .catch(() => null);

    const data = {
      propertyCount,
      occupancyRate,
      paymentHealth,
      totalRevenue,
      monthlyRevenue: totalRevenue,
      riskScore: Math.max(0, Math.min(100, 100 - paymentHealth)),
      riskLevel: (paymentHealth >= 90 ? "LOW" : paymentHealth >= 70 ? "MEDIUM" : "HIGH") as RiskLevel,
      lastCalculatedAt: new Date(),
    };

    if (existing) {
      return this.db.landlordFinancialProfile.update({ where: { id: existing.id }, data });
    }
    return this.db.landlordFinancialProfile.create({
      data: {
        landlordEntity: { connect: { id: landlordEntityId } },
        org: { connect: { id: orgId } },
        ...data,
      },
    });
  }

  async getPortfolioHealth(landlordEntityId: string) {
    const profile = await this.db.landlordFinancialProfile
      .findUnique({ where: { landlordEntityId } })
      .catch(() => null);

    if (profile) {
      return {
        occupancyRate: profile.occupancyRate,
        paymentHealth: profile.paymentHealth,
        riskScore: profile.riskScore,
        propertyCount: profile.propertyCount,
        totalRevenue: Number(profile.totalRevenue),
        riskLevel: profile.riskLevel,
      };
    }

    return { occupancyRate: 0, paymentHealth: 0, riskScore: 100, propertyCount: 0, totalRevenue: 0 };
  }
}

export const landlordAnalyticsService = new LandlordAnalyticsService();
