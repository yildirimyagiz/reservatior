import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { identityDocumentService } from "../services/identitydocument";
import { 
  IdentityDocumentPlainInputCreate, 
  IdentityDocumentPlainInputUpdate 
} from "../../generated/prismabox/IdentityDocument";

export const identityDocumentRoutes = new Elysia({ prefix: "/identity-document" })
  .use(authMiddleware)

  /**
   * GET /identity-document
   * Retrieves all IdentityDocument with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return identityDocumentService.getAll({
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
   * POST /identity-document
   * Creates a new IdentityDocument.
   */
  .post("/", async ({ body, set }) => {
    const data = await identityDocumentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: IdentityDocumentPlainInputCreate
  })

  /**
   * GET /identity-document/:id
   * Retrieves a single IdentityDocument by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await identityDocumentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "IdentityDocument not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /identity-document/:id
   * Updates an existing IdentityDocument.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await identityDocumentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "IdentityDocument not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: IdentityDocumentPlainInputUpdate
  })

  /**
   * DELETE /identity-document/:id
   * Deletes a IdentityDocument.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await identityDocumentService.delete(params.id);
      return { success: true, message: "IdentityDocument deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "IdentityDocument not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
