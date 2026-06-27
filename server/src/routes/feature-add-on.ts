import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { featureAddOnService } from "../services/featureaddon";
import { 
  FeatureAddOnPlainInputCreate, 
  FeatureAddOnPlainInputUpdate 
} from "../../generated/prismabox/FeatureAddOn";
import { regionMiddleware } from "../middleware/region";

export const featureAddOnRoutes = new Elysia({ prefix: "/feature-add-on" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /feature-add-on
   * Retrieves all FeatureAddOn with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return featureAddOnService.withDB(db as any).getAll({
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
   * POST /feature-add-on
   * Creates a new FeatureAddOn.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await featureAddOnService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: FeatureAddOnPlainInputCreate
  })

  /**
   * GET /feature-add-on/:id
   * Retrieves a single FeatureAddOn by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await featureAddOnService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "FeatureAddOn not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /feature-add-on/:id
   * Updates an existing FeatureAddOn.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await featureAddOnService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "FeatureAddOn not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: FeatureAddOnPlainInputUpdate
  })

  /**
   * DELETE /feature-add-on/:id
   * Deletes a FeatureAddOn.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await featureAddOnService.withDB(db as any).delete(params.id);
      return { success: true, message: "FeatureAddOn deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "FeatureAddOn not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
