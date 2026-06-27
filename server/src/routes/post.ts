import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { postService } from "../services/post";
import { 
  PostPlainInputCreate, 
  PostPlainInputUpdate 
} from "../../generated/prismabox/Post";
import { regionMiddleware } from "../middleware/region";

export const postRoutes = new Elysia({ prefix: "/posts" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /post
   * Retrieves all Post with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return postService.withDB(db as any).getAll({
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
   * POST /post
   * Creates a new Post.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await postService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PostPlainInputCreate
  })

  /**
   * GET /post/:id
   * Retrieves a single Post by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await postService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Post not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /post/:id
   * Updates an existing Post.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await postService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Post not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PostPlainInputUpdate
  })

  /**
   * DELETE /post/:id
   * Deletes a Post.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await postService.withDB(db as any).delete(params.id);
      return { success: true, message: "Post deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Post not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
