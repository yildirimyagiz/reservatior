import Elysia, { t } from "elysia";
import { prisma } from "../lib/prisma";

export const priceOptimizationDashboardRoutes = new Elysia({ prefix: "/api/analytics/price-optimization" })
  .get("/kpi", async () => {
    try {
      const [
        totalListings,
        optimizedListings,
        activeOptimizations,
        totalCommissions,
        totalRevenue,
      ] = await Promise.all([
        prisma.listing.count({ where: { deletedAt: null } }),
        prisma.listing.count({ where: { isOptimizedForSpeed: true, deletedAt: null } }),
        prisma.listing.count({ where: { optimizationStatus: "ACTIVE", deletedAt: null } }),
        prisma.commission.aggregate({ _sum: { amount: true } }),
        prisma.financialRecord.aggregate({ _sum: { amount: true } }),
      ]);

      const avgVacancy = await prisma.listing.aggregate({
        _avg: { vacancyDays: true },
        where: { status: "VACANT", deletedAt: null },
      });

      const acceptedOptimizations = await prisma.listing.count({
        where: { optimizationStatus: { in: ["ACCEPTED", "ACTIVE"] }, deletedAt: null },
      });

      const totalSuggestions = await prisma.aIPriceOptimization.count();
      const acceptanceRate = totalSuggestions > 0 ? acceptedOptimizations / totalSuggestions : 0;

      // Calculate average time to rent for optimized vs non-optimized
      const optimizedTimeToRent = await prisma.listing.aggregate({
        _avg: { vacancyDays: true },
        where: { isOptimizedForSpeed: true, status: { not: "VACANT" }, deletedAt: null },
      });

      const nonOptimizedTimeToRent = await prisma.listing.aggregate({
        _avg: { vacancyDays: true },
        where: { isOptimizedForSpeed: false, status: { not: "VACANT" }, deletedAt: null },
      });

      return {
        success: true,
        data: {
          totalListings,
          optimizedListings,
          activeOptimizations,
          avgVacancyDays: Math.round(avgVacancy._avg.vacancyDays || 0),
          averageTimeToRent: Math.round(optimizedTimeToRent._avg.vacancyDays || 0),
          nonOptimizedTimeToRent: Math.round(nonOptimizedTimeToRent._avg.vacancyDays || 0),
          totalCommissions: totalCommissions._sum.amount || 0,
          totalRevenue: totalRevenue._sum.amount || 0,
          acceptanceRate: Math.round(acceptanceRate * 100),
          revenueLift: 15, // Mock - would be calculated from actual data
          conversionLift: 22, // Mock
          boostedListings: activeOptimizations,
        },
      };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  })

  .get("/optimization-trend", async () => {
    // Return last 30 days of optimization data
    const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);

    const optimizations = await prisma.aIPriceOptimization.findMany({
      where: { generatedAt: { gte: thirtyDaysAgo } },
      orderBy: { generatedAt: "asc" },
      select: { generatedAt: true, confidence: true, isApplied: true, recommendedDiscount: true },
    });

    // Aggregate by day
    const trend: Record<string, { count: number; accepted: number; avgDiscount: number }> = {};
    for (const opt of optimizations) {
      const day = opt.generatedAt.toISOString().slice(0, 10);
      if (!trend[day]) trend[day] = { count: 0, accepted: 0, avgDiscount: 0 };
      trend[day].count++;
      if (opt.isApplied) trend[day].accepted++;
      trend[day].avgDiscount += Number(opt.recommendedDiscount || 0);
    }

    // Average the discounts
    for (const day of Object.keys(trend)) {
      trend[day].avgDiscount = trend[day].count > 0
        ? Math.round((trend[day].avgDiscount / trend[day].count) * 100) / 100
        : 0;
    }

    return { success: true, data: trend };
  })

  .get("/country-breakdown", async () => {
    const listings = await prisma.listing.groupBy({
      by: ["optimizationStatus"],
      _count: { id: true },
      _avg: { vacancyDays: true, boostScore: true, rankingScore: true },
      where: { deletedAt: null },
    });

    const breakdown = listings.map((l) => ({
      status: l.optimizationStatus,
      count: l._count.id,
      avgVacancyDays: Math.round(l._avg.vacancyDays || 0),
      avgBoostScore: Math.round((l._avg.boostScore || 0) * 100) / 100,
      avgRankingScore: Math.round((l._avg.rankingScore || 0) * 100) / 100,
    }));

    return { success: true, data: breakdown };
  });