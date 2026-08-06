import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * Agent Reputation Dashboard — matches the GenericOSDashboard client contract
 * (GET /api/v1/agent-reputation/dashboard?orgId=... → flat { kpis, recentActivity, alerts }).
 */
export const agentReputationDashboardRoutes = new Elysia({
  prefix: "/api/v1/agent-reputation",
}).get(
  "/dashboard",
  async ({ query }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;

    const [profiles, events, agents] = await Promise.all([
      prisma.agentReputationProfile.findMany({ where }),
      prisma.trustScoreEvent.findMany({
        where: { ...where, entityType: "AGENT" },
        orderBy: { createdAt: "desc" },
        take: 20,
      }),
      prisma.agent.findMany({ where }),
    ]);

    const totalAgents = profiles.length;
    const avgReputationScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.overallScore, 0) / profiles.length)
      : 0;
    const highReputationAgents = profiles.filter((p) => p.overallScore >= 75).length;
    const lowReputationAgents = profiles.filter((p) => p.overallScore < 50).length;
    const avgPerformanceScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.performanceScore, 0) / profiles.length)
      : 0;
    const avgReliabilityScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.reliabilityScore, 0) / profiles.length)
      : 0;

    return {
      kpis: {
        totalAgents,
        averageReputationScore: avgReputationScore,
        highReputationAgents,
        lowReputationAgents,
        averagePerformanceScore: avgPerformanceScore,
        averageReliabilityScore: avgReliabilityScore,
        totalDealsClosed: 0,
      },
      recentActivity: events.slice(0, 10).map((e) => ({
        id: e.id,
        title: e.signalKey,
        subtitle: e.category,
        value: `${e.normalizedScore}`,
        timeAgo: e.createdAt.toISOString(),
      })),
      alerts: [
        ...lowReputationAgents > 0
          ? [{ type: "warning" as const, title: `${lowReputationAgents} low reputation agent(s)`, message: "Agents with reputation score below 50 require attention" }]
          : [],
        ...profiles.filter((p) => p.disputeRate > 0.1).slice(0, 5).map((p) => ({
          type: "error" as const,
          title: "High dispute rate agent",
          message: `Agent ${p.agentId.slice(0, 8)} has high dispute rate`,
        })),
      ],
    };
  },
  {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Agent Reputation Dashboard", tags: ["Trust OS", "Agent"] },
  },
);
