import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class AnalyticsEngineService {
  async getDashboard(_orgId: string) {
    const [totalAnalytics, reportCount, activeWidgets, systemHealth, recentMetrics] = await Promise.all([
      prisma.analytics.count(),
      prisma.report.count(),
      prisma.dashboardWidget.count(),
      prisma.healthCheck.findFirst({ orderBy: { checkedAt: "desc" } }),
      prisma.systemMetrics.findMany({ orderBy: { collectedAt: "desc" }, take: 10 }),
    ]);
    return { totalAnalytics, reportCount, activeWidgets, systemHealth, recentMetrics };
  }

  async getAnalyticsByOrg(_orgId: string, params?: { skip?: number; take?: number; type?: string }) {
    return prisma.analytics.findMany({
      where: {
        ...(params?.type && { type: params.type }),
      },
      orderBy: { timestamp: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getAnalyticsStats(_orgId: string) {
    const [total, byType] = await Promise.all([
      prisma.analytics.count(),
      prisma.analytics.groupBy({ by: ["type"], _count: { id: true } }),
    ]);
    return { total, byType: byType.map(t => ({ type: t.type, count: t._count.id })) };
  }

  async getReports(orgId: string, params?: { skip?: number; take?: number }) {
    return prisma.report.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getReportExecutions(reportId: string) {
    return prisma.reportExecution.findMany({
      where: { reportId },
      orderBy: { executedAt: "desc" },
      take: 20,
    });
  }

  async createReport(data: { orgId: string; userId: string; name: string; reportType: string; config?: any }) {
    const result = await prisma.report.create({
      data: {
        ...data,
        config: data.config ?? {},
      },
    });
    await eventBus.publish({
      type: DomainEvents.REPORT_GENERATED,
      payload: { id: result.id, name: data.name, reportType: data.reportType },
      source: "AnalyticsOS",
    });
    return result;
  }

  async getDashboards(orgId: string) {
    return prisma.dashboardConfiguration.findMany({
      where: { orgId },
      orderBy: { createdAt: "desc" },
    });
  }

  async getSystemMetrics(params?: { skip?: number; take?: number; metricType?: string }) {
    return prisma.systemMetrics.findMany({
      where: { ...(params?.metricType && { metricType: params.metricType }) },
      orderBy: { collectedAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 50,
    });
  }

  async getPerformanceAlerts(params?: { skip?: number; take?: number; severity?: string }) {
    return prisma.performanceAlert.findMany({
      where: { ...(params?.severity && { severity: params.severity }) },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getHealthChecks() {
    return prisma.healthCheck.findMany({
      orderBy: { checkedAt: "desc" },
      take: 20,
    });
  }

  async createAnalytics(data: { entityId: string; entityType: string; type: string; data?: any }) {
    const result = await prisma.analytics.create({
      data: {
        entityId: data.entityId,
        entityType: data.entityType,
        type: data.type,
        data: data.data ?? {},
        timestamp: new Date(),
      },
    });
    await eventBus.publish({
      type: DomainEvents.ANALYTICS_DATA_COLLECTED,
      payload: { id: result.id, entityId: data.entityId, type: data.type },
      source: "AnalyticsOS",
    });
    return result;
  }
}

export const analyticsEngineService = new AnalyticsEngineService();
