import { prisma } from "../../lib/prisma";
import { LandlordTrustProfile, TrustSignalCategory } from "@prisma/client";

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
];

const SIGNAL_WEIGHTS = {
  PROPERTY_MAINTENANCE: { weight: 0.25, category: "MAINTENANCE" as TrustSignalCategory },
  RESPONSIVENESS: { weight: 0.20, category: "BEHAVIOR" as TrustSignalCategory },
  LEASE_COMPLIANCE: { weight: 0.20, category: "COMPLIANCE" as TrustSignalCategory },
  FINANCIAL_RELIABILITY: { weight: 0.15, category: "FINANCIAL" as TrustSignalCategory },
  TENANT_SATISFACTION: { weight: 0.10, category: "SOCIAL" as TrustSignalCategory },
  VERIFICATION: { weight: 0.10, category: "VERIFICATION" as TrustSignalCategory },
};

function assignTier(score: number): string {
  for (const { min, tier } of TIER_THRESHOLDS) {
    if (score >= min) return tier;
  }
  return "BRONZE";
}

function normalizeSignal(rawValue: any): number {
  if (typeof rawValue === "number") {
    return Math.min(100, Math.max(0, rawValue));
  }
  if (typeof rawValue === "boolean") {
    return rawValue ? 100 : 0;
  }
  if (typeof rawValue === "string") {
    const lower = rawValue.toLowerCase();
    if (lower === "excellent" || lower === "pass" || lower === "verified") return 95;
    if (lower === "good") return 80;
    if (lower === "average" || lower === "fair") return 60;
    if (lower === "poor" || lower === "fail" || lower === "unverified") return 25;
    if (lower === "critical" || lower === "severe") return 10;
    return 50;
  }
  return 50;
}

async function fetchPropertyMaintenanceSignals(landlordId: string, orgId?: string) {
  const landlordEntity = await prisma.landlordEntity.findUnique({
    where: { id: landlordId },
  });

  if (!landlordEntity) return { maintenanceScore: 50 };

  // Query rental service plans to get associated properties
  const rentalPlans = await prisma.rentalServicePlan.findMany({
    where: { landlordEntityId: landlordId },
    select: { propertyId: true },
  });

  const propertyIds = rentalPlans.map((p) => p.propertyId).filter(Boolean) as string[];

  if (propertyIds.length === 0) return { maintenanceScore: 75 };

  const workOrders = await prisma.maintenanceWorkOrder.findMany({
    where: { propertyId: { in: propertyIds } },
    take: 50,
  });

  const resolvedOrders = workOrders.filter((w) => w.isActive === false).length;
  const resolutionRate = workOrders.length > 0 ? resolvedOrders / workOrders.length : 0.75;

  return {
    maintenanceScore: Math.round(resolutionRate * 100) / 100,
    totalProperties: propertyIds.length,
    totalWorkOrders: workOrders.length,
  };
}

async function fetchResponsivenessSignals(landlordId: string) {
  const landlordEntity = await prisma.landlordEntity.findUnique({
    where: { id: landlordId },
  });

  if (!landlordEntity || !landlordEntity.userId) return { responsivenessScore: 50 };

  const messages = await prisma.message.findMany({
    where: { senderUserId: landlordEntity.userId },
    orderBy: { createdAt: "desc" },
    take: 50,
  });

  const responsivenessScore = messages.length > 0 ? 75 : 50;

  return {
    responsivenessScore: Math.round(responsivenessScore * 100) / 100,
    totalMessages: messages.length,
  };
}

async function fetchLeaseComplianceSignals(landlordId: string) {
  const rentalPlans = await prisma.rentalServicePlan.findMany({
    where: { landlordEntityId: landlordId },
    take: 20,
  });

  const activePlans = rentalPlans.filter((p) => p.status === "ACTIVE").length;
  const leaseComplianceScore = rentalPlans.length > 0 ? activePlans / rentalPlans.length : 0.75;

  return {
    leaseComplianceScore: Math.round(leaseComplianceScore * 100) / 100,
    totalLeases: rentalPlans.length,
    disputeRate: 0,
  };
}

async function fetchFinancialReliabilitySignals(landlordId: string) {
  const financialProfile = await prisma.landlordFinancialProfile.findUnique({
    where: { landlordEntityId: landlordId },
  });

  if (!financialProfile) return { financialScore: 50, riskLevel: "UNKNOWN" };

  const riskScore = financialProfile.riskLevel === "LOW" ? 90 : financialProfile.riskLevel === "MEDIUM" ? 60 : 30;

  return {
    financialScore: riskScore,
    riskLevel: financialProfile.riskLevel,
  };
}

async function fetchTenantSatisfactionSignals(landlordId: string) {
  const rentalPlans = await prisma.rentalServicePlan.findMany({
    where: { landlordEntityId: landlordId },
    select: { propertyId: true },
  });

  const propertyIds = rentalPlans.map((p) => p.propertyId).filter(Boolean) as string[];

  if (propertyIds.length === 0) return { satisfactionScore: 75 };

  const reviews = await prisma.guestReview.findMany({
    where: { propertyId: { in: propertyIds } },
    take: 30,
  });

  const avgRating =
    reviews.length > 0 ? reviews.reduce((sum, r) => sum + (r.rating || 3), 0) / reviews.length / 5 : 0.75;

  return {
    satisfactionScore: Math.round(avgRating * 100) / 100,
    totalReviews: reviews.length,
    avgRating: Math.round(avgRating * 5 * 10) / 10,
  };
}

