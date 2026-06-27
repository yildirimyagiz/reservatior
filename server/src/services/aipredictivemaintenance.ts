import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIPredictiveMaintenanceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIPredictiveMaintenance, "aIPredictiveMaintenance");
  }
}

export const aIPredictiveMaintenanceService = new AIPredictiveMaintenanceService();
