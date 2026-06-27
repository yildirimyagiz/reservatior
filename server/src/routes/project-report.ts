import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { projectReportService } from "../services/projectreport";
import { 
  ProjectReportPlainInputCreate, 
  ProjectReportPlainInputUpdate 
} from "../../generated/prismabox/ProjectReport";
import { regionMiddleware } from "../middleware/region";

export const projectReportRoutes = new Elysia({ prefix: "/project-reports" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /project-report
   * Retrieves all ProjectReport with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return projectReportService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await projectReportService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ProjectReportPlainInputCreate
  })

  /**
   * GET /project-report/:id
   * Retrieves a single ProjectReport by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await projectReportService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await projectReportService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await projectReportService.withDB(db as any).delete(params.id);
      return { success: true, message: "ProjectReport deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ProjectReport not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
