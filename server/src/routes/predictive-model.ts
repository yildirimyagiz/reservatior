import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { predictiveModelService } from "../services/predictivemodel";
import { 
  PredictiveModelPlainInputCreate, 
  PredictiveModelPlainInputUpdate 
} from "../../generated/prismabox/PredictiveModel";
import { regionMiddleware } from "../middleware/region";

export const predictiveModelRoutes = new Elysia({ prefix: "/predictive-models" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /predictive-model
   * Retrieves all PredictiveModel with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return predictiveModelService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /predictive-model
   * Creates a new PredictiveModel.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await predictiveModelService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PredictiveModelPlainInputCreate
  })

  /**
   * GET /predictive-model/:id
   * Retrieves a single PredictiveModel by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await predictiveModelService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PredictiveModel not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /predictive-model/:id
   * Updates an existing PredictiveModel.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await predictiveModelService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PredictiveModel not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PredictiveModelPlainInputUpdate
  })

  /**
   * DELETE /predictive-model/:id
   * Deletes a PredictiveModel.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await predictiveModelService.withDB(db as any).delete(params.id);
      return { success: true, message: "PredictiveModel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PredictiveModel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
