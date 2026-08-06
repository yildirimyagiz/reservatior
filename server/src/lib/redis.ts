/**
 * Redis Manager — Singleton Redis client with graceful fallback
 *
 * If REDIS_URL is not set, all operations silently no-op.
 * Provides typed get/set/del with JSON serialization.
 */
import Redis from 'ioredis';

class RedisManager {
  private static instance: Redis | null = null;
  private static connecting = false;

  static getClient(): Redis | null {
    const url = process.env.REDIS_URL;
    if (!url) return null;

    if (!this.instance) {
      this.instance = new Redis(url, {
        maxRetriesPerRequest: 3,
        retryStrategy(times) {
          if (times > 3) return null;
          return Math.min(times * 200, 2000);
        },
        lazyConnect: true,
        enableReadyCheck: true,
      });

      this.instance.on('error', (err) => {
        console.error('[Redis] Connection error:', err.message);
      });

      this.instance.on('connect', () => {
        console.log('[Redis] Connected');
      });

      if (!this.connecting) {
        this.connecting = true;
        this.instance.connect().catch(() => {
          this.connecting = false;
        });
      }
    }

    return this.instance;
  }

  static async get<T = any>(key: string): Promise<T | null> {
    const client = this.getClient();
    if (!client) return null;

    try {
      const data = await client.get(key);
      if (!data) return null;
      return JSON.parse(data) as T;
    } catch {
      return null;
    }
  }

  static async set(key: string, value: unknown, ttlSeconds = 3600): Promise<void> {
    const client = this.getClient();
    if (!client) return;

    try {
      await client.set(key, JSON.stringify(value), 'EX', ttlSeconds);
    } catch (err) {
      console.error('[Redis] Set error:', err);
    }
  }

  static async del(...keys: string[]): Promise<void> {
    const client = this.getClient();
    if (!client || keys.length === 0) return;

    try {
      await client.del(...keys);
    } catch (err) {
      console.error('[Redis] Del error:', err);
    }
  }

  static async delPattern(pattern: string): Promise<void> {
    const client = this.getClient();
    if (!client) return;

    try {
      const keys = await client.keys(pattern);
      if (keys.length > 0) await client.del(...keys);
    } catch (err) {
      console.error('[Redis] DelPattern error:', err);
    }
  }

  static async incr(key: string, ttlSeconds = 3600): Promise<number> {
    const client = this.getClient();
    if (!client) return 0;

    try {
      const val = await client.incr(key);
      if (val === 1) await client.expire(key, ttlSeconds);
      return val;
    } catch {
      return 0;
    }
  }

  static async disconnect(): Promise<void> {
    if (this.instance) {
      await this.instance.quit().catch(() => {});
      this.instance = null;
      this.connecting = false;
    }
  }
}

export const redis = RedisManager;
