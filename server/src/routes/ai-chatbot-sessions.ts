import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIChatbotSessionService } from "../services/aichatbotsession";
import { 
  AIChatbotSessionPlainInputCreate, 
  AIChatbotSessionPlainInputUpdate 
} from "../../generated/prismabox/AIChatbotSession";

export const aiChatbotSessionsRoutes = new Elysia({ prefix: "/ai-chatbot-sessions" })
  .use(authMiddleware)

  /**
   * GET /ai-chatbot-sessions
   * Retrieves all AIChatbotSession with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIChatbotSessionService.getAll({
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
   * POST /ai-chatbot-sessions
   * Creates a new AIChatbotSession.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIChatbotSessionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIChatbotSessionPlainInputCreate
  })

  /**
   * GET /ai-chatbot-sessions/:id
   * Retrieves a single AIChatbotSession by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIChatbotSessionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIChatbotSession not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-chatbot-sessions/:id
   * Updates an existing AIChatbotSession.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIChatbotSessionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatbotSession not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIChatbotSessionPlainInputUpdate
  })

  /**
   * DELETE /ai-chatbot-sessions/:id
   * Deletes a AIChatbotSession.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIChatbotSessionService.delete(params.id);
      return { success: true, message: "AIChatbotSession deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatbotSession not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
