/**
 * Saga Timeline
 * Step-level observability for saga workflows.
 *
 * Records every step transition with:
 *   - Duration (ms)
 *   - Retry count
 *   - Outcome (SUCCESS / RETRY / COMPENSATED / FAILED)
 *   - Error details
 *   - Custom metadata
 *
 * This powers the Admin Intelligence Dashboard "Saga Timeline" view.
 *
 * Usage (called automatically by BaseSaga):
 *   await sagaTimeline.recordStep({
 *     correlationId: this.sagaId,
 *     sagaType: this.constructor.name,
 *     step: 'SCORING',
 *     outcome: 'SUCCESS',
 *     durationMs: 1234,
 *   });
 */

import { prismaManager } from '../../lib/prisma';

export interface TimelineEntry {
  correlationId: string;
  sagaType: string;
  step: string;
  startedAt?: Date;
  completedAt?: Date;
  durationMs?: number;
  retryCount?: number;
  outcome: 'SUCCESS' | 'RETRY' | 'COMPENSATED' | 'FAILED';
  error?: string;
  metadata?: Record<string, any>;
}

export interface SagaTimelineView {
  sagaId: string;
  sagaType: string;
  steps: Array<{
    step: string;
    startedAt: Date;
    completedAt: Date | null;
    durationMs: number | null;
    retryCount: number;
    outcome: string;
    error: string | null;
  }>;
  totalDurationMs: number;
  status: string;
}

export class SagaTimeline {
  private countryCode: string;

  constructor(countryCode: string = 'US') {
    this.countryCode = countryCode;
  }

  private getModel() {
    const prisma = prismaManager.getClient(this.countryCode);
    return (prisma as any).sagaTimeline;
  }

  /**
   * Record a step in the saga timeline.
   */
  async recordStep(entry: TimelineEntry): Promise<void> {
    try {
      const model = this.getModel();
      await model.create({
        data: {
          correlationId: entry.correlationId,
          sagaType: entry.sagaType,
          step: entry.step,
          startedAt: entry.startedAt || new Date(),
          completedAt: entry.completedAt || (entry.outcome !== 'RETRY' ? new Date() : null),
          durationMs: entry.durationMs,
          retryCount: entry.retryCount || 0,
          outcome: entry.outcome,
          error: entry.error,
          metadata: entry.metadata || undefined,
        },
      });
    } catch (err) {
      // Timeline recording is non-fatal — never crash the saga
      console.error(`[SagaTimeline] Failed to record step ${entry.step} for ${entry.correlationId}:`, err);
    }
  }

  /**
   * Get full timeline for a specific saga instance.
   */
  async getTimeline(correlationId: string): Promise<SagaTimelineView | null> {
    try {
      const model = this.getModel();

      const steps = await model.findMany({
        where: { correlationId },
        orderBy: { startedAt: 'asc' },
      });

      if (steps.length === 0) return null;

      const firstStep = steps[0];
      const lastStep = steps[steps.length - 1];
      const totalDurationMs =
        (lastStep.completedAt?.getTime() ?? Date.now()) - firstStep.startedAt.getTime();

      // Derive status from last step
      const status =
        lastStep.outcome === 'FAILED' ? 'FAILED' :
        lastStep.outcome === 'COMPENSATED' ? 'COMPENSATED' :
        lastStep.step === 'COMPLETE' ? 'COMPLETED' : 'RUNNING';

      return {
        sagaId: correlationId,
        sagaType: firstStep.sagaType,
        steps: steps.map((s: { step: any; startedAt: any; completedAt: any; durationMs: any; retryCount: any; outcome: any; error: any; }) => ({
          step: s.step,
          startedAt: s.startedAt,
          completedAt: s.completedAt,
          durationMs: s.durationMs,
          retryCount: s.retryCount,
          outcome: s.outcome,
          error: s.error,
        })),
        totalDurationMs,
        status,
      };
    } catch (err) {
      console.error(`[SagaTimeline] Failed to get timeline for ${correlationId}:`, err);
      return null;
    }
  }

  /**
   * Get recent saga timelines for the admin dashboard.
   */
  async getRecentTimelines(limit: number = 20): Promise<SagaTimelineView[]> {
    try {
      const model = this.getModel();

      // Get distinct correlation IDs from recent timeline entries
      const recentIds = await model.findMany({
        select: { correlationId: true },
        distinct: ['correlationId'],
        orderBy: { startedAt: 'desc' },
        take: limit,
      });

      const timelines: SagaTimelineView[] = [];
      for (const { correlationId } of recentIds) {
        const timeline = await this.getTimeline(correlationId);
        if (timeline) timelines.push(timeline);
      }

      return timelines;
    } catch (err) {
      console.error('[SagaTimeline] Failed to get recent timelines:', err);
      return [];
    }
  }

  /**
   * Get aggregated statistics for the dashboard.
   */
  async getStats(): Promise<{
    totalSagas: number;
    completedSagas: number;
    failedSteps: number;
    avgDurationMs: number;
    bySagaType: Record<string, { total: number; avgDurationMs: number }>;
  }> {
    try {
      const model = this.getModel();

      const [totalSagas, failedSteps, allEntries] = await Promise.all([
        model.findMany({
          select: { correlationId: true },
          distinct: ['correlationId'],
        }),
        model.count({ where: { outcome: 'FAILED' } }),
        model.groupBy({
          by: ['sagaType'],
          _count: { id: true },
          _avg: { durationMs: true },
        }),
      ]);

      const completedSagas = await model.count({
        where: { step: 'COMPLETE', outcome: 'SUCCESS' },
      });

      const avgEntries = await model.aggregate({
        _avg: { durationMs: true },
      });

      const bySagaType: Record<string, { total: number; avgDurationMs: number }> = {};
      for (const entry of allEntries) {
        bySagaType[entry.sagaType] = {
          total: entry._count.id,
          avgDurationMs: Math.round(entry._avg.durationMs ?? 0),
        };
      }

      return {
        totalSagas: totalSagas.length,
        completedSagas,
        failedSteps,
        avgDurationMs: Math.round(avgEntries._avg.durationMs ?? 0),
        bySagaType,
      };
    } catch (err) {
      console.error('[SagaTimeline] Failed to get stats:', err);
      return { totalSagas: 0, completedSagas: 0, failedSteps: 0, avgDurationMs: 0, bySagaType: {} };
    }
  }
}

// Singleton
export const sagaTimeline = new SagaTimeline();
