import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { guestReviewService } from "../services/guestreview";
import { 
  GuestReviewPlainInputCreate, 
  GuestReviewPlainInputUpdate 
} from "../../generated/prismabox/GuestReview";
import { regionMiddleware } from "../middleware/region";

export const guestReviewRoutes = new Elysia({ prefix: "/guest-reviews" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /guest-review
   * Retrieves all GuestReview with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return guestReviewService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await guestReviewService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: GuestReviewPlainInputCreate
  })

  /**
   * GET /guest-review/:id
   * Retrieves a single GuestReview by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await guestReviewService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await guestReviewService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await guestReviewService.withDB(db as any).delete(params.id);
      return { success: true, message: "GuestReview deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "GuestReview not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
