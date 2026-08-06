import { prisma } from "../../lib/prisma";
import { AgentReputationProfile } from "@prisma/client";

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
];

const SIGNAL_WEIGHTS = {
  PERFORMANCE: { weight: 0.30 },
  RELIABILITY: { weight: 0.25 },
  CUSTOMER_SATISFACTION: { weight: 0.20 },
  CONTRACT_ACCURACY: { weight: 0.15 },
  COMMISSION_RELIABILITY: { weight: 0.10 },
};

function assignTier(score: number): string {
  for (const { min, tier } of TIER_THRESHOLDS) {
    if (score >= min) return tier;
  }
  return "BRONZE";
}

async function fetchPerformanceSignals(agentId: string) {
  const performances = await prisma.agentPerformance.findMany({
    where: { agentId },
    orderBy: { startDate: "desc" },
    take: 30,
  });

  const totalDeals = performances.reduce((sum, p) => sum + (p.dealsClosed || 0), 0);
  const totalLeads = performances.reduce((sum, p) => sum + (p.leadsGenerated || 0), 0);
  const conversionRate = totalLeads > 0 ? totalDeals / totalLeads : 0.5;

  const totalShowings = performances.reduce((sum, p) => sum + (p.showingsCompleted || 0), 0);
  const showingRate = totalLeads > 0 ? totalShowings / totalLeads : 0.5;

  return {
    conversionRate: Math.round(conversionRate * 100) / 100,
    showingRate: Math.round(showingRate * 100) / 100,
    totalDeals,
    totalLeads,
  };
}

async function fetchReliabilitySignals(agentId: string) {
  const commissions = await prisma.commission.findMany({
    where: { agentId },
    orderBy: { createdAt: "desc" },
    take: 30,
  });

  const paidCommissions = commissions.filter((c) => c.status === "PAID").length;
  const commissionReliability = commissions.length > 0 ? paidCommissions / commissions.length : 0.75;

  return {
    commissionReliability: Math.round(commissionReliability * 100) / 100,
    completionRate: 0.75,
    totalCommissions: commissions.length,
  };
}

async function fetchCustomerSatisfactionSignals(agentId: string) {
  // Use guest reviews for properties associated with the agent via Property relation
  const properties = await prisma.property.findMany({
    where: { 
      agents: { 
        some: { id: agentId } 
      } 
    },
    select: { id: true },
    take: 50,
  });

  if (properties.length === 0) {
    return { avgRating: 3.5, positiveRate: 0.5, totalReviews: 0 };
  }

  const propertyIds = properties.map((p) => p.id);
  const reviews = await prisma.guestReview.findMany({
    where: { propertyId: { in: propertyIds } },
    take: 30,
  });

  const avgRating =
    reviews.length > 0 ? reviews.reduce((sum, r) => sum + (r.rating || 3), 0) / reviews.length / 5 : 0.5;
  const positiveReviews = reviews.filter((r) => (r.rating || 3) >= 4).length;
  const positiveRate = reviews.length > 0 ? positiveReviews / reviews.length : 0.5;

  return {
    avgRating: Math.round(avgRating * 5 * 10) / 10,
    positiveRate: Math.round(positiveRate * 100) / 100,
    totalReviews: reviews.length,
  };
}

async function fetchContractAccuracySignals(agentId: string) {
  // Use agent's deal completion as proxy for contract accuracy
  const performances = await prisma.agentPerformance.findMany({
    where: { agentId },
    take: 20,
  });

  const totalDeals = performances.reduce((sum, p) => sum + (p.dealsClosed || 0), 0);
  const totalOffers = performances.reduce((sum, p) => sum + (p.offersSubmitted || 0), 0);
  const offerToDealRate = totalOffers > 0 ? totalDeals / totalOffers : 0.5;

  return {
    contractAccuracy: Math.round(offerToDealRate * 100) / 100,
    disputeRate: 0,
    totalContracts: totalDeals,
  };
}

async function fetchCommissionReliabilitySignals(agentId: string) {
  const commissions = await prisma.commission.findMany({
    where: { agentId },
    orderBy: { createdAt: "desc" },
    take: 30,
  });

  const disputedCommissions = commissions.filter((c) => c.status === "DISPUTED").length;
  const disputeRate = commissions.length > 0 ? disputedCommissions / commissions.length : 0;
  const reliabilityScore = Math.max(0, 1 - disputeRate);

  return {
    reliabilityScore: Math.round(reliabilityScore * 100) / 100,
    disputeRate: Math.round(disputeRate * 100) / 100,
    totalCommissions: commissions.length,
  };
}

