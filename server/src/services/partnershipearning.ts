import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PartnershipEarningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.partnershipEarning, "partnershipEarning");
  }
}

export const partnershipEarningService = new PartnershipEarningService();
