import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aiVideoGenerationService } from "../services/aivideogeneration";
import { 
  AiVideoGenerationPlainInputCreate, 
  AiVideoGenerationPlainInputUpdate 
} from "../../generated/prismabox/AiVideoGeneration";

export const aiVideoGenerationRoutes = new Elysia({ prefix: "/ai-video-generation" })
  .use(authMiddleware)

  /**
   * GET /ai-video-generation
   * Retrieves all AiVideoGeneration with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aiVideoGenerationService.getAll({
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
   * POST /ai-video-generation
   * Creates a new AiVideoGeneration.
   */
  .post("/", async ({ body, set }) => {
    const data = await aiVideoGenerationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AiVideoGenerationPlainInputCreate
  })

  /**
   * GET /ai-video-generation/:id
   * Retrieves a single AiVideoGeneration by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aiVideoGenerationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AiVideoGeneration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-video-generation/:id
   * Updates an existing AiVideoGeneration.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aiVideoGenerationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AiVideoGeneration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AiVideoGenerationPlainInputUpdate
  })

  /**
   * DELETE /ai-video-generation/:id
   * Deletes a AiVideoGeneration.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aiVideoGenerationService.delete(params.id);
      return { success: true, message: "AiVideoGeneration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AiVideoGeneration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
