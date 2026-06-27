import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentTeamMemberService } from "../services/agentteammember";
import { 
  AgentTeamMemberPlainInputCreate, 
  AgentTeamMemberPlainInputUpdate 
} from "../../generated/prismabox/AgentTeamMember";
import { regionMiddleware } from "../middleware/region";

export const agentTeamMemberRoutes = new Elysia({ prefix: "/agent-team-members" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /agent-team-member
   * Retrieves all AgentTeamMember with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return agentTeamMemberService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await agentTeamMemberService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentTeamMemberPlainInputCreate
  })

  /**
   * GET /agent-team-member/:id
   * Retrieves a single AgentTeamMember by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await agentTeamMemberService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await agentTeamMemberService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await agentTeamMemberService.withDB(db as any).delete(params.id);
      return { success: true, message: "AgentTeamMember deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentTeamMember not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
