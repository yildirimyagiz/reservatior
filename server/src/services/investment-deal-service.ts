import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class InvestmentDealService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.investmentDeal, "investmentDeal");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return this.model.findMany({
      where: {
        orgId,
        ...(params?.status && { status: params.status }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getByUser(userId: string, params?: { skip?: number; take?: number }) {
    return this.model.findMany({
      where: { userId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async createDeal(data: {
    orgId: string;
    userId: string;
    propertyId?: string;
    name: string;
    dealType?: string;
    status?: string;
    investmentAmount?: number;
    expectedReturn?: number;
    riskLevel?: string;
    metadata?: any;
  }) {
    const result = await this.model.create({
      data: {
        ...data,
        status: data.status ?? "DRAFT",
        createdAt: new Date(),
      },
    });
    await eventBus.publish(DomainEvents.DEAL_CREATED, { id: result.id, name: data.name, investmentAmount: data.investmentAmount }, "InvestmentOS");
    return result;
  }

  async updateDeal(id: string, data: {
    name?: string;
    dealType?: string;
    status?: string;
    investmentAmount?: number;
    expectedReturn?: number;
    riskLevel?: string;
    metadata?: any;
  }) {
    return this.model.update({
      where: { id },
      data,
    });
  }

  async analyzeDeal(id: string) {
    const deal = await this.model.findUnique({ where: { id } });
    if (!deal) throw new Error("Deal not found");

    const analysis = {
      id: deal.id,
      name: deal.name,
      investmentAmount: deal.investmentAmount,
      expectedReturn: deal.expectedReturn,
      riskLevel: deal.riskLevel,
      projectedROI: deal.investmentAmount && deal.expectedReturn
        ? ((deal.expectedReturn / deal.investmentAmount) * 100).toFixed(2) + "%"
        : null,
      status: deal.status,
    };
    await eventBus.publish("INVESTMENT_RECOMMENDATION_READY", { id: deal.id, analysis }, "InvestmentOS");
    return { deal, analysis };
  }

  async duplicateDeal(id: string, userId: string) {
    const original = await this.model.findUnique({ where: { id } });
    if (!original) throw new Error("Deal not found");

    const { id: _id, createdAt, updatedAt, ...rest } = original;
    return this.model.create({
      data: {
        ...rest,
        userId,
        name: `${original.name} (Copy)`,
        status: "DRAFT",
        createdAt: new Date(),
      },
    });
  }

  async getDealStats(orgId: string) {
    const [total, byStatus, aggregate] = await Promise.all([
      this.model.count({ where: { orgId } }),
      this.model.groupBy({ by: ["status"], where: { orgId }, _count: { id: true } }),
      this.model.aggregate({
        where: { orgId },
        _sum: { investmentAmount: true, expectedReturn: true },
        _avg: { investmentAmount: true, expectedReturn: true },
      }),
    ]);

    return {
      total,
      byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })),
      totalInvestment: aggregate._sum.investmentAmount ?? 0,
      totalExpectedReturn: aggregate._sum.expectedReturn ?? 0,
      avgInvestment: aggregate._avg.investmentAmount ?? 0,
      avgExpectedReturn: aggregate._avg.expectedReturn ?? 0,
    };
  }
}

export const investmentDealService = new InvestmentDealService();
