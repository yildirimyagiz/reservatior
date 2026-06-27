import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class HealthCheckService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.healthCheck, "healthCheck");
  }
}

export const healthCheckService = new HealthCheckService();
