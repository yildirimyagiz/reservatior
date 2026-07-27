/**
 * Feedback Intelligence Agent
 * Phase 7 — Intelligence Feedback Loop
 *
 * Listens to REAL outcome events (deal closed, booking completed, investment funded)
 * and recalibrates the Property/Market/Agent intelligence scores based on actuals.
 *
 * Flow:
 *   DealClosed / BookingCheckedOut / InvestmentFunded / CommissionPaid
 *       ↓
 *   Compare predicted vs actual (yield, price, days-on-market)
 *       ↓
 *   Compute calibration delta
 *       ↓
 *   Update PropertyCurrentScore.calibrationFactor
 *   Update PropertyScoreHistory (audit trail)
 *   Emit feedback.calibration.completed.v1
 */

import { PrismaClient } from '@prisma/client';
import { eventBus } from '../core/events/event-bus';
import { DomainEvents } from '../core/events/domain-events';
import { IdempotentEventConsumer } from '../core/events/idempotent-event-consumer';

const prisma = new PrismaClient();

// ─── Types ─────────────────────────────────────────────────────────────────────

export interface OutcomeEvent {
  propertyId: string;
  orgId: string;
  eventId: string;
  actualSalePrice?: number;
  predictedSalePrice?: number;
  actualRentalYield?: number;
  predictedRentalYield?: number;
  daysOnMarket?: number;
  predictedDaysOnMarket?: number;
  agentId?: string;
  source: 'DEAL_CLOSED' | 'BOOKING_COMPLETED' | 'INVESTMENT_FUNDED' | 'LISTING_EXPIRED';
}

export interface CalibrationResult {
  propertyId: string;
  pricePredictionError: number;    // % error: (actual - predicted) / predicted
  yieldPredictionError: number;
  domPredictionError: number;      // Days-on-market error %
  calibrationDelta: number;        // Composite adjustment to apply to scores
  direction: 'UPWARD' | 'DOWNWARD' | 'NEUTRAL';
  newCalibrationFactor: number;    // Cumulative factor (stored in DB)
  recommendation: string;
}

// ─── Agent ─────────────────────────────────────────────────────────────────────

export class FeedbackIntelligenceAgent {
  private idempotentConsumer: IdempotentEventConsumer;

  constructor() {
    this.idempotentConsumer = new IdempotentEventConsumer();
  }

  /** Subscribe to all outcome events */
  start() {
    eventBus.subscribe(DomainEvents.DEAL_CLOSED, async (msg) => {
      await this.handleOutcome({
        propertyId: msg.payload.propertyId,
        orgId: msg.payload.orgId ?? '',
        eventId: msg.id,
        actualSalePrice: msg.payload.salePrice,
        predictedSalePrice: msg.payload.predictedPrice,
        daysOnMarket: msg.payload.daysOnMarket,
        predictedDaysOnMarket: msg.payload.predictedDaysOnMarket,
        agentId: msg.payload.agentId,
        source: 'DEAL_CLOSED',
      });
    });

    eventBus.subscribe(DomainEvents.BOOKING_CHECKED_OUT, async (msg) => {
      await this.handleOutcome({
        propertyId: msg.payload.propertyId,
        orgId: msg.payload.orgId ?? '',
        eventId: msg.id,
        actualRentalYield: msg.payload.actualYield,
        predictedRentalYield: msg.payload.predictedYield,
        source: 'BOOKING_COMPLETED',
      });
    });

    eventBus.subscribe(DomainEvents.INVESTMENT_FUNDED, async (msg) => {
      await this.handleOutcome({
        propertyId: msg.payload.propertyId ?? '',
        orgId: msg.payload.orgId ?? '',
        eventId: msg.id,
        actualSalePrice: msg.payload.fundedAmount,
        predictedSalePrice: msg.payload.predictedValue,
        source: 'INVESTMENT_FUNDED',
      });
    });

    eventBus.subscribe(DomainEvents.LISTING_EXPIRED, async (msg) => {
      await this.handleOutcome({
        propertyId: msg.payload.propertyId ?? '',
        orgId: msg.payload.orgId ?? '',
        eventId: msg.id,
        daysOnMarket: msg.payload.daysListed,
        source: 'LISTING_EXPIRED',
      });
    });

    console.log('[FeedbackIntelligenceAgent] ✅ Subscribed to 4 outcome events');
  }

