import { prisma } from "../lib/prisma";
import { PrismaClient } from "@prisma/client";
import { prismaManager } from "../lib/prisma";

import { TrustEntityType, TrustScoreStatus, TrustSignalCategory } from "@prisma/client";

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
] as const;

const SIGNAL_WEIGHTS: Record<string, Record<string, { weight: number; category: TrustSignalCategory }>> = {
  TENANT: {
    on_time_payment: { weight: 0.35, category: "PAYMENT" },
    payment_ratio: { weight: 0.15, category: "PAYMENT" },
    lease_completion: { weight: 0.2, category: "BEHAVIOR" },
    guest_rating: { weight: 0.15, category: "SOCIAL" },
    dispute_count: { weight: 0.15, category: "BEHAVIOR" },
  },
  PROPERTY: {
    maintenance_score: { weight: 0.25, category: "MAINTENANCE" },
    valuation_trend: { weight: 0.15, category: "FINANCIAL" },
    review_avg: { weight: 0.2, category: "SOCIAL" },
    compliance_score: { weight: 0.25, category: "COMPLIANCE" },
    occupancy_rate: { weight: 0.15, category: "OPERATIONAL" },
  },
  AGENT: {
    deal_closing_rate: { weight: 0.3, category: "OPERATIONAL" },
    commission_consistency: { weight: 0.2, category: "FINANCIAL" },
    client_rating: { weight: 0.25, category: "SOCIAL" },
    response_time: { weight: 0.15, category: "OPERATIONAL" },
    compliance_score: { weight: 0.1, category: "COMPLIANCE" },
  },
};

function assignTier(score: number): string {
  for (const { min, tier } of TIER_THRESHOLDS) {
    if (score >= min) return tier;
  }
  return "BRONZE";
}

function normalizeSignal(category: string, rawValue: any): number {
  if (typeof rawValue === "number") {
    if (category === "PAYMENT") {
      return Math.min(100, Math.max(0, rawValue * 100));
    }
    return Math.min(100, Math.max(0, rawValue));
  }
  if (typeof rawValue === "boolean") {
    return rawValue ? 100 : 0;
  }
  if (typeof rawValue === "string") {
    const lower = rawValue.toLowerCase();
    if (lower === "excellent" || lower === "pass" || lower === "compliant") return 95;
    if (lower === "good") return 80;
    if (lower === "average" || lower === "fair") return 60;
    if (lower === "poor" || lower === "fail" || lower === "non_compliant") return 25;
    if (lower === "critical" || lower === "severe") return 10;
    return 50;
  }
  return 50;
}

async function fetchTenantSignals(entityId: string, orgId: string | null) {
  const payments: any[] = await (prisma as any).payment.findMany({
    where: { tenantId: entityId, orgId: orgId ?? undefined },
    orderBy: { createdAt: "desc" },
    take: 50,
  });

  const totalPayments = payments.length;
  const onTimePayments = payments.filter(
    (p: any) => p.status === "COMPLETED" && p.paymentDate && p.dueDate && p.paymentDate <= p.dueDate
  ).length;
  const onTimeRatio = totalPayments > 0 ? onTimePayments / totalPayments : 0.5;

  const leases: any[] = await (prisma as any).lease.findMany({
    where: { tenantId: entityId, orgId: orgId ?? undefined },
    orderBy: { createdAt: "desc" },
    take: 10,
  });
  const completedLeases = leases.filter((l: any) => l.status === "COMPLETED").length;
  const leaseCompletionRate = leases.length > 0 ? completedLeases / leases.length : 0.5;

  const reviews: any[] = await (prisma as any).guestReview.findMany({
    where: { guestId: entityId, orgId: orgId ?? undefined },
    take: 20,
  });
  const avgRating =
    reviews.length > 0
      ? reviews.reduce((sum: number, r: any) => sum + (r.rating ?? 3), 0) / reviews.length / 5
      : 0.5;

  const disputes: any[] = await (prisma as any).bookingSecurityScreening.findMany({
    where: { tenantId: entityId, orgId: orgId ?? undefined },
    take: 20,
  });
  const disputeRate = totalPayments > 0 ? Math.min(1, disputes.length / totalPayments) : 0;

  return {
    on_time_payment: onTimeRatio,
    payment_ratio: onTimeRatio,
    lease_completion: leaseCompletionRate,
    guest_rating: avgRating,
    dispute_count: 1 - disputeRate,
  };
}

