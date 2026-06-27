import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { categoryService } from "../services/category";
import { 
  CategoryPlainInputCreate, 
  CategoryPlainInputUpdate 
} from "../../generated/prismabox/Category";
import { regionMiddleware } from "../middleware/region";

export const categoryRoutes = new Elysia({ prefix: "/categories" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /category
   * Retrieves all Category with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return categoryService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await categoryService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: CategoryPlainInputCreate
  })

  /**
   * GET /category/:id
   * Retrieves a single Category by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await categoryService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await categoryService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await categoryService.withDB(db as any).delete(params.id);
      return { success: true, message: "Category deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Category not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
