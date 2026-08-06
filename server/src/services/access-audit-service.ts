import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

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
    const result = await this.model.create({
      data: {
        ...data,
        createdAt: new Date(),
      },
    });

    await eventBus.publish(
      DomainEvents.ACCESS_LOG_RECORDED,
      { id: result.id, userId: data.userId, action: data.action, resource: data.resource },
      "SecurityOS",
    );

    return result;
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