async function fetchPropertySignals(entityId: string, orgId: string | null) {
  const workOrders: any[] = await (prisma as any).maintenanceWorkOrder.findMany({
    where: { propertyId: entityId, orgId: orgId ?? undefined },
    orderBy: { createdAt: "desc" },
    take: 30,
  });
  const resolvedOrders = workOrders.filter((w: any) => w.status === "RESOLVED" || w.status === "CLOSED").length;
  const maintenanceScore = workOrders.length > 0 ? resolvedOrders / workOrders.length : 0.75;

  const valuations: any[] = await (prisma as any).propertyValuation.findMany({
    where: { propertyId: entityId, orgId: orgId ?? undefined },
    orderBy: { createdAt: "desc" },
    take: 5,
  });
  let valuationTrend = 0.5;
  if (valuations.length >= 2) {
    const latest = Number(valuations[0].estimatedValue ?? 0);
    const previous = Number(valuations[1].estimatedValue ?? 0);
    valuationTrend = previous > 0 ? Math.min(1, Math.max(0, 0.5 + (latest - previous) / previous * 5)) : 0.5;
  }

  const reviews: any[] = await (prisma as any).review.findMany({
    where: { entityId: entityId, entityType: "PROPERTY", orgId: orgId ?? undefined },
    take: 20,
  });
  const reviewAvg = reviews.length > 0
    ? reviews.reduce((sum: number, r: any) => sum + (r.rating ?? 3), 0) / reviews.length / 5
    : 0.5;

  const complianceRecords: any[] = await (prisma as any).propertyCompliance.findMany({
    where: { propertyId: entityId, orgId: orgId ?? undefined },
    take: 10,
  });
  const compliantCount = complianceRecords.filter((c: any) => c.status === "COMPLIANT").length;
  const complianceScore = complianceRecords.length > 0 ? compliantCount / complianceRecords.length : 0.75;

  return {
    maintenance_score: maintenanceScore,
    valuation_trend: valuationTrend,
    review_avg: reviewAvg,
    compliance_score: complianceScore,
    occupancy_rate: 0.7,
  };
}

async function fetchAgentSignals(entityId: string, orgId: string | null) {
  const performances: any[] = await (prisma as any).agentPerformance.findMany({
    where: { agentId: entityId, orgId: orgId ?? undefined },
    orderBy: { createdAt: "desc" },
    take: 20,
  });

  const dealClosings = performances.filter((p: any) => p.metricType === "DEAL_CLOSED" || p.metricType === "CONVERSION").length;
  const dealClosingRate = performances.length > 0 ? Math.min(1, dealClosings / Math.max(1, performances.length * 0.4)) : 0.5;

  const commissions: any[] = await (prisma as any).commission.findMany({
    where: { agentId: entityId, orgId: orgId ?? undefined },
    orderBy: { createdAt: "desc" },
    take: 30,
  });
  const paidCommissions = commissions.filter((c: any) => c.status === "PAID").length;
  const commissionConsistency = commissions.length > 0 ? paidCommissions / commissions.length : 0.5;

  const reviews: any[] = await (prisma as any).review.findMany({
    where: { entityId: entityId, entityType: "AGENT", orgId: orgId ?? undefined },
    take: 20,
  });
  const clientRating = reviews.length > 0
    ? reviews.reduce((sum, r) => sum + (r.rating ?? 3), 0) / reviews.length / 5
    : 0.5;

  const avgResponseHours =
    performances.length > 0
      ? performances.reduce((sum: number, p: any) => sum + (p.responseTimeMs ?? 3600000), 0) / performances.length / 3600000
      : 2;
  const responseTime = Math.max(0, 1 - avgResponseHours / 24);

  return {
    deal_closing_rate: dealClosingRate,
    commission_consistency: commissionConsistency,
    client_rating: clientRating,
    response_time: responseTime,
    compliance_score: 0.75,
  };
}

