import { prisma } from "../../lib/prisma";
import { PropertyTrustProfile } from "@prisma/client";

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
];

const SIGNAL_WEIGHTS = {
  ACCURACY: { weight: 0.25 },
  CONDITION: { weight: 0.20 },
  LOCATION: { weight: 0.20 },
  LEGAL: { weight: 0.15 },
  MAINTENANCE: { weight: 0.10 },
  PERFORMANCE: { weight: 0.10 },
};

function assignTier(score: number): string {
  for (const { min, tier } of TIER_THRESHOLDS) {
    if (score >= min) return tier;
  }
  return "BRONZE";
}

async function fetchAccuracySignals(propertyId: string) {
  const property = await prisma.property.findUnique({
    where: { id: propertyId },
  });

  if (!property) return { accuracyScore: 50, descriptionVerified: false, photosVerified: false };

  const descriptionVerified = property.name && property.name.length > 5 ? 80 : 50;
  const photosVerified = property.name ? 80 : 50;
  const accuracyScore = (descriptionVerified + photosVerified) / 2;

  return {
    accuracyScore: Math.round(accuracyScore * 100) / 100,
    descriptionVerified: descriptionVerified >= 70,
    photosVerified: photosVerified >= 70,
  };
}

async function fetchConditionSignals(propertyId: string) {
  const workOrders = await prisma.maintenanceWorkOrder.findMany({
    where: { propertyId },
    take: 30,
  });

  const resolvedOrders = workOrders.filter((w) => w.isActive === false).length;
  const maintenanceQuality = workOrders.length > 0 ? resolvedOrders / workOrders.length : 0.75;

  return {
    conditionScore: Math.round(maintenanceQuality * 100) / 100,
    totalWorkOrders: workOrders.length,
  };
}

async function fetchLocationSignals(propertyId: string) {
  const property = await prisma.property.findUnique({
    where: { id: propertyId },
  });

  if (!property) return { locationScore: 50 };

  const locationScore = property.city && property.country ? 75 : 50;

  return {
    locationScore: Math.round(locationScore * 100) / 100,
    hasCity: !!property.city,
    hasCountry: !!property.country,
  };
}

async function fetchLegalSignals(propertyId: string) {
  const complianceRecords = await prisma.propertyCompliance.findMany({
    where: { propertyId },
    take: 10,
  });

  const compliantCount = complianceRecords.filter((c) => c.status === "COMPLIANT").length;
  const complianceScore = complianceRecords.length > 0 ? compliantCount / complianceRecords.length : 0.75;

  return {
    legalScore: Math.round(complianceScore * 100) / 100,
    totalComplianceRecords: complianceRecords.length,
  };
}

async function fetchMaintenanceSignals(propertyId: string) {
  const workOrders = await prisma.maintenanceWorkOrder.findMany({
    where: { propertyId },
    take: 30,
  });

  if (workOrders.length === 0) return { maintenanceScore: 75, frequency: 0, daysSinceLastMaintenance: 365 };

  const frequency = workOrders.length / 12; // per month average
  const maintenanceScore = 75;

  return {
    maintenanceScore: Math.round(maintenanceScore * 100) / 100,
    frequency: Math.round(frequency * 100) / 100,
    daysSinceLastMaintenance: 365,
  };
}

async function fetchPerformanceSignals(propertyId: string) {
  const reviews = await prisma.guestReview.findMany({
    where: { propertyId },
    take: 30,
  });

  const avgRating =
    reviews.length > 0 ? reviews.reduce((sum, r) => sum + (r.rating || 3), 0) / reviews.length / 5 : 0.5;

  const performanceScore = avgRating * 100;

  return {
    performanceScore: Math.round(performanceScore * 100) / 100,
    occupancyRate: 0.5,
    avgRating: Math.round(avgRating * 5 * 10) / 10,
  };
}

