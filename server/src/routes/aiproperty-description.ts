import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { aIPropertyDescriptionService } from "../services/aipropertydescription";
import { 
  AIPropertyDescriptionPlainInputCreate, 
  AIPropertyDescriptionPlainInputUpdate 
} from "../../generated/prismabox/AIPropertyDescription";

export const aipropertyDescriptionRoutes = new Elysia({ prefix: "/ai-property-descriptions" })
  .use(authMiddleware)

  /**
   * GET /aiproperty-description
   * Retrieves all AIPropertyDescription with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return aIPropertyDescriptionService.getAll({
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
   * POST /aiproperty-description
   * Creates a new AIPropertyDescription.
   */
  .post("/", async ({ body, set }) => {
    const data = await aIPropertyDescriptionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AIPropertyDescriptionPlainInputCreate
  })

  /**
   * GET /aiproperty-description/:id
   * Retrieves a single AIPropertyDescription by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await aIPropertyDescriptionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AIPropertyDescription not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /aiproperty-description/:id
   * Updates an existing AIPropertyDescription.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await aIPropertyDescriptionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AIPropertyDescription not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AIPropertyDescriptionPlainInputUpdate
  })

  /**
   * DELETE /aiproperty-description/:id
   * Deletes a AIPropertyDescription.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await aIPropertyDescriptionService.delete(params.id);
      return { success: true, message: "AIPropertyDescription deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AIPropertyDescription not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
