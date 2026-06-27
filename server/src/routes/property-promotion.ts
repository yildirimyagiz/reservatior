import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyPromotionService } from "../services/propertypromotion";
import { 
  PropertyPromotionPlainInputCreate, 
  PropertyPromotionPlainInputUpdate 
} from "../../generated/prismabox/PropertyPromotion";
import { regionMiddleware } from "../middleware/region";

export const propertyPromotionRoutes = new Elysia({ prefix: "/property-promotion" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-promotion
   * Retrieves all PropertyPromotion with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyPromotionService.withDB(db as any).getAll({
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
   * POST /property-promotion
   * Creates a new PropertyPromotion.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyPromotionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyPromotionPlainInputCreate
  })

  /**
   * GET /property-promotion/:id
   * Retrieves a single PropertyPromotion by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyPromotionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyPromotion not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-promotion/:id
   * Updates an existing PropertyPromotion.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyPromotionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyPromotion not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyPromotionPlainInputUpdate
  })

  /**
   * DELETE /property-promotion/:id
   * Deletes a PropertyPromotion.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyPromotionService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyPromotion deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyPromotion not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
