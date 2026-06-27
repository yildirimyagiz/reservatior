import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIPredictiveMaintenanceService } from "../services/aipredictivemaintenance";
import { 
  AIPredictiveMaintenancePlainInputCreate, 
  AIPredictiveMaintenancePlainInputUpdate 
} from "../../generated/prismabox/AIPredictiveMaintenance";

export const aipredictiveMaintenanceRoutes = new Elysia({ prefix: "/ai-predictive-maintenances" })
  .use(authMiddleware)

  /**
   * GET /aipredictive-maintenance
   * Retrieves all AIPredictiveMaintenance with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIPredictiveMaintenanceService.getAll({
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
   * POST /aipredictive-maintenance
   * Creates a new AIPredictiveMaintenance.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIPredictiveMaintenanceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIPredictiveMaintenancePlainInputCreate
  })

  /**
   * GET /aipredictive-maintenance/:id
   * Retrieves a single AIPredictiveMaintenance by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIPredictiveMaintenanceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIPredictiveMaintenance not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aipredictive-maintenance/:id
   * Updates an existing AIPredictiveMaintenance.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIPredictiveMaintenanceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIPredictiveMaintenance not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIPredictiveMaintenancePlainInputUpdate
  })

  /**
   * DELETE /aipredictive-maintenance/:id
   * Deletes a AIPredictiveMaintenance.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIPredictiveMaintenanceService.delete(params.id);
      return { success: true, message: "AIPredictiveMaintenance deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIPredictiveMaintenance not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
