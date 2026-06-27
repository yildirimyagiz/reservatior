import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { taskService } from "../services/task";
import { 
  TaskPlainInputCreate, 
  TaskPlainInputUpdate 
} from "../../generated/prismabox/Task";
import { regionMiddleware } from "../middleware/region";

export const taskRoutes = new Elysia({ prefix: "/task" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /task
   * Retrieves all Task with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return taskService.withDB(db as any).getAll({
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
   * POST /task
   * Creates a new Task.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await taskService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: TaskPlainInputCreate
  })

  /**
   * GET /task/:id
   * Retrieves a single Task by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await taskService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Task not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /task/:id
   * Updates an existing Task.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await taskService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Task not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TaskPlainInputUpdate
  })

  /**
   * DELETE /task/:id
   * Deletes a Task.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await taskService.withDB(db as any).delete(params.id);
      return { success: true, message: "Task deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Task not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
