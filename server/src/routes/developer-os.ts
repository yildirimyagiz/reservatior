import { Elysia, t } from "elysia";
import { developerPlatformService } from "../services/developer-platform-service";

export const developerOSRoutes = new Elysia({ prefix: "/developer-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await developerPlatformService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Developer API OS Dashboard", tags: ["Developer API OS"] },
  })

  .get("/api-keys", async ({ query, set }) => {
    try {
      const { orgId, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await developerPlatformService.getApiKeys(orgId, {
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
    detail: { summary: "List API Keys", tags: ["Developer API OS"] },
  })

  .post("/api-keys", async ({ body, set }) => {
    try {
      const data = await developerPlatformService.createApiKey(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      scopes: t.Optional(t.Array(t.String())),
    }),
    detail: { summary: "Create API Key", tags: ["Developer API OS"] },
  })

  .get("/integrations", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await developerPlatformService.getIntegrations(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Integrations", tags: ["Developer API OS"] },
  })

  .get("/integrations/stats", async ({ set }) => {
    try {
      const data = await developerPlatformService.getIntegrationStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Integration Statistics", tags: ["Developer API OS"] },
  })

  .get("/webhooks", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await developerPlatformService.getWebhooks(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Webhooks", tags: ["Developer API OS"] },
  })

  .post("/webhooks", async ({ body, set }) => {
    try {
      const data = await developerPlatformService.createWebhook(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      url: t.String(),
      events: t.Array(t.String()),
      secret: t.Optional(t.String()),
    }),
    detail: { summary: "Create Webhook", tags: ["Developer API OS"] },
  })

  .get("/logs", async ({ query, set }) => {
    try {
      const { page, limit, integrationId } = query;
      const data = await developerPlatformService.getRecentLogs({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        integrationId: integrationId as string,
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
      integrationId: t.Optional(t.String()),
    }),
    detail: { summary: "Get Integration Logs", tags: ["Developer API OS"] },
  })

  .get("/webhooks/:id/deliveries", async ({ params, set }) => {
    try {
      const data = await developerPlatformService.getWebhookDeliveries(params.id);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Webhook Deliveries", tags: ["Developer API OS"] },
  });
