/**
 * Agent Passport API
 * Exposes Agent Intelligence Data as a comprehensive Agent Passport
 */

import { PrismaClient } from '@prisma/client';
import { agentIntelligenceAgent, AgentMatchInput, AgentMatchResult } from './agent-intelligence-agent';

const prisma = new PrismaClient();

export interface AgentPassportResponse {
  agentId: string;
  agentInfo: {
    name?: string;
    agencyId?: string;
    tierLevel?: string;
    monthlyRevenue?: number;
  };
  intelligenceProfile: {
    performanceScore: number;
    conversionRate: number;
    marketExpertise: number;
    propertyMatchingAccuracy: number;
    clientSatisfaction: number;
    revenueContribution: number;
    leadConversionRate: number;
    expertiseAreas: any;
    specialization: any;
  };
  aiRecommendation: string;
  updatedAt: Date;
}

export class AgentPassportAPI {
  /**
   * Get live Agent Passport by Agent ID
   */
  async getAgentPassport(agentId: string): Promise<AgentPassportResponse | null> {
    try {
      const agent = await prisma.agent.findUnique({
        where: { id: agentId }
      });

      if (!agent) {
        return null;
      }

      let profile = await prisma.agentIntelligenceProfile.findUnique({
        where: { agentId }
      });

      // Compute if not exists
      if (!profile) {
        const passport = await agentIntelligenceAgent.processAgentIntelligence({ agentId });
        profile = await prisma.agentIntelligenceProfile.findUnique({
          where: { agentId }
        });
      }

      if (!profile) {
        return null;
      }

      return {
        agentId,
        agentInfo: {
          name: agent.name,
          agencyId: agent.agencyId || undefined,
          tierLevel: agent.tierLevel || undefined,
          monthlyRevenue: agent.monthlyRevenue ? Number(agent.monthlyRevenue) : undefined
        },
        intelligenceProfile: {
          performanceScore: profile.performanceScore,
          conversionRate: profile.conversionRate,
          marketExpertise: profile.marketExpertise,
          propertyMatchingAccuracy: profile.propertyMatchingAccuracy,
          clientSatisfaction: profile.clientSatisfaction,
          revenueContribution: profile.revenueContribution,
          leadConversionRate: profile.leadConversionRate,
          expertiseAreas: profile.expertiseAreas,
          specialization: profile.specialization
        },
        aiRecommendation: profile.performanceScore > 85 ? 'PREMIUM_ADVISOR' : 'TOP_PERFORMER',
        updatedAt: profile.updatedAt
      };
    } catch (error) {
      console.error(`[AgentPassportAPI] Failed to fetch agent passport for ${agentId}:`, error);
      throw error;
    }
  }

  /**
   * Smart Agent Matching Uç Noktası: Yatırımcı (User Passport) ve Pazar (Market Passport) verilerine göre en iyi 3 acentayı önerir
   */
  async matchBestAgents(matchInput: AgentMatchInput): Promise<AgentMatchResult[]> {
    return agentIntelligenceAgent.matchAgentsForInvestor(matchInput);
  }
}

export const agentPassportAPI = new AgentPassportAPI();
