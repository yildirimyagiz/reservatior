import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AutomationTaskService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.automationTask, "automationTask");
  }
}

export const automationTaskService = new AutomationTaskService();
