import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { auditLogService } from "../services/auditlog";
import { 
  AuditLogPlainInputCreate, 
  AuditLogPlainInputUpdate 
} from "../../generated/prismabox/AuditLog";

export const auditLogRoutes = new Elysia({ prefix: "/audit-logs" })
  .use(authMiddleware)

  /**
   * GET /audit-log
   * Retrieves all AuditLog with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return auditLogService.getAll({
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
   * POST /audit-log
   * Creates a new AuditLog.
   */
  .post("/", async ({ body, set }) => {
    const data = await auditLogService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AuditLogPlainInputCreate
  })

  /**
   * GET /audit-log/:id
   * Retrieves a single AuditLog by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await auditLogService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AuditLog not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /audit-log/:id
   * Updates an existing AuditLog.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await auditLogService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AuditLog not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AuditLogPlainInputUpdate
  })

  /**
   * DELETE /audit-log/:id
   * Deletes a AuditLog.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await auditLogService.delete(params.id);
      return { success: true, message: "AuditLog deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AuditLog not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
