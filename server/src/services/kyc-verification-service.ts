import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class KYCVerificationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.kYCVerification, "kYCVerification");
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

  async getByUser(userId: string) {
    return this.model.findMany({
      where: { userId },
      orderBy: { createdAt: "desc" },
    });
  }

  async submitVerification(data: {
    userId: string;
    orgId: string;
    documentType: string;
    documentNumber?: string;
    documentUrl?: string;
    metadata?: any;
  }) {
    const result = await this.model.create({
      data: {
        ...data,
        status: "PENDING",
        createdAt: new Date(),
      },
    });

    await eventBus.publish({
      type: DomainEvents.KYC_SUBMITTED,
      payload: { id: result.id, userId: result.userId, type: data.documentType },
      source: "SecurityOS",
    });

    return result;
  }

  async approveVerification(id: string, reviewerId?: string) {
    const result = await this.model.update({
      where: { id },
      data: {
        status: "APPROVED",
        reviewedAt: new Date(),
        ...(reviewerId && { reviewerId }),
      },
    });

    await eventBus.publish({
      type: DomainEvents.KYC_APPROVED,
      payload: { id: result.id, userId: result.userId, status: "APPROVED" },
      source: "SecurityOS",
    });

    return result;
  }

  async rejectVerification(id: string, reason?: string, reviewerId?: string) {
    const result = await this.model.update({
      where: { id },
      data: {
        status: "REJECTED",
        reviewedAt: new Date(),
        ...(reason && { rejectionReason: reason }),
        ...(reviewerId && { reviewerId }),
      },
    });

    await eventBus.publish({
      type: DomainEvents.KYC_REJECTED,
      payload: { id: result.id, userId: result.userId, status: "REJECTED" },
      source: "SecurityOS",
    });

    return result;
  }

  async getStats(orgId: string) {
    const [total, byStatus] = await Promise.all([
      this.model.count({ where: { orgId } }),
      this.model.groupBy({ by: ["status"], where: { orgId }, _count: { id: true } }),
    ]);
    return {
      total,
      byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })),
    };
  }
}

export const kycVerificationService = new KYCVerificationService();
