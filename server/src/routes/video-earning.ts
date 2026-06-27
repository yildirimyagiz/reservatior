import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoEarningService } from "../services/videoearning";
import { 
  VideoEarningPlainInputCreate, 
  VideoEarningPlainInputUpdate 
} from "../../generated/prismabox/VideoEarning";
import { regionMiddleware } from "../middleware/region";

export const videoEarningRoutes = new Elysia({ prefix: "/video-earning" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /video-earning
   * Retrieves all VideoEarning with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return videoEarningService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await videoEarningService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoEarningPlainInputCreate
  })

  /**
   * GET /video-earning/:id
   * Retrieves a single VideoEarning by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await videoEarningService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await videoEarningService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await videoEarningService.withDB(db as any).delete(params.id);
      return { success: true, message: "VideoEarning deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoEarning not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
