import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";

export const agentOSRoutes = new Elysia({ prefix: "/agent-os" })
  .get("/dashboard", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      const thirtyDaysAgo = new Date();
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

      const [
        performances,
        totalCommissions,
        activeLeads,
        closedDeals,
      ] = await Promise.all([
        prisma.agentPerformance.findMany({
          where: { orgId, deletedAt: null },
          orderBy: { createdAt: "desc" },
          take: 20,
          select: {
            id: true,
            leadsGenerated: true,
            responseTime: true,
            successRate: true,
            totalRevenue: true,
            createdAt: true,
          },
        }),
        prisma.commission.aggregate({
          where: {
            orgId,
            createdAt: { gte: thirtyDaysAgo },
          },
          _sum: { amount: true },
          _count: true,
        }),
        prisma.lead.count({
          where: {
            orgId,
            status: { in: ["NEW", "CONTACTED", "QUALIFIED"] },
            deletedAt: null,
          },
        }),
        prisma.deal.count({
          where: {
            orgId,
            status: "WON",
            createdAt: { gte: thirtyDaysAgo },
          },
        }),
      ]);

      const totalLeads = performances.reduce(
        (acc, p) => acc + (p.leadsGenerated || 0),
        0
      );
      const avgResponseTime =
        performances.length > 0
          ? Math.round(
              performances.reduce((acc, p) => acc + (p.responseTime || 0), 0) /
                performances.length
            )
          : 0;
      const avgConversionRate =
        performances.length > 0
          ? (
              performances.reduce(
                (acc, p) => acc + (p.successRate || 0),
                0
              ) / performances.length
            ).toFixed(1)
          : "0.0";

      // Commission trend chart (last 7 days)
      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

      const commissionsByDay = await prisma.commission.findMany({
        where: {
          orgId,
          createdAt: { gte: sevenDaysAgo },
        },
        select: { amount: true, createdAt: true },
        orderBy: { createdAt: "asc" },
      });

      const chartDataMap = new Map<string, { day: string; revenue: number; commissions: number }>();
      for (let i = 6; i >= 0; i--) {
        const d = new Date();
        d.setDate(d.getDate() - i);
        const key = d.toISOString().split("T")[0];
        const label = d.toLocaleDateString("en-US", { weekday: "short" });
        chartDataMap.set(key, { day: label, revenue: 0, commissions: 0 });
      }

      commissionsByDay.forEach((c) => {
        const key = c.createdAt.toISOString().split("T")[0];
        if (chartDataMap.has(key)) {
          const entry = chartDataMap.get(key)!;
          entry.revenue += Number(c.amount);
          entry.commissions += 1;
        }
      });

      return {
        success: true,
        data: {
          totalLeads: totalLeads || activeLeads,
          avgResponseTime,
          avgConversionRate: parseFloat(avgConversionRate as string),
          totalCommissionValue: Number(totalCommissions._sum?.amount || 0),
          totalCommissionCount: totalCommissions._count,
          closedDeals,
          chartData: Array.from(chartDataMap.values()),
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .get("/network-signals", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      // Commission rules — the dynamic pricing backbone
      const commissionRules = await prisma.commissionRule.findMany({
        where: { orgId, deletedAt: null },
        orderBy: { updatedAt: "desc" },
        take: 5,
        select: {
          id: true,
          name: true,
          rate: true,
          type: true,
          isActive: true,
          updatedAt: true,
        },
      });

      // Recent lead conversions as behavioral signals
      const recentConversions = await prisma.leadConversion.findMany({
        where: { deletedAt: null },
        orderBy: { convertedAt: "desc" },
        take: 8,
        select: {
          id: true,
          sourceType: true,
          convertedAt: true,
          dealValue: true,
        },
      });

      return {
        success: true,
        data: {
          commissionRules,
          recentConversions,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
