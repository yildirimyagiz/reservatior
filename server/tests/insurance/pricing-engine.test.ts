import { describe, expect, test } from 'bun:test'
import { InsurancePricingEngine } from '../../src/services/insurance/pricing-engine'

describe('InsurancePricingEngine', () => {
  const engine = new InsurancePricingEngine()

  test('should compute premium rate based on tenant reliability', () => {
    const resultHighRisk = engine.calculatePremium({
      tenantProfile: { reliabilityScore: 40 },
    })
    expect(resultHighRisk.premiumRate).toBe(0.03)
    expect(resultHighRisk.riskBand).toBe('HIGH')

    const resultLowRisk = engine.calculatePremium({
      tenantProfile: { reliabilityScore: 95 },
    })
    expect(resultLowRisk.premiumRate).toBe(0.01)
    expect(resultLowRisk.riskBand).toBe('LOW')
  })

  test('should respect maxPremiumRate cap', () => {
    const result = engine.calculatePremium({
      tenantProfile: { reliabilityScore: 40 },
      maxPremiumRate: 0.04,
    })
    expect(result.premiumRate).toBe(0.03)

    const withAdjustments = engine.calculatePremium({
      tenantProfile: { reliabilityScore: 40 },
      paymentHistory: [
        { status: 'COMPLETED', daysLate: 0 },
        { status: 'COMPLETED', daysLate: 0 },
        { status: 'COMPLETED', daysLate: 0 },
      ],
      fraudScore: 70,
      locationRisk: { level: 'HIGH' },
      maxPremiumRate: 0.04,
    })
    expect(withAdjustments.premiumRate).toBeLessThanOrEqual(0.04)
  })

  test('should adjust rate for income stability', () => {
    const stable = engine.calculatePremium({
      tenantProfile: { reliabilityScore: 80, incomeStability: 0.9 },
    })
    expect(stable.premiumRate).toBeLessThan(0.02)

    const unstable = engine.calculatePremium({
      tenantProfile: { reliabilityScore: 80, incomeStability: 0.2 },
    })
    expect(unstable.premiumRate).toBeGreaterThan(0.02)
  })
})
