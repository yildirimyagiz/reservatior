import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { globalTaxRegulationService } from "../services/globaltaxregulation";
import { 
  GlobalTaxRegulationPlainInputCreate, 
  GlobalTaxRegulationPlainInputUpdate 
} from "../../generated/prismabox/GlobalTaxRegulation";
import { regionMiddleware } from "../middleware/region";

export const globalTaxRegulationRoutes = new Elysia({ prefix: "/global-tax-regulation" })
  .use(authMiddleware)
  .use(regionMiddleware)
  
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
  .get("/defaults/:countryCode", async ({ orgId, db, params }) => {
    return { data: globalTaxRegulationService.withDB(db as any).getDefaultRates(params.countryCode) };
  }, {
    params: t.Object({ countryCode: t.String() })
  })

  /**
   * GET /global-tax-regulation
   * Retrieves all GlobalTaxRegulation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return globalTaxRegulationService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await globalTaxRegulationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: GlobalTaxRegulationPlainInputCreate
  })

  /**
   * GET /global-tax-regulation/:id
   * Retrieves a single GlobalTaxRegulation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await globalTaxRegulationService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await globalTaxRegulationService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await globalTaxRegulationService.withDB(db as any).delete(params.id);
      return { success: true, message: "GlobalTaxRegulation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GlobalTaxRegulation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
