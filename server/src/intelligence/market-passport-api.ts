/**
 * Market Passport API
 * Exposes market intelligence data as a comprehensive market passport
 */

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export interface MarketPassport {
  locationId: string;
  // Location Identity
  locationInfo: {
    countryIsoCode: string;
    citySlug: string;
    districtSlug?: string;
    neighborhoodSlug?: string;
  };
  // Market Identity
  marketInfo: {
    averagePricePerSqm?: number;
    medianPrice?: number;
    supplyScore: number;
    demandScore: number;
    transactionVelocity: number;
    liquidityScore: number;
  };
  // Rental Identity
  rentalInfo: {
    averageRentalYield: number;
    occupancyRate: number;
  };
  // Foreign Investment
  foreignInvestmentInfo: {
    foreignBuyerRatio: number;
    internationalDemandScore: number;
  };
  // Growth Identity
  growthInfo: {
    priceGrowth1Y: number;
    priceGrowth3Y: number;
    priceGrowth5Y: number;
  };
  // AI Identity
  aiInfo: {
    marketPhase?: string;
    aiRecommendation?: string;
    confidenceScore: number;
    intelligenceVersion: string;
    analysisStatus: string;
  };
  // Opportunity Score
  opportunityScore: {
    growthScore: number;
    rentalScore: number;
    demandScore: number;
    liquidityScore: number;
    riskScore: number;
    overallScore: number;
    recommendation?: string;
  };
  // Digital Twin
  digitalTwin?: {
    currentState: any;
    scenarios: any[];
    predictions: any;
    assumptions: any;
    modelVersion: string;
    confidenceScore: number;
  };
  // Metadata
  metadata: {
    createdAt: Date;
    updatedAt: Date;
    lastAnalyzedAt?: Date;
  };
}

export class MarketPassportAPI {
  /**
   * Get market passport by location
   */
  async getMarketPassport(
    countryIsoCode: string,
    citySlug: string,
    districtSlug?: string,
    neighborhoodSlug?: string
  ): Promise<MarketPassport | null> {
    try {
      // Fetch market intelligence profile
      const marketProfile = await prisma.marketIntelligenceProfile.findUnique({
        where: {
          countryIsoCode_citySlug_districtSlug_neighborhoodSlug: {
            countryIsoCode,
            citySlug,
            districtSlug: districtSlug || null,
            neighborhoodSlug: neighborhoodSlug || null
          }
        }
      });

      if (!marketProfile) {
        return null;
      }

      // Fetch opportunity score
      const opportunityScore = await prisma.marketOpportunityScore.findFirst({
        where: { locationId: marketProfile.id }
      });

      // Fetch digital twin
      const digitalTwin = await prisma.marketDigitalTwin.findUnique({
        where: { locationId: marketProfile.id }
      });

      // Build market passport
      const passport: MarketPassport = {
        locationId: marketProfile.id,
        locationInfo: {
          countryIsoCode: marketProfile.countryIsoCode,
          citySlug: marketProfile.citySlug,
          districtSlug: marketProfile.districtSlug || undefined,
          neighborhoodSlug: marketProfile.neighborhoodSlug || undefined
        },
        marketInfo: {
          averagePricePerSqm: marketProfile.averagePricePerSqm ? Number(marketProfile.averagePricePerSqm) : undefined,
          medianPrice: marketProfile.medianPrice ? Number(marketProfile.medianPrice) : undefined,
          supplyScore: marketProfile.supplyScore,
          demandScore: marketProfile.demandScore,
          transactionVelocity: marketProfile.transactionVelocity,
          liquidityScore: marketProfile.liquidityScore
        },
        rentalInfo: {
          averageRentalYield: marketProfile.averageRentalYield,
          occupancyRate: marketProfile.occupancyRate
        },
        foreignInvestmentInfo: {
          foreignBuyerRatio: marketProfile.foreignBuyerRatio,
          internationalDemandScore: marketProfile.internationalDemandScore
        },
        growthInfo: {
          priceGrowth1Y: marketProfile.priceGrowth1Y,
          priceGrowth3Y: marketProfile.priceGrowth3Y,
          priceGrowth5Y: marketProfile.priceGrowth5Y
        },
        aiInfo: {
          marketPhase: marketProfile.marketPhase || undefined,
          aiRecommendation: marketProfile.aiRecommendation || undefined,
          confidenceScore: marketProfile.confidenceScore,
          intelligenceVersion: marketProfile.intelligenceVersion,
          analysisStatus: marketProfile.analysisStatus
        },
        opportunityScore: opportunityScore ? {
          growthScore: opportunityScore.growthScore,
          rentalScore: opportunityScore.rentalScore,
          demandScore: opportunityScore.demandScore,
          liquidityScore: opportunityScore.liquidityScore,
          riskScore: opportunityScore.riskScore,
          overallScore: opportunityScore.overallScore,
          recommendation: opportunityScore.recommendation || undefined
        } : {
          growthScore: 0,
          rentalScore: 0,
          demandScore: 0,
          liquidityScore: 0,
          riskScore: 0,
          overallScore: 0
        },
        digitalTwin: digitalTwin ? {
          currentState: digitalTwin.currentState,
          scenarios: digitalTwin.scenarios as any[],
          predictions: digitalTwin.predictions,
          assumptions: digitalTwin.assumptions,
          modelVersion: digitalTwin.modelVersion,
          confidenceScore: digitalTwin.confidenceScore
        } : undefined,
        metadata: {
          createdAt: marketProfile.createdAt,
          updatedAt: marketProfile.updatedAt,
          lastAnalyzedAt: marketProfile.lastAnalyzedAt || undefined
        }
      };

      return passport;
    } catch (error) {
      console.error('[MarketPassportAPI] Failed to get market passport:', error);
      throw error;
    }
  }

