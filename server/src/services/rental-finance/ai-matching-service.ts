/**
 * AI Tenant-Landlord Matching Service
 *
 * Computes a 0-100 compatibility score between a tenant and a property based
 * on financial reliability, location fit and application signals. Pure +
 * deterministic so it is unit-testable; can later be superseded by the ML
 * bridge without changing the interface.
 */
export interface MatchContext {
  reliabilityScore?: number;
  incomeStability?: number;
  desiredRegion?: string;
  propertyRegion?: string;
  familySize?: number;
  propertyCapacity?: number;
  creditScore?: number;
  referencesPositive?: boolean;
}

export class AIMatchingService {
  computeMatchScore(tenantId: string, propertyId: string, context: MatchContext = {}): number {
    let score = 0;
    const factors: Record<string, number> = {};

    // 1. Financial reliability (weight 40)
    const reliability = context.reliabilityScore ?? 50;
    factors.financial = (reliability / 100) * 40;
    score += factors.financial;

    // 2. Income stability (weight 20)
    const incomeStability = context.incomeStability ?? 0.5;
    factors.income = incomeStability * 20;
    score += factors.income;

    // 3. Region fit (weight 20)
    if (context.desiredRegion && context.propertyRegion) {
      factors.region = context.desiredRegion === context.propertyRegion ? 20 : 5;
    } else {
      factors.region = 10;
    }
    score += factors.region;

    // 4. Capacity fit (weight 10)
    if (context.familySize != null && context.propertyCapacity != null) {
      factors.capacity =
        context.familySize <= context.propertyCapacity ? 10 : Math.max(0, 10 - (context.familySize - context.propertyCapacity) * 5);
    } else {
      factors.capacity = 5;
    }
    score += factors.capacity;

    // 5. Credit + references (weight 10)
    const credit = context.creditScore ?? 600;
    factors.credit = Math.min(7, (credit - 500) / 100);
    factors.references = context.referencesPositive === false ? -3 : 3;
    score += factors.credit + factors.references;

    return Math.max(0, Math.min(100, Math.round(score * 10) / 10));
  }
}

export const aiMatchingService = new AIMatchingService();
