import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mlsListingEnhancementService } from "../services/mlslistingenhancement";
import { 
  MlsListingEnhancementPlainInputCreate, 
  MlsListingEnhancementPlainInputUpdate 
} from "../../generated/prismabox/MlsListingEnhancement";

export const mlsListingEnhancementRoutes = new Elysia({ prefix: "/mls-listing-enhancements" })
  .use(authMiddleware)

  /**
   * GET /mls-listing-enhancement
   * Retrieves all MlsListingEnhancement with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mlsListingEnhancementService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await mlsListingEnhancementService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MlsListingEnhancementPlainInputCreate
  })

  /**
   * GET /mls-listing-enhancement/:id
   * Retrieves a single MlsListingEnhancement by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mlsListingEnhancementService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mlsListingEnhancementService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await mlsListingEnhancementService.delete(params.id);
      return { success: true, message: "MlsListingEnhancement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MlsListingEnhancement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
