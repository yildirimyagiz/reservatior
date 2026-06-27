import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIRecommendationService } from "../services/airecommendation";
import { 
  AIRecommendationPlainInputCreate, 
  AIRecommendationPlainInputUpdate 
} from "../../generated/prismabox/AIRecommendation";

export const airecommendationRoutes = new Elysia({ prefix: "/ai-recommendations" })
  .use(authMiddleware)

  /**
   * GET /airecommendation
   * Retrieves all AIRecommendation with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIRecommendationService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await aIRecommendationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIRecommendationPlainInputCreate
  })

  /**
   * GET /airecommendation/:id
   * Retrieves a single AIRecommendation by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIRecommendationService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIRecommendationService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIRecommendationService.delete(params.id);
      return { success: true, message: "AIRecommendation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIRecommendation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
