/**
 * Opportunity Engine Validation Test
 * 
 * Validates that Opportunity Engine adapts to different countries
 * Same mathematical model, different weights and factors per country
 */

import { opportunityEngine } from '../../src/intelligence/opportunity-engine-v2';
import { OpportunityScoreInput } from '../../src/intelligence/opportunity-engine-v2';

describe('Opportunity Engine Validation', () => {
  test('should calculate different scores for same property in different countries', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Test Location',
      propertyType: 'apartment',
      currentCondition: 'good',
      neighborhoodData: {
        averagePrice: 110000,
        demandLevel: 80,
        vacancyRate: 0.05,
        crimeRate: 0.02
      }
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 80,
      competitionLevel: 60,
      marketTrend: 'GROWTH'
    };

    const additionalFactors = {
      yield: 0.08,
      vacancy: 0.05,
      demand: 80,
      risk: 30,
      liquidity: 70
    };

    // Calculate for UAE (tax-free, high yield weight)
    const aeInput: OpportunityScoreInput = {
      country_code: 'AE',
      propertyData,
      marketData,
      additionalFactors
    };

    const aeResult = await opportunityEngine.calculateScore(aeInput);

    // Calculate for Turkey (higher risk weight, earthquake factor)
    const trInput: OpportunityScoreInput = {
      country_code: 'TR',
      propertyData,
      marketData,
      additionalFactors
    };

    const trResult = await opportunityEngine.calculateScore(trInput);

    // Calculate for USA (higher liquidity weight)
    const usInput: OpportunityScoreInput = {
      country_code: 'US',
      propertyData,
      marketData,
      additionalFactors
    };

    const usResult = await opportunityEngine.calculateScore(usInput);

    // All should have valid scores
    expect(aeResult.overallScore).toBeGreaterThanOrEqual(0);
    expect(aeResult.overallScore).toBeLessThanOrEqual(100);
    expect(trResult.overallScore).toBeGreaterThanOrEqual(0);
    expect(trResult.overallScore).toBeLessThanOrEqual(100);
    expect(usResult.overallScore).toBeGreaterThanOrEqual(0);
    expect(usResult.overallScore).toBeLessThanOrEqual(100);

    // UAE should have higher yield weight (30% vs 20% default)
    expect(aeResult.weights.yield).toBe(0.30);
    expect(trResult.weights.yield).toBe(0.20);
    expect(usResult.weights.yield).toBe(0.25);

    // Turkey should have higher risk weight (20% vs 15% default)
    expect(trResult.weights.risk).toBe(0.20);
    expect(aeResult.weights.risk).toBe(0.15);
    expect(usResult.weights.risk).toBe(0.15);

    // USA should have higher liquidity weight (15% vs 10% default)
    expect(usResult.weights.liquidity).toBe(0.15);
    expect(aeResult.weights.liquidity).toBe(0.10);
    expect(trResult.weights.liquidity).toBe(0.10);

    console.log('UAE Score:', aeResult.overallScore, 'Weights:', aeResult.weights);
    console.log('Turkey Score:', trResult.overallScore, 'Weights:', trResult.weights);
    console.log('USA Score:', usResult.overallScore, 'Weights:', usResult.weights);
  });

  test('should apply country-specific adjustments', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Dubai Marina',
      propertyType: 'apartment',
      currentCondition: 'good',
      neighborhoodData: {
        averagePrice: 110000,
        demandLevel: 80,
        vacancyRate: 0.04,
        crimeRate: 0.01
      }
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 85,
      competitionLevel: 50,
      marketTrend: 'GROWTH'
    };

    const additionalFactors = {
      yield: 0.085,
      vacancy: 0.04,
      demand: 85,
      risk: 20,
      liquidity: 80
    };

    const aeInput: OpportunityScoreInput = {
      country_code: 'AE',
      propertyData,
      marketData,
      additionalFactors
    };

    const aeResult = await opportunityEngine.calculateScore(aeInput);

    // UAE should have location premium adjustment
    expect(aeResult.countryAdjustments).toHaveProperty('location_premium');
    expect(aeResult.countryAdjustments.location_premium).toBe(0.20);

    // UAE should have luxury premium adjustment
    expect(aeResult.countryAdjustments).toHaveProperty('luxury_premium');
    expect(aeResult.countryAdjustments.luxury_premium).toBe(0.25);
  });

  test('should determine opportunity tier based on country thresholds', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Test Location',
      propertyType: 'apartment',
      currentCondition: 'good'
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 90,
      competitionLevel: 40,
      marketTrend: 'GROWTH'
    };

    const additionalFactors = {
      yield: 0.09,
      vacancy: 0.03,
      demand: 90,
      risk: 15,
      liquidity: 85
    };

    // High score property
    const highScoreInput: OpportunityScoreInput = {
      country_code: 'AE',
      propertyData,
      marketData,
      additionalFactors
    };

    const highScoreResult = await opportunityEngine.calculateScore(highScoreInput);
    expect(['HIGH_POTENTIAL', 'PREMIUM']).toContain(highScoreResult.opportunityTier);

    // Low score property
    const lowScoreInput: OpportunityScoreInput = {
      country_code: 'AE',
      propertyData: {
        ...propertyData,
        price: 150000 // Higher price, lower opportunity
      },
      marketData: {
        ...marketData,
        demandLevel: 40 // Lower demand
      },
      additionalFactors: {
        yield: 0.04,
        vacancy: 0.10,
        demand: 40,
        risk: 60,
        liquidity: 50
      }
    };

    const lowScoreResult = await opportunityEngine.calculateScore(lowScoreInput);
    expect(['LOW_POTENTIAL', 'MONITOR']).toContain(lowScoreResult.opportunityTier);
  });

  test('should calculate component scores correctly', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Test Location',
      propertyType: 'apartment',
      currentCondition: 'good',
      neighborhoodData: {
        averagePrice: 110000,
        demandLevel: 80,
        vacancyRate: 0.05,
        crimeRate: 0.02
      }
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 80,
      competitionLevel: 60,
      marketTrend: 'GROWTH'
    };

    const additionalFactors = {
      yield: 0.08,
      vacancy: 0.05,
      demand: 80,
      risk: 30,
      liquidity: 70
    };

    const input: OpportunityScoreInput = {
      country_code: 'TR',
      propertyData,
      marketData,
      additionalFactors
    };

    const result = await opportunityEngine.calculateScore(input);

    // All component scores should be between 0-100
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

    // Weights should sum to 1
    const weightSum = Object.values(result.weights).reduce((sum, weight) => sum + weight, 0);
    expect(Math.abs(weightSum - 1)).toBeLessThan(0.01);
  });

  test('should handle missing country context gracefully', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Test Location',
      propertyType: 'apartment',
      currentCondition: 'good'
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 80,
      competitionLevel: 60,
      marketTrend: 'GROWTH'
    };

    const input: OpportunityScoreInput = {
      country_code: 'INVALID_COUNTRY',
      propertyData,
      marketData
    };

    await expect(opportunityEngine.calculateScore(input)).rejects.toThrow();
  });

  test('should batch calculate scores for multiple properties', async () => {
    const inputs: OpportunityScoreInput[] = [
      {
        country_code: 'TR',
        propertyData: {
          price: 100000,
          size: 100,
          rooms: 3,
          location: 'Istanbul',
          propertyType: 'apartment',
          currentCondition: 'good'
        },
        marketData: {
          averagePrice: 110000,
          priceTrend: 'RISING',
          demandLevel: 80,
          competitionLevel: 60,
          marketTrend: 'GROWTH'
        }
      },
      {
        country_code: 'AE',
        propertyData: {
          price: 200000,
          size: 150,
          rooms: 4,
          location: 'Dubai',
          propertyType: 'villa',
          currentCondition: 'excellent'
        },
        marketData: {
          averagePrice: 220000,
          priceTrend: 'RISING',
          demandLevel: 85,
          competitionLevel: 50,
          marketTrend: 'GROWTH'
        }
      }
    ];

    const results = await opportunityEngine.batchCalculateScores(inputs);

    expect(results).toHaveLength(2);
    expect(results[0].countryContext.country_code).toBe('TR');
    expect(results[1].countryContext.country_code).toBe('AE');
  });

  test('should determine acquisition urgency correctly', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Test Location',
      propertyType: 'apartment',
      currentCondition: 'good'
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 90,
      competitionLevel: 40,
      marketTrend: 'GROWTH'
    };

    const additionalFactors = {
      yield: 0.09,
      vacancy: 0.03,
      demand: 90,
      risk: 15,
      liquidity: 85
    };

    const input: OpportunityScoreInput = {
      country_code: 'AE',
      propertyData,
      marketData,
      additionalFactors
    };

    const result = await opportunityEngine.calculateScore(input);

    // High score + high demand should result in HIGH or IMMEDIATE urgency
    expect(['HIGH', 'IMMEDIATE']).toContain(result.acquisitionUrgency);
  });
});

