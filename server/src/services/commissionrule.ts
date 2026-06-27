import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CommissionRuleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.commissionRule, "commissionRule");
  }
}

export const commissionRuleService = new CommissionRuleService();
