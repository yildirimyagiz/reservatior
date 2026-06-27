import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mlsListingEnhancementService } from "../services/mlslistingenhancement";
import { 
  MlsListingEnhancementPlainInputCreate, 
  MlsListingEnhancementPlainInputUpdate 
} from "../../generated/prismabox/MlsListingEnhancement";
import { regionMiddleware } from "../middleware/region";

export const mlsListingEnhancementRoutes = new Elysia({ prefix: "/mls-listing-enhancements" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mls-listing-enhancement
   * Retrieves all MlsListingEnhancement with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mlsListingEnhancementService.withDB(db as any).getAll({
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
   * POST /mls-listing-enhancement
   * Creates a new MlsListingEnhancement.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mlsListingEnhancementService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MlsListingEnhancementPlainInputCreate
  })

  /**
   * GET /mls-listing-enhancement/:id
   * Retrieves a single MlsListingEnhancement by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mlsListingEnhancementService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MlsListingEnhancement not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mls-listing-enhancement/:id
   * Updates an existing MlsListingEnhancement.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mlsListingEnhancementService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MlsListingEnhancement not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MlsListingEnhancementPlainInputUpdate
  })

  /**
   * DELETE /mls-listing-enhancement/:id
   * Deletes a MlsListingEnhancement.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mlsListingEnhancementService.withDB(db as any).delete(params.id);
      return { success: true, message: "MlsListingEnhancement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MlsListingEnhancement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
