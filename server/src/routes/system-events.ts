import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { triggerEngine } from "../services/trigger-engine";
import { regionMiddleware } from "../middleware/region";

export const systemEventRoutes = new Elysia({ prefix: "/system/events" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", eventType, orgId, entityType, entityId } = query as any;
    const where: any = {};
    if (eventType) where.eventType = eventType;
    if (orgId) where.orgId = orgId;
    if (entityType) where.entityType = entityType;
    if (entityId) where.entityId = entityId;

    const [data, total] = await Promise.all([
      prisma.systemEvent.findMany({
        where,
        skip: (parseInt(page) - 1) * parseInt(limit),
        take: parseInt(limit),
        orderBy: { createdAt: "desc" },
        include: {
          executions: {
            include: { rule: { select: { id: true, ruleName: true } } },
          },
        },
      }),
      prisma.systemEvent.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      eventType: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      entityType: t.Optional(t.String()),
      entityId: t.Optional(t.String()),
    })),
  })

  .get("/:id", async ({ orgId, db, params, set }) => {
    const event = await prisma.systemEvent.findUnique({
      where: { id: params.id },
      include: {
        executions: {
          include: { rule: { select: { id: true, ruleName: true } } },
          orderBy: { executedAt: "desc" },
        },
      },
    });
    if (!event) {
      set.status = 404;
      return { error: "Event not found" };
    }
    return { data: event };
  }, {
    params: t.Object({ id: t.String() }),
  })

  .post("/emit", async ({ orgId, db, body }) => {
    const result = await triggerEngine.emit(body as any);
    return { data: result };
  }, {
    body: t.Object({
      orgId: t.String(),
      eventType: t.String(),
      severity: t.Optional(t.String()),
      entityType: t.Optional(t.String()),
      entityId: t.Optional(t.String()),
      entityLabel: t.Optional(t.String()),
      payload: t.Optional(t.Any()),
      metadata: t.Optional(t.Any()),
      source: t.Optional(t.String()),
    }),
  });
