import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aILeadScoringService } from "../services/aileadscoring";
import { 
  AILeadScoringPlainInputCreate, 
  AILeadScoringPlainInputUpdate 
} from "../../generated/prismabox/AILeadScoring";
import { regionMiddleware } from "../middleware/region";

export const aileadScoringRoutes = new Elysia({ prefix: "/ai-lead-scores" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /ailead-scoring
   * Retrieves all AILeadScoring with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return aILeadScoringService.withDB(db as any).getAll({
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
   * POST /ailead-scoring
   * Creates a new AILeadScoring.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await aILeadScoringService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AILeadScoringPlainInputCreate
  })

  /**
   * GET /ailead-scoring/:id
   * Retrieves a single AILeadScoring by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await aILeadScoringService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AILeadScoring not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ailead-scoring/:id
   * Updates an existing AILeadScoring.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await aILeadScoringService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AILeadScoring not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AILeadScoringPlainInputUpdate
  })

  /**
   * DELETE /ailead-scoring/:id
   * Deletes a AILeadScoring.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await aILeadScoringService.withDB(db as any).delete(params.id);
      return { success: true, message: "AILeadScoring deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AILeadScoring not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
