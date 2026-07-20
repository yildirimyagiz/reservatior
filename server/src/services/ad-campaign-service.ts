import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AdCampaignService extends BaseService<any, any, any> {
  constructor() { super(prisma.adCampaign, "adCampaign"); }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return this.model.findMany({ where: { orgId, ...(params?.status && { status: params.status }) }, orderBy: { createdAt: "desc" }, skip: params?.skip ?? 0, take: params?.take ?? 20 });
  }

  async createCampaign(data: any) {
    return this.model.create({ data: { ...data, status: data.status ?? "DRAFT", createdAt: new Date() } });
  }

  async activateCampaign(id: string) {
    return this.model.update({ where: { id }, data: { status: "ACTIVE", startedAt: new Date() } });
  }

  async pauseCampaign(id: string) {
    return this.model.update({ where: { id }, data: { status: "PAUSED" } });
  }

  async completeCampaign(id: string) {
    return this.model.update({ where: { id }, data: { status: "COMPLETED", endedAt: new Date() } });
  }

  async duplicateCampaign(id: string, name: string) {
    const original = await this.model.findUnique({ where: { id } });
    if (!original) throw new Error("Campaign not found");
    const { id: _id, createdAt, updatedAt, ...rest } = original;
    return this.model.create({ data: { ...rest, name, status: "DRAFT", createdAt: new Date() } });
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
