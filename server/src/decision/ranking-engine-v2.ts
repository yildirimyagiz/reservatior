/**
 * Ranking Engine v2 - Country-Aware Opportunity Ranking
 * 
 * Ranks properties based on multi-factor analysis with country-specific weights:
 * - Opportunity scores from mathematical engine
 * - Strategic analysis from AI
 * - Simulation results from commercial scenarios
 * - Market conditions and trends
 * - User preferences and constraints
 * 
 * Country-specific: Each country has different market dynamics and investor preferences
 */

import { countryContextRegistry } from '../events/country/country-context';
import { SimulationOutput } from './simulation-agent-v2';

export interface RankingInput {
  country_code: string;
  propertyId: string;
  opportunityScore: number;
  strategicAnalysis?: {
    recommendedStrategy: string;
    confidence: number;
    regionalStrengths: string[];
    riskFactors: string[];
  };
  simulationResults?: SimulationOutput;
  marketConditions: {
    demandLevel: number;
    competitionLevel: number;
    priceTrend: string;
    marketTrend: string;
  };
  userPreferences?: {
    minPrice?: number;
    maxPrice?: number;
    preferredPropertyType?: string;
    investmentHorizon?: 'short' | 'medium' | 'long';
    riskTolerance?: 'low' | 'medium' | 'high';
  };
}

export interface RankedProperty {
  propertyId: string;
  country_code: string;
  overallScore: number;
  rank: number;
  componentScores: {
    opportunityScore: number;
    strategicScore: number;
    simulationScore: number;
    marketScore: number;
    userPreferenceScore: number;
  };
  weights: {
    opportunity: number;
    strategic: number;
    simulation: number;
    market: number;
    userPreference: number;
  };
  keyFactors: string[];
  risks: string[];
  recommendedAction: string;
  confidence: number;
}

export interface RankingOutput {
  country_code: string;
  rankedProperties: RankedProperty[];
  totalProperties: number;
  rankingMethod: string;
  weightsUsed: {
    opportunity: number;
    strategic: number;
    simulation: number;
    market: number;
    userPreference: number;
  };
  countryContext: any;
}

export class CountryAwareRankingEngine {
  /**
   * Rank properties based on multi-factor analysis
   */
  async rankProperties(inputs: RankingInput[]): Promise<RankingOutput> {
    if (inputs.length === 0) {
      return {
        country_code: '',
        rankedProperties: [],
        totalProperties: 0,
        rankingMethod: 'multi-factor',
        weightsUsed: {
          opportunity: 0,
          strategic: 0,
          simulation: 0,
          market: 0,
          userPreference: 0
        },
        countryContext: null
      };
    }

    const country_code = inputs[0].country_code;
    
    // Get country context
    const countryContext = countryContextRegistry.getContext(country_code);
    if (!countryContext) {
      throw new Error(`Country context not found for: ${country_code}`);
    }

    // Get country-specific weights
    const weights = this.getCountryWeights(country_code);

    // Calculate scores for each property
    const scoredProperties = await Promise.all(
      inputs.map(input => this.calculatePropertyScore(input, weights, countryContext))
    );

    // Sort by overall score
    scoredProperties.sort((a, b) => b.overallScore - a.overallScore);

    // Assign ranks
    const rankedProperties = scoredProperties.map((property, index) => ({
      ...property,
      rank: index + 1
    }));

    return {
      country_code,
      rankedProperties,
      totalProperties: inputs.length,
      rankingMethod: 'multi-factor-country-aware',
      weightsUsed: weights,
      countryContext
    };
  }

  /**
   * Get country-specific ranking weights
   */
  private getCountryWeights(countryCode: string): {
    opportunity: number;
    strategic: number;
    simulation: number;
    market: number;
    userPreference: number;
  } {
    // Default weights
    const defaultWeights = {
      opportunity: 0.35,
      strategic: 0.25,
      simulation: 0.20,
      market: 0.10,
      userPreference: 0.10
    };

    // Country-specific adjustments
    const countryWeights: Record<string, Record<string, number>> = {
      'TR': {
        ...defaultWeights,
        strategic: 0.30, // Higher weight for strategic analysis (risk factors)
        market: 0.15, // Higher weight for market conditions (volatility)
        simulation: 0.15 // Lower weight for simulation (uncertainty)
      },
      'AE': {
        ...defaultWeights,
        opportunity: 0.40, // Higher weight for opportunity (tax-free)
        simulation: 0.25, // Higher weight for simulation (commercial scenarios)
        strategic: 0.20,
        market: 0.10,
        userPreference: 0.05
      },
      'US': {
        ...defaultWeights,
        simulation: 0.30, // Higher weight for simulation (mature market)
        opportunity: 0.30,
        strategic: 0.20,
        market: 0.15,
        userPreference: 0.05
      }
    };

    return countryWeights[countryCode] || defaultWeights;
  }

