import { prismaManager } from "../../lib/prisma";
import { rankingAlgorithm, ListingRankingInput } from "./ranking-algorithm";
import { reputationEngine } from "../reputation/reputation-engine";

export interface DistributionResult {
  listingId: string;
  priority: "HIGH" | "MEDIUM" | "LOW";
  score: number;
  recommendedAgents: string[];
  estimatedConversion: number;
}

export class DistributionEngine {
  async distributeListing(listingId: string, region: string = "US"): Promise<DistributionResult> {
    const prisma = prismaManager.getClient(region);

    const listing = await prisma.listing.findUnique({
      where: { id: listingId },
      include: {
        property: true,
        agent: {
          include: {
            agentPerformances: true,
            Review: true,
          },
        },
        leads: true,
        maintenanceBlocks: true,
      },
    });

    if (!listing) throw new Error("Listing not found");
    if (!listing.agent) throw new Error("Listing has no assigned agent");

    const agentReputation = await reputationEngine.calculateAgentScore(listing.agent.id, region);
    const agentScore = agentReputation.totalScore;

    const now = Date.now();
    const totalMaintenance = listing.maintenanceBlocks?.length || 0;
    const openMaintenance = listing.maintenanceBlocks?.filter((m) => {
      const start = new Date(m.startDate).getTime();
      const end = new Date(m.endDate).getTime();
      return start <= now && end >= now;
    }).length || 0;
    const maintenanceHealth = totalMaintenance > 0 ? 1 - (openMaintenance / totalMaintenance) : 1;

    const agentReviews = listing.agent?.Review || [];
    const avgReviewScore = agentReviews.length > 0
      ? agentReviews.reduce((s, r) => s + r.rating / 5, 0) / agentReviews.length
      : 0.5;

    const listingQualityScore = (avgReviewScore * 0.6 + maintenanceHealth * 0.4);

    const totalLeads = listing.leads?.length || 0;
    const convertedLeads = listing.leads?.filter((l) => l.status === "CONVERTED").length || 0;
    const conversionRate = totalLeads > 0 ? convertedLeads / totalLeads : 0;

    const platformFee = Number(listing.price) * 0.04;
    const revenuePotential = platformFee * Math.max(conversionRate, 0.1);

    const daysListed = Math.floor((new Date().getTime() - new Date(listing.createdAt).getTime()) / (1000 * 60 * 60 * 24));
    const viewCount = listing.likesCount || 0;
    const inquiryCount = listing.leads?.length || 0;

    const agentWorkload = listing.agent?.agentPerformances?.reduce((s, p) => s + p.leadsGenerated, 0) || 0;

    const rankInput: ListingRankingInput = {
      listingId: listing.id,
      propertyId: listing.propertyId || "",
      agentId: listing.agentId || "",
      agentScore,
      listingQualityScore: Math.round(listingQualityScore * 100) / 100,
      historicalConversionRate: Math.round(conversionRate * 100) / 100,
      platformRevenuePotential: Math.round(revenuePotential * 100) / 100,
      daysListed,
      viewCount,
      inquiryCount,
      priceCompetitiveness: 0.5,
      agentWorkload,
    };

    const ranking = rankingAlgorithm.score(rankInput);

    const topAgents = await this.findTopAgentsForListing(listing, region);
    const estimatedConversion = conversionRate * (1 + ranking.finalScore * 0.5);

    await prisma.listingDistribution.upsert({
      where: { listingId: listingId },
      update: {
        distributionScore: ranking.finalScore,
        priority: ranking.priority,
        estimatedConversion,
        calculatedAt: new Date(),
      },
      create: {
        listingId: listingId,
        agentId: listing.agentId || "",
        orgId: listing.orgId,
        distributionScore: ranking.finalScore,
        priority: ranking.priority,
        estimatedConversion,
        calculatedAt: new Date(),
      },
    });

    return {
      listingId: listing.id,
      priority: ranking.priority,
      score: ranking.finalScore,
      recommendedAgents: topAgents,
      estimatedConversion: Math.round(estimatedConversion * 100) / 100,
    };
  }

  async distributeAllActiveListings(region: string = "US"): Promise<DistributionResult[]> {
    const prisma = prismaManager.getClient(region);
    const listings = await prisma.listing.findMany({
      where: {
        status: { in: ["AVAILABLE", "VACANT"] },
      },
      take: 100,
    });

    const results: DistributionResult[] = [];
    for (const listing of listings) {
      try {
        const result = await this.distributeListing(listing.id, region);
        results.push(result);
      } catch (err) {
        console.error(`Distribution failed for listing ${listing.id}:`, err);
      }
    }

    return results;
  }

  async getDistributionHistory(listingId: string, region: string = "US"): Promise<any> {
    const prisma = prismaManager.getClient(region);
    return prisma.listingDistribution.findMany({
      where: { listingId },
      orderBy: { calculatedAt: "desc" },
      take: 10,
    });
  }

  private async findTopAgentsForListing(listing: any, region: string): Promise<string[]> {
    const prisma = prismaManager.getClient(region);
    const agents = await prisma.agent.findMany({
      where: {
        status: "ACTIVE",
        specialties: { hasSome: [listing.type || "RESIDENTIAL"] },
      },
      take: 5,
    });

    const scoredAgents = await Promise.all(
      agents.map(async (a: any) => {
        const score = await reputationEngine.calculateAgentScore(a.id, region);
        return { id: a.id, score: score.totalScore };
      })
    );

    return scoredAgents
      .sort((a, b) => b.score - a.score)
      .slice(0, 3)
      .map(a => a.id);
  }
}

export const distributionEngine = new DistributionEngine();
