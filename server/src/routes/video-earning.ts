import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoEarningService } from "../services/videoearning";
import { 
  VideoEarningPlainInputCreate, 
  VideoEarningPlainInputUpdate 
} from "../../generated/prismabox/VideoEarning";

export const videoEarningRoutes = new Elysia({ prefix: "/video-earning" })
  .use(authMiddleware)

  /**
   * GET /video-earning
   * Retrieves all VideoEarning with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return videoEarningService.getAll({
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
   * POST /video-earning
   * Creates a new VideoEarning.
   */
  .post("/", async ({ body, set }) => {
    const data = await videoEarningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoEarningPlainInputCreate
  })

  /**
   * GET /video-earning/:id
   * Retrieves a single VideoEarning by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await videoEarningService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VideoEarning not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /video-earning/:id
   * Updates an existing VideoEarning.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await videoEarningService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VideoEarning not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VideoEarningPlainInputUpdate
  })

  /**
   * DELETE /video-earning/:id
   * Deletes a VideoEarning.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await videoEarningService.delete(params.id);
      return { success: true, message: "VideoEarning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoEarning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
