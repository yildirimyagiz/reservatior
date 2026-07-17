import { EventEmitter } from 'events';
import { v4 as uuidv4 } from 'uuid';
import { DomainEvent, EventMessage, DomainEvents } from './domain-events';
import { rabbitMQService } from "../../services/rabbitmq-service";
import { WebhookService } from "../webhooks/webhook-service";
import { prismaManager } from '../../lib/prisma';

/**
 * EventBus - The Central Nervous System for OS Modules
 * Supports direct domain event dispatching and wildcard subscriptions.
 */
class CoreEventBus {
  private localEmitter = new EventEmitter();

  constructor() {
    this.localEmitter.setMaxListeners(100);
  }

  /**
   * Publish a strongly-typed domain event.
   * NOTE: In a Transactional Outbox pattern, you usually don't call this directly 
   * from the business logic. Instead, the business logic inserts into `EventLog`
   * within a DB transaction, and the `OutboxWorker` calls this method.
   */
  public async publish<T = any>(
    type: DomainEvent | string, 
    payload: T, 
    source: string,
    correlationId?: string
  ): Promise<void> {
    const message: EventMessage<T> = {
      id: uuidv4(),
      type: type as DomainEvent,
      timestamp: new Date(),
      payload,
      source,
      correlationId
    };

    console.log(`[EventBus] 🚀 Publishing: ${type} (Source: ${source})`);

    // 1. Emit locally (for Saga/Workflows running in same Node process)
    this.localEmitter.emit(type, message);
    
    // Also emit wildcard for domain-level listeners (e.g. "agent.*")
    const domainPrefix = type.split('.')[0];
    this.localEmitter.emit(`${domainPrefix}.*`, message);
    this.localEmitter.emit(`*`, message);

    // 2. Try RabbitMQ if distributed
    try {
      if (rabbitMQService.isConnected) {
        await rabbitMQService.publishToQueue(type as any, message);
      }
    } catch (err) {
      console.warn(`[EventBus] RabbitMQ publish failed for ${type}. Relied on local bus.`);
    }

    // 3. Trigger Webhooks for external consumers
    const orgId = (payload as any)?.orgId || (payload as any)?.organizationId;
    if (orgId) {
      WebhookService.dispatch(type as any, payload, orgId).catch(err => 
        console.error(`[EventBus] Webhook dispatch error:`, err)
      );
    }
  }

  /**
   * Subscribe to a specific domain event or wildcard
   */
  public subscribe<T = any>(type: DomainEvent | string, handler: (msg: EventMessage<T>) => void | Promise<void>) {
    console.log(`[EventBus] 🎧 Subscribed to: ${type}`);
    this.localEmitter.on(type, async (message) => {
      try {
        await handler(message);
      } catch (err) {
        console.error(`[EventBus] Error in handler for ${type}:`, err);
      }
    });
  }
}

export const eventBus = new CoreEventBus();
