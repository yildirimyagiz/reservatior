import { Elysia, t } from "elysia";
import { analyticsEngineService } from "../services/analytics-engine-service";

export const analyticsOSRoutes = new Elysia({ prefix: "/analytics-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await analyticsEngineService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Analytics OS Dashboard", tags: ["Analytics OS"] },
  })

  .get("/analytics", async ({ query, set }) => {
    try {
      const { orgId, page, limit, type } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await analyticsEngineService.getAnalyticsByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        type: type as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      type: t.Optional(t.String()),
    }),
    detail: { summary: "List Analytics Records", tags: ["Analytics OS"] },
  })

  .post("/analytics", async ({ body, set }) => {
    try {
      const data = await analyticsEngineService.createAnalytics(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      entityId: t.String(),
      entityType: t.String(),
      type: t.String(),
      data: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Analytics Record", tags: ["Analytics OS"] },
  })

  .get("/analytics/stats", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await analyticsEngineService.getAnalyticsStats(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Analytics Statistics", tags: ["Analytics OS"] },
  })

  .get("/reports", async ({ query, set }) => {
    try {
      const { orgId, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await analyticsEngineService.getReports(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Reports", tags: ["Analytics OS"] },
  })

  .post("/reports", async ({ body, set }) => {
    try {
      const data = await analyticsEngineService.createReport(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      userId: t.String(),
      name: t.String(),
      reportType: t.String(),
      config: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Report", tags: ["Analytics OS"] },
  })

  .get("/reports/:id/executions", async ({ params, set }) => {
    try {
      const data = await analyticsEngineService.getReportExecutions(params.id);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Report Executions", tags: ["Analytics OS"] },
  })

  .get("/dashboards", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await analyticsEngineService.getDashboards(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Dashboards", tags: ["Analytics OS"] },
  })

  .get("/metrics", async ({ query, set }) => {
    try {
      const { page, limit, metricType } = query;
      const data = await analyticsEngineService.getSystemMetrics({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        metricType: metricType as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      metricType: t.Optional(t.String()),
    }),
    detail: { summary: "Get System Metrics", tags: ["Analytics OS"] },
  })

  .get("/alerts", async ({ query, set }) => {
    try {
      const { page, limit, severity } = query;
      const data = await analyticsEngineService.getPerformanceAlerts({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        severity: severity as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      severity: t.Optional(t.String()),
    }),
    detail: { summary: "Get Performance Alerts", tags: ["Analytics OS"] },
  })

  .get("/health", async ({ set }) => {
    try {
      const data = await analyticsEngineService.getHealthChecks();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Health Checks", tags: ["Analytics OS"] },
  });
