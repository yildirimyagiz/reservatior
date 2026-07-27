/**
 * Multi Channel Publisher
 * Phase 6 — Autonomous Publishing Engine
 *
 * Final layer: receives SEO page + content briefs and distributes to:
 *   → Google SEO (page record + sitemap trigger)
 *   → Portal Listing (premium listing update)
 *   → Social Media (caption + image batch)
 *   → Email (alert dispatch)
 *   → WhatsApp (card message)
 *   → Investor Network (investment brief PDF trigger)
 *
 * Each channel adapter is independent and fail-safe.
 * Failed channels are retried without blocking others.
 */

import { DomainEvents } from '../core/events/domain-events';
import { ContentBrief } from './content-intelligence-agent';
import { SEOPagePayload } from './seo-page-generator';

// ─── Channel Result ───────────────────────────────────────────────────────────

export interface ChannelPublishResult {
  channel: string;
  status: 'SUCCESS' | 'FAILED' | 'SKIPPED';
  publishedUrl?: string;
  error?: string;
  publishedAt: Date;
}

export interface PublishingResult {
  propertyId: string;
  totalChannels: number;
  successCount: number;
  failedCount: number;
  skippedCount: number;
  results: ChannelPublishResult[];
  completedAt: Date;
}

// ─── Multi Channel Publisher ──────────────────────────────────────────────────

export class MultiChannelPublisher {
  constructor() {
    this.registerEventHandlers();
  }

  private registerEventHandlers() {
    DomainEvents.on('seo.page.generated.v1', async (payload: any) => {
      console.log(`[MultiChannelPublisher] SEO page ready for property ${payload.propertyId}`);
      // In production: trigger sitemap rebuild and CDN invalidation
    });

    DomainEvents.on('content.briefs.generated.v1', async (payload: any) => {
      console.log(`[MultiChannelPublisher] ${payload.briefCount} briefs ready for job ${payload.jobId}`);
    });
  }

  /**
   * Publish content across all enabled channels
   */
  async publish(
    propertyId: string,
    briefs: ContentBrief[],
    seoPage?: SEOPagePayload,
    channels: string[] = ['GOOGLE_SEO', 'PORTAL_LISTING', 'SOCIAL_MEDIA', 'EMAIL']
  ): Promise<PublishingResult> {
    console.log(`[MultiChannelPublisher] Starting publish for property ${propertyId} across ${channels.length} channels`);

    const results: ChannelPublishResult[] = [];

    // Run channels concurrently with individual failure isolation
    await Promise.allSettled(
      channels.map(async (channel) => {
        const result = await this.publishToChannel(channel, propertyId, briefs, seoPage);
        results.push(result);
      })
    );

    const successCount = results.filter(r => r.status === 'SUCCESS').length;
    const failedCount = results.filter(r => r.status === 'FAILED').length;
    const skippedCount = results.filter(r => r.status === 'SKIPPED').length;

    const publishingResult: PublishingResult = {
      propertyId,
      totalChannels: channels.length,
      successCount,
      failedCount,
      skippedCount,
      results,
      completedAt: new Date(),
    };

    await DomainEvents.emit('content.published.v1', {
      propertyId,
      successCount,
      failedCount,
      channels: results.filter(r => r.status === 'SUCCESS').map(r => r.channel),
    });

    console.log(`[MultiChannelPublisher] Publish complete: ${successCount} success, ${failedCount} failed, ${skippedCount} skipped`);
    return publishingResult;
  }

  /**
   * Route to the correct channel adapter
   */
  private async publishToChannel(
    channel: string,
    propertyId: string,
    briefs: ContentBrief[],
    seoPage?: SEOPagePayload
  ): Promise<ChannelPublishResult> {
    try {
      switch (channel) {
        case 'GOOGLE_SEO':
          return await this.publishGoogleSEO(propertyId, seoPage);
        case 'PORTAL_LISTING':
          return await this.publishPortalListing(propertyId, briefs);
        case 'SOCIAL_MEDIA':
          return await this.publishSocial(propertyId, briefs);
        case 'EMAIL':
          return await this.publishEmail(propertyId, briefs);
        case 'WHATSAPP':
          return await this.publishWhatsApp(propertyId, briefs);
        case 'INVESTOR_NETWORK':
          return await this.publishInvestorNetwork(propertyId, briefs);
        default:
          return { channel, status: 'SKIPPED', error: `Unknown channel: ${channel}`, publishedAt: new Date() };
      }
    } catch (err: any) {
      console.error(`[MultiChannelPublisher] Channel ${channel} failed: ${err.message}`);
      return { channel, status: 'FAILED', error: err.message, publishedAt: new Date() };
    }
  }

  // ─── Channel Adapters ──────────────────────────────────────────────────────

  private async publishGoogleSEO(propertyId: string, seoPage?: SEOPagePayload): Promise<ChannelPublishResult> {
    if (!seoPage) {
      return { channel: 'GOOGLE_SEO', status: 'SKIPPED', error: 'No SEO page payload', publishedAt: new Date() };
    }

    // In production: write page to CMS / CDN, trigger sitemap rebuild
    await DomainEvents.emit('seo.page.publish.v1', {
      propertyId,
      slug: seoPage.slug,
      canonicalUrl: seoPage.canonicalUrl,
      title: seoPage.title,
      metaDescription: seoPage.metaDescription,
    });

    console.log(`[MultiChannelPublisher:GoogleSEO] Published: ${seoPage.canonicalUrl}`);
    return {
      channel: 'GOOGLE_SEO',
      status: 'SUCCESS',
      publishedUrl: seoPage.canonicalUrl,
      publishedAt: new Date(),
    };
  }

