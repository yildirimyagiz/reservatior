import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * AI OS — AI service orchestration, model usage, and task queues.
 * Serves a flat GenericOSDashboard contract ({ kpis, recentActivity, alerts })
 * consumed by the mobile OsDashboardStats provider.
 */
export const aiOSRoutes = new Elysia({ prefix: "/ai-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      const where = orgId ? { orgId } : {};
      const [queued, processing, completed, failed, canceled, byType, recentTasks] = await Promise.all([
        prisma.aiServiceTask.count({ where: { ...where, status: "QUEUED" } }),
        prisma.aiServiceTask.count({ where: { ...where, status: "PROCESSING" } }),
        prisma.aiServiceTask.count({ where: { ...where, status: "COMPLETED" } }),
        prisma.aiServiceTask.count({ where: { ...where, status: "FAILED" } }),
        prisma.aiServiceTask.count({ where: { ...where, status: "CANCELED" } }),
        prisma.aiServiceTask.groupBy({ by: ["taskType"], _count: { id: true } }),
        prisma.aiServiceTask.findMany({ where, orderBy: { createdAt: "desc" }, take: 8 }),
      ]);
      const total = queued + processing + completed + failed + canceled;

      return {
        kpis: {
          totalTasks: total,
          queued,
          processing,
          completed,
          failed,
          serviceCount: byType.length,
        },
        recentActivity: recentTasks.map((task) => ({
          title: task.taskType,
          subtitle: `${task.status} · ${new Date(task.createdAt).toLocaleDateString("en-US")}`,
          value: `${task.progress}%`,
        })),
        alerts: failed > 0
          ? [{ type: "warning", title: `${failed} failed tasks`, message: `${failed} AI service task(s) failed and may need attention.` }]
          : [],
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "AI OS Dashboard", tags: ["AI OS"] },
  });
