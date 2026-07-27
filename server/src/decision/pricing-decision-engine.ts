/**
 * Pricing Decision Engine
 * Phase 5 — Intelligent Pricing Recommendations
 */

import { PrismaClient } from '@prisma/client';
import { DecisionRequest, DecisionOutput, DecisionConfidence } from './decision-engine';

const prisma = new PrismaClient();

export interface PricingRecommendation {
  currentListingPrice: number;
  recommendedPrice: number;
  priceRangeLow: number;
  priceRangeHigh: number;
  expectedDaysOnMarket: number;
  expectedInquiryIncrease: number;
  demandLevel: 'VERY_HIGH' | 'HIGH' | 'MEDIUM' | 'LOW';
  priceAction: 'INCREASE' | 'DECREASE' | 'HOLD';
  currency: string;
  confidence: number;
  reasoning: string[];
}

export class PricingDecisionEngine {
  async decide(request: DecisionRequest): Promise<DecisionOutput> {
    const { propertyId } = request.context;

    if (!propertyId) {
      return this.noPropertyResponse(request);
    }

    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: { location: true },
    });

    if (!property) {
      return this.noPropertyResponse(request);
    }

    const recommendation = await this.computePricingRecommendation(property);

    const confidence: DecisionConfidence = recommendation.confidence >= 0.85
      ? 'VERY_HIGH'
      : recommendation.confidence >= 0.70
      ? 'HIGH'
      : recommendation.confidence >= 0.55
      ? 'MEDIUM'
      : 'LOW';

    return {
      requestId: request.requestId,
      decisionType: 'PRICE_ADJUST',
      confidence,
      priority: recommendation.priceAction !== 'HOLD' ? 'HIGH' : 'LOW',
      primaryRecommendation: this.buildRecommendationText(recommendation),
      candidates: [],
      explanation: '',
      reasoning: recommendation.reasoning,
      alternativeActions: this.buildAlternatives(recommendation),
      expiresAt: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000),
      generatedAt: new Date(),
      metadata: {
        modelsUsed: ['PropertyCurrentScore', 'MarketIntelligenceProfile'],
      },
    };
  }

  private async computePricingRecommendation(property: any): Promise<PricingRecommendation> {
    const currentScore = await (prisma as any).propertyCurrentScore
      ?.findUnique({ where: { propertyId: property.id } })
      .catch(() => null);

    const marketProfile = property.location?.id
      ? await (prisma as any).marketIntelligenceProfile?.findFirst({
          where: { locationId: property.location.id },
          orderBy: { updatedAt: 'desc' },
        }).catch(() => null)
      : null;

    const currentPrice = Number(property.listingPrice ?? property.originalPrice ?? 0);
    const demandScore: number = currentScore?.demandScore ?? 65;
    const marketScore: number = marketProfile?.overallScore ?? 65;
    const liquidityScore: number = marketProfile?.liquidityScore ?? 65;

    const marketPressure = (demandScore * 0.5 + marketScore * 0.3 + liquidityScore * 0.2) / 100;

    let priceAdjustmentFactor: number;
    if (marketPressure >= 0.80) {
      priceAdjustmentFactor = 1.03;
    } else if (marketPressure >= 0.65) {
      priceAdjustmentFactor = 1.00;
    } else if (marketPressure >= 0.50) {
      priceAdjustmentFactor = 0.97;
    } else {
      priceAdjustmentFactor = 0.94;
    }

    const recommendedPrice = Math.round(currentPrice * priceAdjustmentFactor);
    const priceRangeLow = Math.round(recommendedPrice * 0.96);
    const priceRangeHigh = Math.round(recommendedPrice * 1.04);

    const demandLevel: PricingRecommendation['demandLevel'] =
      demandScore >= 85 ? 'VERY_HIGH' :
      demandScore >= 70 ? 'HIGH' :
      demandScore >= 50 ? 'MEDIUM' : 'LOW';

    const priceAction: PricingRecommendation['priceAction'] =
      priceAdjustmentFactor > 1.01 ? 'INCREASE' :
      priceAdjustmentFactor < 0.99 ? 'DECREASE' : 'HOLD';

    return {
      currentListingPrice: currentPrice,
      recommendedPrice,
      priceRangeLow,
      priceRangeHigh,
      expectedDaysOnMarket: priceAction === 'DECREASE' ? 21 : priceAction === 'HOLD' ? 35 : 45,
      expectedInquiryIncrease: priceAction === 'DECREASE' ? 34 : priceAction === 'HOLD' ? 0 : -10,
      demandLevel,
      priceAction,
      currency: property.currency ?? 'USD',
      confidence: 0.55 + marketPressure * 0.35,
      reasoning: [
        `Current listing price: ${currentPrice.toLocaleString()} ${property.currency ?? ''}`,
        `Demand score: ${demandScore.toFixed(1)}/100 (${demandLevel})`,
        `Market score: ${marketScore.toFixed(1)}/100`,
        `Liquidity score: ${liquidityScore.toFixed(1)}/100`,
        `Market pressure index: ${(marketPressure * 100).toFixed(1)}`,
        `Price adjustment: ${((priceAdjustmentFactor - 1) * 100).toFixed(1)}%`,
      ],
    };
  }

  private buildRecommendationText(rec: PricingRecommendation): string {
    const priceChange = rec.recommendedPrice - rec.currentListingPrice;
    const pct = ((priceChange / Math.max(rec.currentListingPrice, 1)) * 100).toFixed(1);
    const sign = priceChange >= 0 ? '+' : '';
    return `${rec.priceAction}: Set price to ${rec.recommendedPrice.toLocaleString()} ${rec.currency} ` +
      `(${sign}${pct}% from current). Est. ${rec.expectedDaysOnMarket} days on market. Demand: ${rec.demandLevel}.`;
  }

  private buildAlternatives(rec: PricingRecommendation): string[] {
    if (rec.priceAction === 'DECREASE') {
      return ['Consider premium listing to justify current price', 'Stage property', 'Offer incentives'];
    } else if (rec.priceAction === 'INCREASE') {
      return ['Monitor market for 2 weeks first', 'Ensure media quality supports premium', 'Highlight unique features'];
    }
    return ['Refresh listing photos every 30 days', 'Run targeted ad campaign', 'Review again in 14 days'];
  }

  private noPropertyResponse(request: DecisionRequest): DecisionOutput {
    return {
      requestId: request.requestId,
      decisionType: 'PRICE_ADJUST',
      confidence: 'LOW',
      priority: 'LOW',
      primaryRecommendation: 'Property not found or ID not provided.',
      candidates: [],
      explanation: 'Cannot generate pricing recommendation without a valid property.',
      reasoning: ['No property ID provided'],
      alternativeActions: ['Provide a valid property ID'],
      expiresAt: new Date(),
      generatedAt: new Date(),
      metadata: { modelsUsed: [] },
    };
  }
}
