import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class AdCreativeService extends BaseService<any, any, any> {
  constructor() { super(prisma.adCreative, "adCreative"); }

  async getByCampaign(campaignId: string) {
    return this.model.findMany({ where: { campaignId }, orderBy: { createdAt: "desc" } });
  }

  async createCreative(data: any) {
    const result = await this.model.create({ data: { ...data, createdAt: new Date() } });
    await eventBus.publish({ event: DomainEvents.AD_CREATIVE_CREATED, payload: { id: result.id, campaignId: result.campaignId, name: result.name }, source: "AdsOS" });
    return result;
  }

  async startABTest(id: string, variantB: any) {
    return this.model.update({ where: { id }, data: { abTestEnabled: true, variantB, abTestStartedAt: new Date() } });
  }
}

export const adCreativeService = new AdCreativeService();
