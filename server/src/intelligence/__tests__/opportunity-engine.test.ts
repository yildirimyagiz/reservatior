import { describe, it, expect } from 'bun:test';
import { OpportunityEngine, OpportunityFactors } from '../opportunity-engine';

function makeGoodFactors(overrides?: Partial<OpportunityFactors>): OpportunityFactors {
  return {
    capRate: 8,
    cashOnCashReturn: 12,
    grossYield: 10,
    netYield: 7,
    listingPrice: 100_000,
    estimatedMarketValue: 120_000,
    priceGapPercentage: 20,
    marketDemandScore: 85,
    searchVolume: 1000,
    daysOnMarket: 15,
    areaVacancyRate: 3,
    propertyVacancyRate: 0,
    riskScore: 20,
    locationRisk: 15,
    marketRisk: 25,
    liquidityScore: 80,
    marketLiquidity: 75,
    ...overrides,
  };
}

describe('OpportunityEngine', () => {
  const engine = new OpportunityEngine();

  it('calculates high-potential tier for good property', () => {
    const result = engine.calculateScore(makeGoodFactors());
    expect(result.overallScore).toBeGreaterThanOrEqual(50);
    expect(['HIGH_POTENTIAL', 'PREMIUM']).toContain(result.opportunityTier);
  });

  it('calculates low tier for poor property', () => {
    const result = engine.calculateScore(
      makeGoodFactors({
        capRate: 1,
        cashOnCashReturn: 2,
        grossYield: 2,
        netYield: 1,
        priceGapPercentage: 2,
        marketDemandScore: 10,
        searchVolume: 10,
        daysOnMarket: 180,
        areaVacancyRate: 20,
        propertyVacancyRate: 15,
        riskScore: 90,
        locationRisk: 85,
        marketRisk: 80,
        liquidityScore: 20,
        marketLiquidity: 15,
      }),
    );
    expect(result.overallScore).toBeLessThanOrEqual(50);
    expect(result.opportunityTier).toBe('LOW_POTENTIAL');
  });

  it('score components sum to overall', () => {
    const result = engine.calculateScore(makeGoodFactors());
    const componentSum =
      result.yieldContribution +
      result.priceGapContribution +
      result.demandContribution +
      result.vacancyContribution +
      result.riskContribution +
      result.liquidityContribution;
    expect(Math.abs(componentSum - result.overallScore)).toBeLessThanOrEqual(1);
  });

  it('all component scores are between 0 and 100', () => {
    const result = engine.calculateScore(makeGoodFactors());
    expect(result.yieldScore).toBeGreaterThanOrEqual(0);
    expect(result.yieldScore).toBeLessThanOrEqual(100);
    expect(result.priceGapScore).toBeGreaterThanOrEqual(0);
    expect(result.priceGapScore).toBeLessThanOrEqual(100);
    expect(result.demandScore).toBeGreaterThanOrEqual(0);
    expect(result.demandScore).toBeLessThanOrEqual(100);
    expect(result.vacancyScore).toBeGreaterThanOrEqual(0);
    expect(result.vacancyScore).toBeLessThanOrEqual(100);
    expect(result.riskScore).toBeGreaterThanOrEqual(0);
    expect(result.riskScore).toBeLessThanOrEqual(100);
    expect(result.liquidityScore).toBeGreaterThanOrEqual(0);
    expect(result.liquidityScore).toBeLessThanOrEqual(100);
  });

  it('includes model version and timestamp', () => {
    const result = engine.calculateScore(makeGoodFactors());
    expect(result.modelVersion).toBe('v1.0');
    expect(result.calculationTimestamp).toBeInstanceOf(Date);
  });

  it('higher price gap yields higher score', () => {
    const low = engine.calculateScore(makeGoodFactors({ priceGapPercentage: 5 }));
    const high = engine.calculateScore(makeGoodFactors({ priceGapPercentage: 25 }));
    expect(high.overallScore).toBeGreaterThan(low.overallScore);
  });

  it('lower risk yields higher score', () => {
    const low = engine.calculateScore(makeGoodFactors({ riskScore: 80, locationRisk: 75, marketRisk: 70 }));
    const high = engine.calculateScore(makeGoodFactors({ riskScore: 10, locationRisk: 5, marketRisk: 10 }));
    expect(high.overallScore).toBeGreaterThan(low.overallScore);
  });

  it('lower vacancy yields higher score', () => {
    const low = engine.calculateScore(makeGoodFactors({ areaVacancyRate: 25, propertyVacancyRate: 20 }));
    const high = engine.calculateScore(makeGoodFactors({ areaVacancyRate: 1, propertyVacancyRate: 0 }));
    expect(high.overallScore).toBeGreaterThan(low.overallScore);
  });
});
