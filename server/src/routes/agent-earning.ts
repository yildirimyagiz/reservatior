import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentEarningService } from "../services/agentearning";
import { 
  AgentEarningPlainInputCreate, 
  AgentEarningPlainInputUpdate 
} from "../../generated/prismabox/AgentEarning";
import { regionMiddleware } from "../middleware/region";

export const agentEarningRoutes = new Elysia({ prefix: "/agent-earning" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /agent-earning
   * Retrieves all AgentEarning with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return agentEarningService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await agentEarningService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentEarningPlainInputCreate
  })

  /**
   * GET /agent-earning/:id
   * Retrieves a single AgentEarning by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await agentEarningService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await agentEarningService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await agentEarningService.withDB(db as any).delete(params.id);
      return { success: true, message: "AgentEarning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentEarning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
