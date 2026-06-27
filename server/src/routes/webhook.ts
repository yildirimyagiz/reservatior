import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { webhookService } from "../services/webhook";
import { 
  WebhookPlainInputCreate, 
  WebhookPlainInputUpdate 
} from "../../generated/prismabox/Webhook";

export const webhookRoutes = new Elysia({ prefix: "/webhooks" })
  .use(authMiddleware)

  /**
   * GET /webhook
   * Retrieves all Webhook with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return webhookService.getAll({
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
   * POST /webhook
   * Creates a new Webhook.
   */
  .post("/", async ({ body, set }) => {
    const data = await webhookService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: WebhookPlainInputCreate
  })

  /**
   * GET /webhook/:id
   * Retrieves a single Webhook by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await webhookService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Webhook not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /webhook/:id
   * Updates an existing Webhook.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await webhookService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Webhook not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: WebhookPlainInputUpdate
  })

  /**
   * DELETE /webhook/:id
   * Deletes a Webhook.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await webhookService.delete(params.id);
      return { success: true, message: "Webhook deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Webhook not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
