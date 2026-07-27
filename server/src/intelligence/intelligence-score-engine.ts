/**
 * Intelligence Score Engine
 * Centralized scoring system for all entities (Country, City, District, Neighborhood, Property)
 */

export enum EntityType {
  COUNTRY = 'COUNTRY',
  CITY = 'CITY',
  DISTRICT = 'DISTRICT',
  NEIGHBORHOOD = 'NEIGHBORHOOD',
  PROPERTY = 'PROPERTY'
}

export interface ComponentScore {
  type: string;
  value: number;
  weight: number;
  contribution: number;
  metadata?: {
    factors?: Record<string, number>;
    trend?: 'IMPROVING' | 'STABLE' | 'DECLINING';
    confidence?: number;
  };
}

export interface IntelligenceScore {
  entityId: string;
  entityType: EntityType;
  componentScores: ComponentScore[];
  overallScore: number;
  calculatedAt: Date;
  metadata?: {
    dataQuality: number;
    sampleSize: number;
    timeRange: string;
  };
}

export interface ScoreWeights {
  investment: number;
  demand: number;
  rental: number;
  liquidity: number;
  foreignInterest: number;
  marketTrend: number;
  infrastructure: number;
  risk: number;
}

const DEFAULT_WEIGHTS: ScoreWeights = {
  investment: 0.25,
  demand: 0.20,
  rental: 0.20,
  liquidity: 0.15,
  foreignInterest: 0.20,
  marketTrend: 0.10,
  infrastructure: 0.05,
  risk: -0.15 // Negative weight
};

export class IntelligenceScoreEngine {
  private weights: ScoreWeights;

  constructor(weights?: Partial<ScoreWeights>) {
    this.weights = {
      ...DEFAULT_WEIGHTS,
      ...weights
    };
  }

  /**
   * Calculate intelligence score for an entity
   */
  async calculateEntityScore(
    entityId: string,
    entityType: EntityType,
    componentData: Record<string, number>
  ): Promise<IntelligenceScore> {
    const componentScores = await this.calculateComponentScores(componentData);
    const overallScore = this.calculateWeightedAverage(componentScores);

    return {
      entityId,
      entityType,
      componentScores,
      overallScore,
      calculatedAt: new Date(),
      metadata: {
        dataQuality: this.calculateDataQuality(componentData),
        sampleSize: Object.keys(componentData).length,
        timeRange: '30d'
      }
    };
  }

