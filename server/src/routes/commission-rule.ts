import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { commissionRuleService } from "../services/commissionrule";
import { 
  CommissionRulePlainInputCreate, 
  CommissionRulePlainInputUpdate 
} from "../../generated/prismabox/CommissionRule";

export const commissionRuleRoutes = new Elysia({ prefix: "/financials/commission-rules" })
  .use(authMiddleware)

  /**
   * GET /commission-rule
   * Retrieves all CommissionRule with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return commissionRuleService.getAll({
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
   * POST /commission-rule
   * Creates a new CommissionRule.
   */
  .post("/", async ({ body, set }) => {
    const data = await commissionRuleService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: CommissionRulePlainInputCreate
  })

  /**
   * GET /commission-rule/:id
   * Retrieves a single CommissionRule by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await commissionRuleService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "CommissionRule not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /commission-rule/:id
   * Updates an existing CommissionRule.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await commissionRuleService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "CommissionRule not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: CommissionRulePlainInputUpdate
  })

  /**
   * DELETE /commission-rule/:id
   * Deletes a CommissionRule.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await commissionRuleService.delete(params.id);
      return { success: true, message: "CommissionRule deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "CommissionRule not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
