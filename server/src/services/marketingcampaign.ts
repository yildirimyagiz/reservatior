import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MarketingCampaignService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.marketingCampaign, "marketingCampaign");
  }
}

export const marketingCampaignService = new MarketingCampaignService();
