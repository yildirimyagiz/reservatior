import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoContentService } from "../services/videocontent";
import { 
  VideoContentPlainInputCreate, 
  VideoContentPlainInputUpdate 
} from "../../generated/prismabox/VideoContent";

export const videoContentRoutes = new Elysia({ prefix: "/video-contents" })
  .use(authMiddleware)

  /**
   * GET /video-content
   * Retrieves all VideoContent with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return videoContentService.getAll({
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
   * POST /video-content
   * Creates a new VideoContent.
   */
  .post("/", async ({ body, set }) => {
    const data = await videoContentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoContentPlainInputCreate
  })

  /**
   * GET /video-content/:id
   * Retrieves a single VideoContent by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await videoContentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VideoContent not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /video-content/:id
   * Updates an existing VideoContent.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await videoContentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VideoContent not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VideoContentPlainInputUpdate
  })

  /**
   * DELETE /video-content/:id
   * Deletes a VideoContent.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await videoContentService.delete(params.id);
      return { success: true, message: "VideoContent deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoContent not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
