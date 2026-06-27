import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ApiIntegrationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.apiIntegration, "apiIntegration");
  }
}

export const apiIntegrationService = new ApiIntegrationService();
