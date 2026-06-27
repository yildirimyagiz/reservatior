import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aiBrochureGenerationService } from "../services/aibrochuregeneration";
import { 
  AiBrochureGenerationPlainInputCreate, 
  AiBrochureGenerationPlainInputUpdate 
} from "../../generated/prismabox/AiBrochureGeneration";

export const aiBrochureGenerationRoutes = new Elysia({ prefix: "/ai-brochure-generation" })
  .use(authMiddleware)

  /**
   * GET /ai-brochure-generation
   * Retrieves all AiBrochureGeneration with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aiBrochureGenerationService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await aiBrochureGenerationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AiBrochureGenerationPlainInputCreate
  })

  /**
   * GET /ai-brochure-generation/:id
   * Retrieves a single AiBrochureGeneration by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aiBrochureGenerationService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aiBrochureGenerationService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await aiBrochureGenerationService.delete(params.id);
      return { success: true, message: "AiBrochureGeneration deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AiBrochureGeneration not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
