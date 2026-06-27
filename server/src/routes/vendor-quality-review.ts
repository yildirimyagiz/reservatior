import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vendorQualityReviewService } from "../services/vendorqualityreview";
import { 
  VendorQualityReviewPlainInputCreate, 
  VendorQualityReviewPlainInputUpdate 
} from "../../generated/prismabox/VendorQualityReview";
import { regionMiddleware } from "../middleware/region";

export const vendorQualityReviewRoutes = new Elysia({ prefix: "/vendor-quality-review" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /vendor-quality-review
   * Retrieves all VendorQualityReview with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return vendorQualityReviewService.withDB(db as any).getAll({
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
   * POST /vendor-quality-review
   * Creates a new VendorQualityReview.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await vendorQualityReviewService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VendorQualityReviewPlainInputCreate
  })

  /**
   * GET /vendor-quality-review/:id
   * Retrieves a single VendorQualityReview by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await vendorQualityReviewService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VendorQualityReview not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /vendor-quality-review/:id
   * Updates an existing VendorQualityReview.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await vendorQualityReviewService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VendorQualityReview not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VendorQualityReviewPlainInputUpdate
  })

  /**
   * DELETE /vendor-quality-review/:id
   * Deletes a VendorQualityReview.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await vendorQualityReviewService.withDB(db as any).delete(params.id);
      return { success: true, message: "VendorQualityReview deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VendorQualityReview not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
