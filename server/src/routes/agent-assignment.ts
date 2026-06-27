import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { agentAssignmentService } from "../services/agentassignment";
import { 
  AgentAssignmentPlainInputCreate, 
  AgentAssignmentPlainInputUpdate 
} from "../../generated/prismabox/AgentAssignment";

export const agentAssignmentRoutes = new Elysia({ prefix: "/agent-assignments" })
  .use(authMiddleware)

  /**
   * GET /agent-assignment
   * Retrieves all AgentAssignment with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return agentAssignmentService.getAll({
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
   * POST /agent-assignment
   * Creates a new AgentAssignment.
   */
  .post("/", async ({ body, set }) => {
    const data = await agentAssignmentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AgentAssignmentPlainInputCreate
  })

  /**
   * GET /agent-assignment/:id
   * Retrieves a single AgentAssignment by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await agentAssignmentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AgentAssignment not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /agent-assignment/:id
   * Updates an existing AgentAssignment.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await agentAssignmentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AgentAssignment not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AgentAssignmentPlainInputUpdate
  })

  /**
   * DELETE /agent-assignment/:id
   * Deletes a AgentAssignment.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await agentAssignmentService.delete(params.id);
      return { success: true, message: "AgentAssignment deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AgentAssignment not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
