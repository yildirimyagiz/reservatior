/**
 * Dead Letter Queue (DLQ)
 * DB-backed queue for failed saga events that can be replayed.
 *
 * Flow:
 *   Event fails after all retries
 *     → enqueue to DLQ (SagaDeadLetter table)
 *     → Admin can review, replay, or discard
 *
 * Usage:
 *   await deadLetterQueue.enqueue({
 *     correlationId: saga.sagaId,
 *     sagaType: 'IntelligencePipelineSaga',
 *     step: 'CONTENT_GENERATING',
 *     eventType: 'content.brief.generated.v1',
 *     payload: { propertyId: '...' },
 *     error: 'Timeout after 30s',
 *     retryCount: 3,
 *   });
 *
 *   // Admin replay:
 *   await deadLetterQueue.replay(entryId);
 */

import { prismaManager } from '../../lib/prisma';
import { eventBus } from '../events/event-bus';

export interface DeadLetterEntry {
  id: string;
  correlationId: string;
  sagaType: string;
  step: string;
  eventType: string;
  payload: any;
  error: string;
  retryCount: number;
  status: 'PENDING' | 'REPLAYED' | 'DISCARDED';
  createdAt: Date;
  replayedAt?: Date | null;
}

export class DeadLetterQueue {
  private countryCode: string;

  constructor(countryCode: string = 'US') {
    this.countryCode = countryCode;
  }

  private getModel() {
    const prisma = prismaManager.getClient(this.countryCode);
    return (prisma as any).sagaDeadLetter;
  }

  /**
   * Add a failed event to the dead letter queue.
   */
  async enqueue(entry: {
    correlationId: string;
    sagaType: string;
    step: string;
    eventType: string;
    payload: any;
    error: string;
    retryCount: number;
  }): Promise<string> {
    try {
      const model = this.getModel();
      const record = await model.create({
        data: {
          correlationId: entry.correlationId,
          sagaType: entry.sagaType,
          step: entry.step,
          eventType: entry.eventType,
          payload: entry.payload,
          error: entry.error,
          retryCount: entry.retryCount,
          status: 'PENDING',
        },
      });

      console.warn(
        `[DLQ] ⚠️ Enqueued: saga=${entry.sagaType} step=${entry.step} event=${entry.eventType} retries=${entry.retryCount}`
      );

      // Emit DLQ event for monitoring
      await eventBus.publish(
        'saga.dead.letter.enqueued.v1',
        {
          dlqId: record.id,
          sagaType: entry.sagaType,
          step: entry.step,
          eventType: entry.eventType,
          error: entry.error,
        },
        'dead-letter-queue'
      );

      return record.id;
    } catch (err) {
      console.error('[DLQ] Failed to enqueue:', err);
      throw err;
    }
  }

  /**
   * Replay a dead letter entry by re-publishing its event.
   */
  async replay(id: string): Promise<void> {
    const model = this.getModel();
    const entry = await model.findUnique({ where: { id } });

    if (!entry) throw new Error(`[DLQ] Entry ${id} not found`);
    if (entry.status !== 'PENDING') throw new Error(`[DLQ] Entry ${id} is ${entry.status}, not PENDING`);

    // Re-publish the original event
    await eventBus.publish(
      entry.eventType,
      entry.payload as any,
      `DLQ-replay:${entry.sagaType}`,
      entry.correlationId
    );

    // Mark as replayed
    await model.update({
      where: { id },
      data: {
        status: 'REPLAYED',
        replayedAt: new Date(),
      },
    });

    console.log(`[DLQ] ✅ Replayed: id=${id} event=${entry.eventType}`);
  }

  /**
   * Replay all pending dead letters for a given saga type.
   * Returns number of entries replayed.
   */
  async replayAll(sagaType?: string): Promise<number> {
    const model = this.getModel();
    const where: any = { status: 'PENDING' };
    if (sagaType) where.sagaType = sagaType;

    const pending = await model.findMany({
      where,
      orderBy: { createdAt: 'asc' },
      take: 100, // safety limit
    });

    let replayed = 0;
    for (const entry of pending) {
      try {
        await this.replay(entry.id);
        replayed++;
      } catch (err) {
        console.error(`[DLQ] Replay failed for ${entry.id}:`, err);
      }
    }

    console.log(`[DLQ] Batch replay complete: ${replayed}/${pending.length} replayed`);
    return replayed;
  }

  /**
   * Discard a dead letter entry (admin decision: won't retry).
   */
  async discard(id: string): Promise<void> {
    const model = this.getModel();
    await model.update({
      where: { id },
      data: { status: 'DISCARDED' },
    });
    console.log(`[DLQ] 🗑️ Discarded: id=${id}`);
  }

  /**
   * Get all pending dead letter entries.
   */
  async getPending(limit: number = 50): Promise<DeadLetterEntry[]> {
    const model = this.getModel();
    const entries = await model.findMany({
      where: { status: 'PENDING' },
      orderBy: { createdAt: 'desc' },
      take: limit,
    });
    return entries as DeadLetterEntry[];
  }

  /**
   * Get DLQ statistics for admin dashboard.
   */
  async getStats(): Promise<{
    pending: number;
    replayed: number;
    discarded: number;
    bySagaType: Record<string, number>;
  }> {
    const model = this.getModel();

    const [pending, replayed, discarded] = await Promise.all([
      model.count({ where: { status: 'PENDING' } }),
      model.count({ where: { status: 'REPLAYED' } }),
      model.count({ where: { status: 'DISCARDED' } }),
    ]);

    // Group by saga type
    const byType = await model.groupBy({
      by: ['sagaType'],
      where: { status: 'PENDING' },
      _count: { id: true },
    });

    const bySagaType: Record<string, number> = {};
    for (const row of byType) {
      bySagaType[row.sagaType] = row._count.id;
    }

    return { pending, replayed, discarded, bySagaType };
  }
}

// Default singleton
export const deadLetterQueue = new DeadLetterQueue();
