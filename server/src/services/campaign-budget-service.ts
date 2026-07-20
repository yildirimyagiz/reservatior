import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CampaignBudgetService extends BaseService<any, any, any> {
  constructor() { super(prisma.campaignBudget, "campaignBudget"); }

  async getByCampaign(campaignId: string) {
    return this.model.findFirst({ where: { campaignId } });
  }

  async setBudget(campaignId: string, data: { dailyBudget: number; totalBudget: number; currency?: string }) {
    return this.model.upsert({
      where: { campaignId } as any,
      update: data,
      create: { campaignId, ...data, currency: data.currency ?? "USD", createdAt: new Date() },
    }).catch(() => this.model.create({ data: { campaignId, ...data, currency: data.currency ?? "USD", createdAt: new Date() } }));
  }

  async getReport(campaignId: string) {
    const budget = await this.model.findFirst({ where: { campaignId } });
    return { campaignId, budget: budget?.dailyBudget ?? 0, totalBudget: budget?.totalBudget ?? 0, spent: 0, remaining: budget?.totalBudget ?? 0 };
  }
}

export const campaignBudgetService = new CampaignBudgetService();
