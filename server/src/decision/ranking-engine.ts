/**
 * Ranking Engine - Opportunity Ranking
 * 
 * Ranks properties based on multiple factors:
 * - Opportunity Engine scores
 * - Strategic Brain recommendations
 * - Simulation Agent results
 * - Market conditions
 * - User preferences
 * 
 * Provides ranked list for decision making
 */

import { OpportunityScoreResult } from '../intelligence/opportunity-engine';
import { StrategicAnalysisOutput } from '../intelligence/strategic-brain';
import { SimulationOutput } from './simulation-agent';

export interface RankingInput {
  propertyId: string;
  opportunityScore: OpportunityScoreResult;
  strategicAnalysis: StrategicAnalysisOutput;
  simulationResults: SimulationOutput;
  userPreferences?: {
    preferredStrategy?: string;
    maxPrice?: number;
    minScore?: number;
    locationPreference?: string[];
  };
}

export interface RankedProperty {
  propertyId: string;
  overallRank: number;
  overallScore: number;
  opportunityScore: number;
  strategicScore: number;
  simulationScore: number;
  marketScore: number;
  userPreferenceScore: number;
  recommendedStrategy: string;
  confidence: number;
  keyFactors: string[];
  risks: string[];
}

export interface RankingOutput {
  rankedProperties: RankedProperty[];
  totalProperties: number;
  rankingTimestamp: Date;
  rankingMethod: string;
  modelVersion: string;
}

export class RankingEngine {
  private modelVersion = 'v1.0';
  private weights = {
    opportunity: 0.30,    // 30% weight
    strategic: 0.25,      // 25% weight
    simulation: 0.25,     // 25% weight
    market: 0.10,         // 10% weight
    userPreference: 0.10  // 10% weight
  };

  /**
   * Rank properties based on multiple factors
   */
  async rankProperties(inputs: RankingInput[]): Promise<RankingOutput> {
    const rankedProperties: RankedProperty[] = [];

    for (const input of inputs) {
      const ranked = await this.rankSingleProperty(input);
      rankedProperties.push(ranked);
    }

    // Sort by overall score
    rankedProperties.sort((a, b) => b.overallScore - a.overallScore);

    // Assign ranks
    rankedProperties.forEach((property, index) => {
      property.overallRank = index + 1;
    });

    return {
      rankedProperties,
      totalProperties: rankedProperties.length,
      rankingTimestamp: new Date(),
      rankingMethod: 'weighted_multi_factor',
      modelVersion: this.modelVersion
    };
  }

  /**
   * Rank a single property
   */
  private async rankSingleProperty(input: RankingInput): Promise<RankedProperty> {
    const { propertyId, opportunityScore, strategicAnalysis, simulationResults, userPreferences } = input;

    // Calculate individual scores
    const opportunityScoreValue = this.calculateOpportunityScore(opportunityScore);
    const strategicScoreValue = this.calculateStrategicScore(strategicAnalysis);
    const simulationScoreValue = this.calculateSimulationScore(simulationResults);
    const marketScoreValue = this.calculateMarketScore(opportunityScore);
    const userPreferenceScoreValue = this.calculateUserPreferenceScore(simulationResults, userPreferences);

    // Calculate weighted overall score
    const overallScore = 
      (opportunityScoreValue * this.weights.opportunity) +
      (strategicScoreValue * this.weights.strategic) +
      (simulationScoreValue * this.weights.simulation) +
      (marketScoreValue * this.weights.market) +
      (userPreferenceScoreValue * this.weights.userPreference);

    // Determine key factors and risks
    const keyFactors = this.extractKeyFactors(opportunityScore, strategicAnalysis, simulationResults);
    const risks = this.extractRisks(opportunityScore, strategicAnalysis, simulationResults);

    return {
      propertyId,
      overallRank: 0, // Will be assigned after sorting
      overallScore: Math.round(overallScore),
      opportunityScore: Math.round(opportunityScoreValue),
      strategicScore: Math.round(strategicScoreValue),
      simulationScore: Math.round(simulationScoreValue),
      marketScore: Math.round(marketScoreValue),
      userPreferenceScore: Math.round(userPreferenceScoreValue),
      recommendedStrategy: strategicAnalysis.recommendedStrategy,
      confidence: strategicAnalysis.confidenceScore,
      keyFactors,
      risks
    };
  }

  /**
   * Calculate opportunity score (normalized 0-100)
   */
  private calculateOpportunityScore(score: OpportunityScoreResult): number {
    return score.overallScore;
  }

  /**
   * Calculate strategic score based on AI analysis
   */
  private calculateStrategicScore(analysis: StrategicAnalysisOutput): number {
    // Base score from confidence
    let score = analysis.confidenceScore;

    // Boost for high-confidence recommendations
    if (analysis.confidenceScore >= 80) {
      score += 10;
    }

    // Adjust based on strategy alignment with market
    const strategyScores: Record<string, number> = {
      'NORMAL_SALE': 70,
      'LUXURY_RENTAL': 85,
      'CORPORATE_TENANT': 90,
      'FURNISHED_RENTAL': 75,
      'SHORT_TERM_RENTAL': 65,
      'HOLD_FOR_APPRECIATION': 60
    };

    const strategyScore = strategyScores[analysis.recommendedStrategy] || 70;
    score = (score + strategyScore) / 2;

    return Math.min(100, Math.max(0, score));
  }

