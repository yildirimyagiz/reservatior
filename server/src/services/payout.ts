import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PayoutService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.payout, "payout");
  }
}

export const payoutService = new PayoutService();
