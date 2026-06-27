import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { solicitorManagementService } from "../services/solicitormanagement";
import { 
  SolicitorManagementPlainInputCreate, 
  SolicitorManagementPlainInputUpdate 
} from "../../generated/prismabox/SolicitorManagement";
import { regionMiddleware } from "../middleware/region";

export const solicitorManagementRoutes = new Elysia({ prefix: "/solicitor-managements" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /solicitor-management
   * Retrieves all SolicitorManagement with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return solicitorManagementService.withDB(db as any).getAll({
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
   * POST /solicitor-management
   * Creates a new SolicitorManagement.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await solicitorManagementService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: SolicitorManagementPlainInputCreate
  })

  /**
   * GET /solicitor-management/:id
   * Retrieves a single SolicitorManagement by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await solicitorManagementService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SolicitorManagement not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /solicitor-management/:id
   * Updates an existing SolicitorManagement.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await solicitorManagementService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SolicitorManagement not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SolicitorManagementPlainInputUpdate
  })

  /**
   * DELETE /solicitor-management/:id
   * Deletes a SolicitorManagement.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await solicitorManagementService.withDB(db as any).delete(params.id);
      return { success: true, message: "SolicitorManagement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SolicitorManagement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
