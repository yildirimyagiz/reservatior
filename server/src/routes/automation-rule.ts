import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { automationRuleService } from "../services/automationrule";
import { triggerEngine } from "../services/trigger-engine";
import {
  AutomationRulePlainInputCreate,
  AutomationRulePlainInputUpdate,
} from "../../generated/prismabox/AutomationRule";
import { regionMiddleware } from "../middleware/region";

export const automationRuleRoutes = new Elysia({ prefix: "/automation-rules" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return automationRuleService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    })),
  })

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await automationRuleService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AutomationRulePlainInputCreate,
  })

  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await prisma.automationRule.findUnique({
      where: { id: params.id },
      include: {
        executions: {
          orderBy: { executedAt: "desc" },
          take: 20,
        },
        notificationTemplate: true,
        chainRule: { select: { id: true, ruleName: true } },
      },
    });
    if (!data) {
      set.status = 404;
      return { error: "AutomationRule not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
  })

  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await automationRuleService.withDB(db as any).update(params.id, body);
      return { data };
    } catch {
      set.status = 404;
      return { error: "AutomationRule not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AutomationRulePlainInputUpdate,
  })

  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await automationRuleService.withDB(db as any).delete(params.id);
      return { success: true, message: "AutomationRule deleted successfully" };
    } catch {
      set.status = 404;
      return { error: "AutomationRule not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() }),
  })

  .post("/:id/trigger", async ({ orgId, db, params, body, set }) => {
    const rule = await prisma.automationRule.findUnique({
      where: { id: params.id, isActive: true },
    });
    if (!rule) {
      set.status = 404;
      return { error: "Rule not found or inactive" };
    }

    const payload = (body as any)?.payload || {};
    const event = await prisma.systemEvent.create({
      data: {
        orgId: rule.orgId,
        eventType: "CUSTOM",
        source: "manual_trigger",
        payload,
        metadata: { ruleId: rule.id, ruleName: rule.ruleName },
      },
    });

    const ruleExec = await (triggerEngine as any).executeRule(rule, event, payload);
    return { data: { event, execution: ruleExec } };
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Optional(t.Object({ payload: t.Optional(t.Any()) })),
  });
