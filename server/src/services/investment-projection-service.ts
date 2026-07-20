import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class InvestmentProjectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.investmentProjection, "investmentProjection");
  }

  async getByDeal(dealId: string) {
    return this.model.findMany({
      where: { dealId },
      orderBy: { createdAt: "desc" },
    });
  }

  async generateProjections(dealId: string, params?: { years?: number; annualGrowthRate?: number; rentalYield?: number }) {
    const years = params?.years ?? 10;
    const growthRate = params?.annualGrowthRate ?? 0.03;
    const rentalYield = params?.rentalYield ?? 0.05;

    const projections = [];
    for (let year = 1; year <= years; year++) {
      projections.push({
        dealId,
        year,
        projectedValue: Math.round(Math.pow(1 + growthRate, year) * 100) / 100,
        projectedRentalIncome: Math.round(rentalYield * 100) / 100,
        projectedROI: Math.round(((1 + growthRate) ** year - 1 + rentalYield * year) * 100) / 100,
        growthRate,
        rentalYield,
        createdAt: new Date(),
      });
    }

    const created = await Promise.all(
      projections.map(p => this.model.create({ data: p }))
    );

    return created;
  }

  async getProjectionsSummary(dealId: string) {
    const projections = await this.model.findMany({
      where: { dealId },
      orderBy: { year: "asc" },
    });

    if (!projections.length) {
      return { dealId, projectionCount: 0, summary: "No projections found" };
    }

    const lastProjection = projections[projections.length - 1];
    return {
      dealId,
      projectionCount: projections.length,
      timeHorizon: `${projections[0].year} - ${lastProjection.year}`,
      finalProjectedValue: lastProjection.projectedValue,
      totalProjectedROI: lastProjection.projectedROI,
      averageAnnualGrowth: projections.reduce((sum: number, p: any) => sum + (p.growthRate || 0), 0) / projections.length,
    };
  }
}

export const investmentProjectionService = new InvestmentProjectionService();
