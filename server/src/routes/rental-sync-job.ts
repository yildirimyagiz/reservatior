import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { rentalSyncJobService } from "../services/rentalsyncjob";
import { 
  RentalSyncJobPlainInputCreate, 
  RentalSyncJobPlainInputUpdate 
} from "../../generated/prismabox/RentalSyncJob";
import { regionMiddleware } from "../middleware/region";

export const rentalSyncJobRoutes = new Elysia({ prefix: "/rental-sync-jobs" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /rental-sync-job
   * Retrieves all RentalSyncJob with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return rentalSyncJobService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await rentalSyncJobService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: RentalSyncJobPlainInputCreate
  })

  /**
   * GET /rental-sync-job/:id
   * Retrieves a single RentalSyncJob by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await rentalSyncJobService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await rentalSyncJobService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await rentalSyncJobService.withDB(db as any).delete(params.id);
      return { success: true, message: "RentalSyncJob deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RentalSyncJob not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
