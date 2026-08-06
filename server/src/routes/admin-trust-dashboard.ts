import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { trustGraphService } from "../services/trust/trust-graph.service";
import { aiTrustEngineService } from "../services/trust/ai-trust-engine.service";

/**
 * Admin Trust Dashboard — matches the GenericOSDashboard client contract
 * (GET /api/v1/admin-trust/dashboard?orgId=... → flat { kpis, recentActivity, alerts }).
 */
export const adminTrustDashboardRoutes = new Elysia({
  prefix: "/api/v1/admin-trust",
}).get(
  "/dashboard",
  async ({ query }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;

    const [tenantProfiles, landlordProfiles, agentProfiles, propertyProfiles, transactionProfiles, graphStats] = await Promise.all([
      prisma.tenantTrustProfile.findMany({ where }),
      prisma.landlordTrustProfile.findMany({ where }),
      prisma.agentReputationProfile.findMany({ where }),
      prisma.propertyTrustProfile.findMany({ where }),
      prisma.transactionTrustProfile.findMany({ where }),
      trustGraphService.getGraphStatistics(),
    ]);

    const totalEntities = tenantProfiles.length + landlordProfiles.length + agentProfiles.length + propertyProfiles.length;
    const avgOverallScore = totalEntities > 0
      ? Math.round(
          (tenantProfiles.reduce((s, p) => s + p.overallScore, 0) +
           landlordProfiles.reduce((s, p) => s + p.overallScore, 0) +
           agentProfiles.reduce((s, p) => s + p.overallScore, 0) +
           propertyProfiles.reduce((s, p) => s + p.overallScore, 0)) / totalEntities
        )
      : 0;
    const highTrustEntities = 
      tenantProfiles.filter((p) => p.overallScore >= 75).length +
      landlordProfiles.filter((p) => p.overallScore >= 75).length +
      agentProfiles.filter((p) => p.overallScore >= 75).length +
      propertyProfiles.filter((p) => p.overallScore >= 75).length;
    const lowTrustEntities = 
      tenantProfiles.filter((p) => p.overallScore < 50).length +
      landlordProfiles.filter((p) => p.overallScore < 50).length +
      agentProfiles.filter((p) => p.overallScore < 50).length +
      propertyProfiles.filter((p) => p.overallScore < 50).length;
    const highRiskTransactions = transactionProfiles.filter((p) => p.overallScore < 50).length;

    return {
      kpis: {
        totalEntities,
        averageOverallScore: avgOverallScore,
        highTrustEntities,
        lowTrustEntities,
        totalTenants: tenantProfiles.length,
        totalLandlords: landlordProfiles.length,
        totalAgents: agentProfiles.length,
        totalProperties: propertyProfiles.length,
        totalTransactions: transactionProfiles.length,
        graphNodes: graphStats.nodeCount,
        graphEdges: graphStats.edgeCount,
        systemHealth: avgOverallScore >= 70 ? "HEALTHY" : avgOverallScore >= 50 ? "MODERATE" : "AT_RISK",
      },
      recentActivity: [
        ...tenantProfiles.slice(0, 3).map((p) => ({
          id: p.id,
          title: "Tenant trust updated",
          subtitle: `Score: ${p.overallScore}`,
          value: p.tenantId.slice(0, 8),
          timeAgo: p.lastCalculatedAt.toISOString(),
        })),
        ...landlordProfiles.slice(0, 3).map((p) => ({
          id: p.id,
          title: "Landlord trust updated",
          subtitle: `Score: ${p.overallScore}`,
          value: p.landlordId.slice(0, 8),
          timeAgo: p.lastCalculatedAt.toISOString(),
        })),
      ],
      alerts: [
        ...lowTrustEntities > 5
          ? [{ type: "warning" as const, title: `${lowTrustEntities} low trust entities`, message: "Multiple entities with trust score below 50 require attention" }]
          : [],
        ...highRiskTransactions > 0
          ? [{ type: "error" as const, title: `${highRiskTransactions} high risk transaction(s)`, message: "Transactions with low trust scores detected" }]
          : [],
        ...avgOverallScore < 60
          ? [{ type: "warning" as const, title: "System trust below threshold", message: "Overall system trust score is below 60" }]
          : [],
      ],
    };
  },
  {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Admin Trust Dashboard", tags: ["Trust OS", "Admin"] },
  },
);
