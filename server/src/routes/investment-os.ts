import { Elysia, t } from "elysia";
import { investmentDealService } from "../services/investment-deal-service";
import { investmentProjectionService } from "../services/investment-projection-service";
import { marketComparablesService } from "../services/market-comparables-service";
import { marketInsightDataService } from "../services/market-insight-service";

export const investmentOSRoutes = new Elysia({ prefix: "/investment-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const [dealStats, recentDeals, insights, topDeals] = await Promise.all([
        investmentDealService.getDealStats(orgId).catch(() => null),
        investmentDealService.getByOrg(orgId, { take: 10 }).catch(() => []),
        marketInsightDataService.getLatest(undefined, 5).catch(() => []),
        investmentDealService.getByOrg(orgId, { take: 5, status: "ACTIVE" }).catch(() => []),
      ]);

      return {
        success: true,
        data: { dealStats, recentDeals, insights, topDeals },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Investment OS Dashboard", tags: ["Investment OS"] },
  })

  .get("/deals", async ({ query, set }) => {
    try {
      const { orgId, page, limit, status } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const result = await investmentDealService.getByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
      });
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      status: t.Optional(t.String()),
    }),
    detail: { summary: "List Investment Deals", tags: ["Investment OS"] },
  })

  .post("/deals", async ({ body, set }) => {
    try {
      const data = await investmentDealService.createDeal(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      userId: t.String(),
      name: t.String(),
      propertyId: t.Optional(t.String()),
      dealType: t.Optional(t.String()),
      investmentAmount: t.Optional(t.Number()),
      expectedReturn: t.Optional(t.Number()),
      riskLevel: t.Optional(t.String()),
    }),
    detail: { summary: "Create Investment Deal", tags: ["Investment OS"] },
  })

  .get("/deals/:id", async ({ params, set }) => {
    try {
      const data = await investmentDealService.getById(params.id);
      if (!data) { set.status = 404; return { error: "Deal not found" }; }
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Investment Deal", tags: ["Investment OS"] },
  })

  .patch("/deals/:id", async ({ params, body, set }) => {
    try {
      const data = await investmentDealService.updateDeal(params.id, body as any);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      name: t.Optional(t.String()),
      dealType: t.Optional(t.String()),
      status: t.Optional(t.String()),
      investmentAmount: t.Optional(t.Number()),
      expectedReturn: t.Optional(t.Number()),
      riskLevel: t.Optional(t.String()),
    }),
    detail: { summary: "Update Investment Deal", tags: ["Investment OS"] },
  })

  .post("/deals/:id/analyze", async ({ params, set }) => {
    try {
      const data = await investmentDealService.analyzeDeal(params.id);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Analyze Investment Deal", tags: ["Investment OS"] },
  })

  .post("/deals/:id/duplicate", async ({ params, body, set }) => {
    try {
      const { userId } = body as any;
      const data = await investmentDealService.duplicateDeal(params.id, userId);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({ userId: t.String() }),
    detail: { summary: "Duplicate Investment Deal", tags: ["Investment OS"] },
  })

  .get("/deals/:id/stats", async ({ params, set }) => {
    try {
      const deal = await investmentDealService.getById(params.id);
      if (!deal) { set.status = 404; return { error: "Deal not found" }; }
      const stats = await investmentDealService.getDealStats(deal.orgId);
      return { success: true, data: stats };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Deal Stats", tags: ["Investment OS"] },
  })

  .get("/projections/:dealId", async ({ params, set }) => {
    try {
      const data = await investmentProjectionService.getByDeal(params.dealId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dealId: t.String() }),
    detail: { summary: "Get Projections for Deal", tags: ["Investment OS"] },
  })

  .post("/projections/:dealId/generate", async ({ params, body, set }) => {
    try {
      const data = await investmentProjectionService.generateProjections(params.dealId, body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dealId: t.String() }),
    body: t.Object({
      years: t.Optional(t.Number()),
      annualGrowthRate: t.Optional(t.Number()),
      rentalYield: t.Optional(t.Number()),
    }),
    detail: { summary: "Generate Projections", tags: ["Investment OS"] },
  })

  .get("/projections/:dealId/summary", async ({ params, set }) => {
    try {
      const data = await investmentProjectionService.getProjectionsSummary(params.dealId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ dealId: t.String() }),
    detail: { summary: "Get Projections Summary", tags: ["Investment OS"] },
  })

  .get("/comparables/:propertyId", async ({ params, set }) => {
    try {
      const data = await marketComparablesService.getByProperty(params.propertyId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Get Comparables for Property", tags: ["Investment OS"] },
  })

  .post("/comparables", async ({ body, set }) => {
    try {
      const data = await marketComparablesService.addComparable(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      propertyId: t.String(),
      comparablePropertyId: t.Optional(t.String()),
      address: t.Optional(t.String()),
      price: t.Optional(t.Number()),
      squareFootage: t.Optional(t.Number()),
      bedrooms: t.Optional(t.Number()),
      bathrooms: t.Optional(t.Number()),
      distance: t.Optional(t.Number()),
    }),
    detail: { summary: "Add Comparable", tags: ["Investment OS"] },
  })

  .delete("/comparables/:id", async ({ params, set }) => {
    try {
      await marketComparablesService.removeComparable(params.id);
      return { success: true, message: "Comparable removed" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Remove Comparable", tags: ["Investment OS"] },
  })

  .get("/comparables/:propertyId/adjusted-price", async ({ params, set }) => {
    try {
      const data = await marketComparablesService.getAdjustedPrice(params.propertyId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Get Adjusted Price", tags: ["Investment OS"] },
  })

  .get("/insights", async ({ query, set }) => {
    try {
      const { region, limit } = query;
      const data = await marketInsightDataService.getLatest(region as string | undefined, parseInt(limit as string) || 10);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      region: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "Get Market Insights", tags: ["Investment OS"] },
  })

  .get("/insights/:region", async ({ params, set }) => {
    try {
      const data = await marketInsightDataService.getByRegion(params.region);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ region: t.String() }),
    detail: { summary: "Get Insights by Region", tags: ["Investment OS"] },
  })

  .get("/insights/:region/trends", async ({ params, query, set }) => {
    try {
      const { months } = query;
      const data = await marketInsightDataService.getTrends(params.region, parseInt(months as string) || 6);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ region: t.String() }),
    query: t.Object({ months: t.Optional(t.String()) }),
    detail: { summary: "Get Market Trends", tags: ["Investment OS"] },
  })

  .post("/insights/generate", async ({ body, set }) => {
    try {
      const { region, type, period } = body as any;
      const data = await marketInsightDataService.generateInsight(region, { type, period });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      region: t.String(),
      type: t.Optional(t.String()),
      period: t.Optional(t.String()),
    }),
    detail: { summary: "Generate Market Insight", tags: ["Investment OS"] },
  });
