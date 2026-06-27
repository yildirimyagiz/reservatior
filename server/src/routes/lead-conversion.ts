import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leadConversionService } from "../services/leadconversion";
import { 
  LeadConversionPlainInputCreate, 
  LeadConversionPlainInputUpdate 
} from "../../generated/prismabox/LeadConversion";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const leadConversionRoutes = new Elysia({ prefix: "/lead-conversion" })
  .use(authMiddleware)

  /**
   * GET /lead-conversion
   * Retrieves all LeadConversion with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return leadConversionService.getAll({
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
   * POST /lead-conversion
   * Creates a new LeadConversion.
   */
  .post("/", async ({ body, set }) => {
    const data = await leadConversionService.create(body);
    
    // ML Feedback Loop: Lead Converted -> Reward Agent Performance
    if (data.convertedByUserId) {
      MLBridgeService.sendFeedback("agent-performance", "LEAD_CONVERTED", 5.0, {
        conversionId: data.id,
        leadId: data.leadId,
        agentId: data.convertedByUserId,
        revenue: data.revenueAmount
      }).catch(console.error);
    }

    set.status = 201;
    return { data };
  }, {
    body: LeadConversionPlainInputCreate
  })

  /**
   * GET /lead-conversion/:id
   * Retrieves a single LeadConversion by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await leadConversionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LeadConversion not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /lead-conversion/:id
   * Updates an existing LeadConversion.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await leadConversionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LeadConversion not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LeadConversionPlainInputUpdate
  })

  /**
   * DELETE /lead-conversion/:id
   * Deletes a LeadConversion.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await leadConversionService.delete(params.id);
      return { success: true, message: "LeadConversion deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LeadConversion not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
