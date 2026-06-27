import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { tenantService } from "../services/tenant";
import { 
  TenantPlainInputCreate, 
  TenantPlainInputUpdate 
} from "../../generated/prismabox/Tenant";
import { regionMiddleware } from "../middleware/region";

export const tenantRoutes = new Elysia({ prefix: "/tenants" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /tenant
   * Retrieves all Tenant with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return tenantService.withDB(db as any).getAll({
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
   * POST /tenant
   * Creates a new Tenant.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await tenantService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: TenantPlainInputCreate
  })

  /**
   * GET /tenant/:id
   * Retrieves a single Tenant by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await tenantService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Tenant not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /tenant/:id
   * Updates an existing Tenant.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await tenantService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TenantPlainInputUpdate
  })

  /**
   * DELETE /tenant/:id
   * Deletes a Tenant.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await tenantService.withDB(db as any).delete(params.id);
      return { success: true, message: "Tenant deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /tenant/:id/calculate-score
   * Calculates and updates tenant credit score based on payment history, income, etc.
   */
  .post("/:id/calculate-score", async ({ orgId, db, params, set }) => {
    try {
      const data = await tenantService.withDB(db as any).calculateScore(params.id);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found or score calculation failed" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * GET /tenant/:id/score
   * Retrieves tenant's current score and risk assessment.
   */
  .get("/:id/score", async ({ orgId, db, params, set }) => {
    try {
      const data = await tenantService.withDB(db as any).getScore(params.id);
      if (!data) {
        set.status = 404;
        return { error: "Tenant score not found" };
      }
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  .get("/:id/compliance", async ({ orgId, db, params, set }) => {
    try {
      const tenant = await tenantService.withDB(db as any).getById(params.id);
      if (!tenant) {
        set.status = 404;
        return { error: "Tenant not found" };
      }
      return { data: tenant };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id/compliance", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await tenantService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      rightToRentCheck: t.Optional(t.Boolean()),
      rightToRentExpiry: t.Optional(t.String()),
      immigrationCheck: t.Optional(t.Boolean()),
      immigrationExpiry: t.Optional(t.String()),
      propertyCompliance: t.Optional(t.Boolean()),
      propertyComplianceExpiry: t.Optional(t.String()),
      gasSafetyCheck: t.Optional(t.Boolean()),
      gasSafetyExpiry: t.Optional(t.String()),
      fireSafetyCheck: t.Optional(t.Boolean()),
      fireSafetyExpiry: t.Optional(t.String()),
      energyCertificate: t.Optional(t.Boolean()),
      energyCertificateExpiry: t.Optional(t.String()),
    })
  })

  .post("/:id/calculate-compliance-score", async ({ orgId, db, params, set }) => {
    try {
      const data = await tenantService.withDB(db as any).calculateScore(params.id);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Tenant not found or score calculation failed" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
