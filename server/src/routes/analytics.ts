import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { analyticsService } from "../services/analytics";
import { 
  AnalyticsPlainInputCreate, 
  AnalyticsPlainInputUpdate 
} from "../../generated/prismabox/Analytics";
import { regionMiddleware } from "../middleware/region";

export const analyticsRoutes = new Elysia({ prefix: "/analytics" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /analytics
   * Retrieves all Analytics with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return analyticsService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { timestamp: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /analytics
   * Creates a new Analytics.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await analyticsService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AnalyticsPlainInputCreate
  })

  /**
   * GET /analytics/:id
   * Retrieves a single Analytics by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await analyticsService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Analytics not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /analytics/:id
   * Updates an existing Analytics.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await analyticsService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Analytics not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AnalyticsPlainInputUpdate
  })

  /**
   * DELETE /analytics/:id
   * Deletes a Analytics.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await analyticsService.withDB(db as any).delete(params.id);
      return { success: true, message: "Analytics deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Analytics not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
