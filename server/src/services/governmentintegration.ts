import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class GovernmentIntegrationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.governmentIntegration, "governmentIntegration");
  }
}

export const governmentIntegrationService = new GovernmentIntegrationService();
