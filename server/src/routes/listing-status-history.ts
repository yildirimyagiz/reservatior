import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { listingStatusHistoryService } from "../services/listingstatushistory";
import { 
  ListingStatusHistoryPlainInputCreate, 
  ListingStatusHistoryPlainInputUpdate 
} from "../../generated/prismabox/ListingStatusHistory";
import { regionMiddleware } from "../middleware/region";

export const listingStatusHistoryRoutes = new Elysia({ prefix: "/listing-status-histories" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /listing-status-history
   * Retrieves all ListingStatusHistory with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return listingStatusHistoryService.withDB(db as any).getAll({
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
   * POST /listing-status-history
   * Creates a new ListingStatusHistory.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await listingStatusHistoryService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ListingStatusHistoryPlainInputCreate
  })

  /**
   * GET /listing-status-history/:id
   * Retrieves a single ListingStatusHistory by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await listingStatusHistoryService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ListingStatusHistory not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /listing-status-history/:id
   * Updates an existing ListingStatusHistory.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await listingStatusHistoryService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ListingStatusHistory not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ListingStatusHistoryPlainInputUpdate
  })

  /**
   * DELETE /listing-status-history/:id
   * Deletes a ListingStatusHistory.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await listingStatusHistoryService.withDB(db as any).delete(params.id);
      return { success: true, message: "ListingStatusHistory deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ListingStatusHistory not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
