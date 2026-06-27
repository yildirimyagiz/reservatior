import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyDocumentService } from "../services/propertydocument";
import { 
  PropertyDocumentPlainInputCreate, 
  PropertyDocumentPlainInputUpdate 
} from "../../generated/prismabox/PropertyDocument";

export const propertyDocumentRoutes = new Elysia({ prefix: "/property-document" })
  .use(authMiddleware)

  /**
   * GET /property-document
   * Retrieves all PropertyDocument with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyDocumentService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await propertyDocumentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyDocumentPlainInputCreate
  })

  /**
   * GET /property-document/:id
   * Retrieves a single PropertyDocument by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyDocumentService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyDocumentService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyDocumentService.delete(params.id);
      return { success: true, message: "PropertyDocument deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyDocument not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
