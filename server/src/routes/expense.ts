import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { expenseService } from "../services/expense";
import { 
  ExpensePlainInputCreate, 
  ExpensePlainInputUpdate 
} from "../../generated/prismabox/Expense";
import { regionMiddleware } from "../middleware/region";

export const expenseRoutes = new Elysia({ prefix: "/expense" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /expense
   * Retrieves all Expense with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return expenseService.withDB(db as any).getAll({
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
   * POST /expense
   * Creates a new Expense.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await expenseService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExpensePlainInputCreate
  })

  /**
   * GET /expense/:id
   * Retrieves a single Expense by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await expenseService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Expense not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /expense/:id
   * Updates an existing Expense.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await expenseService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Expense not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ExpensePlainInputUpdate
  })

  /**
   * DELETE /expense/:id
   * Deletes a Expense.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await expenseService.withDB(db as any).delete(params.id);
      return { success: true, message: "Expense deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Expense not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
