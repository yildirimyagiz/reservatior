import { Elysia, t } from "elysia";
import { governanceEngineService } from "../services/governance-engine-service";

export const governanceOSRoutes = new Elysia({ prefix: "/governance-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await governanceEngineService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Governance OS Dashboard", tags: ["Governance OS"] },
  })

  .get("/rules", async ({ query, set }) => {
    try {
      const { orgId, page, limit, status } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await governanceEngineService.getRulesByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
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
      status: t.Optional(t.String()),
    }),
    detail: { summary: "List Governance Rules", tags: ["Governance OS"] },
  })

  .get("/compliance", async ({ query, set }) => {
    try {
      const { page, limit, status, type } = query;
      const data = await governanceEngineService.getComplianceRecords({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
        type: type as string,
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
      status: t.Optional(t.String()),
      type: t.Optional(t.String()),
    }),
    detail: { summary: "List Compliance Records", tags: ["Governance OS"] },
  })

  .get("/compliance/stats", async ({ set }) => {
    try {
      const data = await governanceEngineService.getComplianceStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Compliance Statistics", tags: ["Governance OS"] },
  })

  .post("/compliance", async ({ body, set }) => {
    try {
      const data = await governanceEngineService.createComplianceRecord(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      type: t.String(),
      entityId: t.String(),
      entityType: t.String(),
      status: t.Optional(t.String()),
      notes: t.Optional(t.String()),
    }),
    detail: { summary: "Create Compliance Record", tags: ["Governance OS"] },
  })

  .patch("/compliance/:id", async ({ params, body, set }) => {
    try {
      const { status, notes } = body as any;
      const data = await governanceEngineService.updateComplianceStatus(params.id, status, notes);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      status: t.String(),
      notes: t.Optional(t.String()),
    }),
    detail: { summary: "Update Compliance Status", tags: ["Governance OS"] },
  })

  .get("/legal/:orgId", async ({ params, set }) => {
    try {
      const data = await governanceEngineService.getLegalCompliance(params.orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Legal Compliance by Organization", tags: ["Governance OS"] },
  })

  .get("/audit-trail", async ({ query, set }) => {
    try {
      const { page, limit, entityType, action } = query;
      const data = await governanceEngineService.getAuditTrail({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        entityType: entityType as string,
        action: action as string,
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
      entityType: t.Optional(t.String()),
      action: t.Optional(t.String()),
    }),
    detail: { summary: "Get Audit Trail", tags: ["Governance OS"] },
  });
