import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIMarketAnalysisService } from "../services/aimarketanalysis";
import { 
  AIMarketAnalysisPlainInputCreate, 
  AIMarketAnalysisPlainInputUpdate 
} from "../../generated/prismabox/AIMarketAnalysis";

export const aimarketAnalysisRoutes = new Elysia({ prefix: "/ai-market-analyses" })
  .use(authMiddleware)

  /**
   * GET /aimarket-analysis
   * Retrieves all AIMarketAnalysis with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIMarketAnalysisService.getAll({
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
   * POST /aimarket-analysis
   * Creates a new AIMarketAnalysis.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIMarketAnalysisService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIMarketAnalysisPlainInputCreate
  })

  /**
   * GET /aimarket-analysis/:id
   * Retrieves a single AIMarketAnalysis by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIMarketAnalysisService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIMarketAnalysis not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aimarket-analysis/:id
   * Updates an existing AIMarketAnalysis.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIMarketAnalysisService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIMarketAnalysis not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIMarketAnalysisPlainInputUpdate
  })

  /**
   * DELETE /aimarket-analysis/:id
   * Deletes a AIMarketAnalysis.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIMarketAnalysisService.delete(params.id);
      return { success: true, message: "AIMarketAnalysis deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIMarketAnalysis not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
