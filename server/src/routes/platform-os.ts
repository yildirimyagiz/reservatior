import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

/**
 * Platform OS — Unified dashboard for system health, metrics, audit trail.
 *
 * Existing sub-routes: /config, /system, /health-checks, /system-metrics,
 *   /dashboard-configurations
 *
 * This OS route provides the aggregated dashboard + cross-cutting queries.
 */
export const platformOSRoutes = new Elysia({ prefix: "/platform-os" })
  .use(authMiddleware)

  // ─── Dashboard ───────────────────────────────────────────────────────────
  .get(
    "/dashboard",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const [totalHealthChecks, failedHealthChecks, totalMetrics, recentAudits, totalOrgs] =
          await Promise.all([
            prisma.healthCheck.count({ where: { orgId } }),
            prisma.healthCheck.count({ where: { orgId, status: "FAILED" } }),
            prisma.systemMetrics.count({ where: { orgId } }),
            prisma.auditLog.count({ where: { orgId } }),
            prisma.organization.count(),
          ]);

        return {
          success: true,
          data: {
            health: { total: totalHealthChecks, failed: failedHealthChecks, healthy: totalHealthChecks - failedHealthChecks },
            metricsCount: totalMetrics,
            auditEntries: recentAudits,
            totalOrganizations: totalOrgs,
          },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["Platform OS"], summary: "Platform dashboard overview" } }
  )

  // ─── Organizations (Tenants) ─────────────────────────────────────────────
  .get(
    "/tenants",
    async ({ query, set }) => {
      const { page = 1, limit = 20 } = query;
      try {
        const [tenants, total] = await Promise.all([
          prisma.organization.findMany({
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
            select: { id: true, name: true, type: true, region: true, defaultCurrency: true, createdAt: true },
          }),
          prisma.organization.count(),
        ]);
        return { success: true, data: { tenants, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Platform OS"], summary: "List tenants (organizations)" },
    }
  )

  // ─── Health Checks ───────────────────────────────────────────────────────
  .get(
    "/health",
    async ({ query, set }) => {
      const { orgId, serviceName, page = 1, limit = 50 } = query;
      try {
        const where: any = {};
        if (orgId) where.orgId = orgId;
        if (serviceName) where.serviceName = serviceName;
        const checks = await prisma.healthCheck.findMany({
          where,
          skip: (page - 1) * limit,
          take: limit,
          orderBy: { checkedAt: "desc" },
        });
        const summary = {
          total: checks.length,
          passed: checks.filter((c) => c.status === "PASSED").length,
          failed: checks.filter((c) => c.status === "FAILED").length,
          degraded: checks.filter((c) => c.status === "DEGRADED").length,
        };
        return { success: true, data: { checks, summary } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.Optional(t.String()),
        serviceName: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Platform OS"], summary: "Health check results" },
    }
  )

  // ─── System Metrics ──────────────────────────────────────────────────────
  .get(
    "/metrics",
    async ({ query, set }) => {
      const { orgId, metricType, from, to } = query;
      try {
        const where: any = {};
        if (orgId) where.orgId = orgId;
        if (metricType) where.metricType = metricType;
        if (from || to) {
          where.timestamp = {};
          if (from) where.timestamp.gte = new Date(from);
          if (to) where.timestamp.lte = new Date(to);
        }
        const metrics = await prisma.systemMetrics.findMany({
          where,
          orderBy: { timestamp: "desc" },
          take: 100,
        });
        return { success: true, data: metrics };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.Optional(t.String()),
        metricType: t.Optional(t.String()),
        from: t.Optional(t.String()),
        to: t.Optional(t.String()),
      }),
      detail: { tags: ["Platform OS"], summary: "System metrics" },
    }
  )

  // ─── Audit Trail ─────────────────────────────────────────────────────────
  .get(
    "/audit-trail",
    async ({ query, set }) => {
      const { orgId, action, entityType, page = 1, limit = 50 } = query;
      try {
        const where: any = {};
        if (orgId) where.orgId = orgId;
        if (action) where.action = action;
        if (entityType) where.entityType = entityType;
        const [entries, total] = await Promise.all([
          prisma.auditLog.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
          }),
          prisma.auditLog.count({ where }),
        ]);
        return { success: true, data: { entries, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.Optional(t.String()),
        action: t.Optional(t.String()),
        entityType: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Platform OS"], summary: "Platform audit trail" },
    }
  )

  // ─── Tickets ─────────────────────────────────────────────────────────────
  .get(
    "/tickets",
    async ({ query, set }) => {
      const { status, page = 1, limit = 20 } = query;
      try {
        const where: any = {};
        if (status) where.status = status;
        const [tickets, total] = await Promise.all([
          prisma.ticket.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
            include: { User: { select: { id: true, name: true, email: true } } },
          }),
          prisma.ticket.count({ where }),
        ]);
        return { success: true, data: { tickets, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        status: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Platform OS"], summary: "Platform support tickets" },
    }
  )

  // ─── Config (Organization) ───────────────────────────────────────────────
  .get(
    "/config",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const org = await prisma.organization.findUnique({
          where: { id: orgId },
          select: {
            id: true,
            name: true,
            type: true,
            region: true,
            defaultCurrency: true,
            defaultLocale: true,
            complianceTracking: true,
            taxReportingEnabled: true,
          },
        });
        if (!org) {
          set.status = 404;
          return { success: false, error: "Organization not found" };
        }
        return { success: true, data: org };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["Platform OS"], summary: "Organization configuration" } }
  );
