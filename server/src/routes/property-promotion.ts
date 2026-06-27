import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyPromotionService } from "../services/propertypromotion";
import { 
  PropertyPromotionPlainInputCreate, 
  PropertyPromotionPlainInputUpdate 
} from "../../generated/prismabox/PropertyPromotion";

export const propertyPromotionRoutes = new Elysia({ prefix: "/property-promotion" })
  .use(authMiddleware)

  /**
   * GET /property-promotion
   * Retrieves all PropertyPromotion with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyPromotionService.getAll({
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
   * POST /property-promotion
   * Creates a new PropertyPromotion.
   */
  .post("/", async ({ body, set }) => {
    const data = await propertyPromotionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyPromotionPlainInputCreate
  })

  /**
   * POST /property-promotion/purchase
   * Specialized endpoint for agents to purchase doping.
   */
  .post("/purchase", async ({ body }) => {
    const { propertyId, agencyId, agentId, promotionType, days, price, isAutoRenew } = body as any;
    
    const startDate = new Date();
    const endDate = new Date();
    endDate.setDate(startDate.getDate() + days);

    // Creates the promotion and audit logs it
    const promotion = await propertyPromotionService.create({
      propertyId,
      agencyId,
      agentId,
      promotionType,
      startDate,
      endDate,
      price,
      isAutoRenew: isAutoRenew || false,
      status: "ACTIVE"
    });

    // We can directly call prisma manager here for audit log since it's an API specific action
    const db = require("../lib/prisma").prismaManager.getClient();
    await db.auditLog.create({
      data: {
        action: "PROMOTION_PURCHASED",
        entityType: "PropertyPromotion",
        entityId: promotion.id,
        newValues: { details: `Property ${propertyId} promoted for ${days} days. Type: ${promotionType}, Price: ${price}` },
        orgId: "system"
      }
    });

    return { success: true, promotion };
  }, {
    body: t.Object({
      propertyId: t.String(),
      agencyId: t.Optional(t.String()),
      agentId: t.Optional(t.String()),
      promotionType: t.String(),
      days: t.Number(),
      price: t.Number(),
      isAutoRenew: t.Optional(t.Boolean())
    })
  })

  /**
   * GET /property-promotion/:id
   * Retrieves a single PropertyPromotion by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyPromotionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyPromotion not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-promotion/:id
   * Updates an existing PropertyPromotion.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyPromotionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyPromotion not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyPromotionPlainInputUpdate
  })

  /**
   * DELETE /property-promotion/:id
   * Deletes a PropertyPromotion.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyPromotionService.delete(params.id);
      return { success: true, message: "PropertyPromotion deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyPromotion not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
