import { Elysia, t } from "elysia";
import { localizationEngineService } from "../services/localization-engine-service";

export const localizationOSRoutes = new Elysia({ prefix: "/localization-os" })

  .get("/dashboard", async ({ set }) => {
    try {
      const data = await localizationEngineService.getDashboard();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Localization OS Dashboard", tags: ["Localization OS"] },
  })

  .get("/countries", async ({ set }) => {
    try {
      const data = await localizationEngineService.getCountries();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Countries", tags: ["Localization OS"] },
  })

  .get("/countries/:isoCode", async ({ params, set }) => {
    try {
      const data = await localizationEngineService.getCountryByCode(params.isoCode);
      if (!data) { set.status = 404; return { error: "Country not found" }; }
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ isoCode: t.String() }),
    detail: { summary: "Get Country Config", tags: ["Localization OS"] },
  })

  .get("/countries/:isoCode/states", async ({ params, set }) => {
    try {
      const data = await localizationEngineService.getStateConfigs(params.isoCode);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ isoCode: t.String() }),
    detail: { summary: "Get State Configs", tags: ["Localization OS"] },
  })

  .get("/currencies", async ({ set }) => {
    try {
      const data = await localizationEngineService.getCurrencies();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Currencies", tags: ["Localization OS"] },
  })

  .get("/exchange-rates", async ({ query, set }) => {
    try {
      const { page, limit, baseCurrency } = query;
      const data = await localizationEngineService.getExchangeRates({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        baseCurrency: baseCurrency as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      baseCurrency: t.Optional(t.String()),
    }),
    detail: { summary: "List Exchange Rates", tags: ["Localization OS"] },
  })

  .post("/exchange-rates", async ({ body, set }) => {
    try {
      const data = await localizationEngineService.createExchangeRate(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      baseCurrency: t.String(),
      quoteCurrency: t.String(),
      rate: t.Number(),
      source: t.Optional(t.String()),
    }),
    detail: { summary: "Create Exchange Rate", tags: ["Localization OS"] },
  })

  .get("/languages", async ({ set }) => {
    try {
      const data = await localizationEngineService.getLanguages();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Languages", tags: ["Localization OS"] },
  })

  .get("/compliance", async ({ query, set }) => {
    try {
      const { page, limit, region } = query;
      const data = await localizationEngineService.getLegalCompliance({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        region: region as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      region: t.Optional(t.String()),
    }),
    detail: { summary: "List Legal Compliance Records", tags: ["Localization OS"] },
  })

  .get("/compliance/stats", async ({ set }) => {
    try {
      const data = await localizationEngineService.getComplianceStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Compliance Statistics", tags: ["Localization OS"] },
  })

  .get("/tax-regulations", async ({ query, set }) => {
    try {
      const { page, limit, taxAuthority } = query;
      const data = await localizationEngineService.getTaxRegulations({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        taxAuthority: taxAuthority as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      taxAuthority: t.Optional(t.String()),
    }),
    detail: { summary: "List Tax Regulations", tags: ["Localization OS"] },
  })

  .get("/tax-regulations/stats", async ({ set }) => {
    try {
      const data = await localizationEngineService.getTaxStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Tax Regulation Statistics", tags: ["Localization OS"] },
  });
