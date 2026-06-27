import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { categoryTranslationService } from "../services/categorytranslation";
import { 
  CategoryTranslationPlainInputCreate, 
  CategoryTranslationPlainInputUpdate 
} from "../../generated/prismabox/CategoryTranslation";
import { regionMiddleware } from "../middleware/region";

export const categoryTranslationRoutes = new Elysia({ prefix: "/category-translation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /category-translation
   * Retrieves all CategoryTranslation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return categoryTranslationService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /category-translation
   * Creates a new CategoryTranslation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await categoryTranslationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: CategoryTranslationPlainInputCreate
  })

  /**
   * GET /category-translation/:id
   * Retrieves a single CategoryTranslation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await categoryTranslationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "CategoryTranslation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /category-translation/:id
   * Updates an existing CategoryTranslation.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await categoryTranslationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "CategoryTranslation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CategoryTranslationPlainInputUpdate
  })

  /**
   * DELETE /category-translation/:id
   * Deletes a CategoryTranslation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await categoryTranslationService.withDB(db as any).delete(params.id);
      return { success: true, message: "CategoryTranslation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "CategoryTranslation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
