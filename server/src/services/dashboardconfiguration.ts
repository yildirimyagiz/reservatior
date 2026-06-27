import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DashboardConfigurationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.dashboardConfiguration, "dashboardConfiguration");
  }
}

export const dashboardConfigurationService = new DashboardConfigurationService();
