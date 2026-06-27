import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { accountService } from "../services/account";
import { 
  AccountPlainInputCreate, 
  AccountPlainInputUpdate 
} from "../../generated/prismabox/Account";
import { regionMiddleware } from "../middleware/region";

export const accountRoutes = new Elysia({ prefix: "/accounts" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /account
   * Retrieves all Account with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return accountService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await accountService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AccountPlainInputCreate
  })

  /**
   * GET /account/:id
   * Retrieves a single Account by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await accountService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await accountService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await accountService.withDB(db as any).delete(params.id);
      return { success: true, message: "Account deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Account not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
