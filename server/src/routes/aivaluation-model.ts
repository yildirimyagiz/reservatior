import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIValuationModelService } from "../services/aivaluationmodel";
import { 
  AIValuationModelPlainInputCreate, 
  AIValuationModelPlainInputUpdate 
} from "../../generated/prismabox/AIValuationModel";
import { regionMiddleware } from "../middleware/region";

export const aivaluationModelRoutes = new Elysia({ prefix: "/ai-valuation-models" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /aivaluation-model
   * Retrieves all AIValuationModel with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aIValuationModelService.withDB(db as any).getAll({
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
   * POST /aivaluation-model
   * Creates a new AIValuationModel.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aIValuationModelService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIValuationModelPlainInputCreate
  })

  /**
   * GET /aivaluation-model/:id
   * Retrieves a single AIValuationModel by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aIValuationModelService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIValuationModel not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aivaluation-model/:id
   * Updates an existing AIValuationModel.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aIValuationModelService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIValuationModel not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIValuationModelPlainInputUpdate
  })

  /**
   * DELETE /aivaluation-model/:id
   * Deletes a AIValuationModel.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aIValuationModelService.withDB(db as any).delete(params.id);
      return { success: true, message: "AIValuationModel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIValuationModel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
