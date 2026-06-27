import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { securityDepositProtectionService } from "../services/securitydepositprotection";
import { 
  SecurityDepositProtectionPlainInputCreate, 
  SecurityDepositProtectionPlainInputUpdate 
} from "../../generated/prismabox/SecurityDepositProtection";

export const securityDepositProtectionRoutes = new Elysia({ prefix: "/security-deposit-protections" })
  .use(authMiddleware)

  /**
   * GET /security-deposit-protection
   * Retrieves all SecurityDepositProtection with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return securityDepositProtectionService.getAll({
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
   * POST /security-deposit-protection
   * Creates a new SecurityDepositProtection.
   */
  .post("/", async ({ body, set }) => {
    const data = await securityDepositProtectionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SecurityDepositProtectionPlainInputCreate
  })

  /**
   * GET /security-deposit-protection/:id
   * Retrieves a single SecurityDepositProtection by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await securityDepositProtectionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SecurityDepositProtection not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /security-deposit-protection/:id
   * Updates an existing SecurityDepositProtection.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await securityDepositProtectionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SecurityDepositProtection not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SecurityDepositProtectionPlainInputUpdate
  })

  /**
   * DELETE /security-deposit-protection/:id
   * Deletes a SecurityDepositProtection.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await securityDepositProtectionService.delete(params.id);
      return { success: true, message: "SecurityDepositProtection deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SecurityDepositProtection not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
