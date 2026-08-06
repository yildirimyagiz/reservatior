import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * Landlord Trust Dashboard — matches the GenericOSDashboard client contract
 * (GET /api/v1/landlord-trust/dashboard?orgId=... → flat { kpis, recentActivity, alerts }).
 */
export const landlordTrustDashboardRoutes = new Elysia({
  prefix: "/api/v1/landlord-trust",
}).get(
  "/dashboard",
  async ({ query }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;

    const [profiles, events, properties] = await Promise.all([
      prisma.landlordTrustProfile.findMany({ where }),
      prisma.trustScoreEvent.findMany({
        where: { ...where, entityType: "LANDLORD" },
        orderBy: { createdAt: "desc" },
        take: 20,
      }),
      prisma.property.findMany({ where }),
    ]);

    const totalLandlords = profiles.length;
    const avgTrustScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.overallScore, 0) / profiles.length)
      : 0;
    const highTrustLandlords = profiles.filter((p) => p.overallScore >= 75).length;
    const lowTrustLandlords = profiles.filter((p) => p.overallScore < 50).length;
    const avgPaymentScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.paymentScore, 0) / profiles.length)
      : 0;
    const avgMaintenanceScore = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.maintenanceScore, 0) / profiles.length)
      : 0;

    return {
      kpis: {
        totalLandlords,
        averageTrustScore: avgTrustScore,
        highTrustLandlords,
        lowTrustLandlords,
        averagePaymentScore: avgPaymentScore,
        averageMaintenanceScore: avgMaintenanceScore,
        totalProperties: properties.length,
      },
      recentActivity: events.slice(0, 10).map((e) => ({
        id: e.id,
        title: e.signalKey,
        subtitle: e.category,
        value: `${e.normalizedScore}`,
        timeAgo: e.createdAt.toISOString(),
      })),
      alerts: [
        ...lowTrustLandlords > 0
          ? [{ type: "warning" as const, title: `${lowTrustLandlords} low trust landlord(s)`, message: "Landlords with trust score below 50 require attention" }]
          : [],
        ...profiles.filter((p) => p.riskLevel === "HIGH").slice(0, 5).map((p) => ({
          type: "error" as const,
          title: "High risk landlord",
          message: `Landlord ${p.landlordId.slice(0, 8)} has high risk level`,
        })),
      ],
    };
  },
  {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Landlord Trust Dashboard", tags: ["Trust OS", "Landlord"] },
  },
);
