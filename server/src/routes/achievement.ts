import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { achievementService } from "../services/achievement";
import { 
  AchievementPlainInputCreate, 
  AchievementPlainInputUpdate 
} from "../../generated/prismabox/Achievement";

export const achievementRoutes = new Elysia({ prefix: "/achievements" })
  .use(authMiddleware)

  /**
   * GET /achievement
   * Retrieves all Achievement with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return achievementService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await achievementService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AchievementPlainInputCreate
  })

  /**
   * GET /achievement/:id
   * Retrieves a single Achievement by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await achievementService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await achievementService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await achievementService.delete(params.id);
      return { success: true, message: "Achievement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Achievement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
