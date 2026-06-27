import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aILeadScoreService } from "../services/aileadscore";
import { 
  AILeadScorePlainInputCreate, 
  AILeadScorePlainInputUpdate 
} from "../../generated/prismabox/AILeadScore";

export const aileadScoreRoutes = new Elysia({ prefix: "/ailead-score" })
  .use(authMiddleware)

  /**
   * GET /ailead-score
   * Retrieves all AILeadScore with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aILeadScoreService.getAll({
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
   * POST /ailead-score
   * Creates a new AILeadScore.
   */
  .post("/", async ({ body, set }) => {
    const data = await aILeadScoreService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AILeadScorePlainInputCreate
  })

  /**
   * GET /ailead-score/:id
   * Retrieves a single AILeadScore by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aILeadScoreService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AILeadScore not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ailead-score/:id
   * Updates an existing AILeadScore.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aILeadScoreService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AILeadScore not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AILeadScorePlainInputUpdate
  })

  /**
   * DELETE /ailead-score/:id
   * Deletes a AILeadScore.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aILeadScoreService.delete(params.id);
      return { success: true, message: "AILeadScore deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AILeadScore not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
