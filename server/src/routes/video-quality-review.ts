import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoQualityReviewService } from "../services/videoqualityreview";
import { 
  VideoQualityReviewPlainInputCreate, 
  VideoQualityReviewPlainInputUpdate 
} from "../../generated/prismabox/VideoQualityReview";
import { regionMiddleware } from "../middleware/region";

export const videoQualityReviewRoutes = new Elysia({ prefix: "/video-quality-review" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /video-quality-review
   * Retrieves all VideoQualityReview with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return videoQualityReviewService.withDB(db as any).getAll({
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
   * POST /video-quality-review
   * Creates a new VideoQualityReview.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await videoQualityReviewService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoQualityReviewPlainInputCreate
  })

  /**
   * GET /video-quality-review/:id
   * Retrieves a single VideoQualityReview by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await videoQualityReviewService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VideoQualityReview not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /video-quality-review/:id
   * Updates an existing VideoQualityReview.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await videoQualityReviewService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VideoQualityReview not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VideoQualityReviewPlainInputUpdate
  })

  /**
   * DELETE /video-quality-review/:id
   * Deletes a VideoQualityReview.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await videoQualityReviewService.withDB(db as any).delete(params.id);
      return { success: true, message: "VideoQualityReview deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoQualityReview not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
