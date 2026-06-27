import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class FloorPlanService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.floorPlan, "floorPlan");
  }
}

export const floorPlanService = new FloorPlanService();
