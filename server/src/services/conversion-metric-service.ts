import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class ConversionMetricService extends BaseService<any, any, any> {
  constructor() { super(prisma.conversionMetric, "conversionMetric"); }

  async getByOrg(orgId: string) {
    return this.model.findMany({ where: { orgId }, orderBy: { createdAt: "desc" } });
  }

  async trackConversion(data: { orgId: string; campaignId?: string; metricType: string; value: number; metadata?: any }) {
    const result = await this.model.create({ data: { ...data, createdAt: new Date() } });
    await eventBus.publish({ event: "ADS_CONVERSION_RECORDED", payload: { id: result.id, campaignId: result.campaignId, value: result.value }, source: "AdsOS" });
    return result;
  }

  async getFunnel(orgId: string) {
    const metrics = await this.model.findMany({ where: { orgId } });
    const byType = metrics.reduce((acc: Record<string, number>, m: any) => { acc[m.metricType] = (acc[m.metricType] || 0) + m.value; return acc; }, {});
    return { orgId, funnel: Object.entries(byType).map(([type, total]) => ({ type, total: total as number })) };
  }

  async getROAS(orgId: string) {
    const metrics = await this.model.findMany({ where: { orgId } });
    const revenue = metrics.filter((m: any) => m.metricType === "REVENUE").reduce((sum: number, m: any) => sum + m.value, 0);
    const adSpend = metrics.filter((m: any) => m.metricType === "AD_SPEND").reduce((sum: number, m: any) => sum + m.value, 0);
    return { orgId, roas: adSpend > 0 ? revenue / adSpend : 0, revenue, adSpend };
  }
}

export const conversionMetricService = new ConversionMetricService();
