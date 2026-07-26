import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";

export const growthEngineRoutes = new Elysia({ prefix: "/growth-engine" })
  .use(authMiddleware)
  .use(regionMiddleware)

  // ──────────────────────────────────────────────
  // 1. GET /summary — Growth engine summary for org
  // ──────────────────────────────────────────────
  .get("/summary", async ({ orgId: ctxOrgId, db, query }) => {
    const dbClient = db as any;
    const orgId = (query as any).orgId || ctxOrgId;

    const where = orgId ? { orgId } : {};

    const [
      totalProperties,
      bookingAgg,
      activeCampaigns,
      totalCreators,
      funnelRecords,
    ] = await Promise.all([
      dbClient.property.count({ where }),
      dbClient.booking.aggregate({
        where,
        _sum: { totalAmount: true },
        _count: true,
      }),
      dbClient.adCampaign.count({
        where: { ...where, status: "ACTIVE" },
      }),
      dbClient.creatorProfile.count({ where }),
      dbClient.conversionFunnel.findMany({
        where,
        orderBy: { createdAt: "desc" },
        take: 50,
      }),
    ]);

    const totalRevenue = Number(bookingAgg._sum.totalAmount ?? 0);
    const totalBookings = bookingAgg._count ?? 0;

    const stageTotals: Record<string, number> = {};
    for (const rec of funnelRecords) {
      stageTotals[rec.funnelStage] =
        (stageTotals[rec.funnelStage] ?? 0) + rec.count;
    }

    const viewCount = stageTotals["VIEW"] ?? 0;
    const bookingCount = stageTotals["BOOKING"] ?? 0;
    const conversionRate = viewCount > 0 ? bookingCount / viewCount : 0;

    return {
      data: {
        totalProperties,
        totalBookings,
        totalRevenue,
        activeCampaigns,
        totalCreators,
        conversionRate,
      },
    };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
  })

  // ──────────────────────────────────────────────
  // 2. GET /telemetry/feed — Telemetry event feed
  // ──────────────────────────────────────────────
  .get("/telemetry/feed", async ({ orgId: ctxOrgId, db, query }) => {
    const dbClient = db as any;
    const orgId = (query as any).orgId || ctxOrgId;
    const limit = parseInt((query as any).limit ?? "50", 10);
    const offset = parseInt((query as any).offset ?? "0", 10);
    const type = (query as any).type as string | undefined;

    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (type) where.eventType = type;

    const [events, total] = await Promise.all([
      dbClient.telemetryEvent.findMany({
        where,
        orderBy: { createdAt: "desc" },
        skip: offset,
        take: limit,
      }),
      dbClient.telemetryEvent.count({ where }),
    ]);

    return {
      data: {
        events,
        total,
        limit,
        offset,
      },
    };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      offset: t.Optional(t.String()),
      type: t.Optional(t.String()),
    }),
  })

  // ──────────────────────────────────────────────
  // 3. POST /telemetry/events/:eventId/acknowledge
  // ──────────────────────────────────────────────
  .post("/telemetry/events/:eventId/acknowledge", async ({ params, userId, db, set }) => {
    const dbClient = db as any;
    const { eventId } = params as { eventId: string };

    const existing = await dbClient.telemetryEvent.findUnique({
      where: { id: eventId },
    });

    if (!existing) {
      set.status = 404;
      return { error: "Telemetry event not found" };
    }

    const updated = await dbClient.telemetryEvent.update({
      where: { id: eventId },
      data: {
        acknowledgedBy: userId,
        acknowledgedAt: new Date(),
      },
    });

    return { data: updated };
  }, {
    params: t.Object({ eventId: t.String() }),
  })

  // ──────────────────────────────────────────────
  // 4. GET /gamification/state — Get gamification state
  // ──────────────────────────────────────────────
  .get("/gamification/state", async ({ orgId: ctxOrgId, userId, db, query }) => {
    const dbClient = db as any;
    const orgId = (query as any).orgId || ctxOrgId;

    if (!orgId) {
      return { error: "orgId is required" };
    }

    let state = await dbClient.gamificationState.findUnique({
      where: { orgId },
    });

    if (!state) {
      state = await dbClient.gamificationState.create({
        data: {
          orgId,
          userId,
          points: 0,
          level: 1,
          streak: 0,
        },
      });
    }

    const achievements = await dbClient.achievement.findMany({
      where: { orgId },
      orderBy: { unlockedAt: "desc" },
    });

    const POINTS_PER_LEVEL = 100;
    const expectedLevel = Math.floor(state.points / POINTS_PER_LEVEL) + 1;
    if (expectedLevel > state.level) {
      state = await dbClient.gamificationState.update({
        where: { id: state.id },
        data: { level: expectedLevel },
      });
    }

    return {
      data: {
        ...state,
        achievements,
      },
    };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
  })

  // ──────────────────────────────────────────────
  // 5. GET /gamification/achievements — Get achievements
  // ──────────────────────────────────────────────
  .get("/gamification/achievements", async ({ orgId: ctxOrgId, db, query }) => {
    const dbClient = db as any;
    const orgId = (query as any).orgId || ctxOrgId;

    const where: any = {};
    if (orgId) where.orgId = orgId;

    const achievements = await dbClient.achievement.findMany({
      where,
      orderBy: { unlockedAt: "desc" },
    });

    return { data: achievements };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
  })

  // ──────────────────────────────────────────────
  // 6. GET /funnel — Get conversion funnel
  // ──────────────────────────────────────────────
  .get("/funnel", async ({ orgId: ctxOrgId, db, query }) => {
    const dbClient = db as any;
    const orgId = (query as any).orgId || ctxOrgId;
    const startDate = (query as any).startDate
      ? new Date((query as any).startDate)
      : undefined;
    const endDate = (query as any).endDate
      ? new Date((query as any).endDate)
      : undefined;

    const where: any = {};
    if (orgId) where.orgId = orgId;
    if (startDate || endDate) {
      where.startDate = {};
      if (startDate) where.startDate.gte = startDate;
      if (endDate) where.startDate.lte = endDate;
    }

    const records = await dbClient.conversionFunnel.findMany({
      where,
      orderBy: { startDate: "asc" },
    });

    const stages = ["VIEW", "INQUIRY", "BOOKING", "CHECKOUT", "SETTLEMENT"];
    const funnel: Record<string, { count: number; conversionRate: number | null }> = {};

    for (const stage of stages) {
      const stageRecords = records.filter(
        (r: any) => r.funnelStage === stage,
      );
      const totalCount = stageRecords.reduce(
        (sum: number, r: any) => sum + r.count,
        0,
      );
      const avgRate =
        stageRecords.length > 0
          ? stageRecords.reduce(
              (sum: number, r: any) => sum + (r.conversionRate ?? 0),
              0,
            ) / stageRecords.length
          : null;

      funnel[stage] = { count: totalCount, conversionRate: avgRate };
    }

    return {
      data: {
        stages: funnel,
        records,
      },
    };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
    }),
  })

  // ──────────────────────────────────────────────
  // 7. GET /widgets — Get configured widgets
  // ──────────────────────────────────────────────
  .get("/widgets", async ({ orgId: ctxOrgId, db, query }) => {
    const dbClient = db as any;
    const orgId = (query as any).orgId || ctxOrgId;

    const where: any = {};
    if (orgId) where.orgId = orgId;

    const widgets = await dbClient.growthWidget.findMany({
      where,
      orderBy: { position: "asc" },
    });

    return { data: widgets };
  }, {
    query: t.Object({
      orgId: t.Optional(t.String()),
    }),
  })

  // ──────────────────────────────────────────────
  // 8. PUT /widgets/:widgetId — Update widget config
  // ──────────────────────────────────────────────
  .put("/widgets/:widgetId", async ({ params, db, body, set }) => {
    const dbClient = db as any;
    const { widgetId } = params as { widgetId: string };
    const { config, position, title, isVisible } = body as any;

    const existing = await dbClient.growthWidget.findUnique({
      where: { id: widgetId },
    });

    if (!existing) {
      set.status = 404;
      return { error: "Widget not found" };
    }

    const data: any = {};
    if (config !== undefined) data.config = config;
    if (position !== undefined) data.position = position;
    if (title !== undefined) data.title = title;
    if (isVisible !== undefined) data.isVisible = isVisible;

    const updated = await dbClient.growthWidget.update({
      where: { id: widgetId },
      data,
    });

    return { data: updated };
  }, {
    params: t.Object({ widgetId: t.String() }),
    body: t.Object({
      config: t.Optional(t.Any()),
      position: t.Optional(t.Number()),
      title: t.Optional(t.String()),
      isVisible: t.Optional(t.Boolean()),
    }),
  });
