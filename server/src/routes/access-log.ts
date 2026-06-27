import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { accessLogService } from "../services/accesslog";
import { 
  AccessLogPlainInputCreate, 
  AccessLogPlainInputUpdate 
} from "../../generated/prismabox/AccessLog";
import { regionMiddleware } from "../middleware/region";

export const accessLogRoutes = new Elysia({ prefix: "/access-log" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /access-log
   * Retrieves all AccessLog with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return accessLogService.withDB(db as any).getAll({
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
   * POST /access-log
   * Creates a new AccessLog.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await accessLogService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AccessLogPlainInputCreate
  })

  /**
   * GET /access-log/:id
   * Retrieves a single AccessLog by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await accessLogService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AccessLog not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /access-log/:id
   * Updates an existing AccessLog.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await accessLogService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AccessLog not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AccessLogPlainInputUpdate
  })

  /**
   * DELETE /access-log/:id
   * Deletes a AccessLog.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await accessLogService.withDB(db as any).delete(params.id);
      return { success: true, message: "AccessLog deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AccessLog not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
