import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class IdentityAccessService {
  async getDashboard(orgId: string) {
    const [totalUsers, activeSessions, totalRoles, totalApiKeys, recentUsers, providerBreakdown] = await Promise.all([
      prisma.user.count(),
      prisma.session.count({ where: { expiresAt: { gt: new Date() } } }),
      prisma.role.count({ where: { orgId } }),
      prisma.apiKey.count({ where: { orgId } }),
      prisma.user.findMany({ orderBy: { createdAt: "desc" }, take: 10, select: { id: true, email: true, name: true, createdAt: true, locale: true } }),
      prisma.account.groupBy({ by: ["providerId"], _count: { id: true } }),
    ]);
    return { totalUsers, activeSessions, totalRoles, totalApiKeys, recentUsers, providerBreakdown: providerBreakdown.map(p => ({ provider: p.providerId, count: p._count.id })) };
  }

  async getUsers(params?: { skip?: number; take?: number; search?: string }) {
    return prisma.user.findMany({
      where: { ...(params?.search && { OR: [{ email: { contains: params.search } }, { name: { contains: params.search } }] }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
      select: { id: true, email: true, name: true, phone: true, imageUrl: true, locale: true, timezone: true, createdAt: true },
    });
  }

  async getUserStats() {
    const [total, byLocale] = await Promise.all([
      prisma.user.count(),
      prisma.user.groupBy({ by: ["locale"], _count: { id: true }, orderBy: { _count: { id: "desc" } }, take: 10 }),
    ]);
    return { total, byLocale: byLocale.map(l => ({ locale: l.locale, count: l._count.id })) };
  }

  async getSessions(params?: { skip?: number; take?: number; userId?: string }) {
    return prisma.session.findMany({
      where: {
        ...(params?.userId && { userId: params.userId }),
        expiresAt: { gt: new Date() },
      },
      orderBy: { expiresAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getActiveSessionCount() {
    return prisma.session.count({ where: { expiresAt: { gt: new Date() } } });
  }

  async getRoles(orgId: string) {
    return prisma.role.findMany({
      where: { orgId },
      include: { permissions: { include: { permission: true } } },
      orderBy: { name: "asc" },
    });
  }

  async getPermissions() {
    return prisma.permission.findMany({ orderBy: { key: "asc" } });
  }

  async getAccounts(userId: string) {
    return prisma.account.findMany({
      where: { userId },
      select: { id: true, type: true, providerId: true, isActive: true, createdAt: true },
    });
  }

  async getMembersByOrg(orgId: string) {
    return prisma.organizationMember.findMany({
      where: { orgId },
      include: { user: { select: { id: true, email: true, name: true } }, role: { select: { name: true, key: true } } },
    });
  }

  async getApiKeys(orgId: string) {
    return prisma.apiKey.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      select: { id: true, name: true, scopes: true, lastUsedAt: true, expiresAt: true, createdAt: true },
    });
  }

  async revokeSession(id: string) {
    const result = await prisma.session.delete({ where: { id } });
    await eventBus.publish(DomainEvents.SESSION_REVOKED, { id: result.id }, "IdentityOS");
    return result;
  }
}

export const identityAccessService = new IdentityAccessService();
