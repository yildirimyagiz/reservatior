import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { regionMiddleware } from "../middleware/region";

export const notificationTemplateRoutes = new Elysia({ prefix: "/notification-templates" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", channel, isActive } = query as any;
    const where: any = { deletedAt: null };
    if (channel) where.channel = channel;
    if (isActive !== undefined) where.isActive = isActive === "true";

    const [data, total] = await Promise.all([
      prisma.notificationTemplate.findMany({
        where,
        skip: (parseInt(page) - 1) * parseInt(limit),
        take: parseInt(limit),
        orderBy: { createdAt: "desc" },
      }),
      prisma.notificationTemplate.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      channel: t.Optional(t.String()),
      isActive: t.Optional(t.String()),
    })),
  })

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await prisma.notificationTemplate.create({ data: body as any });
    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      name: t.String(),
      description: t.Optional(t.String()),
      channel: t.String(),
      subject: t.Optional(t.String()),
      body: t.String(),
      variables: t.Optional(t.Array(t.String())),
      design: t.Optional(t.Any()),
      isActive: t.Optional(t.Boolean()),
    }),
  })

  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await prisma.notificationTemplate.findUnique({
      where: { id: params.id },
      include: {
        automationRules: { select: { id: true, ruleName: true } },
      },
    });
    if (!data || data.deletedAt) {
      set.status = 404;
      return { error: "NotificationTemplate not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() }),
  })

  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await prisma.notificationTemplate.update({
        where: { id: params.id },
        data: body as any,
      });
      return { data };
    } catch {
      set.status = 404;
      return { error: "NotificationTemplate not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Partial(t.Object({
      name: t.Optional(t.String()),
      description: t.Optional(t.String()),
      channel: t.Optional(t.String()),
      subject: t.Optional(t.String()),
      body: t.Optional(t.String()),
      variables: t.Optional(t.Array(t.String())),
      design: t.Optional(t.Any()),
      isActive: t.Optional(t.Boolean()),
    })),
  })

  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await prisma.notificationTemplate.update({
        where: { id: params.id },
        data: { deletedAt: new Date() },
      });
      return { success: true, message: "NotificationTemplate deleted successfully" };
    } catch {
      set.status = 404;
      return { error: "NotificationTemplate not found" };
    }
  }, {
    params: t.Object({ id: t.String() }),
  });
