import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { tagService } from "../services/tag";
import { 
  TagPlainInputCreate, 
  TagPlainInputUpdate 
} from "../../generated/prismabox/Tag";

export const tagRoutes = new Elysia({ prefix: "/tag" })
  .use(authMiddleware)

  /**
   * GET /tag
   * Retrieves all Tag with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return tagService.getAll({
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
   * POST /tag
   * Creates a new Tag.
   */
  .post("/", async ({ body, set }) => {
    const data = await tagService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TagPlainInputCreate
  })

  /**
   * GET /tag/:id
   * Retrieves a single Tag by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await tagService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Tag not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /tag/:id
   * Updates an existing Tag.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await tagService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tag not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TagPlainInputUpdate
  })

  /**
   * DELETE /tag/:id
   * Deletes a Tag.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await tagService.delete(params.id);
      return { success: true, message: "Tag deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Tag not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
