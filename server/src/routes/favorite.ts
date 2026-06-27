import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { favoriteService } from "../services/favorite";
import { 
  FavoritePlainInputCreate, 
  FavoritePlainInputUpdate 
} from "../../generated/prismabox/Favorite";

export const favoriteRoutes = new Elysia({ prefix: "/favorites" })
  .use(authMiddleware)

  /**
   * GET /favorite
   * Retrieves all Favorite with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return favoriteService.getAll({
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
   * POST /favorite
   * Creates a new Favorite.
   */
  .post("/", async ({ body, set }) => {
    const data = await favoriteService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: FavoritePlainInputCreate
  })

  /**
   * GET /favorite/:id
   * Retrieves a single Favorite by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await favoriteService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Favorite not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /favorite/:id
   * Updates an existing Favorite.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await favoriteService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Favorite not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: FavoritePlainInputUpdate
  })

  /**
   * DELETE /favorite/:id
   * Deletes a Favorite.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await favoriteService.delete(params.id);
      return { success: true, message: "Favorite deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Favorite not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
