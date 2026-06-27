import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIInvestmentAnalysisService } from "../services/aiinvestmentanalysis";
import { 
  AIInvestmentAnalysisPlainInputCreate, 
  AIInvestmentAnalysisPlainInputUpdate 
} from "../../generated/prismabox/AIInvestmentAnalysis";
import { regionMiddleware } from "../middleware/region";

export const aiinvestmentAnalysisRoutes = new Elysia({ prefix: "/ai-investment-analyses" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aiinvestment-analysis
   * Retrieves all AIInvestmentAnalysis with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIInvestmentAnalysisService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIInvestmentAnalysisService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIInvestmentAnalysisPlainInputCreate
  })

  /**
   * GET /aiinvestment-analysis/:id
   * Retrieves a single AIInvestmentAnalysis by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIInvestmentAnalysisService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIInvestmentAnalysisService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIInvestmentAnalysisService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIInvestmentAnalysis deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIInvestmentAnalysis not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
