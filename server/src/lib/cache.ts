/**
 * Redis Caching Layer
 * Provides O(1) cache access for hot data
 * Performance target: < 50ms cache hit latency
 */

import Redis from 'ioredis';

const redisUrl = process.env.REDIS_URL || 'redis://localhost:6379';
const redis = new Redis(redisUrl, {
  maxRetriesPerRequest: 3,
  retryStrategy: (times) => {
    const delay = Math.min(times * 50, 2000);
    return delay;
  },
});

redis.on('error', (err) => {
  console.error('[Cache] Redis error:', err);
});

redis.on('connect', () => {
  console.log('[Cache] Redis connected');
});

export interface CacheOptions {
  ttl?: number; // Time to live in seconds (default: 3600 = 1 hour)
}

/**
 * Cache property preview data
 * Key: property:preview:{propertyId}
 * TTL: 1 hour (3600s)
 */
export async function cachePropertyPreview(
  propertyId: string,
  data: any,
  options: CacheOptions = {}
): Promise<void> {
  const key = `property:preview:${propertyId}`;
  const ttl = options.ttl || 3600;
  await redis.setex(key, ttl, JSON.stringify(data));
  console.log(`[Cache] Cached property preview: ${propertyId}`);
}

/**
 * Get cached property preview data
 */
export async function getCachedPropertyPreview(
  propertyId: string
): Promise<any | null> {
  const key = `property:preview:${propertyId}`;
  const cached = await redis.get(key);
  if (cached) {
    console.log(`[Cache] Hit for property preview: ${propertyId}`);
    return JSON.parse(cached);
  }
  console.log(`[Cache] Miss for property preview: ${propertyId}`);
  return null;
}

/**
 * Invalidate property preview cache
 */
export async function invalidatePropertyPreview(propertyId: string): Promise<void> {
  const key = `property:preview:${propertyId}`;
  await redis.del(key);
  console.log(`[Cache] Invalidated property preview: ${propertyId}`);
}

/**
 * Cache token validation result
 * Key: token:validation:{tokenHash}
 * TTL: 5 minutes (300s) for security
 */
export async function cacheTokenValidation(
  tokenHash: string,
  isValid: boolean,
  userId?: string
): Promise<void> {
  const key = `token:validation:${tokenHash}`;
  const data = JSON.stringify({ isValid, userId, timestamp: Date.now() });
  await redis.setex(key, 300, data);
}

/**
 * Get cached token validation
 */
export async function getCachedTokenValidation(
  tokenHash: string
): Promise<{ isValid: boolean; userId?: string; timestamp: number } | null> {
  const key = `token:validation:${tokenHash}`;
  const cached = await redis.get(key);
  if (cached) {
    return JSON.parse(cached);
  }
  return null;
}

/**
 * Cache session data
 * Key: session:{sessionId}
 * TTL: 7 days (604800s)
 */
export async function cacheSession(
  sessionId: string,
  data: any
): Promise<void> {
  const key = `session:${sessionId}`;
  await redis.setex(key, 604800, JSON.stringify(data));
}

/**
 * Get cached session data
 */
export async function getCachedSession(sessionId: string): Promise<any | null> {
  const key = `session:${sessionId}`;
  const cached = await redis.get(key);
  if (cached) {
    return JSON.parse(cached);
  }
  return null;
}

/**
 * Delete session
 */
export async function deleteSession(sessionId: string): Promise<void> {
  const key = `session:${sessionId}`;
  await redis.del(key);
}

/**
 * Generic cache set
 */
export async function cacheSet(
  key: string,
  value: any,
  ttl: number = 3600
): Promise<void> {
  await redis.setex(key, ttl, JSON.stringify(value));
}

/**
 * Generic cache get
 */
export async function cacheGet<T = any>(key: string): Promise<T | null> {
  const cached = await redis.get(key);
  if (cached) {
    return JSON.parse(cached) as T;
  }
  return null;
}

/**
 * Generic cache delete
 */
export async function cacheDelete(key: string): Promise<void> {
  await redis.del(key);
}

/**
 * Cache multiple keys at once (pipeline)
 */
export async function cacheSetBatch(
  items: Array<{ key: string; value: any; ttl?: number }>
): Promise<void> {
  const pipeline = redis.pipeline();
  items.forEach(({ key, value, ttl = 3600 }) => {
    pipeline.setex(key, ttl, JSON.stringify(value));
  });
  await pipeline.exec();
}

/**
 * Get cache statistics
 */
export async function getCacheStats(): Promise<{
  keys: number;
  memory: string;
  hitRate: number;
}> {
  const info = await redis.info('stats');
  const keys = await redis.dbsize();
  const memory = await redis.info('memory');
  
  // Parse hit rate from info
  const hitRateMatch = info.match(/keyspace_hits:(\d+)/);
  const hitRateMissMatch = info.match(/keyspace_misses:(\d+)/);
  const hits = hitRateMatch ? parseInt(hitRateMatch[1]) : 0;
  const misses = hitRateMissMatch ? parseInt(hitRateMissMatch[1]) : 0;
  const hitRate = hits + misses > 0 ? hits / (hits + misses) : 0;

  return {
    keys,
    memory: memory.split('\n')[1]?.split(':')[1]?.trim() || 'unknown',
    hitRate,
  };
}

/**
 * Flush all cache (use with caution)
 */
export async function flushCache(): Promise<void> {
  await redis.flushall();
  console.log('[Cache] Cache flushed');
}

/**
 * Close Redis connection
 */
export async function closeCache(): Promise<void> {
  await redis.quit();
  console.log('[Cache] Redis connection closed');
}

export default redis;
