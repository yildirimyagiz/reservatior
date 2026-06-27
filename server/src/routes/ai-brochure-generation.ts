import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aiBrochureGenerationService } from "../services/aibrochuregeneration";
import { 
  AiBrochureGenerationPlainInputCreate, 
  AiBrochureGenerationPlainInputUpdate 
} from "../../generated/prismabox/AiBrochureGeneration";
import { regionMiddleware } from "../middleware/region";

export const aiBrochureGenerationRoutes = new Elysia({ prefix: "/ai-brochure-generation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /ai-brochure-generation
   * Retrieves all AiBrochureGeneration with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aiBrochureGenerationService.withDB(db as any).getAll({
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
   * POST /ai-brochure-generation
   * Creates a new AiBrochureGeneration.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aiBrochureGenerationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AiBrochureGenerationPlainInputCreate
  })

  /**
   * GET /ai-brochure-generation/:id
   * Retrieves a single AiBrochureGeneration by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aiBrochureGenerationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AiBrochureGeneration not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ai-brochure-generation/:id
   * Updates an existing AiBrochureGeneration.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aiBrochureGenerationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AiBrochureGeneration not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AiBrochureGenerationPlainInputUpdate
  })

  /**
   * DELETE /ai-brochure-generation/:id
   * Deletes a AiBrochureGeneration.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aiBrochureGenerationService.withDB(db as any).delete(params.id);
      return { success: true, message: "AiBrochureGeneration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AiBrochureGeneration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
