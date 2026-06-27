import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIChatHandoffService } from "../services/aichathandoff";
import { 
  AIChatHandoffPlainInputCreate, 
  AIChatHandoffPlainInputUpdate 
} from "../../generated/prismabox/AIChatHandoff";
import { regionMiddleware } from "../middleware/region";

export const aichatHandoffRoutes = new Elysia({ prefix: "/aichat-handoff" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aichat-handoff
   * Retrieves all AIChatHandoff with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIChatHandoffService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /aichat-handoff
   * Creates a new AIChatHandoff.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIChatHandoffService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIChatHandoffPlainInputCreate
  })

  /**
   * GET /aichat-handoff/:id
   * Retrieves a single AIChatHandoff by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIChatHandoffService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIChatHandoff not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aichat-handoff/:id
   * Updates an existing AIChatHandoff.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIChatHandoffService.withDB(db as any).update(params.id, body);
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
   * DELETE /aichat-handoff/:id
   * Deletes a AIChatHandoff.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIChatHandoffService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIChatHandoff deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIChatHandoff not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