  /**
   * Calculate property score with country-specific factors
   */
  private async calculatePropertyScore(
    input: RankingInput,
    weights: {
      opportunity: number;
      strategic: number;
      simulation: number;
      market: number;
      userPreference: number;
    },
    countryContext: any
  ): Promise<Omit<RankedProperty, 'rank'>> {
    const {
      propertyId,
      country_code,
      opportunityScore,
      strategicAnalysis,
      simulationResults,
      marketConditions,
      userPreferences
    } = input;

    // Calculate component scores
    const opportunityScoreNormalized = opportunityScore / 100; // Normalize to 0-1
    const strategicScore = this.calculateStrategicScore(strategicAnalysis, countryContext);
    const simulationScore = this.calculateSimulationScore(simulationResults, countryContext);
    const marketScore = this.calculateMarketScore(marketConditions, countryContext);
    const userPreferenceScore = this.calculateUserPreferenceScore(userPreferences, input, countryContext);

    // Calculate weighted overall score
    const overallScore = 
      (opportunityScoreNormalized * weights.opportunity) +
      (strategicScore * weights.strategic) +
      (simulationScore * weights.simulation) +
      (marketScore * weights.market) +
      (userPreferenceScore * weights.userPreference);

    // Extract key factors and risks
    const keyFactors = this.extractKeyFactors(input, countryContext);
    const risks = this.extractRisks(input, countryContext);

    // Determine recommended action
    const recommendedAction = this.determineRecommendedAction(input, overallScore, countryContext);

    // Calculate confidence
    const confidence = this.calculateConfidence(input, overallScore);

    return {
      propertyId,
      country_code,
      overallScore: overallScore * 100, // Convert back to 0-100 scale
      componentScores: {
        opportunityScore: opportunityScore,
        strategicScore: strategicScore * 100,
        simulationScore: simulationScore * 100,
        marketScore: marketScore * 100,
        userPreferenceScore: userPreferenceScore * 100
      },
      weights: weights as {
        opportunity: number;
        strategic: number;
        simulation: number;
        market: number;
        userPreference: number;
      },
      keyFactors,
      risks,
      recommendedAction,
      confidence
    };
  }

  /**
   * Calculate strategic score
   */
  private calculateStrategicScore(strategicAnalysis: any, countryContext: any): number {
    if (!strategicAnalysis) return 0.5; // Default score

    let score = 0.5; // Base score

    // Adjust based on confidence
    score += (strategicAnalysis.confidence - 0.5) * 0.3;

    // Adjust based on regional strengths
    if (strategicAnalysis.regionalStrengths && strategicAnalysis.regionalStrengths.length > 0) {
      score += 0.2;
    }

    // Adjust based on risk factors
    if (strategicAnalysis.riskFactors && strategicAnalysis.riskFactors.length > 0) {
      score -= 0.1 * strategicAnalysis.riskFactors.length;
    }

    return Math.max(0, Math.min(1, score));
  }

  /**
   * Calculate simulation score
   */
  private calculateSimulationScore(simulationResults: SimulationOutput | undefined, countryContext: any): number {
    if (!simulationResults || simulationResults.scenarios.length === 0) return 0.5;

    // Find best scenario
    const bestScenario = simulationResults.scenarios.reduce((best, current) => 
      current.netProfit > best.netProfit ? current : best
    );

    // Score based on profit margin and confidence
    let score = 0.5;
    score += (bestScenario.profitMargin / 100) * 0.3;
    score += (bestScenario.confidence - 0.5) * 0.2;

    return Math.max(0, Math.min(1, score));
  }

  /**
   * Calculate market score
   */
  private calculateMarketScore(marketConditions: any, countryContext: any): number {
    let score = 0.5; // Base score

    // Adjust based on demand level
    score += (marketConditions.demandLevel - 50) / 100;

    // Adjust based on competition (inverse)
    score -= (marketConditions.competitionLevel - 50) / 200;

    // Adjust based on market trend
    if (marketConditions.marketTrend === 'GROWTH') {
      score += 0.1;
    } else if (marketConditions.marketTrend === 'DECLINING') {
      score -= 0.1;
    }

    return Math.max(0, Math.min(1, score));
  }

  /**
   * Calculate user preference score
   */
  private calculateUserPreferenceScore(userPreferences: any, input: RankingInput, countryContext: any): number {
    if (!userPreferences) return 0.5; // Default score

    let score = 0.5; // Base score

    // Check price range
    if (userPreferences.minPrice && userPreferences.maxPrice) {
      const propertyPrice = input.opportunityScore; // Using opportunity score as proxy for price
      if (propertyPrice >= userPreferences.minPrice && propertyPrice <= userPreferences.maxPrice) {
        score += 0.2;
      }
    }

    // Check risk tolerance
    if (userPreferences.riskTolerance === 'low') {
      score -= 0.1; // Penalize high-risk properties
    } else if (userPreferences.riskTolerance === 'high') {
      score += 0.1; // Reward high-risk, high-reward properties
    }

    return Math.max(0, Math.min(1, score));
  }

