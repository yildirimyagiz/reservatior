import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { maintenanceWorkOrderService } from "../services/maintenanceworkorder";
import { 
  MaintenanceWorkOrderPlainInputCreate, 
  MaintenanceWorkOrderPlainInputUpdate 
} from "../../generated/prismabox/MaintenanceWorkOrder";
import { regionMiddleware } from "../middleware/region";

export const maintenanceWorkOrderRoutes = new Elysia({ prefix: "/maintenance-work-orders" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /maintenance-work-order
   * Retrieves all MaintenanceWorkOrder with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return maintenanceWorkOrderService.withDB(db as any).getAll({
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
   * POST /maintenance-work-order
   * Creates a new MaintenanceWorkOrder.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await maintenanceWorkOrderService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MaintenanceWorkOrderPlainInputCreate
  })

  /**
   * GET /maintenance-work-order/:id
   * Retrieves a single MaintenanceWorkOrder by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await maintenanceWorkOrderService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MaintenanceWorkOrder not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /maintenance-work-order/:id
   * Updates an existing MaintenanceWorkOrder.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await maintenanceWorkOrderService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MaintenanceWorkOrder not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MaintenanceWorkOrderPlainInputUpdate
  })

  /**
   * DELETE /maintenance-work-order/:id
   * Deletes a MaintenanceWorkOrder.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await maintenanceWorkOrderService.withDB(db as any).delete(params.id);
      return { success: true, message: "MaintenanceWorkOrder deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MaintenanceWorkOrder not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
