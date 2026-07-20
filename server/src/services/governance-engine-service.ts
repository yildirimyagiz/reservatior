import { prisma } from "../lib/prisma";

export class GovernanceEngineService {
  async getDashboard(orgId: string) {
    const [rules, activeCompliance, pendingApprovals, recentAudits, complianceByType] = await Promise.all([
      prisma.automationRule.count({ where: { orgId } }),
      prisma.complianceRecord.count({ where: { status: "APPROVED" } }),
      prisma.complianceRecord.count({ where: { status: "PENDING" } }),
      prisma.auditLog.findMany({ orderBy: { createdAt: "desc" }, take: 10 }),
      prisma.complianceRecord.groupBy({ by: ["type"], _count: { id: true } }),
    ]);
    return { rules, activeCompliance, pendingApprovals, recentAudits, complianceByType };
  }

  async getRulesByOrg(orgId: string, params?: { skip?: number; take?: number; status?: string }) {
    return prisma.automationRule.findMany({
      where: { orgId, ...(params?.status && { status: params.status }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getComplianceRecords(params?: { skip?: number; take?: number; status?: string; type?: string }) {
    return prisma.complianceRecord.findMany({
      where: {
        ...(params?.status && { status: params.status }),
        ...(params?.type && { type: params.type }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getComplianceStats() {
    const [total, byStatus, byType] = await Promise.all([
      prisma.complianceRecord.count(),
      prisma.complianceRecord.groupBy({ by: ["status"], _count: { id: true } }),
      prisma.complianceRecord.groupBy({ by: ["type"], _count: { id: true } }),
    ]);
    return {
      total,
      byStatus: byStatus.map(s => ({ status: s.status, count: s._count.id })),
      byType: byType.map(t => ({ type: t.type, count: t._count.id })),
    };
  }

  async getLegalCompliance(orgId: string) {
    return prisma.legalCompliance.findMany({
      where: { property: { orgId } },
      orderBy: { createdAt: "desc" },
      take: 50,
    });
  }

  async getAuditTrail(params?: { skip?: number; take?: number; entityType?: string; action?: string }) {
    return prisma.auditLog.findMany({
      where: {
        ...(params?.entityType && { entityType: params.entityType }),
        ...(params?.action && { action: params.action }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async createComplianceRecord(data: { type: string; entityId: string; entityType: string; status?: string; notes?: string }) {
    return prisma.complianceRecord.create({
      data: {
        ...data,
        status: data.status ?? "PENDING",
        createdAt: new Date(),
      },
    });
  }

  async updateComplianceStatus(id: string, status: string, notes?: string) {
    return prisma.complianceRecord.update({
      where: { id },
      data: { status, ...(notes && { notes }) },
    });
  }
}

export const governanceEngineService = new GovernanceEngineService();
