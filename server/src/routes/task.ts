import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { taskService } from "../services/task";
import { GeminiOpsNotificationCoordinator } from "../services/ai/gemini-ops-coordinator";
import { 
  TaskPlainInputCreate, 
  TaskPlainInputUpdate 
} from "../../generated/prismabox/Task";

export const taskRoutes = new Elysia({ prefix: "/task" })
  .use(authMiddleware)

  /**
   * GET /task
   * Retrieves all Task with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return taskService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await taskService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TaskPlainInputCreate
  })

  /**
   * GET /task/:id
   * Retrieves a single Task by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await taskService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set, headers }) => {
    try {
      const data = await taskService.update(params.id, body);
      
      // Asynchronously trigger Gemini operations audit if completed/closed
      const region = headers["x-region"] || "US";
      if (body.status === "COMPLETED" || body.status === "CLOSED") {
        GeminiOpsNotificationCoordinator.trackTaskGPS(params.id, region).catch(err => {
          console.error("❌ Failed triggering trackTaskGPS in patch handler:", err);
        });
      }
      
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await taskService.delete(params.id);
      return { success: true, message: "Task deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Task not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
