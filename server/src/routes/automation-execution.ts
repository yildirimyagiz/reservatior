import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { regionMiddleware } from "../middleware/region";

export const automationExecutionRoutes = new Elysia({ prefix: "/system/automation-executions" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ruleId, status, orgId } = query as any;
    const where: any = {};
    if (ruleId) where.ruleId = ruleId;
    if (status) where.status = status;
    if (orgId) where.orgId = orgId;

    const [data, total] = await Promise.all([
      prisma.automationExecution.findMany({
        where,
        skip: (parseInt(page) - 1) * parseInt(limit),
        take: parseInt(limit),
        orderBy: { executedAt: "desc" },
        include: {
          rule: { select: { id: true, ruleName: true } },
          event: { select: { id: true, eventType: true, entityLabel: true } },
        },
      }),
      prisma.automationExecution.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      ruleId: t.Optional(t.String()),
      status: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    })),
  })

  .get("/:id", async ({ orgId, db, params, set }) => {
    const execution = await prisma.automationExecution.findUnique({
      where: { id: params.id },
      include: {
        rule: { select: { id: true, ruleName: true, ruleType: true } },
        event: true,
      },
    });
    if (!execution) {
      set.status = 404;
      return { error: "Execution not found" };
    }
    return { data: execution };
  }, {
    params: t.Object({ id: t.String() }),
  });
