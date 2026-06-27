import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIChatbotSessionService } from "../services/aichatbotsession";
import { 
  AIChatbotSessionPlainInputCreate, 
  AIChatbotSessionPlainInputUpdate 
} from "../../generated/prismabox/AIChatbotSession";
import { regionMiddleware } from "../middleware/region";

export const aichatbotSessionRoutes = new Elysia({ prefix: "/ai-chatbot-sessions" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aichatbot-session
   * Retrieves all AIChatbotSession with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIChatbotSessionService.withDB(db as any).getAll({
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
   * POST /aichatbot-session
   * Creates a new AIChatbotSession.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIChatbotSessionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIChatbotSessionPlainInputCreate
  })

  /**
   * GET /aichatbot-session/:id
   * Retrieves a single AIChatbotSession by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIChatbotSessionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIChatbotSession not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aichatbot-session/:id
   * Updates an existing AIChatbotSession.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIChatbotSessionService.withDB(db as any).update(params.id, body);
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
   * DELETE /aichatbot-session/:id
   * Deletes a AIChatbotSession.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIChatbotSessionService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIChatbotSession deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatbotSession not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
