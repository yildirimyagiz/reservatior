import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { documentTemplateService } from "../services/documenttemplate";
import { 
  DocumentTemplatePlainInputCreate, 
  DocumentTemplatePlainInputUpdate 
} from "../../generated/prismabox/DocumentTemplate";
import { regionMiddleware } from "../middleware/region";

export const documentTemplateRoutes = new Elysia({ prefix: "/document-templates" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /document-template
   * Retrieves all DocumentTemplate with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return documentTemplateService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await documentTemplateService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: DocumentTemplatePlainInputCreate
  })

  /**
   * GET /document-template/:id
   * Retrieves a single DocumentTemplate by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await documentTemplateService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await documentTemplateService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await documentTemplateService.withDB(db as any).delete(params.id);
      return { success: true, message: "DocumentTemplate deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "DocumentTemplate not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
