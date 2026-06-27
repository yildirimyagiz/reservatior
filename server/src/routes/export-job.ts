import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { exportJobService } from "../services/exportjob";
import { 
  ExportJobPlainInputCreate, 
  ExportJobPlainInputUpdate 
} from "../../generated/prismabox/ExportJob";
import { regionMiddleware } from "../middleware/region";

export const exportJobRoutes = new Elysia({ prefix: "/export-jobs" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /export-job
   * Retrieves all ExportJob with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return exportJobService.withDB(db as any).getAll({
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
   * POST /export-job
   * Creates a new ExportJob.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await exportJobService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExportJobPlainInputCreate
  })

  /**
   * GET /export-job/:id
   * Retrieves a single ExportJob by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await exportJobService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ExportJob not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /export-job/:id
   * Updates an existing ExportJob.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await exportJobService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ExportJob not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ExportJobPlainInputUpdate
  })

  /**
   * DELETE /export-job/:id
   * Deletes a ExportJob.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await exportJobService.withDB(db as any).delete(params.id);
      return { success: true, message: "ExportJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExportJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