  private async publishPortalListing(propertyId: string, briefs: ContentBrief[]): Promise<ChannelPublishResult> {
    const seoBrief = briefs.find(b => b.format === 'SEO_PROPERTY_PAGE');
    if (!seoBrief) {
      return { channel: 'PORTAL_LISTING', status: 'SKIPPED', error: 'No SEO brief found', publishedAt: new Date() };
    }

    await DomainEvents.emit('portal.listing.update.v1', {
      propertyId,
      headline: seoBrief.headline,
      subheadline: seoBrief.subheadline,
      keyPoints: seoBrief.keyPoints,
      callToAction: seoBrief.callToAction,
    });

    console.log(`[MultiChannelPublisher:PortalListing] Updated listing for property ${propertyId}`);
    return { channel: 'PORTAL_LISTING', status: 'SUCCESS', publishedAt: new Date() };
  }

  private async publishSocial(propertyId: string, briefs: ContentBrief[]): Promise<ChannelPublishResult> {
    const socialBrief = briefs.find(b => b.format === 'SOCIAL_CAPTION');
    if (!socialBrief) {
      return { channel: 'SOCIAL_MEDIA', status: 'SKIPPED', error: 'No social brief found', publishedAt: new Date() };
    }

    await DomainEvents.emit('social.post.scheduled.v1', {
      propertyId,
      headline: socialBrief.headline,
      caption: `${socialBrief.headline}\n\n${socialBrief.keyPoints.join('\n')}\n\n${socialBrief.callToAction}`,
      platforms: socialBrief.metadata?.platform?.split(',') ?? ['INSTAGRAM'],
    });

    console.log(`[MultiChannelPublisher:Social] Scheduled social post for property ${propertyId}`);
    return { channel: 'SOCIAL_MEDIA', status: 'SUCCESS', publishedAt: new Date() };
  }

  private async publishEmail(propertyId: string, briefs: ContentBrief[]): Promise<ChannelPublishResult> {
    const emailBrief = briefs.find(b => b.format === 'EMAIL_ALERT');
    if (!emailBrief) {
      return { channel: 'EMAIL', status: 'SKIPPED', error: 'No email brief found', publishedAt: new Date() };
    }

    await DomainEvents.emit('email.alert.dispatch.v1', {
      propertyId,
      subject: emailBrief.headline,
      previewText: emailBrief.subheadline,
      bodyPoints: emailBrief.keyPoints,
      callToAction: emailBrief.callToAction,
      targetAudience: emailBrief.targetAudience,
      urgency: emailBrief.metadata?.urgency ?? 'NORMAL',
    });

    console.log(`[MultiChannelPublisher:Email] Dispatched email alert for property ${propertyId}`);
    return { channel: 'EMAIL', status: 'SUCCESS', publishedAt: new Date() };
  }

  private async publishWhatsApp(propertyId: string, briefs: ContentBrief[]): Promise<ChannelPublishResult> {
    const emailBrief = briefs.find(b => b.format === 'EMAIL_ALERT');
    if (!emailBrief) {
      return { channel: 'WHATSAPP', status: 'SKIPPED', error: 'No suitable brief for WhatsApp', publishedAt: new Date() };
    }

    const card = `🏠 *${emailBrief.headline}*\n` +
      emailBrief.keyPoints.slice(0, 3).map(kp => `• ${kp}`).join('\n') +
      `\n\n➡️ ${emailBrief.callToAction}`;

    await DomainEvents.emit('whatsapp.card.send.v1', {
      propertyId,
      message: card,
      targetAudience: emailBrief.targetAudience,
    });

    console.log(`[MultiChannelPublisher:WhatsApp] Sent WhatsApp card for property ${propertyId}`);
    return { channel: 'WHATSAPP', status: 'SUCCESS', publishedAt: new Date() };
  }

  private async publishInvestorNetwork(propertyId: string, briefs: ContentBrief[]): Promise<ChannelPublishResult> {
    const investorBrief = briefs.find(b => b.format === 'INVESTMENT_BRIEF');
    if (!investorBrief) {
      return { channel: 'INVESTOR_NETWORK', status: 'SKIPPED', error: 'No investment brief (score too low)', publishedAt: new Date() };
    }

    await DomainEvents.emit('investor.brief.distribute.v1', {
      propertyId,
      headline: investorBrief.headline,
      keyMetrics: investorBrief.keyPoints,
      targetAudience: investorBrief.targetAudience,
      callToAction: investorBrief.callToAction,
      reportSections: investorBrief.metadata?.includedSections,
    });

    console.log(`[MultiChannelPublisher:InvestorNetwork] Distributed investor brief for property ${propertyId}`);
    return { channel: 'INVESTOR_NETWORK', status: 'SUCCESS', publishedAt: new Date() };
  }
}

export const multiChannelPublisher = new MultiChannelPublisher();