describe('Opportunity Engine Country-Specific Behavior', () => {
  test('Turkey should apply earthquake risk adjustment', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Istanbul',
      propertyType: 'apartment',
      currentCondition: 'good'
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 80,
      competitionLevel: 60,
      marketTrend: 'GROWTH'
    };

    const input: OpportunityScoreInput = {
      country_code: 'TR',
      propertyData,
      marketData
    };

    const result = await opportunityEngine.calculateScore(input);

    // Turkey should have earthquake risk adjustment
    expect(result.countryAdjustments).toHaveProperty('earthquake_risk');
    expect(result.countryAdjustments.earthquake_risk).toBe(-0.15);
  });

  test('UAE should apply tourism potential adjustment', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'Dubai',
      propertyType: 'apartment',
      currentCondition: 'good'
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 80,
      competitionLevel: 60,
      marketTrend: 'GROWTH'
    };

    const input: OpportunityScoreInput = {
      country_code: 'AE',
      propertyData,
      marketData
    };

    const result = await opportunityEngine.calculateScore(input);

    // UAE should have tourism potential adjustment
    expect(result.countryAdjustments).toHaveProperty('tourism_potential');
    expect(result.countryAdjustments.tourism_potential).toBe(0.10);
  });

  test('USA should apply school quality adjustment', async () => {
    const propertyData = {
      price: 100000,
      size: 100,
      rooms: 3,
      location: 'New York',
      propertyType: 'apartment',
      currentCondition: 'good'
    };

    const marketData = {
      averagePrice: 110000,
      priceTrend: 'RISING',
      demandLevel: 80,
      competitionLevel: 60,
      marketTrend: 'GROWTH'
    };

    const input: OpportunityScoreInput = {
      country_code: 'US',
      propertyData,
      marketData
    };

    const result = await opportunityEngine.calculateScore(input);

    // USA should have school quality adjustment
    expect(result.countryAdjustments).toHaveProperty('school_quality');
    expect(result.countryAdjustments.school_quality).toBe(0.12);
  });
});
