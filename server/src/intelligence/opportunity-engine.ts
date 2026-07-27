/**
 * Opportunity Engine - Mathematical Scoring Engine
 * 
 * Pure mathematical scoring without AI hallucination risk
 * Combines multiple factors into a single opportunity score:
 * - Yield
 * - Price Gap
 * - Demand
 * - Vacancy
 * - Risk
 * - Liquidity
 */

export interface OpportunityFactors {
  // Yield factors
  capRate: number;
  cashOnCashReturn: number;
  grossYield: number;
  netYield: number;
  
  // Price gap factors
  listingPrice: number;
  estimatedMarketValue: number;
  priceGapPercentage: number;
  
  // Demand factors
  marketDemandScore: number;
  searchVolume: number;
  daysOnMarket: number;
  
  // Vacancy factors
  areaVacancyRate: number;
  propertyVacancyRate: number;
  
  // Risk factors
  riskScore: number;
  locationRisk: number;
  marketRisk: number;
  
  // Liquidity factors
  liquidityScore: number;
  marketLiquidity: number;
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
  
  // Weighted contributions
  yieldContribution: number;
  priceGapContribution: number;
  demandContribution: number;
  vacancyContribution: number;
  riskContribution: number;
  liquidityContribution: number;
  
  // Metadata
  calculationTimestamp: Date;
  modelVersion: string;
}

export class OpportunityEngine {
  private weights = {
    yield: 0.25,           // 25% weight
    priceGap: 0.20,        // 20% weight
    demand: 0.20,          // 20% weight
    vacancy: 0.10,         // 10% weight
    risk: 0.15,            // 15% weight
    liquidity: 0.10        // 10% weight
  };

  private modelVersion = 'v1.0';

