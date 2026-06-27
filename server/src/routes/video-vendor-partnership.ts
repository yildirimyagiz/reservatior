import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { videoVendorPartnershipService } from "../services/videovendorpartnership";
import { 
  VideoVendorPartnershipPlainInputCreate, 
  VideoVendorPartnershipPlainInputUpdate 
} from "../../generated/prismabox/VideoVendorPartnership";
import { regionMiddleware } from "../middleware/region";

export const videoVendorPartnershipRoutes = new Elysia({ prefix: "/video-vendor-partnership" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /video-vendor-partnership
   * Retrieves all VideoVendorPartnership with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return videoVendorPartnershipService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await videoVendorPartnershipService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VideoVendorPartnershipPlainInputCreate
  })

  /**
   * GET /video-vendor-partnership/:id
   * Retrieves a single VideoVendorPartnership by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await videoVendorPartnershipService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await videoVendorPartnershipService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await videoVendorPartnershipService.withDB(db as any).delete(params.id);
      return { success: true, message: "VideoVendorPartnership deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VideoVendorPartnership not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
