import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { reportService } from "../services/report";
import { 
  ReportPlainInputCreate, 
  ReportPlainInputUpdate 
} from "../../generated/prismabox/Report";
import { regionMiddleware } from "../middleware/region";

export const reportRoutes = new Elysia({ prefix: "/reports" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /report
   * Retrieves all Report with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return reportService.withDB(db as any).getAll({
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
   * POST /report
   * Creates a new Report.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await reportService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReportPlainInputCreate
  })

  /**
   * GET /report/:id
   * Retrieves a single Report by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await reportService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Report not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /report/:id
   * Updates an existing Report.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await reportService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Report not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReportPlainInputUpdate
  })

  /**
   * DELETE /report/:id
   * Deletes a Report.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await reportService.withDB(db as any).delete(params.id);
      return { success: true, message: "Report deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Report not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
