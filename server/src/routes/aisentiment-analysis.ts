import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aISentimentAnalysisService } from "../services/aisentimentanalysis";
import { 
  AISentimentAnalysisPlainInputCreate, 
  AISentimentAnalysisPlainInputUpdate 
} from "../../generated/prismabox/AISentimentAnalysis";

export const aisentimentAnalysisRoutes = new Elysia({ prefix: "/ai-sentiment-analyses" })
  .use(authMiddleware)

  /**
   * GET /aisentiment-analysis
   * Retrieves all AISentimentAnalysis with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aISentimentAnalysisService.getAll({
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
   * POST /aisentiment-analysis
   * Creates a new AISentimentAnalysis.
   */
  .post("/", async ({ body, set }) => {
    const data = await aISentimentAnalysisService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AISentimentAnalysisPlainInputCreate
  })

  /**
   * GET /aisentiment-analysis/:id
   * Retrieves a single AISentimentAnalysis by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aISentimentAnalysisService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AISentimentAnalysis not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aisentiment-analysis/:id
   * Updates an existing AISentimentAnalysis.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aISentimentAnalysisService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AISentimentAnalysis not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AISentimentAnalysisPlainInputUpdate
  })

  /**
   * DELETE /aisentiment-analysis/:id
   * Deletes a AISentimentAnalysis.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aISentimentAnalysisService.delete(params.id);
      return { success: true, message: "AISentimentAnalysis deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AISentimentAnalysis not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
