/**
 * Exchange Rate Routes
 *
 * Real exchange rate API endpoints with Frankfurter/ECB data.
 * Supports conversion between 25+ currencies.
 * Special TRY↔USD handling for Turkish real estate compliance.
 */
import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import {
  convert,
  getRate,
  getAllRates,
  getCurrencyInfo,
  refreshRates,
  getMultiCurrencyPrice,
  getTRYPrice,
  formatCurrency,
  SUPPORTED_CURRENCIES,
  COUNTRY_CURRENCY,
} from "../services/currency-converter";

export const exchangeRateRoutes = new Elysia({ prefix: "/exchange-rates" })
  .use(authMiddleware)

  /**
   * GET /exchange-rates/latest
   * Get latest rates for a base currency
   */
  .get("/latest", async ({ query }) => {
    const { base = "USD", target } = query as any;

    if (target) {
      const rate = await getRate(base, target);
      return {
        success: true,
        data: {
          base: base.toUpperCase(),
          target: target.toUpperCase(),
          rate: Math.round(rate * 1000000) / 1000000,
          timestamp: new Date().toISOString(),
        },
      };
    }

    const rates = await getAllRates(base);
    return {
      success: true,
      data: {
        base: base.toUpperCase(),
        rates: Object.fromEntries(rates.map(r => [r.code, r.rate])),
        timestamp: new Date().toISOString(),
      },
    };
  }, {
    query: t.Object({
      base: t.Optional(t.String()),
      target: t.Optional(t.String()),
    }),
  })

  /**
   * GET /exchange-rates/convert
   * Convert amount between currencies
   */
  .get("/convert", async ({ query }) => {
    const { from, to, amount } = query as any;

    if (!from || !to || !amount) {
      return { success: false, msg: 'from, to, and amount are required' };
    }

    const result = await convert(parseFloat(amount), from, to);

    return {
      success: true,
      data: result,
    };
  }, {
    query: t.Object({
      from: t.String(),
      to: t.String(),
      amount: t.String(),
    }),
  })

  /**
   * GET /exchange-rates/try-price
   * Special endpoint for Turkish listings: auto-convert USD to TRY
   * Turkish law prohibits publishing property prices in USD
   */
  .get("/try-price", async ({ query }) => {
    const { usdAmount } = query as any;

    if (!usdAmount) {
      return { success: false, msg: 'usdAmount is required' };
    }

    const result = await getTRYPrice(parseFloat(usdAmount));

    return {
      success: true,
      data: {
        ...result,
        legalNote: 'Türkiye\'de gayrimenkul fiyatlarının TL olarak yayınlanması zorunludur.',
      },
    };
  }, {
    query: t.Object({
      usdAmount: t.String(),
    }),
  })

  /**
   * GET /exchange-rates/multi
   * Get price in all currencies
   */
  .get("/multi", async ({ query }) => {
    const { amount, currency } = query as any;

    if (!amount || !currency) {
      return { success: false, msg: 'amount and currency are required' };
    }

    const result = await getMultiCurrencyPrice(parseFloat(amount), currency);

    return {
      success: true,
      data: result,
    };
  }, {
    query: t.Object({
      amount: t.String(),
      currency: t.String(),
    }),
  })

  /**
   * GET /exchange-rates/supported
   * List all supported currencies
   */
  .get("/supported", async () => {
    return {
      success: true,
      data: {
        currencies: Object.entries(SUPPORTED_CURRENCIES).map(([code, info]) => ({
          code,
          name: info.name,
          symbol: info.symbol,
          country: info.country,
        })),
        countryMap: COUNTRY_CURRENCY,
      },
    };
  })

  /**
   * GET /exchange-rates/:code
   * Get info for a specific currency
   */
  .get("/:code", async ({ params }) => {
    const info = await getCurrencyInfo(params.code);
    if (!info) {
      return { success: false, msg: `Currency ${params.code} not found` };
    }
    return { success: true, data: info };
  }, {
    params: t.Object({ code: t.String() }),
  })

  /**
   * POST /exchange-rates/refresh
   * Force refresh rates from API
   */
  .post("/refresh", async () => {
    const result = await refreshRates();
    return {
      success: true,
      data: result,
    };
  })

  /**
   * GET /exchange-rates
   * Get all rates (paginated for compatibility)
   */
  .get("/", async ({ query }) => {
    const { base = "USD" } = query as any;
    const rates = await getAllRates(base);
    return {
      success: true,
      data: {
        base: base.toUpperCase(),
        rates,
        total: rates.length,
        timestamp: new Date().toISOString(),
      },
    };
  }, {
    query: t.Object({
      base: t.Optional(t.String()),
    }),
  });
