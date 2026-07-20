/**
 * Saga: Listing Pipeline
 * 
 * Flow:
 *   listing.imported
 *       |
 *   [Enrich listing data, SEO text]
 *       |
 *   listing.published
 *       |
 *   ad.generated (→ AI OS generates reels/creatives)
 *       |
 *   ad.published
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class ListingPipelineSaga extends BaseSaga {
  public agentId: string;
  public listingCount: number;
  public listingIds: string[];

  constructor(agentId: string, listingCount: number, sagaId?: string, listingIds?: string[], localization?: LocalizationContext) {
    super(sagaId, { step: 'LISTINGS_IMPORTED', agentId, listingCount }, localization);
    this.agentId = agentId;
    this.listingCount = listingCount;
    this.listingIds = listingIds || ['lst_mock_1', 'lst_mock_2', 'lst_mock_3'].slice(0, listingCount);
  }

  protected async compensate(): Promise<void> {
    console.log(`[ListingPipelineSaga] Compensating. Removing unpublished listings for agent ${this.agentId}...`);
  }

  public async onImported() {
    console.log(`[ListingPipelineSaga] ${this.listingCount} listings imported for Agent ${this.agentId}. Enriching & publishing...`);
    await this.transition({ step: 'ENRICHING' });

    // Simulate enrichment, SEO text generation, etc.
    setTimeout(() => {
      eventBus.publish(DomainEvents.LISTING_PUBLISHED, { 
        agentId: this.agentId, 
        count: this.listingCount, 
        listingIds: this.listingIds,
        localization: this.localization 
      }, 'ListingOS', this.sagaId);
    }, 1200);
  }

  public async onPublished(msg: EventMessage) {
    console.log(`[ListingPipelineSaga] Listings published! Requesting AI Reel Generation...`);
    await this.transition({ step: 'REQUESTING_ADS' });

    // Request AI OS to generate ads for the new listings
    setTimeout(() => {
      eventBus.publish(DomainEvents.AD_GENERATED, { 
        agentId: this.agentId, 
        reels: 3, 
        platform: 'INSTAGRAM',
        localization: this.localization 
      }, 'AI-OS', this.sagaId);
    }, 1500);
  }

  public async onAdGenerated(msg: EventMessage) {
    console.log(`[ListingPipelineSaga] ${msg.payload.reels} reels generated. Publishing to ${msg.payload.platform}...`);
    await this.transition({ step: 'ADS_PUBLISHING' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.AD_PUBLISHED, { 
        agentId: this.agentId, 
        campaignId: 'cmp_abc123',
        localization: this.localization 
      }, 'AI-OS', this.sagaId);
    }, 500);
  }

  public async onAdPublished(msg: EventMessage) {
    console.log(`[ListingPipelineSaga] Campaign ${msg.payload.campaignId} is LIVE! Pipeline COMPLETE.`);
    await this.complete();
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, ListingPipelineSaga>();

export function registerListingPipelineListeners() {
  eventBus.subscribe(DomainEvents.LISTING_IMPORTED, (msg) => {
    const { agentId, count, listingIds } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new ListingPipelineSaga(agentId, count, msg.correlationId, listingIds, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onImported();
    console.log(`[ListingPipelineSaga] ✅ Started for ${count} listings from Agent ${agentId}`);
  });

  eventBus.subscribe(DomainEvents.LISTING_PUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onPublished(msg);
  });

  eventBus.subscribe(DomainEvents.AD_GENERATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAdGenerated(msg);
  });

  eventBus.subscribe(DomainEvents.AD_PUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onAdPublished(msg);
  });
}
