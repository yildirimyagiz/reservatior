import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyComplianceService } from "../services/propertycompliance";
import { 
  PropertyCompliancePlainInputCreate, 
  PropertyCompliancePlainInputUpdate 
} from "../../generated/prismabox/PropertyCompliance";
import { regionMiddleware } from "../middleware/region";

export const propertyComplianceRoutes = new Elysia({ prefix: "/property-compliance" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-compliance
   * Retrieves all PropertyCompliance with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyComplianceService.withDB(db as any).getAll({
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
   * POST /property-compliance
   * Creates a new PropertyCompliance.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyComplianceService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyCompliancePlainInputCreate
  })

  /**
   * GET /property-compliance/:id
   * Retrieves a single PropertyCompliance by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyComplianceService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyCompliance not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-compliance/:id
   * Updates an existing PropertyCompliance.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyComplianceService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyCompliance not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyCompliancePlainInputUpdate
  })

  /**
   * DELETE /property-compliance/:id
   * Deletes a PropertyCompliance.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyComplianceService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyCompliance deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyCompliance not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
