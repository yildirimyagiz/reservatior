import { Elysia } from "elysia";
import { SharedStatus } from "@prisma/client";
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

      const agency = await prisma.agency.findFirst({
        where: { organizationId: data.orgId, deletedAt: null },
        select: { id: true },
      });
      if (!agency) {
        set.status = 400;
        return { success: false, error: "No agency found for the given organization" };
      }

      const result = await prisma.agent.create({
        data: {
          name: data.name,
          email: data.email,
          agencyId: agency.id,
          status: SharedStatus.ACTIVE,
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

      const status = data.status?.toUpperCase() as SharedStatus;
      if (!Object.values(SharedStatus).includes(status)) {
        set.status = 400;
        return { success: false, error: `Invalid status. Expected one of: ${Object.values(SharedStatus).join(", ")}` };
      }

      const result = await prisma.agent.update({
        where: { id },
        data: { status },
      });

      await eventBus.publish(DomainEvents.AGENT_STATUS_CHANGED, { id, status }, "AgentOS");

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
      });

      return {
        success: true,
        data: listings.map((l) => ({
          listingId: l.id,
          listingTitle: l.title || "Unknown",
          currentPrice: l.price ? Number(l.price) : 0,
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
  })

  // GET /agent-os/verifications — agent identity/license verification status
  .get("/verifications", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      const agents = await prisma.agent.findMany({
        where: { Agency: { organizationId: orgId || undefined }, deletedAt: null },
        select: {
          id: true,
          name: true,
          licenseNumber: true,
          licenseType: true,
          licenseExpiryDate: true,
          licenseStatus: true,
          licenseVerified: true,
          licenseVerifiedAt: true,
          verificationMethod: true,
        },
        orderBy: { createdAt: "desc" },
        take: 50,
      });

      const now = new Date();
      const items = agents.map((a) => {
        let status = "Pending";
        if (a.licenseVerified && a.licenseExpiryDate && a.licenseExpiryDate > now) status = "Verified";
        else if (a.licenseExpiryDate && a.licenseExpiryDate < now) status = "Expired";
        else if (a.licenseVerified) status = "Verified";

        const score =
          (a.licenseVerified ? 40 : 0) +
          (a.licenseStatus === "ACTIVE" || a.licenseStatus === "APPROVED" ? 35 : 0) +
          (a.licenseExpiryDate && a.licenseExpiryDate > now ? 25 : 0);

        return {
          id: a.id,
          agentName: a.name,
          status,
          idType: a.licenseType || a.verificationMethod || "Government ID",
          verifiedDate: a.licenseVerifiedAt ? a.licenseVerifiedAt.toISOString().split("T")[0] : null,
          expiryDate: a.licenseExpiryDate ? a.licenseExpiryDate.toISOString().split("T")[0] : null,
          score: Math.min(100, score),
        };
      });

      return {
        success: true,
        data: {
          verified: items.filter((i) => i.status === "Verified").length,
          pending: items.filter((i) => i.status === "Pending").length,
          expired: items.filter((i) => i.status === "Expired").length,
          totalAgents: items.length,
          agents: items,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })

  // GET /agent-os/compliance — agent license/document compliance review list
  .get("/compliance", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      const agents = await prisma.agent.findMany({
        where: { Agency: { organizationId: orgId || undefined }, deletedAt: null },
        select: {
          id: true,
          name: true,
          licenseStatus: true,
          licenseVerified: true,
          licenseType: true,
          licenseExpiryDate: true,
          updatedAt: true,
        },
        orderBy: { updatedAt: "desc" },
        take: 50,
      });

      const now = new Date();
      const items = agents.map((a) => {
        let status = "Pending";
        if (!a.licenseVerified) status = "Pending";
        else if (
          a.licenseStatus === "SUSPENDED" ||
          a.licenseStatus === "REVOKED" ||
          (a.licenseExpiryDate && a.licenseExpiryDate < now)
        )
          status = "Flagged";
        else status = "Approved";

        const score =
          (a.licenseVerified ? 50 : 0) +
          (a.licenseStatus === "APPROVED" || a.licenseStatus === "ACTIVE" ? 30 : 0) +
          (a.licenseExpiryDate && a.licenseExpiryDate > now ? 20 : 0);

        return {
          id: a.id,
          agentName: a.name,
          documentType: a.licenseType || "License",
          status,
          date: a.updatedAt.toISOString().split("T")[0],
          score: Math.min(100, score),
        };
      });

      return {
        success: true,
        data: {
          totalRecords: items.length,
          pendingReview: items.filter((i) => i.status === "Pending").length,
          compliant: items.filter((i) => i.status === "Approved").length,
          flaggedIssues: items.filter((i) => i.status === "Flagged").length,
          records: items,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })

  // GET /agent-os/scoring — behavioral/performance score rankings
  .get("/scoring", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      const agents = await prisma.agent.findMany({
        where: { Agency: { organizationId: orgId || undefined }, deletedAt: null },
        select: {
          id: true,
          name: true,
          clientSatisfaction: true,
          responseRate: true,
          responseTime: true,
          closingRate: true,
          totalTransactions: true,
          agentPerformances: {
            select: { leadsGenerated: true, dealsClosed: true, commissionEarned: true },
          },
        },
        orderBy: { totalTransactions: "desc" },
        take: 50,
      });

      const items = agents.map((a) => {
        const leads = a.agentPerformances.reduce((s, p) => s + p.leadsGenerated, 0);
        const deals = a.agentPerformances.reduce((s, p) => s + p.dealsClosed, 0);
        const earned = a.agentPerformances.reduce((s, p) => s + Number(p.commissionEarned), 0);
        const closing = a.closingRate ?? (deals / Math.max(leads, 1)) * 100;
        const score = Math.round(
          Math.min(
            100,
            (a.clientSatisfaction ?? 80) * 0.3 + closing * 0.4 + (a.responseRate ?? 0.85) * 100 * 0.3
          )
        );
        return {
          id: a.id,
          name: a.name,
          score: Math.max(0, score),
          deals: deals || a.totalTransactions || 0,
          leads,
          commission: Math.round(earned),
          responseTime: a.responseTime ?? 2,
          trend:
            a.responseRate && a.responseRate > 0.9
              ? "up"
              : a.responseRate && a.responseRate < 0.7
                ? "down"
                : "stable",
        };
      });

      const sorted = items.sort((x, y) => y.score - x.score);
      const overallScore = sorted.length
        ? Math.round(sorted.reduce((s, x) => s + x.score, 0) / sorted.length)
        : 0;
      const avgResponse = sorted.length
        ? sorted.reduce((s, x) => s + x.responseTime, 0) / sorted.length
        : 0;
      const avgRating = sorted.length
        ? sorted.reduce((s, x) => s + (x.score >= 90 ? 5 : x.score >= 75 ? 4 : x.score >= 60 ? 3 : 2), 0) /
          sorted.length
        : 0;

      return {
        success: true,
        data: {
          overallScore,
          responseLatency: parseFloat(avgResponse.toFixed(1)),
          conversionRate: parseFloat(overallScore.toFixed(1)),
          avgRating: parseFloat(avgRating.toFixed(1)),
          dealsClosed: sorted.reduce((s, x) => s + x.deals, 0),
          rankings: sorted.map((x, idx) => ({ rank: idx + 1, ...x })).slice(0, 20),
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
