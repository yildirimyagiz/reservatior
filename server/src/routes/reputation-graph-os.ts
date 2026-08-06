import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { reputationGraphService, EntityType, EdgeType } from "../services/reputation/reputation-graph.service";

/**
 * Reputation Graph OS - Advanced reputation analysis
 * Extends Trust OS with relationship networks, influence scoring, path finding, and community detection
 */
export const reputationGraphOSRoutes = new Elysia({
  prefix: "/api/v1/reputation-graph-os",
})
  // Build reputation graph for an entity
  .get("/graph/:entityType/:entityId", async ({ params, query }) => {
    try {
      const graph = await reputationGraphService.buildReputationGraph(
        params.entityType as EntityType,
        params.entityId,
        query.maxDepth ? parseInt(query.maxDepth) : 3
      );
      return { success: true, graph };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    query: t.Object({ maxDepth: t.Optional(t.String()) }),
    detail: { summary: "Build Reputation Graph", tags: ["Reputation Graph OS"] },
  })

  // Calculate influence score
  .get("/influence/:entityType/:entityId", async ({ params }) => {
    try {
      const influenceScore = await reputationGraphService.calculateInfluenceScore(
        params.entityType as EntityType,
        params.entityId
      );
      return { success: true, influenceScore };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    detail: { summary: "Calculate Influence Score", tags: ["Reputation Graph OS"] },
  })

  // Calculate reputation score
  .get("/reputation/:entityType/:entityId", async ({ params }) => {
    try {
      const reputationScore = await reputationGraphService.calculateReputationScore(
        params.entityType as EntityType,
        params.entityId
      );
      return { success: true, reputationScore };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    detail: { summary: "Calculate Reputation Score", tags: ["Reputation Graph OS"] },
  })

  // Find trust path between entities
  .get("/path/:fromEntityType/:fromEntityId/:toEntityType/:toEntityId", async ({ params, query }) => {
    try {
      const path = await reputationGraphService.findTrustPath(
        params.fromEntityType as EntityType,
        params.fromEntityId,
        params.toEntityType as EntityType,
        params.toEntityId,
        query.maxHops ? parseInt(query.maxHops) : 5
      );
      return { success: true, path };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({
      fromEntityType: t.String(),
      fromEntityId: t.String(),
      toEntityType: t.String(),
      toEntityId: t.String(),
    }),
    query: t.Object({ maxHops: t.Optional(t.String()) }),
    detail: { summary: "Find Trust Path", tags: ["Reputation Graph OS"] },
  })

  // Detect communities
  .get("/communities/:entityType/:entityId", async ({ params, query }) => {
    try {
      const communities = await reputationGraphService.detectCommunities(
        params.entityType as EntityType,
        params.entityId,
        query.minCommunitySize ? parseInt(query.minCommunitySize) : 3
      );
      return { success: true, communities };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    query: t.Object({ minCommunitySize: t.Optional(t.String()) }),
    detail: { summary: "Detect Communities", tags: ["Reputation Graph OS"] },
  })

  // Get reputation summary
  .get("/summary/:entityType/:entityId", async ({ params }) => {
    try {
      const summary = await reputationGraphService.getReputationSummary(
        params.entityType as EntityType,
        params.entityId
      );
      return { success: true, summary };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    detail: { summary: "Get Reputation Summary", tags: ["Reputation Graph OS"] },
  })

  // Get reputation graph dashboard
  .get("/dashboard", async ({ query }) => {
    try {
      const where: any = {};
      if (query.orgId) where.orgId = query.orgId;

      const [nodes, edges] = await Promise.all([
        prisma.trustGraphNode.findMany({
          where,
          take: 100,
        }),
        prisma.trustGraphEdge.findMany({
          where,
          take: 200,
        }),
      ]);

      const totalNodes = nodes.length;
      const totalEdges = edges.length;
      const avgTrustScore = nodes.length > 0
        ? nodes.reduce((sum, n) => sum + n.trustScore, 0) / nodes.length
        : 0;
      const highTrustNodes = nodes.filter(n => n.trustScore >= 75).length;
      const lowTrustNodes = nodes.filter(n => n.trustScore < 50).length;

      const byEntityType = nodes.reduce((acc, n) => {
        acc[n.entityType] = (acc[n.entityType] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      return {
        kpis: {
          totalNodes,
          totalEdges,
          avgTrustScore: Math.round(avgTrustScore),
          highTrustNodes,
          lowTrustNodes,
          entityTypes: Object.keys(byEntityType).length,
          avgConnections: totalNodes > 0 ? Math.round(totalEdges / totalNodes) : 0,
        },
        recentActivity: edges.slice(0, 10).map((e) => ({
          id: e.id,
          title: `New ${e.edgeType} connection`,
          subtitle: `Trust weight: ${e.trustWeight}`,
          value: e.riskLevel,
          timeAgo: e.createdAt.toISOString(),
        })),
        alerts: [
          ...lowTrustNodes > 5
            ? [{ type: "warning" as const, title: `${lowTrustNodes} low trust nodes`, message: "Review reputation scores" }]
            : [],
          ...avgTrustScore < 60
            ? [{ type: "warning" as const, title: "Low average trust score", message: "Overall network health below threshold" }]
            : [],
        ],
      };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Reputation Graph Dashboard", tags: ["Reputation Graph OS"] },
  });
