import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AnalyticsService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.analytics, "analytics");
  }
}

export const analyticsService = new AnalyticsService();
