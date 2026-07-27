/**
 * BaseSaga — Enterprise Orchestration Platform
 *
 * Features:
 *   ✅ State persistence (Prisma sagaState)
 *   ✅ Compensation chain (reverse-order rollback)
 *   ✅ Saga versioning (v1/v2 parallel execution)
 *   ✅ Distributed locking (entity-level collision prevention)
 *   ✅ Saga timeline (step-level observability)
 *   ✅ Retry policy (exponential backoff before compensation)
 *   ✅ Dead letter queue integration (failed events → replay)
 *   ✅ Localization context (multi-country)
 */

import { v4 as uuidv4 } from 'uuid';
import { prismaManager } from '../../lib/prisma';
import { LocalizationContext } from '../events/domain-events';
import { distributedLock } from './distributed-lock';
import { sagaTimeline } from './saga-timeline';
import { retryExecutor, RetryPolicy, DEFAULT_RETRY_POLICY } from './retry-policy';
import { deadLetterQueue } from './dead-letter-queue';

export enum SagaStatus {
  STARTED = 'STARTED',
  COMPENSATING = 'COMPENSATING',
  COMPLETED = 'COMPLETED',
  FAILED = 'FAILED'
}

export abstract class BaseSaga {
  public sagaId: string;
  public sagaVersion: number;
  public status: SagaStatus;
  protected state: any;
  protected localization: LocalizationContext;
  protected compensationSteps: { name: string; undo: () => Promise<void> }[] = [];

  /** Override in subclass to set entity lock key (e.g. `property:${id}`) */
  protected lockKey?: string;

  /** Override in subclass to customize retry behavior */
  protected retryPolicy: Partial<RetryPolicy> = DEFAULT_RETRY_POLICY;

  /** Tracks step start time for duration calculation */
  private stepStartedAt: number = Date.now();

  constructor(
    sagaId?: string,
    initialState: any = {},
    localization?: LocalizationContext,
    version: number = 1
  ) {
    this.sagaId = sagaId || uuidv4();
    this.sagaVersion = version;
    this.status = SagaStatus.STARTED;
    this.state = initialState;
    this.localization = localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    this.persistState();
  }

  /**
   * Register a compensation step that will be called in reverse order on failure.
   */
  protected registerCompensation(name: string, undo: () => Promise<void>): void {
    this.compensationSteps.push({ name, undo });
  }

  /**
   * Update localization context
   */
  protected setLocalization(localization: LocalizationContext): void {
    this.localization = { ...this.localization, ...localization };
  }

  /**
   * Advance the workflow state with optional distributed locking.
   * Records step transition in the timeline.
   */
  protected async transition(newStateData: any): Promise<void> {
    const previousStep = this.state.step || 'INIT';
    const nextStep = newStateData.step || 'UPDATE';
    const now = Date.now();
    const durationMs = now - this.stepStartedAt;

    const doTransition = async () => {
      this.state = { ...this.state, ...newStateData };
      await this.persistState();
    };

    // If lockKey is set, acquire lock during transition
    if (this.lockKey) {
      await distributedLock.withLock(
        this.lockKey,
        this.sagaId,
        doTransition,
        30_000,
        10_000
      );
    } else {
      await doTransition();
    }

    // Record in timeline (non-blocking, non-fatal)
    sagaTimeline.recordStep({
      correlationId: this.sagaId,
      sagaType: this.constructor.name,
      step: previousStep,
      durationMs,
      outcome: 'SUCCESS',
      metadata: { nextStep },
    }).catch(() => {});

    // Reset timer for next step
    this.stepStartedAt = Date.now();
  }

