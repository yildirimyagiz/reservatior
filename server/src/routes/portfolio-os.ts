import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

/**
 * Portfolio OS — Unified dashboard for investor portfolios, REO assets, valuations.
 *
 * Existing sub-routes: /investor-portfolios, /investor-properties,
 *   /institutional-portfolios, /reo-properties, /property-valuation
 *
 * This OS route provides the aggregated dashboard + cross-cutting queries.
 */
export const portfolioOSRoutes = new Elysia({ prefix: "/portfolio-os" })
  .use(authMiddleware)

  // ─── Dashboard ───────────────────────────────────────────────────────────
  .get(
    "/dashboard",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const [totalPortfolios, totalHoldings, totalValuations, reoCount, totalInvestmentValue] =
          await Promise.all([
            prisma.institutionalPortfolio.count({ where: { orgId } }),
            prisma.portfolioHolding.count({ where: { orgId } }),
            prisma.propertyValuation.count({ where: { orgId } }),
            prisma.rEOProperty.count({ where: { orgId } }),
            prisma.portfolioHolding.aggregate({
              where: { orgId },
              _sum: { purchasePrice: true },
            }),
          ]);

        return {
          success: true,
          data: {
            portfolios: totalPortfolios,
            holdings: totalHoldings,
            valuations: totalValuations,
            reoAssets: reoCount,
            totalInvestmentValue: Number(totalInvestmentValue._sum.purchasePrice ?? 0),
          },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["Portfolio OS"], summary: "Portfolio dashboard overview" } }
  )

  // ─── Institutional Portfolios ────────────────────────────────────────────
  .get(
    "/portfolios",
    async ({ query, set }) => {
      const { orgId, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const [portfolios, total] = await Promise.all([
          prisma.institutionalPortfolio.findMany({
            where: { orgId },
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
            include: { holdings: true },
          }),
          prisma.institutionalPortfolio.count({ where: { orgId } }),
        ]);
        return { success: true, data: { portfolios, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Portfolio OS"], summary: "List institutional portfolios" },
    }
  )

  // ─── Holdings ────────────────────────────────────────────────────────────
  .get(
    "/holdings",
    async ({ query, set }) => {
      const { orgId, portfolioId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (portfolioId) where.portfolioId = portfolioId;
        const holdings = await prisma.portfolioHolding.findMany({
          where,
          orderBy: { acquisitionDate: "desc" },
        });
        return { success: true, data: holdings };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({ orgId: t.String(), portfolioId: t.Optional(t.String()) }),
      detail: { tags: ["Portfolio OS"], summary: "List holdings" },
    }
  )

  // ─── REO Properties ──────────────────────────────────────────────────────
  .get(
    "/reo",
    async ({ query, set }) => {
      const { orgId, status, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (status) where.status = status;
        const [properties, total] = await Promise.all([
          prisma.rEOProperty.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { acquiredAt: "desc" },
          }),
          prisma.rEOProperty.count({ where }),
        ]);
        return { success: true, data: { properties, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        status: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Portfolio OS"], summary: "List REO properties" },
    }
  )

  // ─── REO Status Change (emits event) ─────────────────────────────────────
  .patch(
    "/reo/:id/status",
    async ({ params, body, set }) => {
      const { id } = params;
      const { status } = body;
      try {
        const property = await prisma.rEOProperty.update({ where: { id }, data: { status: status as any } });

        const eventMap: Record<string, string> = {
          SOLD: DomainEvents.REO_PROPERTY_SOLD,
          BANK_OWNED: DomainEvents.REO_PROPERTY_ACQUIRED,
          LISTED_FOR_SALE: DomainEvents.REO_PROPERTY_LISTED,
        };
        const eventName = eventMap[status];
        if (eventName) {
          eventBus.publish(eventName, { propertyId: id, status, orgId: property.orgId }, "PortfolioOS");
        }

        return { success: true, data: property };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      body: t.Object({ status: t.String() }),
      detail: { tags: ["Portfolio OS"], summary: "Update REO property status" },
    }
  )

  // ─── Valuations ──────────────────────────────────────────────────────────
  .get(
    "/valuations",
    async ({ query, set }) => {
      const { orgId, propertyId, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (propertyId) where.propertyId = propertyId;
        const [valuations, total] = await Promise.all([
          prisma.propertyValuation.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { valuationDate: "desc" },
          }),
          prisma.propertyValuation.count({ where }),
        ]);
        return { success: true, data: { valuations, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        propertyId: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["Portfolio OS"], summary: "List valuations" },
    }
  )

  // ─── Valuation Request (emits event) ─────────────────────────────────────
  .post(
    "/valuations/request",
    async ({ body, set }) => {
      const { propertyId, orgId, requestedBy, notes } = body;
      try {
        const valuation = await prisma.propertyValuation.create({
          data: {
            propertyId,
            orgId,
            userId: requestedBy,
            status: "PENDING",
            value: 0,
            valuationDate: new Date(),
            metadata: notes ? { notes } : undefined,
          },
        });
        eventBus.publish(DomainEvents.VALUATION_REQUESTED, { valuationId: valuation.id, propertyId, orgId }, "PortfolioOS");
        return { success: true, data: valuation };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        propertyId: t.String(),
        orgId: t.String(),
        requestedBy: t.String(),
        notes: t.Optional(t.String()),
      }),
      detail: { tags: ["Portfolio OS"], summary: "Request property valuation" },
    }
  )

  // ─── Portfolio Analytics ─────────────────────────────────────────────────
  .get(
    "/analytics",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const reoByStatus = await prisma.rEOProperty.groupBy({
          by: ["status"],
          where: { orgId },
          _count: true,
        });
        const holdingsByOccupancy = await prisma.portfolioHolding.groupBy({
          by: ["occupancyStatus"],
          where: { orgId },
          _count: true,
          _sum: { currentValue: true },
        });
        return { success: true, data: { reoByStatus, holdingsByOccupancy } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["Portfolio OS"], summary: "Portfolio analytics" } }
  );
