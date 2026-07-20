import { prisma } from "../lib/prisma";

export class AnalyticsEngineService {
  async getDashboard(orgId: string) {
    const [totalAnalytics, reportCount, activeWidgets, systemHealth, recentMetrics] = await Promise.all([
      prisma.analytics.count({ where: { orgId } }),
      prisma.report.count({ where: { orgId } }),
      prisma.dashboardWidget.count(),
      prisma.healthCheck.findFirst({ orderBy: { createdAt: "desc" } }),
      prisma.systemMetrics.findMany({ orderBy: { createdAt: "desc" }, take: 10 }),
    ]);
    return { totalAnalytics, reportCount, activeWidgets, systemHealth, recentMetrics };
  }

  async getAnalyticsByOrg(orgId: string, params?: { skip?: number; take?: number; type?: string }) {
    return prisma.analytics.findMany({
      where: {
        orgId,
        ...(params?.type && { type: params.type }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async getAnalyticsStats(orgId: string) {
    const [total, byType] = await Promise.all([
      prisma.analytics.count({ where: { orgId } }),
      prisma.analytics.groupBy({ by: ["type"], where: { orgId }, _count: { id: true } }),
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

  async createReport(data: { orgId: string; name: string; reportType: string; config?: any }) {
    return prisma.report.create({
      data: {
        ...data,
        config: data.config ?? {},
        createdAt: new Date(),
      },
    });
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
      orderBy: { createdAt: "desc" },
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
      orderBy: { createdAt: "desc" },
      take: 20,
    });
  }

  async createAnalytics(data: { orgId: string; entityId: string; entityType: string; type: string; data?: any }) {
    return prisma.analytics.create({
      data: {
        ...data,
        data: data.data ?? {},
        timestamp: new Date(),
        createdAt: new Date(),
      },
    });
  }
}

export const analyticsEngineService = new AnalyticsEngineService();
