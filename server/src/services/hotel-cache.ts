/**
 * Hotel API Response Cache
 *
 * In-memory LRU cache for B2B hotel search results to reduce API calls
 * and improve response times for repeat searches.
 */

interface CacheEntry<T> {
  data: T;
  expiresAt: number;
}

export class HotelResponseCache {
  private cache = new Map<string, CacheEntry<any>>();
  private maxSize: number;
  private defaultTTLMs: number;

  constructor(maxSize: number = 1000, defaultTTLSeconds: number = 300) {
    this.maxSize = maxSize;
    this.defaultTTLMs = defaultTTLSeconds * 1000;
  }

  get<T>(key: string): T | null {
    const entry = this.cache.get(key);
    if (!entry) return null;
    if (Date.now() > entry.expiresAt) {
      this.cache.delete(key);
      return null;
    }
    return entry.data as T;
  }

  set<T>(key: string, data: T, ttlMs?: number): void {
    if (this.cache.size >= this.maxSize) {
      const oldestKey = this.cache.keys().next().value;
      if (oldestKey) this.cache.delete(oldestKey);
    }
    this.cache.set(key, {
      data,
      expiresAt: Date.now() + (ttlMs ?? this.defaultTTLMs),
    });
  }

  buildKey(destination: string, checkIn: string, checkOut: string, guests: number): string {
    return `${destination}|${checkIn}|${checkOut}|${guests}`;
  }

  invalidate(destination?: string): void {
    if (!destination) {
      this.cache.clear();
      return;
    }
    for (const key of this.cache.keys()) {
      if (key.startsWith(destination)) {
        this.cache.delete(key);
      }
    }
  }

  get size(): number {
    return this.cache.size;
  }
}

export const hotelCache = new HotelResponseCache(500, 300);
