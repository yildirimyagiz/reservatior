import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export interface LeadMatchingParams {
  region: string;
  propertyType: string;
  activityLevel: string; // e.g. ACTIVE, HIGH, MEDIUM
}

export interface AgentPerformanceData {
  agentId: string;
  name: string;
  responseSpeedMinutes: number; // lower is better
  successRate: number;          // 0.0 to 1.0 (higher is better)
  availability: boolean;
  recentActivityScore: number;  // 0.0 to 1.0
}

export class AgentMatchingService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).visibilityBudget, "visibilityBudget");
  }

  /**
   * Calculates a composite score for an agent based on their performance metrics
   */
  calculateCompositeScore(performance: AgentPerformanceData): number {
    if (!performance.availability) return 0;

    // Normalize response speed (e.g. 0 to 60 minutes maps to 1.0 to 0.0 score)
    const speedScore = Math.max(0, 1 - performance.responseSpeedMinutes / 60);
    const successWeight = 0.5;
    const speedWeight = 0.3;
    const activityWeight = 0.2;

    const rawScore = 
      performance.successRate * successWeight +
      speedScore * speedWeight +
      performance.recentActivityScore * activityWeight;

    return Math.round(rawScore * 100) / 100;
  }

  /**
   * Resolves a lead matching candidate list
   */
  async matchLeadToAgents(
    leadParams: LeadMatchingParams,
    availableAgents: AgentPerformanceData[]
  ): Promise<{
    bestMatch: AgentPerformanceData & { score: number };
    balancedPerformer: AgentPerformanceData & { score: number };
    risingAgent: AgentPerformanceData & { score: number };
  }> {
    // 1. Resolve budgets for all agents
    const budgets = await prisma.visibilityBudget.findMany({
      where: {
        agentId: { in: availableAgents.map(a => a.agentId) }
      }
    });

    const budgetMap = new Map(budgets.map(b => [b.agentId, b]));

    // 2. Filter eligible agents having remaining visibility budget
    const eligibleAgents = availableAgents.map(agent => {
      const budgetRecord = budgetMap.get(agent.agentId);
      const used = budgetRecord?.used || 0;
      const budgetLimit = budgetRecord?.budget || 100;
      const hasBudget = used < budgetLimit;

      return {
        ...agent,
        score: this.calculateCompositeScore(agent),
        hasBudget,
        usedBudget: used
      };
    }).filter(a => a.score > 0 && a.hasBudget);

    if (eligibleAgents.length < 3) {
      // Fallback: If not enough agents have remaining budget, ignore budget limitations temporarily
      // to ensure we still present 3 candidates.
      eligibleAgents.push(...availableAgents.map(agent => ({
        ...agent,
        score: this.calculateCompositeScore(agent),
        hasBudget: true,
        usedBudget: 0
      })).filter(a => a.score > 0 && !eligibleAgents.some(ea => ea.agentId === a.agentId)));
    }

    // Sort by composite score descending
    eligibleAgents.sort((a, b) => b.score - a.score);

    // 3. Pool Partitioning
    // Top K Pool (top 3 agents)
    const topKPool = eligibleAgents.slice(0, Math.min(3, eligibleAgents.length));

    // Rotation Pool (next set of agents for exploration / fairness)
    const rotationPool = eligibleAgents.slice(topKPool.length);

    // 4. Selection Layer
    // Candidate 1: Best Match (Highest Score in Top K)
    const bestMatch = topKPool[0] || null;

    // Candidate 2: Balanced Performer (2nd Highest in Top K or next best)
    const balancedPerformer = topKPool[1] || topKPool[0];

    // Candidate 3: Rising Agent (Exploration - pick from Rotation Pool or next in line)
    // Preference: An agent in the Rotation Pool who has the lowest budget usage (fairest exposure)
    let risingAgent = rotationPool.length > 0
      ? [...rotationPool].sort((a, b) => a.usedBudget - b.usedBudget)[0]
      : (topKPool[2] || topKPool[0]);

    // Ensure we don't return duplicate objects, fall back to whatever is available
    return {
      bestMatch: {
        agentId: bestMatch.agentId,
        name: bestMatch.name,
        responseSpeedMinutes: bestMatch.responseSpeedMinutes,
        successRate: bestMatch.successRate,
        availability: bestMatch.availability,
        recentActivityScore: bestMatch.recentActivityScore,
        score: bestMatch.score
      },
      balancedPerformer: {
        agentId: balancedPerformer.agentId,
        name: balancedPerformer.name,
        responseSpeedMinutes: balancedPerformer.responseSpeedMinutes,
        successRate: balancedPerformer.successRate,
        availability: balancedPerformer.availability,
        recentActivityScore: balancedPerformer.recentActivityScore,
        score: balancedPerformer.score
      },
      risingAgent: {
        agentId: risingAgent.agentId,
        name: risingAgent.name,
        responseSpeedMinutes: risingAgent.responseSpeedMinutes,
        successRate: risingAgent.successRate,
        availability: risingAgent.availability,
        recentActivityScore: risingAgent.recentActivityScore,
        score: risingAgent.score
      }
    };
  }

  /**
   * Consumes visibility budget when an agent is selected by the user
   */
  async selectAgentAndConsumeBudget(agentId: string) {
    return prisma.visibilityBudget.upsert({
      where: { agentId },
      create: {
        agentId,
        budget: 100,
        used: 1
      },
      update: {
        used: { increment: 1 }
      }
    });
  }

  /**
   * Applies continuous decay to budget usage count (e.g. 15% decay nightly)
   * to ensure smooth budget regeneration instead of hard resets.
   */
  async decayVisibilityBudgets(decayFactor: number = 0.85) {
    return prisma.$executeRawUnsafe(
      `UPDATE "VisibilityBudget" SET "used" = GREATEST(0, FLOOR("used" * ${decayFactor}))`
    ).catch(async () => {
      // Fallback in case PostgreSQL dialect/driver experiences parsing issue in dev:
      const allBudgets = await prisma.visibilityBudget.findMany();
      for (const b of allBudgets) {
        const nextUsed = Math.max(0, Math.floor(b.used * decayFactor));
        await prisma.visibilityBudget.update({
          where: { id: b.id },
          data: { used: nextUsed }
        });
      }
    });
  }
}

export const agentMatchingService = new AgentMatchingService();
