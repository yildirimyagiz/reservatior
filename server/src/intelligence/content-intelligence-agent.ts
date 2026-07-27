/**
 * Content Intelligence Agent
 * Phase 6 — Autonomous Publishing Engine
 *
 * Zincir:
 *   Intelligence Event (property.digital.twin.generated.v1)
 *     ↓
 *   Content Intelligence Agent  ← this file
 *     ↓
 *   SEO Page Generator
 *     ↓
 *   Multi Channel Publisher
 *
 * Consumes intelligence events and generates platform-specific content briefs
 * that feed the SEO generator and multi-channel publisher.
 */

import { PrismaClient } from '@prisma/client';
import { DomainEvents } from '../core/events/domain-events';
import { IdempotentEventConsumer } from '@/core/events/idempotent-event-consumer';

const prisma = new PrismaClient();

// ─── Content Types ────────────────────────────────────────────────────────────

export type ContentFormat =
  | 'SEO_PROPERTY_PAGE'
  | 'NEIGHBORHOOD_GUIDE'
  | 'INVESTMENT_BRIEF'
  | 'SOCIAL_CAPTION'
  | 'EMAIL_ALERT'
  | 'WHATSAPP_CARD'
  | 'INVESTOR_REPORT';

export interface ContentBrief {
  propertyId: string;
  format: ContentFormat;
  language: string;
  countryIsoCode: string;
  targetAudience: string;
  headline: string;
  subheadline: string;
  keyPoints: string[];
  callToAction: string;
  metadata: Record<string, any>;
  generatedAt: Date;
}

export interface PublishingJob {
  jobId: string;
  propertyId: string;
  briefs: ContentBrief[];
  channels: string[];
  scheduledAt: Date;
  status: 'PENDING' | 'PROCESSING' | 'PUBLISHED' | 'FAILED';
}

// ─── Content Intelligence Agent ───────────────────────────────────────────────

export class ContentIntelligenceAgent {
  constructor() {
    // Event handlers will be registered separately via registerContentIntelligenceEventHandlers
  }

  /**
   * Triggered when a Property Digital Twin is created/updated
   * → Generates full content suite for this property
   */
  async onDigitalTwinGenerated(payload: { propertyId: string; countryIsoCode?: string }): Promise<PublishingJob> {
    console.log(`[ContentIntelligenceAgent] Digital twin event for property ${payload.propertyId}`);

    const property = await prisma.property.findUnique({
      where: { id: payload.propertyId },
      include: { location: true },
    });

    if (!property) {
      throw new Error(`Property not found: ${payload.propertyId}`);
    }

    const intelligenceProfile = await (prisma as any).propertyIntelligenceProfile
      ?.findUnique({ where: { propertyId: payload.propertyId } })
      .catch(() => null);

    const currentScore = await (prisma as any).propertyCurrentScore
      ?.findUnique({ where: { propertyId: payload.propertyId } })
      .catch(() => null);

    const countryIsoCode = property.countryIsoCode ?? payload.countryIsoCode ?? 'TR';

    // Generate content briefs for all formats
    const briefs: ContentBrief[] = await this.generateAllBriefs(property, intelligenceProfile, currentScore, countryIsoCode);

    const job: PublishingJob = {
      jobId: `job_${payload.propertyId}_${Date.now()}`,
      propertyId: payload.propertyId,
      briefs,
      channels: ['GOOGLE_SEO', 'PORTAL_LISTING', 'SOCIAL_MEDIA', 'EMAIL'],
      scheduledAt: new Date(),
      status: 'PENDING',
    };

    console.log(`[ContentIntelligenceAgent] Generated ${briefs.length} content briefs for property ${payload.propertyId}`);
    return job;
  }

  /**
   * Triggered when market intelligence updates → Neighborhood guide refresh
   */
  async onMarketIntelligenceGenerated(payload: { locationId: string; citySlug?: string; countryIsoCode?: string }): Promise<void> {
    console.log(`[ContentIntelligenceAgent] Market intelligence event for location ${payload.locationId}`);
    // In production, this would trigger neighborhood guide refresh
  }

  /**
   * Triggered when property score changes significantly → Update existing content
   */
  async onPropertyScoreUpdated(payload: { propertyId: string; previousScore?: number; newScore?: number }): Promise<void> {
    const scoreDelta = Math.abs((payload.newScore ?? 0) - (payload.previousScore ?? 0));
    if (scoreDelta < 5) return; // Only republish on meaningful score change

    console.log(`[ContentIntelligenceAgent] Score delta ${scoreDelta} for property ${payload.propertyId} — triggering content refresh`);
    // In production, this would trigger content refresh
  }

