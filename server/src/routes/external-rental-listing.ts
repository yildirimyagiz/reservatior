import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { externalRentalListingService } from "../services/externalrentallisting";
import { 
  ExternalRentalListingPlainInputCreate, 
  ExternalRentalListingPlainInputUpdate 
} from "../../generated/prismabox/ExternalRentalListing";
import { regionMiddleware } from "../middleware/region";

export const externalRentalListingRoutes = new Elysia({ prefix: "/external-rental-listings" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /external-rental-listing
   * Retrieves all ExternalRentalListing with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return externalRentalListingService.withDB(db as any).getAll({
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
   * POST /external-rental-listing
   * Creates a new ExternalRentalListing.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await externalRentalListingService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExternalRentalListingPlainInputCreate
  })

  /**
   * GET /external-rental-listing/:id
   * Retrieves a single ExternalRentalListing by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await externalRentalListingService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ExternalRentalListing not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /external-rental-listing/:id
   * Updates an existing ExternalRentalListing.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await externalRentalListingService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ExternalRentalListing not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ExternalRentalListingPlainInputUpdate
  })

  /**
   * DELETE /external-rental-listing/:id
   * Deletes a ExternalRentalListing.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await externalRentalListingService.withDB(db as any).delete(params.id);
      return { success: true, message: "ExternalRentalListing deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExternalRentalListing not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
