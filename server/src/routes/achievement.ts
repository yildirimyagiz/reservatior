import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { achievementService } from "../services/achievement";
import { 
  AchievementPlainInputCreate, 
  AchievementPlainInputUpdate 
} from "../../generated/prismabox/Achievement";
import { regionMiddleware } from "../middleware/region";

export const achievementRoutes = new Elysia({ prefix: "/achievements" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /achievement
   * Retrieves all Achievement with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return achievementService.withDB(db as any).getAll({
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
   * POST /achievement
   * Creates a new Achievement.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await achievementService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AchievementPlainInputCreate
  })

  /**
   * GET /achievement/:id
   * Retrieves a single Achievement by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await achievementService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Achievement not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /achievement/:id
   * Updates an existing Achievement.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await achievementService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Achievement not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AchievementPlainInputUpdate
  })

  /**
   * DELETE /achievement/:id
   * Deletes a Achievement.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await achievementService.withDB(db as any).delete(params.id);
      return { success: true, message: "Achievement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Achievement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
