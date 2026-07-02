import { Elysia, t } from "elysia";
import { reputationEngine } from "../services/reputation/reputation-engine";
import { crossValidator } from "../services/reputation/cross-validator";
import { decayScheduler } from "../services/reputation/decay-scheduler";
import { signalRegistry } from "../services/reputation/signal-registry";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";

export const reputationRoutes = new Elysia({ prefix: "/reputation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/agent/:agentId", async ({ params, region, db }) => {
    const score = await reputationEngine.calculateAgentScore(params.agentId, region);
    return { success: true, data: score };
  }, {
    params: t.Object({ agentId: t.String() }),
  })

  .get("/agent/:agentId/public", async ({ params, region }) => {
    const exportData = await reputationEngine.getPublicExport(params.agentId, region);
    return { success: true, data: exportData };
  }, {
    params: t.Object({ agentId: t.String() }),
  })

  .get("/tenant/:tenantId", async ({ params, region }) => {
    const score = await reputationEngine.calculateTenantScore(params.tenantId, region);
    return { success: true, data: score };
  }, {
    params: t.Object({ tenantId: t.String() }),
  })

  .get("/validate/agent/:agentId", async ({ params, region }) => {
    const result = await crossValidator.validateAgent(params.agentId, region);
    return { success: true, data: result };
  }, {
    params: t.Object({ agentId: t.String() }),
  })

  .get("/validate/tenant/:tenantId", async ({ params, region }) => {
    const result = await crossValidator.validateTenant(params.tenantId, region);
    return { success: true, data: result };
  }, {
    params: t.Object({ tenantId: t.String() }),
  })

  .get("/validate/landlord/:orgId", async ({ params, region }) => {
    const result = await crossValidator.validateLandlord(params.orgId, region);
    return { success: true, data: result };
  }, {
    params: t.Object({ orgId: t.String() }),
  })

  .get("/signals", async () => {
    return {
      success: true,
      data: {
        all: signalRegistry.getAllSignals(),
        public: signalRegistry.getExportableSignals(),
        internalWeight: signalRegistry.getInternalWeight(),
      },
    };
  })

  .get("/decay/:entityId", async ({ params, region }) => {
    const history = await decayScheduler.getDecayHistory(params.entityId, region);
    return { success: true, data: history };
  }, {
    params: t.Object({ entityId: t.String() }),
  })

  .post("/decay/run", async ({ region }) => {
    const result = await decayScheduler.applyDecay(region);
    return { success: true, data: result };
  })

  .post("/decay/re-engage", async ({ body, region }) => {
    const { entityId, entityType } = body as { entityId: string; entityType: "AGENT" | "TENANT" | "LANDLORD" };
    await decayScheduler.applyReEngagementBoost(entityId, entityType, region);
    return { success: true };
  }, {
    body: t.Object({
      entityId: t.String(),
      entityType: t.Union([t.Literal("AGENT"), t.Literal("TENANT"), t.Literal("LANDLORD")]),
    }),
  });
