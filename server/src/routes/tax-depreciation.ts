import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { taxDepreciationService } from "../services/taxdepreciation";
import { 
  TaxDepreciationPlainInputCreate, 
  TaxDepreciationPlainInputUpdate 
} from "../../generated/prismabox/TaxDepreciation";
import { regionMiddleware } from "../middleware/region";

export const taxDepreciationRoutes = new Elysia({ prefix: "/tax-depreciations" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /tax-depreciation
   * Retrieves all TaxDepreciation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return taxDepreciationService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /tax-depreciation
   * Creates a new TaxDepreciation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await taxDepreciationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: TaxDepreciationPlainInputCreate
  })

  /**
   * GET /tax-depreciation/:id
   * Retrieves a single TaxDepreciation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await taxDepreciationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "TaxDepreciation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /tax-depreciation/:id
   * Updates an existing TaxDepreciation.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await taxDepreciationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "TaxDepreciation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TaxDepreciationPlainInputUpdate
  })

  /**
   * DELETE /tax-depreciation/:id
   * Deletes a TaxDepreciation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await taxDepreciationService.withDB(db as any).delete(params.id);
      return { success: true, message: "TaxDepreciation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "TaxDepreciation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
