import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyDocumentService } from "../services/propertydocument";
import { 
  PropertyDocumentPlainInputCreate, 
  PropertyDocumentPlainInputUpdate 
} from "../../generated/prismabox/PropertyDocument";
import { regionMiddleware } from "../middleware/region";

export const propertyDocumentRoutes = new Elysia({ prefix: "/property-document" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-document
   * Retrieves all PropertyDocument with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyDocumentService.withDB(db as any).getAll({
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
   * POST /property-document
   * Creates a new PropertyDocument.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyDocumentService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyDocumentPlainInputCreate
  })

  /**
   * GET /property-document/:id
   * Retrieves a single PropertyDocument by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyDocumentService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyDocument not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-document/:id
   * Updates an existing PropertyDocument.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyDocumentService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyDocument not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyDocumentPlainInputUpdate
  })

  /**
   * DELETE /property-document/:id
   * Deletes a PropertyDocument.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyDocumentService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyDocument deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyDocument not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
