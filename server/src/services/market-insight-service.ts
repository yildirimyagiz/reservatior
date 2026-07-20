import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MarketInsightDataService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.marketInsight, "marketInsight");
  }

  async getByRegion(region: string, params?: { skip?: number; take?: number }) {
    return this.model.findMany({
      where: { region },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getLatest(region?: string, limit = 10) {
    return this.model.findMany({
      where: region ? { region } : undefined,
      orderBy: { createdAt: "desc" },
      take: limit,
    });
  }

  async generateInsight(region: string, _params?: { type?: string; period?: string }) {
    const existing = await this.model.findMany({
      where: { region },
      orderBy: { createdAt: "desc" },
      take: 50,
    });

    return {
      region,
      insightCount: existing.length,
      generatedAt: new Date(),
      summary: `Insight generation for ${region} is a stub. Found ${existing.length} existing records.`,
    };
  }

  async getTrends(region: string, months = 6) {
    const since = new Date();
    since.setMonth(since.getMonth() - months);

    const insights = await this.model.findMany({
      where: {
        region,
        createdAt: { gte: since },
      },
      orderBy: { createdAt: "asc" },
    });

    return {
      region,
      period: `${months} months`,
      dataPoints: insights.length,
      insights: insights.map((i: any) => ({
        id: i.id,
        type: i.type,
        createdAt: i.createdAt,
        data: i.data,
      })),
    };
  }
}

export const marketInsightDataService = new MarketInsightDataService();
