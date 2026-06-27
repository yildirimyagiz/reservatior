import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialAutomationRuleService } from "../services/socialautomationrule";
import { 
  SocialAutomationRulePlainInputCreate, 
  SocialAutomationRulePlainInputUpdate 
} from "../../generated/prismabox/SocialAutomationRule";

export const socialAutomationRuleRoutes = new Elysia({ prefix: "/social-automationrule" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return socialAutomationRuleService.getAll({
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

  .post("/", async ({ body, set }) => {
    const data = await socialAutomationRuleService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialAutomationRulePlainInputCreate
  })

  .get("/:id", async ({ params, set }) => {
    const data = await socialAutomationRuleService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialAutomationRule not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await socialAutomationRuleService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialAutomationRule not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialAutomationRulePlainInputUpdate
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await socialAutomationRuleService.delete(params.id);
      return { success: true, message: "SocialAutomationRule deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialAutomationRule not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