  /**
   * Execute a step function with retry policy.
   * On final failure → enqueue to DLQ → then compensate.
   */
  protected async executeStep<T>(
    stepName: string,
    fn: () => Promise<T>,
    customRetryPolicy?: Partial<RetryPolicy>
  ): Promise<T> {
    const policy = customRetryPolicy || this.retryPolicy;

    const result = await retryExecutor.executeWithRetry(
      fn,
      policy,
      (attempt, err, delay) => {
        console.warn(
          `[${this.constructor.name}] Step "${stepName}" retry ${attempt}: ${err.message}. Next in ${delay}ms`
        );
        // Record retry in timeline
        sagaTimeline.recordStep({
          correlationId: this.sagaId,
          sagaType: this.constructor.name,
          step: stepName,
          retryCount: attempt,
          outcome: 'RETRY',
          error: err.message,
        }).catch(() => {});
      }
    );

    if (!result.success) {
      // All retries exhausted → Dead Letter Queue
      await deadLetterQueue.enqueue({
        correlationId: this.sagaId,
        sagaType: this.constructor.name,
        step: stepName,
        eventType: `${this.constructor.name}.${stepName}`,
        payload: this.state,
        error: result.error?.message || 'Unknown error',
        retryCount: result.attempts,
      });

      // Record failure in timeline
      await sagaTimeline.recordStep({
        correlationId: this.sagaId,
        sagaType: this.constructor.name,
        step: stepName,
        durationMs: result.totalDurationMs,
        retryCount: result.attempts,
        outcome: 'FAILED',
        error: result.error?.message,
      }).catch(() => {});

      // Now trigger compensation
      throw result.error || new Error(`Step ${stepName} failed after ${result.attempts} attempts`);
    }

    return result.result!;
  }

  protected async complete(): Promise<void> {
    const durationMs = Date.now() - this.stepStartedAt;
    this.status = SagaStatus.COMPLETED;
    await this.persistState();

    // Record completion in timeline
    sagaTimeline.recordStep({
      correlationId: this.sagaId,
      sagaType: this.constructor.name,
      step: 'COMPLETE',
      durationMs,
      outcome: 'SUCCESS',
    }).catch(() => {});

    console.log(`[Saga ${this.constructor.name}] Completed: ${this.sagaId}`);
  }

  protected async fail(reason: string): Promise<void> {
    this.status = SagaStatus.COMPENSATING;
    this.state.failureReason = reason;
    await this.persistState();

    // Record failure in timeline
    sagaTimeline.recordStep({
      correlationId: this.sagaId,
      sagaType: this.constructor.name,
      step: this.state.step || 'UNKNOWN',
      outcome: 'FAILED',
      error: reason,
    }).catch(() => {});

    console.error(`[Saga ${this.constructor.name}] Failed: ${this.sagaId} - ${reason}`);
    await this.compensate();
    this.status = SagaStatus.FAILED;
    await this.persistState();
  }

  /**
   * Execute all registered compensation steps in reverse order.
   * Override in subclass to add custom compensation before/after.
   */
  protected async compensate(): Promise<void> {
    for (const step of [...this.compensationSteps].reverse()) {
      try {
        await step.undo();

        // Record compensation in timeline
        sagaTimeline.recordStep({
          correlationId: this.sagaId,
          sagaType: this.constructor.name,
          step: `COMPENSATE:${step.name}`,
          outcome: 'COMPENSATED',
        }).catch(() => {});

        console.log(`[Saga ${this.constructor.name}] Compensation done: ${step.name}`);
      } catch (err) {
        sagaTimeline.recordStep({
          correlationId: this.sagaId,
          sagaType: this.constructor.name,
          step: `COMPENSATE:${step.name}`,
          outcome: 'FAILED',
          error: err instanceof Error ? err.message : String(err),
        }).catch(() => {});

        console.error(`[Saga ${this.constructor.name}] Compensation failed for ${step.name}:`, err);
      }
    }
  }

  /**
   * Real persistence to Prisma Event Sourcing Table (now with sagaVersion)
   */
  private async persistState(): Promise<void> {
    try {
      const prisma = prismaManager.getClient(this.localization.countryCode);
      await prisma.sagaState.upsert({
        where: { correlationId: this.sagaId },
        create: {
          correlationId: this.sagaId,
          sagaType: this.constructor.name,
          currentStep: this.state.step || 'INIT',
          status: this.status,
          sagaVersion: this.sagaVersion,
          context: {
            ...this.state,
            localization: this.localization
          }
        } as any,
        update: {
          currentStep: this.state.step || 'UPDATE',
          status: this.status,
          sagaVersion: this.sagaVersion,
          context: {
            ...this.state,
            localization: this.localization
          }
        } as any,
      });
    } catch (err) {
      console.error(`[SagaState] Failed to persist Saga ${this.sagaId}`, err);
    }
  }
}
