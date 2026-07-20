import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class AudienceSegmentService extends BaseService<any, any, any> {
  constructor() { super(prisma.audienceSegment, "audienceSegment"); }

  async getByOrg(orgId: string) {
    return this.model.findMany({ where: { orgId }, orderBy: { createdAt: "desc" } });
  }

  async createSegment(data: any) {
    const result = await this.model.create({ data: { ...data, createdAt: new Date() } });
    await eventBus.publish({ event: DomainEvents.AUDIENCE_SEGMENT_CREATED, payload: { id: result.id, name: result.name, criteria: result.criteria }, source: "AdsOS" });
    return result;
  }

  async generateAISegment(orgId: string, criteria: any) {
    const result = await this.model.create({ data: { orgId, name: `AI Segment - ${new Date().toISOString()}`, criteria, aiGenerated: true, createdAt: new Date() } });
    await eventBus.publish({ event: DomainEvents.AUDIENCE_SEGMENT_CREATED, payload: { id: result.id, name: result.name, criteria: result.criteria }, source: "AdsOS" });
    return result;
  }

  async getSegmentSize(id: string) {
    const segment = await this.model.findUnique({ where: { id } });
    return { id, estimatedSize: segment?.estimatedSize ?? 0, criteria: segment?.criteria };
  }
}

export const audienceSegmentService = new AudienceSegmentService();
