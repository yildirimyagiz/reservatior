import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { floorPlanService } from "../services/floorplan";
import { 
  FloorPlanPlainInputCreate, 
  FloorPlanPlainInputUpdate 
} from "../../generated/prismabox/FloorPlan";
import { regionMiddleware } from "../middleware/region";

export const floorPlanRoutes = new Elysia({ prefix: "/floor-plan" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /floor-plan
   * Retrieves all FloorPlan with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return floorPlanService.withDB(db as any).getAll({
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
   * POST /floor-plan
   * Creates a new FloorPlan.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await floorPlanService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: FloorPlanPlainInputCreate
  })

  /**
   * GET /floor-plan/:id
   * Retrieves a single FloorPlan by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await floorPlanService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "FloorPlan not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /floor-plan/:id
   * Updates an existing FloorPlan.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await floorPlanService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "FloorPlan not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: FloorPlanPlainInputUpdate
  })

  /**
   * DELETE /floor-plan/:id
   * Deletes a FloorPlan.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await floorPlanService.withDB(db as any).delete(params.id);
      return { success: true, message: "FloorPlan deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "FloorPlan not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
