import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AccessAuditService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.accessAuditLog, "accessAuditLog");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number }) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getByUser(userId: string) {
    return this.model.findMany({
      where: { userId },
      orderBy: { createdAt: "desc" },
    });
  }

  async logAccess(data: {
    orgId: string;
    userId: string;
    action: string;
    resource: string;
    resourceId?: string;
    ipAddress?: string;
    userAgent?: string;
    metadata?: any;
  }) {
    return this.model.create({
      data: {
        ...data,
        createdAt: new Date(),
      },
    });
  }

  async getRecentActivity(orgId: string, limit = 50) {
    return this.model.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      take: limit,
    });
  }
}

export const accessAuditService = new AccessAuditService();
