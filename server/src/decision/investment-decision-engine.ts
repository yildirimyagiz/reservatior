/**
 * Investment Decision Engine
 * Phase 5 — Investment Advice
 */

import { PrismaClient } from '@prisma/client';
import { DecisionRequest, DecisionOutput, DecisionCandidate, DecisionGoal, DecisionRisk } from './decision-engine';

const prisma = new PrismaClient();

export class InvestmentDecisionEngine {
  async decide(request: DecisionRequest): Promise<DecisionOutput> {
    const { userId, countryIsoCode, citySlug } = request.context;
    const constraints = request.constraints ?? {};

    // ── 1. Load User Passport ──────────────────────────────────────────────────
    const userProfile = userId
      ? await (prisma as any).userIntelligenceProfile?.findUnique({ where: { userId } }).catch(() => null)
      : null;

    const effectiveBudgetMin = constraints.budget?.min ?? userProfile?.budgetMin ?? 0;
    const effectiveBudgetMax = constraints.budget?.max ?? userProfile?.budgetMax ?? 10_000_000;
    const effectiveGoal: DecisionGoal = constraints.goal ?? userProfile?.investmentGoal ?? 'RENTAL_YIELD';
    const riskTolerance: DecisionRisk = constraints.riskTolerance ?? userProfile?.riskTolerance ?? 'MEDIUM';

    // ── 2. Query Properties ────────────────────────────────────────────────────
    const properties = await prisma.property.findMany({
      where: {
        ...(countryIsoCode ? { countryIsoCode } : {}),
        ...(citySlug ? { city: citySlug } : {}),
        listingPrice: {
          gte: effectiveBudgetMin,
          lte: effectiveBudgetMax,
        },
      },
      include: { location: true },
      take: 50,
      orderBy: { createdAt: 'desc' },
    });

    // ── 3. Score Each Property ─────────────────────────────────────────────────
    const candidates: DecisionCandidate[] = [];

    for (const property of properties) {
      const currentScore = await (prisma as any).propertyCurrentScore
        ?.findUnique({ where: { propertyId: property.id } })
        .catch(() => null);

      if (!currentScore) continue;

      const investmentScore: number = currentScore.investmentScore ?? 60;
      const rentalScore: number = currentScore.rentalScore ?? 60;
      const demandScore: number = currentScore.demandScore ?? 60;

      let compositeScore: number;
      let expectedYield: number;
      let expectedAppreciation: number;

      if (effectiveGoal === 'RENTAL_YIELD') {
        compositeScore = rentalScore * 0.5 + investmentScore * 0.3 + demandScore * 0.2;
        expectedYield = (rentalScore / 100) * 12;
        expectedAppreciation = (investmentScore / 100) * 8;
      } else if (effectiveGoal === 'CAPITAL_APPRECIATION') {
        compositeScore = investmentScore * 0.6 + demandScore * 0.25 + rentalScore * 0.15;
        expectedYield = (rentalScore / 100) * 6;
        expectedAppreciation = (investmentScore / 100) * 15;
      } else {
        compositeScore = (investmentScore + rentalScore + demandScore) / 3;
        expectedYield = (rentalScore / 100) * 9;
        expectedAppreciation = (investmentScore / 100) * 10;
      }

      const riskLevel: DecisionRisk = compositeScore >= 75 ? 'LOW' : compositeScore >= 55 ? 'MEDIUM' : 'HIGH';

      if (riskTolerance === 'LOW' && riskLevel === 'HIGH') continue;
      if (riskTolerance === 'MEDIUM' && riskLevel === 'HIGH') compositeScore *= 0.85;

      const bestAgent = await this.findBestAgent(property.id, countryIsoCode);
      const priceStr = property.listingPrice ? `${Number(property.listingPrice).toLocaleString()} ${property.currency}` : 'N/A';

      candidates.push({
        propertyId: property.id,
        score: Math.round(compositeScore * 10) / 10,
        expectedYield: Math.round(expectedYield * 10) / 10,
        expectedAppreciation: Math.round(expectedAppreciation * 10) / 10,
        riskLevel,
        reasoning: [
          `Investment score: ${investmentScore.toFixed(1)}`,
          `Rental score: ${rentalScore.toFixed(1)}`,
          `Demand score: ${demandScore.toFixed(1)}`,
          `Goal: ${effectiveGoal}`,
          `Price: ${priceStr}`,
        ],
        agentId: bestAgent?.agentId,
        agentScore: bestAgent?.performanceScore,
      });
    }

    // ── 4. Sort and Finalize ───────────────────────────────────────────────────
    candidates.sort((a, b) => b.score - a.score);
    const top = candidates.slice(0, 5);
    const topScore = top[0]?.score ?? 0;
    const confidence = topScore >= 85 ? 'VERY_HIGH' : topScore >= 70 ? 'HIGH' : topScore >= 55 ? 'MEDIUM' : 'LOW';

    return {
      requestId: request.requestId,
      decisionType: 'BUY_PROPERTY',
      confidence,
      priority: top.length > 0 ? 'HIGH' : 'MEDIUM',
      primaryRecommendation: top.length > 0
        ? `Found ${top.length} opportunity(ies). Top match scored ${topScore.toFixed(1)}/100 with est. yield ${top[0]?.expectedYield ?? 0}%.`
        : 'No suitable properties found. Consider expanding budget or location range.',
      candidates: top,
      explanation: '',
      reasoning: [
        `Goal: ${effectiveGoal}`,
        `Budget: ${effectiveBudgetMin.toLocaleString()} – ${effectiveBudgetMax.toLocaleString()}`,
        `Risk tolerance: ${riskTolerance}`,
        `Properties evaluated: ${properties.length}`,
        `Qualified candidates: ${candidates.length}`,
      ],
      alternativeActions: top.length === 0
        ? ['Expand budget range', 'Consider different property types', 'Explore adjacent markets']
        : ['Schedule viewings for top 3', 'Request agent introductions', 'Review market trends'],
      expiresAt: new Date(Date.now() + 3 * 24 * 60 * 60 * 1000),
      generatedAt: new Date(),
      metadata: {
        userPassportVersion: userProfile?.updatedAt?.toISOString(),
        modelsUsed: ['UserIntelligenceProfile', 'PropertyCurrentScore', 'AgentIntelligenceProfile'],
      },
    };
  }

  private async findBestAgent(propertyId: string, countryIsoCode?: string) {
    try {
      const profiles = await (prisma as any).agentIntelligenceProfile?.findMany({
        orderBy: { performanceScore: 'desc' },
        take: 1,
      }) ?? [];
      return profiles[0] ?? null;
    } catch {
      return null;
    }
  }
}
