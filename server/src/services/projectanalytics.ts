import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ProjectAnalyticsService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.projectAnalytics, "projectAnalytics");
  }
}

export const projectAnalyticsService = new ProjectAnalyticsService();
