import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { planService } from "../services/plan";
import { 
  PlanPlainInputCreate, 
  PlanPlainInputUpdate 
} from "../../generated/prismabox/Plan";

export const planRoutes = new Elysia({ prefix: "/plans" })
  .use(authMiddleware)

  /**
   * GET /plan
   * Retrieves all Plan with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return planService.getAll({
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
   * POST /plan
   * Creates a new Plan.
   */
  .post("/", async ({ body, set }) => {
    const data = await planService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PlanPlainInputCreate
  })

  /**
   * GET /plan/:id
   * Retrieves a single Plan by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await planService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Plan not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /plan/:id
   * Updates an existing Plan.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await planService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Plan not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PlanPlainInputUpdate
  })

  /**
   * DELETE /plan/:id
   * Deletes a Plan.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await planService.delete(params.id);
      return { success: true, message: "Plan deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Plan not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
