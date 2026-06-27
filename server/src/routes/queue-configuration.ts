import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { queueConfigurationService } from "../services/queueconfiguration";
import { 
  QueueConfigurationPlainInputCreate, 
  QueueConfigurationPlainInputUpdate 
} from "../../generated/prismabox/QueueConfiguration";

export const queueConfigurationRoutes = new Elysia({ prefix: "/queue-configurations" })
  .use(authMiddleware)

  /**
   * GET /queue-configuration
   * Retrieves all QueueConfiguration with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return queueConfigurationService.getAll({
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
   * POST /queue-configuration
   * Creates a new QueueConfiguration.
   */
  .post("/", async ({ body, set }) => {
    const data = await queueConfigurationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: QueueConfigurationPlainInputCreate
  })

  /**
   * GET /queue-configuration/:id
   * Retrieves a single QueueConfiguration by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await queueConfigurationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "QueueConfiguration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /queue-configuration/:id
   * Updates an existing QueueConfiguration.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await queueConfigurationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "QueueConfiguration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: QueueConfigurationPlainInputUpdate
  })

  /**
   * DELETE /queue-configuration/:id
   * Deletes a QueueConfiguration.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await queueConfigurationService.delete(params.id);
      return { success: true, message: "QueueConfiguration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "QueueConfiguration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
