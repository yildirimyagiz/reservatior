import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aiExtractedDataService } from "../services/aiextracteddata";
import { 
  AiExtractedDataPlainInputCreate, 
  AiExtractedDataPlainInputUpdate 
} from "../../generated/prismabox/AiExtractedData";

export const aiExtractedDataRoutes = new Elysia({ prefix: "/ai-extracted-data" })
  .use(authMiddleware)

  /**
   * GET /ai-extracted-data
   * Retrieves all AiExtractedData with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aiExtractedDataService.getAll({
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
   * POST /ai-extracted-data
   * Creates a new AiExtractedData.
   */
  .post("/", async ({ body, set }) => {
    const data = await aiExtractedDataService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AiExtractedDataPlainInputCreate
  })

  /**
   * GET /ai-extracted-data/:id
   * Retrieves a single AiExtractedData by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aiExtractedDataService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AiExtractedData not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-extracted-data/:id
   * Updates an existing AiExtractedData.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aiExtractedDataService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AiExtractedData not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AiExtractedDataPlainInputUpdate
  })

  /**
   * DELETE /ai-extracted-data/:id
   * Deletes a AiExtractedData.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aiExtractedDataService.delete(params.id);
      return { success: true, message: "AiExtractedData deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AiExtractedData not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
