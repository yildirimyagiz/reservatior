import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { automationTaskService } from "../services/automationtask";
import { 
  AutomationTaskPlainInputCreate, 
  AutomationTaskPlainInputUpdate 
} from "../../generated/prismabox/AutomationTask";
import { regionMiddleware } from "../middleware/region";

export const automationTaskRoutes = new Elysia({ prefix: "/system/automation-tasks" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /automation-task
   * Retrieves all AutomationTask with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return automationTaskService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await automationTaskService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AutomationTaskPlainInputCreate
  })

  /**
   * GET /automation-task/:id
   * Retrieves a single AutomationTask by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await automationTaskService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await automationTaskService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await automationTaskService.withDB(db as any).delete(params.id);
      return { success: true, message: "AutomationTask deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationTask not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
