import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { integrationLogService } from "../services/integrationlog";
import { 
  IntegrationLogPlainInputCreate, 
  IntegrationLogPlainInputUpdate 
} from "../../generated/prismabox/IntegrationLog";
import { regionMiddleware } from "../middleware/region";

export const integrationLogRoutes = new Elysia({ prefix: "/integration-logs" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /integration-log
   * Retrieves all IntegrationLog with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return integrationLogService.withDB(db as any).getAll({
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
   * POST /integration-log
   * Creates a new IntegrationLog.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await integrationLogService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: IntegrationLogPlainInputCreate
  })

  /**
   * GET /integration-log/:id
   * Retrieves a single IntegrationLog by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await integrationLogService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "IntegrationLog not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /integration-log/:id
   * Updates an existing IntegrationLog.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await integrationLogService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "IntegrationLog not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: IntegrationLogPlainInputUpdate
  })

  /**
   * DELETE /integration-log/:id
   * Deletes a IntegrationLog.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await integrationLogService.withDB(db as any).delete(params.id);
      return { success: true, message: "IntegrationLog deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "IntegrationLog not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
