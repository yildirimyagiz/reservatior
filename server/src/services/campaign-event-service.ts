import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CampaignEventService extends BaseService<any, any, any> {
  constructor() { super(prisma.campaignEvent, "campaignEvent"); }

  async getByCampaign(campaignId: string, limit = 100) {
    return this.model.findMany({ where: { campaignId }, orderBy: { createdAt: "desc" }, take: limit });
  }

  async trackEvent(data: { campaignId: string; eventType: string; metadata?: any }) {
    return this.model.create({ data: { ...data, createdAt: new Date() } });
  }

  async getEventStats(campaignId: string) {
    const events = await this.model.findMany({ where: { campaignId } });
    const byType = events.reduce((acc: Record<string, number>, e: any) => { acc[e.eventType] = (acc[e.eventType] || 0) + 1; return acc; }, {});
    return { campaignId, totalEvents: events.length, byType };
  }
}

export const campaignEventService = new CampaignEventService();
