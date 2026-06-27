import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoVendorService } from "../services/videovendor";
import { 
  VideoVendorPlainInputCreate, 
  VideoVendorPlainInputUpdate 
} from "../../generated/prismabox/VideoVendor";

export const videoVendorRoutes = new Elysia({ prefix: "/video-vendor" })
  .use(authMiddleware)

  /**
   * GET /video-vendor
   * Retrieves all VideoVendor with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return videoVendorService.getAll({
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
   * POST /video-vendor
   * Creates a new VideoVendor.
   */
  .post("/", async ({ body, set }) => {
    const data = await videoVendorService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoVendorPlainInputCreate
  })

  /**
   * GET /video-vendor/:id
   * Retrieves a single VideoVendor by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await videoVendorService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VideoVendor not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /video-vendor/:id
   * Updates an existing VideoVendor.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await videoVendorService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VideoVendor not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VideoVendorPlainInputUpdate
  })

  /**
   * DELETE /video-vendor/:id
   * Deletes a VideoVendor.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await videoVendorService.delete(params.id);
      return { success: true, message: "VideoVendor deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoVendor not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
