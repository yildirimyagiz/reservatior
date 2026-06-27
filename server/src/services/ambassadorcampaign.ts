import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AmbassadorCampaignService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.ambassadorCampaign, "ambassadorCampaign");
  }
}

export const ambassadorCampaignService = new AmbassadorCampaignService();
