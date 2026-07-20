/**
 * Caching Layer
 * Provides distributed caching with Redis support and local fallback
 */

export interface CacheConfig {
  enabled: boolean;
  ttl: number; // Default time-to-live in seconds
  maxSize?: number; // Maximum number of items for local cache
  redisUrl?: string;
  redisPrefix?: string;
}

export interface CacheEntry<T> {
  value: T;
  expiresAt: number;
  createdAt: number;
  hits: number;
  metadata?: Record<string, any>;
}

class CacheService {
  private config: CacheConfig;
  private localCache: Map<string, CacheEntry<any>> = new Map();
  private stats = {
    hits: 0,
    misses: 0,
    sets: 0,
    deletes: 0,
    evictions: 0
  };

  constructor(config: CacheConfig) {
    this.config = config;
    if (config.enabled) {
      this.initializeCache();
    }
  }

  /**
   * Initialize cache
   */
  private initializeCache() {
    console.log('[Cache] Initializing cache service');
    
    // In production, this would connect to Redis
    // For now, we'll use local in-memory cache
    
    // Start cleanup interval
    setInterval(() => this.cleanupExpiredEntries(), 60000); // Every minute
    
    console.log('[Cache] Cache service initialized');
  }

  /**
   * Get value from cache
   */
  async get<T>(key: string): Promise<T | null> {
    if (!this.config.enabled) return null;

    const entry = this.localCache.get(this.normalizeKey(key));
    
    if (!entry) {
      this.stats.misses++;
      return null;
    }

    // Check if expired
    if (Date.now() > entry.expiresAt) {
      this.localCache.delete(this.normalizeKey(key));
      this.stats.misses++;
      return null;
    }

    entry.hits++;
    this.stats.hits++;
    
    return entry.value as T;
  }

  /**
   * Set value in cache
   */
  async set<T>(key: string, value: T, ttl?: number): Promise<void> {
    if (!this.config.enabled) return;

    const normalizedKey = this.normalizeKey(key);
    const entryTtl = ttl || this.config.ttl;
    
    const entry: CacheEntry<T> = {
      value,
      expiresAt: Date.now() + (entryTtl * 1000),
      createdAt: Date.now(),
      hits: 0
    };

    // Check if we need to evict entries
    if (this.config.maxSize && this.localCache.size >= this.config.maxSize) {
      this.evictLRU();
    }

    this.localCache.set(normalizedKey, entry);
    this.stats.sets++;
  }

  /**
   * Delete value from cache
   */
  async delete(key: string): Promise<void> {
    if (!this.config.enabled) return;

    this.localCache.delete(this.normalizeKey(key));
    this.stats.deletes++;
  }

  /**
   * Check if key exists
   */
  async has(key: string): Promise<boolean> {
    if (!this.config.enabled) return false;

    const entry = this.localCache.get(this.normalizeKey(key));
    
    if (!entry) return false;
    
    // Check if expired
    if (Date.now() > entry.expiresAt) {
      this.localCache.delete(this.normalizeKey(key));
      return false;
    }

    return true;
  }

  /**
   * Get or set value (cache-aside pattern)
   */
  async getOrSet<T>(
    key: string,
    factory: () => Promise<T>,
    ttl?: number
  ): Promise<T> {
    const cached = await this.get<T>(key);
    
    if (cached !== null) {
      return cached;
    }

    const value = await factory();
    await this.set(key, value, ttl);
    
    return value;
  }

  /**
   * Get multiple values
   */
  async getMany<T>(keys: string[]): Promise<Map<string, T>> {
    const results = new Map<string, T>();
    
    for (const key of keys) {
      const value = await this.get<T>(key);
      if (value !== null) {
        results.set(key, value);
      }
    }

    return results;
  }

  /**
   * Set multiple values
   */
  async setMany<T>(entries: Map<string, T>, ttl?: number): Promise<void> {
    for (const [key, value] of entries.entries()) {
      await this.set(key, value, ttl);
    }
  }

