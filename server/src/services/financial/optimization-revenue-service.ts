import { prisma } from "../../lib/prisma";
import { eventBus } from "../../core/events/event-bus";
import { DomainEvents } from "../../core/events/domain-events";

export class OptimizationRevenueService {
  static async trackOptimizationImpact(listingId: string): Promise<void> {
    const listing = await prisma.listing.findUnique({
      where: { id: listingId },
      include: {
        aiPriceOptimizations: { orderBy: { generatedAt: "desc" }, take: 1 },
        financialRecords: { where: { deletedAt: null } },
      },
    });

    if (!listing) return;

    const optimization = listing.aiPriceOptimizations[0];
    if (!optimization) return;

    const currentPrice = Number(listing.price || 0);
    const originalPrice = Number(optimization.currentPrice);
    const priceReduction = originalPrice - currentPrice;

    // Calculate vacancy cost saved
    const avgVacancyBefore = optimization.vacancyDaysAtAnalysis || 45;
    const avgVacancyAfter = listing.vacancyDays;
    const vacancyDaysSaved = Math.max(0, avgVacancyBefore - avgVacancyAfter);
    const dailyRate = currentPrice / 30;
    const recoveredRevenue = vacancyDaysSaved * dailyRate;

    // Log financial impact
    await prisma.financialRecord.create({
      data: {
        orgId: listing.orgId,
        listingId: listing.id,
        type: "REVENUE",
        category: "OPTIMIZATION_IMPACT",
        amount: recoveredRevenue,
        currency: listing.priceCurrency || "USD",
        description: `Revenue recovered from price optimization - ${vacancyDaysSaved} days vacancy reduction`,
        recordedAt: new Date(),
      },
    });

    console.log(
      `[OptimizationRevenue] Listing ${listingId}: ` +
        `price reduced ${priceReduction}, ` +
        `vacancy saved ${vacancyDaysSaved} days, ` +
        `recovered $${recoveredRevenue.toFixed(2)}`
    );
  }

  static async getOptimizationROI(
    listingId: string
  ): Promise<{ totalRecovered: number; totalReduction: number; roi: number; daysOptimized: number }> {
    const records = await prisma.financialRecord.findMany({
      where: { listingId, category: "OPTIMIZATION_IMPACT", deletedAt: null },
    });

    const totalRecovered = records.reduce((sum, r) => sum + Number(r.amount), 0);

    const opt = await prisma.aIPriceOptimization.findFirst({
      where: { listingId, isApplied: true },
      orderBy: { appliedAt: "desc" },
    });

    const totalReduction = opt ? Number(opt.currentPrice) - Number(opt.recommendedPrice) : 0;
    const daysOptimized = opt?.appliedAt
      ? Math.floor((Date.now() - new Date(opt.appliedAt).getTime()) / (1000 * 60 * 60 * 24))
      : 0;

    const roi = totalReduction > 0 ? totalRecovered / totalReduction : 0;

    return { totalRecovered, totalReduction, roi: Math.round(roi * 100) / 100, daysOptimized };
  }
}