async function getSignals(entityType: TrustEntityType, entityId: string, orgId: string | null) {
  switch (entityType) {
    case "TENANT":
      return fetchTenantSignals(entityId, orgId);
    case "PROPERTY":
      return fetchPropertySignals(entityId, orgId);
    case "AGENT":
      return fetchAgentSignals(entityId, orgId);
    default:
      return {};
  }
}

function computeWeightedScore(signals: Record<string, number>, weights: Record<string, { weight: number; category: string }>) {
  let totalWeight = 0;
  let weightedSum = 0;
  const breakdown: Record<string, number> = {};

  for (const [key, value] of Object.entries(signals)) {
    const config = weights[key];
    if (!config) continue;
    const normalized = Math.min(100, Math.max(0, value * 100));
    breakdown[key] = Math.round(normalized * 100) / 100;
    weightedSum += normalized * config.weight;
    totalWeight += config.weight;
  }

  const overall = totalWeight > 0 ? weightedSum / totalWeight : 0;
  return { overall: Math.round(overall * 100) / 100, breakdown };
}

function buildExplanation(
  entityType: TrustEntityType,
  signals: Record<string, number>,
  overall: number,
  tier: string,
  breakdown: Record<string, number>
) {
  const parts: string[] = [];
  parts.push(`Overall trust score is ${Math.round(overall)}/100, placing this ${entityType.toLowerCase()} in the ${tier} tier.`);

  const sorted = Object.entries(breakdown).sort((a, b) => b[1] - a[1]);
  if (sorted.length > 0) {
    const [bestKey, bestVal] = sorted[0];
    parts.push(`Strongest area: ${bestKey.replace(/_/g, " ")} at ${Math.round(bestVal)}/100.`);
  }
  if (sorted.length > 1) {
    const [worstKey, worstVal] = sorted[sorted.length - 1];
    parts.push(`Weakest area: ${worstKey.replace(/_/g, " ")} at ${Math.round(worstVal)}/100.`);
  }

  if (overall >= 75) {
    parts.push("This entity has demonstrated strong trustworthiness across measured dimensions.");
  } else if (overall >= 50) {
    parts.push("This entity shows moderate trustworthiness with room for improvement.");
  } else {
    parts.push("This entity has significant trust gaps that should be addressed.");
  }

  return { summary: parts.join(" "), breakdown, tier, overall };
}

