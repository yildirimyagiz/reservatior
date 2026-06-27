import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentTeamMemberService } from "../services/agentteammember";
import { 
  AgentTeamMemberPlainInputCreate, 
  AgentTeamMemberPlainInputUpdate 
} from "../../generated/prismabox/AgentTeamMember";

export const agentTeamMemberRoutes = new Elysia({ prefix: "/agent-team-members" })
  .use(authMiddleware)

  /**
   * GET /agent-team-member
   * Retrieves all AgentTeamMember with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentTeamMemberService.getAll({
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
   * POST /agent-team-member
   * Creates a new AgentTeamMember.
   */
  .post("/", async ({ body, set }) => {
    const data = await agentTeamMemberService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentTeamMemberPlainInputCreate
  })

  /**
   * GET /agent-team-member/:id
   * Retrieves a single AgentTeamMember by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentTeamMemberService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AgentTeamMember not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent-team-member/:id
   * Updates an existing AgentTeamMember.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentTeamMemberService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AgentTeamMember not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentTeamMemberPlainInputUpdate
  })

  /**
   * DELETE /agent-team-member/:id
   * Deletes a AgentTeamMember.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentTeamMemberService.delete(params.id);
      return { success: true, message: "AgentTeamMember deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentTeamMember not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
