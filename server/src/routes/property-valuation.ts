import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyValuationService } from "../services/propertyvaluation";
import { 
  PropertyValuationPlainInputCreate, 
  PropertyValuationPlainInputUpdate 
} from "../../generated/prismabox/PropertyValuation";
import { regionMiddleware } from "../middleware/region";

export const propertyValuationRoutes = new Elysia({ prefix: "/property-valuation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-valuation
   * Retrieves all PropertyValuation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyValuationService.withDB(db as any).getAll({
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
   * POST /property-valuation
   * Creates a new PropertyValuation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyValuationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyValuationPlainInputCreate
  })

  /**
   * GET /property-valuation/:id
   * Retrieves a single PropertyValuation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyValuationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyValuation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-valuation/:id
   * Updates an existing PropertyValuation.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyValuationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyValuation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyValuationPlainInputUpdate
  })

  /**
   * DELETE /property-valuation/:id
   * Deletes a PropertyValuation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyValuationService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyValuation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyValuation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
