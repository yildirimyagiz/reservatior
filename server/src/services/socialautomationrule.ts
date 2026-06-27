import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialAutomationRuleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialAutomationRule, "socialAutomationRule");
  }
}

export const socialAutomationRuleService = new SocialAutomationRuleService();
