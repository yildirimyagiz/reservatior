import { prisma } from "../../lib/prisma";

/**
 * Insurance OS Dashboard Service
 *
 * Aggregates KPIs for the insurance-os dashboard: active policies, premium
 * revenue (provider-owned, never platform), claims, providers and risk bands.
 * Output matches the client GenericOSDashboard contract (flat, `kpis` as a
 * Record<string, number>).
 */
export class InsuranceDashboardService {
  constructor(private readonly db: typeof prisma = prisma) {}

  async getStats(orgId: string) {
    const [policies, activePolicies, claims, providers, products, premiumTx] =
      await Promise.all([
        this.db.rentalInsurancePolicy.count({ where: { provider: { organizationId: orgId } } }),
        this.db.rentalInsurancePolicy.count({
          where: { provider: { organizationId: orgId }, status: "ACTIVE" },
        }),
        this.db.insuranceClaim.findMany({
          where: { policy: { provider: { organizationId: orgId } } },
          orderBy: { createdAt: "desc" },
          take: 50,
        }),
        this.db.insuranceProvider.findMany({ where: { organizationId: orgId } }),
        this.db.rentalInsuranceProduct.findMany({
          where: { provider: { organizationId: orgId } },
        }),
        this.db.insurancePaymentTransaction.findMany({
          where: { provider: { organizationId: orgId } },
        }),
      ]);

    const premiumRevenue = premiumTx.reduce((s, t) => s + Number(t.amount), 0);

    const claimsByStatus = claims.reduce<Record<string, number>>((acc, c) => {
      acc[c.status] = (acc[c.status] ?? 0) + 1;
      return acc;
    }, {});

    const riskBandCounts: Record<string, number> = {};
    const byBand = await this.db.rentalInsurancePolicy
      .findMany({
        where: { provider: { organizationId: orgId }, metadata: { not: undefined } },
        select: { metadata: true },
      })
      .catch(() => []);
    for (const p of byBand) {
      const band = (p.metadata as any)?.riskBand ?? "UNKNOWN";
      riskBandCounts[band] = (riskBandCounts[band] ?? 0) + 1;
    }

    const totalPremium = activePolicies
      ? await this.db.rentalInsurancePolicy.aggregate({
          _sum: { premiumAmount: true },
          where: { provider: { organizationId: orgId }, status: "ACTIVE" },
        })
      : { _sum: { premiumAmount: null } };

    return {
      kpis: {
        totalPolicies: policies,
        activePolicies,
        premiumRevenue,
        activeClaims: claimsByStatus["UNDER_REVIEW"] ?? 0,
        providers: providers.length,
        products: products.length,
      },
      recentActivity: claims.slice(0, 10).map((c) => ({
        id: c.id,
        title: `Claim ${c.claimType ?? "claim"} • ${c.id.slice(0, 8)}`,
        subtitle: c.status,
        value: `$${Number(c.amountRequested).toLocaleString()}`,
        timeAgo: c.createdAt.toISOString(),
      })),
      alerts: claims
        .filter((c) => c.status === "SUBMITTED" || c.status === "DISPUTED")
        .slice(0, 10)
        .map((c) => ({
          type: (c.status === "DISPUTED" ? "warning" : "info") as "warning" | "info",
          title: `${c.status === "DISPUTED" ? "Disputed" : "New"} claim`,
          message: `Claim ${c.id.slice(0, 8)} is ${c.status.toLowerCase()}`,
        })),
      distribution: {
        claimsByStatus,
        riskBands: riskBandCounts,
      },
      totalPremiumValue: Number(totalPremium._sum.premiumAmount ?? 0),
    };
  }
}

export const insuranceDashboardService = new InsuranceDashboardService();
