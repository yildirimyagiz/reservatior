import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialImpactRecordService } from "../services/socialimpactrecord";
import { 
  SocialImpactRecordPlainInputCreate, 
  SocialImpactRecordPlainInputUpdate 
} from "../../generated/prismabox/SocialImpactRecord";
import { regionMiddleware } from "../middleware/region";

export const socialImpactRecordRoutes = new Elysia({ prefix: "/social-impact-records" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /social-impact-record
   * Retrieves all SocialImpactRecord with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return socialImpactRecordService.withDB(db as any).getAll({
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
   * POST /social-impact-record
   * Creates a new SocialImpactRecord.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await socialImpactRecordService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialImpactRecordPlainInputCreate
  })

  /**
   * GET /social-impact-record/:id
   * Retrieves a single SocialImpactRecord by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await socialImpactRecordService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialImpactRecord not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /social-impact-record/:id
   * Updates an existing SocialImpactRecord.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await socialImpactRecordService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialImpactRecord not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialImpactRecordPlainInputUpdate
  })

  /**
   * DELETE /social-impact-record/:id
   * Deletes a SocialImpactRecord.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await socialImpactRecordService.withDB(db as any).delete(params.id);
      return { success: true, message: "SocialImpactRecord deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialImpactRecord not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
