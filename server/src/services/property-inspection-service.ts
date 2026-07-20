import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

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

  async completeInspection(id: string, data?: { result?: string; notes?: string; completedDate?: Date }) {
    return this.model.update({
      where: { id },
      data: {
        status: "COMPLETED",
        completedDate: data?.completedDate ?? new Date(),
        ...(data?.result && { result: data.result }),
        ...(data?.notes && { notes: data.notes }),
      },
    });
  }
}

export const propertyInspectionService = new PropertyInspectionService();
