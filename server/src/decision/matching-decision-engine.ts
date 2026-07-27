/**
 * Matching Decision Engine
 * Phase 5 — Smart Property + Agent + Financing Match
 *
 * Classic CRM → AI Real Estate Advisor
 *
 * User + Market + Property + Agent → Best bundle recommendation
 */

import { PrismaClient } from '@prisma/client';
import { DecisionRequest, DecisionOutput, DecisionCandidate } from './decision-engine';

const prisma = new PrismaClient();

export interface MatchBundle {
  propertyId: string;
  propertyScore: number;
  agentId: string;
  agentScore: number;
  marketFit: number;
  timingScore: number;  // Is now a good time to buy/rent in this market?
  bundleScore: number;  // Composite
  reasoning: string[];
}

export class MatchingDecisionEngine {
  async decide(request: DecisionRequest): Promise<DecisionOutput> {
    const { userId, countryIsoCode, citySlug } = request.context;
    const constraints = request.constraints ?? {};

    // ── 1. Load User Intelligence Profile ─────────────────────────────────────
    const userProfile = userId
      ? await (prisma as any).userIntelligenceProfile?.findUnique({ where: { userId } }).catch(() => null)
      : null;

    const budgetMax = constraints.budget?.max ?? userProfile?.budgetMax ?? 2_000_000;
    const budgetMin = constraints.budget?.min ?? userProfile?.budgetMin ?? 0;
    const preferredTypes = constraints.preferredPropertyTypes ?? userProfile?.propertyTypes ?? [];

    // ── 2. Candidate Properties ────────────────────────────────────────────────
    const properties = await prisma.property.findMany({
      where: {
        isActive: true,
        ...(countryIsoCode ? { countryIsoCode } : {}),
        price: { gte: budgetMin, lte: budgetMax },
        ...(preferredTypes.length > 0 ? { type: { in: preferredTypes } } : {}),
      },
      include: { location: true },
      take: 30,
    });

    // ── 3. Build Match Bundles ─────────────────────────────────────────────────
    const bundles: MatchBundle[] = [];

    for (const property of properties) {
      const propScore = await (prisma as any).propertyCurrentScore
        ?.findUnique({ where: { propertyId: property.id } })
        .catch(() => null);

      if (!propScore) continue;

      // Market timing for this location
      const marketFit = await this.getMarketFit(property.location?.id);

      // Best agent for this location
      const agent = await this.getBestMatchAgent(countryIsoCode, citySlug, propScore.investmentScore ?? 60);
      if (!agent) continue;

      const propertyScore = (propScore.investmentScore ?? 60) * 0.4 + (propScore.demandScore ?? 60) * 0.6;
      const timingScore = marketFit;
      const bundleScore = propertyScore * 0.45 + agent.performanceScore * 0.30 + timingScore * 0.25;

      bundles.push({
        propertyId: property.id,
        propertyScore: Math.round(propertyScore * 10) / 10,
        agentId: agent.agentId,
        agentScore: agent.performanceScore,
        marketFit: Math.round(marketFit * 10) / 10,
        timingScore: Math.round(timingScore * 10) / 10,
        bundleScore: Math.round(bundleScore * 10) / 10,
        reasoning: [
          `Property demand score: ${(propScore.demandScore ?? 60).toFixed(1)}`,
          `Agent performance: ${agent.performanceScore.toFixed(1)}`,
          `Market timing: ${marketFit.toFixed(1)}`,
          `Price: ${property.price?.toLocaleString() ?? 'N/A'} ${property.currency ?? ''}`,
        ],
      });
    }

    bundles.sort((a, b) => b.bundleScore - a.bundleScore);
    const topBundles = bundles.slice(0, 5);

    const topScore = topBundles[0]?.bundleScore ?? 0;
    const confidence = topScore >= 85 ? 'VERY_HIGH' : topScore >= 70 ? 'HIGH' : topScore >= 55 ? 'MEDIUM' : 'LOW';

    const candidates: DecisionCandidate[] = topBundles.map((b) => ({
      propertyId: b.propertyId,
      score: b.bundleScore,
      riskLevel: b.bundleScore >= 75 ? 'LOW' : b.bundleScore >= 55 ? 'MEDIUM' : 'HIGH',
      reasoning: b.reasoning,
      agentId: b.agentId,
      agentScore: b.agentScore,
    }));

    return {
      requestId: request.requestId,
      decisionType: 'AGENT_MATCH',
      confidence,
      priority: candidates.length > 0 ? 'HIGH' : 'MEDIUM',
      primaryRecommendation: candidates.length > 0
        ? `Matched ${candidates.length} optimal Property + Agent bundle(s). Top bundle score: ${topScore.toFixed(1)}/100.`
        : 'No matching bundles found. Consider broadening search criteria.',
      candidates,
      explanation: '',
      reasoning: [
        `User budget: ${budgetMin.toLocaleString()} – ${budgetMax.toLocaleString()}`,
        `Properties evaluated: ${properties.length}`,
        `Match bundles scored: ${bundles.length}`,
      ],
      alternativeActions: candidates.length === 0
        ? ['Broaden property type filter', 'Expand budget range', 'Try different city or district']
        : ['Book viewings with recommended agent', 'Request property reports', 'Set market alerts for top matches'],
      expiresAt: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000), // 2 days
      generatedAt: new Date(),
      metadata: {
        userPassportVersion: userProfile?.updatedAt?.toISOString(),
        modelsUsed: ['UserIntelligenceProfile', 'PropertyCurrentScore', 'AgentIntelligenceProfile', 'MarketIntelligenceProfile'],
      },
    };
  }

  private async getMarketFit(locationId?: string): Promise<number> {
    if (!locationId) return 65;
    try {
      const profile = await (prisma as any).marketIntelligenceProfile?.findFirst({
        where: { locationId },
        orderBy: { updatedAt: 'desc' },
      });
      return profile?.overallScore ?? 65;
    } catch {
      return 65;
    }
  }

  private async getBestMatchAgent(countryIsoCode?: string, citySlug?: string, minScore = 0) {
    try {
      const profiles = await (prisma as any).agentIntelligenceProfile?.findMany({
        where: {
          ...(countryIsoCode ? { agent: { countryIsoCode } } : {}),
          performanceScore: { gte: minScore * 0.7 },
        },
        orderBy: { performanceScore: 'desc' },
        take: 1,
      }) ?? [];

      return profiles[0] ?? null;
    } catch {
      return null;
    }
  }
}
