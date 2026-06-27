import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoCaptionService } from "../services/videocaption";
import { 
  VideoCaptionPlainInputCreate, 
  VideoCaptionPlainInputUpdate 
} from "../../generated/prismabox/VideoCaption";
import { regionMiddleware } from "../middleware/region";

export const videoCaptionRoutes = new Elysia({ prefix: "/video-caption" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /video-caption
   * Retrieves all VideoCaption with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return videoCaptionService.withDB(db as any).getAll({
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
   * POST /video-caption
   * Creates a new VideoCaption.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await videoCaptionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoCaptionPlainInputCreate
  })

  /**
   * GET /video-caption/:id
   * Retrieves a single VideoCaption by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await videoCaptionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VideoCaption not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /video-caption/:id
   * Updates an existing VideoCaption.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await videoCaptionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VideoCaption not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VideoCaptionPlainInputUpdate
  })

  /**
   * DELETE /video-caption/:id
   * Deletes a VideoCaption.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await videoCaptionService.withDB(db as any).delete(params.id);
      return { success: true, message: "VideoCaption deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoCaption not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
