import { describe, expect, test } from 'bun:test'
import {
  InsurancePolicySaga,
  evaluateUnderwriting,
  UNDERWRITING_RISK_THRESHOLD,
} from '../../src/core/workflows/insurance-policy.saga'

describe('evaluateUnderwriting', () => {
  test('approves low-risk quotes (score <= threshold)', () => {
    const result = evaluateUnderwriting(20)
    expect(result.approved).toBe(true)
    expect(result.riskScore).toBe(20)
  })

  test('approves quote exactly at the threshold', () => {
    const result = evaluateUnderwriting(UNDERWRITING_RISK_THRESHOLD)
    expect(result.approved).toBe(true)
  })

  test('rejects high-risk quotes (score > threshold)', () => {
    expect(() => evaluateUnderwriting(90)).toThrow(/UNDERWRITING_REJECTED/)
  })

  test('threshold default is 75', () => {
    expect(UNDERWRITING_RISK_THRESHOLD).toBe(75)
  })
})

describe('InsurancePolicySaga', () => {
  test('starts in QUOTE_CREATED step with quote payload', () => {
    const saga = new InsurancePolicySaga({
      quoteId: 'Q-1',
      policyId: 'P-1',
      rentalPlanId: 'PLAN-1',
      riskScore: 20,
      countryCode: 'US',
    })
    expect(saga.status).toBe('STARTED')
    expect(saga.sagaData.step).toBe('QUOTE_CREATED')
    expect(saga.sagaData.quoteId).toBe('Q-1')
    expect(saga.sagaData.rentalPlanId).toBe('PLAN-1')
    expect(saga.sagaData.riskScore).toBe(20)
  })

  test('defaults missing fields gracefully', () => {
    const saga = new InsurancePolicySaga({})
    expect(saga.sagaData.step).toBe('QUOTE_CREATED')
    expect(saga.localization.countryCode).toBe('US')
  })
})
