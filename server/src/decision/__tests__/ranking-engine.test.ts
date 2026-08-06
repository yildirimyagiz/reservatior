import { describe, it, expect } from 'bun:test';
import { RankingEngine, RankingInput } from '../ranking-engine';

function makeInput(overrides?: Partial<RankingInput>): RankingInput {
  return {
    propertyId: 'prop-1',
    opportunityScore: {
      overallScore: 85,
      opportunityTier: 'PREMIUM',
      acquisitionUrgency: 'IMMEDIATE',
      yieldScore: 80,
      priceGapScore: 90,
      demandScore: 85,
      vacancyScore: 75,
      riskScore: 70,
      liquidityScore: 80,
      yieldContribution: 20,
      priceGapContribution: 18,
      demandContribution: 17,
      vacancyContribution: 7.5,
      riskContribution: 10.5,
      liquidityContribution: 8,
      calculationTimestamp: new Date(),
      modelVersion: 'v1.0',
    },
    strategicAnalysis: {
      propertyId: 'prop-1',
      finalOpportunityScore: 85,
      recommendedStrategy: 'LUXURY_RENTAL',
      explanation: {
        whyScore: 'High yield area',
        regionalStrengths: 'Prime location',
        targetCustomerSegments: ['investors'],
        recommendedSalesStrategy: 'Premium listing',
        riskFactors: [],
        timingRecommendations: 'Buy now',
      },
      confidenceScore: 85,
      modelUsed: 'gemini-2.0',
      processingTimeMs: 500,
      timestamp: new Date(),
    },
    simulationResults: {
      propertyId: 'prop-1',
      baseOpportunityScore: 85,
      scenarios: [
        {
          scenarioName: 'Luxury Rental',
          scenarioType: 'RENTAL',
          estimatedTimeframe: 30,
          estimatedRevenue: 12000,
          estimatedCost: 2000,
          netProfit: 10000,
          profitMargin: 25,
          confidence: 80,
          riskFactors: ['market_downturn'],
          requirements: ['furnishing'],
        },
      ],
      recommendedScenario: 'Luxury Rental',
      recommendedConfidence: 85,
      simulationTimestamp: new Date(),
      modelVersion: 'v1.0',
    },
    ...overrides,
  };
}

describe('RankingEngine', () => {
  const engine = new RankingEngine();

  it('ranks properties by overall score', async () => {
    const result = await engine.rankProperties([
      makeInput({ propertyId: 'p1', opportunityScore: { ...makeInput().opportunityScore, overallScore: 90 } }),
      makeInput({ propertyId: 'p2', opportunityScore: { ...makeInput().opportunityScore, overallScore: 55 } }),
    ]);
    expect(result.rankedProperties[0].propertyId).toBe('p1');
    expect(result.rankedProperties[0].overallRank).toBe(1);
    expect(result.rankedProperties[1].overallRank).toBe(2);
  });

  it('returns empty for no inputs', async () => {
    const result = await engine.rankProperties([]);
    expect(result.rankedProperties).toHaveLength(0);
    expect(result.totalProperties).toBe(0);
  });

  it('single property returns rank 1', async () => {
    const result = await engine.rankProperties([makeInput()]);
    expect(result.rankedProperties).toHaveLength(1);
    expect(result.rankedProperties[0].overallRank).toBe(1);
  });

  it('includes metadata', async () => {
    const result = await engine.rankProperties([makeInput()]);
    expect(result.rankingTimestamp).toBeInstanceOf(Date);
    expect(result.modelVersion).toBe('v1.0');
    expect(result.rankingMethod).toBe('weighted_multi_factor');
  });

  it('score components are populated', async () => {
    const result = await engine.rankProperties([makeInput()]);
    const prop = result.rankedProperties[0];
    expect(prop.opportunityScore).toBeGreaterThanOrEqual(0);
    expect(prop.strategicScore).toBeGreaterThanOrEqual(0);
    expect(prop.simulationScore).toBeGreaterThanOrEqual(0);
    expect(prop.marketScore).toBeGreaterThanOrEqual(0);
  });

  it('key factors and risks are extracted', async () => {
    const result = await engine.rankProperties([makeInput()]);
    const prop = result.rankedProperties[0];
    expect(prop.keyFactors.length).toBeGreaterThan(0);
    expect(prop.risks.length).toBeGreaterThanOrEqual(0);
  });

  it('getTopProperties returns correct subset', async () => {
    const ranking = await engine.rankProperties([
      makeInput({ propertyId: 'p1', opportunityScore: { ...makeInput().opportunityScore, overallScore: 90 } }),
      makeInput({ propertyId: 'p2', opportunityScore: { ...makeInput().opportunityScore, overallScore: 70 } }),
      makeInput({ propertyId: 'p3', opportunityScore: { ...makeInput().opportunityScore, overallScore: 50 } }),
    ]);
    const top2 = engine.getTopProperties(ranking, 2);
    expect(top2).toHaveLength(2);
    expect(top2[0].propertyId).toBe('p1');
    expect(top2[1].propertyId).toBe('p2');
  });

  it('filterProperties by minScore works', async () => {
    const ranking = await engine.rankProperties([
      makeInput({ propertyId: 'p1', opportunityScore: { ...makeInput().opportunityScore, overallScore: 90, demandScore: 90, liquidityScore: 90 } }),
      makeInput({ propertyId: 'p2', opportunityScore: { ...makeInput().opportunityScore, overallScore: 10, demandScore: 10, liquidityScore: 10 } }),
    ]);
    const filtered = engine.filterProperties(ranking, { minScore: 60 });
    expect(filtered.length).toBeLessThan(ranking.rankedProperties.length);
    expect(filtered[0].propertyId).toBe('p1');
  });

  it('getRankingStats returns correct stats', async () => {
    const ranking = await engine.rankProperties([
      makeInput({ propertyId: 'p1', opportunityScore: { ...makeInput().opportunityScore, overallScore: 80 } }),
      makeInput({ propertyId: 'p2', opportunityScore: { ...makeInput().opportunityScore, overallScore: 60 } }),
    ]);
    const stats = engine.getRankingStats(ranking);
    expect(stats.totalProperties).toBe(2);
    expect(stats.averageScore).toBeGreaterThan(0);
    expect(stats.maxScore).toBeGreaterThanOrEqual(stats.minScore);
  });

  it('updateWeights validates sum', async () => {
    expect(() => {
      engine.updateWeights({ opportunity: 0.5, strategic: 0.5 });
    }).toThrow('Weights must sum to 1');
  });
});
