import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoCaptionService } from "../services/videocaption";
import { 
  VideoCaptionPlainInputCreate, 
  VideoCaptionPlainInputUpdate 
} from "../../generated/prismabox/VideoCaption";

export const videoCaptionRoutes = new Elysia({ prefix: "/video-caption" })
  .use(authMiddleware)

  /**
   * GET /video-caption
   * Retrieves all VideoCaption with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return videoCaptionService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await videoCaptionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoCaptionPlainInputCreate
  })

  /**
   * GET /video-caption/:id
   * Retrieves a single VideoCaption by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await videoCaptionService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await videoCaptionService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await videoCaptionService.delete(params.id);
      return { success: true, message: "VideoCaption deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoCaption not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
