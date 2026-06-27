import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { globalTaxRegulationService } from "../services/globaltaxregulation";
import { 
  GlobalTaxRegulationPlainInputCreate, 
  GlobalTaxRegulationPlainInputUpdate 
} from "../../generated/prismabox/GlobalTaxRegulation";

export const globalTaxRegulationRoutes = new Elysia({ prefix: "/global-tax-regulation" })
  .use(authMiddleware)
  
  /**
   * GET /global-tax-regulation/countries
   * Retrieves all supported countries with tax regulation data.
   */
  .get("/countries", async () => {
    return { data: globalTaxRegulationService.getSupportedCountries() };
  })

  /**
   * GET /global-tax-regulation/defaults/:countryCode
   * Retrieves default tax rates for a specific country.
   */
  .get("/defaults/:countryCode", async ({ params }) => {
    return { data: globalTaxRegulationService.getDefaultRates(params.countryCode) };
  }, {
    params: t.Object({ countryCode: t.String() })
  })

  /**
   * GET /global-tax-regulation
   * Retrieves all GlobalTaxRegulation with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return globalTaxRegulationService.getAll({
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
   * POST /global-tax-regulation
   * Creates a new GlobalTaxRegulation.
   */
  .post("/", async ({ body, set }) => {
    const data = await globalTaxRegulationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: GlobalTaxRegulationPlainInputCreate
  })

  /**
   * GET /global-tax-regulation/:id
   * Retrieves a single GlobalTaxRegulation by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await globalTaxRegulationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "GlobalTaxRegulation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /global-tax-regulation/:id
   * Updates an existing GlobalTaxRegulation.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await globalTaxRegulationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "GlobalTaxRegulation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: GlobalTaxRegulationPlainInputUpdate
  })

  /**
   * DELETE /global-tax-regulation/:id
   * Deletes a GlobalTaxRegulation.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await globalTaxRegulationService.delete(params.id);
      return { success: true, message: "GlobalTaxRegulation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GlobalTaxRegulation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
