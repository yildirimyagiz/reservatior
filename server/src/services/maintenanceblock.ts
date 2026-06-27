import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MaintenanceBlockService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.maintenanceBlock, "maintenanceBlock");
  }
}

export const maintenanceBlockService = new MaintenanceBlockService();
