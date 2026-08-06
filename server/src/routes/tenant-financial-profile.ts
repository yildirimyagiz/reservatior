import { Elysia, t } from "elysia";
import { tenantScoreService } from "../services/rental-finance/tenant-score-service";
import { prisma } from "../lib/prisma";

/**
 * Tenant Financial Profile (Tenant OS)
 * Prefix: /api/v1/tenant-finance
 */
export const tenantFinanceRoutes = new Elysia({ prefix: "/api/v1/tenant-finance" })
  .get(
    "/profile/:tenantId",
    async ({ params: { tenantId } }) => {
      const [reliabilityScore, profile] = await Promise.all([
        tenantScoreService.calculateScore(tenantId).catch(() => null),
        prisma.tenantFinancialProfile.findUnique({ where: { tenantId } }).catch(() => null),
      ]);

      return {
        tenantId,
        reliabilityScore,
        riskLevel: profile?.riskLevel ?? null,
        paymentCount: profile?.paymentCount ?? 0,
        successfulPayments: profile?.successfulPayments ?? 0,
        latePayments: profile?.latePayments ?? 0,
        averageDelayDays: profile?.averageDelayDays ?? 0,
        lastCalculatedAt: profile?.lastCalculatedAt ?? null,
      };
    },
    { params: t.Object({ tenantId: t.String() }), detail: { summary: "Tenant financial profile", tags: ["Tenant Finance"] } },
  )
  .get(
    "/risk-level/:tenantId",
    async ({ params: { tenantId } }) => {
      const score = await tenantScoreService.calculateScore(tenantId).catch(() => 0);
      return { tenantId, score, riskLevel: tenantScoreService.getRiskLevel(score) };
    },
    { params: t.Object({ tenantId: t.String() }), detail: { summary: "Tenant risk level", tags: ["Tenant Finance"] } },
  );
