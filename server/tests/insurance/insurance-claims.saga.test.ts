import { describe, expect, test } from 'bun:test'
import {
  InsuranceClaimsSaga,
  evaluateClaim,
} from '../../src/core/workflows/insurance-claims.saga'

describe('evaluateClaim', () => {
  test('approves claim within coverage', () => {
    const result = evaluateClaim(5000, 10000)
    expect(result.approved).toBe(true)
    expect(result.amountApproved).toBe(5000)
  })

  test('caps approval at coverage amount', () => {
    const result = evaluateClaim(10000, 10000)
    expect(result.amountApproved).toBe(10000)
  })

  test('rejects claim exceeding coverage', () => {
    expect(() => evaluateClaim(15000, 10000)).toThrow(/CLAIM_AMOUNT_EXCEEDS_COVERAGE/)
  })
})

describe('InsuranceClaimsSaga', () => {
  test('starts in CLAIM_SUBMITTED step with claim payload', () => {
    const saga = new InsuranceClaimsSaga({
      claimId: 'C-1',
      policyId: 'P-1',
      claimType: 'DEPOSIT',
      amountRequested: 5000,
      countryCode: 'US',
    })
    expect(saga.status).toBe('STARTED')
    expect(saga.sagaData.step).toBe('CLAIM_SUBMITTED')
    expect(saga.sagaData.claimId).toBe('C-1')
    expect(saga.sagaData.amountRequested).toBe(5000)
  })
})
