import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * Tenant Trust Dashboard — matches the GenericOSDashboard client contract
 * (GET /api/v1/tenant-trust/dashboard?orgId=... → flat { kpis, recentActivity, alerts }).
 */
export const tenantTrustDashboardRoutes = new Elysia({
  prefix: "/api/v1/tenant-trust",
}).get(
  "/dashboard",
  async ({ query }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;

    const [profiles, events, leases] = await Promise.all([
      prisma.tenantTrustProfile.findMany({ where }),
      prisma.trustScoreEvent.findMany({
        where: { ...where, entityType: "TENANT" },
        orderBy: { createdAt: "desc" },
        take: 20,
      }),
      prisma.lease.findMany({ where }),
    ]);

    const totalTenants = profiles.length;
    const avgTrustScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.overallScore, 0) / profiles.length)
      : 0;
    const highTrustTenants = profiles.filter((p) => p.overallScore >= 75).length;
    const lowTrustTenants = profiles.filter((p) => p.overallScore < 50).length;
    const avgPaymentScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.paymentScore, 0) / profiles.length)
      : 0;
    const avgBehaviorScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.behaviorScore, 0) / profiles.length)
      : 0;

    return {
      kpis: {
        totalTenants,
        averageTrustScore: avgTrustScore,
        highTrustTenants,
        lowTrustTenants,
        averagePaymentScore: avgPaymentScore,
        averageBehaviorScore: avgBehaviorScore,
        totalLeases: leases.length,
      },
      recentActivity: events.slice(0, 10).map((e) => ({
        id: e.id,
        title: e.signalKey,
        subtitle: e.category,
        value: `${e.normalizedScore}`,
        timeAgo: e.createdAt.toISOString(),
      })),
      alerts: [
        ...lowTrustTenants > 0
          ? [{ type: "warning" as const, title: `${lowTrustTenants} low trust tenant(s)`, message: "Tenants with trust score below 50 require attention" }]
          : [],
        ...profiles.filter((p) => p.riskLevel === "HIGH").slice(0, 5).map((p) => ({
          type: "error" as const,
          title: "High risk tenant",
          message: `Tenant ${p.tenantId.slice(0, 8)} has high risk level`,
        })),
      ],
    };
  },
  {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Tenant Trust Dashboard", tags: ["Trust OS", "Tenant"] },
  },
);
