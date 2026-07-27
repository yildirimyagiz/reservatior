/**
 * Opportunity Engine v2 - Country-Aware Scoring
 * 
 * Reservatior IP - Pure mathematical scoring engine
 * Country-specific factors via Country Context
 * NO AI hallucination risk
 */

import { countryContextRegistry } from '../events/country/country-context';

export interface PropertyData {
  price: number;
  size: number;
  rooms: number;
  location: string;
  propertyType: string;
  currentCondition: string;
  neighborhoodData?: {
    averagePrice: number;
    demandLevel: number;
    vacancyRate: number;
    crimeRate: number;
  };
}

export interface MarketData {
  averagePrice: number;
  priceTrend: string;
  demandLevel: number;
  competitionLevel: number;
  marketTrend: string;
}

export interface OpportunityScoreInput {
  country_code: string;
  propertyData: PropertyData;
  marketData: MarketData;
  additionalFactors?: {
    yield?: number;
    vacancy?: number;
    demand?: number;
    risk?: number;
    liquidity?: number;
  };
}

export interface OpportunityScoreResult {
  overallScore: number;
  opportunityTier: 'LOW_POTENTIAL' | 'MONITOR' | 'HIGH_POTENTIAL' | 'PREMIUM';
  acquisitionUrgency: 'LOW' | 'MEDIUM' | 'HIGH' | 'IMMEDIATE';
  
  // Component scores
  yieldScore: number;
  priceGapScore: number;
  demandScore: number;
  vacancyScore: number;
  riskScore: number;
  liquidityScore: number;
  
  // Weights used
  weights: {
    yield: number;
    priceGap: number;
    demand: number;
    vacancy: number;
    risk: number;
    liquidity: number;
  };
  
  // Country-specific adjustments
  countryAdjustments: Record<string, number>;
  
  // Country context used
  countryContext: any;
}

export class OpportunityEngine {
  /**
   * Calculate opportunity score with country-specific factors
   */
  async calculateScore(input: OpportunityScoreInput): Promise<OpportunityScoreResult> {
    const { country_code, propertyData, marketData, additionalFactors } = input;
    
    // Get country context
    const countryContext = countryContextRegistry.getContext(country_code);
    if (!countryContext) {
      throw new Error(`Country context not found for: ${country_code}`);
    }
    
    // Get country-specific weights and thresholds
    const countryWeights = this.getCountryWeights(country_code);
    const countryThresholds = countryContextRegistry.getAcquisitionThresholds(country_code);
    const countryAdjustments = countryContextRegistry.getValuationAdjustments(country_code);
    const countryRiskFactors = countryContextRegistry.getRiskFactors(country_code);
    const countryOpportunityFactors = countryContextRegistry.getOpportunityFactors(country_code);
    
    // Calculate component scores
    const yieldScore = this.calculateYieldScore(propertyData, marketData, additionalFactors, countryAdjustments);
    const priceGapScore = this.calculatePriceGapScore(propertyData, marketData, countryAdjustments);
    const demandScore = this.calculateDemandScore(marketData, additionalFactors, countryAdjustments);
    const vacancyScore = this.calculateVacancyScore(propertyData, marketData, additionalFactors, countryAdjustments);
    const riskScore = this.calculateRiskScore(propertyData, marketData, countryRiskFactors, countryAdjustments);
    const liquidityScore = this.calculateLiquidityScore(marketData, additionalFactors, countryAdjustments);
    
    // Calculate weighted overall score
    const overallScore = 
      (yieldScore * countryWeights.yield) +
      (priceGapScore * countryWeights.priceGap) +
      (demandScore * countryWeights.demand) +
      (vacancyScore * countryWeights.vacancy) +
      (riskScore * countryWeights.risk) +
      (liquidityScore * countryWeights.liquidity);
    
    // Determine opportunity tier based on country thresholds
    const opportunityTier = this.determineOpportunityTier(overallScore, countryThresholds);
    
    // Determine acquisition urgency
    const acquisitionUrgency = this.determineAcquisitionUrgency(overallScore, demandScore, marketData);
    
    return {
      overallScore: Math.round(overallScore),
      opportunityTier,
      acquisitionUrgency,
      yieldScore: Math.round(yieldScore),
      priceGapScore: Math.round(priceGapScore),
      demandScore: Math.round(demandScore),
      vacancyScore: Math.round(vacancyScore),
      riskScore: Math.round(riskScore),
      liquidityScore: Math.round(liquidityScore),
      weights: countryWeights,
      countryAdjustments,
      countryContext
    };
  }
  
  /**
   * Get country-specific weights
   */
  private getCountryWeights(countryCode: string) {
    // Default weights
    const defaultWeights = {
      yield: 0.25,
      priceGap: 0.20,
      demand: 0.20,
      vacancy: 0.10,
      risk: 0.15,
      liquidity: 0.10
    };
    
    // Country-specific adjustments
    const countryWeights: Record<string, any> = {
      'TR': {
        ...defaultWeights,
        risk: 0.20, // Higher weight for risk (earthquake, currency)
        yield: 0.20  // Lower weight for yield
      },
      'AE': {
        ...defaultWeights,
        yield: 0.30, // Higher weight for yield (no tax)
        risk: 0.10   // Lower weight for risk (stable market)
      },
      'US': {
        ...defaultWeights,
        liquidity: 0.15, // Higher weight for liquidity
        vacancy: 0.05   // Lower weight for vacancy
      }
    };
    
    return countryWeights[countryCode] || defaultWeights;
  }
  
