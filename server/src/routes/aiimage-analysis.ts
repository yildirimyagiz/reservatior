import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIImageAnalysisService } from "../services/aiimageanalysis";
import { 
  AIImageAnalysisPlainInputCreate, 
  AIImageAnalysisPlainInputUpdate 
} from "../../generated/prismabox/AIImageAnalysis";
import { regionMiddleware } from "../middleware/region";

export const aiimageAnalysisRoutes = new Elysia({ prefix: "/ai-ext/image-analyses" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aiimage-analysis
   * Retrieves all AIImageAnalysis with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIImageAnalysisService.withDB(db as any).getAll({
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
   * POST /aiimage-analysis
   * Creates a new AIImageAnalysis.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIImageAnalysisService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIImageAnalysisPlainInputCreate
  })

  /**
   * GET /aiimage-analysis/:id
   * Retrieves a single AIImageAnalysis by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIImageAnalysisService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIImageAnalysis not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aiimage-analysis/:id
   * Updates an existing AIImageAnalysis.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIImageAnalysisService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIImageAnalysis not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIImageAnalysisPlainInputUpdate
  })

  /**
   * DELETE /aiimage-analysis/:id
   * Deletes a AIImageAnalysis.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIImageAnalysisService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIImageAnalysis deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIImageAnalysis not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