export const universalTrustScoreService = {
  async calculateScore(entityType: TrustEntityType, entityId: string, orgId: string | null) {
    const weights = SIGNAL_WEIGHTS[entityType];
    if (!weights) {
      throw new Error(`Unsupported entity type: ${entityType}`);
    }

    const signals = await getSignals(entityType, entityId, orgId);
    const { overall, breakdown } = computeWeightedScore(signals, weights);
    const tier = assignTier(overall);

    const existing = await prisma.universalTrustScore.findUnique({
      where: {
        entityType_entityId_orgId: {
          entityType,
          entityId,
          orgId: orgId ?? "",
        },
      },
    });

    const signalCount = await prisma.trustScoreEvent.count({
      where: { score: { entityType, entityId, orgId: orgId ?? undefined }, isValid: true },
    });

    const confidence = Math.min(1, signalCount / 10);

    const explanation = buildExplanation(entityType, signals, overall, tier, breakdown);

    let score;
    if (existing) {
      const newVersion = existing.version + 1;
      score = await prisma.universalTrustScore.update({
        where: { id: existing.id },
        data: {
          overallScore: overall,
          confidenceLevel: confidence,
          scoreBreakdown: breakdown,
          tier,
          version: newVersion,
          signalCount,
          lastCalculatedAt: new Date(),
          lastSignalAt: new Date(),
          explanationData: explanation,
          status: "ACTIVE",
        },
      });

      await prisma.trustScoreVersion.create({
        data: {
          scoreId: score.id,
          orgId: orgId ?? undefined,
          version: newVersion,
          overallScore: overall,
          tier,
          scoreBreakdown: breakdown,
          triggerEvent: "RECALCULATION",
          explanation: explanation,
        },
      });
    } else {
      score = await prisma.universalTrustScore.create({
        data: {
          orgId: orgId ?? undefined,
          entityType,
          entityId,
          overallScore: overall,
          confidenceLevel: confidence,
          scoreBreakdown: breakdown,
          tier,
          signalCount,
          lastCalculatedAt: new Date(),
          lastSignalAt: new Date(),
          explanationData: explanation,
          status: "ACTIVE",
        },
      });

      await prisma.trustScoreVersion.create({
        data: {
          scoreId: score.id,
          orgId: orgId ?? undefined,
          version: 1,
          overallScore: overall,
          tier,
          scoreBreakdown: breakdown,
          triggerEvent: "INITIAL_CALCULATION",
          explanation: explanation,
        },
      });
    }

    return {
      score,
      breakdown,
      tier,
      confidence,
      explanation,
    };
  },

  async recordEvent(
    scoreId: string,
    signalKey: string,
    category: TrustSignalCategory,
    rawValue: any,
    weight: number = 1.0,
    options?: { sourceEntityId?: string; sourceEntityType?: string; description?: string }
  ) {
    const score = await prisma.universalTrustScore.findUnique({
      where: { id: scoreId },
    });
    if (!score) throw new Error(`TrustScore not found: ${scoreId}`);

    const normalizedScore = normalizeSignal(category, rawValue);
    const previousScore = score.overallScore;
    const scoreImpact = (normalizedScore - 50) * weight * 0.1;
    const newScore = Math.min(100, Math.max(0, previousScore + scoreImpact));
    const newTier = assignTier(newScore);

    const event = await prisma.trustScoreEvent.create({
      data: {
        scoreId,
        orgId: score.orgId ?? undefined,
        signalKey,
        category,
        weight,
        rawValue,
        normalizedScore,
        scoreDelta: Math.round((newScore - previousScore) * 100) / 100,
        previousScore,
        newScore: Math.round(newScore * 100) / 100,
        sourceEntityId: options?.sourceEntityId,
        sourceEntityType: options?.sourceEntityType,
        description: options?.description,
      },
    });

    const newVersion = score.version + 1;
    const updatedScore = await prisma.universalTrustScore.update({
      where: { id: scoreId },
      data: {
        overallScore: Math.round(newScore * 100) / 100,
        tier: newTier,
        version: newVersion,
        signalCount: { increment: 1 },
        lastSignalAt: new Date(),
        lastCalculatedAt: new Date(),
        status: "ACTIVE",
      },
    });

    await prisma.trustScoreVersion.create({
      data: {
        scoreId,
        orgId: score.orgId ?? undefined,
        version: newVersion,
        overallScore: Math.round(newScore * 100) / 100,
        tier: newTier,
        scoreBreakdown: updatedScore.scoreBreakdown as any,
        triggerEvent: `SIGNAL: ${signalKey}`,
        eventId: event.id,
      },
    });

    return { event, updatedScore, delta: event.scoreDelta };
  },

  async getScoreWithHistory(entityType: TrustEntityType, entityId: string, orgId: string | null) {
    const score = await prisma.universalTrustScore.findUnique({
      where: {
        entityType_entityId_orgId: {
          entityType,
          entityId,
          orgId: orgId ?? "",
        },
      },
      include: {
        versions: {
          orderBy: { version: "desc" },
          take: 20,
        },
        events: {
          where: { isValid: true },
          orderBy: { calculatedAt: "desc" },
          take: 20,
        },
      },
    });

    if (!score) return null;

    await prisma.universalTrustScore.update({
      where: { id: score.id },
      data: {
        lastAccessedAt: new Date(),
        accessCount: { increment: 1 },
      },
    });

    return score;
  },

  async applyDecay(scoreId: string) {
    const score = await prisma.universalTrustScore.findUnique({
      where: { id: scoreId },
    });
    if (!score) throw new Error(`TrustScore not found: ${scoreId}`);
    if (score.status === "FROZEN" || score.status === "UNDER_REVIEW") return { score, decayed: false };

    const now = new Date();
    const lastSignal = score.lastSignalAt ?? score.lastCalculatedAt;
    const daysSinceLastSignal = Math.floor((now.getTime() - lastSignal.getTime()) / (1000 * 60 * 60 * 24));

    if (daysSinceLastSignal < score.inactivityDays) {
      return { score, decayed: false, reason: "Within inactivity threshold" };
    }

    const periodsInactive = Math.floor(daysSinceLastSignal / score.inactivityDays);
    const decayFactor = Math.pow(1 - score.decayRate, periodsInactive);
    let newScoreValue = score.overallScore * decayFactor;

    if (daysSinceLastSignal >= 180) {
      newScoreValue = Math.max(newScoreValue, 50);
    }

    newScoreValue = Math.round(newScoreValue * 100) / 100;
    const newTier = assignTier(newScoreValue);

    const updated = await prisma.universalTrustScore.update({
      where: { id: scoreId },
      data: {
        overallScore: newScoreValue,
        tier: newTier,
        status: "DECAYED",
        lastDecayAt: now,
        version: { increment: 1 },
      },
    });

    await prisma.trustScoreVersion.create({
      data: {
        scoreId,
        orgId: score.orgId ?? undefined,
        version: updated.version,
        overallScore: newScoreValue,
        tier: newTier,
        scoreBreakdown: updated.scoreBreakdown as any,
        triggerEvent: `DECAY: ${periodsInactive} periods inactive (${daysSinceLastSignal} days)`,
      },
    });

    return { score: updated, decayed: true, previousScore: score.overallScore, daysSinceLastSignal };
  },

  async getExplainableScore(entityType: TrustEntityType, entityId: string, orgId: string | null) {
    const score = await prisma.universalTrustScore.findUnique({
      where: {
        entityType_entityId_orgId: {
          entityType,
          entityId,
          orgId: orgId ?? "",
        },
      },
      include: {
        events: {
          where: { isValid: true },
          orderBy: { calculatedAt: "desc" },
          take: 10,
        },
      },
    });

    if (!score) return null;

    const breakdown = (score.scoreBreakdown as Record<string, number>) ?? {};
    const explanation = (score.explanationData as any) ?? buildExplanation(entityType, {}, score.overallScore, score.tier, breakdown);

    const eventSummaries = (score as any).events?.map((e: any) => ({
      signalKey: e.signalKey,
      category: e.category,
      normalizedScore: e.normalizedScore,
      scoreDelta: e.scoreDelta,
      description: e.description,
      at: e.calculatedAt,
    })) ?? [];

    return {
      entityType,
      entityId,
      overallScore: score.overallScore,
      tier: score.tier,
      confidenceLevel: score.confidenceLevel,
      explanation,
      signalContributions: Object.entries(breakdown)
        .sort((a, b) => b[1] - a[1])
        .map(([key, value]) => ({
          signal: key,
          score: value,
          impact: value >= 70 ? "positive" : value >= 40 ? "neutral" : "negative",
        })),
      recentEvents: eventSummaries,
      lastCalculatedAt: score.lastCalculatedAt,
    };
  },

  async getPublicScore(entityType: TrustEntityType, entityId: string) {
    const score = await prisma.universalTrustScore.findFirst({
      where: { entityType, entityId, apiAccessEnabled: true },
      select: {
        entityType: true,
        entityId: true,
        overallScore: true,
        tier: true,
        status: true,
        lastCalculatedAt: true,
      },
    });

    if (!score) return null;

    await prisma.universalTrustScore.updateMany({
      where: { entityType, entityId },
      data: { lastAccessedAt: new Date(), accessCount: { increment: 1 } },
    });

    return {
      entityType: score.entityType,
      entityId: score.entityId,
      score: score.overallScore,
      tier: score.tier,
      status: score.status,
      asOf: score.lastCalculatedAt,
    };
  },
};
