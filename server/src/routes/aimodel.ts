import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIModelService } from "../services/aimodel";
import { 
  AIModelPlainInputCreate, 
  AIModelPlainInputUpdate 
} from "../../generated/prismabox/AIModel";

export const aimodelRoutes = new Elysia({ prefix: "/ai-models" })
  .use(authMiddleware)

  /**
   * GET /aimodel
   * Retrieves all AIModel with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIModelService.getAll({
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
   * POST /aimodel
   * Creates a new AIModel.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIModelService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIModelPlainInputCreate
  })

  /**
   * GET /aimodel/:id
   * Retrieves a single AIModel by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIModelService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIModel not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aimodel/:id
   * Updates an existing AIModel.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIModelService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIModel not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIModelPlainInputUpdate
  })

  /**
   * DELETE /aimodel/:id
   * Deletes a AIModel.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIModelService.delete(params.id);
      return { success: true, message: "AIModel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIModel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