  /**
   * Delete multiple keys
   */
  async deleteMany(keys: string[]): Promise<void> {
    for (const key of keys) {
      await this.delete(key);
    }
  }

  /**
   * Clear all cache entries
   */
  async clear(): Promise<void> {
    this.localCache.clear();
    console.log('[Cache] Cache cleared');
  }

  /**
   * Clear cache entries matching pattern
   */
  async clearPattern(pattern: string): Promise<void> {
    const regex = new RegExp(pattern.replace('*', '.*'));
    
    for (const key of this.localCache.keys()) {
      if (regex.test(key)) {
        this.localCache.delete(key);
      }
    }
  }

  /**
   * Get cache statistics
   */
  getStats() {
    const hitRate = this.stats.hits + this.stats.misses > 0
      ? (this.stats.hits / (this.stats.hits + this.stats.misses)) * 100
      : 0;

    return {
      ...this.stats,
      hitRate: hitRate.toFixed(2) + '%',
      size: this.localCache.size,
      maxSize: this.config.maxSize,
      memoryUsage: this.getMemoryUsage()
    };
  }

  /**
   * Get memory usage estimate
   */
  private getMemoryUsage(): string {
    let totalSize = 0;
    
    for (const entry of this.localCache.values()) {
      totalSize += JSON.stringify(entry).length;
    }

    return (totalSize / 1024 / 1024).toFixed(2) + ' MB';
  }

  /**
   * Normalize cache key
   */
  private normalizeKey(key: string): string {
    const prefix = this.config.redisPrefix || 'reservatior';
    return `${prefix}:${key}`;
  }

  /**
   * Evict least recently used entry
   */
  private evictLRU() {
    let lruKey: string | null = null;
    let lruHits = Infinity;

    for (const [key, entry] of this.localCache.entries()) {
      if (entry.hits < lruHits) {
        lruHits = entry.hits;
        lruKey = key;
      }
    }

    if (lruKey) {
      this.localCache.delete(lruKey);
      this.stats.evictions++;
    }
  }

  /**
   * Cleanup expired entries
   */
  private cleanupExpiredEntries() {
    const now = Date.now();
    let cleaned = 0;

    for (const [key, entry] of this.localCache.entries()) {
      if (now > entry.expiresAt) {
        this.localCache.delete(key);
        cleaned++;
      }
    }

    if (cleaned > 0) {
      console.log(`[Cache] Cleaned up ${cleaned} expired entries`);
    }
  }

  /**
   * Warm up cache with initial data
   */
  async warmUp<T>(entries: Map<string, T>, ttl?: number): Promise<void> {
    console.log(`[Cache] Warming up cache with ${entries.size} entries`);
    await this.setMany(entries, ttl);
  }

  /**
   * Create a cached function wrapper
   */
  cachedFunction<T extends (...args: any[]) => Promise<any>>(
    keyGenerator: (...args: Parameters<T>) => string,
    fn: T,
    ttl?: number
  ): T {
    return (async (...args: Parameters<T>) => {
      const key = keyGenerator(...args);
      return this.getOrSet(key, () => fn(...args), ttl);
    }) as T;
  }

  /**
   * Invalidate cache by tag
   */
  async invalidateByTag(tag: string): Promise<void> {
    await this.clearPattern(`*:${tag}:*`);
  }

  /**
   * Get cache keys matching pattern
   */
  async keys(pattern: string): Promise<string[]> {
    const regex = new RegExp(pattern.replace('*', '.*'));
    return Array.from(this.localCache.keys()).filter(key => regex.test(key));
  }
}

// Initialize cache service
const cacheConfig: CacheConfig = {
  enabled: process.env.CACHE_ENABLED !== 'false',
  ttl: 300, // 5 minutes default
  maxSize: 10000, // Maximum 10,000 entries
  redisUrl: process.env.REDIS_URL,
  redisPrefix: 'reservatior'
};

export const cacheService = new CacheService(cacheConfig);
