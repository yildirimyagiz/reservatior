import { describe, it, expect } from 'bun:test';
import { IntelligenceScoreEngine, EntityType } from '../intelligence-score-engine';

describe('IntelligenceScoreEngine', () => {
  const engine = new IntelligenceScoreEngine();

  it('calculates entity score with all components', async () => {
    const result = await engine.calculateEntityScore('test-1', EntityType.CITY, {
      investmentScore: 80,
      demandScore: 70,
      rentalScore: 75,
      liquidity: 65,
      foreignInterest: 90,
      marketTrend: 85,
      infrastructure: 78,
      risk: 30,
    });
    expect(result.overallScore).toBeGreaterThan(0);
    expect(result.overallScore).toBeLessThanOrEqual(100);
    expect(result.componentScores.length).toBeGreaterThan(0);
    expect(result.entityId).toBe('test-1');
    expect(result.entityType).toBe(EntityType.CITY);
  });

  it('returns 0 for empty data', async () => {
    const result = await engine.calculateEntityScore('empty', EntityType.PROPERTY, {});
    expect(result.overallScore).toBe(0);
    expect(result.componentScores.length).toBe(0);
  });

  it('applies negative risk weight correctly', async () => {
    const lowRisk = await engine.calculateEntityScore('a', EntityType.DISTRICT, {
      investmentScore: 50,
      demandScore: 50,
      rentalScore: 50,
      liquidity: 50,
      foreignInterest: 50,
      risk: 15,
    });
    const highRisk = await engine.calculateEntityScore('b', EntityType.DISTRICT, {
      investmentScore: 50,
      demandScore: 50,
      rentalScore: 50,
      liquidity: 50,
      foreignInterest: 50,
      risk: 85,
    });
    expect(lowRisk.overallScore).toBeGreaterThanOrEqual(highRisk.overallScore);
  });

  it('calculates data quality metadata', async () => {
    const full = await engine.calculateEntityScore('full', EntityType.CITY, {
      investmentScore: 80,
      demandScore: 70,
    });
    expect(full.metadata?.dataQuality).toBe(100);
    expect(full.metadata?.sampleSize).toBe(2);
  });

  it('batch calculates scores', async () => {
    const results = await engine.batchCalculateScores([
      { entityId: 'a', entityType: EntityType.CITY, data: { investmentScore: 80, demandScore: 70 } },
      { entityId: 'b', entityType: EntityType.DISTRICT, data: { investmentScore: 60, demandScore: 50 } },
    ]);
    expect(results.length).toBe(2);
    expect(results[0].entityId).toBe('a');
    expect(results[1].entityId).toBe('b');
  });

  it('score statistics work', async () => {
    const scores = await engine.batchCalculateScores([
      { entityId: 'a', entityType: EntityType.CITY, data: { investmentScore: 90, demandScore: 80 } },
      { entityId: 'b', entityType: EntityType.CITY, data: { investmentScore: 60, demandScore: 50 } },
    ]);
    const stats = engine.getScoreStatistics(scores);
    expect(stats.total).toBe(2);
    expect(stats.averageScore).toBeGreaterThan(0);
    expect(stats.minScore).toBeLessThanOrEqual(stats.maxScore);
  });

  it('compare scores identifies better entity', async () => {
    const scoreA = await engine.calculateEntityScore('a', EntityType.CITY, {
      investmentScore: 30,
      demandScore: 25,
      rentalScore: 20,
      liquidity: 20,
      foreignInterest: 25,
      marketTrend: 20,
      infrastructure: 15,
      risk: 5,
    });
    const scoreB = await engine.calculateEntityScore('b', EntityType.CITY, {
      investmentScore: 5,
      demandScore: 5,
      rentalScore: 5,
      liquidity: 5,
      foreignInterest: 5,
      marketTrend: 5,
      infrastructure: 5,
      risk: 5,
    });
    const comparison = engine.compareScores(scoreA, scoreB);
    expect(comparison.better.entityId).toBe('a');
    expect(comparison.difference).toBeGreaterThan(0);
  });

  it('metadata includes calculatedAt', async () => {
    const result = await engine.calculateEntityScore('test', EntityType.NEIGHBORHOOD, {
      investmentScore: 75,
    });
    expect(result.calculatedAt).toBeInstanceOf(Date);
  });

  it('individual component scores have correct weights', async () => {
    const result = await engine.calculateEntityScore('test', EntityType.CITY, {
      investmentScore: 80,
      risk: 20,
    });
    const invComp = result.componentScores.find((c) => c.type === 'investment');
    const riskComp = result.componentScores.find((c) => c.type === 'risk');
    expect(invComp).toBeDefined();
    expect(riskComp).toBeDefined();
    expect(invComp!.weight).toBe(0.25);
    expect(riskComp!.weight).toBe(-0.15);
  });
});
