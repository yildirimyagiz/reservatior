import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { taxDepreciationService } from "../services/taxdepreciation";
import { 
  TaxDepreciationPlainInputCreate, 
  TaxDepreciationPlainInputUpdate 
} from "../../generated/prismabox/TaxDepreciation";

export const taxDepreciationRoutes = new Elysia({ prefix: "/tax-depreciations" })
  .use(authMiddleware)

  /**
   * GET /tax-depreciation
   * Retrieves all TaxDepreciation with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return taxDepreciationService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await taxDepreciationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TaxDepreciationPlainInputCreate
  })

  /**
   * GET /tax-depreciation/:id
   * Retrieves a single TaxDepreciation by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await taxDepreciationService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await taxDepreciationService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await taxDepreciationService.delete(params.id);
      return { success: true, message: "TaxDepreciation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "TaxDepreciation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
