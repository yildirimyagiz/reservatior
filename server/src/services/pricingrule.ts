import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PricingRuleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.pricingRule, "pricingRule");
  }
}

export const pricingRuleService = new PricingRuleService();
