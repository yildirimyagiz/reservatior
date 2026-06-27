import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { exchangeRateService } from "../services/exchangerate";
import { 
  ExchangeRatePlainInputCreate, 
  ExchangeRatePlainInputUpdate 
} from "../../generated/prismabox/ExchangeRate";

export const exchangeRateRoutes = new Elysia({ prefix: "/exchange-rates" })
  .use(authMiddleware)

  /**
   * GET /exchange-rates/latest
   * Gets latest exchange rates
   */
  .get("/latest", async ({ query }) => {
    const { base = "USD", target } = query as any;
    // Mock data for now - in real app this would fetch from API
    const mockRates = {
      "USD": { "EUR": 0.92, "GBP": 0.79, "JPY": 149.50 },
      "EUR": { "USD": 1.09, "GBP": 0.86, "JPY": 162.89 },
      "GBP": { "USD": 1.27, "EUR": 1.16, "JPY": 189.73 }
    };
    
    if (target && mockRates[base] && mockRates[base][target]) {
      return { base, target, rate: mockRates[base][target] };
    }
    
    return { base, rates: mockRates[base] || {} };
  }, {
    query: t.Partial(t.Object({
      base: t.Optional(t.String()),
      target: t.Optional(t.String()),
    }))
  })

  /**
   * GET /exchange-rate
   * Retrieves all ExchangeRate with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return exchangeRateService.getAll({
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
   * POST /exchange-rate
   * Creates a new ExchangeRate.
   */
  .post("/", async ({ body, set }) => {
    const data = await exchangeRateService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExchangeRatePlainInputCreate
  })

  /**
   * GET /exchange-rate/:id
   * Retrieves a single ExchangeRate by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await exchangeRateService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ExchangeRate not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /exchange-rate/:id
   * Updates an existing ExchangeRate.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await exchangeRateService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ExchangeRate not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ExchangeRatePlainInputUpdate
  })

  /**
   * DELETE /exchange-rate/:id
   * Deletes a ExchangeRate.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await exchangeRateService.delete(params.id);
      return { success: true, message: "ExchangeRate deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExchangeRate not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
