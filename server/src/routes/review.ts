import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { reviewService } from "../services/review";
import { 
  ReviewPlainInputCreate, 
  ReviewPlainInputUpdate 
} from "../../generated/prismabox/Review";
import { regionMiddleware } from "../middleware/region";

export const reviewRoutes = new Elysia({ prefix: "/reviews" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /review
   * Retrieves all Review with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return reviewService.withDB(db as any).getAll({
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
   * POST /review
   * Creates a new Review.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await reviewService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReviewPlainInputCreate
  })

  /**
   * GET /review/:id
   * Retrieves a single Review by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await reviewService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Review not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /review/:id
   * Updates an existing Review.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await reviewService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Review not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReviewPlainInputUpdate
  })

  /**
   * DELETE /review/:id
   * Deletes a Review.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await reviewService.withDB(db as any).delete(params.id);
      return { success: true, message: "Review deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Review not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
