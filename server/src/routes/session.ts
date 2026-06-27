import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { sessionService } from "../services/session";
import { 
  SessionPlainInputCreate, 
  SessionPlainInputUpdate 
} from "../../generated/prismabox/Session";

export const sessionRoutes = new Elysia({ prefix: "/sessions" })
  .use(authMiddleware)

  /**
   * GET /session
   * Retrieves all Session with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return sessionService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await sessionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SessionPlainInputCreate
  })

  /**
   * GET /session/:id
   * Retrieves a single Session by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await sessionService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await sessionService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await sessionService.delete(params.id);
      return { success: true, message: "Session deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Session not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
