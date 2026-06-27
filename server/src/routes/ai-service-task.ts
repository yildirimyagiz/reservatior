import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aiServiceTaskService } from "../services/aiservicetask";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";
import { 
  AiServiceTaskPlainInputCreate, 
  AiServiceTaskPlainInputUpdate 
} from "../../generated/prismabox/AiServiceTask";

export const aiServiceTaskRoutes = new Elysia({ prefix: "/ai-service-task" })
  /**
   * POST /ai-service-task/webhook
   * Callback webhook for Python workers / Skipper API.
   */
  .post("/webhook", async ({ body, set }) => {
    const { taskId, status, result, error } = body as any;
    try {
      const data = await MLBridgeService.onTaskUpdate(taskId, status, result, error);
      return { success: true, data };
    } catch (e: any) {
      set.status = 400;
      return { error: `Webhook handling failed: ${e.message}` };
    }
  }, {
    body: t.Object({
      taskId: t.String(),
      status: t.String(),
      progress: t.Number(),
      result: t.Optional(t.Any()),
      error: t.Optional(t.String())
    })
  })

  .use(authMiddleware)

  /**
   * GET /ai-service-task
   * Retrieves all AiServiceTask with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aiServiceTaskService.getAll({
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
   * POST /ai-service-task
   * Creates a new AiServiceTask and dispatches to MLBridgeService.
   */
  .post("/", async ({ body, set }) => {
    const data = await aiServiceTaskService.create(body);
    
    // Asynchronously dispatch the background task execution
    MLBridgeService.triggerTask(data).catch(err => {
      console.error(`[aiServiceTaskRoutes] Failed to trigger task ${data.id}:`, err);
    });

    set.status = 201;
    return { data };
  }, {
    body: AiServiceTaskPlainInputCreate
  })

  /**
   * GET /ai-service-task/:id
   * Retrieves a single AiServiceTask by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aiServiceTaskService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AiServiceTask not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-service-task/:id
   * Updates an existing AiServiceTask.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aiServiceTaskService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AiServiceTask not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AiServiceTaskPlainInputUpdate
  })

  /**
   * DELETE /ai-service-task/:id
   * Deletes a AiServiceTask.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aiServiceTaskService.delete(params.id);
      return { success: true, message: "AiServiceTask deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AiServiceTask not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
