import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIChatHandoffService } from "../services/aichathandoff";
import { 
  AIChatHandoffPlainInputCreate, 
  AIChatHandoffPlainInputUpdate 
} from "../../generated/prismabox/AIChatHandoff";

export const aiChatHandoffsRoutes = new Elysia({ prefix: "/ai-chat-handoffs" })
  .use(authMiddleware)

  /**
   * GET /ai-chat-handoffs
   * Retrieves all AIChatHandoff with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIChatHandoffService.getAll({
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
   * POST /ai-chat-handoffs
   * Creates a new AIChatHandoff.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIChatHandoffService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIChatHandoffPlainInputCreate
  })

  /**
   * GET /ai-chat-handoffs/:id
   * Retrieves a single AIChatHandoff by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIChatHandoffService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIChatHandoff not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-chat-handoffs/:id
   * Updates an existing AIChatHandoff.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIChatHandoffService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatHandoff not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIChatHandoffPlainInputUpdate
  })

  /**
   * DELETE /ai-chat-handoffs/:id
   * Deletes a AIChatHandoff.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIChatHandoffService.delete(params.id);
      return { success: true, message: "AIChatHandoff deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatHandoff not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
