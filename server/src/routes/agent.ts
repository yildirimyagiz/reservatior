import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentService } from "../services/agent";
import { 
  AgentPlainInputCreate, 
  AgentPlainInputUpdate 
} from "../../generated/prismabox/Agent";

export const agentRoutes = new Elysia({ prefix: "/agent" })
  .use(authMiddleware)

  /**
   * GET /agent
   * Retrieves all Agent with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentService.getAll({
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
   * POST /agent
   * Creates a new Agent.
   */
  .post("/", async ({ body, set }) => {
    const data = await agentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentPlainInputCreate
  })

  /**
   * GET /agent/:id
   * Retrieves a single Agent by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Agent not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent/:id
   * Updates an existing Agent.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Agent not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentPlainInputUpdate
  })

  /**
   * DELETE /agent/:id
   * Deletes a Agent.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentService.delete(params.id);
      return { success: true, message: "Agent deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Agent not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
