import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { accountService } from "../services/account";
import { 
  AccountPlainInputCreate, 
  AccountPlainInputUpdate 
} from "../../generated/prismabox/Account";

export const accountRoutes = new Elysia({ prefix: "/accounts" })
  .use(authMiddleware)

  /**
   * GET /account
   * Retrieves all Account with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return accountService.getAll({
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
   * POST /account
   * Creates a new Account.
   */
  .post("/", async ({ body, set }) => {
    const data = await accountService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AccountPlainInputCreate
  })

  /**
   * GET /account/:id
   * Retrieves a single Account by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await accountService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Account not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /account/:id
   * Updates an existing Account.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await accountService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Account not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AccountPlainInputUpdate
  })

  /**
   * DELETE /account/:id
   * Deletes a Account.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await accountService.delete(params.id);
      return { success: true, message: "Account deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Account not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
