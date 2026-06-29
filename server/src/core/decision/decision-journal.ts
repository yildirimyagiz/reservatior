import { PrismaClient } from "@prisma/client";

// Use a shared instance or instantiate here. Using a local instance for the module.
const prisma = new PrismaClient();

export class DecisionJournalService {
  static async logDecision(params: {
    eventName: string;
    decision: string;
    reason: string;
    confidence: number;
    outcome?: string;
    revenueImpact?: number;
    feedback?: string;
  }) {
    try {
      // @ts-ignore - Prisma client cache issue in IDE
      await prisma.decisionJournal.create({
        data: {
          eventName: params.eventName,
          decision: params.decision,
          reason: params.reason,
          confidence: params.confidence,
          outcome: params.outcome,
          revenueImpact: params.revenueImpact,
          feedback: params.feedback,
        }
      });
      console.log(`[DecisionJournal] Logged: ${params.decision} (Confidence: ${params.confidence})`);
    } catch (error) {
      console.error("[DecisionJournal] Failed to log decision:", error);
    }
  }
}
