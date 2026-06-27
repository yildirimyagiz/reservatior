import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { hashtagService } from "../services/hashtag";
import { 
  HashtagPlainInputCreate, 
  HashtagPlainInputUpdate 
} from "../../generated/prismabox/Hashtag";

export const hashtagRoutes = new Elysia({ prefix: "/hashtags" })
  .use(authMiddleware)

  /**
   * GET /hashtag
   * Retrieves all Hashtag with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return hashtagService.getAll({
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
   * POST /hashtag
   * Creates a new Hashtag.
   */
  .post("/", async ({ body, set }) => {
    const data = await hashtagService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: HashtagPlainInputCreate
  })

  /**
   * GET /hashtag/:id
   * Retrieves a single Hashtag by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await hashtagService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Hashtag not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /hashtag/:id
   * Updates an existing Hashtag.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await hashtagService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Hashtag not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: HashtagPlainInputUpdate
  })

  /**
   * DELETE /hashtag/:id
   * Deletes a Hashtag.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await hashtagService.delete(params.id);
      return { success: true, message: "Hashtag deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Hashtag not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /hashtag/post-twitter
   * Posts a listing to Twitter with hashtags.
   */
  .post("/post-twitter", async ({ body }) => {
    return hashtagService.postWithHashtags(
      body.title,
      body.location,
      body.price,
      body.currency,
      body.imageUrl,
      body.url
    );
  }, {
    body: t.Object({
      title: t.String(),
      location: t.String(),
      price: t.Number(),
      currency: t.String(),
      imageUrl: t.Optional(t.String()),
      url: t.Optional(t.String()),
    })
  })

  /**
   * POST /hashtag/track
   * Tracks hashtag usage.
   */
  .post("/track", async ({ body }) => {
    return hashtagService.trackHashtagUsage(body.hashtag);
  }, {
    body: t.Object({
      hashtag: t.String(),
    })
  })

  /**
   * GET /hashtag/trending
   * Gets trending hashtags.
   */
  .get("/trending", async () => {
    return hashtagService.getTrendingHashtags();
  });
