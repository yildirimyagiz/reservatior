import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { performanceAlertService } from "../services/performancealert";
import { 
  PerformanceAlertPlainInputCreate, 
  PerformanceAlertPlainInputUpdate 
} from "../../generated/prismabox/PerformanceAlert";

export const performanceAlertRoutes = new Elysia({ prefix: "/performance-alerts" })
  .use(authMiddleware)

  /**
   * GET /performance-alert
   * Retrieves all PerformanceAlert with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return performanceAlertService.getAll({
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
   * POST /performance-alert
   * Creates a new PerformanceAlert.
   */
  .post("/", async ({ body, set }) => {
    const data = await performanceAlertService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PerformanceAlertPlainInputCreate
  })

  /**
   * GET /performance-alert/:id
   * Retrieves a single PerformanceAlert by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await performanceAlertService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PerformanceAlert not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /performance-alert/:id
   * Updates an existing PerformanceAlert.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await performanceAlertService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PerformanceAlert not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PerformanceAlertPlainInputUpdate
  })

  /**
   * DELETE /performance-alert/:id
   * Deletes a PerformanceAlert.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await performanceAlertService.delete(params.id);
      return { success: true, message: "PerformanceAlert deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PerformanceAlert not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
