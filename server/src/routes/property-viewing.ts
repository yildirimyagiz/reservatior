import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyViewingService } from "../services/propertyviewing";
import { 
  PropertyViewingPlainInputCreate, 
  PropertyViewingPlainInputUpdate 
} from "../../generated/prismabox/PropertyViewing";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const propertyViewingRoutes = new Elysia({ prefix: "/property-viewing" })
  .use(authMiddleware)

  /**
   * GET /property-viewing
   * Retrieves all PropertyViewing with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyViewingService.getAll({
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
   * POST /property-viewing
   * Creates a new PropertyViewing.
   */
  .post("/", async ({ body, set }) => {
    const data = await propertyViewingService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyViewingPlainInputCreate
  })

  /**
   * GET /property-viewing/:id
   * Retrieves a single PropertyViewing by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyViewingService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyViewing not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-viewing/:id
   * Updates an existing PropertyViewing.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const oldData = await propertyViewingService.getById(params.id);
      const data = await propertyViewingService.update(params.id, body);

      // ML Feedback Loop: Viewing Demand Signal -> Pricing Adjustment
      if (oldData && oldData.status !== 'COMPLETED' && (body as any).status === 'COMPLETED') {
        const interest = (body as any).interestedLevel || data.interestedLevel;
        if (interest === 'HIGH') {
          MLBridgeService.sendFeedback("pricing-bandit", "VIEWING_HIGH_INTEREST", 1.0, {
            viewingId: data.id,
            propertyId: data.propertyId
          }).catch(console.error);
        } else if (interest === 'LOW') {
          MLBridgeService.sendFeedback("pricing-bandit", "VIEWING_LOW_INTEREST", -1.0, {
            viewingId: data.id,
            propertyId: data.propertyId
          }).catch(console.error);
        }
      }

      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyViewing not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyViewingPlainInputUpdate
  })

  /**
   * DELETE /property-viewing/:id
   * Deletes a PropertyViewing.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyViewingService.delete(params.id);
      return { success: true, message: "PropertyViewing deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyViewing not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
