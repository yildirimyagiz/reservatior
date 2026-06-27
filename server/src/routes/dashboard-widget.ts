import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { dashboardWidgetService } from "../services/dashboardwidget";
import { 
  DashboardWidgetPlainInputCreate, 
  DashboardWidgetPlainInputUpdate 
} from "../../generated/prismabox/DashboardWidget";

export const dashboardWidgetRoutes = new Elysia({ prefix: "/dashboard-widgets" })
  .use(authMiddleware)

  /**
   * GET /dashboard-widget
   * Retrieves all DashboardWidget with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return dashboardWidgetService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /dashboard-widget
   * Creates a new DashboardWidget.
   */
  .post("/", async ({ body, set }) => {
    const data = await dashboardWidgetService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: DashboardWidgetPlainInputCreate
  })

  /**
   * GET /dashboard-widget/:id
   * Retrieves a single DashboardWidget by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await dashboardWidgetService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "DashboardWidget not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /dashboard-widget/:id
   * Updates an existing DashboardWidget.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await dashboardWidgetService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "DashboardWidget not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DashboardWidgetPlainInputUpdate
  })

  /**
   * DELETE /dashboard-widget/:id
   * Deletes a DashboardWidget.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await dashboardWidgetService.delete(params.id);
      return { success: true, message: "DashboardWidget deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "DashboardWidget not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
