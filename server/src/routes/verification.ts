import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { verificationService } from "../services/verification";
import { 
  VerificationPlainInputCreate, 
  VerificationPlainInputUpdate 
} from "../../generated/prismabox/Verification";
import { regionMiddleware } from "../middleware/region";

export const verificationRoutes = new Elysia({ prefix: "/verification" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /verification
   * Retrieves all Verification with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return verificationService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await verificationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VerificationPlainInputCreate
  })

  /**
   * GET /verification/:id
   * Retrieves a single Verification by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await verificationService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await verificationService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await verificationService.withDB(db as any).delete(params.id);
      return { success: true, message: "Verification deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Verification not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