  /**
   * Calculate opportunity score from factors
   */
  calculateScore(factors: OpportunityFactors): OpportunityScoreResult {
    // Calculate individual component scores (0-100)
    const yieldScore = this.calculateYieldScore(factors);
    const priceGapScore = this.calculatePriceGapScore(factors);
    const demandScore = this.calculateDemandScore(factors);
    const vacancyScore = this.calculateVacancyScore(factors);
    const riskScore = this.calculateRiskScore(factors);
    const liquidityScore = this.calculateLiquidityScore(factors);

    // Calculate weighted contributions
    const yieldContribution = yieldScore * this.weights.yield;
    const priceGapContribution = priceGapScore * this.weights.priceGap;
    const demandContribution = demandScore * this.weights.demand;
    const vacancyContribution = vacancyScore * this.weights.vacancy;
    const riskContribution = riskScore * this.weights.risk;
    const liquidityContribution = liquidityScore * this.weights.liquidity;

    // Calculate overall score (0-100)
    const overallScore = 
      yieldContribution +
      priceGapContribution +
      demandContribution +
      vacancyContribution +
      riskContribution +
      liquidityContribution;

    // Determine opportunity tier
    const opportunityTier = this.determineOpportunityTier(overallScore);
    
    // Determine acquisition urgency
    const acquisitionUrgency = this.determineAcquisitionUrgency(
      overallScore,
      factors.priceGapPercentage,
      factors.daysOnMarket
    );

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
      yieldContribution: Math.round(yieldContribution),
      priceGapContribution: Math.round(priceGapContribution),
      demandContribution: Math.round(demandContribution),
      vacancyContribution: Math.round(vacancyContribution),
      riskContribution: Math.round(riskContribution),
      liquidityContribution: Math.round(liquidityContribution),
      calculationTimestamp: new Date(),
      modelVersion: this.modelVersion
    };
  }

  /**
   * Calculate yield score (0-100)
   * Higher yields = higher score
   */
  private calculateYieldScore(factors: OpportunityFactors): number {
    // Weighted average of yield metrics
    const capRateScore = Math.min(factors.capRate * 10, 100); // 10% cap rate = 100 points
    const cashOnCashScore = Math.min(factors.cashOnCashReturn * 10, 100);
    const grossYieldScore = Math.min(factors.grossYield * 8, 100);
    const netYieldScore = Math.min(factors.netYield * 10, 100);

    return (capRateScore * 0.3 + cashOnCashScore * 0.3 + grossYieldScore * 0.2 + netYieldScore * 0.2);
  }

  /**
   * Calculate price gap score (0-100)
   * Higher price gap (undervalued) = higher score
   */
  private calculatePriceGapScore(factors: OpportunityFactors): number {
    // Price gap percentage: how much below market value
    // 20% below market = 100 points, 0% = 0 points
    const priceGapScore = Math.min(factors.priceGapPercentage * 5, 100);
    
    return priceGapScore;
  }

  /**
   * Calculate demand score (0-100)
   * Higher demand = higher score
   */
  private calculateDemandScore(factors: OpportunityFactors): number {
    // Market demand score (0-100) already normalized
    const marketDemandScore = factors.marketDemandScore;
    
    // Search volume normalization (logarithmic)
    const searchVolumeScore = Math.min(Math.log10(factors.searchVolume + 1) * 20, 100);
    
    // Days on market: lower is better
    const daysOnMarketScore = Math.max(100 - (factors.daysOnMarket / 3), 0);

    return (marketDemandScore * 0.4 + searchVolumeScore * 0.3 + daysOnMarketScore * 0.3);
  }

  /**
   * Calculate vacancy score (0-100)
   * Lower vacancy = higher score
   */
  private calculateVacancyScore(factors: OpportunityFactors): number {
    // Area vacancy rate: lower is better
    const areaVacancyScore = Math.max(100 - (factors.areaVacancyRate * 200), 0);
    
    // Property vacancy rate: lower is better
    const propertyVacancyScore = Math.max(100 - (factors.propertyVacancyRate * 200), 0);

    return (areaVacancyScore * 0.5 + propertyVacancyScore * 0.5);
  }

  /**
   * Calculate risk score (0-100)
   * Lower risk = higher score (inverted)
   */
  private calculateRiskScore(factors: OpportunityFactors): number {
    // Risk score is inverted: lower risk = higher opportunity score
    const locationRiskScore = 100 - factors.locationRisk;
    const marketRiskScore = 100 - factors.marketRisk;
    const overallRiskScore = 100 - factors.riskScore;

    return (locationRiskScore * 0.3 + marketRiskScore * 0.3 + overallRiskScore * 0.4);
  }

  /**
   * Calculate liquidity score (0-100)
   * Higher liquidity = higher score
   */
  private calculateLiquidityScore(factors: OpportunityFactors): number {
    // Market liquidity (0-100) already normalized
    const marketLiquidityScore = factors.marketLiquidity;
    
    // Property liquidity (0-100) already normalized
    const propertyLiquidityScore = factors.liquidityScore;

    return (marketLiquidityScore * 0.6 + propertyLiquidityScore * 0.4);
  }

  /**
   * Determine opportunity tier based on overall score
   */
  private determineOpportunityTier(score: number): 'LOW_POTENTIAL' | 'MONITOR' | 'HIGH_POTENTIAL' | 'PREMIUM' {
    if (score >= 85) return 'PREMIUM';
    if (score >= 70) return 'HIGH_POTENTIAL';
    if (score >= 50) return 'MONITOR';
    return 'LOW_POTENTIAL';
  }

  /**
   * Determine acquisition urgency based on score and market factors
   */
  private determineAcquisitionUrgency(
    score: number,
    priceGapPercentage: number,
    daysOnMarket: number
  ): 'LOW' | 'MEDIUM' | 'HIGH' | 'IMMEDIATE' {
    // High urgency conditions
    if (score >= 85 && priceGapPercentage >= 15) return 'IMMEDIATE';
    if (score >= 75 && daysOnMarket <= 7) return 'HIGH';
    if (score >= 60 && priceGapPercentage >= 10) return 'HIGH';
    
    // Medium urgency conditions
    if (score >= 50) return 'MEDIUM';
    if (priceGapPercentage >= 8) return 'MEDIUM';
    
    // Low urgency
    return 'LOW';
  }

  /**
   * Update scoring weights (for model tuning)
   */
  updateWeights(newWeights: Partial<typeof this.weights>) {
    this.weights = { ...this.weights, ...newWeights };
    
    // Validate weights sum to 1
    const total = Object.values(this.weights).reduce((sum, weight) => sum + weight, 0);
    if (Math.abs(total - 1) > 0.01) {
      throw new Error(`Weights must sum to 1, current sum: ${total}`);
    }
  }

  /**
   * Get current weights
   */
  getWeights() {
    return { ...this.weights };
  }

  /**
   * Get model version
   */
  getModelVersion() {
    return this.modelVersion;
  }
}

export const opportunityEngine = new OpportunityEngine();
