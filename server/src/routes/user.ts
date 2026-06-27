import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { userService } from "../services/user";
import { 
  UserPlainInputCreate, 
  UserPlainInputUpdate 
} from "../../generated/prismabox/User";

export const userRoutes = new Elysia({ prefix: "/user" })
  .use(authMiddleware)
  .onBeforeHandle(hasPermission("USERS_MANAGE"))

  /**
   * GET /user
   * Retrieves all User with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return userService.getAll({
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
   * POST /user
   * Creates a new User.
   */
  .post("/", async ({ body, set }) => {
    const data = await userService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: UserPlainInputCreate
  })

  /**
   * GET /user/:id
   * Retrieves a single User by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await userService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "User not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /user/:id
   * Updates an existing User.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await userService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "User not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: UserPlainInputUpdate
  })

  /**
   * DELETE /user/:id
   * Deletes a User.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await userService.delete(params.id);
      return { success: true, message: "User deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "User not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
