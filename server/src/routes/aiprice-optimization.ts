import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIPriceOptimizationService } from "../services/aipriceoptimization";
import { 
  AIPriceOptimizationPlainInputCreate, 
  AIPriceOptimizationPlainInputUpdate 
} from "../../generated/prismabox/AIPriceOptimization";
import { regionMiddleware } from "../middleware/region";

export const aipriceOptimizationRoutes = new Elysia({ prefix: "/ai-price-optimizations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aiprice-optimization
   * Retrieves all AIPriceOptimization with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIPriceOptimizationService.withDB(db as any).getAll({
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
   * POST /aiprice-optimization
   * Creates a new AIPriceOptimization.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIPriceOptimizationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIPriceOptimizationPlainInputCreate
  })

  /**
   * GET /aiprice-optimization/:id
   * Retrieves a single AIPriceOptimization by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIPriceOptimizationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIPriceOptimization not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aiprice-optimization/:id
   * Updates an existing AIPriceOptimization.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIPriceOptimizationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIPriceOptimization not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIPriceOptimizationPlainInputUpdate
  })

  /**
   * DELETE /aiprice-optimization/:id
   * Deletes a AIPriceOptimization.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIPriceOptimizationService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIPriceOptimization deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIPriceOptimization not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
