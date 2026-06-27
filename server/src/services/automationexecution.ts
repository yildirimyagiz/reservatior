import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AutomationExecutionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.automationExecution, "automationExecution");
  }
}

export const automationExecutionService = new AutomationExecutionService();
