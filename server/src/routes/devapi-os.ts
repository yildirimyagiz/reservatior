import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * DevAPI OS — external API gateway, rate limits, and key management.
 * Serves a flat GenericOSDashboard contract ({ kpis, recentActivity, alerts })
 * consumed by the mobile OsDashboardStats provider.
 */
export const devApiOSRoutes = new Elysia({ prefix: "/devapi-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      const where = orgId ? { orgId } : {};
      const [apiKeys, integrations, webhooks, failedDeliveries, recentLogs] = await Promise.all([
        prisma.apiKey.count({ where }),
        prisma.apiIntegration.count({ where }),
        prisma.webhook.count({ where }),
        prisma.webhookDelivery.count({ where: { statusCode: { gte: 400 } } }),
        prisma.integrationLog.findMany({ orderBy: { createdAt: "desc" }, take: 8 }),
      ]);

      return {
        kpis: {
          apiKeys,
          integrations,
          webhooks,
          failedDeliveries,
        },
        recentActivity: recentLogs.map((log) => ({
          title: log.integrationType,
          subtitle: log.operation,
          value: log.success ? "OK" : log.errorMessage || "Failed",
        })),
        alerts: failedDeliveries > 0
          ? [{ type: "warning", title: `${failedDeliveries} delivery failures`, message: `${failedDeliveries} webhook/integration delivery(ies) returned HTTP >= 400.` }]
          : [],
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "DevAPI OS Dashboard", tags: ["DevAPI OS"] },
  });