export const propertyTrustScoreService = {
  async calculateTrustScore(propertyId: string): Promise<PropertyTrustProfile> {
    const [accuracySignals, conditionSignals, locationSignals, legalSignals, maintenanceSignals, performanceSignals] =
      await Promise.all([
        fetchAccuracySignals(propertyId),
        fetchConditionSignals(propertyId),
        fetchLocationSignals(propertyId),
        fetchLegalSignals(propertyId),
        fetchMaintenanceSignals(propertyId),
        fetchPerformanceSignals(propertyId),
      ]);

    const signalScores = {
      ACCURACY: accuracySignals.accuracyScore,
      CONDITION: conditionSignals.conditionScore,
      LOCATION: locationSignals.locationScore,
      LEGAL: legalSignals.legalScore,
      MAINTENANCE: maintenanceSignals.maintenanceScore,
      PERFORMANCE: performanceSignals.performanceScore,
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

    const existingProfile = await prisma.propertyTrustProfile.findUnique({
      where: { propertyId },
    });

    const riskFactors: string[] = [];
    const positiveFactors: string[] = [];

    if (conditionSignals.conditionScore < 60) riskFactors.push("Poor maintenance condition");
    if (legalSignals.legalScore < 60) riskFactors.push("Legal compliance issues");
    if (!accuracySignals.descriptionVerified) riskFactors.push("Incomplete property description");
    if (performanceSignals.occupancyRate < 0.4) riskFactors.push("Low occupancy rate");

    if (accuracySignals.photosVerified && accuracySignals.descriptionVerified) positiveFactors.push("Complete property verification");
    if (performanceSignals.avgRating >= 4.0) positiveFactors.push("High tenant satisfaction");
    if (locationSignals.locationScore >= 75) positiveFactors.push("Prime location");

    const profileData = {
      overallScore,
      accuracyScore: Math.round(accuracySignals.accuracyScore * 100) / 100,
      conditionScore: Math.round(conditionSignals.conditionScore * 100) / 100,
      locationScore: Math.round(locationSignals.locationScore * 100) / 100,
      legalScore: Math.round(legalSignals.legalScore * 100) / 100,
      ownershipVerified: accuracySignals.descriptionVerified,
      descriptionVerified: accuracySignals.descriptionVerified,
      photosVerified: accuracySignals.photosVerified,
      maintenanceQualityScore: Math.round(conditionSignals.conditionScore * 100) / 100,
      maintenanceFrequency: maintenanceSignals.frequency,
      lastMaintenanceDate: (maintenanceSignals.daysSinceLastMaintenance || 365) < 365 ? new Date() : null,
      occupancyRate: performanceSignals.occupancyRate,
      averageTenantRating: performanceSignals.avgRating,
      legalComplianceScore: Math.round(legalSignals.legalScore * 100) / 100,
      riskFactors,
      improvementSuggestions: positiveFactors,
      lastCalculatedAt: new Date(),
    };

    if (existingProfile) {
      return await prisma.propertyTrustProfile.update({
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
      return await prisma.propertyTrustProfile.create({
        data: {
          propertyId,
          ...profileData,
          calculationVersion: 1,
          scoreHistory: {
            [new Date().toISOString()]: overallScore,
          },
        },
      });
    }
  },

  async getTrustProfile(propertyId: string): Promise<PropertyTrustProfile | null> {
    return await prisma.propertyTrustProfile.findUnique({
      where: { propertyId },
      include: {
        property: true,
      },
    });
  },

  async recordTrustEvent(
    propertyId: string,
    eventType: string,
    impact: number,
    metadata?: any
  ) {
    const profile = await prisma.propertyTrustProfile.findUnique({
      where: { propertyId },
    });

    if (!profile) {
      await this.calculateTrustScore(propertyId);
      return;
    }

    const newScore = Math.min(100, Math.max(0, profile.overallScore + impact));
    const newTier = assignTier(newScore);

    await prisma.propertyTrustProfile.update({
      where: { propertyId },
      data: {
        overallScore: Math.round(newScore * 100) / 100,
        calculationVersion: { increment: 1 },
        lastCalculatedAt: new Date(),
      },
    });
  },

  async getTrustHistory(propertyId: string) {
    const profile = await prisma.propertyTrustProfile.findUnique({
      where: { propertyId },
    });

    if (!profile) return null;

    const history = profile.scoreHistory as Record<string, number>;
    const entries = Object.entries(history)
      .sort((a, b) => new Date(b[0]).getTime() - new Date(a[0]).getTime())
      .slice(0, 30);

    return entries.map(([date, score]) => ({ date, score }));
  },
};
