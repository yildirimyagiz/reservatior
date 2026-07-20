import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class AttributionService extends BaseService<any, any, any> {
  constructor() { super(prisma.attributionEvent, "attributionEvent"); }

  async getByOrg(orgId: string) {
    return this.model.findMany({ where: { orgId }, orderBy: { createdAt: "desc" } });
  }

  async trackAttribution(data: { orgId: string; campaignId?: string; channel: string; eventType: string; touchpointIndex?: number }) {
    const result = await this.model.create({ data: { ...data, createdAt: new Date() } });
    await eventBus.publish({ event: "ADS_ATTRIBUTION_RECORDED", payload: { id: result.id, campaignId: result.campaignId, touchpoint: result.channel }, source: "AdsOS" });
    return result;
  }

  async getChannelPerformance(orgId: string) {
    const events = await this.model.findMany({ where: { orgId } });
    const byChannel = events.reduce((acc: Record<string, number>, e: any) => { acc[e.channel] = (acc[e.channel] || 0) + 1; return acc; }, {});
    return { orgId, channels: Object.entries(byChannel).map(([channel, count]) => ({ channel, touches: count as number })) };
  }

  async getTouchpoints(attributionId: string) {
    return this.model.findMany({ where: { id: attributionId }, orderBy: { createdAt: "asc" } });
  }
}

export const attributionService = new AttributionService();
