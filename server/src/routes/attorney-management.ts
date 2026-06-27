import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { attorneyManagementService } from "../services/attorneymanagement";
import { 
  AttorneyManagementPlainInputCreate, 
  AttorneyManagementPlainInputUpdate 
} from "../../generated/prismabox/AttorneyManagement";
import { regionMiddleware } from "../middleware/region";

export const attorneyManagementRoutes = new Elysia({ prefix: "/attorney-managements" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /attorney-management
   * Retrieves all AttorneyManagement with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return attorneyManagementService.withDB(db as any).getAll({
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
   * POST /attorney-management
   * Creates a new AttorneyManagement.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await attorneyManagementService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AttorneyManagementPlainInputCreate
  })

  /**
   * GET /attorney-management/:id
   * Retrieves a single AttorneyManagement by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await attorneyManagementService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AttorneyManagement not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /attorney-management/:id
   * Updates an existing AttorneyManagement.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await attorneyManagementService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AttorneyManagement not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AttorneyManagementPlainInputUpdate
  })

  /**
   * DELETE /attorney-management/:id
   * Deletes a AttorneyManagement.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await attorneyManagementService.withDB(db as any).delete(params.id);
      return { success: true, message: "AttorneyManagement deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AttorneyManagement not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