  /**
   * Calculate component scores
   */
  private async calculateComponentScores(data: Record<string, number>): Promise<ComponentScore[]> {
    const scores: ComponentScore[] = [];

    // Investment Score
    if (data.investmentScore !== undefined) {
      scores.push({
        type: 'investment',
        value: data.investmentScore,
        weight: this.weights.investment,
        contribution: data.investmentScore * this.weights.investment,
        metadata: {
          factors: {
            priceGrowth: data.priceGrowth || 0,
            rentalYield: data.rentalYield || 0,
            demand: data.demand || 0
          },
          trend: this.determineTrend(data.priceGrowth || 0),
          confidence: 0.85
        }
      });
    }

    // Demand Score
    if (data.demandScore !== undefined) {
      scores.push({
        type: 'demand',
        value: data.demandScore,
        weight: this.weights.demand,
        contribution: data.demandScore * this.weights.demand,
        metadata: {
          factors: {
            searchVolume: data.searchVolume || 0,
            inquiryRate: data.inquiryRate || 0,
            viewRate: data.viewRate || 0
          },
          trend: this.determineTrend(data.searchVolume || 0),
          confidence: 0.90
        }
      });
    }

    // Rental Score
    if (data.rentalScore !== undefined) {
      scores.push({
        type: 'rental',
        value: data.rentalScore,
        weight: this.weights.rental,
        contribution: data.rentalScore * this.weights.rental,
        metadata: {
          factors: {
            rentalYield: data.rentalYield || 0,
            occupancyRate: data.occupancyRate || 0,
            pricePerSqm: data.pricePerSqm || 0
          },
          trend: this.determineTrend(data.rentalYield || 0),
          confidence: 0.88
        }
      });
    }

    // Liquidity Score
    if (data.liquidity !== undefined) {
      scores.push({
        type: 'liquidity',
        value: data.liquidity,
        weight: this.weights.liquidity,
        contribution: data.liquidity * this.weights.liquidity,
        metadata: {
          factors: {
            daysOnMarket: data.daysOnMarket || 0,
            turnoverRate: data.turnoverRate || 0
          },
          trend: 'STABLE',
          confidence: 0.80
        }
      });
    }

    // Foreign Interest Score
    if (data.foreignInterest !== undefined) {
      scores.push({
        type: 'foreignInterest',
        value: data.foreignInterest,
        weight: this.weights.foreignInterest,
        contribution: data.foreignInterest * this.weights.foreignInterest,
        metadata: {
          factors: {
            foreignBuyerRatio: data.foreignBuyerRatio || 0,
            internationalInquiries: data.internationalInquiries || 0
          },
          trend: this.determineTrend(data.foreignBuyerRatio || 0),
          confidence: 0.82
        }
      });
    }

    // Market Trend Score
    if (data.marketTrend !== undefined) {
      scores.push({
        type: 'marketTrend',
        value: data.marketTrend,
        weight: this.weights.marketTrend,
        contribution: data.marketTrend * this.weights.marketTrend,
        metadata: {
          factors: {
            priceTrend: data.priceTrend || 0,
            volumeTrend: data.volumeTrend || 0
          },
          trend: this.determineTrend(data.priceTrend || 0),
          confidence: 0.75
        }
      });
    }

    // Infrastructure Score
    if (data.infrastructure !== undefined) {
      scores.push({
        type: 'infrastructure',
        value: data.infrastructure,
        weight: this.weights.infrastructure,
        contribution: data.infrastructure * this.weights.infrastructure,
        metadata: {
          factors: {
            transportScore: data.transportScore || 0,
            schoolScore: data.schoolScore || 0,
            amenityScore: data.amenityScore || 0
          },
          trend: 'STABLE',
          confidence: 0.70
        }
      });
    }

    // Risk Score (negative weight)
    if (data.risk !== undefined) {
      scores.push({
        type: 'risk',
        value: data.risk,
        weight: this.weights.risk,
        contribution: data.risk * this.weights.risk,
        metadata: {
          factors: {
            marketVolatility: data.marketVolatility || 0,
            economicRisk: data.economicRisk || 0,
            regulatoryRisk: data.regulatoryRisk || 0
          },
          trend: 'STABLE',
          confidence: 0.78
        }
      });
    }

    return scores;
  }

  /**
   * Calculate weighted average
   */
  private calculateWeightedAverage(scores: ComponentScore[]): number {
    if (scores.length === 0) return 0;

    const totalContribution = scores.reduce((sum, score) => sum + score.contribution, 0);
    const totalWeight = scores.reduce((sum, score) => sum + Math.abs(score.weight), 0);

    if (totalWeight === 0) return 0;

    return Math.max(0, Math.min(100, (totalContribution / totalWeight) * 100));
  }

  /**
   * Determine trend based on value
   */
  private determineTrend(value: number): 'IMPROVING' | 'STABLE' | 'DECLINING' {
    if (value > 5) return 'IMPROVING';
    if (value < -5) return 'DECLINING';
    return 'STABLE';
  }

  /**
   * Calculate data quality score
   */
  private calculateDataQuality(data: Record<string, number>): number {
    const totalFields = Object.keys(data).length;
    const filledFields = Object.values(data).filter(v => v !== undefined && v !== null).length;
    
    if (totalFields === 0) return 0;
    return (filledFields / totalFields) * 100;
  }

  /**
   * Batch calculate scores for multiple entities
   */
  async batchCalculateScores(
    entities: Array<{ entityId: string; entityType: EntityType; data: Record<string, number> }>
  ): Promise<IntelligenceScore[]> {
    const scores = [];

    for (const entity of entities) {
      const score = await this.calculateEntityScore(entity.entityId, entity.entityType, entity.data);
      scores.push(score);
    }

    return scores;
  }

