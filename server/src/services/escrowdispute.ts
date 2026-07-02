import { prismaManager } from "../lib/prisma";
import { BaseService } from "./base";
import { prisma } from "../lib/prisma";
import { disputeResolver } from "../core/dispute/resolver";
import { isExecutionLocked } from "../lib/config/execution-lock";
import { EventDispatcher } from "../core/events/event-dispatcher";

export class EscrowDisputeService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.escrowDispute, "escrowDispute");
  }

  async openDispute(data: {
    orgId: string;
    reservationId: string;
    escrowAccountId: string;
    openedBy: "TENANT" | "OWNER" | "PLATFORM";
    disputeType: "PROPERTY_DAMAGE" | "LISTING_MISMATCH" | "PAYMENT_DISPUTE" | "EARLY_DEPARTURE" | "CANCELLATION" | "OTHER";
    description: string;
    claimedAmount?: number;
    currency?: string;
    evidence?: Record<string, any>;
    region?: string;
  }) {
    const region = data.region || "US";
    const prisma = prismaManager.getClient(region);

    const forceDispute = isExecutionLocked(region, "forceDisputeResolution");

    const escrow = await prisma.escrowAccount.findUnique({
      where: { id: data.escrowAccountId },
    });
    if (!escrow) throw new Error("Escrow account not found");

    if (escrow.status !== "HOLDING") {
      throw new Error(`Dispute can only be opened while escrow is in HOLDING state. Current: ${escrow.status}`);
    }

    const existingDispute = await prisma.escrowDispute.findFirst({
      where: { escrowAccountId: data.escrowAccountId, status: { in: ["OPEN", "EVIDENCE_COLLECTION", "UNDER_REVIEW"] } },
    });
    if (existingDispute) throw new Error("An active dispute already exists for this escrow account");

    const dispute = await prisma.escrowDispute.create({
      data: {
        orgId: data.orgId,
        reservationId: data.reservationId,
        escrowAccountId: data.escrowAccountId,
        openedBy: data.openedBy as any,
        disputeType: data.disputeType as any,
        description: data.description,
        claimedAmount: data.claimedAmount,
        currency: data.currency || "USD",
        status: "OPEN",
        evidence: data.evidence || {},
        deadlineAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 day deadline
      },
    });

    await prisma.escrowAccount.update({
      where: { id: data.escrowAccountId },
      data: { status: "DISPUTED" },
    });

    await prisma.escrowStatusHistory.create({
      data: {
        escrowId: data.escrowAccountId,
        fromStatus: escrow.status,
        toStatus: "DISPUTED",
        changedBy: data.openedBy,
        reason: `Dispute opened: ${data.disputeType} - ${data.description.slice(0, 100)}`,
      },
    });

    EventDispatcher.emit("DISPUTE_OPENED" as any, {
      disputeId: dispute.id,
      escrowAccountId: data.escrowAccountId,
      region,
      disputeType: data.disputeType,
      openedBy: data.openedBy,
    });

    if (forceDispute) {
      await prisma.escrowRelease.updateMany({
        where: { escrowId: data.escrowAccountId, status: { in: ["PENDING", "SCHEDULED"] } },
        data: { status: "CANCELLED", failureReason: "Dispute opened — releases cancelled" },
      });
    }

    return dispute;
  }

  async submitEvidence(disputeId: string, evidence: Record<string, any>, region: string = "US") {
    const prisma = prismaManager.getClient(region);

    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
    });
    if (!dispute) throw new Error("Dispute not found");

    const existingEvidence = (dispute.evidence as Record<string, any>) || {};
    const mergedEvidence = { ...existingEvidence, ...evidence };

    const updated = await prisma.escrowDispute.update({
      where: { id: disputeId },
      data: {
        evidence: mergedEvidence,
        status: dispute.status === "OPEN" ? "EVIDENCE_COLLECTION" : dispute.status,
      },
    });

    return updated;
  }

  async requestModeratorReview(disputeId: string, region: string = "US") {
    const prisma = prismaManager.getClient(region);

    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
    });
    if (!dispute) throw new Error("Dispute not found");

    const analysis = await disputeResolver.withRegion(region).analyzeDispute(disputeId);

    const updated = await prisma.escrowDispute.update({
      where: { id: disputeId },
      data: { status: "UNDER_REVIEW" },
    });

    return { dispute: updated, analysis };
  }

  async resolveDispute(
    disputeId: string,
    resolvedBy: string,
    region: string = "US"
  ): Promise<any> {
    const analysis = await disputeResolver.withRegion(region).analyzeDispute(disputeId);

    if (analysis.recommendedAction === "ESCALATE_HUMAN") {
      await disputeResolver.withRegion(region).escalateToHuman(disputeId, analysis.reasoning);
      return { status: "ESCALATED", reasoning: analysis.reasoning };
    }

    const resolved = await disputeResolver.withRegion(region).resolveDispute(disputeId, analysis, resolvedBy);

    EventDispatcher.emit("DISPUTE_RESOLVED" as any, {
      disputeId,
      region,
      resolution: analysis.recommendedAction,
      resolvedBy,
    });

    return {
      status: "RESOLVED",
      resolution: analysis.recommendedAction,
      reasoning: analysis.reasoning,
      splitRatio: analysis.splitRatio,
      confidence: analysis.confidence,
    };
  }

  async checkDeadlines(region: string = "US"): Promise<{ escalated: number }> {
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

  async getDisputeTimeline(disputeId: string, region: string = "US") {
    const prisma = prismaManager.getClient(region);
    const dispute = await prisma.escrowDispute.findUnique({
      where: { id: disputeId },
      include: {
        escrowAccount: {
          include: {
            statusHistory: { orderBy: { createdAt: "asc" } },
            releases: { orderBy: { createdAt: "desc" } },
          },
        },
      },
    });
    if (!dispute) return null;

    const analysis = await disputeResolver.withRegion(region).analyzeDispute(disputeId);

    return {
      ...dispute,
      aiAnalysis: analysis,
    };
  }

  async getDisputesByEscrow(escrowAccountId: string, region: string = "US") {
    const prisma = prismaManager.getClient(region);
    return prisma.escrowDispute.findMany({
      where: { escrowAccountId },
      orderBy: { createdAt: "desc" },
    });
  }
}

export const escrowDisputeService = new EscrowDisputeService();
