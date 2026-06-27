import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIValuationModelService } from "../services/aivaluationmodel";
import { 
  AIValuationModelPlainInputCreate, 
  AIValuationModelPlainInputUpdate 
} from "../../generated/prismabox/AIValuationModel";

export const aivaluationModelRoutes = new Elysia({ prefix: "/ai-valuation-models" })
  .use(authMiddleware)

  /**
   * GET /aivaluation-model
   * Retrieves all AIValuationModel with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIValuationModelService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await aIValuationModelService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIValuationModelPlainInputCreate
  })

  /**
   * GET /aivaluation-model/:id
   * Retrieves a single AIValuationModel by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIValuationModelService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIValuationModelService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIValuationModelService.delete(params.id);
      return { success: true, message: "AIValuationModel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIValuationModel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
