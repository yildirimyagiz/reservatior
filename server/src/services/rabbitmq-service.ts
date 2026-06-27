import * as amqp from 'amqplib';
import { ChannelModel, Channel, ConsumeMessage } from 'amqplib';
import { EventEmitter } from 'events';

export const LOCAL_EVENT_BUS = new EventEmitter();

export class RabbitMQService {
  private static instance: RabbitMQService;
  private connection: ChannelModel | null = null;
  private channel: Channel | null = null;
  private readonly RABBITMQ_URL = process.env.RABBITMQ_URL || 'amqp://localhost';
  public isConnected = false;

  private constructor() {}

  public static getInstance(): RabbitMQService {
    if (!RabbitMQService.instance) {
      RabbitMQService.instance = new RabbitMQService();
    }
    return RabbitMQService.instance;
  }

  public async connect(): Promise<void> {
    if (this.connection && this.channel) return;

    try {
      const conn = await amqp.connect(this.RABBITMQ_URL);
      this.connection = conn;
      this.channel = await conn.createChannel();
      console.log('[RabbitMQ] Successfully connected and channel created.');

      conn.on('error', (err: any) => {
        console.error('[RabbitMQ] Connection error:', err);
        this.connection = null;
        this.channel = null;
        this.isConnected = false;
      });

      conn.on('close', () => {
        console.log('[RabbitMQ] Connection closed.');
        this.connection = null;
        this.channel = null;
        this.isConnected = false;
      });
      this.isConnected = true;
    } catch (error) {
      console.warn('[RabbitMQ] Connection failed. Falling back to In-Memory Event Bus.');
      this.isConnected = false;
      // Do not throw error, allow graceful degradation
    }
  }

  public async publishToQueue(queueName: string, data: any): Promise<boolean> {
    try {
      if (!this.isConnected && !this.channel) {
        // Fallback
        LOCAL_EVENT_BUS.emit(queueName, data);
        return true;
      }
      
      if (!this.channel) await this.connect();
      if (!this.channel) {
         LOCAL_EVENT_BUS.emit(queueName, data);
         return true;
      }

      await this.channel.assertQueue(queueName, { durable: true });
      return this.channel.sendToQueue(queueName, Buffer.from(JSON.stringify(data)), {
        persistent: true,
      });
    } catch (error) {
      console.error(`[RabbitMQ] Error publishing to queue ${queueName}:`, error);
      return false;
    }
  }

  public async consumeQueue(queueName: string, callback: (msg: ConsumeMessage | null, parsedData: any) => Promise<void>): Promise<void> {
    try {
      if (!this.isConnected && !this.channel) {
         console.log(`[EventBus] Listening to local in-memory queue: ${queueName}`);
         LOCAL_EVENT_BUS.on(queueName, async (data) => {
            await callback(null, data);
         });
         return;
      }

      if (!this.channel) await this.connect();
      if (!this.channel) {
         console.log(`[EventBus] Listening to local in-memory queue: ${queueName}`);
         LOCAL_EVENT_BUS.on(queueName, async (data) => {
            await callback(null, data);
         });
         return;
      }

      await this.channel.assertQueue(queueName, { durable: true });
      this.channel.prefetch(1); // Process 1 message at a time
      
      console.log(`[RabbitMQ] Listening to queue: ${queueName}`);
      this.channel.consume(queueName, async (msg) => {
        if (msg !== null) {
          try {
            const data = JSON.parse(msg.content.toString());
            await callback(msg, data);
            this.channel?.ack(msg);
          } catch (error) {
            console.error(`[RabbitMQ] Error processing message from ${queueName}:`, error);
            // Optionally nack or reject the message
            this.channel?.nack(msg, false, false); // false, false means don't requeue if unrecoverable error
          }
        }
      });
    } catch (error) {
      console.error(`[RabbitMQ] Error consuming queue ${queueName}:`, error);
    }
  }

  public async close(): Promise<void> {
    try {
      if (this.channel) await this.channel.close();
      if (this.connection) await this.connection.close();
    } catch (error) {
      console.error('[RabbitMQ] Error closing connection:', error);
    }
  }
}

export const rabbitMQService = RabbitMQService.getInstance();
