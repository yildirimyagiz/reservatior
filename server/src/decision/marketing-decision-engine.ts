/**
 * Marketing Decision Engine
 * Phase 5 — Autonomous Marketing Strategy
 *
 * Input:  Property Passport + User Intelligence + Market Context
 * Output: Channel strategy, content direction, audience targeting
 */

import { PrismaClient } from '@prisma/client';
import { DecisionRequest, DecisionOutput } from './decision-engine';

const prisma = new PrismaClient();

export type MarketingChannel = 'GOOGLE_SEO' | 'SOCIAL_MEDIA' | 'EMAIL' | 'WHATSAPP' | 'INVESTOR_NETWORK' | 'PORTAL_LISTING';

export interface MarketingChannelStrategy {
  channel: MarketingChannel;
  priority: 'PRIMARY' | 'SECONDARY' | 'OPTIONAL';
  expectedReach: number;
  audienceSegment: string;
  contentType: string;
  budgetAllocation: number; // 0-100 %
}

export interface MarketingDecisionOutput {
  targetAudience: string;
  primaryMessage: string;
  channels: MarketingChannelStrategy[];
  contentBriefs: string[];
  estimatedLeadVolume: number;
  estimatedConversionRate: number;
}

export class MarketingDecisionEngine {
  async decide(request: DecisionRequest): Promise<DecisionOutput> {
    const { propertyId } = request.context;

    if (!propertyId) {
      return this.emptyResponse(request);
    }

    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: { location: true },
    });

    if (!property) return this.emptyResponse(request);

    const intelligenceProfile = await (prisma as any).propertyIntelligenceProfile
      ?.findUnique({ where: { propertyId } })
      .catch(() => null);

    const currentScore = await (prisma as any).propertyCurrentScore
      ?.findUnique({ where: { propertyId } })
      .catch(() => null);

    const marketProfile = property.location?.id
      ? await (prisma as any).marketIntelligenceProfile?.findFirst({
          where: { locationId: property.location.id },
          orderBy: { updatedAt: 'desc' },
        }).catch(() => null)
      : null;

    const investmentScore = currentScore?.investmentScore ?? 65;
    const rentalScore = currentScore?.rentalScore ?? 65;
    const demandScore = currentScore?.demandScore ?? 65;
    const foreignInterest = marketProfile?.foreignInvestorInterest ?? 40;

    // Determine primary audience
    const targetAudience = this.deriveAudience(investmentScore, rentalScore, foreignInterest);

    // Determine channels
    const channels = this.buildChannelStrategy(demandScore, foreignInterest, investmentScore);

    // Content briefs
    const contentBriefs = this.buildContentBriefs(property, investmentScore, rentalScore, targetAudience);

    const estimatedLeadVolume = Math.round((demandScore / 100) * 15 + (channels.length * 2));
    const estimatedConversionRate = Math.round((investmentScore / 100) * 8 * 10) / 10;

    const confidence = demandScore >= 80 ? 'HIGH' : demandScore >= 60 ? 'MEDIUM' : 'LOW';

    return {
      requestId: request.requestId,
      decisionType: 'OPPORTUNITY_ALERT',
      confidence,
      priority: demandScore >= 75 ? 'HIGH' : 'MEDIUM',
      primaryRecommendation:
        `Launch ${channels.filter(c => c.priority === 'PRIMARY').map(c => c.channel).join(', ')} campaign ` +
        `targeting ${targetAudience}. Est. ${estimatedLeadVolume} leads/month at ${estimatedConversionRate}% conversion.`,
      candidates: [],
      explanation: '',
      reasoning: [
        `Investment score: ${investmentScore.toFixed(1)}`,
        `Rental score: ${rentalScore.toFixed(1)}`,
        `Demand score: ${demandScore.toFixed(1)}`,
        `Foreign investor interest: ${foreignInterest.toFixed(1)}`,
        `Target audience: ${targetAudience}`,
      ],
      alternativeActions: [
        'Generate AI listing copy from property passport',
        'Schedule social media content batch',
        'Create investor-focused PDF report',
      ],
      expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
      generatedAt: new Date(),
      metadata: {
        modelsUsed: ['PropertyIntelligenceProfile', 'PropertyCurrentScore', 'MarketIntelligenceProfile'],
      },
    };
  }

  private deriveAudience(investmentScore: number, rentalScore: number, foreignInterest: number): string {
    if (foreignInterest >= 70 && investmentScore >= 75) return 'Foreign Investors';
    if (investmentScore >= 75) return 'Buy-to-Invest Buyers';
    if (rentalScore >= 75) return 'Buy-to-Rent Landlords';
    return 'End-User Buyers';
  }

  private buildChannelStrategy(demandScore: number, foreignInterest: number, investmentScore: number): MarketingChannelStrategy[] {
    const channels: MarketingChannelStrategy[] = [];

    // SEO always primary
    channels.push({
      channel: 'GOOGLE_SEO',
      priority: 'PRIMARY',
      expectedReach: Math.round(demandScore * 120),
      audienceSegment: 'Organic search buyers',
      contentType: 'SEO Property Page + Neighborhood Guide',
      budgetAllocation: 30,
    });

    // Portal listing
    channels.push({
      channel: 'PORTAL_LISTING',
      priority: 'PRIMARY',
      expectedReach: Math.round(demandScore * 80),
      audienceSegment: 'Active property searchers',
      contentType: 'Premium listing with virtual tour',
      budgetAllocation: 20,
    });

    // Social media
    channels.push({
      channel: 'SOCIAL_MEDIA',
      priority: demandScore >= 70 ? 'PRIMARY' : 'SECONDARY',
      expectedReach: Math.round(demandScore * 200),
      audienceSegment: 'Lifestyle buyers / aspirational investors',
      contentType: 'Video walkthrough + Lifestyle content',
      budgetAllocation: 25,
    });

    // Investor network if high investment score
    if (investmentScore >= 75 || foreignInterest >= 60) {
      channels.push({
        channel: 'INVESTOR_NETWORK',
        priority: 'PRIMARY',
        expectedReach: Math.round(foreignInterest * 10),
        audienceSegment: 'HNW foreign investors',
        contentType: 'Investment brief + Yield analysis PDF',
        budgetAllocation: 15,
      });
    }

    // Email & WhatsApp
    channels.push({
      channel: 'EMAIL',
      priority: 'SECONDARY',
      expectedReach: 500,
      audienceSegment: 'Registered platform users matching preferences',
      contentType: 'Personalized property alert email',
      budgetAllocation: 5,
    });

    channels.push({
      channel: 'WHATSAPP',
      priority: foreignInterest >= 60 ? 'SECONDARY' : 'OPTIONAL',
      expectedReach: 200,
      audienceSegment: 'Active lead list',
      contentType: 'WhatsApp property card with CTA',
      budgetAllocation: 5,
    });

    return channels;
  }

  private buildContentBriefs(property: any, investmentScore: number, rentalScore: number, audience: string): string[] {
    const city = property.location?.citySlug ?? 'the city';
    const type = property.type ?? 'property';
    const price = property.price ? `${property.price.toLocaleString()} ${property.currency ?? ''}` : 'competitive price';

    return [
      `SEO Title: "${city} ${type} – ${investmentScore >= 80 ? 'High-Yield Investment Opportunity' : 'Premium Residential Listing'}"`,
      `Hero Copy: Introduce ${city} market strength + property's unique value for ${audience}`,
      `Investment Brief: Expected rental yield ${(rentalScore / 100 * 9).toFixed(1)}%, 5-year appreciation outlook`,
      `CTA: "Request Investment Report" or "Schedule Private Viewing"`,
      `Video Script: 60-second property + neighborhood highlight for social distribution`,
    ];
  }

  private emptyResponse(request: DecisionRequest): DecisionOutput {
    return {
      requestId: request.requestId,
      decisionType: 'OPPORTUNITY_ALERT',
      confidence: 'LOW',
      priority: 'LOW',
      primaryRecommendation: 'No property specified for marketing strategy.',
      candidates: [],
      explanation: 'Provide a property ID to generate a marketing decision.',
      reasoning: [],
      alternativeActions: ['Provide a valid propertyId in the request context'],
      expiresAt: new Date(),
      generatedAt: new Date(),
      metadata: { modelsUsed: [] },
    };
  }
}
