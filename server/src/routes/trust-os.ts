import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { tenantTrustScoreService } from "../services/trust/tenant-trust-score.service";
import { landlordTrustScoreService } from "../services/trust/landlord-trust-score.service";
import { agentReputationService } from "../services/trust/agent-reputation.service";
import { propertyTrustScoreService } from "../services/trust/property-trust-score.service";
import { transactionTrustScoreService } from "../services/trust/transaction-trust-score.service";
import { trustGraphService } from "../services/trust/trust-graph.service";
import { aiTrustEngineService } from "../services/trust/ai-trust-engine.service";

/**
 * Trust OS — user verification, fraud prevention, and reputation scores.
 * Serves a flat GenericOSDashboard contract ({ kpis, recentActivity, alerts })
 * consumed by the mobile OsDashboardStats provider.
 */
export const trustOSRoutes = new Elysia({ prefix: "/trust-os" })

  // Tenant Trust Endpoints
  .get("/tenant/:tenantId", async ({ params, set }) => {
    try {
      const profile = await tenantTrustScoreService.getTrustProfile(params.tenantId);
      if (!profile) {
        set.status = 404;
        return { success: false, error: "Tenant trust profile not found" };
      }
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Tenant Trust Profile", tags: ["Trust OS", "Tenant"] },
  })

  .post("/tenant/:tenantId/calculate", async ({ params, query, set }) => {
    try {
      const profile = await tenantTrustScoreService.calculateTrustScore(params.tenantId, query.orgId);
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Calculate Tenant Trust Score", tags: ["Trust OS", "Tenant"] },
  })

  .post("/tenant/:tenantId/event", async ({ params, body, set }) => {
    try {
      await tenantTrustScoreService.recordTrustEvent(
        params.tenantId,
        body.eventType,
        "PAYMENT" as any,
        body.impact,
        body.metadata
      );
      return { success: true, message: "Trust event recorded" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      eventType: t.String(),
      impact: t.Number(),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Record Tenant Trust Event", tags: ["Trust OS", "Tenant"] },
  })

  .get("/tenant/:tenantId/history", async ({ params, set }) => {
    try {
      const history = await tenantTrustScoreService.getTrustHistory(params.tenantId);
      return { success: true, data: history };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Tenant Trust History", tags: ["Trust OS", "Tenant"] },
  })

  // Landlord Trust Endpoints
  .get("/landlord/:landlordId", async ({ params, set }) => {
    try {
      const profile = await landlordTrustScoreService.getTrustProfile(params.landlordId);
      if (!profile) {
        set.status = 404;
        return { success: false, error: "Landlord trust profile not found" };
      }
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Landlord Trust Profile", tags: ["Trust OS", "Landlord"] },
  })

  .post("/landlord/:landlordId/calculate", async ({ params, query, set }) => {
    try {
      const profile = await landlordTrustScoreService.calculateTrustScore(params.landlordId, query.orgId);
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Calculate Landlord Trust Score", tags: ["Trust OS", "Landlord"] },
  })

  .post("/landlord/:landlordId/event", async ({ params, body, set }) => {
    try {
      await landlordTrustScoreService.recordTrustEvent(
        params.landlordId,
        body.eventType,
        "MAINTENANCE" as any,
        body.impact,
        body.metadata
      );
      return { success: true, message: "Trust event recorded" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      eventType: t.String(),
      impact: t.Number(),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Record Landlord Trust Event", tags: ["Trust OS", "Landlord"] },
  })

  .get("/landlord/:landlordId/history", async ({ params, set }) => {
    try {
      const history = await landlordTrustScoreService.getTrustHistory(params.landlordId);
      return { success: true, data: history };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Landlord Trust History", tags: ["Trust OS", "Landlord"] },
  })

  // Agent Reputation Endpoints
  .get("/agent/:agentId", async ({ params, set }) => {
    try {
      const profile = await agentReputationService.getReputationProfile(params.agentId);
      if (!profile) {
        set.status = 404;
        return { success: false, error: "Agent reputation profile not found" };
      }
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Agent Reputation Profile", tags: ["Trust OS", "Agent"] },
  })

  .post("/agent/:agentId/calculate", async ({ params, set }) => {
    try {
      const profile = await agentReputationService.calculateReputationScore(params.agentId);
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Calculate Agent Reputation Score", tags: ["Trust OS", "Agent"] },
  })

  .post("/agent/:agentId/event", async ({ params, body, set }) => {
    try {
      await agentReputationService.recordReputationEvent(
        params.agentId,
        body.eventType,
        body.impact,
        body.metadata
      );
      return { success: true, message: "Reputation event recorded" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      eventType: t.String(),
      impact: t.Number(),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Record Agent Reputation Event", tags: ["Trust OS", "Agent"] },
  })

  .get("/agent/:agentId/history", async ({ params, set }) => {
    try {
      const history = await agentReputationService.getReputationHistory(params.agentId);
      return { success: true, data: history };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Agent Reputation History", tags: ["Trust OS", "Agent"] },
  })

  // Property Trust Endpoints
  .get("/property/:propertyId", async ({ params, set }) => {
    try {
      const profile = await propertyTrustScoreService.getTrustProfile(params.propertyId);
      if (!profile) {
        set.status = 404;
        return { success: false, error: "Property trust profile not found" };
      }
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Property Trust Profile", tags: ["Trust OS", "Property"] },
  })

  .post("/property/:propertyId/calculate", async ({ params, set }) => {
    try {
      const profile = await propertyTrustScoreService.calculateTrustScore(params.propertyId);
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Calculate Property Trust Score", tags: ["Trust OS", "Property"] },
  })

  .post("/property/:propertyId/event", async ({ params, body, set }) => {
    try {
      await propertyTrustScoreService.recordTrustEvent(
        params.propertyId,
        body.eventType,
        body.impact,
        body.metadata
      );
      return { success: true, message: "Trust event recorded" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      eventType: t.String(),
      impact: t.Number(),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Record Property Trust Event", tags: ["Trust OS", "Property"] },
  })

  .get("/property/:propertyId/history", async ({ params, set }) => {
    try {
      const history = await propertyTrustScoreService.getTrustHistory(params.propertyId);
      return { success: true, data: history };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Property Trust History", tags: ["Trust OS", "Property"] },
  })

  // Transaction Trust Endpoints
  .get("/transaction/:transactionId", async ({ params, set }) => {
    try {
      const profile = await transactionTrustScoreService.getTrustProfile(params.transactionId);
      if (!profile) {
        set.status = 404;
        return { success: false, error: "Transaction trust profile not found" };
      }
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Transaction Trust Profile", tags: ["Trust OS", "Transaction"] },
  })

  .post("/transaction/:transactionId/calculate", async ({ params, body, set }) => {
    try {
      const profile = await transactionTrustScoreService.calculateTrustScore(params.transactionId, body.transactionType);
      return { success: true, data: profile };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({ transactionType: t.String() }),
    detail: { summary: "Calculate Transaction Trust Score", tags: ["Trust OS", "Transaction"] },
  })

  .post("/transaction/:transactionId/event", async ({ params, body, set }) => {
    try {
      await transactionTrustScoreService.recordTrustEvent(
        params.transactionId,
        body.eventType,
        body.impact,
        body.metadata
      );
      return { success: true, message: "Trust event recorded" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      eventType: t.String(),
      impact: t.Number(),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Record Transaction Trust Event", tags: ["Trust OS", "Transaction"] },
  })

  .get("/transaction/:transactionId/history", async ({ params, set }) => {
    try {
      const history = await transactionTrustScoreService.getTrustHistory(params.transactionId);
      return { success: true, data: history };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Transaction Trust History", tags: ["Trust OS", "Transaction"] },
  })

  // Trust Graph Endpoints
  .get("/graph/node/:entityType/:entityId", async ({ params, set }) => {
    try {
      const node = await trustGraphService.getNode(params.entityType, params.entityId);
      if (!node) {
        set.status = 404;
        return { success: false, error: "Trust graph node not found" };
      }
      return { success: true, data: node };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Trust Graph Node", tags: ["Trust OS", "Graph"] },
  })

  .post("/graph/node", async ({ body, set }) => {
    try {
      const node = await trustGraphService.createNode(body.entityType, body.entityId, body.nodeData);
      return { success: true, data: node };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      entityType: t.String(),
      entityId: t.String(),
      nodeData: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Trust Graph Node", tags: ["Trust OS", "Graph"] },
  })

  .put("/graph/node/:entityType/:entityId/score", async ({ params, body, set }) => {
    try {
      const node = await trustGraphService.updateNodeScore(
        params.entityType,
        params.entityId,
        body.trustScore,
        body.riskLevel
      );
      return { success: true, data: node };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      trustScore: t.Number(),
      riskLevel: t.Optional(t.String()),
    }),
    detail: { summary: "Update Trust Graph Node Score", tags: ["Trust OS", "Graph"] },
  })

  .post("/graph/edge", async ({ body, set }) => {
    try {
      const edge = await trustGraphService.createEdge(
        body.fromEntityType,
        body.fromEntityId,
        body.toEntityType,
        body.toEntityId,
        body.edgeType,
        body.edgeData,
        body.trustWeight
      );
      return { success: true, data: edge };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      fromEntityType: t.String(),
      fromEntityId: t.String(),
      toEntityType: t.String(),
      toEntityId: t.String(),
      edgeType: t.String(),
      edgeData: t.Optional(t.Any()),
      trustWeight: t.Optional(t.Number()),
    }),
    detail: { summary: "Create Trust Graph Edge", tags: ["Trust OS", "Graph"] },
  })

  .get("/graph/edges", async ({ query, set }) => {
    try {
      const edges = await trustGraphService.getEdges(
        query.fromEntityType,
        query.fromEntityId,
        query.toEntityType,
        query.toEntityId,
        query.edgeType
      );
      return { success: true, data: edges };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      fromEntityType: t.Optional(t.String()),
      fromEntityId: t.Optional(t.String()),
      toEntityType: t.Optional(t.String()),
      toEntityId: t.Optional(t.String()),
      edgeType: t.Optional(t.String()),
    }),
    detail: { summary: "Get Trust Graph Edges", tags: ["Trust OS", "Graph"] },
  })

  .get("/graph/propagation/:entityType/:entityId", async ({ params, query, set }) => {
    try {
      const propagation = await trustGraphService.calculateTrustPropagation(
        params.entityType,
        params.entityId,
        query.maxDepth ? parseInt(query.maxDepth) : 3
      );
      return { success: true, data: Object.fromEntries(propagation) };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ maxDepth: t.Optional(t.String()) }),
    detail: { summary: "Calculate Trust Propagation", tags: ["Trust OS", "Graph"] },
  })

  .get("/graph/path/:fromEntityType/:fromEntityId/:toEntityType/:toEntityId", async ({ params, set }) => {
    try {
      const path = await trustGraphService.getTrustPath(
        params.fromEntityType,
        params.fromEntityId,
        params.toEntityType,
        params.toEntityId
      );
      return { success: true, data: path };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Trust Path", tags: ["Trust OS", "Graph"] },
  })

  .get("/graph/statistics", async ({ set }) => {
    try {
      const stats = await trustGraphService.getGraphStatistics();
      return { success: true, data: stats };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Trust Graph Statistics", tags: ["Trust OS", "Graph"] },
  })

  .delete("/graph/node/:entityType/:entityId", async ({ params, set }) => {
    try {
      const deleted = await trustGraphService.deleteNode(params.entityType, params.entityId);
      return { success: true, deleted };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Delete Trust Graph Node", tags: ["Trust OS", "Graph"] },
  })

  // AI Trust Engine Endpoints
  .post("/ai/calculate/:entityType/:entityId", async ({ params, query, set }) => {
    try {
      const results = await aiTrustEngineService.calculateAllTrustScores(params.entityType, params.entityId, query.orgId);
      return { success: true, data: results };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Calculate All Trust Scores (AI Engine)", tags: ["Trust OS", "AI"] },
  })

  .get("/ai/insights/:entityType/:entityId", async ({ params, set }) => {
    try {
      const insights = await aiTrustEngineService.generateTrustInsights(params.entityType, params.entityId);
      return { success: true, data: insights };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Generate Trust Insights", tags: ["Trust OS", "AI"] },
  })

  .get("/ai/relationships/:entityType/:entityId", async ({ params, set }) => {
    try {
      const relationships = await aiTrustEngineService.analyzeTrustRelationships(params.entityType, params.entityId);
      return { success: true, data: relationships };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Analyze Trust Relationships", tags: ["Trust OS", "AI"] },
  })

  .post("/ai/batch-calculate", async ({ body, query, set }) => {
    try {
      const results = await aiTrustEngineService.batchCalculateTrustScores(body.entities, query.orgId);
      return { success: true, data: results };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      entities: t.Array(t.Object({ type: t.String(), id: t.String() })),
    }),
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Batch Calculate Trust Scores", tags: ["Trust OS", "AI"] },
  })

  .get("/ai/anomalies", async ({ query, set }) => {
    try {
      const threshold = query.threshold ? parseInt(query.threshold) : 30;
      const anomalies = await aiTrustEngineService.detectTrustAnomalies(threshold);
      return { success: true, data: anomalies };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ threshold: t.Optional(t.String()) }),
    detail: { summary: "Detect Trust Anomalies", tags: ["Trust OS", "AI"] },
  })

  .get("/ai/report/:entityType/:entityId", async ({ params, set }) => {
    try {
      const report = await aiTrustEngineService.getTrustReport(params.entityType, params.entityId);
      return { success: true, data: report };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Trust Report", tags: ["Trust OS", "AI"] },
  })

  .post("/ai/transaction/:transactionId", async ({ params, body, set }) => {
    try {
      const result = await aiTrustEngineService.updateTrustGraphAfterTransaction(params.transactionId, body.transactionType);
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({ transactionType: t.String() }),
    detail: { summary: "Update Trust Graph After Transaction", tags: ["Trust OS", "AI"] },
  })

  .get("/ai/system-overview", async ({ set }) => {
    try {
      const overview = await aiTrustEngineService.getSystemTrustOverview();
      return { success: true, data: overview };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get System Trust Overview", tags: ["Trust OS", "AI"] },
  })

  .get("/ai/recommendations/:entityType/:entityId", async ({ params, set }) => {
    try {
      const recommendations = await aiTrustEngineService.recommendTrustImprovements(params.entityType, params.entityId);
      return { success: true, data: recommendations };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Get Trust Improvement Recommendations", tags: ["Trust OS", "AI"] },
  })

  // Dashboard Endpoint
  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      const where = orgId ? { orgId } : {};
      const startOfDay = new Date();
      startOfDay.setHours(0, 0, 0, 0);

      const [totalScores, activeScores, avgScore, eventsToday, recentEvents, tierDistribution] = await Promise.all([
        prisma.universalTrustScore.count({ where }),
        prisma.universalTrustScore.count({ where: { ...where, status: "ACTIVE" } }),
        prisma.universalTrustScore.aggregate({ where, _avg: { overallScore: true } }),
        prisma.trustScoreEvent.count({ where: { ...where, createdAt: { gte: startOfDay } } }),
        prisma.trustScoreEvent.findMany({ where, orderBy: { createdAt: "desc" }, take: 8 }),
        prisma.universalTrustScore.groupBy({ by: ["tier"], _count: { id: true } }),
      ]);

      return {
        kpis: {
          totalScores,
          activeScores,
          avgScore: Math.round(((avgScore._avg.overallScore ?? 0) * 10)) / 10,
          eventsToday,
          tiers: tierDistribution.length,
        },
        recentActivity: recentEvents.map((event) => ({
          title: event.signalKey,
          subtitle: `Category: ${event.category}`,
          value: `${event.normalizedScore}`,
        })),
        alerts: eventsToday === 0 && totalScores > 0
          ? [{ type: "info", title: "No trust events today", message: "Trust score events have not been recorded in the last 24h." }]
          : [],
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Trust OS Dashboard", tags: ["Trust OS"] },
  });