  /**
   * Get score statistics
   */
  getScoreStatistics(scores: IntelligenceScore[]): {
    total: number;
    averageScore: number;
    minScore: number;
    maxScore: number;
    byEntityType: Record<EntityType, {
      count: number;
      averageScore: number;
    }>;
  } {
    if (scores.length === 0) {
      return {
        total: 0,
        averageScore: 0,
        minScore: 0,
        maxScore: 0,
        byEntityType: {} as any
      };
    }

    const overallScores = scores.map(s => s.overallScore);
    const averageScore = overallScores.reduce((sum, score) => sum + score, 0) / scores.length;
    const minScore = Math.min(...overallScores);
    const maxScore = Math.max(...overallScores);

    const byEntityType: Record<string, any> = {};

    scores.forEach(score => {
      if (!byEntityType[score.entityType]) {
        byEntityType[score.entityType] = {
          count: 0,
          totalScore: 0
        };
      }
      byEntityType[score.entityType].count++;
      byEntityType[score.entityType].totalScore += score.overallScore;
    });

    Object.keys(byEntityType).forEach(type => {
      byEntityType[type].averageScore = byEntityType[type].totalScore / byEntityType[type].count;
      delete byEntityType[type].totalScore;
    });

    return {
      total: scores.length,
      averageScore,
      minScore,
      maxScore,
      byEntityType: byEntityType as Record<EntityType, any>
    };
  }

  /**
   * Update score weights
   */
  updateWeights(weights: Partial<ScoreWeights>): void {
    this.weights = {
      ...this.weights,
      ...weights
    };
  }

  /**
   * Get current weights
   */
  getWeights(): ScoreWeights {
    return { ...this.weights };
  }

  /**
   * Compare two scores
   */
  compareScores(score1: IntelligenceScore, score2: IntelligenceScore): {
    difference: number;
    better: IntelligenceScore;
    improvementAreas: string[];
    declineAreas: string[];
  } {
    const difference = score1.overallScore - score2.overallScore;
    const better = difference > 0 ? score1 : score2;

    const improvementAreas: string[] = [];
    const declineAreas: string[] = [];

    score1.componentScores.forEach(comp1 => {
      const comp2 = score2.componentScores.find(c => c.type === comp1.type);
      if (comp2) {
        if (comp1.value > comp2.value) {
          improvementAreas.push(comp1.type);
        } else if (comp1.value < comp2.value) {
          declineAreas.push(comp1.type);
        }
      }
    });

    return {
      difference,
      better,
      improvementAreas,
      declineAreas
    };
  }
}

// Singleton instance
export const intelligenceScoreEngine = new IntelligenceScoreEngine();

/**
 * Example: Dubai Marina Intelligence Score
 */
export function exampleDubaiMarinaScore() {
  const engine = new IntelligenceScoreEngine();

  const dubaiMarinaData = {
    investmentScore: 91,
    demandScore: 94,
    rentalScore: 88,
    liquidity: 92,
    foreignInterest: 96,
    marketTrend: 85,
    infrastructure: 90,
    risk: 25,
    priceGrowth: 12.3,
    rentalYield: 8.5,
    demand: 0.88,
    searchVolume: 15.2,
    inquiryRate: 0.72,
    viewRate: 0.65,
    occupancyRate: 0.85,
    pricePerSqm: 15000,
    daysOnMarket: 45,
    turnoverRate: 0.15,
    foreignBuyerRatio: 0.42,
    internationalInquiries: 0.38,
    priceTrend: 8.5,
    volumeTrend: 12.0,
    transportScore: 92,
    schoolScore: 88,
    amenityScore: 95,
    marketVolatility: 15,
    economicRisk: 20,
    regulatoryRisk: 10
  };

  return engine.calculateEntityScore('dubai-marina', EntityType.NEIGHBORHOOD, dubaiMarinaData);
}
