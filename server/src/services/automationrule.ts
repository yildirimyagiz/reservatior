import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AutomationRuleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.automationRule, "automationRule");
  }
}

export const automationRuleService = new AutomationRuleService();
