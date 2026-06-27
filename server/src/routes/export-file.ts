import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { exportFileService } from "../services/exportfile";
import { 
  ExportFilePlainInputCreate, 
  ExportFilePlainInputUpdate 
} from "../../generated/prismabox/ExportFile";
import { regionMiddleware } from "../middleware/region";

export const exportFileRoutes = new Elysia({ prefix: "/export-files" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /export-file
   * Retrieves all ExportFile with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return exportFileService.withDB(db as any).getAll({
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
   * POST /export-file
   * Creates a new ExportFile.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await exportFileService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExportFilePlainInputCreate
  })

  /**
   * GET /export-file/:id
   * Retrieves a single ExportFile by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await exportFileService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ExportFile not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /export-file/:id
   * Updates an existing ExportFile.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await exportFileService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ExportFile not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ExportFilePlainInputUpdate
  })

  /**
   * DELETE /export-file/:id
   * Deletes a ExportFile.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await exportFileService.withDB(db as any).delete(params.id);
      return { success: true, message: "ExportFile deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExportFile not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
