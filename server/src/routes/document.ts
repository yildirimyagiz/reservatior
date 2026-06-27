import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { documentService } from "../services/document";
import { 
  DocumentPlainInputCreate, 
  DocumentPlainInputUpdate 
} from "../../generated/prismabox/Document";
import { regionMiddleware } from "../middleware/region";

export const documentRoutes = new Elysia({ prefix: "/legal/documents" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /document
   * Retrieves all Document with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return documentService.withDB(db as any).getAll({
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
   * POST /document
   * Creates a new Document.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await documentService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: DocumentPlainInputCreate
  })

  /**
   * GET /document/:id
   * Retrieves a single Document by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await documentService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Document not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /document/:id
   * Updates an existing Document.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await documentService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Document not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DocumentPlainInputUpdate
  })

  /**
   * DELETE /document/:id
   * Deletes a Document.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await documentService.withDB(db as any).delete(params.id);
      return { success: true, message: "Document deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Document not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
