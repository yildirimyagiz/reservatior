import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLSExternalListingService } from "../services/mlsexternallisting";
import { 
  MLSExternalListingPlainInputCreate, 
  MLSExternalListingPlainInputUpdate 
} from "../../generated/prismabox/MLSExternalListing";

export const mlsexternalListingRoutes = new Elysia({ prefix: "/mlsexternal-listing" })
  .use(authMiddleware)

  /**
   * GET /mlsexternal-listing
   * Retrieves all MLSExternalListing with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mLSExternalListingService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await mLSExternalListingService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLSExternalListingPlainInputCreate
  })

  /**
   * GET /mlsexternal-listing/:id
   * Retrieves a single MLSExternalListing by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mLSExternalListingService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mLSExternalListingService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await mLSExternalListingService.delete(params.id);
      return { success: true, message: "MLSExternalListing deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLSExternalListing not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
