import { prisma } from "../lib/prisma";
import { prismaManager } from "../lib/prisma";
import { BaseService } from "./base";
import { reputationEngine } from "./reputation/reputation-engine";
import { distributionEngine } from "./distribution/distribution-engine";

export interface LeadMatchingParams {
  region: string;
  propertyType: string;
  activityLevel: string;
  listingId?: string;
}

export interface AgentPerformanceData {
  agentId: string;
  name: string;
  responseSpeedMinutes: number;
  successRate: number;
  availability: boolean;
  recentActivityScore: number;
  reputationScore?: number;
}

export class AgentMatchingService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).visibilityBudget, "visibilityBudget");
  }

  calculateCompositeScore(performance: AgentPerformanceData): number {
    if (!performance.availability) return 0;

    const speedScore = Math.max(0, 1 - performance.responseSpeedMinutes / 60);
    const reputationWeight = performance.reputationScore !== undefined ? 0.15 : 0;
    const successWeight = 0.40 - reputationWeight;
    const speedWeight = 0.25;
    const activityWeight = 0.20;

    const rawScore =
      performance.successRate * successWeight +
      speedScore * speedWeight +
      performance.recentActivityScore * activityWeight +
      (performance.reputationScore || 0) * reputationWeight;

    return Math.round(rawScore * 100) / 100;
  }

  async matchLeadToAgents(
    leadParams: LeadMatchingParams,
    availableAgents: AgentPerformanceData[]
  ): Promise<{
    bestMatch: AgentPerformanceData & { score: number };
    balancedPerformer: AgentPerformanceData & { score: number };
    risingAgent: AgentPerformanceData & { score: number };
  }> {
    const budgets = await prisma.visibilityBudget.findMany({
      where: {
        agentId: { in: availableAgents.map(a => a.agentId) }
      }
    });

    const budgetMap = new Map(budgets.map(b => [b.agentId, b]));

    const enrichedAgents = await Promise.all(
      availableAgents.map(async (agent) => {
        let reputationScore = 0;
        try {
          const rep = await reputationEngine.calculateAgentScore(agent.agentId, leadParams.region);
          reputationScore = rep.totalScore;
        } catch {}
        return { ...agent, reputationScore };
      })
    );

    const eligibleAgents = enrichedAgents.map(agent => {
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
      eligibleAgents.push(...enrichedAgents.map(agent => ({
        ...agent,
        score: this.calculateCompositeScore(agent),
        hasBudget: true,
        usedBudget: 0
      })).filter(a => a.score > 0 && !eligibleAgents.some(ea => ea.agentId === a.agentId)));
    }

    eligibleAgents.sort((a, b) => b.score - a.score);

    const topKPool = eligibleAgents.slice(0, Math.min(3, eligibleAgents.length));
    const rotationPool = eligibleAgents.slice(topKPool.length);

    const bestMatch = topKPool[0] || null;
    const balancedPerformer = topKPool[1] || topKPool[0];
    let risingAgent = rotationPool.length > 0
      ? [...rotationPool].sort((a, b) => a.usedBudget - b.usedBudget)[0]
      : (topKPool[2] || topKPool[0]);

    return {
      bestMatch: this.formatResult(bestMatch),
      balancedPerformer: this.formatResult(balancedPerformer),
      risingAgent: this.formatResult(risingAgent),
    };
  }

  async matchLeadWithDistribution(leadParams: LeadMatchingParams): Promise<any> {
    if (leadParams.listingId) {
      try {
        const distribution = await distributionEngine.distributeListing(leadParams.listingId, leadParams.region);
        if (distribution.priority === "HIGH") {
          const agents = await this.getAgentsByIds(distribution.recommendedAgents, leadParams.region);
          if (agents.length >= 3) {
            return this.matchLeadToAgents(leadParams, agents);
          }
        }
      } catch {}
    }

    const defaultAgents = await this.getDefaultAgents(leadParams);
    return this.matchLeadToAgents(leadParams, defaultAgents);
  }

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

  async decayVisibilityBudgets(decayFactor: number = 0.85) {
    return prisma.$executeRawUnsafe(
      `UPDATE "VisibilityBudget" SET "used" = GREATEST(0, FLOOR("used" * ${decayFactor}))`
    ).catch(async () => {
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

  private formatResult(agent: any) {
    if (!agent) return null;
    return {
      agentId: agent.agentId,
      name: agent.name,
      responseSpeedMinutes: agent.responseSpeedMinutes,
      successRate: agent.successRate,
      availability: agent.availability,
      recentActivityScore: agent.recentActivityScore,
      score: agent.score,
    };
  }

  private async getAgentsByIds(agentIds: string[], region: string): Promise<AgentPerformanceData[]> {
    const prisma = prismaManager.getClient(region);
    const agents = await prisma.agent.findMany({
      where: { id: { in: agentIds }, isActive: true },
      include: { agentPerformances: { orderBy: { endDate: "desc" }, take: 2 } },
    });

    return agents.map(a => {
      const perf = a.agentPerformances?.[0];
      return {
        agentId: a.id,
        name: a.name || a.user?.name || "Agent",
        responseSpeedMinutes: 30,
        successRate: perf ? perf.dealsClosed / Math.max(perf.leadsGenerated, 1) : 0.3,
        availability: true,
        recentActivityScore: perf ? Math.min(perf.leadsGenerated / 20, 1) : 0.5,
      };
    });
  }

  private async getDefaultAgents(params: LeadMatchingParams): Promise<AgentPerformanceData[]> {
    const prisma = prismaManager.getClient(params.region);
    const agents = await prisma.agent.findMany({
      where: { isActive: true },
      include: { agentPerformances: { orderBy: { endDate: "desc" }, take: 2 } },
      take: 10,
    });

    return agents.map(a => {
      const perf = a.agentPerformances?.[0];
      return {
        agentId: a.id,
        name: a.name || "Agent",
        responseSpeedMinutes: 30,
        successRate: perf ? perf.dealsClosed / Math.max(perf.leadsGenerated, 1) : 0.3,
        availability: true,
        recentActivityScore: perf ? Math.min(perf.leadsGenerated / 20, 1) : 0.5,
      };
    });
  }
}

export const agentMatchingService = new AgentMatchingService();
