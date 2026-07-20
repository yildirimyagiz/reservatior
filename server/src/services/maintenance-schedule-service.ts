import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MaintenanceScheduleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.maintenanceSchedule, "maintenanceSchedule");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return this.model.findMany({
      where: {
        orgId,
        ...(params?.status && { status: params.status }),
      },
      orderBy: { scheduledDate: "asc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getByProperty(propertyId: string) {
    return this.model.findMany({
      where: { propertyId },
      orderBy: { scheduledDate: "asc" },
    });
  }

  async getOverdue(orgId: string) {
    return this.model.findMany({
      where: {
        orgId,
        scheduledDate: { lt: new Date() },
        status: { not: "COMPLETED" },
      },
      orderBy: { scheduledDate: "asc" },
    });
  }

  async completeMaintenance(id: string, data?: { completedDate?: Date; cost?: number; notes?: string }) {
    return this.model.update({
      where: { id },
      data: {
        status: "COMPLETED",
        completedDate: data?.completedDate ?? new Date(),
        ...(data?.cost !== undefined && { cost: data.cost }),
        ...(data?.notes && { notes: data.notes }),
      },
    });
  }
}

export const maintenanceScheduleService = new MaintenanceScheduleService();
