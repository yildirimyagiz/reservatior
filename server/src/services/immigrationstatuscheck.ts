import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ImmigrationStatusCheckService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.immigrationStatusCheck, "immigrationStatusCheck");
  }
}

export const immigrationStatusCheckService = new ImmigrationStatusCheckService();
