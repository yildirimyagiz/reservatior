import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { marketRateComparisonService } from "../services/marketratecomparison";
import { 
  MarketRateComparisonPlainInputCreate, 
  MarketRateComparisonPlainInputUpdate 
} from "../../generated/prismabox/MarketRateComparison";

export const marketRateComparisonRoutes = new Elysia({ prefix: "/market-rate-comparison" })
  .use(authMiddleware)

  /**
   * GET /market-rate-comparison
   * Retrieves all MarketRateComparison with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return marketRateComparisonService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await marketRateComparisonService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MarketRateComparisonPlainInputCreate
  })

  /**
   * GET /market-rate-comparison/:id
   * Retrieves a single MarketRateComparison by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await marketRateComparisonService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await marketRateComparisonService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await marketRateComparisonService.delete(params.id);
      return { success: true, message: "MarketRateComparison deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MarketRateComparison not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
