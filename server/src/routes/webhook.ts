import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { webhookService } from "../services/webhook";
import { 
  WebhookPlainInputCreate, 
  WebhookPlainInputUpdate 
} from "../../generated/prismabox/Webhook";
import { regionMiddleware } from "../middleware/region";

export const webhookRoutes = new Elysia({ prefix: "/webhooks" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /webhook
   * Retrieves all Webhook with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return webhookService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await webhookService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: WebhookPlainInputCreate
  })

  /**
   * GET /webhook/:id
   * Retrieves a single Webhook by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await webhookService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await webhookService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await webhookService.withDB(db as any).delete(params.id);
      return { success: true, message: "Webhook deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Webhook not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
