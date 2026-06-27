import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { languageService } from "../services/language";
import { 
  LanguagePlainInputCreate, 
  LanguagePlainInputUpdate 
} from "../../generated/prismabox/Language";

export const languageRoutes = new Elysia({ prefix: "/system/languages" })
  .use(authMiddleware)

  /**
   * GET /language
   * Retrieves all Language with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return languageService.getAll({
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
   * POST /language
   * Creates a new Language.
   */
  .post("/", async ({ body, set }) => {
    const data = await languageService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LanguagePlainInputCreate
  })

  /**
   * GET /language/:id
   * Retrieves a single Language by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await languageService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Language not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /language/:id
   * Updates an existing Language.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await languageService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Language not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LanguagePlainInputUpdate
  })

  /**
   * DELETE /language/:id
   * Deletes a Language.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await languageService.delete(params.id);
      return { success: true, message: "Language deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Language not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
