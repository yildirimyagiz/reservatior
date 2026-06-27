import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIInvestmentAnalysisService } from "../services/aiinvestmentanalysis";
import { 
  AIInvestmentAnalysisPlainInputCreate, 
  AIInvestmentAnalysisPlainInputUpdate 
} from "../../generated/prismabox/AIInvestmentAnalysis";

export const aiinvestmentAnalysisRoutes = new Elysia({ prefix: "/ai-investment-analyses" })
  .use(authMiddleware)

  /**
   * GET /aiinvestment-analysis
   * Retrieves all AIInvestmentAnalysis with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIInvestmentAnalysisService.getAll({
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
   * POST /aiinvestment-analysis
   * Creates a new AIInvestmentAnalysis.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIInvestmentAnalysisService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIInvestmentAnalysisPlainInputCreate
  })

  /**
   * GET /aiinvestment-analysis/:id
   * Retrieves a single AIInvestmentAnalysis by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIInvestmentAnalysisService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIInvestmentAnalysis not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aiinvestment-analysis/:id
   * Updates an existing AIInvestmentAnalysis.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIInvestmentAnalysisService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIInvestmentAnalysis not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIInvestmentAnalysisPlainInputUpdate
  })

  /**
   * DELETE /aiinvestment-analysis/:id
   * Deletes a AIInvestmentAnalysis.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIInvestmentAnalysisService.delete(params.id);
      return { success: true, message: "AIInvestmentAnalysis deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIInvestmentAnalysis not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
