import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { tenantApplicationService } from "../services/tenantapplication";
import { 
  TenantApplicationPlainInputCreate, 
  TenantApplicationPlainInputUpdate 
} from "../../generated/prismabox/TenantApplication";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const tenantApplicationRoutes = new Elysia({ prefix: "/tenant-applications" })
  .use(authMiddleware)

  /**
   * GET /tenant-application
   * Retrieves all TenantApplication with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return tenantApplicationService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /tenant-application
   * Creates a new TenantApplication.
   */
  .post("/", async ({ body, set }) => {
    const data = await tenantApplicationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TenantApplicationPlainInputCreate
  })

  /**
   * GET /tenant-application/:id
   * Retrieves a single TenantApplication by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await tenantApplicationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "TenantApplication not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /tenant-application/:id
   * Updates an existing TenantApplication.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const oldData = await tenantApplicationService.getById(params.id);
      const data = await tenantApplicationService.update(params.id, body);

      // ML Feedback Loop: Application Rejected -> Underwriting Penalty
      if (oldData && oldData.status !== 'REJECTED' && (body as any).status === 'REJECTED') {
        MLBridgeService.sendFeedback("tenant-screening", "APPLICATION_REJECTED", -2.0, {
          applicationId: data.id,
          applicantId: data.applicantId,
          propertyId: data.propertyId
        }).catch(console.error);
      }

      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "TenantApplication not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TenantApplicationPlainInputUpdate
  })

  /**
   * DELETE /tenant-application/:id
   * Deletes a TenantApplication.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await tenantApplicationService.delete(params.id);
      return { success: true, message: "TenantApplication deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "TenantApplication not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