  /** Core calibration logic */
  async handleOutcome(outcome: OutcomeEvent): Promise<void> {
    if (!outcome.propertyId) return;

    const idempotencyKey = `feedback:${outcome.source}:${outcome.eventId}`;

    // Idempotency check
    const check = await this.idempotentConsumer.checkIdempotency({
      idempotencyKey,
      type: `feedback.${outcome.source.toLowerCase()}`,
      id: outcome.eventId,
      aggregateId: outcome.propertyId,
      version: 'v1',
      timestamp: new Date(),
      payload: outcome,
      source: 'feedback-intelligence-agent',
    });

    if (!check.shouldProcess) {
      console.log(`[FeedbackAgent] Skipping duplicate: ${idempotencyKey}`);
      return;
    }

    await this.idempotentConsumer.markAsProcessing({
      idempotencyKey,
      type: `feedback.${outcome.source.toLowerCase()}`,
      id: outcome.eventId,
      aggregateId: outcome.propertyId,
      version: 'v1',
      timestamp: new Date(),
      payload: outcome,
      source: 'feedback-intelligence-agent',
    });

    try {
      const result = await this.calibrate(outcome);
      await this.persistCalibration(outcome.propertyId, result);

      await eventBus.publish(
        'feedback.calibration.completed.v1',
        {
          propertyId: outcome.propertyId,
          orgId: outcome.orgId,
          calibrationDelta: result.calibrationDelta,
          direction: result.direction,
          newCalibrationFactor: result.newCalibrationFactor,
          source: outcome.source,
          recommendation: result.recommendation,
        },
        'feedback-intelligence-agent'
      );

      await this.idempotentConsumer.markAsCompleted({
        idempotencyKey,
        type: `feedback.${outcome.source.toLowerCase()}`,
        id: outcome.eventId,
        aggregateId: outcome.propertyId,
        version: 'v1',
        timestamp: new Date(),
        payload: outcome,
        source: 'feedback-intelligence-agent',
      }, { calibrationDelta: result.calibrationDelta });

      console.log(`[FeedbackAgent] ✅ Calibrated ${outcome.propertyId}: delta=${result.calibrationDelta.toFixed(3)} dir=${result.direction}`);
    } catch (err) {
      await this.idempotentConsumer.markAsFailed({
        idempotencyKey,
        type: `feedback.${outcome.source.toLowerCase()}`,
        id: outcome.eventId,
        aggregateId: outcome.propertyId,
        version: 'v1',
        timestamp: new Date(),
        payload: outcome,
        source: 'feedback-intelligence-agent',
      }, err instanceof Error ? err : new Error(String(err)));
      throw err;
    }
  }

  /** Compute calibration delta from prediction errors */
  private async calibrate(outcome: OutcomeEvent): Promise<CalibrationResult> {
    let pricePredictionError = 0;
    let yieldPredictionError = 0;
    let domPredictionError = 0;

    if (outcome.actualSalePrice && outcome.predictedSalePrice && outcome.predictedSalePrice > 0) {
      pricePredictionError = (outcome.actualSalePrice - outcome.predictedSalePrice) / outcome.predictedSalePrice;
    }
    if (outcome.actualRentalYield && outcome.predictedRentalYield && outcome.predictedRentalYield > 0) {
      yieldPredictionError = (outcome.actualRentalYield - outcome.predictedRentalYield) / outcome.predictedRentalYield;
    }
    if (outcome.daysOnMarket && outcome.predictedDaysOnMarket && outcome.predictedDaysOnMarket > 0) {
      // Negative: sold faster than predicted = UPWARD signal
      domPredictionError = (outcome.predictedDaysOnMarket - outcome.daysOnMarket) / outcome.predictedDaysOnMarket;
    }

    // Composite delta (weighted)
    const calibrationDelta = (
      pricePredictionError * 0.45 +
      yieldPredictionError * 0.35 +
      domPredictionError * 0.20
    );

    // Load existing calibration factor
    const currentScore = await (prisma as any).propertyCurrentScore
      ?.findUnique({ where: { propertyId: outcome.propertyId } })
      .catch(() => null);

    const existingFactor: number = currentScore?.calibrationFactor ?? 1.0;
    // Bounded update: max ±10% shift per event, cumulative factor stays in [0.6, 1.4]
    const rawNewFactor = existingFactor + calibrationDelta * 0.1;
    const newCalibrationFactor = Math.min(1.4, Math.max(0.6, rawNewFactor));

    const direction: CalibrationResult['direction'] =
      calibrationDelta > 0.02 ? 'UPWARD' :
      calibrationDelta < -0.02 ? 'DOWNWARD' : 'NEUTRAL';

    const recommendation = this.buildRecommendation(direction, pricePredictionError, yieldPredictionError, domPredictionError);

    return {
      propertyId: outcome.propertyId,
      pricePredictionError,
      yieldPredictionError,
      domPredictionError,
      calibrationDelta,
      direction,
      newCalibrationFactor,
      recommendation,
    };
  }

  /** Write calibration factor back to DB */
  private async persistCalibration(propertyId: string, result: CalibrationResult): Promise<void> {
    try {
      await (prisma as any).propertyCurrentScore?.update({
        where: { propertyId },
        data: {
          calibrationFactor: result.newCalibrationFactor,
          lastCalibratedAt: new Date(),
          calibrationDirection: result.direction,
        },
      });

      // Append to score history for audit trail
      await (prisma as any).propertyScoreHistory?.create({
        data: {
          propertyId,
          scoreType: 'CALIBRATION',
          score: result.calibrationDelta,
          metadata: {
            pricePredictionError: result.pricePredictionError,
            yieldPredictionError: result.yieldPredictionError,
            domPredictionError: result.domPredictionError,
            newCalibrationFactor: result.newCalibrationFactor,
            direction: result.direction,
            recommendation: result.recommendation,
          },
        },
      });
    } catch (err) {
      console.error(`[FeedbackAgent] DB persist failed for ${propertyId}:`, err);
      // Non-fatal: event already emitted
    }
  }

  private buildRecommendation(
    direction: CalibrationResult['direction'],
    priceErr: number,
    yieldErr: number,
    domErr: number
  ): string {
    if (direction === 'UPWARD') {
      return `Scores underestimated actual performance. Price was ${(priceErr * 100).toFixed(1)}% better than predicted. Raise base scores.`;
    } else if (direction === 'DOWNWARD') {
      return `Scores overestimated performance. Price deviation: ${(priceErr * 100).toFixed(1)}%. Lower base scores or review market model.`;
    }
    return 'Performance matched predictions. No score adjustment needed.';
  }
}

export const feedbackIntelligenceAgent = new FeedbackIntelligenceAgent();
