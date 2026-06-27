import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { offlineSyncQueueService } from "../services/offlinesyncqueue";
import { 
  OfflineSyncQueuePlainInputCreate, 
  OfflineSyncQueuePlainInputUpdate 
} from "../../generated/prismabox/OfflineSyncQueue";

export const offlineSyncQueueRoutes = new Elysia({ prefix: "/offline-sync-queues" })
  .use(authMiddleware)

  /**
   * GET /offline-sync-queue
   * Retrieves all OfflineSyncQueue with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return offlineSyncQueueService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await offlineSyncQueueService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: OfflineSyncQueuePlainInputCreate
  })

  /**
   * GET /offline-sync-queue/:id
   * Retrieves a single OfflineSyncQueue by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await offlineSyncQueueService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await offlineSyncQueueService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await offlineSyncQueueService.delete(params.id);
      return { success: true, message: "OfflineSyncQueue deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "OfflineSyncQueue not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
