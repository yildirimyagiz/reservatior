import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentVideoService } from "../services/agentvideo";
import { 
  AgentVideoPlainInputCreate, 
  AgentVideoPlainInputUpdate 
} from "../../generated/prismabox/AgentVideo";

export const agentVideoRoutes = new Elysia({ prefix: "/agent-video" })
  .use(authMiddleware)

  /**
   * GET /agent-video
   * Retrieves all AgentVideo with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentVideoService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await agentVideoService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentVideoPlainInputCreate
  })

  /**
   * GET /agent-video/:id
   * Retrieves a single AgentVideo by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentVideoService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentVideoService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentVideoService.delete(params.id);
      return { success: true, message: "AgentVideo deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentVideo not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
