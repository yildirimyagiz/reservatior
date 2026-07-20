import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class PropertyInspectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyInspection, "propertyInspection");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number }) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { scheduledDate: "asc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getUpcoming(orgId: string) {
    return this.model.findMany({
      where: {
        orgId,
        scheduledDate: { gte: new Date() },
        status: { not: "COMPLETED" },
      },
      orderBy: { scheduledDate: "asc" },
      take: 10,
    });
  }

  async getByProperty(propertyId: string) {
    return this.model.findMany({
      where: { propertyId },
      orderBy: { scheduledDate: "desc" },
    });
  }

  async create(data: any, include?: any) {
    const result = await super.create(data, include);
    await eventBus.publish("OPERATIONS_INSPECTION_SCHEDULED" as any, {
      id: result.id,
      propertyId: result.propertyId,
      inspectorId: result.inspectorId,
      scheduledDate: result.scheduledDate,
    }, "OperationsOS");
    return result;
  }

  async completeInspection(id: string, data?: { result?: string; notes?: string; completedDate?: Date }) {
    const updated = await this.model.update({
      where: { id },
      data: {
        status: "COMPLETED",
        completedDate: data?.completedDate ?? new Date(),
        ...(data?.result && { result: data.result }),
        ...(data?.notes && { notes: data.notes }),
      },
    });
    await eventBus.publish("OPERATIONS_INSPECTION_COMPLETED" as any, {
      id: updated.id,
      result: updated.result,
    }, "OperationsOS");
    return updated;
  }
}

export const propertyInspectionService = new PropertyInspectionService();
