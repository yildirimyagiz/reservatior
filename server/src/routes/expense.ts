import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { expenseService } from "../services/expense";
import { 
  ExpensePlainInputCreate, 
  ExpensePlainInputUpdate 
} from "../../generated/prismabox/Expense";

export const expenseRoutes = new Elysia({ prefix: "/expense" })
  .use(authMiddleware)

  /**
   * GET /expense
   * Retrieves all Expense with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return expenseService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await expenseService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExpensePlainInputCreate
  })

  /**
   * GET /expense/:id
   * Retrieves a single Expense by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await expenseService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await expenseService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await expenseService.delete(params.id);
      return { success: true, message: "Expense deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Expense not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
