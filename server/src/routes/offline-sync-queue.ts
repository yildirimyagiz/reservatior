import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { offlineSyncQueueService } from "../services/offlinesyncqueue";
import { 
  OfflineSyncQueuePlainInputCreate, 
  OfflineSyncQueuePlainInputUpdate 
} from "../../generated/prismabox/OfflineSyncQueue";
import { regionMiddleware } from "../middleware/region";

export const offlineSyncQueueRoutes = new Elysia({ prefix: "/offline-sync-queues" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /offline-sync-queue
   * Retrieves all OfflineSyncQueue with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return offlineSyncQueueService.withDB(db as any).getAll({
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
   * POST /offline-sync-queue
   * Creates a new OfflineSyncQueue.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await offlineSyncQueueService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: OfflineSyncQueuePlainInputCreate
  })

  /**
   * GET /offline-sync-queue/:id
   * Retrieves a single OfflineSyncQueue by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await offlineSyncQueueService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "OfflineSyncQueue not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /offline-sync-queue/:id
   * Updates an existing OfflineSyncQueue.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await offlineSyncQueueService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "OfflineSyncQueue not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: OfflineSyncQueuePlainInputUpdate
  })

  /**
   * DELETE /offline-sync-queue/:id
   * Deletes a OfflineSyncQueue.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await offlineSyncQueueService.withDB(db as any).delete(params.id);
      return { success: true, message: "OfflineSyncQueue deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "OfflineSyncQueue not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
