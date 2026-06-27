import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { automationExecutionService } from "../services/automationexecution";
import { 
  AutomationExecutionPlainInputCreate, 
  AutomationExecutionPlainInputUpdate 
} from "../../generated/prismabox/AutomationExecution";

export const automationExecutionRoutes = new Elysia({ prefix: "/system/automation-executions" })
  .use(authMiddleware)

  /**
   * GET /automation-execution
   * Retrieves all AutomationExecution with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return automationExecutionService.getAll({
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
   * POST /automation-execution
   * Creates a new AutomationExecution.
   */
  .post("/", async ({ body, set }) => {
    const data = await automationExecutionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AutomationExecutionPlainInputCreate
  })

  /**
   * GET /automation-execution/:id
   * Retrieves a single AutomationExecution by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await automationExecutionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AutomationExecution not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /automation-execution/:id
   * Updates an existing AutomationExecution.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await automationExecutionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationExecution not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AutomationExecutionPlainInputUpdate
  })

  /**
   * DELETE /automation-execution/:id
   * Deletes a AutomationExecution.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await automationExecutionService.delete(params.id);
      return { success: true, message: "AutomationExecution deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationExecution not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
