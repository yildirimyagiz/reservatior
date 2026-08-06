import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * Rental Finance OS Dashboard — matches the GenericOSDashboard client contract
 * (GET /api/v1/{osName}/dashboard?orgId=... → flat { kpis, recentActivity, alerts }).
 */
const APPROX_USD_RATES: Record<string, number> = {
  USD: 1,
  TRY: 0.03, // 1 USD = 32.5 TRY
  EUR: 1.08,
  GBP: 1.25,
  AED: 0.27,
  SAR: 0.27,
  QAR: 0.27,
  AUD: 0.65,
  SGD: 0.74,
  JPY: 0.0066,
  CHF: 1.11,
  CAD: 0.73,
  MXN: 0.059,
  BRL: 0.2,
};

function toUSD(amount: number, currency: string): number {
  const rate = APPROX_USD_RATES[currency] ?? 1;
  return amount * rate;
}

export const rentalFinanceOSDashboardRoutes = new Elysia({
  prefix: "/api/v1/rental-finance-os",
}).get(
  "/dashboard",
  async ({ query }) => {
    const where: any = {};
    if (query.orgId) where.orgId = query.orgId;

    const [plans, payments, escrows, profiles, landlords] = await Promise.all([
      prisma.rentalServicePlan.findMany({ where, include: { rentalEscrow: true } }),
      prisma.rentalPayment.findMany({
        where,
        orderBy: { scheduledDate: "desc" },
        take: 50,
      }),
      prisma.rentalEscrowAccount.findMany({ where }),
      prisma.tenantFinancialProfile.findMany({ where }),
      prisma.landlordEntity.count({ where }),
    ]);

    const activePlans = plans.filter((p) => p.status === "ACTIVE").length;
    const escrowBalance = escrows.reduce((s, e) => s + toUSD(Number(e.balance), e.currency), 0);
    const heldAmount = escrows.reduce((s, e) => s + toUSD(Number(e.heldAmount), e.currency), 0);
    const completedPayments = payments.filter((p) => p.status === "COMPLETED").length;
    const latePayments = payments.filter((p) => p.status === "LATE" || (p.daysLate ?? 0) > 0).length;
    const avgReliability = profiles.length
      ? Math.round(profiles.reduce((s, p) => s + p.reliabilityScore, 0) / profiles.length)
      : 0;

    return {
      kpis: {
        totalPlans: plans.length,
        activePlans,
        escrowBalance: Math.round(escrowBalance),
        heldAmount: Math.round(heldAmount),
        totalCollected: completedPayments,
        latePayments,
        averageReliabilityScore: avgReliability,
        landlords,
      },
      recentActivity: payments.slice(0, 10).map((p) => ({
        id: p.id,
        title: `${p.payerType === "TENANT" ? "Tenant" : "Landlord"} payment ${p.status.toLowerCase()}`,
        subtitle: `Plan ${p.rentalPlanId.slice(0, 8)}`,
        value: `${p.currency === "USD" ? "$" : p.currency + " "}${Number(p.amount).toLocaleString()}`,
        timeAgo: p.scheduledDate.toISOString(),
      })),
      alerts: [
        ...latePayments > 0
          ? [{ type: "warning" as const, title: `${latePayments} late payment(s)`, message: "Marked late by the rental finance engine" }]
          : [],
        ...escrows.filter((e) => Number(e.heldAmount) > 0 && e.status === "OPEN")
          .slice(0, 5)
          .map((e) => ({
            type: "info" as const,
            title: "Escrow holding funds",
            message: `Plan ${e.rentalPlanId.slice(0, 8)} holds ${e.currency === "USD" ? "$" : e.currency + " "}${Number(e.heldAmount).toLocaleString()}`,
          })),
      ],
    };
  },
  {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "Rental Finance OS Dashboard", tags: ["Rental Finance OS"] },
  },
);
