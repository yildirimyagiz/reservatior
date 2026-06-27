import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { queueMessageService } from "../services/queuemessage";
import { 
  QueueMessagePlainInputCreate, 
  QueueMessagePlainInputUpdate 
} from "../../generated/prismabox/QueueMessage";

export const queueMessageRoutes = new Elysia({ prefix: "/queue-messages" })
  .use(authMiddleware)

  /**
   * GET /queue-message
   * Retrieves all QueueMessage with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return queueMessageService.getAll({
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
   * POST /queue-message
   * Creates a new QueueMessage.
   */
  .post("/", async ({ body, set }) => {
    const data = await queueMessageService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: QueueMessagePlainInputCreate
  })

  /**
   * GET /queue-message/:id
   * Retrieves a single QueueMessage by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await queueMessageService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "QueueMessage not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /queue-message/:id
   * Updates an existing QueueMessage.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await queueMessageService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "QueueMessage not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: QueueMessagePlainInputUpdate
  })

  /**
   * DELETE /queue-message/:id
   * Deletes a QueueMessage.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await queueMessageService.delete(params.id);
      return { success: true, message: "QueueMessage deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "QueueMessage not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
