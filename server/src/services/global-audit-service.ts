import { prisma } from "../lib/prisma";

class GlobalAuditLogService {
  async log(data: {
    orgId?: string;
    userId?: string;
    module: string;
    action: string;
    entityId?: string;
    entityType?: string;
    severity?: string;
    description?: string;
    metadata?: any;
    ipAddress?: string;
  }) {
    return prisma.globalAuditLog.create({
      data: {
        ...data,
        severity: data.severity ?? "INFO",
        createdAt: new Date(),
      },
    });
  }

  async getByModule(module: string, params?: { skip?: number; take?: number }) {
    return prisma.globalAuditLog.findMany({
      where: { module },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getByUser(userId: string) {
    return prisma.globalAuditLog.findMany({
      where: { userId },
      orderBy: { createdAt: "desc" },
    });
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number }) {
    return prisma.globalAuditLog.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getByEntity(entityType: string, entityId: string) {
    return prisma.globalAuditLog.findMany({
      where: { entityType, entityId },
      orderBy: { createdAt: "desc" },
    });
  }

  async search(query: string, orgId?: string) {
    return prisma.globalAuditLog.findMany({
      where: {
        ...(orgId && { orgId }),
        OR: [
          { action: { contains: query, mode: "insensitive" } },
          { description: { contains: query, mode: "insensitive" } },
        ],
      },
      orderBy: { createdAt: "desc" },
      take: 50,
    });
  }

  async getStats(orgId?: string) {
    const where = orgId ? { orgId } : {};
    const [total, byModule, bySeverity] = await Promise.all([
      prisma.globalAuditLog.count({ where }),
      prisma.globalAuditLog.groupBy({ by: ["module"], where, _count: { id: true } }),
      prisma.globalAuditLog.groupBy({ by: ["severity"], where, _count: { id: true } }),
    ]);
    return {
      total,
      byModule: byModule.map(m => ({ module: m.module, count: m._count.id })),
      bySeverity: bySeverity.map(s => ({ severity: s.severity, count: s._count.id })),
    };
  }
}

export const globalAuditService = new GlobalAuditLogService();
