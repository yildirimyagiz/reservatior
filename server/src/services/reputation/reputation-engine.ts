import { prismaManager } from "../../lib/prisma";
import { signalRegistry, SignalCategory, SignalVisibility } from "./signal-registry";

export interface ReputationScore {
  totalScore: number;
  publicScore: number;
  breakdown: Record<string, number>;
  internalSignalsUsed: string[];
  lastUpdated: Date;
}

export class ReputationEngine {
  async calculateAgentScore(agentId: string, region: string = "US"): Promise<ReputationScore> {
    const prisma = prismaManager.getClient(region);
    const agent = await prisma.agent.findUnique({
      where: { id: agentId },
      include: {
        agentPerformances: { orderBy: { endDate: "desc" }, take: 4 },
        Review: true,
      },
    });
    if (!agent) throw new Error("Agent not found");

    const disputes = await prisma.escrowDispute.findMany({
      where: {
        status: { in: ["RESOLVED", "CLOSED", "ESCALATED"] },
        escrowAccount: {
          reservation: {
            listing: { agentId },
          },
        },
      },
    });

    const performances = agent.agentPerformances;
    const totalDeals = performances.reduce((sum, p) => sum + p.dealsClosed, 0);
    const totalLeads = performances.reduce((sum, p) => sum + p.leadsGenerated, 0);
    const successRate = totalLeads > 0 ? totalDeals / totalLeads : 0;

    const reviews = agent.Review || [];
    const tenantFeedback = reviews.filter(r => r.targetType === "TENANT").reduce((sum, r) => sum + (r.rating || 0), 0) / Math.max(reviews.filter(r => r.targetType === "TENANT").length, 1) / 5;
    const landlordFeedback = reviews.filter(r => r.targetType === "LANDLORD").reduce((sum, r) => sum + (r.rating || 0), 0) / Math.max(reviews.filter(r => r.targetType === "LANDLORD").length, 1) / 5;

    const totalTransactions = totalDeals;
    const disputeRatio = Math.min(disputes.length / Math.max(totalTransactions, 1), 1);

    const completedViewings = performances.reduce((sum, p) => sum + p.showingsCompleted, 0);
    const responseSpeedScore = totalLeads > 0 ? Math.min(completedViewings / totalLeads * 100, 100) : 50;

    const platformLoyaltyDays = this.calculateTenureDays(agent.createdAt);
    const loyaltyScore = Math.min(platformLoyaltyDays / 365, 1);

    const publicSignals = signalRegistry.getPublicSignals();
    const internalSignals = signalRegistry.getInternalSignals();

    const breakdown: Record<string, number> = {};
    for (const signal of publicSignals) {
      breakdown[signal.key] = this.extractAgentSignalValue(signal.key, { successRate, tenantFeedback, landlordFeedback, disputeRatio, responseSpeedScore, loyaltyScore, totalTransactions });
    }
    for (const signal of internalSignals) {
      breakdown[signal.key] = this.extractAgentSignalValue(signal.key, { successRate, tenantFeedback, landlordFeedback, disputeRatio, responseSpeedScore, loyaltyScore, totalTransactions });
    }

    const totalScore = this.computeWeightedScore(breakdown, [...publicSignals, ...internalSignals]);
    const publicScore = this.computeWeightedScore(breakdown, publicSignals);

    return {
      totalScore: Math.round(totalScore * 100) / 100,
      publicScore: Math.round(publicScore * 100) / 100,
      breakdown,
      internalSignalsUsed: internalSignals.map(s => s.key),
      lastUpdated: new Date(),
    };
  }

