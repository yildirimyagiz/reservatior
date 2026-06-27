import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aiVideoGenerationService } from "../services/aivideogeneration";
import { 
  AiVideoGenerationPlainInputCreate, 
  AiVideoGenerationPlainInputUpdate 
} from "../../generated/prismabox/AiVideoGeneration";
import { regionMiddleware } from "../middleware/region";

export const aiVideoGenerationRoutes = new Elysia({ prefix: "/ai-video-generation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /ai-video-generation
   * Retrieves all AiVideoGeneration with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aiVideoGenerationService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aiVideoGenerationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AiVideoGenerationPlainInputCreate
  })

  /**
   * GET /ai-video-generation/:id
   * Retrieves a single AiVideoGeneration by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aiVideoGenerationService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aiVideoGenerationService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aiVideoGenerationService.withDB(db as any).delete(params.id);
      return { success: true, message: "AiVideoGeneration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AiVideoGeneration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
