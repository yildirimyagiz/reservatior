import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SystemMetricsService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.systemMetrics, "systemMetrics");
  }
}

export const systemMetricsService = new SystemMetricsService();
