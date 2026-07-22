import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

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

      // AgentPerformance: no orgId filter — aggregate across org's agents
      const [performances, totalCommissions, activeLeads, closedDeals] =
        await Promise.all([
          prisma.agentPerformance.findMany({
            orderBy: { startDate: "desc" },
            take: 20,
            select: {
              id: true,
              leadsGenerated: true,
              dealsClosed: true,
              commissionEarned: true,
              showingsCompleted: true,
              offersSubmitted: true,
            },
          }),
          // Commission uses orgId + commissionAmount (not amount)
          prisma.commission.aggregate({
            where: {
              orgId,
              createdAt: { gte: thirtyDaysAgo },
            },
            _sum: { commissionAmount: true },
            _count: true,
          }),
          prisma.lead.count({
            where: {
              orgId,
              status: { in: ["NEW", "CONTACTED", "QUALIFIED"] },
              deletedAt: null,
            },
          }),
          // Deal uses dealStatus, not status
          prisma.deal.count({
            where: {
              orgId,
              dealStatus: "CLOSED",
              createdAt: { gte: thirtyDaysAgo },
            },
          }),
        ]);

      const totalLeads =
        performances.reduce((acc, p) => acc + (p.leadsGenerated || 0), 0) ||
        activeLeads;

      const totalDealsClosed = performances.reduce(
        (acc, p) => acc + (p.dealsClosed || 0),
        0
      );

      // Derive a synthetic conversion rate from dealsClosed / (leadsGenerated || 1)
      const avgConversionRate =
        performances.length > 0
          ? (
              (totalDealsClosed /
                Math.max(
                  performances.reduce(
                    (acc, p) => acc + (p.leadsGenerated || 0),
                    0
                  ),
                  1
                )) *
              100
            ).toFixed(1)
          : "0.0";

      // Commission trend: last 7 days
      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

      const commissionsByDay = await prisma.commission.findMany({
        where: {
          orgId,
          createdAt: { gte: sevenDaysAgo },
        },
        select: { commissionAmount: true, createdAt: true },
        orderBy: { createdAt: "asc" },
      });

      const chartDataMap = new Map<
        string,
        { day: string; revenue: number; commissions: number }
      >();
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
          entry.revenue += Number(c.commissionAmount || 0);
          entry.commissions += 1;
        }
      });

      return {
        success: true,
        data: {
          totalLeads,
          avgResponseTime: 0, // not tracked in schema, frontend uses default
          avgConversionRate: parseFloat(avgConversionRate),
          totalCommissionValue: Number(
            totalCommissions._sum?.commissionAmount || 0
          ),
          totalCommissionCount: totalCommissions._count,
          closedDeals: closedDeals || totalDealsClosed,
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

      // LeadConversion: uses orgId, conversionType, conversionDate, conversionValue
      const recentConversions = await prisma.leadConversion.findMany({
        where: { orgId },
        orderBy: { createdAt: "desc" },
        take: 8,
        select: {
          id: true,
          conversionType: true,
          conversionDate: true,
          conversionValue: true,
          status: true,
        },
      });

      return {
        success: true,
        data: {
          recentConversions,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .post("/register", async ({ body, set }) => {
    try {
      const data = body as {
        name: string;
        email: string;
        orgId: string;
      };

      const result = await prisma.agent.create({
        data: {
          name: data.name,
          email: data.email,
          orgId: data.orgId,
          status: "ACTIVE",
        },
      });

      await eventBus.publish(DomainEvents.AGENT_REGISTERED, { id: result.id, name: data.name }, "AgentOS");

      set.status = 201;
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .put("/status/:id", async ({ params, body, set }) => {
    try {
      const { id } = params as { id: string };
      const data = body as { status: string };

      const result = await prisma.agent.update({
        where: { id },
        data: { status: data.status },
      });

      await eventBus.publish(DomainEvents.AGENT_STATUS_CHANGED, { id, status: data.status }, "AgentOS");

      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })

  // GET /agent-os/vacancy-alerts — listings with high vacancy days for Agent OS dashboard
  .get("/vacancy-alerts", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;

      const where: any = {
        vacancyDays: { gt: 20 },
        status: { in: ["AVAILABLE", "VACANT"] },
        deletedAt: null,
      };
      if (orgId) where.orgId = orgId;

      const listings = await prisma.listing.findMany({
        where,
        orderBy: { vacancyDays: "desc" },
        take: 20,
        include: {
          property: { select: { id: true, name: true, price: true, currency: true } },
        },
      });

      return {
        success: true,
        data: listings.map((l) => ({
          listingId: l.id,
          listingTitle: l.title || l.property?.name || "Unknown",
          currentPrice: l.price ? Number(l.price) : l.property?.price ? Number(l.property.price) : 0,
          currency: l.priceCurrency || "USD",
          vacancyDays: l.vacancyDays,
          marketPosition: l.vacancyDays > 60 ? "Below Average" : l.vacancyDays > 30 ? "Average" : "Above Average",
          suggestedDiscount: l.vacancyDays > 60 ? 0.08 : l.vacancyDays > 30 ? 0.05 : 0.03,
          projectedOccupancy: Math.max(40, 100 - l.vacancyDays * 0.5),
          estimatedMonthlyGain: Math.round((l.price ? Number(l.price) : 100000) * 0.005),
          optimizationStatus: l.optimizationStatus,
        })),
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
