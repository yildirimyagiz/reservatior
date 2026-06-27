import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class IntegrationLogService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.integrationLog, "integrationLog");
  }
}

export const integrationLogService = new IntegrationLogService();