  /**
   * Get market trends for a location
   */
  async getMarketTrends(locationId: string, limit: number = 10): Promise<any[]> {
    try {
      const trends = await prisma.marketTrend.findMany({
        where: { locationId },
        orderBy: { detectedAt: 'desc' },
        take: limit
      });

      return trends.map((trend: any) => ({
        metric: trend.metric,
        previousValue: trend.previousValue,
        currentValue: trend.currentValue,
        changePercentage: trend.changePercentage,
        trendDirection: trend.trendDirection,
        confidence: trend.confidence,
        aiInsight: trend.aiInsight,
        detectedAt: trend.detectedAt
      }));
    } catch (error) {
      console.error('[MarketPassportAPI] Failed to get market trends:', error);
      throw error;
    }
  }

  /**
   * Get top markets by opportunity score
   */
  async getTopMarketsByOpportunityScore(
    countryIsoCode?: string,
    citySlug?: string,
    limit: number = 10
  ): Promise<MarketPassport[]> {
    try {
      const opportunityScores = await prisma.marketOpportunityScore.findMany({
        where: {
          ...(countryIsoCode && { marketProfile: { countryIsoCode } }),
          ...(citySlug && { marketProfile: { citySlug } })
        },
        orderBy: {
          overallScore: 'desc'
        },
        take: limit,
        include: {
          marketProfile: true
        }
      });

      const passports: MarketPassport[] = [];

      for (const score of opportunityScores) {
        const passport = await this.getMarketPassport(
          score.marketProfile.countryIsoCode,
          score.marketProfile.citySlug,
          score.marketProfile.districtSlug || undefined,
          score.marketProfile.neighborhoodSlug || undefined
        );
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[MarketPassportAPI] Failed to get top markets:', error);
      throw error;
    }
  }

  /**
   * Get markets by recommendation
   */
  async getMarketsByRecommendation(
    recommendation: string,
    limit: number = 10
  ): Promise<MarketPassport[]> {
    try {
      const opportunityScores = await prisma.marketOpportunityScore.findMany({
        where: { recommendation },
        orderBy: {
          overallScore: 'desc'
        },
        take: limit,
        include: {
          marketProfile: true
        }
      });

      const passports: MarketPassport[] = [];

      for (const score of opportunityScores) {
        const passport = await this.getMarketPassport(
          score.marketProfile.countryIsoCode,
          score.marketProfile.citySlug,
          score.marketProfile.districtSlug || undefined,
          score.marketProfile.neighborhoodSlug || undefined
        );
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[MarketPassportAPI] Failed to get markets by recommendation:', error);
      throw error;
    }
  }

  /**
   * Get markets by market phase
   */
  async getMarketsByPhase(
    phase: string,
    limit: number = 10
  ): Promise<MarketPassport[]> {
    try {
      const marketProfiles = await prisma.marketIntelligenceProfile.findMany({
        where: {
          marketPhase: phase,
          analysisStatus: 'COMPLETED'
        },
        orderBy: {
          demandScore: 'desc'
        },
        take: limit
      });

      const passports: MarketPassport[] = [];

      for (const profile of marketProfiles) {
        const passport = await this.getMarketPassport(
          profile.countryIsoCode,
          profile.citySlug,
          profile.districtSlug || undefined,
          profile.neighborhoodSlug || undefined
        );
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[MarketPassportAPI] Failed to get markets by phase:', error);
      throw error;
    }
  }

  /**
   * Get market intelligence statistics
   */
  async getMarketIntelligenceStatistics(): Promise<{
    totalLocations: number;
    completedAnalysis: number;
    pendingAnalysis: number;
    failedAnalysis: number;
    averageDemandScore: number;
    averageGrowthScore: number;
    averageOverallScore: number;
    topPhases: Record<string, number>;
    topRecommendations: Record<string, number>;
  }> {
    try {
      const totalLocations = await prisma.marketIntelligenceProfile.count();
      const completedAnalysis = await prisma.marketIntelligenceProfile.count({
        where: { analysisStatus: 'COMPLETED' }
      });
      const pendingAnalysis = await prisma.marketIntelligenceProfile.count({
        where: { analysisStatus: 'PENDING' }
      });
      const failedAnalysis = await prisma.marketIntelligenceProfile.count({
        where: { analysisStatus: 'FAILED' }
      });

      const completedProfiles = await prisma.marketIntelligenceProfile.findMany({
        where: { analysisStatus: 'COMPLETED' },
        select: {
          demandScore: true,
          priceGrowth1Y: true
        }
      });

      const averageDemandScore = completedProfiles.length > 0
        ? completedProfiles.reduce((sum: number, p: any) => sum + p.demandScore, 0) / completedProfiles.length
        : 0;

      const averageGrowthScore = completedProfiles.length > 0
        ? completedProfiles.reduce((sum: number, p: any) => sum + p.priceGrowth1Y, 0) / completedProfiles.length
        : 0;

      const opportunityScores = await prisma.marketOpportunityScore.findMany({
        select: {
          overallScore: true
        }
      });

      const averageOverallScore = opportunityScores.length > 0
        ? opportunityScores.reduce((sum: number, s: any) => sum + s.overallScore, 0) / opportunityScores.length
        : 0;

      const phaseCounts = await prisma.marketIntelligenceProfile.groupBy({
        by: ['marketPhase'],
        _count: true,
        where: {
          marketPhase: { not: null },
          analysisStatus: 'COMPLETED'
        }
      });

      const topPhases: Record<string, number> = {};
      phaseCounts.forEach((group: any) => {
        if (group.marketPhase) {
          topPhases[group.marketPhase] = group._count;
        }
      });

      const recommendationCounts = await prisma.marketOpportunityScore.groupBy({
        by: ['recommendation'],
        _count: true,
        where: {
          recommendation: { not: null }
        }
      });

      const topRecommendations: Record<string, number> = {};
      recommendationCounts.forEach((group: any) => {
        if (group.recommendation) {
          topRecommendations[group.recommendation] = group._count;
        }
      });

      return {
        totalLocations,
        completedAnalysis,
        pendingAnalysis,
        failedAnalysis,
        averageDemandScore,
        averageGrowthScore,
        averageOverallScore,
        topPhases,
        topRecommendations
      };
    } catch (error) {
      console.error('[MarketPassportAPI] Failed to get market intelligence statistics:', error);
      throw error;
    }
  }
}

// Singleton instance
export const marketPassportAPI = new MarketPassportAPI();
