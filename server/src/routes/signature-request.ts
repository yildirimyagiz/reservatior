import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { signatureRequestService } from "../services/signaturerequest";
import { 
  SignatureRequestPlainInputCreate, 
  SignatureRequestPlainInputUpdate 
} from "../../generated/prismabox/SignatureRequest";

export const signatureRequestRoutes = new Elysia({ prefix: "/signature-requests" })
  .use(authMiddleware)

  /**
   * GET /signature-request
   * Retrieves all SignatureRequest with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return signatureRequestService.getAll({
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
   * POST /signature-request
   * Creates a new SignatureRequest.
   */
  .post("/", async ({ body, set }) => {
    const data = await signatureRequestService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SignatureRequestPlainInputCreate
  })

  /**
   * GET /signature-request/:id
   * Retrieves a single SignatureRequest by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await signatureRequestService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SignatureRequest not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /signature-request/:id
   * Updates an existing SignatureRequest.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await signatureRequestService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SignatureRequest not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SignatureRequestPlainInputUpdate
  })

  /**
   * DELETE /signature-request/:id
   * Deletes a SignatureRequest.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await signatureRequestService.delete(params.id);
      return { success: true, message: "SignatureRequest deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SignatureRequest not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
