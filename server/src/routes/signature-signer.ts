import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { signatureSignerService } from "../services/signaturesigner";
import { 
  SignatureSignerPlainInputCreate, 
  SignatureSignerPlainInputUpdate 
} from "../../generated/prismabox/SignatureSigner";

export const signatureSignerRoutes = new Elysia({ prefix: "/signature-signers" })
  .use(authMiddleware)

  /**
   * GET /signature-signer
   * Retrieves all SignatureSigner with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return signatureSignerService.getAll({
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
   * POST /signature-signer
   * Creates a new SignatureSigner.
   */
  .post("/", async ({ body, set }) => {
    const data = await signatureSignerService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SignatureSignerPlainInputCreate
  })

  /**
   * GET /signature-signer/:id
   * Retrieves a single SignatureSigner by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await signatureSignerService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SignatureSigner not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /signature-signer/:id
   * Updates an existing SignatureSigner.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await signatureSignerService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SignatureSigner not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SignatureSignerPlainInputUpdate
  })

  /**
   * DELETE /signature-signer/:id
   * Deletes a SignatureSigner.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await signatureSignerService.delete(params.id);
      return { success: true, message: "SignatureSigner deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SignatureSigner not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
