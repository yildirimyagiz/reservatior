import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CampaignService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.campaign, "campaign");
  }

  async activate(campaignId: string) {
    return prisma.campaign.update({
      where: { id: campaignId },
      data: { status: "ACTIVE", startDate: new Date() }
    });
  }

  async pause(campaignId: string) {
    return prisma.campaign.update({
      where: { id: campaignId },
      data: { status: "PAUSED" }
    });
  }

  async complete(campaignId: string) {
    return prisma.campaign.update({
      where: { id: campaignId },
      data: { status: "COMPLETED", endDate: new Date() }
    });
  }
}

export const campaignService = new CampaignService();
