/**
 * Generic Intelligence Pipeline Saga
 * Replaces entity-specific sagas with one universal pipeline.
 *
 * Supports: Property | Market | User | Agent | Portfolio | Partner
 *
 * Flow:
 *   ENTITY_CREATED
 *     ↓ DATA_COLLECTING
 *     ↓ ANALYZING
 *     ↓ SCORING
 *     ↓ TWIN_GENERATING       (if applicable)
 *     ↓ DECISION_PROPOSING    (if applicable)
 *     ↓ CONTENT_GENERATING
 *     ↓ PUBLISHING
 *     ↓ FEEDBACK_AWAITING
 *     ↓ LEARNING_UPDATING
 *     ↓ COMPLETE
 *
 * Each entity type uses a strategy pattern for entity-specific logic.
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage, DomainEvents } from '../events/domain-events';
import { eventBus } from '../events/event-bus';

// ─── Entity Types ────────────────────────────────────────────────────────────

export type IntelligenceEntityType =
  | 'PROPERTY'
  | 'MARKET'
  | 'USER'
  | 'AGENT'
  | 'PORTFOLIO'
  | 'PARTNER';

// ─── Pipeline Steps ──────────────────────────────────────────────────────────

export type PipelineStep =
  | 'ENTITY_CREATED'
  | 'DATA_COLLECTING'
  | 'ANALYZING'
  | 'SCORING'
  | 'TWIN_GENERATING'
  | 'DECISION_PROPOSING'
  | 'CONTENT_GENERATING'
  | 'PUBLISHING'
  | 'FEEDBACK_AWAITING'
  | 'LEARNING_UPDATING'
  | 'COMPLETE';

// Steps that are optional per entity type
const OPTIONAL_STEPS: Partial<Record<IntelligenceEntityType, PipelineStep[]>> = {
  USER:      ['TWIN_GENERATING', 'PUBLISHING'],
  AGENT:     ['TWIN_GENERATING'],
  PARTNER:   ['TWIN_GENERATING', 'DECISION_PROPOSING'],
  MARKET:    ['DECISION_PROPOSING'],
};

// ─── Event Name Generator ────────────────────────────────────────────────────

function pipelineEvent(entityType: IntelligenceEntityType, step: PipelineStep): string {
  return `intelligence.${entityType.toLowerCase()}.${step.toLowerCase().replace(/_/g, '.')}.v1`;
}

// ─── Saga ────────────────────────────────────────────────────────────────────

export class IntelligencePipelineSaga extends BaseSaga {
  public entityType: IntelligenceEntityType;
  public entityId: string;
  public orgId: string;
  private skippedSteps: Set<PipelineStep>;

  constructor(
    entityType: IntelligenceEntityType,
    entityId: string,
    orgId: string,
    sagaId?: string,
    localization?: LocalizationContext,
    version: number = 1
  ) {
    super(
      sagaId,
      { step: 'ENTITY_CREATED', entityType, entityId, orgId },
      localization,
      version
    );
    this.entityType = entityType;
    this.entityId = entityId;
    this.orgId = orgId;
    this.lockKey = `intelligence:${entityType.toLowerCase()}:${entityId}`;
    this.skippedSteps = new Set(OPTIONAL_STEPS[entityType] || []);
  }

  protected async compensate(): Promise<void> {
    console.log(`[IntelligencePipeline] Compensating ${this.entityType} ${this.entityId}`);
    await super.compensate();
  }

  // ── Pipeline Steps ────────────────────────────────────────────────────────

  /** Step 1: Entity created → start collecting data */
  public async onEntityCreated() {
    console.log(`[IntelligencePipeline] ${this.entityType} ${this.entityId} created. Collecting data…`);
    await this.transition({ step: 'DATA_COLLECTING' });

    this.registerCompensation('reset_data', async () => {
      console.log(`[IntelligencePipeline] Compensation: resetting data for ${this.entityType} ${this.entityId}`);
    });

    await eventBus.publish(
      pipelineEvent(this.entityType, 'DATA_COLLECTING'),
      { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId, localization: this.localization },
      'IntelligencePipelineSaga',
      this.sagaId
    );
  }

  /** Step 2: Data collected → analyze */
  public async onDataCollected(msg: EventMessage) {
    console.log(`[IntelligencePipeline] Data collected for ${this.entityType} ${this.entityId}. Analyzing…`);
    await this.transition({ step: 'ANALYZING', dataId: msg.payload.dataId });

    this.registerCompensation('delete_collected_data', async () => {
      console.log(`[IntelligencePipeline] Compensation: deleting collected data for ${this.entityId}`);
    });

    await eventBus.publish(
      pipelineEvent(this.entityType, 'ANALYZING'),
      { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId, data: msg.payload },
      'IntelligencePipelineSaga',
      this.sagaId
    );
  }

  /** Step 3: Analyzed → score */
  public async onAnalyzed(msg: EventMessage) {
    console.log(`[IntelligencePipeline] ${this.entityType} ${this.entityId} analyzed. Scoring…`);
    await this.transition({ step: 'SCORING', analysisResult: msg.payload });

    this.registerCompensation('delete_analysis', async () => {
      console.log(`[IntelligencePipeline] Compensation: deleting analysis for ${this.entityId}`);
    });

    await eventBus.publish(
      pipelineEvent(this.entityType, 'SCORING'),
      { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId },
      'IntelligencePipelineSaga',
      this.sagaId
    );
  }

  /** Step 4: Scored → twin generation (or skip) */
  public async onScored(msg: EventMessage) {
    const { overallScore } = msg.payload;
    console.log(`[IntelligencePipeline] ${this.entityType} ${this.entityId} scored: ${overallScore}`);
    await this.transition({ step: 'SCORING_COMPLETE', overallScore });

    this.registerCompensation('reset_score', async () => {
      console.log(`[IntelligencePipeline] Compensation: resetting score for ${this.entityId}`);
    });

    if (this.skippedSteps.has('TWIN_GENERATING')) {
      await this.skipToNextAfter('TWIN_GENERATING', msg);
    } else {
      await this.transition({ step: 'TWIN_GENERATING' });
      await eventBus.publish(
        pipelineEvent(this.entityType, 'TWIN_GENERATING'),
        { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId, score: overallScore },
        'IntelligencePipelineSaga',
        this.sagaId
      );
    }
  }

  /** Step 5: Twin generated → decision proposal (or skip) */
  public async onTwinGenerated(msg: EventMessage) {
    console.log(`[IntelligencePipeline] Digital twin generated for ${this.entityType} ${this.entityId}`);
    await this.transition({ step: 'TWIN_COMPLETE', twinId: msg.payload.twinId });

    this.registerCompensation('delete_twin', async () => {
      console.log(`[IntelligencePipeline] Compensation: deleting twin for ${this.entityId}`);
    });

    if (this.skippedSteps.has('DECISION_PROPOSING')) {
      await this.skipToNextAfter('DECISION_PROPOSING', msg);
    } else {
      await this.transition({ step: 'DECISION_PROPOSING' });
      await eventBus.publish(
        pipelineEvent(this.entityType, 'DECISION_PROPOSING'),
        { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId },
        'IntelligencePipelineSaga',
        this.sagaId
      );
    }
  }

  /** Step 6: Decision proposed → content generation */
  public async onDecisionProposed(msg: EventMessage) {
    console.log(`[IntelligencePipeline] Decision proposed for ${this.entityType} ${this.entityId}`);
    await this.transition({ step: 'CONTENT_GENERATING', decision: msg.payload });

    this.registerCompensation('discard_decision', async () => {
      console.log(`[IntelligencePipeline] Compensation: discarding decision for ${this.entityId}`);
    });

    await eventBus.publish(
      pipelineEvent(this.entityType, 'CONTENT_GENERATING'),
      { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId },
      'IntelligencePipelineSaga',
      this.sagaId
    );
  }

  /** Step 7: Content generated → publishing (or skip) */
  public async onContentGenerated(msg: EventMessage) {
    console.log(`[IntelligencePipeline] Content generated for ${this.entityType} ${this.entityId}`);
    await this.transition({ step: 'CONTENT_COMPLETE', contentId: msg.payload.contentId });

    this.registerCompensation('delete_content', async () => {
      console.log(`[IntelligencePipeline] Compensation: deleting content for ${this.entityId}`);
    });

    if (this.skippedSteps.has('PUBLISHING')) {
      await this.skipToNextAfter('PUBLISHING', msg);
    } else {
      await this.transition({ step: 'PUBLISHING' });
      await eventBus.publish(
        pipelineEvent(this.entityType, 'PUBLISHING'),
        { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId },
        'IntelligencePipelineSaga',
        this.sagaId
      );
    }
  }

  /** Step 8: Published → await feedback */
  public async onPublished(msg: EventMessage) {
    const channels: string[] = msg.payload.channels || [];
    console.log(`[IntelligencePipeline] ${this.entityType} ${this.entityId} published to ${channels.length} channels`);
    await this.transition({ step: 'FEEDBACK_AWAITING', publishedChannels: channels });

    this.registerCompensation('unpublish', async () => {
      console.log(`[IntelligencePipeline] Compensation: unpublishing ${this.entityId}`);
    });

    // Pipeline parks here until feedback arrives
    // FeedbackIntelligenceAgent will emit feedback event with correlationId
  }

  /** Step 9: Feedback received → learning update */
  public async onFeedbackReceived(msg: EventMessage) {
    console.log(`[IntelligencePipeline] Feedback received for ${this.entityType} ${this.entityId}. Updating model…`);
    await this.transition({ step: 'LEARNING_UPDATING', feedback: msg.payload });

    await eventBus.publish(
      pipelineEvent(this.entityType, 'LEARNING_UPDATING'),
      { entityType: this.entityType, entityId: this.entityId, orgId: this.orgId, feedback: msg.payload },
      'IntelligencePipelineSaga',
      this.sagaId
    );
  }

  /** Step 10: Learning updated → COMPLETE */
  public async onLearningUpdated(msg: EventMessage) {
    console.log(`[IntelligencePipeline] ✅ ${this.entityType} ${this.entityId} intelligence pipeline COMPLETE`);
    await this.transition({ step: 'COMPLETE' });

    await eventBus.publish(
      'intelligence.pipeline.completed.v1',
      {
        entityType: this.entityType,
        entityId: this.entityId,
        orgId: this.orgId,
        sagaId: this.sagaId,
        sagaVersion: this.sagaVersion,
        completedAt: new Date().toISOString(),
      },
      'IntelligencePipelineSaga',
      this.sagaId
    );

    await this.complete();
  }

  /** Error handler */
  public async onFailed(reason: string) {
    console.error(`[IntelligencePipeline] ❌ ${this.entityType} ${this.entityId} FAILED: ${reason}`);
    await this.fail(reason);
  }

  // ─── Skip Logic ───────────────────────────────────────────────────────────

  private async skipToNextAfter(skippedStep: PipelineStep, msg: EventMessage) {
    const orderedSteps: PipelineStep[] = [
      'TWIN_GENERATING', 'DECISION_PROPOSING', 'CONTENT_GENERATING', 'PUBLISHING',
      'FEEDBACK_AWAITING', 'LEARNING_UPDATING', 'COMPLETE',
    ];

    const idx = orderedSteps.indexOf(skippedStep);
    const nextStep = orderedSteps[idx + 1];

    if (!nextStep) {
      await this.onLearningUpdated(msg);
      return;
    }

    // Map next step to handler
    const handlers: Record<string, (msg: EventMessage) => Promise<void>> = {
      DECISION_PROPOSING: (m) => this.onDecisionProposed(m),
      CONTENT_GENERATING: (m) => this.onContentGenerated(m),
      PUBLISHING:         (m) => this.onPublished(m),
      FEEDBACK_AWAITING:  (m) => this.onFeedbackReceived(m),
      LEARNING_UPDATING:  (m) => this.onLearningUpdated(m),
    };

    // Check if the next step is also skipped
    if (this.skippedSteps.has(nextStep)) {
      await this.skipToNextAfter(nextStep, msg);
    } else if (handlers[nextStep]) {
      await handlers[nextStep](msg);
    }
  }
}

