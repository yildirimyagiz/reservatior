import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { projectReportService } from "../services/projectreport";
import { 
  ProjectReportPlainInputCreate, 
  ProjectReportPlainInputUpdate 
} from "../../generated/prismabox/ProjectReport";

export const projectReportRoutes = new Elysia({ prefix: "/project-reports" })
  .use(authMiddleware)

  /**
   * GET /project-report
   * Retrieves all ProjectReport with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return projectReportService.getAll({
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
   * POST /project-report
   * Creates a new ProjectReport.
   */
  .post("/", async ({ body, set }) => {
    const data = await projectReportService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ProjectReportPlainInputCreate
  })

  /**
   * GET /project-report/:id
   * Retrieves a single ProjectReport by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await projectReportService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ProjectReport not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /project-report/:id
   * Updates an existing ProjectReport.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await projectReportService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectReport not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ProjectReportPlainInputUpdate
  })

  /**
   * DELETE /project-report/:id
   * Deletes a ProjectReport.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await projectReportService.delete(params.id);
      return { success: true, message: "ProjectReport deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectReport not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
