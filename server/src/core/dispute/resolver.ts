import { prismaManager } from "../../lib/prisma";
import { EventDispatcher } from "../events/event-dispatcher";
import { getExecutionLockConfig } from "../../lib/config/execution-lock";

interface DisputeAnalysis {
  recommendedAction: "RELEASE_TO_LANDLORD" | "REFUND_TO_TENANT" | "SPLIT" | "ESCALATE_HUMAN";
  splitRatio: number; // 0-1, portion to landlord
  confidence: number;
  reasoning: string;
  evidenceGaps: string[];
}

export class DisputeResolver {
  private region: string;

  constructor(region: string = "US") {
    this.region = region;
  }

  withRegion(region: string): DisputeResolver {
    this.region = region;
    return this;
  }

  private getConfidenceThreshold(): number {
    return getExecutionLockConfig(this.region).disputeConfidenceThreshold;
  }

  private enforceThreshold(analysis: DisputeAnalysis): DisputeAnalysis {
    if (analysis.confidence < this.getConfidenceThreshold() && analysis.recommendedAction !== "ESCALATE_HUMAN") {
      return {
        ...analysis,
        recommendedAction: "ESCALATE_HUMAN",
        reasoning: `${analysis.reasoning} [Auto-escalated: confidence ${(analysis.confidence * 100).toFixed(0)}% < threshold ${(this.getConfidenceThreshold() * 100).toFixed(0)}%]`,
      };
    }
    return analysis;
  }

