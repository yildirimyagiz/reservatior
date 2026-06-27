import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mentionService } from "../services/mention";
import { 
  MentionPlainInputCreate, 
  MentionPlainInputUpdate 
} from "../../generated/prismabox/Mention";
import { regionMiddleware } from "../middleware/region";

export const mentionRoutes = new Elysia({ prefix: "/mentions" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /mention
   * Retrieves all Mention with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return mentionService.withDB(db as any).getAll({
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
   * POST /mention
   * Creates a new Mention.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await mentionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MentionPlainInputCreate
  })

  /**
   * GET /mention/:id
   * Retrieves a single Mention by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await mentionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Mention not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mention/:id
   * Updates an existing Mention.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await mentionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Mention not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MentionPlainInputUpdate
  })

  /**
   * DELETE /mention/:id
   * Deletes a Mention.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await mentionService.withDB(db as any).delete(params.id);
      return { success: true, message: "Mention deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Mention not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /mention/sync-twitter
   * Syncs Twitter mentions to the database.
   */
  .post("/sync-twitter", async () => {
    return mentionService.syncTwitterMentions();
  })

  /**
   * POST /mention/:id/process
   * Processes a mention and auto-replies on Twitter.
   */
  .post("/:id/process", async ({ orgId, db, params }) => {
    return mentionService.withDB(db as any).processMention(params.id);
  }, {
    params: t.Object({ id: t.String() })
  });
