import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLSSyncJobService } from "../services/mlssyncjob";
import { 
  MLSSyncJobPlainInputCreate, 
  MLSSyncJobPlainInputUpdate 
} from "../../generated/prismabox/MLSSyncJob";
import { regionMiddleware } from "../middleware/region";

export const mlssyncJobRoutes = new Elysia({ prefix: "/mlssync-job" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mlssync-job
   * Retrieves all MLSSyncJob with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mLSSyncJobService.withDB(db as any).getAll({
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
   * POST /mlssync-job
   * Creates a new MLSSyncJob.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mLSSyncJobService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLSSyncJobPlainInputCreate
  })

  /**
   * GET /mlssync-job/:id
   * Retrieves a single MLSSyncJob by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mLSSyncJobService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MLSSyncJob not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mlssync-job/:id
   * Updates an existing MLSSyncJob.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mLSSyncJobService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MLSSyncJob not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MLSSyncJobPlainInputUpdate
  })

  /**
   * DELETE /mlssync-job/:id
   * Deletes a MLSSyncJob.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mLSSyncJobService.withDB(db as any).delete(params.id);
      return { success: true, message: "MLSSyncJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLSSyncJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
