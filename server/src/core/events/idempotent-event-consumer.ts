/**
 * Idempotent Event Consumer
 * Prevents duplicate event processing with idempotency checks
 * Integrates with existing DomainEvents system
 */

import { PrismaClient } from '@prisma/client';
import {
  ReliableEventMessage,
  EventProcessingStatus,
  IdempotencyCheckResult,
  DomainEvent
} from './domain-events';

const prisma = new PrismaClient();

export interface EventProcessingResult {
  success: boolean;
  error?: Error;
  processingTime: number;
}

export class IdempotentEventConsumer {
  private prisma: PrismaClient;

  constructor(prismaClient?: PrismaClient) {
    this.prisma = prismaClient || new PrismaClient();
  }

  /**
   * Check if event has already been processed
   */
  async checkIdempotency(event: ReliableEventMessage): Promise<IdempotencyCheckResult> {
    try {
      const existingRecord = await this.prisma.eventIdempotency.findUnique({
        where: {
          idempotencyKey: event.idempotencyKey
        }
      });

      if (existingRecord) {
        // Check if processing is in progress
        if (existingRecord.processingStatus === 'PROCESSING') {
          return {
            alreadyProcessed: true,
            shouldProcess: false,
            existingRecord: {
              processingStatus: existingRecord.processingStatus as EventProcessingStatus,
              retryCount: existingRecord.retryCount,
              processedAt: existingRecord.processedAt
            }
          };
        }

        // Check if already completed successfully
        if (existingRecord.processingStatus === 'COMPLETED') {
          return {
            alreadyProcessed: true,
            shouldProcess: false,
            existingRecord: {
              processingStatus: existingRecord.processingStatus as EventProcessingStatus,
              retryCount: existingRecord.retryCount,
              processedAt: existingRecord.processedAt
            }
          };
        }

        // Check if failed and can be retried
        if (existingRecord.processingStatus === 'FAILED' && existingRecord.retryCount < 3) {
          return {
            alreadyProcessed: true,
            shouldProcess: true,
            existingRecord: {
              processingStatus: existingRecord.processingStatus as EventProcessingStatus,
              retryCount: existingRecord.retryCount,
              processedAt: existingRecord.processedAt
            }
          };
        }

        return {
          alreadyProcessed: true,
          shouldProcess: false,
          existingRecord: {
            processingStatus: existingRecord.processingStatus as EventProcessingStatus,
            retryCount: existingRecord.retryCount,
            processedAt: existingRecord.processedAt
          }
        };
      }

      return {
        alreadyProcessed: false,
        shouldProcess: true
      };
    } catch (error) {
      console.error('Error checking idempotency:', error);
      // On error, allow processing to proceed (fail-safe)
      return {
        alreadyProcessed: false,
        shouldProcess: true
      };
    }
  }

  /**
   * Mark event as processing
   */
  async markAsProcessing(event: ReliableEventMessage): Promise<void> {
    try {
      await this.prisma.eventIdempotency.create({
        data: {
          idempotencyKey: event.idempotencyKey,
          eventType: event.type,
          eventId: event.id,
          aggregateId: event.aggregateId,
          processingStatus: 'PROCESSING',
          metadata: event.metadata
        }
      });
    } catch (error: any) {
      // If record already exists, update it
      if (error.code === 'P2002') {
        await this.prisma.eventIdempotency.update({
          where: {
            idempotencyKey: event.idempotencyKey
          },
          data: {
            processingStatus: 'PROCESSING',
            lastRetryAt: new Date()
          }
        });
      } else {
        throw error;
      }
    }
  }

  /**
   * Mark event as completed
   */
  async markAsCompleted(event: ReliableEventMessage, metadata?: any): Promise<void> {
    await this.prisma.eventIdempotency.update({
      where: {
        idempotencyKey: event.idempotencyKey
      },
      data: {
        processingStatus: 'COMPLETED',
        processedAt: new Date(),
        metadata: metadata ? { ...event.metadata, ...metadata } : event.metadata
      }
    });
  }

  /**
   * Mark event as failed
   */
  async markAsFailed(event: ReliableEventMessage, error: Error): Promise<void> {
    const existingRecord = await this.prisma.eventIdempotency.findUnique({
      where: {
        idempotencyKey: event.idempotencyKey
      }
    });

    await this.prisma.eventIdempotency.update({
      where: {
        idempotencyKey: event.idempotencyKey
      },
      data: {
        processingStatus: 'FAILED',
        retryCount: (existingRecord?.retryCount || 0) + 1,
        lastRetryAt: new Date(),
        metadata: {
          ...event.metadata,
          error: {
            message: error.message,
            stack: error.stack,
            name: error.name
          }
        }
      }
    });
  }

  /**
   * Mark event as skipped
   */
  async markAsSkipped(event: ReliableEventMessage, reason: string): Promise<void> {
    await this.prisma.eventIdempotency.update({
      where: {
        idempotencyKey: event.idempotencyKey
      },
      data: {
        processingStatus: 'SKIPPED',
        metadata: {
          ...event.metadata,
          skipReason: reason
        }
      }
    });
  }

  /**
   * Consume event with idempotency check
   */
  async consumeEvent(
    event: ReliableEventMessage,
    handler: (event: ReliableEventMessage) => Promise<void>
  ): Promise<EventProcessingResult> {
    const startTime = Date.now();

    try {
      // Check idempotency
      const idempotencyCheck = await this.checkIdempotency(event);

      if (!idempotencyCheck.shouldProcess) {
        console.log(`Event ${event.idempotencyKey} already processed or in progress, skipping`);
        await this.markAsSkipped(event, 'Already processed or in progress');
        return {
          success: true,
          processingTime: Date.now() - startTime
        };
      }

      // Mark as processing
      await this.markAsProcessing(event);

      // Execute event handler
      await handler(event);

      // Mark as completed
      await this.markAsCompleted(event);

      return {
        success: true,
        processingTime: Date.now() - startTime
      };
    } catch (error) {
      // Mark as failed
      await this.markAsFailed(event, error as Error);

      return {
        success: false,
        error: error as Error,
        processingTime: Date.now() - startTime
      };
    }
  }

  /**
   * Clean up old idempotency records (maintenance)
   */
  async cleanupOldRecords(daysToKeep: number = 30): Promise<number> {
    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - daysToKeep);

    const result = await this.prisma.eventIdempotency.deleteMany({
      where: {
        processedAt: {
          lt: cutoffDate
        },
        processingStatus: 'COMPLETED'
      }
    });

    return result.count;
  }

  /**
   * Get statistics
   */
  async getStatistics(): Promise<{
    total: number;
    pending: number;
    processing: number;
    completed: number;
    failed: number;
    skipped: number;
  }> {
    const [total, pending, processing, completed, failed, skipped] = await Promise.all([
      this.prisma.eventIdempotency.count(),
      this.prisma.eventIdempotency.count({ where: { processingStatus: 'PENDING' } }),
      this.prisma.eventIdempotency.count({ where: { processingStatus: 'PROCESSING' } }),
      this.prisma.eventIdempotency.count({ where: { processingStatus: 'COMPLETED' } }),
      this.prisma.eventIdempotency.count({ where: { processingStatus: 'FAILED' } }),
      this.prisma.eventIdempotency.count({ where: { processingStatus: 'SKIPPED' } })
    ]);

    return {
      total,
      pending,
      processing,
      completed,
      failed,
      skipped
    };
  }
}

// Singleton instance
export const idempotentEventConsumer = new IdempotentEventConsumer();
