import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIPropertyValuationService } from "../services/aipropertyvaluation";
import { 
  AIPropertyValuationPlainInputCreate, 
  AIPropertyValuationPlainInputUpdate 
} from "../../generated/prismabox/AIPropertyValuation";
import { regionMiddleware } from "../middleware/region";

export const aipropertyValuationRoutes = new Elysia({ prefix: "/ai-property-valuations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aiproperty-valuation
   * Retrieves all AIPropertyValuation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIPropertyValuationService.withDB(db as any).getAll({
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
   * POST /aiproperty-valuation
   * Creates a new AIPropertyValuation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIPropertyValuationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIPropertyValuationPlainInputCreate
  })

  /**
   * GET /aiproperty-valuation/:id
   * Retrieves a single AIPropertyValuation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIPropertyValuationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIPropertyValuation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aiproperty-valuation/:id
   * Updates an existing AIPropertyValuation.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIPropertyValuationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIPropertyValuation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIPropertyValuationPlainInputUpdate
  })

  /**
   * DELETE /aiproperty-valuation/:id
   * Deletes a AIPropertyValuation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIPropertyValuationService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIPropertyValuation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIPropertyValuation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
