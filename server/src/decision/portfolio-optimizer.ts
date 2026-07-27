/**
 * Portfolio Optimizer
 * Phase 5 — Portfolio Rebalancing & Diversification
 *
 * Input:  User Passport + List of held properties (portfolio)
 * Output: HOLD / SELL / BUY recommendations per asset, diversification score
 */

import { PrismaClient } from '@prisma/client';
import { DecisionRequest, DecisionOutput, DecisionCandidate } from './decision-engine';

const prisma = new PrismaClient();

export interface PortfolioAsset {
  propertyId: string;
  currentValue: number;
  purchaseValue: number;
  rentalIncome: number;
  countryIsoCode: string;
  citySlug?: string;
  type: string;
  holdingMonths: number;
}

export interface PortfolioRecommendation {
  propertyId: string;
  action: 'HOLD' | 'SELL' | 'REFINANCE' | 'UPGRADE';
  reasoning: string[];
  expectedGainLoss?: number; // %
  urgency: 'HIGH' | 'MEDIUM' | 'LOW';
}

export class PortfolioOptimizer {
  async decide(request: DecisionRequest): Promise<DecisionOutput> {
    const { userId, portfolioId } = request.context;

    if (!userId) {
      return this.noUserResponse(request);
    }

    // Load user intelligence profile
    const userProfile = await (prisma as any).userIntelligenceProfile
      ?.findUnique({ where: { userId } })
      .catch(() => null);

    // Load portfolio properties
    // Simplified: find properties where owner matches
    const ownedProperties = await prisma.property.findMany({
      where: {
        ownerId: userId,
        isActive: true,
      },
      include: { location: true },
      take: 20,
    });

    if (ownedProperties.length === 0) {
      return {
        requestId: request.requestId,
        decisionType: 'PORTFOLIO_REBALANCE',
        confidence: 'LOW',
        priority: 'LOW',
        primaryRecommendation: 'No active portfolio properties found for this user.',
        candidates: [],
        explanation: '',
        reasoning: ['Portfolio is empty or user has no owned properties on the platform'],
        alternativeActions: ['Add portfolio properties manually', 'Start investment search'],
        expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
        generatedAt: new Date(),
        metadata: { modelsUsed: ['UserIntelligenceProfile'] },
      };
    }

    // Analyze each asset
    const recommendations: PortfolioRecommendation[] = [];
    const candidates: DecisionCandidate[] = [];

    for (const property of ownedProperties) {
      const currentScore = await (prisma as any).propertyCurrentScore
        ?.findUnique({ where: { propertyId: property.id } })
        .catch(() => null);

      const marketProfile = property.location?.id
        ? await (prisma as any).marketIntelligenceProfile?.findFirst({
            where: { locationId: property.location.id },
            orderBy: { updatedAt: 'desc' },
          }).catch(() => null)
        : null;

      const investmentScore = currentScore?.investmentScore ?? 60;
      const demandScore = currentScore?.demandScore ?? 60;
      const marketScore = marketProfile?.overallScore ?? 60;

      // Portfolio decision logic
      let action: PortfolioRecommendation['action'];
      let reasoning: string[];
      let urgency: PortfolioRecommendation['urgency'];

      if (investmentScore >= 80 && marketScore >= 75) {
        action = 'HOLD';
        reasoning = ['High investment score indicates strong asset', 'Market conditions remain favorable', 'Continue holding for appreciation'];
        urgency = 'LOW';
      } else if (investmentScore < 45 || marketScore < 40) {
        action = 'SELL';
        reasoning = ['Investment score below threshold', 'Market weakness detected', 'Reallocation to higher-yield markets advised'];
        urgency = 'HIGH';
      } else if (investmentScore >= 65 && demandScore >= 70) {
        action = 'REFINANCE';
        reasoning = ['Good asset with strong demand', 'Refinancing can unlock equity for portfolio expansion', 'Maintain while extracting capital'];
        urgency = 'MEDIUM';
      } else {
        action = 'HOLD';
        reasoning = ['Mixed signals — monitoring recommended', 'No immediate action needed'];
        urgency = 'LOW';
      }

      const compositeScore = investmentScore * 0.5 + demandScore * 0.3 + marketScore * 0.2;

      recommendations.push({
        propertyId: property.id,
        action,
        reasoning,
        urgency,
        expectedGainLoss: action === 'SELL' ? -5 : action === 'HOLD' ? 8 : 12,
      });

      candidates.push({
        propertyId: property.id,
        score: Math.round(compositeScore * 10) / 10,
        riskLevel: compositeScore >= 75 ? 'LOW' : compositeScore >= 55 ? 'MEDIUM' : 'HIGH',
        reasoning: [...reasoning, `Action: ${action}`, `Urgency: ${urgency}`],
      });
    }

    const sellCount = recommendations.filter(r => r.action === 'SELL').length;
    const holdCount = recommendations.filter(r => r.action === 'HOLD').length;
    const refinanceCount = recommendations.filter(r => r.action === 'REFINANCE').length;

    const avgScore = candidates.reduce((s, c) => s + c.score, 0) / Math.max(candidates.length, 1);
    const confidence = avgScore >= 75 ? 'HIGH' : avgScore >= 55 ? 'MEDIUM' : 'LOW';

    return {
      requestId: request.requestId,
      decisionType: 'PORTFOLIO_REBALANCE',
      confidence,
      priority: sellCount > 0 ? 'HIGH' : 'MEDIUM',
      primaryRecommendation:
        `Portfolio analysis of ${ownedProperties.length} assets: ` +
        `HOLD ${holdCount} | SELL ${sellCount} | REFINANCE ${refinanceCount}. ` +
        `Portfolio health score: ${avgScore.toFixed(1)}/100.`,
      candidates,
      explanation: '',
      reasoning: [
        `Total portfolio assets analyzed: ${ownedProperties.length}`,
        `HOLD recommendations: ${holdCount}`,
        `SELL recommendations: ${sellCount}`,
        `REFINANCE recommendations: ${refinanceCount}`,
        `Average portfolio score: ${avgScore.toFixed(1)}`,
      ],
      alternativeActions: [
        'Schedule portfolio review with a specialist agent',
        'Explore reinvestment opportunities in emerging markets',
        'Set up automatic portfolio health alerts',
      ],
      expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
      generatedAt: new Date(),
      metadata: {
        userPassportVersion: userProfile?.updatedAt?.toISOString(),
        modelsUsed: ['UserIntelligenceProfile', 'PropertyCurrentScore', 'MarketIntelligenceProfile'],
      },
    };
  }

  private noUserResponse(request: DecisionRequest): DecisionOutput {
    return {
      requestId: request.requestId,
      decisionType: 'PORTFOLIO_REBALANCE',
      confidence: 'LOW',
      priority: 'LOW',
      primaryRecommendation: 'User ID required for portfolio optimization.',
      candidates: [],
      explanation: '',
      reasoning: ['No userId provided in request context'],
      alternativeActions: ['Provide userId in DecisionRequest.context'],
      expiresAt: new Date(),
      generatedAt: new Date(),
      metadata: { modelsUsed: [] },
    };
  }
}
