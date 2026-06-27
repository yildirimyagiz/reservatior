import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ReferralService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.referral, "referral");
  }
}

export const referralService = new ReferralService();
