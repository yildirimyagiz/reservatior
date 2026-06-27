// Memoization utilities for performance optimization

// Simple memoization function
export function memoize<T extends (...args: any[]) => any>(
  fn: T,
  keyGenerator?: (...args: Parameters<T>) => string
): T {
  const cache = new Map<string, ReturnType<T>>();

  return ((...args: Parameters<T>) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);

    if (cache.has(key)) {
      return cache.get(key);
    }

    const result = fn(...args);
    cache.set(key, result);
    return result;
  }) as T;
}

// Memoization with TTL (time to live)
export function memoizeWithTTL<T extends (...args: any[]) => any>(
  fn: T,
  ttl: number = 300000, // 5 minutes default
  keyGenerator?: (...args: Parameters<T>) => string
): T {
  const cache = new Map<string, { value: ReturnType<T>; timestamp: number }>();

  return ((...args: Parameters<T>) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);
    const now = Date.now();

    const cached = cache.get(key);
    if (cached && now - cached.timestamp < ttl) {
      return cached.value;
    }

    const result = fn(...args);
    cache.set(key, { value: result, timestamp: now });
    return result;
  }) as T;
}

// Memoization with LRU (Least Recently Used) cache
export class LRUCache<K, V> {
  private cache = new Map<K, V>();
  private maxSize: number;

  constructor(maxSize: number = 100) {
    this.maxSize = maxSize;
  }

  get(key: K): V | undefined {
    const value = this.cache.get(key);
    if (value !== undefined) {
      // Move to end (most recently used)
      this.cache.delete(key);
      this.cache.set(key, value);
    }
    return value;
  }

  set(key: K, value: V): void {
    if (this.cache.has(key)) {
      this.cache.delete(key);
    } else if (this.cache.size >= this.maxSize) {
      // Remove least recently used (first item)
      const firstKey = this.cache.keys().next().value;
      if (firstKey !== undefined) {
        this.cache.delete(firstKey);
      }
    }
    this.cache.set(key, value);
  }

  has(key: K): boolean {
    return this.cache.has(key);
  }

  delete(key: K): boolean {
    return this.cache.delete(key);
  }

  clear(): void {
    this.cache.clear();
  }

  size(): number {
    return this.cache.size;
  }

  keys(): K[] {
    return Array.from(this.cache.keys());
  }

  values(): V[] {
    return Array.from(this.cache.values());
  }
}

// Memoization with LRU cache
export function memoizeWithLRU<T extends (...args: any[]) => any>(
  fn: T,
  maxSize: number = 100,
  keyGenerator?: (...args: Parameters<T>) => string
): T {
  const cache = new LRUCache<string, ReturnType<T>>(maxSize);

  return ((...args: Parameters<T>) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);

    const cached = cache.get(key);
    if (cached !== undefined) {
      return cached;
    }

    const result = fn(...args);
    cache.set(key, result);
    return result;
  }) as T;
}

// Weak memoization for object arguments
export function weakMemoize<T extends (...args: any[]) => any>(fn: T): T {
  const cache = new WeakMap<any, ReturnType<T>>();

  return ((...args: Parameters<T>) => {
    if (args.length === 1 && typeof args[0] === "object") {
      const cached = cache.get(args[0]);
      if (cached !== undefined) {
        return cached;
      }
    }

    const result = fn(...args);
    if (args.length === 1 && typeof args[0] === "object") {
      cache.set(args[0], result);
    }
    return result;
  }) as T;
}

// Memoization for async functions
export function memoizeAsync<T extends (...args: any[]) => Promise<any>>(
  fn: T,
  keyGenerator?: (...args: Parameters<T>) => string
): T {
  const cache = new Map<string, Promise<ReturnType<T>>>();
  const pendingCache = new Map<string, Promise<ReturnType<T>>>();

  return (async (...args: Parameters<T>) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);

    // Check if already cached
    if (cache.has(key)) {
      return cache.get(key);
    }

    // Check if currently pending
    if (pendingCache.has(key)) {
      return pendingCache.get(key);
    }

    // Create and cache the promise
    const promise = fn(...args);
    pendingCache.set(key, promise);

    try {
      const result = await promise;
      cache.set(key, promise);
      return result;
    } finally {
      pendingCache.delete(key);
    }
  }) as T;
}

// Memoization for async functions with TTL
export function memoizeAsyncWithTTL<T extends (...args: any[]) => Promise<any>>(
  fn: T,
  ttl: number = 300000,
  keyGenerator?: (...args: Parameters<T>) => string
): T {
  const cache = new Map<
    string,
    { promise: Promise<ReturnType<T>>; timestamp: number }
  >();
  const pendingCache = new Map<string, Promise<ReturnType<T>>>();

  return (async (...args: Parameters<T>) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);
    const now = Date.now();

    // Check cache with TTL
    const cached = cache.get(key);
    if (cached && now - cached.timestamp < ttl) {
      return cached.promise;
    }

    // Check if currently pending
    if (pendingCache.has(key)) {
      return pendingCache.get(key);
    }

    // Create and cache the promise
    const promise = fn(...args);
    pendingCache.set(key, promise);

    try {
      const result = await promise;
      cache.set(key, { promise, timestamp: now });
      return result;
    } finally {
      pendingCache.delete(key);
    }
  }) as T;
}

// React hooks for memoization
import { useState, useEffect, useCallback, useMemo, useRef } from "react";

