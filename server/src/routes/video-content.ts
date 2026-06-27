import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoContentService } from "../services/videocontent";
import { 
  VideoContentPlainInputCreate, 
  VideoContentPlainInputUpdate 
} from "../../generated/prismabox/VideoContent";
import { regionMiddleware } from "../middleware/region";

export const videoContentRoutes = new Elysia({ prefix: "/video-contents" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /video-content
   * Retrieves all VideoContent with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return videoContentService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await videoContentService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoContentPlainInputCreate
  })

  /**
   * GET /video-content/:id
   * Retrieves a single VideoContent by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await videoContentService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await videoContentService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await videoContentService.withDB(db as any).delete(params.id);
      return { success: true, message: "VideoContent deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoContent not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
