import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { pricingRuleService } from "../services/pricingrule";
import { 
  PricingRulePlainInputCreate, 
  PricingRulePlainInputUpdate 
} from "../../generated/prismabox/PricingRule";
import { regionMiddleware } from "../middleware/region";

export const pricingRuleRoutes = new Elysia({ prefix: "/pricing-rules" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /pricing-rule
   * Retrieves all PricingRule with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return pricingRuleService.withDB(db as any).getAll({
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
   * POST /pricing-rule
   * Creates a new PricingRule.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await pricingRuleService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PricingRulePlainInputCreate
  })

  /**
   * GET /pricing-rule/:id
   * Retrieves a single PricingRule by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await pricingRuleService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PricingRule not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /pricing-rule/:id
   * Updates an existing PricingRule.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await pricingRuleService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PricingRule not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PricingRulePlainInputUpdate
  })

  /**
   * DELETE /pricing-rule/:id
   * Deletes a PricingRule.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await pricingRuleService.withDB(db as any).delete(params.id);
      return { success: true, message: "PricingRule deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PricingRule not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
