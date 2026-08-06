import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { sagaTimeline } from "../core/workflows/saga-timeline";
import { prismaManager } from "../lib/prisma";

/**
 * Saga Observability Routes
 *
 * Surfaces the saga workflows (SagaState + SagaTimeline) to the platform UI:
 *   GET  /system/saga/stats          — aggregated saga statistics
 *   GET  /system/saga/timelines      — recent saga timelines (monitor feed)
 *   GET  /system/saga/timelines/:id  — full step timeline for one saga
 *   GET  /system/saga/types          — distinct saga types with activity
 *
 * Powers the mobile saga_flow monitor + admin saga views.
 */
export const sagaRoutes = new Elysia({ prefix: "/system/saga" })
  .use(authMiddleware)

  /**
   * GET /system/saga/stats
   * Aggregated observability: timeline stats + live SagaState status counts.
   */
  .get("/stats", async () => {
    const timeline = await sagaTimeline.getStats();
    const prisma = prismaManager.getClient("US");
    const [running, failed, completed, compensating] = await Promise.all([
      prisma.sagaState.count({ where: { status: "STARTED" } }),
      prisma.sagaState.count({ where: { status: "FAILED" } }),
      prisma.sagaState.count({ where: { status: "COMPLETED" } }),
      prisma.sagaState.count({ where: { status: "COMPENSATING" } }),
    ]);
    return {
      ...timeline,
      running,
      failed,
      completed,
      compensating,
    };
  })

  /**
   * GET /system/saga/timelines?limit=20
   * Recent saga timelines across all saga types, newest first.
   */
  .get("/timelines", async ({ query }) => {
    const { limit = "20" } = query as any;
    return { data: await sagaTimeline.getRecentTimelines(parseInt(limit)) };
  }, {
    query: t.Partial(t.Object({ limit: t.Optional(t.String()) })),
  })

  /**
   * GET /system/saga/timelines/:id
   * Full step-level timeline for a single saga instance.
   */
  .get("/timelines/:id", async ({ params, set }) => {
    const timeline = await sagaTimeline.getTimeline(params.id);
    if (!timeline) {
      set.status = 404;
      return { error: "Saga timeline not found" };
    }
    return { data: timeline };
  }, {
    params: t.Object({ id: t.String() }),
  })

  /**
   * GET /system/saga/types
   * Distinct saga types that have activity (for monitor filters / config UI).
   */
  .get("/types", async () => {
    const prisma = prismaManager.getClient("US");
    const rows = await prisma.sagaState.findMany({
      select: { sagaType: true },
      distinct: ["sagaType"],
      orderBy: { sagaType: "asc" },
    });
    return { data: rows.map((r) => r.sagaType) };
  });
