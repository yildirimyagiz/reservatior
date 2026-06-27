import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { categoryService } from "../services/category";
import { 
  CategoryPlainInputCreate, 
  CategoryPlainInputUpdate 
} from "../../generated/prismabox/Category";

export const categoryRoutes = new Elysia({ prefix: "/categories" })
  .use(authMiddleware)

  /**
   * GET /category
   * Retrieves all Category with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return categoryService.getAll({
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
   * POST /category
   * Creates a new Category.
   */
  .post("/", async ({ body, set }) => {
    const data = await categoryService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: CategoryPlainInputCreate
  })

  /**
   * GET /category/:id
   * Retrieves a single Category by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await categoryService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Category not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /category/:id
   * Updates an existing Category.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await categoryService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Category not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CategoryPlainInputUpdate
  })

  /**
   * DELETE /category/:id
   * Deletes a Category.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await categoryService.delete(params.id);
      return { success: true, message: "Category deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Category not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
