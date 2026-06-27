import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { webhookDeliveryService } from "../services/webhookdelivery";
import { 
  WebhookDeliveryPlainInputCreate, 
  WebhookDeliveryPlainInputUpdate 
} from "../../generated/prismabox/WebhookDelivery";

export const webhookDeliveryRoutes = new Elysia({ prefix: "/webhook-deliveries" })
  .use(authMiddleware)

  /**
   * GET /webhook-delivery
   * Retrieves all WebhookDelivery with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return webhookDeliveryService.getAll({
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
   * POST /webhook-delivery
   * Creates a new WebhookDelivery.
   */
  .post("/", async ({ body, set }) => {
    const data = await webhookDeliveryService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: WebhookDeliveryPlainInputCreate
  })

  /**
   * GET /webhook-delivery/:id
   * Retrieves a single WebhookDelivery by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await webhookDeliveryService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "WebhookDelivery not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /webhook-delivery/:id
   * Updates an existing WebhookDelivery.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await webhookDeliveryService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "WebhookDelivery not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: WebhookDeliveryPlainInputUpdate
  })

  /**
   * DELETE /webhook-delivery/:id
   * Deletes a WebhookDelivery.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await webhookDeliveryService.delete(params.id);
      return { success: true, message: "WebhookDelivery deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "WebhookDelivery not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
