import { prisma } from "../../lib/prisma";
import { TenantTrustProfile, TrustSignalCategory } from "@prisma/client";

const TIER_THRESHOLDS = [
  { min: 90, tier: "DIAMOND" },
  { min: 75, tier: "PLATINUM" },
  { min: 55, tier: "GOLD" },
  { min: 35, tier: "SILVER" },
  { min: 0, tier: "BRONZE" },
];

const SIGNAL_WEIGHTS = {
  PAYMENT_HISTORY: { weight: 0.35, category: "PAYMENT" as TrustSignalCategory },
  LEASE_COMPLETION: { weight: 0.20, category: "BEHAVIOR" as TrustSignalCategory },
  PROPERTY_CARE: { weight: 0.15, category: "BEHAVIOR" as TrustSignalCategory },
  COMMUNICATION: { weight: 0.10, category: "BEHAVIOR" as TrustSignalCategory },
  VERIFICATION: { weight: 0.10, category: "VERIFICATION" as TrustSignalCategory },
  DISPUTE_HISTORY: { weight: 0.10, category: "BEHAVIOR" as TrustSignalCategory },
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

async function fetchPaymentSignals(tenantId: string, orgId?: string) {
  const payments = await prisma.payment.findMany({
    where: { tenantId },
    take: 50,
  });

  const totalPayments = payments.length;
  const onTimePayments = payments.filter(
    (p) => p.status === "PAID" && p.paymentDate && p.dueDate && p.paymentDate <= p.dueDate
  ).length;
  const onTimeRatio = totalPayments > 0 ? onTimePayments / totalPayments : 0.5;

  const totalAmount = payments.reduce((sum, p) => sum + Number(p.amount || 0), 0);
  const paidAmount = payments
    .filter((p) => p.status === "PAID")
    .reduce((sum, p) => sum + Number(p.amount || 0), 0);
  const paymentRatio = totalAmount > 0 ? paidAmount / totalAmount : 0.5;

  return {
    onTimeRatio: Math.round(onTimeRatio * 100) / 100,
    paymentRatio: Math.round(paymentRatio * 100) / 100,
    totalPayments,
    averagePaymentAmount: totalPayments > 0 ? totalAmount / totalPayments : 0,
  };
}

async function fetchLeaseSignals(tenantId: string, orgId?: string) {
  const leases = await prisma.lease.findMany({
    where: { tenantId, orgId },
    orderBy: { createdAt: "desc" },
    take: 10,
  });

  const completedLeases = leases.filter((l) => l.status === "ENDED").length;
  const leaseCompletionRate = leases.length > 0 ? completedLeases / leases.length : 0.5;

  const earlyTerminations = leases.filter((l) => l.status === "TERMINATED" || l.status === "EVICTED_VIA_TECH").length;
  const earlyTerminationRate = leases.length > 0 ? earlyTerminations / leases.length : 0;

  return {
    leaseCompletionRate: Math.round(leaseCompletionRate * 100) / 100,
    earlyTerminationRate: Math.round(earlyTerminationRate * 100) / 100,
    totalLeases: leases.length,
  };
}

async function fetchPropertyMaintenanceSignals(tenantId: string, orgId?: string) {
  const workOrders = await prisma.maintenanceWorkOrder.findMany({
    where: { tenantId: { equals: tenantId } },
    take: 30,
  });

  const tenantReported = workOrders.filter((w) => w.reportedBy === tenantId).length;
  const resolvedOrders = workOrders.filter((w) => w.status === "COMPLETED").length;
  const resolutionRate = workOrders.length > 0 ? resolvedOrders / workOrders.length : 0.75;

  const reviews = await prisma.guestReview.findMany({
    where: { guestId: tenantId },
    take: 20,
  });

  const avgPropertyCareRating =
    reviews.length > 0
      ? reviews.reduce((sum, r) => sum + (r.cleanliness || r.rating || 3), 0) / reviews.length / 5
      : 0.5;

  return {
    resolutionRate: Math.round(resolutionRate * 100) / 100,
    avgPropertyCareRating: Math.round(avgPropertyCareRating * 100) / 100,
    totalWorkOrders: workOrders.length,
  };
}

async function fetchCommunicationSignals(tenantId: string, orgId?: string) {
  const messages = await prisma.message.findMany({
    where: { senderUserId: tenantId, orgId },
    orderBy: { createdAt: "desc" },
    take: 50,
  });

  const responseTimes: number[] = [];
  for (let i = 1; i < messages.length; i++) {
    const prev = messages[i - 1];
    const curr = messages[i];
    if (prev.senderUserId !== curr.senderUserId) {
      const diff = curr.createdAt.getTime() - prev.createdAt.getTime();
      responseTimes.push(diff);
    }
  }

  const avgResponseTimeMs =
    responseTimes.length > 0 ? responseTimes.reduce((a, b) => a + b, 0) / responseTimes.length : 86400000; // 24 hours default
  const responseScore = Math.max(0, 1 - avgResponseTimeMs / (24 * 60 * 60 * 1000));

  return {
    avgResponseTimeHours: Math.round(avgResponseTimeMs / (60 * 60 * 1000) * 100) / 100,
    responseScore: Math.round(responseScore * 100) / 100,
    totalMessages: messages.length,
  };
}

async function fetchVerificationSignals(tenantId: string) {
  const tenant = await prisma.tenant.findUnique({
    where: { id: tenantId },
    include: { User: true },
  });

  if (!tenant) return { verified: false, kycLevel: "NONE" };

  const identityVerified = tenant.User?.emailVerified || false;
  const hasFinancialProfile = await prisma.tenantFinancialProfile.findUnique({
    where: { tenantId },
  });

  const kycLevel = hasFinancialProfile ? "FULL" : identityVerified ? "BASIC" : "NONE";
  const verificationScore = kycLevel === "FULL" ? 100 : kycLevel === "BASIC" ? 70 : 0;

  return {
    verified: identityVerified,
    kycLevel,
    verificationScore,
  };
}

async function fetchDisputeSignals(tenantId: string, orgId?: string) {
  const disputes = await prisma.bookingSecurityScreening.findMany({
    take: 20,
  });

  const highRiskDisputes = disputes.filter((d) => d.riskLevel === "HIGH").length;
  const disputeRate = disputes.length > 0 ? highRiskDisputes / disputes.length : 0;

  return {
    totalDisputes: disputes.length,
    highRiskDisputes,
    disputeRate: Math.round(disputeRate * 100) / 100,
  };
}

export const tenantTrustScoreService = {
  async calculateTrustScore(tenantId: string, orgId?: string): Promise<TenantTrustProfile> {
    const [paymentSignals, leaseSignals, propertyCareSignals, communicationSignals, verificationSignals, disputeSignals] =
      await Promise.all([
        fetchPaymentSignals(tenantId, orgId),
        fetchLeaseSignals(tenantId, orgId),
        fetchPropertyMaintenanceSignals(tenantId, orgId),
        fetchCommunicationSignals(tenantId, orgId),
        fetchVerificationSignals(tenantId),
        fetchDisputeSignals(tenantId, orgId),
      ]);

    const signalScores = {
      PAYMENT_HISTORY: paymentSignals.onTimeRatio * 100,
      LEASE_COMPLETION: leaseSignals.leaseCompletionRate * 100,
      PROPERTY_CARE: propertyCareSignals.resolutionRate * 100,
      COMMUNICATION: communicationSignals.responseScore * 100,
      VERIFICATION: verificationSignals.verificationScore,
      DISPUTE_HISTORY: (1 - disputeSignals.disputeRate) * 100,
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

    const existingProfile = await prisma.tenantTrustProfile.findUnique({
      where: { tenantId },
    });

    const riskFactors: string[] = [];
    const positiveFactors: string[] = [];

    if (paymentSignals.onTimeRatio < 0.7) riskFactors.push("Low on-time payment rate");
    if (leaseSignals.earlyTerminationRate > 0.3) riskFactors.push("High early termination rate");
    if (disputeSignals.disputeRate > 0.2) riskFactors.push("High dispute rate");
    if (verificationSignals.kycLevel === "NONE") riskFactors.push("No identity verification");

    if (paymentSignals.onTimeRatio >= 0.95) positiveFactors.push("Excellent payment history");
    if (leaseSignals.leaseCompletionRate >= 0.9) positiveFactors.push("High lease completion rate");
    if (verificationSignals.kycLevel === "FULL") positiveFactors.push("Full KYC verification");

    const profileData = {
      overallScore,
      paymentScore: Math.round(paymentSignals.onTimeRatio * 100) / 100,
      leaseCompletionRate: Math.round(leaseSignals.leaseCompletionRate * 100) / 100,
      propertyCareScore: Math.round(propertyCareSignals.avgPropertyCareRating * 100) / 100,
      communicationScore: Math.round(communicationSignals.responseScore * 100) / 100,
      verificationStatus: verificationSignals.kycLevel,
      disputeRate: Math.round(disputeSignals.disputeRate * 100) / 100,
      riskFactors,
      positiveFactors,
      lastCalculatedAt: new Date(),
    };

    if (existingProfile) {
      return await prisma.tenantTrustProfile.update({
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
      return await prisma.tenantTrustProfile.create({
        data: {
          tenantId,
          userId: (await prisma.tenant.findUnique({ where: { id: tenantId } }))?.userId || "",
          ...profileData,
          calculationVersion: 1,
          scoreHistory: {
            [new Date().toISOString()]: overallScore,
          },
        },
      });
    }
  },

  async getTrustProfile(tenantId: string): Promise<TenantTrustProfile | null> {
    return await prisma.tenantTrustProfile.findUnique({
      where: { tenantId },
      include: {
        tenant: {
          include: { User: true },
        },
      },
    });
  },

  async recordTrustEvent(
    tenantId: string,
    eventType: string,
    category: TrustSignalCategory,
    impact: number,
    metadata?: any
  ) {
    const profile = await prisma.tenantTrustProfile.findUnique({
      where: { tenantId },
    });

    if (!profile) {
      await this.calculateTrustScore(tenantId);
      return;
    }

    const newScore = Math.min(100, Math.max(0, profile.overallScore + impact));
    const newTier = assignTier(newScore);

    await prisma.tenantTrustProfile.update({
      where: { tenantId },
      data: {
        overallScore: Math.round(newScore * 100) / 100,
        calculationVersion: { increment: 1 },
        lastCalculatedAt: new Date(),
      },
    });
  },

  async getTrustHistory(tenantId: string, limit: number = 30) {
    const profile = await prisma.tenantTrustProfile.findUnique({
      where: { tenantId },
    });

    if (!profile) return null;

    const history = profile.scoreHistory as Record<string, number>;
    const entries = Object.entries(history)
      .sort((a, b) => new Date(b[0]).getTime() - new Date(a[0]).getTime())
      .slice(0, limit);

    return entries.map(([date, score]) => ({ date, score }));
  },
};
