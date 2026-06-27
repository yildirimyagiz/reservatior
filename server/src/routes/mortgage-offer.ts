import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mortgageOfferService } from "../services/mortgageoffer";
import { 
  MortgageOfferPlainInputCreate, 
  MortgageOfferPlainInputUpdate 
} from "../../generated/prismabox/MortgageOffer";
import { regionMiddleware } from "../middleware/region";

export const mortgageOfferRoutes = new Elysia({ prefix: "/mortgage-offers" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mortgage-offer
   * Retrieves all MortgageOffer with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mortgageOfferService.withDB(db as any).getAll({
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
   * POST /mortgage-offer
   * Creates a new MortgageOffer.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mortgageOfferService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MortgageOfferPlainInputCreate
  })

  /**
   * GET /mortgage-offer/:id
   * Retrieves a single MortgageOffer by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mortgageOfferService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MortgageOffer not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mortgage-offer/:id
   * Updates an existing MortgageOffer.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mortgageOfferService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MortgageOffer not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MortgageOfferPlainInputUpdate
  })

  /**
   * DELETE /mortgage-offer/:id
   * Deletes a MortgageOffer.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mortgageOfferService.withDB(db as any).delete(params.id);
      return { success: true, message: "MortgageOffer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MortgageOffer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
