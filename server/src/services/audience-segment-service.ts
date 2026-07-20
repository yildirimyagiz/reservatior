import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AudienceSegmentService extends BaseService<any, any, any> {
  constructor() { super(prisma.audienceSegment, "audienceSegment"); }

  async getByOrg(orgId: string) {
    return this.model.findMany({ where: { orgId }, orderBy: { createdAt: "desc" } });
  }

  async createSegment(data: any) {
    return this.model.create({ data: { ...data, createdAt: new Date() } });
  }

  async generateAISegment(orgId: string, criteria: any) {
    return this.model.create({ data: { orgId, name: `AI Segment - ${new Date().toISOString()}`, criteria, aiGenerated: true, createdAt: new Date() } });
  }

  async getSegmentSize(id: string) {
    const segment = await this.model.findUnique({ where: { id } });
    return { id, estimatedSize: segment?.estimatedSize ?? 0, criteria: segment?.criteria };
  }
}

export const audienceSegmentService = new AudienceSegmentService();
