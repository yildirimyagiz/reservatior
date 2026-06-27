import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIChatMessageService } from "../services/aichatmessage";
import { 
  AIChatMessagePlainInputCreate, 
  AIChatMessagePlainInputUpdate 
} from "../../generated/prismabox/AIChatMessage";

export const aiChatMessagesRoutes = new Elysia({ prefix: "/ai-chat-messages" })
  .use(authMiddleware)

  /**
   * GET /ai-chat-messages
   * Retrieves all AIChatMessage with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIChatMessageService.getAll({
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
   * POST /ai-chat-messages
   * Creates a new AIChatMessage.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIChatMessageService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIChatMessagePlainInputCreate
  })

  /**
   * GET /ai-chat-messages/:id
   * Retrieves a single AIChatMessage by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIChatMessageService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIChatMessage not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-chat-messages/:id
   * Updates an existing AIChatMessage.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIChatMessageService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatMessage not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIChatMessagePlainInputUpdate
  })

  /**
   * DELETE /ai-chat-messages/:id
   * Deletes a AIChatMessage.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIChatMessageService.delete(params.id);
      return { success: true, message: "AIChatMessage deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatMessage not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
