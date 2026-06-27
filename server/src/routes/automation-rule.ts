import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { automationRuleService } from "../services/automationrule";
import { 
  AutomationRulePlainInputCreate, 
  AutomationRulePlainInputUpdate 
} from "../../generated/prismabox/AutomationRule";

export const automationRuleRoutes = new Elysia({ prefix: "/automation-rules" })
  .use(authMiddleware)

  /**
   * GET /automation-rule
   * Retrieves all AutomationRule with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return automationRuleService.getAll({
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
   * POST /automation-rule
   * Creates a new AutomationRule.
   */
  .post("/", async ({ body, set }) => {
    const data = await automationRuleService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AutomationRulePlainInputCreate
  })

  /**
   * GET /automation-rule/:id
   * Retrieves a single AutomationRule by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await automationRuleService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AutomationRule not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /automation-rule/:id
   * Updates an existing AutomationRule.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await automationRuleService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationRule not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AutomationRulePlainInputUpdate
  })

  /**
   * DELETE /automation-rule/:id
   * Deletes a AutomationRule.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await automationRuleService.delete(params.id);
      return { success: true, message: "AutomationRule deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AutomationRule not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
