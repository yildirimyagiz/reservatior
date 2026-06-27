import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { sessionService } from "../services/session";
import { 
  SessionPlainInputCreate, 
  SessionPlainInputUpdate 
} from "../../generated/prismabox/Session";
import { regionMiddleware } from "../middleware/region";

export const sessionRoutes = new Elysia({ prefix: "/sessions" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /session
   * Retrieves all Session with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return sessionService.withDB(db as any).getAll({
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
   * POST /session
   * Creates a new Session.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await sessionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: SessionPlainInputCreate
  })

  /**
   * GET /session/:id
   * Retrieves a single Session by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await sessionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Session not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /session/:id
   * Updates an existing Session.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await sessionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Session not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SessionPlainInputUpdate
  })

  /**
   * DELETE /session/:id
   * Deletes a Session.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await sessionService.withDB(db as any).delete(params.id);
      return { success: true, message: "Session deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Session not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
