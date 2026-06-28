import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { automationTaskService } from "../services/automationtask";
import { 
  AutomationTaskPlainInputCreate, 
  AutomationTaskPlainInputUpdate 
} from "prismabox/AutomationTask";

export const automationTaskRoutes = new Elysia({ prefix: "/system/automation-tasks" })
  .use(authMiddleware)

  /**
   * GET /automation-task
   * Retrieves all AutomationTask with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return automationTaskService.getAll({
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
   * POST /automation-task
   * Creates a new AutomationTask.
   */
  .post("/", async ({ body, set }) => {
    const data = await automationTaskService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AutomationTaskPlainInputCreate
  })

  /**
   * GET /automation-task/:id
   * Retrieves a single AutomationTask by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await automationTaskService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AutomationTask not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /automation-task/:id
   * Updates an existing AutomationTask.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await automationTaskService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationTask not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AutomationTaskPlainInputUpdate
  })

  /**
   * DELETE /automation-task/:id
   * Deletes a AutomationTask.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await automationTaskService.delete(params.id);
      return { success: true, message: "AutomationTask deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationTask not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
