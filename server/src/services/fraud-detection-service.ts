import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class FraudDetectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.fraudDetection, "fraudDetection");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return this.model.findMany({
      where: {
        orgId,
        ...(params?.status && { status: params.status }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getActiveAlerts(orgId: string) {
    return this.model.findMany({
      where: {
        orgId,
        status: { in: ["OPEN", "INVESTIGATING"] },
      },
      orderBy: { createdAt: "desc" },
    });
  }

  async flagSuspiciousActivity(data: {
    orgId: string;
    entityType: string;
    entityId: string;
    riskLevel: string;
    description: string;
    evidence?: any;
  }) {
    const result = await this.model.create({
      data: {
        ...data,
        status: "OPEN",
        createdAt: new Date(),
      },
    });

    await eventBus.publish({
      type: DomainEvents.FRAUD_ALERT_RAISED,
      payload: { id: result.id, entityId: data.entityId, riskScore: data.riskLevel, reason: data.description },
      source: "SecurityOS",
    });

    return result;
  }

  async resolveAlert(id: string, resolution: string, reviewerId?: string) {
    return this.model.update({
      where: { id },
      data: {
        status: "RESOLVED",
        resolution,
        resolvedAt: new Date(),
        ...(reviewerId && { reviewerId }),
      },
    });
  }
}

export const fraudDetectionService = new FraudDetectionService();
