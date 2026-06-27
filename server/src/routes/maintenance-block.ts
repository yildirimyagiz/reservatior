import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { maintenanceBlockService } from "../services/maintenanceblock";
import { 
  MaintenanceBlockPlainInputCreate, 
  MaintenanceBlockPlainInputUpdate 
} from "../../generated/prismabox/MaintenanceBlock";

export const maintenanceBlockRoutes = new Elysia({ prefix: "/maintenance-blocks" })
  .use(authMiddleware)

  /**
   * GET /maintenance-block
   * Retrieves all MaintenanceBlock with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return maintenanceBlockService.getAll({
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
   * POST /maintenance-block
   * Creates a new MaintenanceBlock.
   */
  .post("/", async ({ body, set }) => {
    const data = await maintenanceBlockService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MaintenanceBlockPlainInputCreate
  })

  /**
   * GET /maintenance-block/:id
   * Retrieves a single MaintenanceBlock by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await maintenanceBlockService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MaintenanceBlock not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /maintenance-block/:id
   * Updates an existing MaintenanceBlock.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await maintenanceBlockService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MaintenanceBlock not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MaintenanceBlockPlainInputUpdate
  })

  /**
   * DELETE /maintenance-block/:id
   * Deletes a MaintenanceBlock.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await maintenanceBlockService.delete(params.id);
      return { success: true, message: "MaintenanceBlock deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MaintenanceBlock not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
