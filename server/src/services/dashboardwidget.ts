import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class DashboardWidgetService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.dashboardWidget, "dashboardWidget");
  }
}

export const dashboardWidgetService = new DashboardWidgetService();
