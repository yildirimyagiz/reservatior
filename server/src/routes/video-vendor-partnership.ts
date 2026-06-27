import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoVendorPartnershipService } from "../services/videovendorpartnership";
import { 
  VideoVendorPartnershipPlainInputCreate, 
  VideoVendorPartnershipPlainInputUpdate 
} from "../../generated/prismabox/VideoVendorPartnership";

export const videoVendorPartnershipRoutes = new Elysia({ prefix: "/video-vendor-partnership" })
  .use(authMiddleware)

  /**
   * GET /video-vendor-partnership
   * Retrieves all VideoVendorPartnership with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return videoVendorPartnershipService.getAll({
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
   * POST /video-vendor-partnership
   * Creates a new VideoVendorPartnership.
   */
  .post("/", async ({ body, set }) => {
    const data = await videoVendorPartnershipService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoVendorPartnershipPlainInputCreate
  })

  /**
   * GET /video-vendor-partnership/:id
   * Retrieves a single VideoVendorPartnership by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await videoVendorPartnershipService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VideoVendorPartnership not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /video-vendor-partnership/:id
   * Updates an existing VideoVendorPartnership.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await videoVendorPartnershipService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VideoVendorPartnership not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VideoVendorPartnershipPlainInputUpdate
  })

  /**
   * DELETE /video-vendor-partnership/:id
   * Deletes a VideoVendorPartnership.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await videoVendorPartnershipService.delete(params.id);
      return { success: true, message: "VideoVendorPartnership deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoVendorPartnership not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
