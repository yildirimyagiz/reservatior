import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { floorPlanService } from "../services/floorplan";
import { 
  FloorPlanPlainInputCreate, 
  FloorPlanPlainInputUpdate 
} from "../../generated/prismabox/FloorPlan";

export const floorPlanRoutes = new Elysia({ prefix: "/floor-plan" })
  .use(authMiddleware)

  /**
   * GET /floor-plan
   * Retrieves all FloorPlan with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return floorPlanService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await floorPlanService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: FloorPlanPlainInputCreate
  })

  /**
   * GET /floor-plan/:id
   * Retrieves a single FloorPlan by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await floorPlanService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await floorPlanService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await floorPlanService.delete(params.id);
      return { success: true, message: "FloorPlan deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "FloorPlan not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
