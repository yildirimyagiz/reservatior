import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { postService } from "../services/post";
import { 
  PostPlainInputCreate, 
  PostPlainInputUpdate 
} from "../../generated/prismabox/Post";

export const postRoutes = new Elysia({ prefix: "/posts" })
  .use(authMiddleware)

  /**
   * GET /post
   * Retrieves all Post with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return postService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await postService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PostPlainInputCreate
  })

  /**
   * GET /post/:id
   * Retrieves a single Post by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await postService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await postService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await postService.delete(params.id);
      return { success: true, message: "Post deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Post not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
