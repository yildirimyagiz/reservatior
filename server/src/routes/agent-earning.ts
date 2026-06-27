import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentEarningService } from "../services/agentearning";
import { 
  AgentEarningPlainInputCreate, 
  AgentEarningPlainInputUpdate 
} from "../../generated/prismabox/AgentEarning";

export const agentEarningRoutes = new Elysia({ prefix: "/agent-earning" })
  .use(authMiddleware)

  /**
   * GET /agent-earning
   * Retrieves all AgentEarning with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentEarningService.getAll({
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
   * POST /agent-earning
   * Creates a new AgentEarning.
   */
  .post("/", async ({ body, set }) => {
    const data = await agentEarningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentEarningPlainInputCreate
  })

  /**
   * GET /agent-earning/:id
   * Retrieves a single AgentEarning by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentEarningService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AgentEarning not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent-earning/:id
   * Updates an existing AgentEarning.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentEarningService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AgentEarning not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentEarningPlainInputUpdate
  })

  /**
   * DELETE /agent-earning/:id
   * Deletes a AgentEarning.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentEarningService.delete(params.id);
      return { success: true, message: "AgentEarning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentEarning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
