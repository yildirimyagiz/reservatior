/**
 * Saga: Listing Management
 * 
 * Flow:
 *   listing.imported
 *       |
 *   [Data enrichment & validation]
 *       |
 *   listing.published
 *       |
 *   [Marketing activation]
 *       |
 *   listing.viewed
 *       |
 *   listing.inquiry
 *       |
 *   [Lead generation]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class ListingManagementSaga extends BaseSaga {
  public listingId: string;
  public propertyId: string;
  public agentId: string;
  public listingCount: number;

  constructor(
    listingId: string, 
    propertyId: string, 
    agentId: string, 
    listingCount: number,
    sagaId?: string, 
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'LISTING_IMPORTED', listingId, propertyId, agentId, listingCount }, localization);
    this.listingId = listingId;
    this.propertyId = propertyId;
    this.agentId = agentId;
    this.listingCount = listingCount;
  }

  protected async compensate(): Promise<void> {
    console.log(`[ListingManagementSaga] Compensating listing ${this.listingId}. Unpublishing and cleaning up...`);
  }

  public async onImported() {
    console.log(`[ListingManagementSaga] Listing ${this.listingId} imported. Enriching data...`);
    await this.transition({ step: 'ENRICHING_DATA' });

    // Simulate data enrichment, SEO optimization, image processing
    setTimeout(() => {
      eventBus.publish(DomainEvents.LISTING_UPDATED, {
        listingId: this.listingId,
        propertyId: this.propertyId,
        agentId: this.agentId,
        enrichmentStatus: 'completed',
        localization: this.localization
      }, 'ListingOS', this.sagaId);
    }, 1500);
  }

  public async onUpdated(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Listing ${this.listingId} enriched. Publishing...`);
    await this.transition({ step: 'PUBLISHING' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.LISTING_PUBLISHED, {
        listingId: this.listingId,
        propertyId: this.propertyId,
        agentId: this.agentId,
        publishedAt: new Date().toISOString(),
        localization: this.localization
      }, 'ListingOS', this.sagaId);
    }, 1000);
  }

  public async onPublished(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Listing ${this.listingId} published. Activating marketing...`);
    await this.transition({ step: 'ACTIVATING_MARKETING' });

    // Request AI OS to generate marketing content
    setTimeout(() => {
      eventBus.publish(DomainEvents.AD_GENERATED, {
        listingId: this.listingId,
        propertyId: this.propertyId,
        agentId: this.agentId,
        ads: 5,
        platforms: ['instagram', 'facebook', 'google'],
        localization: this.localization
      }, 'AI-OS', this.sagaId);
    }, 1200);
  }

  public async onViewed(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Listing ${this.listingId} viewed. Tracking engagement...`);
    await this.transition({ step: 'TRACKING_ENGAGEMENT' });
    // Saga continues to track engagement metrics
  }

  public async onInquiry(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Inquiry received for listing ${this.listingId}. Generating lead...`);
    await this.transition({ step: 'GENERATING_LEAD' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.LEAD_CREATED, {
        listingId: this.listingId,
        propertyId: this.propertyId,
        agentId: this.agentId,
        inquiryDetails: msg.payload,
        leadScore: 0.75,
        localization: this.localization
      }, 'CRMOS', this.sagaId);
    }, 500);
  }

  public async onLeadCreated(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Lead generated for listing ${this.listingId}. LISTING SAGA COMPLETE.`);
    await this.complete();
  }

  public async onUnpublished(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Listing ${this.listingId} unpublished. SAGA FAILED.`);
    await this.fail('Listing was unpublished');
  }

  public async onExpired(msg: EventMessage) {
    console.log(`[ListingManagementSaga] Listing ${this.listingId} expired. SAGA FAILED.`);
    await this.fail('Listing expired');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, ListingManagementSaga>();

export function registerListingManagementListeners() {
  eventBus.subscribe(DomainEvents.LISTING_IMPORTED, (msg) => {
    const { listingId, propertyId, agentId, count } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new ListingManagementSaga(listingId, propertyId, agentId, count, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onImported();
    console.log(`[ListingManagementSaga] ✅ Started for Listing ${listingId}`);
  });

  eventBus.subscribe(DomainEvents.LISTING_UPDATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onUpdated(msg);
  });

  eventBus.subscribe(DomainEvents.LISTING_PUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onPublished(msg);
  });

  eventBus.subscribe(DomainEvents.LISTING_VIEWED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onViewed(msg);
  });

  eventBus.subscribe(DomainEvents.LISTING_INQUIRY, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onInquiry(msg);
  });

  eventBus.subscribe(DomainEvents.LEAD_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onLeadCreated(msg);
  });

  eventBus.subscribe(DomainEvents.LISTING_UNPUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onUnpublished(msg);
  });

  eventBus.subscribe(DomainEvents.LISTING_EXPIRED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onExpired(msg);
  });
}
