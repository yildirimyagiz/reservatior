/**
 * User Intelligence Agent
 * Analyzes user behavior, preferences, and investment patterns
 */

import { DomainEvents } from '../core/events/domain-events';
import { IdempotentEventConsumer } from '../core/events/idempotent-event-consumer';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export interface UserIntelligenceInput {
  userId: string;
  userData: any;
}

export interface UserIntelligenceOutput {
  userId: string;
  userIntelligenceProfile: any;
  userInvestmentProfile: any;
  confidenceScore: number;
  analysisDuration: number;
}

export class UserIntelligenceAgent {
  private idempotentConsumer: IdempotentEventConsumer;
  private behaviorAnalyzer: UserBehaviorAnalyzer;
  private preferenceDetector: PreferenceDetector;
  private investmentAnalyzer: InvestmentAnalyzer;
  private personaClassifier: PersonaClassifier;

  constructor() {
    this.idempotentConsumer = new IdempotentEventConsumer();
    this.behaviorAnalyzer = new UserBehaviorAnalyzer();
    this.preferenceDetector = new PreferenceDetector();
    this.investmentAnalyzer = new InvestmentAnalyzer();
    this.personaClassifier = new PersonaClassifier();
  }

  /**
   * Process user intelligence pipeline
   */
  async processUserIntelligence(input: UserIntelligenceInput): Promise<UserIntelligenceOutput> {
    const startTime = Date.now();

    try {
      console.log(`[UserIntelligenceAgent] Starting user intelligence analysis for user ${input.userId}`);

      // Step 1: Behavior Analysis
      const behaviorData = await this.behaviorAnalyzer.analyze(input);
      
      // Step 2: Preference Detection
      const preferenceData = await this.preferenceDetector.detect(input);
      
      // Step 3: Investment Analysis
      const investmentData = await this.investmentAnalyzer.analyze(input);
      
      // Step 4: Persona Classification
      const personaData = await this.personaClassifier.classify(input, behaviorData, preferenceData, investmentData);

      const analysisDuration = Date.now() - startTime;
      const confidenceScore = this.calculateConfidence(behaviorData, preferenceData, investmentData);

      // Step 5: Upsert UserIntelligenceProfile to Database
      const userProfile = await prisma.userIntelligenceProfile.upsert({
        where: { userId: input.userId },
        update: {
          persona: personaData.userPersona || 'BUYER',
          personaConfidence: confidenceScore,
          budgetMin: preferenceData.priceRange?.min || 100000,
          budgetMax: preferenceData.priceRange?.max || 1000000,
          preferredLocations: preferenceData.preferredLocations || [],
          propertyTypes: preferenceData.preferredPropertyTypes || [],
          viewingFrequency: behaviorData.viewingBehavior?.viewingFrequency === 'HIGH' ? 8.0 : 4.0,
          inquiryFrequency: behaviorData.inquiryBehavior?.responseRate || 0.75,
          conversionRate: 0.15,
          engagementScore: behaviorData.engagementScore || 75.0,
          investmentHorizon: personaData.investmentHorizon || 'MEDIUM',
          riskTolerance: personaData.riskTolerance || 'MEDIUM',
          propertyInterestScore: 82.5,
          marketInterestScore: 78.0,
          conversionProbability: 0.68,
          dataQuality: 0.90,
          updatedAt: new Date()
        },
        create: {
          userId: input.userId,
          persona: personaData.userPersona || 'BUYER',
          personaConfidence: confidenceScore,
          budgetMin: preferenceData.priceRange?.min || 100000,
          budgetMax: preferenceData.priceRange?.max || 1000000,
          preferredLocations: preferenceData.preferredLocations || [],
          propertyTypes: preferenceData.preferredPropertyTypes || [],
          viewingFrequency: 4.0,
          inquiryFrequency: 0.75,
          conversionRate: 0.15,
          engagementScore: behaviorData.engagementScore || 75.0,
          investmentHorizon: personaData.investmentHorizon || 'MEDIUM',
          riskTolerance: personaData.riskTolerance || 'MEDIUM',
          propertyInterestScore: 82.5,
          marketInterestScore: 78.0,
          conversionProbability: 0.68,
          dataQuality: 0.90
        }
      });

      // Step 6: Upsert UserInvestmentProfile to Database
      const investmentProfile = await prisma.userInvestmentProfile.upsert({
        where: { userId: input.userId },
        update: {
          investmentBudget: investmentData.portfolioSize || 500000,
          investmentGoals: ['ROI', 'CAPITAL_GROWTH'],
          riskTolerance: personaData.riskTolerance || 'MEDIUM',
          investmentHorizon: personaData.investmentHorizon || 'MEDIUM',
          preferredROI: investmentData.targetGrowth || 10.0,
          preferredYield: investmentData.targetYield || 7.5,
          preferredLocations: preferenceData.preferredLocations || [],
          propertyPreferences: preferenceData.preferredPropertyTypes || [],
          portfolioValue: investmentData.portfolioSize || 500000,
          portfolioROI: investmentData.totalROI || 12.5,
          portfolioYield: investmentData.targetYield || 7.5,
          updatedAt: new Date()
        },
        create: {
          userId: input.userId,
          investmentBudget: investmentData.portfolioSize || 500000,
          investmentGoals: ['ROI', 'CAPITAL_GROWTH'],
          riskTolerance: personaData.riskTolerance || 'MEDIUM',
          investmentHorizon: personaData.investmentHorizon || 'MEDIUM',
          preferredROI: investmentData.targetGrowth || 10.0,
          preferredYield: investmentData.targetYield || 7.5,
          preferredLocations: preferenceData.preferredLocations || [],
          propertyPreferences: preferenceData.preferredPropertyTypes || [],
          portfolioValue: investmentData.portfolioSize || 500000,
          portfolioROI: investmentData.totalROI || 12.5,
          portfolioYield: investmentData.targetYield || 7.5
        }
      });

      console.log(`[UserIntelligenceAgent] Successfully persisted User Intelligence Passport for user ${input.userId}`);

      return {
        userId: input.userId,
        userIntelligenceProfile: userProfile,
        userInvestmentProfile: investmentProfile,
        confidenceScore,
        analysisDuration
      };
    } catch (error) {
      console.error(`[UserIntelligenceAgent] Failed to process user intelligence:`, error);
      throw error;
    }
  }

