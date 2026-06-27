import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { depositProtectionService } from "../services/depositprotection";
import { 
  DepositProtectionPlainInputCreate, 
  DepositProtectionPlainInputUpdate 
} from "../../generated/prismabox/DepositProtection";
import { regionMiddleware } from "../middleware/region";

export const depositProtectionRoutes = new Elysia({ prefix: "/deposit-protections" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /deposit-protection
   * Retrieves all DepositProtection with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return depositProtectionService.withDB(db as any).getAll({
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
   * POST /deposit-protection
   * Creates a new DepositProtection.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await depositProtectionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: DepositProtectionPlainInputCreate
  })

  /**
   * GET /deposit-protection/:id
   * Retrieves a single DepositProtection by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await depositProtectionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "DepositProtection not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /deposit-protection/:id
   * Updates an existing DepositProtection.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await depositProtectionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "DepositProtection not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DepositProtectionPlainInputUpdate
  })

  /**
   * DELETE /deposit-protection/:id
   * Deletes a DepositProtection.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await depositProtectionService.withDB(db as any).delete(params.id);
      return { success: true, message: "DepositProtection deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "DepositProtection not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
