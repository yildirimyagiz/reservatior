import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

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
    return this.model.create({
      data: {
        ...data,
        status: "PENDING",
        createdAt: new Date(),
      },
    });
  }

  async approveVerification(id: string, reviewerId?: string) {
    return this.model.update({
      where: { id },
      data: {
        status: "APPROVED",
        reviewedAt: new Date(),
        ...(reviewerId && { reviewerId }),
      },
    });
  }

  async rejectVerification(id: string, reason?: string, reviewerId?: string) {
    return this.model.update({
      where: { id },
      data: {
        status: "REJECTED",
        reviewedAt: new Date(),
        ...(reason && { rejectionReason: reason }),
        ...(reviewerId && { reviewerId }),
      },
    });
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
