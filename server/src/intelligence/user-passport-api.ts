/**
 * User Passport API
 * Exposes user intelligence data as a comprehensive user passport
 */

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export interface UserPassport {
  userId: string;
  // User Identity
  userInfo: {
    userPersona?: string;
    buyerType?: string;
    investmentHorizon?: string;
    riskTolerance?: string;
  };
  // Preference Identity
  preferenceInfo: {
    preferredLocations?: any;
    preferredPropertyTypes?: any;
    priceRange?: any;
    budgetAllocation?: any;
  };
  // Behavior Identity
  behaviorInfo: {
    searchBehavior?: any;
    viewingBehavior?: any;
    inquiryBehavior?: any;
    engagementScore: number;
  };
  // AI Identity
  aiInfo: {
    aiRecommendation?: string;
    confidenceScore: number;
    intelligenceVersion: string;
    analysisStatus: string;
  };
  // Investment Identity
  investmentInfo: {
    investmentStrategy?: string;
    portfolioSize?: number;
    investmentCount: number;
    totalROI?: number;
    averageROI?: number;
    investmentScore: number;
    riskProfile?: string;
    aiRecommendation?: string;
  };
  // Metadata
  metadata: {
    createdAt: Date;
    updatedAt: Date;
    lastAnalyzedAt?: Date;
  };
}

export class UserPassportAPI {
  /**
   * Get user passport by user ID
   */
  async getUserPassport(userId: string): Promise<UserPassport | null> {
    try {
      // Fetch user intelligence profile
      const userIntelligenceProfile = await prisma.userIntelligenceProfile.findUnique({
        where: { userId }
      });

      if (!userIntelligenceProfile) {
        return null;
      }

      // Fetch user investment profile
      const userInvestmentProfile = await prisma.userInvestmentProfile.findUnique({
        where: { userId }
      });

      // Build user passport
      const passport: UserPassport = {
        userId: userIntelligenceProfile.userId,
        userInfo: {
          userPersona: userIntelligenceProfile.persona || undefined,
          buyerType: undefined,
          investmentHorizon: userIntelligenceProfile.investmentHorizon || undefined,
          riskTolerance: userIntelligenceProfile.riskTolerance || undefined
        },
        preferenceInfo: {
          preferredLocations: userIntelligenceProfile.preferredLocations || undefined,
          preferredPropertyTypes: userIntelligenceProfile.propertyTypes || undefined,
          priceRange: userIntelligenceProfile.budgetMin && userIntelligenceProfile.budgetMax ? {
            min: userIntelligenceProfile.budgetMin,
            max: userIntelligenceProfile.budgetMax
          } : undefined,
          budgetAllocation: undefined
        },
        behaviorInfo: {
          searchBehavior: undefined,
          viewingBehavior: undefined,
          inquiryBehavior: undefined,
          engagementScore: userIntelligenceProfile.engagementScore
        },
        aiInfo: {
          aiRecommendation: undefined,
          confidenceScore: userIntelligenceProfile.personaConfidence || 0,
          intelligenceVersion: 'v1',
          analysisStatus: 'COMPLETED'
        },
        investmentInfo: userInvestmentProfile ? {
          investmentStrategy: (userInvestmentProfile as any).investmentStrategy || undefined,
          portfolioSize: userInvestmentProfile.portfolioValue || undefined,
          investmentCount: 0,
          totalROI: userInvestmentProfile.portfolioROI || undefined,
          averageROI: userInvestmentProfile.portfolioROI || undefined,
          investmentScore: 0,
          riskProfile: userInvestmentProfile.riskTolerance || undefined,
          aiRecommendation: undefined
        } : {
          investmentStrategy: undefined,
          portfolioSize: undefined,
          investmentCount: 0,
          totalROI: undefined,
          averageROI: undefined,
          investmentScore: 0,
          riskProfile: undefined,
          aiRecommendation: undefined
        },
        metadata: {
          createdAt: userIntelligenceProfile.updatedAt,
          updatedAt: userIntelligenceProfile.updatedAt,
          lastAnalyzedAt: undefined
        }
      };

      return passport;
    } catch (error) {
      console.error('[UserPassportAPI] Failed to get user passport:', error);
      throw error;
    }
  }

  /**
   * Get users by persona
   */
  async getUsersByPersona(persona: string, limit: number = 10): Promise<UserPassport[]> {
    try {
      const profiles = await prisma.userIntelligenceProfile.findMany({
        where: { persona },
        orderBy: {
          engagementScore: 'desc'
        },
        take: limit
      });

      const passports: UserPassport[] = [];

      for (const profile of profiles) {
        const passport = await this.getUserPassport(profile.userId);
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[UserPassportAPI] Failed to get users by persona:', error);
      throw error;
    }
  }

  /**
   * Get high value leads
   */
  async getHighValueLeads(limit: number = 10): Promise<UserPassport[]> {
    try {
      const profiles = await prisma.userIntelligenceProfile.findMany({
        where: {
          conversionProbability: { gt: 0.7 }
        },
        orderBy: {
          conversionProbability: 'desc'
        },
        take: limit
      });

      const passports: UserPassport[] = [];

      for (const profile of profiles) {
        const passport = await this.getUserPassport(profile.userId);
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[UserPassportAPI] Failed to get high value leads:', error);
      throw error;
    }
  }

  /**
   * Get user intelligence statistics
   */
  async getUserIntelligenceStatistics(): Promise<{
    totalUsers: number;
    completedAnalysis: number;
    averageEngagementScore: number;
    averageConversionProbability: number;
    topPersonas: Record<string, number>;
  }> {
    try {
      const totalUsers = await prisma.userIntelligenceProfile.count();

      const profiles = await prisma.userIntelligenceProfile.findMany({
        select: {
          engagementScore: true,
          conversionProbability: true,
          persona: true
        }
      });

      const averageEngagementScore = profiles.length > 0
        ? profiles.reduce((sum: number, p: any) => sum + p.engagementScore, 0) / profiles.length
        : 0;

      const averageConversionProbability = profiles.length > 0
        ? profiles.reduce((sum: number, p: any) => sum + (p.conversionProbability || 0), 0) / profiles.length
        : 0;

      const personaCounts: Record<string, number> = {};
      profiles.forEach((profile: any) => {
        if (profile.persona) {
          personaCounts[profile.persona] = (personaCounts[profile.persona] || 0) + 1;
        }
      });

      return {
        totalUsers,
        completedAnalysis: totalUsers,
        averageEngagementScore,
        averageConversionProbability,
        topPersonas: personaCounts
      };
    } catch (error) {
      console.error('[UserPassportAPI] Failed to get user intelligence statistics:', error);
      throw error;
    }
  }
}

// Singleton instance
export const userPassportAPI = new UserPassportAPI();
