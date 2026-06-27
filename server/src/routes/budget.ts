import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { budgetService } from "../services/budget";
import { 
  BudgetPlainInputCreate, 
  BudgetPlainInputUpdate 
} from "../../generated/prismabox/Budget";
import { regionMiddleware } from "../middleware/region";

export const budgetRoutes = new Elysia({ prefix: "/budget" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /budget
   * Retrieves all Budget with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return budgetService.withDB(db as any).getAll({
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
   * POST /budget
   * Creates a new Budget.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await budgetService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: BudgetPlainInputCreate
  })

  /**
   * GET /budget/:id
   * Retrieves a single Budget by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await budgetService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Budget not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /budget/:id
   * Updates an existing Budget.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await budgetService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Budget not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: BudgetPlainInputUpdate
  })

  /**
   * DELETE /budget/:id
   * Deletes a Budget.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await budgetService.withDB(db as any).delete(params.id);
      return { success: true, message: "Budget deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Budget not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
