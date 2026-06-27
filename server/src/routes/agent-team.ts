import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentTeamService } from "../services/agentteam";
import { 
  AgentTeamPlainInputCreate, 
  AgentTeamPlainInputUpdate 
} from "../../generated/prismabox/AgentTeam";

export const agentTeamRoutes = new Elysia({ prefix: "/agent-teams" })
  .use(authMiddleware)

  /**
   * GET /agent-team
   * Retrieves all AgentTeam with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentTeamService.getAll({
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
   * POST /agent-team
   * Creates a new AgentTeam.
   */
  .post("/", async ({ body, set }) => {
    const data = await agentTeamService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentTeamPlainInputCreate
  })

  /**
   * GET /agent-team/:id
   * Retrieves a single AgentTeam by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentTeamService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AgentTeam not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent-team/:id
   * Updates an existing AgentTeam.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentTeamService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AgentTeam not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentTeamPlainInputUpdate
  })

  /**
   * DELETE /agent-team/:id
   * Deletes a AgentTeam.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentTeamService.delete(params.id);
      return { success: true, message: "AgentTeam deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentTeam not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