  /**
   * Calculate simulation score based on scenario results
   */
  private calculateSimulationScore(simulation: SimulationOutput): number {
    if (simulation.scenarios.length === 0) return 50;

    // Find best scenario
    const bestScenario = simulation.scenarios.reduce((best, current) => 
      current.netProfit > best.netProfit ? current : best
    );

    // Score based on profit margin and confidence
    let score = bestScenario.profitMargin * 2; // Scale margin to score
    score += bestScenario.confidence * 0.3;

    return Math.min(100, Math.max(0, score));
  }

  /**
   * Calculate market score based on opportunity score components
   */
  private calculateMarketScore(score: OpportunityScoreResult): number {
    // Market score is derived from demand and liquidity components
    return (score.demandScore + score.liquidityScore) / 2;
  }

  /**
   * Calculate user preference score
   */
  private calculateUserPreferenceScore(simulation: SimulationOutput, preferences?: RankingInput['userPreferences']): number {
    if (!preferences) return 50; // Neutral score if no preferences

    let score = 50;

    // Check if recommended strategy matches preference
    if (preferences.preferredStrategy && simulation.recommendedScenario === preferences.preferredStrategy) {
      score += 30;
    }

    // Check if best scenario is within price range
    if (preferences.maxPrice) {
      const bestScenario = simulation.scenarios.reduce((best, current) => 
        current.netProfit > best.netProfit ? current : best
      );
      
      if (bestScenario.estimatedRevenue <= preferences.maxPrice) {
        score += 20;
      }
    }

    // Check if opportunity score meets minimum
    if (preferences.minScore && simulation.baseOpportunityScore >= preferences.minScore) {
      score += 20;
    }

    return Math.min(100, Math.max(0, score));
  }

  /**
   * Extract key factors from analysis
   */
  private extractKeyFactors(
    opportunityScore: OpportunityScoreResult,
    strategicAnalysis: StrategicAnalysisOutput,
    simulation: SimulationOutput
  ): string[] {
    const factors: string[] = [];

    // Opportunity factors
    if (opportunityScore.opportunityTier === 'PREMIUM') {
      factors.push('Premium opportunity tier');
    }
    if (opportunityScore.acquisitionUrgency === 'IMMEDIATE') {
      factors.push('Immediate acquisition urgency');
    }

    // Strategic factors
    if (strategicAnalysis.confidenceScore >= 80) {
      factors.push('High confidence AI recommendation');
    }
    factors.push(`Recommended: ${strategicAnalysis.recommendedStrategy}`);

    // Simulation factors
    const bestScenario = simulation.scenarios.reduce((best, current) => 
      current.netProfit > best.netProfit ? current : best
    );
    factors.push(`Best scenario: ${bestScenario.scenarioName}`);
    if (bestScenario.profitMargin > 20) {
      factors.push('High profit margin potential');
    }

    return factors;
  }

  /**
   * Extract risks from analysis
   */
  private extractRisks(
    opportunityScore: OpportunityScoreResult,
    strategicAnalysis: StrategicAnalysisOutput,
    simulation: SimulationOutput
  ): string[] {
    const risks: string[] = [];

    // Opportunity risks
    if (opportunityScore.riskScore < 50) {
      risks.push('High risk score');
    }
    if (opportunityScore.liquidityScore < 50) {
      risks.push('Low liquidity');
    }

    // Strategic risks
    if (strategicAnalysis.confidenceScore < 60) {
      risks.push('Low confidence in AI recommendation');
    }

    // Simulation risks
    const bestScenario = simulation.scenarios.reduce((best, current) => 
      current.netProfit > best.netProfit ? current : best
    );
    risks.push(...bestScenario.riskFactors);

    return risks;
  }

  /**
   * Update ranking weights
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
   * Get top N properties
   */
  getTopProperties(ranking: RankingOutput, n: number): RankedProperty[] {
    return ranking.rankedProperties.slice(0, n);
  }

  /**
   * Filter properties by criteria
   */
  filterProperties(ranking: RankingOutput, criteria: {
    minScore?: number;
    maxPrice?: number;
    strategy?: string;
    minConfidence?: number;
  }): RankedProperty[] {
    return ranking.rankedProperties.filter(property => {
      if (criteria.minScore && property.overallScore < criteria.minScore) return false;
      if (criteria.minConfidence && property.confidence < criteria.minConfidence) return false;
      if (criteria.strategy && property.recommendedStrategy !== criteria.strategy) return false;
      return true;
    });
  }

  /**
   * Get ranking statistics
   */
  getRankingStats(ranking: RankingOutput) {
    const scores = ranking.rankedProperties.map(p => p.overallScore);
    const avgScore = scores.reduce((sum, score) => sum + score, 0) / scores.length;
    const maxScore = Math.max(...scores);
    const minScore = Math.min(...scores);

    const strategyCounts = ranking.rankedProperties.reduce((counts, property) => {
      counts[property.recommendedStrategy] = (counts[property.recommendedStrategy] || 0) + 1;
      return counts;
    }, {} as Record<string, number>);

    return {
      totalProperties: ranking.totalProperties,
      averageScore: Math.round(avgScore),
      maxScore,
      minScore,
      strategyDistribution: strategyCounts,
      rankingMethod: ranking.rankingMethod,
      modelVersion: ranking.modelVersion
    };
  }

  /**
   * Get model version
   */
  getModelVersion(): string {
    return this.modelVersion;
  }
}

export const rankingEngine = new RankingEngine();
