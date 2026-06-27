import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { currencyService } from "../services/currency";
import { 
  CurrencyPlainInputCreate, 
  CurrencyPlainInputUpdate 
} from "../../generated/prismabox/Currency";
import { regionMiddleware } from "../middleware/region";

export const currencyRoutes = new Elysia({ prefix: "/currencies" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /currency
   * Retrieves all Currency with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return currencyService.withDB(db as any).getAll({
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
   * POST /currency
   * Creates a new Currency.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await currencyService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: CurrencyPlainInputCreate
  })

  /**
   * GET /currency/:id
   * Retrieves a single Currency by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await currencyService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Currency not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /currency/:id
   * Updates an existing Currency.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await currencyService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Currency not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CurrencyPlainInputUpdate
  })

  /**
   * DELETE /currency/:id
   * Deletes a Currency.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await currencyService.withDB(db as any).delete(params.id);
      return { success: true, message: "Currency deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Currency not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
