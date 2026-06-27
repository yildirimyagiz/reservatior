import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { jobService } from "../services/job";
import { 
  JobPlainInputCreate, 
  JobPlainInputUpdate 
} from "../../generated/prismabox/Job";

export const jobRoutes = new Elysia({ prefix: "/jobs" })
  .use(authMiddleware)

  /**
   * GET /job
   * Retrieves all Job with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return jobService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await jobService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: JobPlainInputCreate
  })

  /**
   * GET /job/:id
   * Retrieves a single Job by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await jobService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await jobService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await jobService.delete(params.id);
      return { success: true, message: "Job deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Job not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
