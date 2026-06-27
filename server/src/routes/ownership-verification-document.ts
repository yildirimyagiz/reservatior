import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ownershipVerificationDocumentService } from "../services/ownershipverificationdocument";
import { 
  OwnershipVerificationDocumentPlainInputCreate, 
  OwnershipVerificationDocumentPlainInputUpdate 
} from "../../generated/prismabox/OwnershipVerificationDocument";

export const ownershipVerificationDocumentRoutes = new Elysia({ prefix: "/ownership-verification-document" })
  .use(authMiddleware)

  /**
   * GET /ownership-verification-document
   * Retrieves all OwnershipVerificationDocument with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return ownershipVerificationDocumentService.getAll({
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
   * POST /ownership-verification-document
   * Creates a new OwnershipVerificationDocument.
   */
  .post("/", async ({ body, set }) => {
    const data = await ownershipVerificationDocumentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: OwnershipVerificationDocumentPlainInputCreate
  })

  /**
   * GET /ownership-verification-document/:id
   * Retrieves a single OwnershipVerificationDocument by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await ownershipVerificationDocumentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "OwnershipVerificationDocument not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ownership-verification-document/:id
   * Updates an existing OwnershipVerificationDocument.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await ownershipVerificationDocumentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "OwnershipVerificationDocument not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: OwnershipVerificationDocumentPlainInputUpdate
  })

  /**
   * DELETE /ownership-verification-document/:id
   * Deletes a OwnershipVerificationDocument.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await ownershipVerificationDocumentService.delete(params.id);
      return { success: true, message: "OwnershipVerificationDocument deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "OwnershipVerificationDocument not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
