// Cache utilities for frontend data management

// Simple in-memory cache
class MemoryCache {
  private cache = new Map<
    string,
    { data: any; timestamp: number; ttl: number }
  >();

  set(key: string, data: any, ttl: number = 300000): void {
    // Default TTL: 5 minutes
    this.cache.set(key, {
      data,
      timestamp: Date.now(),
      ttl,
    });
  }

  get(key: string): any | null {
    const item = this.cache.get(key);
    if (!item) return null;

    if (Date.now() - item.timestamp > item.ttl) {
      this.cache.delete(key);
      return null;
    }

    return item.data;
  }

  delete(key: string): boolean {
    return this.cache.delete(key);
  }

  clear(): void {
    this.cache.clear();
  }

  has(key: string): boolean {
    const item = this.cache.get(key);
    if (!item) return false;

    if (Date.now() - item.timestamp > item.ttl) {
      this.cache.delete(key);
      return false;
    }

    return true;
  }

  size(): number {
    return this.cache.size;
  }

  // Clean up expired entries
  cleanup(): void {
    const now = Date.now();
    for (const [key, item] of this.cache.entries()) {
      if (now - item.timestamp > item.ttl) {
        this.cache.delete(key);
      }
    }
  }
}

// LocalStorage cache with TTL support
class LocalStorageCache {
  private prefix: string;

  constructor(prefix: string = "cache_") {
    this.prefix = prefix;
  }

  private getKey(key: string): string {
    return `${this.prefix}${key}`;
  }

  set(key: string, data: any, ttl: number = 300000): void {
    try {
      const item = {
        data,
        timestamp: Date.now(),
        ttl,
      };
      localStorage.setItem(this.getKey(key), JSON.stringify(item));
    } catch (error) {
      console.warn("LocalStorage write failed:", error);
    }
  }

  get(key: string): any | null {
    try {
      const itemStr = localStorage.getItem(this.getKey(key));
      if (!itemStr) return null;

      const item = JSON.parse(itemStr);
      if (Date.now() - item.timestamp > item.ttl) {
        this.delete(key);
        return null;
      }

      return item.data;
    } catch (error) {
      console.warn("LocalStorage read failed:", error);
      return null;
    }
  }

  delete(key: string): void {
    localStorage.removeItem(this.getKey(key));
  }

  clear(): void {
    const keys = Object.keys(localStorage);
    keys.forEach((key) => {
      if (key.startsWith(this.prefix)) {
        localStorage.removeItem(key);
      }
    });
  }

  has(key: string): boolean {
    return this.get(key) !== null;
  }

  // Get cache size estimate
  size(): number {
    let size = 0;
    const keys = Object.keys(localStorage);
    keys.forEach((key) => {
      if (key.startsWith(this.prefix)) {
        size += localStorage.getItem(key)?.length || 0;
      }
    });
    return size;
  }

  // Clean up expired entries
  cleanup(): void {
    const keys = Object.keys(localStorage);
    keys.forEach((key) => {
      if (key.startsWith(this.prefix)) {
        const item = this.get(key.replace(this.prefix, ""));
        if (item === null) {
          localStorage.removeItem(key);
        }
      }
    });
  }
}

// IndexedDB cache for larger data
class IndexedDBCache {
  private dbName: string;
  private storeName: string;
  private db: IDBDatabase | null = null;

  constructor(dbName: string = "appCache", storeName: string = "cache") {
    this.dbName = dbName;
    this.storeName = storeName;
    this.init();
  }

  private async init(): Promise<void> {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open(this.dbName, 1);

      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        this.db = request.result;
        resolve();
      };

      request.onupgradeneeded = () => {
        const db = request.result;
        if (!db.objectStoreNames.contains(this.storeName)) {
          db.createObjectStore(this.storeName);
        }
      };
    });
  }

  private async ensureDB(): Promise<IDBDatabase> {
    if (!this.db) {
      await this.init();
    }
    return this.db!;
  }

  async set(key: string, data: any, ttl: number = 300000): Promise<void> {
    const db = await this.ensureDB();
    return new Promise((resolve, reject) => {
      const transaction = db.transaction([this.storeName], "readwrite");
      const store = transaction.objectStore(this.storeName);

      const item = {
        data,
        timestamp: Date.now(),
        ttl,
      };

      const request = store.put(item, key);
      request.onerror = () => reject(request.error);
      request.onsuccess = () => resolve();
    });
  }

  async get(key: string): Promise<any | null> {
    const db = await this.ensureDB();
    return new Promise((resolve, reject) => {
      const transaction = db.transaction([this.storeName], "readonly");
      const store = transaction.objectStore(this.storeName);

      const request = store.get(key);
      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        const item = request.result;
        if (!item) {
          resolve(null);
          return;
        }

        if (Date.now() - item.timestamp > item.ttl) {
          this.delete(key);
          resolve(null);
          return;
        }

        resolve(item.data);
      };
    });
  }

  async delete(key: string): Promise<void> {
    const db = await this.ensureDB();
    return new Promise((resolve, reject) => {
      const transaction = db.transaction([this.storeName], "readwrite");
      const store = transaction.objectStore(this.storeName);

      const request = store.delete(key);
      request.onerror = () => reject(request.error);
      request.onsuccess = () => resolve();
    });
  }

  async clear(): Promise<void> {
    const db = await this.ensureDB();
    return new Promise((resolve, reject) => {
      const transaction = db.transaction([this.storeName], "readwrite");
      const store = transaction.objectStore(this.storeName);

      const request = store.clear();
      request.onerror = () => reject(request.error);
      request.onsuccess = () => resolve();
    });
  }

  async has(key: string): Promise<boolean> {
    const data = await this.get(key);
    return data !== null;
  }

  // Clean up expired entries
  async cleanup(): Promise<void> {
    const db = await this.ensureDB();
    return new Promise((resolve, reject) => {
      const transaction = db.transaction([this.storeName], "readwrite");
      const store = transaction.objectStore(this.storeName);

      const request = store.openCursor();
      request.onerror = () => reject(request.error);
      request.onsuccess = (event) => {
        const cursor = (event.target as IDBRequest).result;
        if (cursor) {
          const item = cursor.value;
          if (Date.now() - item.timestamp > item.ttl) {
            cursor.delete();
          }
          cursor.continue();
        } else {
          resolve();
        }
      };
    });
  }
}

