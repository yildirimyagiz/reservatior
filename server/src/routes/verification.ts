import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { verificationService } from "../services/verification";
import { 
  VerificationPlainInputCreate, 
  VerificationPlainInputUpdate 
} from "../../generated/prismabox/Verification";

export const verificationRoutes = new Elysia({ prefix: "/verification" })
  .use(authMiddleware)

  /**
   * GET /verification
   * Retrieves all Verification with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return verificationService.getAll({
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
   * POST /verification
   * Creates a new Verification.
   */
  .post("/", async ({ body, set }) => {
    const data = await verificationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VerificationPlainInputCreate
  })

  /**
   * GET /verification/:id
   * Retrieves a single Verification by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await verificationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Verification not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /verification/:id
   * Updates an existing Verification.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await verificationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Verification not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VerificationPlainInputUpdate
  })

  /**
   * DELETE /verification/:id
   * Deletes a Verification.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await verificationService.delete(params.id);
      return { success: true, message: "Verification deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Verification not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
