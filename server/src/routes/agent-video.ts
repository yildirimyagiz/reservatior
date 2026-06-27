import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentVideoService } from "../services/agentvideo";
import { 
  AgentVideoPlainInputCreate, 
  AgentVideoPlainInputUpdate 
} from "../../generated/prismabox/AgentVideo";
import { regionMiddleware } from "../middleware/region";

export const agentVideoRoutes = new Elysia({ prefix: "/agent-video" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /agent-video
   * Retrieves all AgentVideo with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return agentVideoService.withDB(db as any).getAll({
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
   * POST /agent-video
   * Creates a new AgentVideo.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await agentVideoService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentVideoPlainInputCreate
  })

  /**
   * GET /agent-video/:id
   * Retrieves a single AgentVideo by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await agentVideoService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AgentVideo not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent-video/:id
   * Updates an existing AgentVideo.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await agentVideoService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AgentVideo not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentVideoPlainInputUpdate
  })

  /**
   * DELETE /agent-video/:id
   * Deletes a AgentVideo.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await agentVideoService.withDB(db as any).delete(params.id);
      return { success: true, message: "AgentVideo deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentVideo not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
