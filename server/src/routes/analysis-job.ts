import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { analysisJobService } from "../services/analysisjob";
import { 
  AnalysisJobPlainInputCreate, 
  AnalysisJobPlainInputUpdate 
} from "../../generated/prismabox/AnalysisJob";

export const analysisJobRoutes = new Elysia({ prefix: "/analysis-jobs" })
  .use(authMiddleware)

  /**
   * GET /analysis-job
   * Retrieves all AnalysisJob with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return analysisJobService.getAll({
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
   * POST /analysis-job
   * Creates a new AnalysisJob.
   */
  .post("/", async ({ body, set }) => {
    const data = await analysisJobService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AnalysisJobPlainInputCreate
  })

  /**
   * GET /analysis-job/:id
   * Retrieves a single AnalysisJob by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await analysisJobService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AnalysisJob not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /analysis-job/:id
   * Updates an existing AnalysisJob.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await analysisJobService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AnalysisJob not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AnalysisJobPlainInputUpdate
  })

  /**
   * DELETE /analysis-job/:id
   * Deletes a AnalysisJob.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await analysisJobService.delete(params.id);
      return { success: true, message: "AnalysisJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AnalysisJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