// Cache factory
export class CacheFactory {
  private static memoryCache = new MemoryCache();
  private static localStorageCache = new LocalStorageCache();
  private static indexedDBCache = new IndexedDBCache();

  static getCache(type: "memory" | "localStorage" | "indexedDB" = "memory") {
    switch (type) {
      case "memory":
        return this.memoryCache;
      case "localStorage":
        return this.localStorageCache;
      case "indexedDB":
        return this.indexedDBCache;
      default:
        return this.memoryCache;
    }
  }
}

// React hooks for caching
import { useState, useEffect, useCallback } from "react";

// Hook for cached data
export function useCachedData<T>(
  key: string,
  fetcher: () => Promise<T>,
  options: {
    ttl?: number;
    cacheType?: "memory" | "localStorage" | "indexedDB";
    dependencies?: any[];
    staleWhileRevalidate?: boolean;
  } = {}
) {
  const {
    ttl = 300000,
    cacheType = "memory",
    dependencies = [],
    staleWhileRevalidate = true,
  } = options;
  const cache = CacheFactory.getCache(cacheType);

  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const fetchData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      // Try to get from cache first
      const cachedData = cache.get(key);
      if (cachedData && staleWhileRevalidate) {
        setData(cachedData);
        setLoading(false);
      }

      // Fetch fresh data
      const freshData = await fetcher();
      cache.set(key, freshData, ttl);
      setData(freshData);
    } catch (err) {
      setError(err as Error);
    } finally {
      setLoading(false);
    }
  }, [key, fetcher, ttl, cache, staleWhileRevalidate]);

  useEffect(() => {
    // Check cache first
    const cachedData = cache.get(key);
    if (cachedData) {
      setData(cachedData);
      setLoading(false);
    } else {
      fetchData();
    }
  }, dependencies);

  const refetch = useCallback(() => {
    fetchData();
  }, [fetchData]);

  const invalidate = useCallback(() => {
    cache.delete(key);
    fetchData();
  }, [key, cache, fetchData]);

  return {
    data,
    loading,
    error,
    refetch,
    invalidate,
  };
}

// Hook for cached mutations
export function useCachedMutation<T, P>(
  key: string,
  mutator: (params: P) => Promise<T>,
  options: {
    ttl?: number;
    cacheType?: "memory" | "localStorage" | "indexedDB";
    invalidateOnSuccess?: boolean;
    optimisticUpdate?: boolean;
  } = {}
) {
  const {
    ttl = 300000,
    cacheType = "memory",
    invalidateOnSuccess = true,
    optimisticUpdate = false,
  } = options;
  const cache = CacheFactory.getCache(cacheType);

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  const mutate = useCallback(
    async (params: P) => {
      try {
        setLoading(true);
        setError(null);

        if (optimisticUpdate) {
          // Store original data for rollback
          const originalData = cache.get(key);

          try {
            const result = await mutator(params);

            if (invalidateOnSuccess) {
              cache.delete(key);
            } else {
              cache.set(key, result, ttl);
            }

            return result;
          } catch (mutateError) {
            // Rollback on error
            if (originalData) {
              cache.set(key, originalData, ttl);
            }
            throw mutateError;
          }
        } else {
          const result = await mutator(params);

          if (invalidateOnSuccess) {
            cache.delete(key);
          } else {
            cache.set(key, result, ttl);
          }

          return result;
        }
      } catch (err) {
        setError(err as Error);
        throw err;
      } finally {
        setLoading(false);
      }
    },
    [key, mutator, ttl, cache, invalidateOnSuccess, optimisticUpdate]
  );

  return {
    mutate,
    loading,
    error,
  };
}

// Cache utilities for API responses
export function createApiCache(
  apiFunction: (...args: any[]) => Promise<any>,
  options: {
    ttl?: number;
    cacheType?: "memory" | "localStorage" | "indexedDB";
    keyGenerator?: (...args: any[]) => string;
  } = {}
) {
  const { ttl = 300000, cacheType = "memory", keyGenerator } = options;
  const cache = CacheFactory.getCache(cacheType);

  return async (...args: any[]) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);

    // Try cache first
    const cachedResult = cache.get(key);
    if (cachedResult) {
      return cachedResult;
    }

    // Fetch and cache
    const result = await apiFunction(...args);
    cache.set(key, result, ttl);

    return result;
  };
}

// Cache warming utilities
export function warmCache<T>(
  keys: string[],
  fetcher: (key: string) => Promise<T>,
  options: {
    ttl?: number;
    cacheType?: "memory" | "localStorage" | "indexedDB";
  } = {}
) {
  const { ttl = 300000, cacheType = "memory" } = options;
  const cache = CacheFactory.getCache(cacheType);

  return Promise.all(
    keys.map(async (key) => {
      try {
        const data = await fetcher(key);
        cache.set(key, data, ttl);
        return { key, success: true };
      } catch (error) {
        console.warn(`Failed to warm cache for key ${key}:`, error);
        return { key, success: false, error };
      }
    })
  );
}

// Export default instances
export const memoryCache = new MemoryCache();
export const localStorageCache = new LocalStorageCache();
export const indexedDBCache = new IndexedDBCache();
