import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { rolePermissionService } from "../services/rolepermission";
import { 
  RolePermissionPlainInputCreate, 
  RolePermissionPlainInputUpdate 
} from "../../generated/prismabox/RolePermission";

export const rolePermissionRoutes = new Elysia({ prefix: "/role-permissions" })
  .use(authMiddleware)

  /**
   * GET /role-permission
   * Retrieves all RolePermission with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return rolePermissionService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await rolePermissionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: RolePermissionPlainInputCreate
  })

  /**
   * GET /role-permission/:id
   * Retrieves a single RolePermission by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await rolePermissionService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await rolePermissionService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await rolePermissionService.delete(params.id);
      return { success: true, message: "RolePermission deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RolePermission not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
