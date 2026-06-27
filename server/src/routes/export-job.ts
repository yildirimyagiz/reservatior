import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { exportJobService } from "../services/exportjob";
import { 
  ExportJobPlainInputCreate, 
  ExportJobPlainInputUpdate 
} from "../../generated/prismabox/ExportJob";

export const exportJobRoutes = new Elysia({ prefix: "/export-jobs" })
  .use(authMiddleware)

  /**
   * GET /export-job
   * Retrieves all ExportJob with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return exportJobService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await exportJobService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExportJobPlainInputCreate
  })

  /**
   * GET /export-job/:id
   * Retrieves a single ExportJob by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await exportJobService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await exportJobService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await exportJobService.delete(params.id);
      return { success: true, message: "ExportJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExportJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
