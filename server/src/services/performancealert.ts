import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PerformanceAlertService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.performanceAlert, "performanceAlert");
  }
}

export const performanceAlertService = new PerformanceAlertService();
