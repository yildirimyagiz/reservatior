import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LoyaltyAccountService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.loyaltyAccount, "loyaltyAccount");
  }
}

export const loyaltyAccountService = new LoyaltyAccountService();
