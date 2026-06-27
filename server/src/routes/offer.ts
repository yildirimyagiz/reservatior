import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { offerService } from "../services/offer";
import { 
  OfferPlainInputCreate, 
  OfferPlainInputUpdate 
} from "../../generated/prismabox/Offer";
import { regionMiddleware } from "../middleware/region";

export const offerRoutes = new Elysia({ prefix: "/offers" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /offer
   * Retrieves all Offer with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return offerService.withDB(db as any).getAll({
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
   * POST /offer
   * Creates a new Offer.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await offerService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: OfferPlainInputCreate
  })

  /**
   * GET /offer/:id
   * Retrieves a single Offer by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await offerService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Offer not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /offer/:id
   * Updates an existing Offer.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await offerService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Offer not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: OfferPlainInputUpdate
  })

  /**
   * DELETE /offer/:id
   * Deletes a Offer.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await offerService.withDB(db as any).delete(params.id);
      return { success: true, message: "Offer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Offer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