  /**
   * Calculate yield score with country-specific adjustments
   */
  private calculateYieldScore(
    propertyData: PropertyData,
    marketData: MarketData,
    additionalFactors: OpportunityScoreInput['additionalFactors'],
    adjustments: Record<string, number>
  ): number {
    const yieldValue = additionalFactors?.yield || this.calculateYield(propertyData, marketData);
    
    // Base score from yield value
    let score = yieldValue * 100; // Convert to 0-100 scale
    
    // Apply country-specific adjustments
    if (adjustments.yield_premium) score += adjustments.yield_premium * 100;
    if (adjustments.tourism_potential) score += adjustments.tourism_potential * 100;
    
    return Math.min(100, Math.max(0, score));
  }
  
  /**
   * Calculate price gap score
   */
  private calculatePriceGapScore(
    propertyData: PropertyData,
    marketData: MarketData,
    adjustments: Record<string, number>
  ): number {
    const priceGap = (marketData.averagePrice - propertyData.price) / marketData.averagePrice;
    
    // Base score from price gap
    let score = priceGap * 100;
    
    // Apply country-specific adjustments
    if (adjustments.location_premium) score += adjustments.location_premium * 100;
    if (adjustments.luxury_premium) score += adjustments.luxury_premium * 100;
    
    return Math.min(100, Math.max(0, score));
  }
  
  /**
   * Calculate demand score
   */
  private calculateDemandScore(
    marketData: MarketData,
    additionalFactors: OpportunityScoreInput['additionalFactors'],
    adjustments: Record<string, number>
  ): number {
    const demandValue = additionalFactors?.demand || marketData.demandLevel;
    
    // Base score from demand
    let score = demandValue;
    
    // Apply country-specific adjustments
    if (adjustments.school_quality) score += adjustments.school_quality * 100;
    if (adjustments.transportation) score += adjustments.transportation * 100;
    
    return Math.min(100, Math.max(0, score));
  }
  
  /**
   * Calculate vacancy score (inverted - lower vacancy = higher score)
   */
  private calculateVacancyScore(
    propertyData: PropertyData,
    marketData: MarketData,
    additionalFactors: OpportunityScoreInput['additionalFactors'],
    adjustments: Record<string, number>
  ): number {
    const vacancyValue = additionalFactors?.vacancy || (propertyData.neighborhoodData?.vacancyRate || 0.1);
    
    // Invert vacancy (lower vacancy = higher score)
    let score = (1 - vacancyValue) * 100;
    
    return Math.min(100, Math.max(0, score));
  }
  
  /**
   * Calculate risk score (inverted - lower risk = higher score)
   */
  private calculateRiskScore(
    propertyData: PropertyData,
    marketData: MarketData,
    countryRiskFactors: string[],
    adjustments: Record<string, number>
  ): number {
    let riskScore = 70; // Base score
    
    // Apply country-specific risk adjustments
    if (adjustments.earthquake_risk) riskScore += adjustments.earthquake_risk * 100;
    if (adjustments.crime_rate) riskScore += adjustments.crime_rate * 100;
    
    return Math.min(100, Math.max(0, riskScore));
  }
  
  /**
   * Calculate liquidity score
   */
  private calculateLiquidityScore(
    marketData: MarketData,
    additionalFactors: OpportunityScoreInput['additionalFactors'],
    adjustments: Record<string, number>
  ): number {
    const liquidityValue = additionalFactors?.liquidity || (100 - marketData.competitionLevel);
    
    // Base score from liquidity
    let score = liquidityValue;
    
    return Math.min(100, Math.max(0, score));
  }
  
  /**
   * Calculate yield
   */
  private calculateYield(propertyData: PropertyData, marketData: MarketData): number {
    // Simple yield calculation
    const annualRent = propertyData.price * 0.08; // 8% annual rent assumption
    const yieldValue = annualRent / propertyData.price;
    return yieldValue;
  }
  
  /**
   * Determine opportunity tier based on country thresholds
   */
  private determineOpportunityTier(
    overallScore: number,
    thresholds: { minimum: number; good: number; excellent: number }
  ): 'LOW_POTENTIAL' | 'MONITOR' | 'HIGH_POTENTIAL' | 'PREMIUM' {
    if (overallScore >= thresholds.excellent) return 'PREMIUM';
    if (overallScore >= thresholds.good) return 'HIGH_POTENTIAL';
    if (overallScore >= thresholds.minimum) return 'MONITOR';
    return 'LOW_POTENTIAL';
  }
  
  /**
   * Determine acquisition urgency
   */
  private determineAcquisitionUrgency(
    overallScore: number,
    demandScore: number,
    marketData: MarketData
  ): 'LOW' | 'MEDIUM' | 'HIGH' | 'IMMEDIATE' {
    if (overallScore >= 85 && demandScore >= 80) return 'IMMEDIATE';
    if (overallScore >= 70 && demandScore >= 70) return 'HIGH';
    if (overallScore >= 50) return 'MEDIUM';
    return 'LOW';
  }
  
  /**
   * Batch calculate scores
   */
  async batchCalculateScores(inputs: OpportunityScoreInput[]): Promise<OpportunityScoreResult[]> {
    const results = await Promise.all(
      inputs.map(input => this.calculateScore(input))
    );
    return results;
  }
}

export const opportunityEngine = new OpportunityEngine();
