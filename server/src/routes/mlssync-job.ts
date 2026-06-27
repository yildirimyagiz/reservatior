import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLSSyncJobService } from "../services/mlssyncjob";
import { 
  MLSSyncJobPlainInputCreate, 
  MLSSyncJobPlainInputUpdate 
} from "../../generated/prismabox/MLSSyncJob";

export const mlssyncJobRoutes = new Elysia({ prefix: "/mlssync-job" })
  .use(authMiddleware)

  /**
   * GET /mlssync-job
   * Retrieves all MLSSyncJob with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mLSSyncJobService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await mLSSyncJobService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLSSyncJobPlainInputCreate
  })

  /**
   * GET /mlssync-job/:id
   * Retrieves a single MLSSyncJob by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mLSSyncJobService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mLSSyncJobService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await mLSSyncJobService.delete(params.id);
      return { success: true, message: "MLSSyncJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLSSyncJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
