import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { systemMetricsService } from "../services/systemmetrics";
import { 
  SystemMetricsPlainInputCreate, 
  SystemMetricsPlainInputUpdate 
} from "../../generated/prismabox/SystemMetrics";

export const systemMetricsRoutes = new Elysia({ prefix: "/system-metrics" })
  .use(authMiddleware)

  /**
   * GET /system-metrics
   * Retrieves all SystemMetrics with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return systemMetricsService.getAll({
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
   * POST /system-metrics
   * Creates a new SystemMetrics.
   */
  .post("/", async ({ body, set }) => {
    const data = await systemMetricsService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SystemMetricsPlainInputCreate
  })

  /**
   * GET /system-metrics/:id
   * Retrieves a single SystemMetrics by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await systemMetricsService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SystemMetrics not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /system-metrics/:id
   * Updates an existing SystemMetrics.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await systemMetricsService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SystemMetrics not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SystemMetricsPlainInputUpdate
  })

  /**
   * DELETE /system-metrics/:id
   * Deletes a SystemMetrics.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await systemMetricsService.delete(params.id);
      return { success: true, message: "SystemMetrics deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SystemMetrics not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