// Hook for memoized async data
export function useMemoizedAsync<T, P extends any[]>(
  asyncFn: (...args: P) => Promise<T>,
  deps: React.DependencyList,
  options: {
    keyGenerator?: (...args: P) => string;
    ttl?: number;
  } = {}
) {
  const { keyGenerator, ttl } = options;
  const memoizedFn = useMemo(() => {
    return ttl
      ? memoizeAsyncWithTTL(asyncFn, ttl, keyGenerator)
      : memoizeAsync(asyncFn, keyGenerator);
  }, [asyncFn, ttl, keyGenerator]);

  const [state, setState] = useState<{
    data: T | null;
    loading: boolean;
    error: Error | null;
  }>({
    data: null,
    loading: false,
    error: null,
  });

  const execute = useCallback(
    async (...args: P) => {
      setState((prev) => ({ ...prev, loading: true, error: null }));
      try {
        const result = await memoizedFn(...args);
        setState({ data: result, loading: false, error: null });
        return result;
      } catch (error) {
        setState((prev) => ({
          ...prev,
          loading: false,
          error: error as Error,
        }));
        throw error;
      }
    },
    [memoizedFn]
  );

  useEffect(() => {
    // Clear memoization when dependencies change
    if (deps.length > 0) {
      // This will trigger re-memoization
    }
  }, deps);

  return { ...state, execute };
}

// Hook for memoized callback with deep comparison
export function useMemoizedCallback<T extends (...args: any[]) => any>(
  callback: T,
  deps: React.DependencyList
): T {
  const ref = useRef<T>();
  const depsRef = useRef<React.DependencyList>([]);

  if (!ref.current || !depsAreEqual(deps, depsRef.current)) {
    ref.current = callback;
    depsRef.current = deps;
  }

  return useCallback((...args: Parameters<T>) => {
    return ref.current!(...args);
  }, deps) as T;
}

// Deep comparison utility
function depsAreEqual(
  a: React.DependencyList,
  b: React.DependencyList
): boolean {
  if (a.length !== b.length) return false;

  for (let i = 0; i < a.length; i++) {
    if (!deepEqual(a[i], b[i])) return false;
  }

  return true;
}

function deepEqual(a: any, b: any): boolean {
  if (a === b) return true;

  if (typeof a !== typeof b) return false;

  if (typeof a === "object" && a !== null && b !== null) {
    const keysA = Object.keys(a);
    const keysB = Object.keys(b);

    if (keysA.length !== keysB.length) return false;

    for (const key of keysA) {
      if (!keysB.includes(key) || !deepEqual(a[key], b[key])) return false;
    }

    return true;
  }

  return false;
}

// Hook for memoized value with deep comparison
export function useMemoizedValue<T>(
  factory: () => T,
  deps: React.DependencyList
): T {
  const ref = useRef<{ value: T; deps: React.DependencyList }>();

  if (!ref.current || !depsAreEqual(deps, ref.current.deps)) {
    ref.current = { value: factory(), deps };
  }

  return ref.current.value;
}

// Memoization for expensive computations
export function useMemoizeComputation<T, P extends any[]>(
  computation: (...args: P) => T,
  options: {
    maxSize?: number;
    ttl?: number;
    keyGenerator?: (...args: P) => string;
  } = {}
) {
  const { maxSize = 100, ttl, keyGenerator } = options;

  if (ttl) {
    return memoizeWithTTL(computation, ttl, keyGenerator);
  } else if (maxSize) {
    return memoizeWithLRU(computation, maxSize, keyGenerator);
  } else {
    return memoize(computation, keyGenerator);
  }
}

// Cache statistics
export function getCacheStats(cache: Map<any, any>) {
  return {
    size: cache.size,
    keys: Array.from(cache.keys()),
    // Add more stats as needed
  };
}

// Cache cleanup utilities
export function createCacheCleanupScheduler(
  caches: Array<{ clear?: () => void; cleanup?: () => void }>
) {
  const interval = setInterval(() => {
    caches.forEach((cache) => {
      if (cache.cleanup) {
        cache.cleanup();
      }
    });
  }, 60000); // Cleanup every minute

  return () => clearInterval(interval);
}

// Memoization for API calls
export function createMemoizedApi<T extends (...args: any[]) => Promise<any>>(
  apiFunction: T,
  options: {
    ttl?: number;
    maxSize?: number;
    keyGenerator?: (...args: Parameters<T>) => string;
  } = {}
) {
  const { ttl = 300000, maxSize = 100, keyGenerator } = options;

  if (maxSize) {
    return memoizeWithLRU(apiFunction, maxSize, keyGenerator);
  } else {
    return memoizeAsyncWithTTL(apiFunction, ttl, keyGenerator);
  }
}

// Debounced memoization
export function debounceMemo<T extends (...args: any[]) => any>(
  fn: T,
  delay: number,
  keyGenerator?: (...args: Parameters<T>) => string
): T {
  const timeouts = new Map<string, NodeJS.Timeout>();
  const cache = new Map<string, ReturnType<T>>();

  return ((...args: Parameters<T>) => {
    const key = keyGenerator ? keyGenerator(...args) : JSON.stringify(args);

    // Return cached value if available
    if (cache.has(key)) {
      return cache.get(key);
    }

    // Clear existing timeout
    if (timeouts.has(key)) {
      clearTimeout(timeouts.get(key)!);
    }

    // Set new timeout
    const timeout = setTimeout(() => {
      const result = fn(...args);
      cache.set(key, result);
      timeouts.delete(key);
    }, delay);

    timeouts.set(key, timeout);

    // Return initial result for first call
    if (!timeouts.has(key)) {
      return fn(...args);
    }
  }) as T;
}
