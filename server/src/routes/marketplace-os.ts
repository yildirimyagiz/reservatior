import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { marketplaceMatchingService, MatchType, MatchStatus } from "../services/marketplace/matching.service";

/**
 * Marketplace OS - Supply-demand matching and recommendations
 * Manages network effects for the rental marketplace
 * Handles demand analysis, supply analysis, matching algorithms, ranking, and recommendations
 */
export const marketplaceOSRoutes = new Elysia({
  prefix: "/api/v1/marketplace-os",
})
  // Analyze demand
  .get("/demand/:location", async ({ params, query }) => {
    try {
      const demand = await marketplaceMatchingService.analyzeDemand(
        params.location,
        query.propertyType
      );
      return { success: true, demand };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ location: t.String() }),
    query: t.Object({ propertyType: t.Optional(t.String()) }),
    detail: { summary: "Analyze Demand", tags: ["Marketplace OS"] },
  })

  // Analyze supply
  .get("/supply/:location", async ({ params, query }) => {
    try {
      const supply = await marketplaceMatchingService.analyzeSupply(
        params.location,
        query.propertyType
      );
      return { success: true, supply };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ location: t.String() }),
    query: t.Object({ propertyType: t.Optional(t.String()) }),
    detail: { summary: "Analyze Supply", tags: ["Marketplace OS"] },
  })

  // Match tenant to property
  .get("/match/tenant/:tenantId/property/:propertyId", async ({ params }) => {
    try {
      const match = await marketplaceMatchingService.matchTenantToProperty(
        params.tenantId,
        params.propertyId
      );
      return { success: true, match };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ tenantId: t.String(), propertyId: t.String() }),
    detail: { summary: "Match Tenant to Property", tags: ["Marketplace OS"] },
  })

  // Get recommendations
  .get("/recommendations/:entityType/:entityId", async ({ params, query }) => {
    try {
      const recommendations = await marketplaceMatchingService.getRecommendations(
        params.entityType,
        params.entityId,
        query.limit ? parseInt(query.limit) : 10
      );
      return { success: true, recommendations };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityType: t.String(), entityId: t.String() }),
    query: t.Object({ limit: t.Optional(t.String()) }),
    detail: { summary: "Get Recommendations", tags: ["Marketplace OS"] },
  })

  // Get marketplace statistics
  .get("/stats/:location", async ({ params }) => {
    try {
      const stats = await marketplaceMatchingService.getMarketplaceStats(params.location);
      return { success: true, stats };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ location: t.String() }),
    detail: { summary: "Get Marketplace Statistics", tags: ["Marketplace OS"] },
  })

  // Create match
  .post("/match", async ({ body }) => {
    try {
      const match = await marketplaceMatchingService.createMatch({
        ...body,
        matchType: body.matchType as MatchType,
        status: body.status as MatchStatus,
        expiresAt: body.expiresAt ? new Date(body.expiresAt) : undefined,
      });
      return { success: true, match };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      matchType: t.String(),
      fromEntityId: t.String(),
      toEntityId: t.String(),
      matchScore: t.Number(),
      compatibilityScore: t.Number(),
      status: t.String(),
      factors: t.Array(t.Object({ factor: t.String(), score: t.Number() })),
      metadata: t.Optional(t.Any()),
      expiresAt: t.Optional(t.String()),
    }),
    detail: { summary: "Create Match", tags: ["Marketplace OS"] },
  })

  // Update match status
  .put("/match/:matchId/status", async ({ params, body }) => {
    try {
      const match = await marketplaceMatchingService.updateMatchStatus(
        params.matchId,
        body.status as MatchStatus
      );
      return { success: true, match };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ matchId: t.String() }),
    body: t.Object({ status: t.String() }),
    detail: { summary: "Update Match Status", tags: ["Marketplace OS"] },
  })

  // Get match history
  .get("/match/history/:entityId", async ({ params, query }) => {
    try {
      const history = await marketplaceMatchingService.getMatchHistory(
        params.entityId,
        query.limit ? parseInt(query.limit) : 20
      );
      return { success: true, history };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ entityId: t.String() }),
    query: t.Object({ limit: t.Optional(t.String()) }),
    detail: { summary: "Get Match History", tags: ["Marketplace OS"] },
  })

  // Get marketplace dashboard
  .get("/dashboard", async ({ query }) => {
    try {
      const where: any = {};
      if (query.orgId) where.orgId = query.orgId;

      const [properties, matches] = await Promise.all([
        prisma.property.findMany({ where, take: 50 }),
        prisma.trustGraphEdge.findMany({ where, take: 100 }),
      ]);

      const totalProperties = properties.length;
      const totalMatches = matches.length;
      const avgMatchScore = matches.length > 0
        ? matches.reduce((sum: number, m: any) => sum + (m.trustWeight || 0), 0) / matches.length
        : 0;

      const byCity = properties.reduce((acc: Record<string, number>, p: any) => {
        acc[p.city] = (acc[p.city] || 0) + 1;
        return acc;
      }, {} as Record<string, number>);

      const topCities = Object.entries(byCity)
        .sort((a, b) => b[1] - a[1])
        .slice(0, 5)
        .map(([city, count]) => ({ city, count }));

      return {
        kpis: {
          totalProperties,
          totalMatches,
          avgMatchScore: Math.round(avgMatchScore * 100) / 100,
          citiesCovered: Object.keys(byCity).length,
          matchSuccessRate: 0.78, // Mock value
          avgTimeToMatch: 3.5, // Mock value in days
        },
        recentActivity: matches.slice(0, 10).map((m: any) => ({
          id: m.id,
          title: `New ${m.edgeType} match`,
          subtitle: `Trust weight: ${m.trustWeight}`,
          value: m.riskLevel,
          timeAgo: m.createdAt.toISOString(),
        })),
        topCities,
        alerts: [
          ...avgMatchScore < 0.5
            ? [{ type: "warning" as const, title: "Low average match score", message: "Review matching algorithm" }]
            : [],
          ...totalMatches < 10
            ? [{ type: "info" as const, title: "Low match volume", message: "Increase marketplace activity" }]
            : [],
        ],
      };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Marketplace Dashboard", tags: ["Marketplace OS"] },
  });