  async analyzeDispute(disputeId: string): Promise<DisputeAnalysis> {
    const prisma = prismaManager.getClient(this.region);

    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
      include: {
        escrowAccount: {
          include: {
            reservation: {
              include: {
                contact: true,
                listing: { include: { property: true } },
                payments: true,
              }
            }
          }
        }
      }
    });

    if (!dispute) throw new Error("Dispute not found");

    const evidence = (dispute.evidence as any) || {};
    const evidenceCount = Object.keys(evidence).length;
    const hasPhotos = evidence.photos?.length > 0;
    const hasMessages = evidence.messages?.length > 0;
    const hasReceipts = evidence.receipts?.length > 0;
    const claimAmount = Number(dispute.claimedAmount || 0);
    const totalAmount = Number(dispute.escrowAccount.totalAmount);

    if (dispute.disputeType === "PROPERTY_DAMAGE") {
      return this.enforceThreshold(this.analyzeDamageDispute(dispute, evidenceCount, hasPhotos, hasMessages, hasReceipts, claimAmount, totalAmount));
    }

    if (dispute.disputeType === "PAYMENT_DISPUTE") {
      return this.enforceThreshold(this.analyzePaymentDispute(dispute, evidenceCount, claimAmount, totalAmount));
    }

    if (dispute.disputeType === "LISTING_MISMATCH") {
      return this.enforceThreshold(this.analyzeMismatchDispute(dispute, evidenceCount, hasPhotos, claimAmount, totalAmount));
    }

    return {
      recommendedAction: "ESCALATE_HUMAN",
      splitRatio: 0.5,
      confidence: 0.3,
      reasoning: "Unknown dispute type — requires human review",
      evidenceGaps: ["Full evidence package required"],
    };
  }

  private analyzeDamageDispute(
    dispute: any,
    evidenceCount: number,
    hasPhotos: boolean,
    hasMessages: boolean,
    hasReceipts: boolean,
    claimAmount: number,
    totalAmount: number
  ): DisputeAnalysis {
    const evidenceScore = (hasPhotos ? 30 : 0) + (hasMessages ? 10 : 0) + (hasReceipts ? 25 : 0);
    const claimRatio = claimAmount / Math.max(totalAmount, 1);

    if (evidenceScore >= 55 && claimRatio <= 0.3) {
      return {
        recommendedAction: "RELEASE_TO_LANDLORD",
        splitRatio: 1.0,
        confidence: 0.85,
        reasoning: "Sufficient evidence supports landlord claim. Damage documented with photos and receipts.",
        evidenceGaps: [],
      };
    }

    if (evidenceScore >= 40 && claimRatio > 0.3) {
      return {
        recommendedAction: "SPLIT",
        splitRatio: 0.5,
        confidence: 0.6,
        reasoning: "Partial evidence. Recommended 50/50 split pending additional documentation.",
        evidenceGaps: hasPhotos ? [] : ["Damage photos required"],
      };
    }

    return {
      recommendedAction: "ESCALATE_HUMAN",
      splitRatio: 0.5,
      confidence: 0.3,
      reasoning: "Insufficient evidence for automated resolution. Escalating to human moderator.",
      evidenceGaps: ["Damage photos", "Repair receipts", "Before/after documentation"],
    };
  }

  private analyzePaymentDispute(
    dispute: any,
    evidenceCount: number,
    claimAmount: number,
    totalAmount: number
  ): DisputeAnalysis {
    const ratio = claimAmount / Math.max(totalAmount, 1);

    if (ratio <= 0.1) {
      return {
        recommendedAction: "REFUND_TO_TENANT",
        splitRatio: 0,
        confidence: 0.9,
        reasoning: "Small overcharge — automatic refund recommended.",
        evidenceGaps: [],
      };
    }

    if (evidenceCount >= 2) {
      return {
        recommendedAction: "SPLIT",
        splitRatio: 0.5,
        confidence: 0.7,
        reasoning: "Payment dispute with evidence from both parties. Recommended 50/50 split.",
        evidenceGaps: [],
      };
    }

    return {
      recommendedAction: "ESCALATE_HUMAN",
      splitRatio: 0.5,
      confidence: 0.4,
      reasoning: "Significant payment dispute requires human moderator review.",
      evidenceGaps: ["Payment records", "Communication history"],
    };
  }

  private analyzeMismatchDispute(
    dispute: any,
    evidenceCount: number,
    hasPhotos: boolean,
    claimAmount: number,
    totalAmount: number
  ): DisputeAnalysis {
    if (hasPhotos && evidenceCount >= 2) {
      return {
        recommendedAction: "REFUND_TO_TENANT",
        splitRatio: 0,
        confidence: 0.8,
        reasoning: "Listing mismatch confirmed with photographic evidence. Full refund recommended.",
        evidenceGaps: [],
      };
    }

    return {
      recommendedAction: "SPLIT",
      splitRatio: 0.3,
      confidence: 0.5,
      reasoning: "Claimed mismatch without sufficient evidence. Partial compensation recommended.",
      evidenceGaps: ["Current listing photos", "Property video tour"],
    };
  }

  async escalateToHuman(disputeId: string, reason: string): Promise<any> {
    const prisma = prismaManager.getClient(this.region);

    const updated = await prisma.escrowDispute.update({
      where: { id: disputeId },
      data: {
        status: "ESCALATED",
        moderatorNotes: reason,
        escalatedAt: new Date(),
      },
    });

    EventDispatcher.emit("DISPUTE_ESCALATED" as any, {
      disputeId,
      region: this.region,
      reason,
    });

    return updated;
  }

  async resolveDispute(
    disputeId: string,
    resolution: DisputeAnalysis,
    resolvedBy: string
  ): Promise<any> {
    const prisma = prismaManager.getClient(this.region);

    const resolvedAmount = resolution.splitRatio * (await this.getEscrowTotal(disputeId));

    const updated = await prisma.escrowDispute.update({
      where: { id: disputeId },
      data: {
        status: "RESOLVED",
        resolution: resolution.reasoning,
        resolvedAmount,
        resolvedAt: new Date(),
        resolvedBy,
      },
    });

    if (resolution.recommendedAction === "RELEASE_TO_LANDLORD") {
      await this.releaseToLandlord(disputeId);
    } else if (resolution.recommendedAction === "REFUND_TO_TENANT") {
      await this.refundToTenant(disputeId);
    } else if (resolution.recommendedAction === "SPLIT") {
      await this.splitResolution(disputeId, resolution.splitRatio);
    }

    EventDispatcher.emit("DISPUTE_RESOLVED" as any, {
      disputeId,
      region: this.region,
      resolution: resolution.recommendedAction,
      resolvedAmount,
    });

    return updated;
  }

  private async releaseToLandlord(disputeId: string): Promise<void> {
    const prisma = prismaManager.getClient(this.region);
    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
      include: { escrowAccount: true },
    });
    if (!dispute) return;

    await prisma.escrowAccount.update({
      where: { id: dispute.escrowAccountId },
      data: { status: "FULLY_RELEASED", releasedAt: new Date() },
    });

    await prisma.escrowRelease.create({
      data: {
        orgId: dispute.orgId,
        escrowId: dispute.escrowAccountId,
        triggerEvent: "DISPUTE_RESOLVED",
        releasePercent: 100,
        amount: dispute.escrowAccount.totalAmount,
        currency: dispute.currency,
        status: "COMPLETED",
        releasedAt: new Date(),
        notes: "Auto-release after dispute resolution — full release to landlord",
      },
    });
  }

  private async refundToTenant(disputeId: string): Promise<void> {
    const prisma = prismaManager.getClient(this.region);
    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
      include: { escrowAccount: true },
    });
    if (!dispute) return;

    await prisma.escrowAccount.update({
      where: { id: dispute.escrowAccountId },
      data: { status: "REFUNDED" },
    });
  }

  private async splitResolution(disputeId: string, ratio: number): Promise<void> {
    const prisma = prismaManager.getClient(this.region);
    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
      include: { escrowAccount: true },
    });
    if (!dispute) return;

    const total = Number(dispute.escrowAccount.totalAmount);
    const landlordAmount = total * ratio;
    const tenantAmount = total * (1 - ratio);

    await prisma.escrowAccount.update({
      where: { id: dispute.escrowAccountId },
      data: { status: "PARTIALLY_RELEASED" },
    });
  }

  async checkDeadlines(region: string): Promise<{ escalated: number }> {
    const prisma = prismaManager.getClient(region);
    const now = new Date();

    const overdueDisputes = await prisma.escrowDispute.findMany({
      where: {
        status: { in: ["OPEN", "EVIDENCE_COLLECTION", "UNDER_REVIEW"] },
        deadlineAt: { lte: now },
      },
    });

    let escalated = 0;
    for (const dispute of overdueDisputes) {
      await prisma.escrowDispute.update({
        where: { id: dispute.id },
        data: { status: "ESCALATED", escalatedAt: now },
      });
      escalated++;
    }

    return { escalated };
  }

  private async getEscrowTotal(disputeId: string): Promise<number> {
    const prisma = prismaManager.getClient(this.region);
    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
      include: { escrowAccount: true },
    });
    return Number(dispute?.escrowAccount?.totalAmount || 0);
  }
}

export const disputeResolver = new DisputeResolver();
