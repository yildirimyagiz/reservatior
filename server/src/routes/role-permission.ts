import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { rolePermissionService } from "../services/rolepermission";
import { 
  RolePermissionPlainInputCreate, 
  RolePermissionPlainInputUpdate 
} from "../../generated/prismabox/RolePermission";
import { regionMiddleware } from "../middleware/region";

export const rolePermissionRoutes = new Elysia({ prefix: "/role-permissions" })
  .use(authMiddleware)
  .use(regionMiddleware)
  .onBeforeHandle(hasPermission("ORG_MANAGE"))

  /**
   * GET /role-permission
   * Retrieves all RolePermission with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return rolePermissionService.withDB(db as any).getAll({
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
   * POST /role-permission
   * Creates a new RolePermission.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await rolePermissionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: RolePermissionPlainInputCreate
  })

  /**
   * GET /role-permission/:id
   * Retrieves a single RolePermission by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await rolePermissionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "RolePermission not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /role-permission/:id
   * Updates an existing RolePermission.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await rolePermissionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "RolePermission not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RolePermissionPlainInputUpdate
  })

  /**
   * DELETE /role-permission/:id
   * Deletes a RolePermission.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await rolePermissionService.withDB(db as any).delete(params.id);
      return { success: true, message: "RolePermission deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RolePermission not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