  /**
   * Calculate overall confidence score
   */
  private calculateConfidence(behaviorData: any, preferenceData: any, investmentData: any): number {
    let confidence = 0;
    let factors = 0;

    if (behaviorData.dataQuality) {
      confidence += behaviorData.dataQuality * 0.3;
      factors++;
    }

    if (preferenceData.dataQuality) {
      confidence += preferenceData.dataQuality * 0.3;
      factors++;
    }

    if (investmentData.dataQuality) {
      confidence += investmentData.dataQuality * 0.4;
      factors++;
    }

    return factors > 0 ? confidence / factors : 0.5;
  }

  /**
   * Handle user created event
   */
  async handleUserCreated(event: any): Promise<void> {
    const input: UserIntelligenceInput = {
      userId: event.userId,
      userData: event.userData
    };

    await this.processUserIntelligence(input);
  }
}

/**
 * User Behavior Analyzer
 * Analyzes user behavior patterns
 */
class UserBehaviorAnalyzer {
  async analyze(input: UserIntelligenceInput): Promise<any> {
    console.log(`[UserBehaviorAnalyzer] Analyzing behavior for user ${input.userId}`);
    
    // In production, this would analyze:
    // - Search history
    // - Property viewing patterns
    // - Inquiry patterns
    // - Engagement metrics
    
    return {
      searchBehavior: {
        totalSearches: 45,
        avgSearchDuration: 180,
        searchFrequency: 'HIGH',
        searchPatterns: ['location_based', 'price_based', 'amenity_based']
      },
      viewingBehavior: {
        totalViewings: 12,
        avgViewingDuration: 300,
        viewingFrequency: 'MEDIUM',
        preferredViewingTimes: ['weekend', 'evening']
      },
      inquiryBehavior: {
        totalInquiries: 8,
        responseRate: 0.75,
        inquiryFrequency: 'MEDIUM',
        inquiryTypes: ['email', 'phone', 'whatsapp']
      },
      engagementScore: 78.5,
      dataQuality: 0.85
    };
  }
}

/**
 * Preference Detector
 * Detects user preferences
 */
class PreferenceDetector {
  async detect(input: UserIntelligenceInput): Promise<any> {
    console.log(`[PreferenceDetector] Detecting preferences for user ${input.userId}`);
    
    // In production, this would detect:
    // - Location preferences
    // - Property type preferences
    // - Price range preferences
    // - Amenity preferences
    
    return {
      preferredLocations: ['istanbul', 'kadikoy', 'besiktas'],
      preferredPropertyTypes: ['apartment', 'penthouse'],
      priceRange: {
        min: 500000,
        max: 2000000
      },
      budgetAllocation: {
        downPayment: 0.3,
        mortgage: 0.7
      },
      dataQuality: 0.82
    };
  }
}

/**
 * Investment Analyzer
 * Analyzes user investment patterns
 */
class InvestmentAnalyzer {
  async analyze(input: UserIntelligenceInput): Promise<any> {
    console.log(`[InvestmentAnalyzer] Analyzing investment patterns for user ${input.userId}`);
    
    // In production, this would analyze:
    // - Investment history
    // - ROI performance
    // - Portfolio composition
    // - Investment goals
    
    return {
      investmentStrategy: 'APPRECIATION',
      portfolioSize: 1500000,
      investmentCount: 2,
      totalROI: 12.5,
      averageROI: 12.5,
      bestROI: 15.2,
      worstROI: 9.8,
      targetMarkets: ['istanbul', 'antalya'],
      targetYield: 7.5,
      targetGrowth: 10.0,
      leverageRatio: 0.6,
      investmentScore: 82.3,
      riskProfile: 'MODERATE',
      aiRecommendation: 'EXPAND_PORTFOLIO',
      confidenceScore: 0.88,
      dataQuality: 0.90
    };
  }
}

/**
 * Persona Classifier
 * Classifies user persona
 */
class PersonaClassifier {
  async classify(input: UserIntelligenceInput, behaviorData: any, preferenceData: any, investmentData: any): Promise<any> {
    console.log(`[PersonaClassifier] Classifying persona for user ${input.userId}`);
    
    // In production, this would use ML models to classify persona
    let userPersona = 'FIRST_TIME_BUYER';
    let buyerType = 'MORTGAGE_BUYER';
    let investmentHorizon = 'MEDIUM_TERM';
    let riskTolerance = 'MEDIUM';
    let aiRecommendation = 'ACTIVE_BUYER';

    if (investmentData.investmentCount > 1) {
      userPersona = 'INVESTOR';
      buyerType = 'RENTAL_INVESTOR';
      investmentHorizon = 'LONG_TERM';
      aiRecommendation = 'HIGH_VALUE_LEAD';
    }

    if (behaviorData.engagementScore > 80) {
      aiRecommendation = 'ACTIVE_BUYER';
    } else if (behaviorData.engagementScore < 50) {
      aiRecommendation = 'PASSIVE_LOOKER';
    }

    return {
      userPersona,
      buyerType,
      investmentHorizon,
      riskTolerance,
      aiRecommendation
    };
  }
}

// Singleton instance
export const userIntelligenceAgent = new UserIntelligenceAgent();
