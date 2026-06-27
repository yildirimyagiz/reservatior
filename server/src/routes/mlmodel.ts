import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLModelService } from "../services/mlmodel";
import { 
  MLModelPlainInputCreate, 
  MLModelPlainInputUpdate 
} from "../../generated/prismabox/MLModel";
import { regionMiddleware } from "../middleware/region";

export const mlmodelRoutes = new Elysia({ prefix: "/mlmodel" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mlmodel
   * Retrieves all MLModel with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mLModelService.withDB(db as any).getAll({
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
   * POST /mlmodel
   * Creates a new MLModel.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mLModelService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLModelPlainInputCreate
  })

  /**
   * GET /mlmodel/:id
   * Retrieves a single MLModel by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mLModelService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MLModel not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mlmodel/:id
   * Updates an existing MLModel.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mLModelService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MLModel not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MLModelPlainInputUpdate
  })

  /**
   * DELETE /mlmodel/:id
   * Deletes a MLModel.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mLModelService.withDB(db as any).delete(params.id);
      return { success: true, message: "MLModel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLModel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
