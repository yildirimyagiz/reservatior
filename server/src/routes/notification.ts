import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { notificationService } from "../services/notification";
import { 
  NotificationPlainInputCreate, 
  NotificationPlainInputUpdate 
} from "../../generated/prismabox/Notification";

export const notificationRoutes = new Elysia({ prefix: "/notification" })
  .use(authMiddleware)

  /**
   * GET /notification
   * Retrieves all Notification with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return notificationService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await notificationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: NotificationPlainInputCreate
  })

  /**
   * GET /notification/:id
   * Retrieves a single Notification by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await notificationService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await notificationService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await notificationService.delete(params.id);
      return { success: true, message: "Notification deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Notification not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
