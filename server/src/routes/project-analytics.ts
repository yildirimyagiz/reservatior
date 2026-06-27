import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { projectAnalyticsService } from "../services/projectanalytics";
import { 
  ProjectAnalyticsPlainInputCreate, 
  ProjectAnalyticsPlainInputUpdate 
} from "../../generated/prismabox/ProjectAnalytics";

export const projectAnalyticsRoutes = new Elysia({ prefix: "/project-analyticses" })
  .use(authMiddleware)

  /**
   * GET /project-analytics
   * Retrieves all ProjectAnalytics with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return projectAnalyticsService.getAll({
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
   * POST /project-analytics
   * Creates a new ProjectAnalytics.
   */
  .post("/", async ({ body, set }) => {
    const data = await projectAnalyticsService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ProjectAnalyticsPlainInputCreate
  })

  /**
   * GET /project-analytics/:id
   * Retrieves a single ProjectAnalytics by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await projectAnalyticsService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ProjectAnalytics not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /project-analytics/:id
   * Updates an existing ProjectAnalytics.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await projectAnalyticsService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectAnalytics not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ProjectAnalyticsPlainInputUpdate
  })

  /**
   * DELETE /project-analytics/:id
   * Deletes a ProjectAnalytics.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await projectAnalyticsService.delete(params.id);
      return { success: true, message: "ProjectAnalytics deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectAnalytics not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
