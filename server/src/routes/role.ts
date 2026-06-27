import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { roleService } from "../services/role";
import { 
  RolePlainInputCreate, 
  RolePlainInputUpdate 
} from "../../generated/prismabox/Role";

export const roleRoutes = new Elysia({ prefix: "/roles" })
  .use(authMiddleware)

  /**
   * GET /role
   * Retrieves all Role with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return roleService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await roleService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: RolePlainInputCreate
  })

  /**
   * GET /role/:id
   * Retrieves a single Role by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await roleService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await roleService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await roleService.delete(params.id);
      return { success: true, message: "Role deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Role not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
