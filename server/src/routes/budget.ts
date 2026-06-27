import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { budgetService } from "../services/budget";
import { 
  BudgetPlainInputCreate, 
  BudgetPlainInputUpdate 
} from "../../generated/prismabox/Budget";

export const budgetRoutes = new Elysia({ prefix: "/budget" })
  .use(authMiddleware)

  /**
   * GET /budget
   * Retrieves all Budget with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return budgetService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await budgetService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: BudgetPlainInputCreate
  })

  /**
   * GET /budget/:id
   * Retrieves a single Budget by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await budgetService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await budgetService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await budgetService.delete(params.id);
      return { success: true, message: "Budget deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Budget not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
