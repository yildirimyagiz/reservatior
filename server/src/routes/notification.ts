import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { notificationService } from "../services/notification";
import { 
  NotificationPlainInputCreate, 
  NotificationPlainInputUpdate 
} from "../../generated/prismabox/Notification";
import { regionMiddleware } from "../middleware/region";

export const notificationRoutes = new Elysia({ prefix: "/notification" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /notification
   * Retrieves all Notification with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return notificationService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
      include: {
        org: true,
        user: true,
        agencies: true,
        agents: true,
        tenants: true
      }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /notification
   * Creates a new Notification.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await notificationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: NotificationPlainInputCreate
  })

  /**
   * GET /notification/:id
   * Retrieves a single Notification by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await notificationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Notification not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /notification/:id
   * Updates an existing Notification.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await notificationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Notification not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: NotificationPlainInputUpdate
  })

  /**
   * DELETE /notification/:id
   * Deletes a Notification.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await notificationService.withDB(db as any).delete(params.id);
      return { success: true, message: "Notification deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Notification not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
