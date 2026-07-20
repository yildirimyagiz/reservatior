import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class AdCampaignService extends BaseService<any, any, any> {
  constructor() { super(prisma.adCampaign, "adCampaign"); }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return this.model.findMany({ where: { orgId, ...(params?.status && { status: params.status }) }, orderBy: { createdAt: "desc" }, skip: params?.skip ?? 0, take: params?.take ?? 20 });
  }

  async createCampaign(data: any) {
    const result = await this.model.create({ data: { ...data, status: data.status ?? "DRAFT", createdAt: new Date() } });
    await eventBus.publish({ event: DomainEvents.AD_CAMPAIGN_CREATED, payload: { id: result.id, name: result.name, budget: result.budget }, source: "AdsOS" });
    return result;
  }

  async activateCampaign(id: string) {
    const result = await this.model.update({ where: { id }, data: { status: "ACTIVE", startedAt: new Date() } });
    await eventBus.publish({ event: "ADS_CAMPAIGN_STATUS_CHANGED", payload: { id, status: "ACTIVE" }, source: "AdsOS" });
    return result;
  }

  async pauseCampaign(id: string) {
    const result = await this.model.update({ where: { id }, data: { status: "PAUSED" } });
    await eventBus.publish({ event: "ADS_CAMPAIGN_STATUS_CHANGED", payload: { id, status: "PAUSED" }, source: "AdsOS" });
    return result;
  }

  async completeCampaign(id: string) {
    const result = await this.model.update({ where: { id }, data: { status: "COMPLETED", endedAt: new Date() } });
    await eventBus.publish({ event: "ADS_CAMPAIGN_STATUS_CHANGED", payload: { id, status: "COMPLETED" }, source: "AdsOS" });
    return result;
  }

  async duplicateCampaign(id: string, name: string) {
    const original = await this.model.findUnique({ where: { id } });
    if (!original) throw new Error("Campaign not found");
    const { id: _id, createdAt, updatedAt, ...rest } = original;
    const result = await this.model.create({ data: { ...rest, name, status: "DRAFT", createdAt: new Date() } });
    await eventBus.publish({ event: DomainEvents.AD_CAMPAIGN_CREATED, payload: { id: result.id, name: result.name, budget: result.budget }, source: "AdsOS" });
    return result;
  }

  async getCampaignStats(orgId: string) {
    const [total, byStatus] = await Promise.all([
      this.model.count({ where: { orgId } }),
      this.model.groupBy({ by: ["status"], where: { orgId }, _count: { id: true } }),
    ]);
    return { total, byStatus: byStatus.map((s: any) => ({ status: s.status, count: s._count.id })) };
  }
}

export const adCampaignService = new AdCampaignService();
