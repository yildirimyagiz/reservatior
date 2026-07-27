/**
 * Property Passport API
 * Exposes property intelligence data as a comprehensive property passport
 */

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export interface PropertyPassport {
  propertyId: string;
  // Basic Identity
  basicInfo: {
    buildingType?: string;
    yearBuilt?: number;
    totalArea: number;
    bedroomCount?: number;
    bathroomCount?: number;
  };
  // Financial Identity
  financialInfo: {
    currentValue: number;
    historicalValue?: any;
    rentalIncome?: number;
    rentalYield?: number;
    estimatedROI?: number;
  };
  // Market Identity
  marketInfo: {
    marketPosition?: string;
    comparableCount: number;
    daysOnMarket: number;
  };
  // Investment Identity
  investmentInfo: {
    investmentScore: number;
    growthPotential: number;
    riskScore: number;
    liquidityScore: number;
  };
  // Lifestyle Identity
  lifestyleInfo: {
    schoolScore?: number;
    transportScore?: number;
    healthcareScore?: number;
    lifestyleScore?: number;
  };
  // AI Identity & Strategy
  aiInfo: {
    aiRecommendation?: string;
    targetBuyerPersona?: string;
    bestMarketingAngle?: string;
    confidenceScore: number;
    intelligenceVersion: string;
    analysisStatus: string;
  };
  // Current Score
  currentScore: {
    investmentScore: number;
    rentalScore: number;
    demandScore: number;
    locationScore: number;
    liquidityScore: number;
    riskScore: number;
    overallScore: number;
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

export class PropertyPassportAPI {
  /**
   * Get property passport by property ID
   */
  async getPropertyPassport(propertyId: string): Promise<PropertyPassport | null> {
    try {
      // Fetch property intelligence profile
      const intelligenceProfile = await prisma.propertyIntelligenceProfile.findUnique({
        where: { propertyId }
      });

      if (!intelligenceProfile) {
        return null;
      }

      // Fetch current score
      const currentScore = await prisma.propertyCurrentScore.findUnique({
        where: { propertyId }
      });

      // Fetch digital twin
      const digitalTwin = await prisma.propertyDigitalTwin.findUnique({
        where: { propertyId }
      });

      // Build property passport
      const passport: PropertyPassport = {
        propertyId: intelligenceProfile.propertyId,
        basicInfo: {
          buildingType: intelligenceProfile.buildingType || undefined,
          yearBuilt: intelligenceProfile.yearBuilt || undefined,
          totalArea: Number(intelligenceProfile.totalArea),
          bedroomCount: intelligenceProfile.bedroomCount || undefined,
          bathroomCount: intelligenceProfile.bathroomCount || undefined
        },
        financialInfo: {
          currentValue: Number(intelligenceProfile.currentValue),
          historicalValue: intelligenceProfile.historicalValue || undefined,
          rentalIncome: intelligenceProfile.rentalIncome ? Number(intelligenceProfile.rentalIncome) : undefined,
          rentalYield: intelligenceProfile.rentalYield ? Number(intelligenceProfile.rentalYield) : undefined,
          estimatedROI: intelligenceProfile.estimatedROI ? Number(intelligenceProfile.estimatedROI) : undefined
        },
        marketInfo: {
          marketPosition: intelligenceProfile.marketPosition || undefined,
          comparableCount: intelligenceProfile.comparableCount,
          daysOnMarket: intelligenceProfile.daysOnMarket
        },
        investmentInfo: {
          investmentScore: intelligenceProfile.investmentScore,
          growthPotential: intelligenceProfile.growthPotential,
          riskScore: intelligenceProfile.riskScore,
          liquidityScore: intelligenceProfile.liquidityScore
        },
        lifestyleInfo: {
          schoolScore: intelligenceProfile.schoolScore || undefined,
          transportScore: intelligenceProfile.transportScore || undefined,
          healthcareScore: intelligenceProfile.healthcareScore || undefined,
          lifestyleScore: intelligenceProfile.lifestyleScore || undefined
        },
        aiInfo: {
          aiRecommendation: intelligenceProfile.aiRecommendation || undefined,
          targetBuyerPersona: intelligenceProfile.targetBuyerPersona || undefined,
          bestMarketingAngle: intelligenceProfile.bestMarketingAngle || undefined,
          confidenceScore: intelligenceProfile.confidenceScore,
          intelligenceVersion: intelligenceProfile.intelligenceVersion,
          analysisStatus: intelligenceProfile.analysisStatus
        },
        currentScore: currentScore ? {
          investmentScore: currentScore.investmentScore,
          rentalScore: currentScore.rentalScore,
          demandScore: currentScore.demandScore,
          locationScore: currentScore.locationScore,
          liquidityScore: currentScore.liquidityScore,
          riskScore: currentScore.riskScore,
          overallScore: currentScore.overallScore
        } : {
          investmentScore: 0,
          rentalScore: 0,
          demandScore: 0,
          locationScore: 0,
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
          createdAt: intelligenceProfile.createdAt,
          updatedAt: intelligenceProfile.updatedAt,
          lastAnalyzedAt: intelligenceProfile.lastAnalyzedAt || undefined
        }
      };

      return passport;
    } catch (error) {
      console.error(`[PropertyPassportAPI] Failed to get property passport for ${propertyId}:`, error);
      throw error;
    }
  }

  /**
   * Get property score history
   */
  async getPropertyScoreHistory(propertyId: string, limit: number = 10): Promise<any[]> {
    try {
      const history = await prisma.propertyScoreHistory.findMany({
        where: { propertyId },
        orderBy: { calculatedAt: 'desc' },
        take: limit
      });

      return history.map((record: any) => ({
        investmentScore: record.investmentScore,
        rentalScore: record.rentalScore,
        demandScore: record.demandScore,
        locationScore: record.locationScore,
        liquidityScore: record.liquidityScore,
        riskScore: record.riskScore,
        overallScore: record.overallScore,
        calculatedAt: record.calculatedAt,
        modelVersion: record.modelVersion,
        confidenceScore: record.confidenceScore
      }));
    } catch (error) {
      console.error(`[PropertyPassportAPI] Failed to get score history for ${propertyId}:`, error);
      throw error;
    }
  }

  /**
   * Get top properties by investment score
   */
  async getTopPropertiesByInvestmentScore(
    countryIsoCode?: string,
    citySlug?: string,
    limit: number = 10
  ): Promise<PropertyPassport[]> {
    try {
      const profiles = await prisma.propertyIntelligenceProfile.findMany({
        where: {
          ...(countryIsoCode && { countryIsoCode }),
          ...(citySlug && { citySlug }),
          analysisStatus: 'COMPLETED'
        },
        orderBy: {
          investmentScore: 'desc'
        },
        take: limit
      });

      const passports: PropertyPassport[] = [];

      for (const profile of profiles) {
        const passport = await this.getPropertyPassport(profile.propertyId);
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[PropertyPassportAPI] Failed to get top properties:', error);
      throw error;
    }
  }

  /**
   * Get properties by AI recommendation
   */
  async getPropertiesByRecommendation(
    recommendation: string,
    limit: number = 10
  ): Promise<PropertyPassport[]> {
    try {
      const profiles = await prisma.propertyIntelligenceProfile.findMany({
        where: {
          aiRecommendation: recommendation,
          analysisStatus: 'COMPLETED'
        },
        orderBy: {
          investmentScore: 'desc'
        },
        take: limit
      });

      const passports: PropertyPassport[] = [];

      for (const profile of profiles) {
        const passport = await this.getPropertyPassport(profile.propertyId);
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[PropertyPassportAPI] Failed to get properties by recommendation:', error);
      throw error;
    }
  }

  /**
   * Get properties by target buyer persona
   */
  async getPropertiesByTargetPersona(
    persona: string,
    limit: number = 10
  ): Promise<PropertyPassport[]> {
    try {
      const profiles = await prisma.propertyIntelligenceProfile.findMany({
        where: {
          targetBuyerPersona: persona,
          analysisStatus: 'COMPLETED'
        },
        orderBy: {
          investmentScore: 'desc'
        },
        take: limit
      });

      const passports: PropertyPassport[] = [];

      for (const profile of profiles) {
        const passport = await this.getPropertyPassport(profile.propertyId);
        if (passport) {
          passports.push(passport);
        }
      }

      return passports;
    } catch (error) {
      console.error('[PropertyPassportAPI] Failed to get properties by target persona:', error);
      throw error;
    }
  }

  /**
   * Get property intelligence statistics
   */
  async getIntelligenceStatistics(): Promise<{
    totalProperties: number;
    completedAnalysis: number;
    pendingAnalysis: number;
    failedAnalysis: number;
    averageInvestmentScore: number;
    averageOverallScore: number;
    topRecommendations: Record<string, number>;
  }> {
    try {
      const totalProperties = await prisma.propertyIntelligenceProfile.count();
      const completedAnalysis = await prisma.propertyIntelligenceProfile.count({
        where: { analysisStatus: 'COMPLETED' }
      });
      const pendingAnalysis = await prisma.propertyIntelligenceProfile.count({
        where: { analysisStatus: 'PENDING' }
      });
      const failedAnalysis = await prisma.propertyIntelligenceProfile.count({
        where: { analysisStatus: 'FAILED' }
      });

      const completedProfiles = await prisma.propertyIntelligenceProfile.findMany({
        where: { analysisStatus: 'COMPLETED' },
        select: {
          investmentScore: true
        }
      });

      const averageInvestmentScore = completedProfiles.length > 0
        ? completedProfiles.reduce((sum: number, p: any) => sum + p.investmentScore, 0) / completedProfiles.length
        : 0;

      const currentScores = await prisma.propertyCurrentScore.findMany({
        select: {
          overallScore: true
        }
      });

      const averageOverallScore = currentScores.length > 0
        ? currentScores.reduce((sum: number, s: any) => sum + s.overallScore, 0) / currentScores.length
        : 0;

      const recommendationCounts = await prisma.propertyIntelligenceProfile.groupBy({
        by: ['aiRecommendation'],
        _count: true,
        where: {
          aiRecommendation: { not: null },
          analysisStatus: 'COMPLETED'
        }
      });

      const topRecommendations: Record<string, number> = {};
      recommendationCounts.forEach((group: any) => {
        if (group.aiRecommendation) {
          topRecommendations[group.aiRecommendation] = group._count;
        }
      });

      return {
        totalProperties,
        completedAnalysis,
        pendingAnalysis,
        failedAnalysis,
        averageInvestmentScore,
        averageOverallScore,
        topRecommendations
      };
    } catch (error) {
      console.error('[PropertyPassportAPI] Failed to get intelligence statistics:', error);
      throw error;
    }
  }
}

// Singleton instance
export const propertyPassportAPI = new PropertyPassportAPI();
