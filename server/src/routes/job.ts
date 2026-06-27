import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { jobService } from "../services/job";
import { 
  JobPlainInputCreate, 
  JobPlainInputUpdate 
} from "../../generated/prismabox/Job";
import { regionMiddleware } from "../middleware/region";

export const jobRoutes = new Elysia({ prefix: "/jobs" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /job
   * Retrieves all Job with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return jobService.withDB(db as any).getAll({
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
   * POST /job
   * Creates a new Job.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await jobService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: JobPlainInputCreate
  })

  /**
   * GET /job/:id
   * Retrieves a single Job by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await jobService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Job not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /job/:id
   * Updates an existing Job.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await jobService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Job not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: JobPlainInputUpdate
  })

  /**
   * DELETE /job/:id
   * Deletes a Job.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await jobService.withDB(db as any).delete(params.id);
      return { success: true, message: "Job deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Job not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
