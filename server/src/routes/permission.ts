import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { permissionService } from "../services/permission";
import { 
  PermissionPlainInputCreate, 
  PermissionPlainInputUpdate 
} from "../../generated/prismabox/Permission";
import { regionMiddleware } from "../middleware/region";

export const permissionRoutes = new Elysia({ prefix: "/permissions" })
  .use(authMiddleware)
  .use(regionMiddleware)
  .onBeforeHandle(hasPermission("ORG_MANAGE"))

  /**
   * GET /permission
   * Retrieves all Permission with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return permissionService.withDB(db as any).getAll({
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
   * POST /permission
   * Creates a new Permission.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await permissionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PermissionPlainInputCreate
  })

  /**
   * GET /permission/:id
   * Retrieves a single Permission by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await permissionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Permission not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /permission/:id
   * Updates an existing Permission.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await permissionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Permission not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PermissionPlainInputUpdate
  })

  /**
   * DELETE /permission/:id
   * Deletes a Permission.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await permissionService.withDB(db as any).delete(params.id);
      return { success: true, message: "Permission deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Permission not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
