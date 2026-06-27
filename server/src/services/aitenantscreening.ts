import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AITenantScreeningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aITenantScreening, "aITenantScreening");
  }
}

export const aITenantScreeningService = new AITenantScreeningService();
