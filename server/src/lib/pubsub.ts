/**
 * Google Cloud Pub/Sub Manager — Singleton client with graceful fallback
 *
 * If GCP_PROJECT_ID is not set, all publish/subscribe operations silently no-op.
 * Provides typed publish/subscribe with JSON serialization.
 */
import { PubSub, Topic, Subscription } from '@google-cloud/pubsub';

class PubSubManager {
  private static client: PubSub | null = null;
  private static topics = new Map<string, Topic>();
  private static subscriptions = new Map<string, Subscription>();

  static getClient(): PubSub | null {
    const projectId = process.env.GCP_PROJECT_ID;
    if (!projectId) return null;

    if (!this.client) {
      this.client = new PubSub({ projectId });
      console.log('[PubSub] Client initialized');
    }

    return this.client;
  }

  static getTopic(topicName: string): Topic | null {
    const client = this.getClient();
    if (!client) return null;

    if (!this.topics.has(topicName)) {
      this.topics.set(topicName, client.topic(topicName));
    }

    return this.topics.get(topicName) ?? null;
  }

  static async publish(topicName: string, data: Record<string, any>): Promise<string | null> {
    const topic = this.getTopic(topicName);
    if (!topic) return null;

    try {
      const messageId = await topic.publishMessage({
        data: Buffer.from(JSON.stringify(data)),
      });
      console.log(`[PubSub] Published to ${topicName}: ${messageId}`);
      return messageId;
    } catch (err) {
      console.error(`[PubSub] Publish error to ${topicName}:`, err);
      return null;
    }
  }

  static async subscribe(
    topicName: string,
    subscriptionName: string,
    handler: (data: Record<string, any>) => Promise<void>,
  ): Promise<void> {
    const client = this.getClient();
    if (!client) return;

    const key = `${topicName}:${subscriptionName}`;
    if (this.subscriptions.has(key)) return;

    try {
      const topic = client.topic(topicName);
      const [subscription] = await topic.subscription(subscriptionName).get({ autoCreate: true });

      subscription.on('message', async (message) => {
        try {
          const data = JSON.parse(message.data.toString());
          await handler(data);
          message.ack();
        } catch (err) {
          console.error(`[PubSub] Message handler error:`, err);
          message.nack();
        }
      });

      subscription.on('error', (err) => {
        console.error(`[PubSub] Subscription error:`, err);
      });

      this.subscriptions.set(key, subscription);
      console.log(`[PubSub] Subscribed to ${topicName} as ${subscriptionName}`);
    } catch (err) {
      console.error(`[PubSub] Subscribe error:`, err);
    }
  }

  static async disconnect(): Promise<void> {
    for (const [, sub] of this.subscriptions) {
      await sub.close().catch(() => {});
    }
    this.subscriptions.clear();
    this.topics.clear();

    if (this.client) {
      await this.client.close().catch(() => {});
      this.client = null;
    }
  }
}

export const pubsub = PubSubManager;
