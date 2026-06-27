import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { marketRateComparisonService } from "../services/marketratecomparison";
import { 
  MarketRateComparisonPlainInputCreate, 
  MarketRateComparisonPlainInputUpdate 
} from "../../generated/prismabox/MarketRateComparison";
import { regionMiddleware } from "../middleware/region";

export const marketRateComparisonRoutes = new Elysia({ prefix: "/market-rate-comparison" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /market-rate-comparison
   * Retrieves all MarketRateComparison with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return marketRateComparisonService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /market-rate-comparison
   * Creates a new MarketRateComparison.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await marketRateComparisonService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MarketRateComparisonPlainInputCreate
  })

  /**
   * GET /market-rate-comparison/:id
   * Retrieves a single MarketRateComparison by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await marketRateComparisonService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MarketRateComparison not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /market-rate-comparison/:id
   * Updates an existing MarketRateComparison.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await marketRateComparisonService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MarketRateComparison not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MarketRateComparisonPlainInputUpdate
  })

  /**
   * DELETE /market-rate-comparison/:id
   * Deletes a MarketRateComparison.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await marketRateComparisonService.withDB(db as any).delete(params.id);
      return { success: true, message: "MarketRateComparison deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MarketRateComparison not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
