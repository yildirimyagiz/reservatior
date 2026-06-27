import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { roleService } from "../services/role";
import { 
  RolePlainInputCreate, 
  RolePlainInputUpdate 
} from "../../generated/prismabox/Role";
import { regionMiddleware } from "../middleware/region";

export const roleRoutes = new Elysia({ prefix: "/roles" })
  .use(authMiddleware)
  .use(regionMiddleware)
  .onBeforeHandle(hasPermission("ORG_MANAGE"))

  /**
   * GET /role
   * Retrieves all Role with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return roleService.withDB(db as any).getAll({
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
   * POST /role
   * Creates a new Role.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await roleService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: RolePlainInputCreate
  })

  /**
   * GET /role/:id
   * Retrieves a single Role by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await roleService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Role not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /role/:id
   * Updates an existing Role.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await roleService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Role not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RolePlainInputUpdate
  })

  /**
   * DELETE /role/:id
   * Deletes a Role.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await roleService.withDB(db as any).delete(params.id);
      return { success: true, message: "Role deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Role not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
