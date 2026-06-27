import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PlanService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.plan, "plan");
  }
}

export const planService = new PlanService();
