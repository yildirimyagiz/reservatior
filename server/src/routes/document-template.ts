import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { documentTemplateService } from "../services/documenttemplate";
import { 
  DocumentTemplatePlainInputCreate, 
  DocumentTemplatePlainInputUpdate 
} from "../../generated/prismabox/DocumentTemplate";

export const documentTemplateRoutes = new Elysia({ prefix: "/document-templates" })
  .use(authMiddleware)

  /**
   * GET /document-template
   * Retrieves all DocumentTemplate with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return documentTemplateService.getAll({
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
   * POST /document-template
   * Creates a new DocumentTemplate.
   */
  .post("/", async ({ body, set }) => {
    const data = await documentTemplateService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: DocumentTemplatePlainInputCreate
  })

  /**
   * GET /document-template/:id
   * Retrieves a single DocumentTemplate by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await documentTemplateService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "DocumentTemplate not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /document-template/:id
   * Updates an existing DocumentTemplate.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await documentTemplateService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "DocumentTemplate not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DocumentTemplatePlainInputUpdate
  })

  /**
   * DELETE /document-template/:id
   * Deletes a DocumentTemplate.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await documentTemplateService.delete(params.id);
      return { success: true, message: "DocumentTemplate deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "DocumentTemplate not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
