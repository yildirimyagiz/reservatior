import { prismaManager } from '../../lib/prisma';
import { eventBus } from './event-bus';

export class OutboxWorker {
  private isPolling = false;
  private intervalId: NodeJS.Timer | null = null;
  private pollIntervalMs: number;

  constructor(pollIntervalMs: number = 2000) {
    this.pollIntervalMs = pollIntervalMs;
  }

  public start() {
    console.log(`[OutboxWorker] Started polling for PENDING EventLogs every ${this.pollIntervalMs}ms...`);
    this.isPolling = true;
    this.poll();
  }

  public stop() {
    this.isPolling = false;
    if (this.intervalId) {
      clearTimeout(this.intervalId as any);
    }
    console.log(`[OutboxWorker] Stopped.`);
  }

  private async poll() {
    if (!this.isPolling) return;

    try {
      await this.processOutbox();
    } catch (err) {
      console.error(`[OutboxWorker] Polling error:`, err);
    } finally {
      if (this.isPolling) {
        this.intervalId = setTimeout(() => this.poll(), this.pollIntervalMs);
      }
    }
  }

  private async processOutbox() {
    // Note: We use USA prisma as the primary event bus DB for this demo.
    // In a multi-tenant DB, you'd iterate over regions or use a central EventBus DB.
    const prisma = prismaManager.getClient('US');

    // Find up to 50 pending events
    const pendingEvents = await prisma.eventLog.findMany({
      where: { status: 'PENDING' },
      take: 50,
      orderBy: { createdAt: 'asc' }
    });

    if (pendingEvents.length === 0) return;

    console.log(`[OutboxWorker] Found ${pendingEvents.length} PENDING events in Outbox.`);

    for (const event of pendingEvents) {
      try {
        // Publish to EventBus
        await eventBus.publish(
          event.eventType, 
          event.payload, 
          event.aggregateType, // e.g. "AgentOS"
          event.aggregateId
        );

        // Mark as processed
        await prisma.eventLog.update({
          where: { id: event.id },
          data: {
            status: 'PROCESSED',
            processedAt: new Date()
          }
        });
      } catch (err: any) {
        console.error(`[OutboxWorker] Failed to process event ${event.id}:`, err);
        // Increment retry count or mark as FAILED
        await prisma.eventLog.update({
          where: { id: event.id },
          data: {
            retryCount: { increment: 1 },
            error: err.message,
            status: event.retryCount >= 3 ? 'FAILED' : 'PENDING'
          }
        });
      }
    }
  }
}
