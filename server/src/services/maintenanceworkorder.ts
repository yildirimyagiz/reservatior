import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MaintenanceWorkOrderService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.maintenanceWorkOrder, "maintenanceWorkOrder");
  }
}

export const maintenanceWorkOrderService = new MaintenanceWorkOrderService();