// ─── Active Registry ──────────────────────────────────────────────────────────
const activeSagas = new Map<string, IntelligencePipelineSaga>();

// ─── Entity → DomainEvent Mapping ─────────────────────────────────────────────
const ENTITY_CREATED_EVENTS: Record<IntelligenceEntityType, string> = {
  PROPERTY:  DomainEvents.PROPERTY_CREATED,
  MARKET:    'market.intelligence.triggered.v1',
  USER:      'user.passport.created.v1',
  AGENT:     'agent.passport.created.v1',
  PORTFOLIO: 'portfolio.created.v1',
  PARTNER:   'partner.activated.v1',
};

// ─── Listener Registration ────────────────────────────────────────────────────
export function registerIntelligencePipelineListeners() {
  // Register a trigger for each entity type
  for (const [entityType, eventName] of Object.entries(ENTITY_CREATED_EVENTS)) {
    eventBus.subscribe(eventName, (msg) => {
      const entityId = msg.payload.propertyId || msg.payload.entityId || msg.payload.userId || msg.payload.agentId || msg.payload.partnerId || msg.payload.id;
      const orgId = msg.payload.orgId || msg.payload.organizationId || '';
      if (!entityId) return;

      const localization = msg.localization || {
        countryCode: 'US', language: 'en', currency: 'USD', timezone: 'America/New_York'
      };

      const saga = new IntelligencePipelineSaga(
        entityType as IntelligenceEntityType,
        entityId,
        orgId,
        msg.correlationId,
        localization
      );
      activeSagas.set(saga.sagaId, saga);
      saga.onEntityCreated();
      console.log(`[IntelligencePipeline] 🚀 Started ${entityType} pipeline for ${entityId}`);
    });
  }

  // ── Pipeline step events (generic, entity-type-agnostic) ─────────────────
  const stepEvents = [
    { event: 'data.collected',       handler: 'onDataCollected' },
    { event: 'analyzed',             handler: 'onAnalyzed' },
    { event: 'scored',               handler: 'onScored' },
    { event: 'twin.generated',       handler: 'onTwinGenerated' },
    { event: 'decision.proposed',    handler: 'onDecisionProposed' },
    { event: 'content.generated',    handler: 'onContentGenerated' },
    { event: 'published',            handler: 'onPublished' },
    { event: 'feedback.received',    handler: 'onFeedbackReceived' },
    { event: 'learning.updated',     handler: 'onLearningUpdated' },
  ] as const;

  // Subscribe to step events for all entity types
  for (const entityType of Object.keys(ENTITY_CREATED_EVENTS)) {
    for (const { event, handler } of stepEvents) {
      const eventName = `intelligence.${entityType.toLowerCase()}.${event}.v1`;
      eventBus.subscribe(eventName, (msg) => {
        const saga = activeSagas.get(msg.correlationId!);
        if (saga) {
          (saga as any)[handler](msg);
        }
      });
    }
  }

  // Error event
  eventBus.subscribe('intelligence.pipeline.failed.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onFailed(msg.payload.reason || 'Unknown error');
  });

  console.log(`[IntelligencePipeline] ✅ Listeners registered for ${Object.keys(ENTITY_CREATED_EVENTS).length} entity types × ${stepEvents.length} steps`);
}

export { activeSagas as intelligencePipelineActiveSagas };