  /**
   * Extract key factors
   */
  private extractKeyFactors(input: RankingInput, countryContext: any): string[] {
    const factors: string[] = [];

    if (input.opportunityScore > 80) {
      factors.push('High opportunity score');
    }

    if (input.strategicAnalysis?.regionalStrengths) {
      factors.push(...input.strategicAnalysis.regionalStrengths);
    }

    if (input.marketConditions.demandLevel > 70) {
      factors.push('High market demand');
    }

    if (input.marketConditions.marketTrend === 'GROWTH') {
      factors.push('Growing market');
    }

    return factors;
  }

  /**
   * Extract risks
   */
  private extractRisks(input: RankingInput, countryContext: any): string[] {
    const risks: string[] = [];

    if (input.strategicAnalysis?.riskFactors) {
      risks.push(...input.strategicAnalysis.riskFactors);
    }

    if (input.marketConditions.competitionLevel > 70) {
      risks.push('High competition');
    }

    if (input.marketConditions.marketTrend === 'DECLINING') {
      risks.push('Declining market');
    }

    // Add country-specific risks
    const countryRisks = countryContext.market_specifics.risk_factors;
    risks.push(...countryRisks);

    return [...new Set(risks)]; // Remove duplicates
  }

  /**
   * Determine recommended action
   */
  private determineRecommendedAction(input: RankingInput, overallScore: number, countryContext: any): string {
    if (overallScore > 80) {
      return 'IMMEDIATE_ACQUISITION';
    } else if (overallScore > 60) {
      return 'CONSIDER_ACQUISITION';
    } else if (overallScore > 40) {
      return 'MONITOR_MARKET';
    } else {
      return 'DO_NOT_ACQUIRE';
    }
  }

  /**
   * Calculate confidence
   */
  private calculateConfidence(input: RankingInput, overallScore: number): number {
    let confidence = 0.5; // Base confidence

    // Increase confidence if we have more data
    if (input.strategicAnalysis) confidence += 0.15;
    if (input.simulationResults) confidence += 0.15;
    if (input.marketConditions) confidence += 0.1;

    // Increase confidence if score is very high or very low
    if (overallScore > 85 || overallScore < 15) confidence += 0.1;

    return Math.min(1, confidence);
  }

  /**
   * Update ranking weights for a country
   */
  updateCountryWeights(countryCode: string, newWeights: {
    opportunity: number;
    strategic: number;
    simulation: number;
    market: number;
    userPreference: number;
  }): void {
    // This would update the weights in a persistent store
    console.log(`[RankingEngine] Updated weights for ${countryCode}:`, newWeights);
  }

  /**
   * Get top N properties
   */
  getTopProperties(rankingOutput: RankingOutput, n: number): RankedProperty[] {
    return rankingOutput.rankedProperties.slice(0, n);
  }

  /**
   * Filter properties by criteria
   */
  filterProperties(
    rankingOutput: RankingOutput,
    criteria: {
      minScore?: number;
      maxScore?: number;
      propertyType?: string;
      maxRisk?: number;
    }
  ): RankedProperty[] {
    return rankingOutput.rankedProperties.filter(property => {
      if (criteria.minScore && property.overallScore < criteria.minScore) return false;
      if (criteria.maxScore && property.overallScore > criteria.maxScore) return false;
      if (criteria.maxRisk && property.risks.length > criteria.maxRisk) return false;
      return true;
    });
  }

  /**
   * Get ranking statistics
   */
  getRankingStatistics(rankingOutput: RankingOutput): {
    averageScore: number;
    medianScore: number;
    scoreDistribution: Record<string, number>;
    topFactors: string[];
    topRisks: string[];
  } {
    const scores = rankingOutput.rankedProperties.map(p => p.overallScore);
    
    const averageScore = scores.reduce((sum, score) => sum + score, 0) / scores.length;
    const medianScore = scores[Math.floor(scores.length / 2)];

    // Score distribution
    const scoreDistribution: Record<string, number> = {
      '0-20': 0,
      '20-40': 0,
      '40-60': 0,
      '60-80': 0,
      '80-100': 0
    };

    scores.forEach(score => {
      if (score < 20) scoreDistribution['0-20']++;
      else if (score < 40) scoreDistribution['20-40']++;
      else if (score < 60) scoreDistribution['40-60']++;
      else if (score < 80) scoreDistribution['60-80']++;
      else scoreDistribution['80-100']++;
    });

    // Top factors
    const factorCounts: Record<string, number> = {};
    rankingOutput.rankedProperties.forEach(property => {
      property.keyFactors.forEach(factor => {
        factorCounts[factor] = (factorCounts[factor] || 0) + 1;
      });
    });

    const topFactors = Object.entries(factorCounts)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([factor]) => factor);

    // Top risks
    const riskCounts: Record<string, number> = {};
    rankingOutput.rankedProperties.forEach(property => {
      property.risks.forEach(risk => {
        riskCounts[risk] = (riskCounts[risk] || 0) + 1;
      });
    });

    const topRisks = Object.entries(riskCounts)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 5)
      .map(([risk]) => risk);

    return {
      averageScore,
      medianScore,
      scoreDistribution,
      topFactors,
      topRisks
    };
  }

  /**
   * Get model version
   */
  getModelVersion(): string {
    return 'ranking-engine-v2.0';
  }
}

export const countryAwareRankingEngine = new CountryAwareRankingEngine();
