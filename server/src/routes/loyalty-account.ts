import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { loyaltyAccountService } from "../services/loyaltyaccount";
import { 
  LoyaltyAccountPlainInputCreate, 
  LoyaltyAccountPlainInputUpdate 
} from "../../generated/prismabox/LoyaltyAccount";

export const loyaltyAccountRoutes = new Elysia({ prefix: "/loyalty-accounts" })
  .use(authMiddleware)

  /**
   * GET /loyalty-account
   * Retrieves all LoyaltyAccount with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return loyaltyAccountService.getAll({
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
   * POST /loyalty-account
   * Creates a new LoyaltyAccount.
   */
  .post("/", async ({ body, set }) => {
    const data = await loyaltyAccountService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LoyaltyAccountPlainInputCreate
  })

  /**
   * GET /loyalty-account/:id
   * Retrieves a single LoyaltyAccount by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await loyaltyAccountService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LoyaltyAccount not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /loyalty-account/:id
   * Updates an existing LoyaltyAccount.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await loyaltyAccountService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LoyaltyAccount not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LoyaltyAccountPlainInputUpdate
  })

  /**
   * DELETE /loyalty-account/:id
   * Deletes a LoyaltyAccount.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await loyaltyAccountService.delete(params.id);
      return { success: true, message: "LoyaltyAccount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LoyaltyAccount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
