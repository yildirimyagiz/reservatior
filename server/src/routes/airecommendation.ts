import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIRecommendationService } from "../services/airecommendation";
import { 
  AIRecommendationPlainInputCreate, 
  AIRecommendationPlainInputUpdate 
} from "../../generated/prismabox/AIRecommendation";
import { regionMiddleware } from "../middleware/region";

export const airecommendationRoutes = new Elysia({ prefix: "/ai-recommendations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /airecommendation
   * Retrieves all AIRecommendation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIRecommendationService.withDB(db as any).getAll({
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
   * POST /airecommendation
   * Creates a new AIRecommendation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIRecommendationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIRecommendationPlainInputCreate
  })

  /**
   * GET /airecommendation/:id
   * Retrieves a single AIRecommendation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIRecommendationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIRecommendation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /airecommendation/:id
   * Updates an existing AIRecommendation.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIRecommendationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIRecommendation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIRecommendationPlainInputUpdate
  })

  /**
   * DELETE /airecommendation/:id
   * Deletes a AIRecommendation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIRecommendationService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIRecommendation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIRecommendation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
