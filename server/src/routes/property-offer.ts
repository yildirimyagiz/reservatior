import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyOfferService } from "../services/propertyoffer";
import { 
  PropertyOfferPlainInputCreate, 
  PropertyOfferPlainInputUpdate 
} from "../../generated/prismabox/PropertyOffer";
import { regionMiddleware } from "../middleware/region";

export const propertyOfferRoutes = new Elysia({ prefix: "/property-offer" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-offer
   * Retrieves all PropertyOffer with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyOfferService.withDB(db as any).getAll({
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
   * POST /property-offer
   * Creates a new PropertyOffer.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyOfferService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyOfferPlainInputCreate
  })

  /**
   * GET /property-offer/:id
   * Retrieves a single PropertyOffer by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyOfferService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyOffer not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-offer/:id
   * Updates an existing PropertyOffer.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyOfferService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOffer not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyOfferPlainInputUpdate
  })

  /**
   * DELETE /property-offer/:id
   * Deletes a PropertyOffer.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyOfferService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyOffer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyOffer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
