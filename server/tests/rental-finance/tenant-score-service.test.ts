import { describe, expect, test } from 'bun:test'
import { TenantScoreService } from '../../src/services/rental-finance/tenant-score-service'

describe('TenantScoreService', () => {
  const service = new TenantScoreService()

  test('should return correct risk level for high score', async () => {
    const risk = service.getRiskLevel(95)
    expect(risk).toBe('VERY_LOW')
  })

  test('should return correct risk level for low score', async () => {
    const risk = service.getRiskLevel(40)
    expect(risk).toBe('HIGH')
  })
})
