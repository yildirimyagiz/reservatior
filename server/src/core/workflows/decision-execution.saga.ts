/**
 * Decision Execution Saga
 * AI Decision → Owner Notification → Acceptance → Action → Outcome → Learning
 *
 * Flow:
 *   DECISION_PROPOSED (by DecisionEngine)
 *     ↓
 *   OWNER_NOTIFIED    (WhatsApp/Email via NotificationOS)
 *     ↓
 *   OWNER_ACCEPTED / OWNER_REJECTED
 *     ↓
 *   ACTION_EXECUTED   (e.g. listing price updated, strategy changed)
 *     ↓
 *   OUTCOME_MONITORED (track: views, leads, offers for X days)
 *     ↓
 *   LEARNING_UPDATED  (FeedbackIntelligenceAgent recalibrates)
 *     ↓
 *   COMPLETE
 *
 * Compensation:
 *   If owner rejects → revert action, mark decision as rejected
 *   If action fails → notify owner, rollback
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage, DomainEvents } from '../events/domain-events';
import { eventBus } from '../events/event-bus';

export type DecisionType =
  | 'PRICE_REDUCTION'
  | 'PRICE_INCREASE'
  | 'MARKETING_BOOST'
  | 'LISTING_REFRESH'
  | 'AGENT_REASSIGNMENT'
  | 'INVESTMENT_RECOMMENDATION'
  | 'PORTFOLIO_REBALANCE';

export class DecisionExecutionSaga extends BaseSaga {
  public decisionId: string;
  public propertyId: string;
  public orgId: string;
  public decisionType: DecisionType;
  public recommendation: string;
  public proposedValue: any;
  public ownerId?: string;

  constructor(
    decisionId: string,
    propertyId: string,
    orgId: string,
    decisionType: DecisionType,
    recommendation: string,
    proposedValue: any,
    ownerId?: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, {
      step: 'DECISION_PROPOSED',
      decisionId, propertyId, orgId, decisionType, recommendation, proposedValue,
    }, localization);
    this.decisionId = decisionId;
    this.propertyId = propertyId;
    this.orgId = orgId;
    this.decisionType = decisionType;
    this.recommendation = recommendation;
    this.proposedValue = proposedValue;
    this.ownerId = ownerId;
    this.lockKey = `decision:${propertyId}`;
  }

  protected async compensate(): Promise<void> {
    console.log(`[DecisionSaga] Compensating decision ${this.decisionId} for property ${this.propertyId}`);
    await super.compensate();
  }

  /** Step 1: Decision proposed → notify owner */
  public async onDecisionProposed() {
    console.log(`[DecisionSaga] Decision ${this.decisionId} proposed: ${this.decisionType} — "${this.recommendation}"`);
    await this.transition({ step: 'NOTIFYING_OWNER' });

    this.registerCompensation('cancel_notification', async () => {
      console.log(`[DecisionSaga] Compensation: cancelling notification for decision ${this.decisionId}`);
    });

    await eventBus.publish(
      'decision.owner.notification.requested.v1',
      {
        decisionId: this.decisionId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        ownerId: this.ownerId,
        decisionType: this.decisionType,
        recommendation: this.recommendation,
        proposedValue: this.proposedValue,
        localization: this.localization,
      },
      'DecisionExecutionSaga',
      this.sagaId
    );
  }

  /** Step 2: Owner notified → awaiting response */
  public async onOwnerNotified(msg: EventMessage) {
    console.log(`[DecisionSaga] Owner notified for decision ${this.decisionId}. Awaiting response…`);
    await this.transition({ step: 'AWAITING_OWNER_RESPONSE', notifiedAt: new Date().toISOString() });
    // Saga parks here until owner accepts or rejects
  }

  /** Step 3a: Owner accepted → execute action */
  public async onOwnerAccepted(msg: EventMessage) {
    console.log(`[DecisionSaga] ✅ Owner accepted decision ${this.decisionId}. Executing action…`);
    await this.transition({ step: 'EXECUTING_ACTION', acceptedAt: new Date().toISOString() });

    this.registerCompensation('revert_action', async () => {
      console.log(`[DecisionSaga] Compensation: reverting action for decision ${this.decisionId}`);
      await eventBus.publish(
        'decision.action.reverted.v1',
        { decisionId: this.decisionId, propertyId: this.propertyId, decisionType: this.decisionType },
        'DecisionExecutionSaga',
        this.sagaId
      );
    });

    await eventBus.publish(
      'decision.action.execute.v1',
      {
        decisionId: this.decisionId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        decisionType: this.decisionType,
        proposedValue: this.proposedValue,
        localization: this.localization,
      },
      'DecisionExecutionSaga',
      this.sagaId
    );
  }

  /** Step 3b: Owner rejected → saga ends */
  public async onOwnerRejected(msg: EventMessage) {
    console.log(`[DecisionSaga] ❌ Owner rejected decision ${this.decisionId}. Reason: ${msg.payload.reason || 'N/A'}`);
    await this.transition({ step: 'REJECTED', rejectedAt: new Date().toISOString(), reason: msg.payload.reason });

    await eventBus.publish(
      'decision.rejected.v1',
      {
        decisionId: this.decisionId,
        propertyId: this.propertyId,
        decisionType: this.decisionType,
        reason: msg.payload.reason,
      },
      'DecisionExecutionSaga',
      this.sagaId
    );

    await this.complete();
  }

  /** Step 4: Action executed → start monitoring outcomes */
  public async onActionExecuted(msg: EventMessage) {
    console.log(`[DecisionSaga] Action executed for decision ${this.decisionId}. Monitoring outcomes…`);
    await this.transition({
      step: 'MONITORING_OUTCOME',
      executedAt: new Date().toISOString(),
      actionResult: msg.payload.result,
    });

    this.registerCompensation('stop_monitoring', async () => {
      console.log(`[DecisionSaga] Compensation: stopping outcome monitoring for ${this.decisionId}`);
    });

    // Saga parks here — outcome events (views, leads, offers) will be tracked
    // by the intelligence agents. After a monitoring period, a summary is emitted.
  }

  /** Step 5: Outcome summary received → update learning */
  public async onOutcomeReceived(msg: EventMessage) {
    const { views, leads, offers, daysMonitored } = msg.payload;
    console.log(
      `[DecisionSaga] Outcome for decision ${this.decisionId}: ` +
      `views=${views} leads=${leads} offers=${offers} days=${daysMonitored}`
    );
    await this.transition({
      step: 'UPDATING_LEARNING',
      outcome: { views, leads, offers, daysMonitored },
    });

    await eventBus.publish(
      'decision.learning.update.v1',
      {
        decisionId: this.decisionId,
        propertyId: this.propertyId,
        orgId: this.orgId,
        decisionType: this.decisionType,
        proposedValue: this.proposedValue,
        outcome: { views, leads, offers, daysMonitored },
        localization: this.localization,
      },
      'DecisionExecutionSaga',
      this.sagaId
    );
  }

  /** Step 6: Learning updated → COMPLETE */
  public async onLearningUpdated(msg: EventMessage) {
    console.log(`[DecisionSaga] ✅ Decision ${this.decisionId} learning cycle COMPLETE`);
    await this.transition({ step: 'COMPLETE' });

    await eventBus.publish(
      'decision.lifecycle.completed.v1',
      {
        decisionId: this.decisionId,
        propertyId: this.propertyId,
        decisionType: this.decisionType,
        sagaId: this.sagaId,
        completedAt: new Date().toISOString(),
      },
      'DecisionExecutionSaga',
      this.sagaId
    );

    await this.complete();
  }

  /** Error handler */
  public async onFailed(reason: string) {
    await this.fail(reason);
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, DecisionExecutionSaga>();

export function registerDecisionExecutionListeners() {
  // Triggered by DecisionEngine when a decision is ready
  eventBus.subscribe('decision.proposed.v1', (msg) => {
    const {
      decisionId, propertyId, orgId, decisionType, recommendation, proposedValue, ownerId
    } = msg.payload;

    const localization = msg.localization || {
      countryCode: 'US', language: 'en', currency: 'USD', timezone: 'America/New_York'
    };

    const saga = new DecisionExecutionSaga(
      decisionId, propertyId, orgId, decisionType, recommendation, proposedValue,
      ownerId, msg.correlationId, localization
    );
    activeSagas.set(saga.sagaId, saga);
    saga.onDecisionProposed();
    console.log(`[DecisionSaga] 🧠 Started for decision ${decisionId} (${decisionType})`);
  });

  eventBus.subscribe('decision.owner.notified.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOwnerNotified(msg);
  });

  eventBus.subscribe('decision.owner.accepted.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOwnerAccepted(msg);
  });

  eventBus.subscribe('decision.owner.rejected.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOwnerRejected(msg);
  });

  eventBus.subscribe('decision.action.executed.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onActionExecuted(msg);
  });

  eventBus.subscribe('decision.outcome.received.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onOutcomeReceived(msg);
  });

  eventBus.subscribe('decision.learning.updated.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onLearningUpdated(msg);
  });

  console.log('[DecisionSaga] ✅ Listeners registered (7 steps)');
}

export { activeSagas as decisionExecutionActiveSagas };
