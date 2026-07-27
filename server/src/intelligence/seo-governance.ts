/**
 * SEO Intelligence Governance & Quality Gate
 * Prevents Google "Scaled Content Abuse" penalties with quality-based publishing decisions
 */

export interface SEOOpportunityScore {
  searchDemand: number;        // 0-100: Search volume and demand
  marketUniqueness: number;    // 0-100: Market uniqueness and differentiation
  dataAvailability: number;    // 0-100: Quality and quantity of available data
  investmentValue: number;     // 0-100: Investment potential and ROI
  conversionProbability: number; // 0-100: Expected conversion rate
  competitionLevel: number;    // 0-100: Competition level (inverse: higher = more competition)
  freshnessScore: number;       // 0-100: Data freshness and recency

  finalScore: number;          // 0-100: Weighted final score
  publishDecision: PublishDecision;
  qualityGate: QualityGate;
  calculatedAt: Date;
}

export enum PublishDecision {
  AUTO_PUBLISH = 'AUTO_PUBLISH',
  AI_REVIEW = 'AI_REVIEW',
  HUMAN_REVIEW = 'HUMAN_REVIEW',
  DO_NOT_GENERATE = 'DO_NOT_GENERATE'
}

export enum QualityGate {
  HIGH_QUALITY = 'HIGH_QUALITY',
  MEDIUM_QUALITY = 'MEDIUM_QUALITY',
  LOW_QUALITY = 'LOW_QUALITY',
  INSUFFICIENT_DATA = 'INSUFFICIENT_DATA'
}

export interface SEOOpportunityInput {
  searchDemand: number;
  marketUniqueness: number;
  dataAvailability: number;
  investmentValue: number;
  conversionProbability: number;
  competitionLevel: number;
  freshnessScore: number;
}

export interface SEOGovernanceConfig {
  autoPublishThreshold: number;    // Default: 85
  aiReviewThreshold: number;       // Default: 60
  humanReviewThreshold: number;    // Default: 40
  weights: {
    searchDemand: number;
    marketUniqueness: number;
    dataAvailability: number;
    investmentValue: number;
    conversionProbability: number;
    competitionLevel: number;
    freshnessScore: number;
  };
}

const DEFAULT_CONFIG: SEOGovernanceConfig = {
  autoPublishThreshold: 85,
  aiReviewThreshold: 60,
  humanReviewThreshold: 40,
  weights: {
    searchDemand: 0.25,
    marketUniqueness: 0.15,
    dataAvailability: 0.20,
    investmentValue: 0.20,
    conversionProbability: 0.10,
    competitionLevel: -0.15, // Negative weight (inverse)
    freshnessScore: 0.10
  }
};

export class SEOIntelligenceGovernance {
  private config: SEOGovernanceConfig;

  constructor(config?: Partial<SEOGovernanceConfig>) {
    this.config = {
      ...DEFAULT_CONFIG,
      ...config
    };
  }

  /**
   * Calculate SEO Opportunity Score
   */
  calculateScore(input: SEOOpportunityInput): SEOOpportunityScore {
    const weights = this.config.weights;

    // Calculate weighted score
    const finalScore = 
      (input.searchDemand * weights.searchDemand) +
      (input.marketUniqueness * weights.marketUniqueness) +
      (input.dataAvailability * weights.dataAvailability) +
      (input.investmentValue * weights.investmentValue) +
      (input.conversionProbability * weights.conversionProbability) +
      (input.competitionLevel * weights.competitionLevel) + // Negative weight
      (input.freshnessScore * weights.freshnessScore);

    // Normalize to 0-100 range
    const normalizedScore = Math.max(0, Math.min(100, finalScore * 100));

    // Determine publish decision and quality gate
    const { publishDecision, qualityGate } = this.determineDecision(normalizedScore, input);

    return {
      ...input,
      finalScore: normalizedScore,
      publishDecision,
      qualityGate,
      calculatedAt: new Date()
    };
  }

  /**
   * Determine publish decision based on score
   */
  private determineDecision(
    score: number,
    input: SEOOpportunityInput
  ): { publishDecision: PublishDecision; qualityGate: QualityGate } {
    // Check for insufficient data
    if (input.dataAvailability < 30) {
      return {
        publishDecision: PublishDecision.DO_NOT_GENERATE,
        qualityGate: QualityGate.INSUFFICIENT_DATA
      };
    }

    // High quality - auto publish
    if (score >= this.config.autoPublishThreshold) {
      return {
        publishDecision: PublishDecision.AUTO_PUBLISH,
        qualityGate: QualityGate.HIGH_QUALITY
      };
    }

    // Medium quality - AI review
    if (score >= this.config.aiReviewThreshold) {
      return {
        publishDecision: PublishDecision.AI_REVIEW,
        qualityGate: QualityGate.MEDIUM_QUALITY
      };
    }

    // Low quality - human review
    if (score >= this.config.humanReviewThreshold) {
      return {
        publishDecision: PublishDecision.HUMAN_REVIEW,
        qualityGate: QualityGate.LOW_QUALITY
      };
    }

    // Too low - do not generate
    return {
      publishDecision: PublishDecision.DO_NOT_GENERATE,
      qualityGate: QualityGate.LOW_QUALITY
    };
  }

  /**
   * Batch calculate scores for multiple opportunities
   */
  batchCalculateScores(inputs: SEOOpportunityInput[]): SEOOpportunityScore[] {
    return inputs.map(input => this.calculateScore(input));
  }

  /**
   * Get statistics for a batch of scores
   */
  getScoreStatistics(scores: SEOOpportunityScore[]): {
    total: number;
    autoPublish: number;
    aiReview: number;
    humanReview: number;
    doNotGenerate: number;
    averageScore: number;
  } {
    const autoPublish = scores.filter(s => s.publishDecision === PublishDecision.AUTO_PUBLISH).length;
    const aiReview = scores.filter(s => s.publishDecision === PublishDecision.AI_REVIEW).length;
    const humanReview = scores.filter(s => s.publishDecision === PublishDecision.HUMAN_REVIEW).length;
    const doNotGenerate = scores.filter(s => s.publishDecision === PublishDecision.DO_NOT_GENERATE).length;
    const averageScore = scores.reduce((sum, s) => sum + s.finalScore, 0) / scores.length;

    return {
      total: scores.length,
      autoPublish,
      aiReview,
      humanReview,
      doNotGenerate,
      averageScore
    };
  }

  /**
   * Update configuration
   */
  updateConfig(config: Partial<SEOGovernanceConfig>): void {
    this.config = {
      ...this.config,
      ...config
    };
  }

  /**
   * Get current configuration
   */
  getConfig(): SEOGovernanceConfig {
    return { ...this.config };
  }
}

// Singleton instance
export const seoIntelligenceGovernance = new SEOIntelligenceGovernance();

/**
 * Example: Dubai Marina Luxury Apartment Investment
 */
export const exampleDubaiMarina: SEOOpportunityInput = {
  searchDemand: 92,
  marketUniqueness: 85,
  dataAvailability: 95,
  investmentValue: 88,
  conversionProbability: 85,
  competitionLevel: 65,
  freshnessScore: 90
};

/**
 * Calculate example score
 */
export function calculateExampleScore(): SEOOpportunityScore {
  return seoIntelligenceGovernance.calculateScore(exampleDubaiMarina);
}
