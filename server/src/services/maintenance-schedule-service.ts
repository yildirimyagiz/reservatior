import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

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

  async create(data: any, include?: any) {
    const result = await super.create(data, include);
    await eventBus.publish("OPERATIONS_MAINTENANCE_SCHEDULED" as any, {
      id: result.id,
      propertyId: result.propertyId,
      type: result.type,
      scheduledDate: result.scheduledDate,
    }, "OperationsOS");
    return result;
  }

  async completeMaintenance(id: string, data?: { completedDate?: Date; cost?: number; notes?: string }) {
    const result = await this.model.update({
      where: { id },
      data: {
        status: "COMPLETED",
        completedDate: data?.completedDate ?? new Date(),
        ...(data?.cost !== undefined && { cost: data.cost }),
        ...(data?.notes && { notes: data.notes }),
      },
    });
    await eventBus.publish("OPERATIONS_MAINTENANCE_COMPLETED" as any, {
      id: result.id,
      status: result.status,
    }, "OperationsOS");
    return result;
  }
}

export const maintenanceScheduleService = new MaintenanceScheduleService();
