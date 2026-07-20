import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AdCreativeService extends BaseService<any, any, any> {
  constructor() { super(prisma.adCreative, "adCreative"); }

  async getByCampaign(campaignId: string) {
    return this.model.findMany({ where: { campaignId }, orderBy: { createdAt: "desc" } });
  }

  async createCreative(data: any) {
    return this.model.create({ data: { ...data, createdAt: new Date() } });
  }

  async startABTest(id: string, variantB: any) {
    return this.model.update({ where: { id }, data: { abTestEnabled: true, variantB, abTestStartedAt: new Date() } });
  }
}

export const adCreativeService = new AdCreativeService();
