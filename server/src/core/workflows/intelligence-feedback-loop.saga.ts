/**
 * Intelligence Feedback Loop Saga
 * Phase 7 — Autonomous Learning & Score Recalibration
 *
 * Triggered by: feedback.calibration.completed.v1
 *
 * Flow:
 *   feedback.calibration.completed.v1
 *       ↓
 *   CALIBRATING — apply delta to Property scores
 *       ↓
 *   SCORE_RECALIBRATED — re-emit property.score.calculated.v1
 *       ↓
 *   CONTENT_REFRESHING (if downward) — trigger ContentIntelligenceAgent
 *       ↓
 *   MARKET_UPDATING — update MarketIntelligenceProfile accuracy
 *       ↓
 *   COMPLETE
 *
 * This closes the intelligence loop:
 *   Prediction → Outcome → Feedback → Calibration → Better Prediction
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage, DomainEvents } from '../events/domain-events';
import { eventBus } from '../events/event-bus';

export class IntelligenceFeedbackLoopSaga extends BaseSaga {
  public propertyId: string;
  public orgId: string;
  public calibrationDelta: number;
  public direction: 'UPWARD' | 'DOWNWARD' | 'NEUTRAL';

  constructor(
    propertyId: string,
    orgId: string,
    calibrationDelta: number,
    direction: 'UPWARD' | 'DOWNWARD' | 'NEUTRAL',
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'CALIBRATION_RECEIVED', propertyId, orgId, calibrationDelta, direction }, localization);
    this.propertyId = propertyId;
    this.orgId = orgId;
    this.calibrationDelta = calibrationDelta;
    this.direction = direction;
  }

  protected async compensate(): Promise<void> {
    console.log(`[FeedbackLoopSaga] Compensating feedback loop for ${this.propertyId}`);
    await super.compensate();
  }

  /** Step 1 — Apply calibration → re-emit score event */
  public async onCalibrationReceived() {
    console.log(`[FeedbackLoopSaga] Calibration received for ${this.propertyId}: delta=${this.calibrationDelta.toFixed(3)} dir=${this.direction}`);
    await this.transition({ step: 'SCORE_RECALIBRATING' });

    this.registerCompensation('revert_calibration', async () => {
      console.log(`[FeedbackLoopSaga] Compensation: reverting calibration for ${this.propertyId}`);
    });

    // Re-emit score event so downstream (Content, SEO) picks up calibrated scores
    await eventBus.publish(
      DomainEvents.PROPERTY_SCORE_CALCULATED,
      {
        propertyId: this.propertyId,
        orgId: this.orgId,
        calibrated: true,
        calibrationDelta: this.calibrationDelta,
        direction: this.direction,
        triggeredBy: 'intelligence-feedback-loop-saga',
        localization: this.localization,
      },
      'IntelligenceFeedbackLoopSaga',
      this.sagaId
    );
  }

  /** Step 2 — Score recalibrated → trigger content refresh if needed */
  public async onScoreRecalibrated(msg: EventMessage) {
    await this.transition({ step: 'EVALUATING_CONTENT_REFRESH' });

    if (this.direction === 'DOWNWARD' && Math.abs(this.calibrationDelta) > 0.03) {
      console.log(`[FeedbackLoopSaga] Downward calibration — triggering content refresh for ${this.propertyId}`);
      await this.transition({ step: 'CONTENT_REFRESHING' });

      this.registerCompensation('cancel_content_refresh', async () => {
        console.log(`[FeedbackLoopSaga] Compensation: cancelling content refresh for ${this.propertyId}`);
      });

      await eventBus.publish(
        DomainEvents.PROPERTY_DIGITAL_TWIN_GENERATED,
        {
          propertyId: this.propertyId,
          orgId: this.orgId,
          refreshTriggeredByFeedback: true,
          localization: this.localization,
        },
        'IntelligenceFeedbackLoopSaga',
        this.sagaId
      );
    } else {
      // No content refresh needed — go straight to market update
      await this.onContentRefreshSkipped();
    }
  }

  /** Step 3 — Content refresh done OR skipped → update market accuracy */
  public async onContentRefreshSkipped() {
    await this.transition({ step: 'MARKET_ACCURACY_UPDATING' });
    await this.emitMarketAccuracyUpdate();
  }

  public async onContentRefreshed(msg: EventMessage) {
    console.log(`[FeedbackLoopSaga] Content refreshed for ${this.propertyId}`);
    await this.transition({ step: 'MARKET_ACCURACY_UPDATING' });
    await this.emitMarketAccuracyUpdate();
  }

  /** Step 4 — Market accuracy updated → COMPLETE */
  public async onMarketAccuracyUpdated(msg: EventMessage) {
    console.log(`[FeedbackLoopSaga] ✅ Intelligence feedback loop COMPLETE for ${this.propertyId}`);
    await this.transition({ step: 'COMPLETE' });

    await eventBus.publish(
      'intelligence.feedback.loop.completed.v1',
      {
        propertyId: this.propertyId,
        orgId: this.orgId,
        calibrationDelta: this.calibrationDelta,
        direction: this.direction,
        sagaId: this.sagaId,
        completedAt: new Date().toISOString(),
      },
      'IntelligenceFeedbackLoopSaga',
      this.sagaId
    );

    await this.complete();
  }

  private async emitMarketAccuracyUpdate() {
    await eventBus.publish(
      'market.accuracy.updated.v1',
      {
        propertyId: this.propertyId,
        orgId: this.orgId,
        calibrationDelta: this.calibrationDelta,
        direction: this.direction,
        localization: this.localization,
      },
      'IntelligenceFeedbackLoopSaga',
      this.sagaId
    );
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, IntelligenceFeedbackLoopSaga>();

export function registerIntelligenceFeedbackLoopListeners() {
  // Triggered by FeedbackIntelligenceAgent after calibration
  eventBus.subscribe('feedback.calibration.completed.v1', (msg) => {
    const { propertyId, orgId, calibrationDelta, direction } = msg.payload;
    if (!propertyId || direction === 'NEUTRAL') return; // Skip neutral calibrations

    const localization = msg.localization || {
      countryCode: 'US', language: 'en', currency: 'USD', timezone: 'America/New_York'
    };

    const saga = new IntelligenceFeedbackLoopSaga(
      propertyId, orgId, calibrationDelta, direction,
      msg.correlationId, localization
    );
    activeSagas.set(saga.sagaId, saga);
    saga.onCalibrationReceived();
    console.log(`[FeedbackLoopSaga] 🔄 Started for property ${propertyId} (${direction})`);
  });

  // Score recalibrated (from step 1 re-emit, handled by agents → saga continues)
  eventBus.subscribe('feedback.score.recalibrated.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onScoreRecalibrated(msg);
  });

  // Content refreshed (from ContentIntelligenceAgent)
  eventBus.subscribe('content.refresh.completed.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onContentRefreshed(msg);
  });

  // Market accuracy updated
  eventBus.subscribe('market.accuracy.updated.v1', (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onMarketAccuracyUpdated(msg);
  });

  console.log('[IntelligenceFeedbackLoopSaga] ✅ Listeners registered');
}

export { activeSagas as feedbackLoopActiveSagas };
