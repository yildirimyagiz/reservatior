import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { planService } from "../services/plan";
import { 
  PlanPlainInputCreate, 
  PlanPlainInputUpdate 
} from "../../generated/prismabox/Plan";
import { regionMiddleware } from "../middleware/region";

export const planRoutes = new Elysia({ prefix: "/plans" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /plan
   * Retrieves all Plan with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return planService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await planService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PlanPlainInputCreate
  })

  /**
   * GET /plan/:id
   * Retrieves a single Plan by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await planService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await planService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await planService.withDB(db as any).delete(params.id);
      return { success: true, message: "Plan deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Plan not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
