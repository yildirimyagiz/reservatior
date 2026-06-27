import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { communicationLogService } from "../services/communicationlog";
import { 
  CommunicationLogPlainInputCreate, 
  CommunicationLogPlainInputUpdate 
} from "../../generated/prismabox/CommunicationLog";

export const communicationLogRoutes = new Elysia({ prefix: "/communication-logs" })
  .use(authMiddleware)

  /**
   * GET /communication-log
   * Retrieves all CommunicationLog with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return communicationLogService.getAll({
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
   * POST /communication-log
   * Creates a new CommunicationLog.
   */
  .post("/", async ({ body, set }) => {
    const data = await communicationLogService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: CommunicationLogPlainInputCreate
  })

  /**
   * GET /communication-log/:id
   * Retrieves a single CommunicationLog by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await communicationLogService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "CommunicationLog not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /communication-log/:id
   * Updates an existing CommunicationLog.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await communicationLogService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "CommunicationLog not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CommunicationLogPlainInputUpdate
  })

  /**
   * DELETE /communication-log/:id
   * Deletes a CommunicationLog.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await communicationLogService.delete(params.id);
      return { success: true, message: "CommunicationLog deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "CommunicationLog not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
