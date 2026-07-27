/**
 * Property Intelligence Saga
 * Phase 5 Integration — Coordinates the full intelligence pipeline
 *
 * Flow:
 *   property.created.v1
 *       ↓
 *   property.intelligence.created.v1     (PropertyIntelligenceAgent)
 *       ↓
 *   property.score.calculated.v1         (PropertyCurrentScore)
 *       ↓
 *   property.digital.twin.generated.v1   (PropertyDigitalTwin)
 *       ↓
 *   content.brief.generated.v1           (ContentIntelligenceAgent)
 *       ↓
 *   seo.page.published.v1                (SEOPageGenerator)
 *       ↓
 *   content.published.v1                 (MultiChannelPublisher)
 *       ↓
 *   COMPLETE
 *
 * Compensation chain (reverse order):
 *   unpublish_channels → remove_seo → discard_brief → delete_twin → reset_score
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage, DomainEvents } from '../events/domain-events';
import { eventBus } from '../events/event-bus';

// ─── Intelligence-layer event names ───────────────────────────────────────────
// These extend DomainEvents; declared as string literals for forward-compat.
const IE = {
  PROPERTY_INTELLIGENCE_CREATED:   DomainEvents.PROPERTY_INTELLIGENCE_CREATED,
  PROPERTY_SCORE_CALCULATED:       DomainEvents.PROPERTY_SCORE_CALCULATED,
  PROPERTY_DIGITAL_TWIN_GENERATED: DomainEvents.PROPERTY_DIGITAL_TWIN_GENERATED,
  PROPERTY_MARKETING_STRATEGY_GENERATED: DomainEvents.PROPERTY_MARKETING_STRATEGY_GENERATED,
  CONTENT_BRIEF_GENERATED:  'content.brief.generated.v1',
  SEO_PAGE_PUBLISHED:       'seo.page.published.v1',
  CONTENT_PUBLISHED:        'content.published.v1',
  INTELLIGENCE_SAGA_FAILED: 'intelligence.saga.failed.v1',
} as const;

// ─── Saga ─────────────────────────────────────────────────────────────────────

export class PropertyIntelligenceSaga extends BaseSaga {
  public propertyId: string;
  public orgId: string;

  constructor(
    propertyId: string,
    orgId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'PROPERTY_CREATED', propertyId, orgId }, localization);
    this.propertyId = propertyId;
    this.orgId = orgId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[PropertyIntelligenceSaga] Compensating property ${this.propertyId}`);
    await super.compensate();
  }

  // ── Step 1: Property created → trigger intelligence analysis ────────────────
  public async onPropertyCreated() {
    console.log(`[PropertyIntelligenceSaga] Property ${this.propertyId} created. Starting intelligence analysis…`);
    await this.transition({ step: 'INTELLIGENCE_ANALYZING' });

    this.registerCompensation('reset_intelligence', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: resetting intelligence for ${this.propertyId}`);
    });

    // PropertyIntelligenceAgent picks up PROPERTY_CREATED and emits PROPERTY_INTELLIGENCE_CREATED
    // No action needed here — the agent is independently subscribed.
  }

  // ── Step 2: Intelligence analyzed → score calculated next ───────────────────
  public async onIntelligenceCreated(msg: EventMessage) {
    console.log(`[PropertyIntelligenceSaga] Intelligence created for ${this.propertyId}. Awaiting score…`);
    await this.transition({ step: 'SCORING', intelligenceId: msg.payload.intelligenceId });

    this.registerCompensation('delete_intelligence_profile', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: deleting intelligence profile for ${this.propertyId}`);
    });
  }

  // ── Step 3: Score calculated → digital twin generation next ─────────────────
  public async onScoreCalculated(msg: EventMessage) {
    const { overallScore, investmentScore } = msg.payload;
    console.log(`[PropertyIntelligenceSaga] Score calculated for ${this.propertyId}: overall=${overallScore} investment=${investmentScore}`);
    await this.transition({ step: 'DIGITAL_TWIN_GENERATING', overallScore, investmentScore });

    this.registerCompensation('reset_score', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: resetting score for ${this.propertyId}`);
    });
  }

  // ── Step 4: Digital twin generated → content brief generation ───────────────
  public async onDigitalTwinGenerated(msg: EventMessage) {
    console.log(`[PropertyIntelligenceSaga] Digital twin generated for ${this.propertyId}. Publishing intelligence event for content…`);
    await this.transition({ step: 'CONTENT_BRIEFING' });

    this.registerCompensation('delete_digital_twin', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: deleting digital twin for ${this.propertyId}`);
    });

    // Emit downstream to ContentIntelligenceAgent
    await eventBus.publish(
      IE.PROPERTY_DIGITAL_TWIN_GENERATED,
      {
        propertyId: this.propertyId,
        orgId: this.orgId,
        twinId: msg.payload.twinId,
        localization: this.localization,
      },
      'PropertyIntelligenceSaga',
      this.sagaId
    );
  }

  // ── Step 5: Content brief generated → SEO page publication ──────────────────
  public async onContentBriefGenerated(msg: EventMessage) {
    console.log(`[PropertyIntelligenceSaga] Content brief generated for ${this.propertyId}. Awaiting SEO publish…`);
    await this.transition({ step: 'SEO_PUBLISHING', contentBriefId: msg.payload.contentBriefId });

    this.registerCompensation('discard_content_brief', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: discarding content brief for ${this.propertyId}`);
    });
  }

  // ── Step 6: SEO page published → multi-channel distribution ─────────────────
  public async onSeoPagePublished(msg: EventMessage) {
    console.log(`[PropertyIntelligenceSaga] SEO page published for ${this.propertyId}. Awaiting multi-channel…`);
    await this.transition({ step: 'MULTI_CHANNEL_PUBLISHING', seoPageUrl: msg.payload.pageUrl });

    this.registerCompensation('unpublish_seo_page', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: unpublishing SEO page for ${this.propertyId}`);
    });
  }

  // ── Step 7: Multi-channel published → SAGA COMPLETE ─────────────────────────
  public async onContentPublished(msg: EventMessage) {
    const channels: string[] = msg.payload.channels ?? [];
    console.log(`[PropertyIntelligenceSaga] ✅ Property ${this.propertyId} published to ${channels.length} channel(s): ${channels.join(', ')}. SAGA COMPLETE.`);
    await this.transition({ step: 'COMPLETE', publishedChannels: channels });

    this.registerCompensation('unpublish_channels', async () => {
      console.log(`[PropertyIntelligenceSaga] Compensation: unpublishing channels for ${this.propertyId}`);
    });

    await eventBus.publish(
      'property.intelligence.pipeline.completed.v1',
      {
        propertyId: this.propertyId,
        orgId: this.orgId,
        channels,
        completedAt: new Date().toISOString(),
        sagaId: this.sagaId,
        localization: this.localization,
      },
      'PropertyIntelligenceSaga',
      this.sagaId
    );

    await this.complete();
  }

  // ── Error handling ───────────────────────────────────────────────────────────
  public async onFailed(reason: string) {
    console.error(`[PropertyIntelligenceSaga] ❌ Property ${this.propertyId} intelligence pipeline FAILED: ${reason}`);
    await this.fail(reason);
  }
}

// ─── Active Saga Registry ─────────────────────────────────────────────────────
const activeSagas = new Map<string, PropertyIntelligenceSaga>();

// ─── Listener Registration ────────────────────────────────────────────────────
export function registerPropertyIntelligenceListeners() {
  // Step 1 — Property created, kick off saga
  eventBus.subscribe(DomainEvents.PROPERTY_CREATED, (msg) => {
    const { propertyId, orgId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US', language: 'en', currency: 'USD', timezone: 'America/New_York'
    };

    const saga = new PropertyIntelligenceSaga(propertyId, orgId, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onPropertyCreated();
    console.log(`[PropertyIntelligenceSaga] 🚀 Started for property ${propertyId}`);
  });

  // Step 2 — Intelligence profile ready
  eventBus.subscribe(IE.PROPERTY_INTELLIGENCE_CREATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onIntelligenceCreated(msg);
  });

  // Step 3 — Scores computed
  eventBus.subscribe(IE.PROPERTY_SCORE_CALCULATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onScoreCalculated(msg);
  });

  // Step 4 — Digital twin ready
  eventBus.subscribe(IE.PROPERTY_DIGITAL_TWIN_GENERATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDigitalTwinGenerated(msg);
  });

  // Step 5 — Content brief generated (by ContentIntelligenceAgent)
  eventBus.subscribe(IE.CONTENT_BRIEF_GENERATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onContentBriefGenerated(msg);
  });

  // Step 6 — SEO page live (by SEOPageGenerator)
  eventBus.subscribe(IE.SEO_PAGE_PUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onSeoPagePublished(msg);
  });

  // Step 7 — All channels published (by MultiChannelPublisher)
  eventBus.subscribe(IE.CONTENT_PUBLISHED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onContentPublished(msg);
  });

  // Error
  eventBus.subscribe(IE.INTELLIGENCE_SAGA_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onFailed(msg.payload.reason || 'Unknown error');
  });

  console.log('[PropertyIntelligenceSaga] ✅ Listeners registered (7 steps)');
}

// ─── Export active sagas map (for recovery) ───────────────────────────────────
export { activeSagas as propertyIntelligenceActiveSagas };
