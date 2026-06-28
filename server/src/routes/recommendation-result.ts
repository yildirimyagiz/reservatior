import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { recommendationResultService } from "../services/recommendationresult";
import { 
  RecommendationResultPlainInputCreate, 
  RecommendationResultPlainInputUpdate 
} from "prismabox/RecommendationResult";

export const recommendationResultRoutes = new Elysia({ prefix: "/recommendation-results" })
  .use(authMiddleware)

  /**
   * GET /recommendation-result
   * Retrieves all RecommendationResult with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return recommendationResultService.getAll({
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
   * POST /recommendation-result
   * Creates a new RecommendationResult.
   */
  .post("/", async ({ body, set }) => {
    const data = await recommendationResultService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: RecommendationResultPlainInputCreate
  })

  /**
   * GET /recommendation-result/:id
   * Retrieves a single RecommendationResult by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await recommendationResultService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "RecommendationResult not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /recommendation-result/:id
   * Updates an existing RecommendationResult.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await recommendationResultService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "RecommendationResult not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RecommendationResultPlainInputUpdate
  })

  /**
   * DELETE /recommendation-result/:id
   * Deletes a RecommendationResult.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await recommendationResultService.delete(params.id);
      return { success: true, message: "RecommendationResult deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RecommendationResult not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