async function fetchVerificationSignals(landlordId: string) {
  const landlordEntity = await prisma.landlordEntity.findUnique({
    where: { id: landlordId },
    include: { user: true },
  });

  if (!landlordEntity) return { verified: false, kycLevel: "NONE", verificationScore: 0 };

  const identityVerified = landlordEntity.user?.emailVerified || false;
  const hasFinancialProfile = await prisma.landlordFinancialProfile.findUnique({
    where: { landlordEntityId: landlordId },
  });

  const kycLevel = hasFinancialProfile ? "FULL" : identityVerified ? "BASIC" : "NONE";
  const verificationScore = kycLevel === "FULL" ? 100 : kycLevel === "BASIC" ? 70 : 0;

  return {
    verified: identityVerified,
    kycLevel,
    verificationScore,
  };
}

export const landlordTrustScoreService = {
  async calculateTrustScore(landlordId: string, orgId?: string): Promise<LandlordTrustProfile> {
    const [maintenanceSignals, responsivenessSignals, leaseComplianceSignals, financialSignals, satisfactionSignals, verificationSignals] =
      await Promise.all([
        fetchPropertyMaintenanceSignals(landlordId),
        fetchResponsivenessSignals(landlordId),
        fetchLeaseComplianceSignals(landlordId),
        fetchFinancialReliabilitySignals(landlordId),
        fetchTenantSatisfactionSignals(landlordId),
        fetchVerificationSignals(landlordId),
      ]);

    const signalScores = {
      PROPERTY_MAINTENANCE: maintenanceSignals.maintenanceScore,
      RESPONSIVENESS: responsivenessSignals.responsivenessScore,
      LEASE_COMPLIANCE: leaseComplianceSignals.leaseComplianceScore,
      FINANCIAL_RELIABILITY: financialSignals.financialScore,
      TENANT_SATISFACTION: satisfactionSignals.satisfactionScore,
      VERIFICATION: verificationSignals.verificationScore,
    };

    let weightedSum = 0;
    let totalWeight = 0;
    const breakdown: Record<string, number> = {};

    for (const [signal, score] of Object.entries(signalScores)) {
      const config = SIGNAL_WEIGHTS[signal as keyof typeof SIGNAL_WEIGHTS];
      if (config) {
        const normalized = Math.min(100, Math.max(0, score));
        breakdown[signal] = Math.round(normalized * 100) / 100;
        weightedSum += normalized * config.weight;
        totalWeight += config.weight;
      }
    }

    const overallScore = totalWeight > 0 ? Math.round((weightedSum / totalWeight) * 100) / 100 : 0;
    const tier = assignTier(overallScore);

    const existingProfile = await prisma.landlordTrustProfile.findUnique({
      where: { landlordId },
    });

    const riskFactors: string[] = [];
    const positiveFactors: string[] = [];

    if (maintenanceSignals.maintenanceScore < 60) riskFactors.push("Low property maintenance score");
    if (financialSignals.riskLevel === "HIGH") riskFactors.push("High financial risk");
    if (verificationSignals.kycLevel === "NONE") riskFactors.push("No identity verification");

    if (maintenanceSignals.maintenanceScore >= 80) positiveFactors.push("Excellent property maintenance");
    if (satisfactionSignals.satisfactionScore >= 80) positiveFactors.push("High tenant satisfaction");

    const profileData = {
      overallScore,
      maintenanceScore: Math.round(maintenanceSignals.maintenanceScore * 100) / 100,
      contractScore: Math.round(responsivenessSignals.responsivenessScore * 100) / 100,
      paymentScore: Math.round(financialSignals.financialScore * 100) / 100,
      riskLevel: financialSignals.riskLevel || "MEDIUM",
      riskFactors,
      positiveFactors,
      lastCalculatedAt: new Date(),
    };

    if (existingProfile) {
      return await prisma.landlordTrustProfile.update({
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
      const landlordEntity = await prisma.landlordEntity.findUnique({
        where: { id: landlordId },
      });

      return await prisma.landlordTrustProfile.create({
        data: {
          landlordId,
          userId: landlordEntity?.userId || "",
          ...profileData,
          calculationVersion: 1,
          scoreHistory: {
            [new Date().toISOString()]: overallScore,
          },
        },
      });
    }
  },

  async getTrustProfile(landlordId: string): Promise<LandlordTrustProfile | null> {
    return await prisma.landlordTrustProfile.findUnique({
      where: { landlordId },
      include: {
        landlordEntity: {
          include: { user: true },
        },
      },
    });
  },

  async recordTrustEvent(
    landlordId: string,
    eventType: string,
    category: TrustSignalCategory,
    impact: number,
    metadata?: any
  ) {
    const profile = await prisma.landlordTrustProfile.findUnique({
      where: { landlordId },
    });

    if (!profile) {
      await this.calculateTrustScore(landlordId);
      return;
    }

    const newScore = Math.min(100, Math.max(0, profile.overallScore + impact));
    const newTier = assignTier(newScore);

    await prisma.landlordTrustProfile.update({
      where: { landlordId },
      data: {
        overallScore: Math.round(newScore * 100) / 100,
        calculationVersion: { increment: 1 },
        lastCalculatedAt: new Date(),
      },
    });
  },

  async getTrustHistory(landlordId: string) {
    const profile = await prisma.landlordTrustProfile.findUnique({
      where: { landlordId },
    });

    if (!profile) return null;

    const history = profile.scoreHistory as Record<string, number>;
    const entries = Object.entries(history)
      .sort((a, b) => new Date(b[0]).getTime() - new Date(a[0]).getTime())
      .slice(0, 30);

    return entries.map(([date, score]) => ({ date, score }));
  },
};
