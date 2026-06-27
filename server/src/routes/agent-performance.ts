import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentPerformanceService } from "../services/agentperformance";
import { 
  AgentPerformancePlainInputCreate, 
  AgentPerformancePlainInputUpdate 
} from "../../generated/prismabox/AgentPerformance";

export const agentPerformanceRoutes = new Elysia({ prefix: "/agent-performance" })
  .use(authMiddleware)

  /**
   * GET /agent-performance
   * Retrieves all AgentPerformance with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentPerformanceService.getAll({
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
   * POST /agent-performance
   * Creates a new AgentPerformance.
   */
  .post("/", async ({ body, set }) => {
    const data = await agentPerformanceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentPerformancePlainInputCreate
  })

  /**
   * GET /agent-performance/:id
   * Retrieves a single AgentPerformance by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentPerformanceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AgentPerformance not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent-performance/:id
   * Updates an existing AgentPerformance.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentPerformanceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AgentPerformance not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentPerformancePlainInputUpdate
  })

  /**
   * DELETE /agent-performance/:id
   * Deletes a AgentPerformance.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentPerformanceService.delete(params.id);
      return { success: true, message: "AgentPerformance deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentPerformance not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
