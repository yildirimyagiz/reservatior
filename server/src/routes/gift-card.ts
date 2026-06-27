import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { giftCardService } from "../services/giftcard";
import { 
  GiftCardPlainInputCreate, 
  GiftCardPlainInputUpdate 
} from "../../generated/prismabox/GiftCard";

export const giftCardRoutes = new Elysia({ prefix: "/gift-cards" })
  .use(authMiddleware)

  /**
   * GET /gift-card
   * Retrieves all GiftCard with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return giftCardService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await giftCardService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: GiftCardPlainInputCreate
  })

  /**
   * GET /gift-card/:id
   * Retrieves a single GiftCard by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await giftCardService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await giftCardService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await giftCardService.delete(params.id);
      return { success: true, message: "GiftCard deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GiftCard not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
