import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { dashboardConfigurationService } from "../services/dashboardconfiguration";
import { 
  DashboardConfigurationPlainInputCreate, 
  DashboardConfigurationPlainInputUpdate 
} from "../../generated/prismabox/DashboardConfiguration";
import { regionMiddleware } from "../middleware/region";

export const dashboardConfigurationRoutes = new Elysia({ prefix: "/dashboard-configurations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /dashboard-configuration
   * Retrieves all DashboardConfiguration with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return dashboardConfigurationService.withDB(db as any).getAll({
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
   * POST /dashboard-configuration
   * Creates a new DashboardConfiguration.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await dashboardConfigurationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: DashboardConfigurationPlainInputCreate
  })

  /**
   * GET /dashboard-configuration/:id
   * Retrieves a single DashboardConfiguration by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await dashboardConfigurationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "DashboardConfiguration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /dashboard-configuration/:id
   * Updates an existing DashboardConfiguration.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await dashboardConfigurationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "DashboardConfiguration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DashboardConfigurationPlainInputUpdate
  })

  /**
   * DELETE /dashboard-configuration/:id
   * Deletes a DashboardConfiguration.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await dashboardConfigurationService.withDB(db as any).delete(params.id);
      return { success: true, message: "DashboardConfiguration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "DashboardConfiguration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
