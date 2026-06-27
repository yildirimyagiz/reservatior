import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialImpactCounterService } from "../services/socialimpactcounter";
import { 
  SocialImpactCounterPlainInputCreate, 
  SocialImpactCounterPlainInputUpdate 
} from "../../generated/prismabox/SocialImpactCounter";
import { regionMiddleware } from "../middleware/region";

export const socialImpactCounterRoutes = new Elysia({ prefix: "/social-impact-counters" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /social-impact-counter
   * Retrieves all SocialImpactCounter with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return socialImpactCounterService.withDB(db as any).getAll({
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
   * POST /social-impact-counter
   * Creates a new SocialImpactCounter.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await socialImpactCounterService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialImpactCounterPlainInputCreate
  })

  /**
   * GET /social-impact-counter/:id
   * Retrieves a single SocialImpactCounter by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await socialImpactCounterService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialImpactCounter not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /social-impact-counter/:id
   * Updates an existing SocialImpactCounter.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await socialImpactCounterService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialImpactCounter not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialImpactCounterPlainInputUpdate
  })

  /**
   * DELETE /social-impact-counter/:id
   * Deletes a SocialImpactCounter.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await socialImpactCounterService.withDB(db as any).delete(params.id);
      return { success: true, message: "SocialImpactCounter deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialImpactCounter not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
