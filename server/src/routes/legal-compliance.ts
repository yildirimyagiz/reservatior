import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { legalComplianceService } from "../services/legalcompliance";
import { 
  LegalCompliancePlainInputCreate, 
  LegalCompliancePlainInputUpdate 
} from "../../generated/prismabox/LegalCompliance";

export const legalComplianceRoutes = new Elysia({ prefix: "/legal-compliance" })
  .use(authMiddleware)

  /**
   * GET /legal-compliance
   * Retrieves all LegalCompliance with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return legalComplianceService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await legalComplianceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LegalCompliancePlainInputCreate
  })

  /**
   * GET /legal-compliance/:id
   * Retrieves a single LegalCompliance by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await legalComplianceService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await legalComplianceService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await legalComplianceService.delete(params.id);
      return { success: true, message: "LegalCompliance deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LegalCompliance not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
