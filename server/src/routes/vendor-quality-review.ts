import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vendorQualityReviewService } from "../services/vendorqualityreview";
import { 
  VendorQualityReviewPlainInputCreate, 
  VendorQualityReviewPlainInputUpdate 
} from "../../generated/prismabox/VendorQualityReview";

export const vendorQualityReviewRoutes = new Elysia({ prefix: "/vendor-quality-review" })
  .use(authMiddleware)

  /**
   * GET /vendor-quality-review
   * Retrieves all VendorQualityReview with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return vendorQualityReviewService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await vendorQualityReviewService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VendorQualityReviewPlainInputCreate
  })

  /**
   * GET /vendor-quality-review/:id
   * Retrieves a single VendorQualityReview by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await vendorQualityReviewService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await vendorQualityReviewService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await vendorQualityReviewService.delete(params.id);
      return { success: true, message: "VendorQualityReview deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VendorQualityReview not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
