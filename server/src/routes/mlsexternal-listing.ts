import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLSExternalListingService } from "../services/mlsexternallisting";
import { 
  MLSExternalListingPlainInputCreate, 
  MLSExternalListingPlainInputUpdate 
} from "../../generated/prismabox/MLSExternalListing";
import { regionMiddleware } from "../middleware/region";

export const mlsexternalListingRoutes = new Elysia({ prefix: "/mlsexternal-listing" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mlsexternal-listing
   * Retrieves all MLSExternalListing with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mLSExternalListingService.withDB(db as any).getAll({
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
   * POST /mlsexternal-listing
   * Creates a new MLSExternalListing.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mLSExternalListingService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLSExternalListingPlainInputCreate
  })

  /**
   * GET /mlsexternal-listing/:id
   * Retrieves a single MLSExternalListing by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mLSExternalListingService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MLSExternalListing not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mlsexternal-listing/:id
   * Updates an existing MLSExternalListing.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mLSExternalListingService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MLSExternalListing not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MLSExternalListingPlainInputUpdate
  })

  /**
   * DELETE /mlsexternal-listing/:id
   * Deletes a MLSExternalListing.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mLSExternalListingService.withDB(db as any).delete(params.id);
      return { success: true, message: "MLSExternalListing deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLSExternalListing not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
