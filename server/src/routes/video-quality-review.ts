import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoQualityReviewService } from "../services/videoqualityreview";
import { 
  VideoQualityReviewPlainInputCreate, 
  VideoQualityReviewPlainInputUpdate 
} from "../../generated/prismabox/VideoQualityReview";

export const videoQualityReviewRoutes = new Elysia({ prefix: "/video-quality-review" })
  .use(authMiddleware)

  /**
   * GET /video-quality-review
   * Retrieves all VideoQualityReview with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return videoQualityReviewService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await videoQualityReviewService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoQualityReviewPlainInputCreate
  })

  /**
   * GET /video-quality-review/:id
   * Retrieves a single VideoQualityReview by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await videoQualityReviewService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await videoQualityReviewService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await videoQualityReviewService.delete(params.id);
      return { success: true, message: "VideoQualityReview deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoQualityReview not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
