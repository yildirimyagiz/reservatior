import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { negotiationOfferService } from "../services/negotiationoffer";
import { 
  NegotiationOfferPlainInputCreate, 
  NegotiationOfferPlainInputUpdate 
} from "../../generated/prismabox/NegotiationOffer";
import { regionMiddleware } from "../middleware/region";

export const negotiationOfferRoutes = new Elysia({ prefix: "/negotiation-offers" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /negotiation-offer
   * Retrieves all NegotiationOffer with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return negotiationOfferService.withDB(db as any).getAll({
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
   * POST /negotiation-offer
   * Creates a new NegotiationOffer.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await negotiationOfferService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: NegotiationOfferPlainInputCreate
  })

  /**
   * GET /negotiation-offer/:id
   * Retrieves a single NegotiationOffer by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await negotiationOfferService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "NegotiationOffer not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /negotiation-offer/:id
   * Updates an existing NegotiationOffer.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await negotiationOfferService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "NegotiationOffer not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: NegotiationOfferPlainInputUpdate
  })

  /**
   * DELETE /negotiation-offer/:id
   * Deletes a NegotiationOffer.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await negotiationOfferService.withDB(db as any).delete(params.id);
      return { success: true, message: "NegotiationOffer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "NegotiationOffer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
