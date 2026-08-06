import { describe, expect, test } from 'bun:test'
import {
  RentalFinancePlanSaga,
} from '../../src/core/workflows/rental-finance-payment.saga'
import {
  RentalFinanceRiskSaga,
} from '../../src/core/workflows/rental-finance-risk.saga'

describe('RentalFinancePlanSaga', () => {
  test('starts in PLAN_ACTIVATED step with plan payload', () => {
    const saga = new RentalFinancePlanSaga({
      rentalPlanId: 'PLAN-1',
      tenantId: 'T-1',
      landlordId: 'L-1',
      propertyId: 'PROP-1',
      countryCode: 'US',
    })
    expect(saga.status).toBe('STARTED')
    expect(saga.sagaData.step).toBe('PLAN_ACTIVATED')
    expect(saga.sagaData.rentalPlanId).toBe('PLAN-1')
    expect(saga.sagaData.tenantId).toBe('T-1')
  })
})

describe('RentalFinanceRiskSaga', () => {
  test('starts in PAYMENT_LATE step with late-payment payload', () => {
    const saga = new RentalFinanceRiskSaga({
      paymentId: 'PAY-1',
      rentalPlanId: 'PLAN-1',
      tenantId: 'T-1',
      daysLate: 3,
      countryCode: 'US',
    })
    expect(saga.status).toBe('STARTED')
    expect(saga.sagaData.step).toBe('PAYMENT_LATE')
    expect(saga.sagaData.paymentId).toBe('PAY-1')
    expect(saga.sagaData.daysLate).toBe(3)
  })

  test('defaults daysLate to 3 when missing', () => {
    const saga = new RentalFinanceRiskSaga({})
    expect(saga.sagaData.step).toBe('PAYMENT_LATE')
    expect(saga.sagaData.daysLate).toBeUndefined()
  })
})
