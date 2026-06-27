import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { giftCardService } from "../services/giftcard";
import { 
  GiftCardPlainInputCreate, 
  GiftCardPlainInputUpdate 
} from "../../generated/prismabox/GiftCard";
import { regionMiddleware } from "../middleware/region";

export const giftCardRoutes = new Elysia({ prefix: "/gift-cards" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /gift-card
   * Retrieves all GiftCard with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return giftCardService.withDB(db as any).getAll({
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
   * POST /gift-card
   * Creates a new GiftCard.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await giftCardService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: GiftCardPlainInputCreate
  })

  /**
   * GET /gift-card/:id
   * Retrieves a single GiftCard by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await giftCardService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "GiftCard not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /gift-card/:id
   * Updates an existing GiftCard.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await giftCardService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "GiftCard not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: GiftCardPlainInputUpdate
  })

  /**
   * DELETE /gift-card/:id
   * Deletes a GiftCard.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await giftCardService.withDB(db as any).delete(params.id);
      return { success: true, message: "GiftCard deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GiftCard not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
