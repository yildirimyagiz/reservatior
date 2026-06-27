import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { queueConfigurationService } from "../services/queueconfiguration";
import { 
  QueueConfigurationPlainInputCreate, 
  QueueConfigurationPlainInputUpdate 
} from "../../generated/prismabox/QueueConfiguration";
import { regionMiddleware } from "../middleware/region";

export const queueConfigurationRoutes = new Elysia({ prefix: "/queue-configurations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /queue-configuration
   * Retrieves all QueueConfiguration with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return queueConfigurationService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await queueConfigurationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: QueueConfigurationPlainInputCreate
  })

  /**
   * GET /queue-configuration/:id
   * Retrieves a single QueueConfiguration by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await queueConfigurationService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await queueConfigurationService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await queueConfigurationService.withDB(db as any).delete(params.id);
      return { success: true, message: "QueueConfiguration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "QueueConfiguration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