export const agentReputationService = {
  async calculateReputationScore(agentId: string): Promise<AgentReputationProfile> {
    const [performanceSignals, reliabilitySignals, satisfactionSignals, contractSignals, commissionSignals] =
      await Promise.all([
        fetchPerformanceSignals(agentId),
        fetchReliabilitySignals(agentId),
        fetchCustomerSatisfactionSignals(agentId),
        fetchContractAccuracySignals(agentId),
        fetchCommissionReliabilitySignals(agentId),
      ]);

    const signalScores = {
      PERFORMANCE: performanceSignals.conversionRate * 100,
      RELIABILITY: reliabilitySignals.commissionReliability * 100,
      CUSTOMER_SATISFACTION: satisfactionSignals.avgRating * 100,
      CONTRACT_ACCURACY: contractSignals.contractAccuracy * 100,
      COMMISSION_RELIABILITY: commissionSignals.reliabilityScore * 100,
    };

    let weightedSum = 0;
    let totalWeight = 0;
    const breakdown: Record<string, number> = {};

    for (const [signal, score] of Object.entries(signalScores)) {
      const config = SIGNAL_WEIGHTS[signal as keyof typeof SIGNAL_WEIGHTS];
      if (config) {
        const normalized = Math.min(100, Math.max(0, score || 0));
        breakdown[signal] = Math.round(normalized * 100) / 100;
        weightedSum += normalized * config.weight;
        totalWeight += config.weight;
      }
    }

    const overallScore = totalWeight > 0 ? Math.round((weightedSum / totalWeight) * 100) / 100 : 0;
    const tier = assignTier(overallScore);

    const existingProfile = await prisma.agentReputationProfile.findUnique({
      where: { agentId },
    });

    const riskFactors: string[] = [];
    const positiveFactors: string[] = [];

    if (contractSignals.disputeRate > 0.2) riskFactors.push("High contract dispute rate");
    if (commissionSignals.disputeRate > 0.1) riskFactors.push("High commission dispute rate");
    if (performanceSignals.conversionRate < 0.3) riskFactors.push("Low lead conversion rate");

    if (satisfactionSignals.avgRating >= 4.5) positiveFactors.push("Excellent customer ratings");
    if (performanceSignals.conversionRate >= 0.7) positiveFactors.push("High lead conversion rate");
    if (reliabilitySignals.commissionReliability >= 0.95) positiveFactors.push("Excellent commission reliability");

    const agent = await prisma.agent.findUnique({
      where: { id: agentId },
    });

    const profileData = {
      overallScore,
      performanceScore: Math.round(performanceSignals.conversionRate * 100) / 100,
      reliabilityScore: Math.round(reliabilitySignals.commissionReliability * 100) / 100,
      serviceScore: Math.round(satisfactionSignals.avgRating * 100) / 100,
      leadResponseTime: 0,
      leadConversionRate: performanceSignals.conversionRate,
      transactionCompletionRate: reliabilitySignals.completionRate,
      customerSatisfactionScore: satisfactionSignals.avgRating,
      positiveReviewRate: satisfactionSignals.positiveRate,
      contractAccuracyRate: contractSignals.contractAccuracy,
      contractComplianceRate: contractSignals.contractAccuracy,
      disputeRate: contractSignals.disputeRate,
      commissionAccuracyRate: commissionSignals.reliabilityScore,
      commissionDisputeRate: commissionSignals.disputeRate,
      riskFactors,
      improvementSuggestions: positiveFactors,
      lastCalculatedAt: new Date(),
    };

    if (existingProfile) {
      return await prisma.agentReputationProfile.update({
        where: { id: existingProfile.id },
        data: {
          ...profileData,
          calculationVersion: { increment: 1 },
          scoreHistory: {
            ...(existingProfile.scoreHistory as any),
            [new Date().toISOString()]: overallScore,
          },
        },
      });
    } else {
      return await prisma.agentReputationProfile.create({
        data: {
          agentId,
          userId: "",
          ...profileData,
          calculationVersion: 1,
          scoreHistory: {
            [new Date().toISOString()]: overallScore,
          },
        },
      });
    }
  },

  async getReputationProfile(agentId: string): Promise<AgentReputationProfile | null> {
    return await prisma.agentReputationProfile.findUnique({
      where: { agentId },
    });
  },

  async recordReputationEvent(
    agentId: string,
    eventType: string,
    impact: number,
    metadata?: any
  ) {
    const profile = await prisma.agentReputationProfile.findUnique({
      where: { agentId },
    });

    if (!profile) {
      await this.calculateReputationScore(agentId);
      return;
    }

    const newScore = Math.min(100, Math.max(0, profile.overallScore + impact));
    const newTier = assignTier(newScore);

    await prisma.agentReputationProfile.update({
      where: { agentId },
      data: {
        overallScore: Math.round(newScore * 100) / 100,
        calculationVersion: { increment: 1 },
        lastCalculatedAt: new Date(),
      },
    });
  },

  async getReputationHistory(agentId: string) {
    const profile = await prisma.agentReputationProfile.findUnique({
      where: { agentId },
    });

    if (!profile) return null;

    const history = profile.scoreHistory as Record<string, number>;
    const entries = Object.entries(history)
      .sort((a, b) => new Date(b[0]).getTime() - new Date(a[0]).getTime())
      .slice(0, 30);

    return entries.map(([date, score]) => ({ date, score }));
  },
};
