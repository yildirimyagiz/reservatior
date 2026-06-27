import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { legalComplianceService } from "../services/legalcompliance";
import { 
  LegalCompliancePlainInputCreate, 
  LegalCompliancePlainInputUpdate 
} from "../../generated/prismabox/LegalCompliance";
import { regionMiddleware } from "../middleware/region";

export const legalComplianceRoutes = new Elysia({ prefix: "/legal-compliance" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /legal-compliance
   * Retrieves all LegalCompliance with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return legalComplianceService.withDB(db as any).getAll({
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
   * POST /legal-compliance
   * Creates a new LegalCompliance.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await legalComplianceService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: LegalCompliancePlainInputCreate
  })

  /**
   * GET /legal-compliance/:id
   * Retrieves a single LegalCompliance by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await legalComplianceService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LegalCompliance not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /legal-compliance/:id
   * Updates an existing LegalCompliance.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await legalComplianceService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LegalCompliance not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LegalCompliancePlainInputUpdate
  })

  /**
   * DELETE /legal-compliance/:id
   * Deletes a LegalCompliance.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await legalComplianceService.withDB(db as any).delete(params.id);
      return { success: true, message: "LegalCompliance deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LegalCompliance not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
