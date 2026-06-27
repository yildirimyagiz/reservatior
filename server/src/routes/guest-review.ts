import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { guestReviewService } from "../services/guestreview";
import { 
  GuestReviewPlainInputCreate, 
  GuestReviewPlainInputUpdate 
} from "../../generated/prismabox/GuestReview";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const guestReviewRoutes = new Elysia({ prefix: "/guest-reviews" })
  .use(authMiddleware)

  /**
   * GET /guest-review
   * Retrieves all GuestReview with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return guestReviewService.getAll({
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
   * POST /guest-review
   * Creates a new GuestReview.
   */
  .post("/", async ({ body, set }) => {
    const data = await guestReviewService.create(body);

    // ML Feedback Loop: Review Sentiment to Property Ranking
    // Map rating 1-5 to a reward score between -1.0 and 1.0
    const rating = data.rating || 3;
    const rewardScore = (rating - 3) / 2.0;

    MLBridgeService.sendFeedback("rank-failover", "GUEST_REVIEW_POSTED", rewardScore, {
      reviewId: data.id,
      propertyId: data.propertyId,
      guestId: data.guestId,
      rating: data.rating
    }).catch(console.error);

    set.status = 201;
    return { data };
  }, {
    body: GuestReviewPlainInputCreate
  })

  /**
   * GET /guest-review/:id
   * Retrieves a single GuestReview by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await guestReviewService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "GuestReview not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /guest-review/:id
   * Updates an existing GuestReview.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await guestReviewService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "GuestReview not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: GuestReviewPlainInputUpdate
  })

  /**
   * DELETE /guest-review/:id
   * Deletes a GuestReview.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await guestReviewService.delete(params.id);
      return { success: true, message: "GuestReview deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GuestReview not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
