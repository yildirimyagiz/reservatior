import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { userActivityLogService } from "../services/useractivitylog";
import { 
  UserActivityLogPlainInputCreate, 
  UserActivityLogPlainInputUpdate 
} from "../../generated/prismabox/UserActivityLog";

export const userActivityLogRoutes = new Elysia({ prefix: "/user-activity-logs" })
  .use(authMiddleware)

  /**
   * GET /user-activity-log
   * Retrieves all UserActivityLog with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return userActivityLogService.getAll({
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
   * POST /user-activity-log
   * Creates a new UserActivityLog.
   */
  .post("/", async ({ body, set }) => {
    const data = await userActivityLogService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: UserActivityLogPlainInputCreate
  })

  /**
   * GET /user-activity-log/:id
   * Retrieves a single UserActivityLog by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await userActivityLogService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "UserActivityLog not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /user-activity-log/:id
   * Updates an existing UserActivityLog.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await userActivityLogService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "UserActivityLog not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: UserActivityLogPlainInputUpdate
  })

  /**
   * DELETE /user-activity-log/:id
   * Deletes a UserActivityLog.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await userActivityLogService.delete(params.id);
      return { success: true, message: "UserActivityLog deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "UserActivityLog not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