  async calculateTenantScore(tenantId: string, region: string = "US"): Promise<ReputationScore> {
    const prisma = prismaManager.getClient(region);
    const tenant = await prisma.tenant.findUnique({
      where: { id: tenantId },
      include: {
        Payment: true,
        Lease: true,
      },
    });
    if (!tenant) throw new Error("Tenant not found");

    const totalPayments = tenant.Payment.length;
    const onTimePayments = tenant.Payment.filter(p => p.paymentDate && p.dueDate && new Date(p.paymentDate) <= new Date(p.dueDate)).length;
    const paymentReliability = totalPayments > 0 ? onTimePayments / totalPayments : 0;

    const completedLeases = tenant.Lease.filter(l => l.status === "ENDED" || l.status === "ARCHIVED").length;
    const terminatedLeases = tenant.Lease.filter(l => l.status === "TERMINATED").length;
    const leaseCompletion = (totalPayments > 0 ? completedLeases / Math.max(completedLeases + terminatedLeases, 1) : 0.5);

    const landlordFeedback = 0.5;

    const disputeRatio = 0;

    const internalBehaviorScore = (paymentReliability * 0.4 + (1 - disputeRatio) * 0.3 + leaseCompletion * 0.3);

    const signals = signalRegistry.getSignalsByCategory(SignalCategory.TENANT);
    const publicSignals = signals.filter(s => s.visibility === SignalVisibility.PUBLIC);
    const internalSignals = signals.filter(s => s.visibility === SignalVisibility.INTERNAL);

    const breakdown: Record<string, number> = {};
    breakdown["payment_reliability"] = paymentReliability;
    breakdown["lease_completion"] = leaseCompletion;
    breakdown["landlord_feedback_tenant"] = landlordFeedback;
    breakdown["internal_behavior_score"] = internalBehaviorScore;
    breakdown["cross_reference_consistency"] = Math.min(paymentReliability * 0.8 + leaseCompletion * 0.2, 1);
    breakdown["referral_quality"] = 0.5;

    const totalScore = this.computeWeightedScore(breakdown, signals);
    const publicScore = this.computeWeightedScore(breakdown, publicSignals);

    return {
      totalScore: Math.round(totalScore * 100) / 100,
      publicScore: Math.round(publicScore * 100) / 100,
      breakdown,
      internalSignalsUsed: internalSignals.map(s => s.key),
      lastUpdated: new Date(),
    };
  }

  async getPublicExport(agentId: string, region: string = "US"): Promise<{ publicScore: number; lastUpdated: Date }> {
    const score = await this.calculateAgentScore(agentId, region);
    return { publicScore: score.publicScore, lastUpdated: score.lastUpdated };
  }

  private extractAgentSignalValue(
    key: string,
    data: { successRate: number; tenantFeedback: number; landlordFeedback: number; disputeRatio: number; responseSpeedScore: number; loyaltyScore: number; totalTransactions: number }
  ): number {
    switch (key) {
      case "success_rate": return data.successRate;
      case "response_speed": return data.responseSpeedScore / 100;
      case "tenant_feedback": return data.tenantFeedback;
      case "landlord_feedback": return data.landlordFeedback;
      case "platform_loyalty": return data.loyaltyScore;
      case "dispute_history_ratio": return 1 - data.disputeRatio;
      case "cross_party_consistency": return Math.abs(data.tenantFeedback - data.landlordFeedback) <= 0.2 ? 1 : 0.5;
      case "lead_to_viewing_ratio": return Math.min(data.responseSpeedScore / 100, 1);
      default: return 0.5;
    }
  }

  private computeWeightedScore(breakdown: Record<string, number>, signals: { key: string; weight: number }[]): number {
    let score = 0;
    let totalWeight = 0;
    for (const signal of signals) {
      const value = breakdown[signal.key];
      if (value !== undefined) {
        score += value * signal.weight;
        totalWeight += signal.weight;
      }
    }
    return totalWeight > 0 ? score / totalWeight : 0;
  }

  private calculateTenureDays(createdAt: Date): number {
    return Math.floor((new Date().getTime() - new Date(createdAt).getTime()) / (1000 * 60 * 60 * 24));
  }
}

export const reputationEngine = new ReputationEngine();
