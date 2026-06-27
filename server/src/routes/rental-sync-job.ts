import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { rentalSyncJobService } from "../services/rentalsyncjob";
import { 
  RentalSyncJobPlainInputCreate, 
  RentalSyncJobPlainInputUpdate 
} from "../../generated/prismabox/RentalSyncJob";

export const rentalSyncJobRoutes = new Elysia({ prefix: "/rental-sync-jobs" })
  .use(authMiddleware)

  /**
   * GET /rental-sync-job
   * Retrieves all RentalSyncJob with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return rentalSyncJobService.getAll({
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
   * POST /rental-sync-job
   * Creates a new RentalSyncJob.
   */
  .post("/", async ({ body, set }) => {
    const data = await rentalSyncJobService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: RentalSyncJobPlainInputCreate
  })

  /**
   * GET /rental-sync-job/:id
   * Retrieves a single RentalSyncJob by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await rentalSyncJobService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "RentalSyncJob not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /rental-sync-job/:id
   * Updates an existing RentalSyncJob.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await rentalSyncJobService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "RentalSyncJob not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RentalSyncJobPlainInputUpdate
  })

  /**
   * DELETE /rental-sync-job/:id
   * Deletes a RentalSyncJob.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await rentalSyncJobService.delete(params.id);
      return { success: true, message: "RentalSyncJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RentalSyncJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
