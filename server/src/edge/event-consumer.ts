/**
 * VPS Edge Event Consumer
 * 
 * Subscribes to Google Cloud Pub/Sub topics and updates country databases
 * NO AI processing on VPS - only database updates and UI notifications
 */

import { EventFactory, EventEnvelope } from '../events/base/event-envelope';
import { databaseRouter } from '../database/database-router';
import { eventConsumerIntegration } from './event-consumer-integration';

export class EdgeEventConsumer {
  private projectId: string;
  private subscriptionPrefix: string;
  private subscriptions: Map<string, any>;

  constructor() {
    this.projectId = process.env.GCP_PROJECT_ID || 'reservatior-prod';
    this.subscriptionPrefix = process.env.GCP_PUBSUB_SUBSCRIPTION_PREFIX || 'reservatior-prod';
    this.subscriptions = new Map();
  }

  /**
   * Subscribe to a Google Cloud Pub/Sub topic
   */
  async subscribe(topicName: string, handler: (event: EventEnvelope) => Promise<any>) {
    const subscriptionName = `${this.subscriptionPrefix}-${topicName}-sub`;
    
    console.log(`[EdgeEventConsumer] Subscribing to: ${subscriptionName}`);

    // TODO: Implement actual Pub/Sub subscription
    // const { PubSub } = require('@google-cloud/pubsub');
    // const pubsub = new PubSub({ projectId: this.projectId });
    // const subscription = pubsub.subscription(subscriptionName);
    
    // subscription.on('message', async (message) => {
    //   try {
    //     const event = EventFactory.parseEvent(message.data.toString());
    //     await handler(event);
    //     message.ack();
    //   } catch (error) {
    //     console.error(`[EdgeEventConsumer] Error processing message:`, error);
    //     message.nack();
    //   }
    // });

    this.subscriptions.set(topicName, { subscriptionName, handler });
    
    return {
      success: true,
      subscription: subscriptionName
    };
  }

  /**
   * Handle event via integration layer
   */
  async handleEvent(event: EventEnvelope) {
    return await eventConsumerIntegration.routeEvent(event);
  }

  /**
   * Start all subscriptions
   */
  async startAll() {
    // Subscribe to all event types handled by integration layer
    const integrationStatus = eventConsumerIntegration.getStatus();
    
    for (const eventType of integrationStatus.handlers) {
      await this.subscribe(eventType, this.handleEvent.bind(this));
    }
    
    console.log(`[EdgeEventConsumer] All subscriptions started (${this.subscriptions.size} subscriptions)`);
  }

  /**
   * Get subscription status
   */
  getStatus() {
    return {
      activeSubscriptions: this.subscriptions.size,
      subscriptions: Array.from(this.subscriptions.keys()),
      projectId: this.projectId,
      subscriptionPrefix: this.subscriptionPrefix,
      integrationStatus: eventConsumerIntegration.getStatus()
    };
  }
}

export const edgeEventConsumer = new EdgeEventConsumer();
