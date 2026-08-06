import { Elysia, t } from "elysia";
import { landlordAnalyticsService } from "../services/rental-finance/landlord-analytics-service";
import { prisma } from "../lib/prisma";

/**
 * Landlord Financial Profile (Landlord OS)
 * Prefix: /api/v1/landlord-finance
 */
export const landlordFinanceRoutes = new Elysia({ prefix: "/api/v1/landlord-finance" })
  .get(
    "/",
    async ({ query }) => {
      const where: any = {};
      if (query.orgId) where.organizationId = query.orgId;
      const entities = await prisma.landlordEntity.findMany({
        where,
        include: { financialProfile: true },
        orderBy: { createdAt: "desc" },
      });
      return { success: true, data: entities };
    },
    {
      query: t.Optional(t.Object({ orgId: t.Optional(t.String()) })),
      detail: { summary: "List landlord entities", tags: ["Landlord Finance"] },
    },
  )
  .get(
    "/profile/:landlordId",
    async ({ params: { landlordId }, query }) => {
      const orgId = query.orgId ?? "default";
      const [health, profile] = await Promise.all([
        landlordAnalyticsService.refreshProfile(landlordId, orgId).catch(() => null),
        landlordAnalyticsService.getPortfolioHealth(landlordId).catch(() => null),
      ]);
      return {
        landlordId,
        ...(health ?? {}),
        health: profile,
      };
    },
    {
      params: t.Object({ landlordId: t.String() }),
      query: t.Optional(t.Object({ orgId: t.Optional(t.String()) })),
      detail: { summary: "Landlord financial profile", tags: ["Landlord Finance"] },
    },
  )
  .get(
    "/portfolio/:landlordId",
    async ({ params: { landlordId } }) => landlordAnalyticsService.getPortfolioHealth(landlordId),
    { params: t.Object({ landlordId: t.String() }), detail: { summary: "Landlord portfolio health", tags: ["Landlord Finance"] } },
  );