  /**
   * Generate content briefs for all relevant formats
   */
  private async generateAllBriefs(
    property: any,
    intelligenceProfile: any,
    currentScore: any,
    countryIsoCode: string
  ): Promise<ContentBrief[]> {
    const briefs: ContentBrief[] = [];

    const investmentScore = currentScore?.investmentScore ?? 65;
    const rentalScore = currentScore?.rentalScore ?? 65;
    const demandScore = currentScore?.demandScore ?? 65;

    const city = property.location?.cityName ?? property.location?.citySlug ?? 'City';
    const district = property.location?.districtName ?? property.location?.districtSlug ?? '';
    const type = property.type ?? 'Property';
    const price = property.price ? `${property.price.toLocaleString()} ${property.currency ?? ''}` : 'Competitive Price';
    const isHighInvestment = investmentScore >= 80;
    const isHighRental = rentalScore >= 75;

    // SEO Property Page
    briefs.push({
      propertyId: property.id,
      format: 'SEO_PROPERTY_PAGE',
      language: 'en',
      countryIsoCode,
      targetAudience: isHighInvestment ? 'Investors' : 'End-User Buyers',
      headline: isHighInvestment
        ? `${city} ${type} – High-Yield Investment Opportunity | Investment Score ${investmentScore.toFixed(0)}/100`
        : `${city} ${district} ${type} for Sale | ${price}`,
      subheadline: isHighRental
        ? `Earn up to ${(rentalScore / 100 * 9).toFixed(1)}% annual rental yield in ${city}'s most sought-after district`
        : `Premium residential listing in ${city} ${district}`,
      keyPoints: [
        `Investment Score: ${investmentScore.toFixed(0)}/100`,
        `Rental Yield Score: ${rentalScore.toFixed(0)}/100`,
        `Market Demand: ${demandScore.toFixed(0)}/100`,
        `Price: ${price}`,
        `Location: ${district}, ${city}`,
      ],
      callToAction: isHighInvestment ? 'Request Investment Report' : 'Schedule Private Viewing',
      metadata: { seoSlug: `${city}-${type}-${property.id}`.toLowerCase().replace(/\s+/g, '-'), schemaType: 'Product' },
      generatedAt: new Date(),
    });

    // Neighborhood Guide
    briefs.push({
      propertyId: property.id,
      format: 'NEIGHBORHOOD_GUIDE',
      language: 'en',
      countryIsoCode,
      targetAudience: 'Research-Phase Buyers',
      headline: `${district} ${city}: Complete Neighborhood Guide 2026`,
      subheadline: `Market data, lifestyle insights, and investment outlook for ${district}`,
      keyPoints: [
        `Active demand score: ${demandScore.toFixed(0)}/100`,
        `Top property types in the area`,
        `Investment trend analysis`,
        `Lifestyle & amenity overview`,
      ],
      callToAction: 'Explore Available Properties',
      metadata: { locationFocus: district, contentType: 'guide' },
      generatedAt: new Date(),
    });

    // Social caption (short-form)
    briefs.push({
      propertyId: property.id,
      format: 'SOCIAL_CAPTION',
      language: 'en',
      countryIsoCode,
      targetAudience: 'Social Media Browsers',
      headline: `🏠 ${isHighInvestment ? '📈 High-Yield' : 'Premium'} ${type} in ${city}`,
      subheadline: `Investment Score: ${investmentScore.toFixed(0)}/100 | ${isHighRental ? `${(rentalScore / 100 * 9).toFixed(1)}% yield` : 'Lifestyle living'}`,
      keyPoints: [
        `📍 ${district}, ${city}`,
        `💰 ${price}`,
        `⭐ Score: ${investmentScore.toFixed(0)}/100`,
      ],
      callToAction: 'See full listing — link in bio',
      metadata: { platform: 'INSTAGRAM,TIKTOK,LINKEDIN', maxLength: 280 },
      generatedAt: new Date(),
    });

    // Email alert
    briefs.push({
      propertyId: property.id,
      format: 'EMAIL_ALERT',
      language: 'en',
      countryIsoCode,
      targetAudience: 'Registered Investors & Buyers',
      headline: `New ${isHighInvestment ? 'Investment Opportunity' : 'Listing'}: ${type} in ${city}`,
      subheadline: `Matched to your profile | Score: ${investmentScore.toFixed(0)}/100`,
      keyPoints: [
        `Property type: ${type}`,
        `Location: ${district}, ${city}`,
        `Price: ${price}`,
        `Investment score: ${investmentScore.toFixed(0)}/100`,
      ],
      callToAction: 'View Full Property Report',
      metadata: { emailType: 'PROPERTY_ALERT', urgency: investmentScore >= 85 ? 'HIGH' : 'NORMAL' },
      generatedAt: new Date(),
    });

    // Investment brief (for high-score properties only)
    if (isHighInvestment) {
      briefs.push({
        propertyId: property.id,
        format: 'INVESTMENT_BRIEF',
        language: 'en',
        countryIsoCode,
        targetAudience: 'Foreign Investors & HNW Individuals',
        headline: `${city} Investment Brief: ${type} — Score ${investmentScore.toFixed(0)}/100`,
        subheadline: `Comprehensive yield analysis, market positioning, and 5-year outlook`,
        keyPoints: [
          `Investment Score: ${investmentScore.toFixed(0)}/100`,
          `Rental Yield Estimate: ${(rentalScore / 100 * 9).toFixed(1)}% p.a.`,
          `Market Demand Index: ${demandScore.toFixed(0)}/100`,
          `5-Year Capital Appreciation: ${(investmentScore / 100 * 35).toFixed(0)}% est.`,
          `Risk Profile: ${investmentScore >= 80 ? 'LOW' : 'MEDIUM'}`,
        ],
        callToAction: 'Download Full Investment Report (PDF)',
        metadata: { format: 'PDF', pages: 4, includedSections: ['MarketAnalysis', 'YieldModel', 'RiskAssessment', 'AgentContact'] },
        generatedAt: new Date(),
      });
    }

    return briefs;
  }
}

export const contentIntelligenceAgent = new ContentIntelligenceAgent();
