import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class DeveloperPlatformService {
  async getDashboard(orgId: string) {
    const [totalApiKeys, activeIntegrations, totalWebhooks, recentLogs, failedDeliveries] = await Promise.all([
      prisma.apiKey.count({ where: { orgId } }),
      prisma.apiIntegration.count({ where: { orgId } }),
      prisma.webhook.count({ where: { orgId } }),
      prisma.integrationLog.findMany({ orderBy: { createdAt: "desc" }, take: 10 }),
      prisma.webhookDelivery.count({ where: { statusCode: { gte: 400 } } }),
    ]);
    return { totalApiKeys, activeIntegrations, totalWebhooks, recentLogs, failedDeliveries };
  }

  async getApiKeys(orgId: string, params?: { skip?: number; take?: number }) {
    return prisma.apiKey.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async createApiKey(data: { orgId: string; name: string; scopes?: string[] }) {
    const key = `rk_${Array.from({ length: 40 }, () => "abcdefghijklmnopqrstuvwxyz0123456789"[Math.floor(Math.random() * 36)]).join("")}`;
    const result = await prisma.apiKey.create({
      data: {
        orgId: data.orgId,
        name: data.name,
        keyHash: key,
        scopes: data.scopes ?? ["read"],
        expiresAt: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000),
        createdAt: new Date(),
      },
    });
    await eventBus.publish({
      event: DomainEvents.API_KEY_CREATED,
      payload: { id: result.id, name: data.name },
      source: "DeveloperOS",
    });
    return result;
  }

  async getIntegrations(orgId: string) {
    return prisma.apiIntegration.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
    });
  }

  async getIntegrationStats() {
    const [total, byPlatform, activeCount] = await Promise.all([
      prisma.apiIntegration.count(),
      prisma.apiIntegration.groupBy({ by: ["platform"], _count: { id: true } }),
      prisma.apiIntegration.count({ where: { status: "ACTIVE" } }),
    ]);
    return { total, activeCount, byPlatform: byPlatform.map(p => ({ platform: p.platform, count: p._count.id })) };
  }

  async getWebhooks(orgId: string) {
    return prisma.webhook.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
    });
  }

  async createWebhook(data: { orgId: string; url: string; events: string[]; secret?: string }) {
    const result = await prisma.webhook.create({
      data: {
        orgId: data.orgId,
        url: data.url,
        events: data.events,
        secret: data.secret ?? `whsec_${Math.random().toString(36).slice(2)}`,
        isActive: true,
        createdAt: new Date(),
      },
    });
    await eventBus.publish({
      event: DomainEvents.WEBHOOK_REGISTERED,
      payload: { id: result.id, url: data.url },
      source: "DeveloperOS",
    });
    return result;
  }

  async getRecentLogs(params?: { skip?: number; take?: number; integrationId?: string }) {
    return prisma.integrationLog.findMany({
      where: { ...(params?.integrationId && { integrationId: params.integrationId }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getWebhookDeliveries(webhookId: string) {
    return prisma.webhookDelivery.findMany({
      where: { webhookId },
      orderBy: { createdAt: "desc" },
      take: 50,
    });
  }
}

export const developerPlatformService = new DeveloperPlatformService();
