/**
 * Distributed Lock
 * Enterprise-grade locking for saga step transitions.
 *
 * Prevents two sagas from modifying the same entity simultaneously.
 * Starts as in-process Map<key, lease>; upgradeable to Redis in production.
 *
 * Usage:
 *   await distributedLock.withLock(`property:${propertyId}`, sagaId, async () => {
 *     // exclusive work
 *   });
 */

export interface LockEntry {
  owner: string;
  leaseUntil: number; // epoch ms
  acquiredAt: number;
}

export class DistributedLock {
  private locks: Map<string, LockEntry> = new Map();
  private cleanupInterval: ReturnType<typeof setInterval> | null = null;

  constructor() {
    // Periodically clean up expired leases (every 30s)
    this.cleanupInterval = setInterval(() => this.cleanup(), 30_000);
  }

  /**
   * Attempt to acquire a lock.
   * Returns true if acquired, false if already held by another owner.
   */
  async acquire(key: string, owner: string, ttlMs: number = 30_000): Promise<boolean> {
    const now = Date.now();
    const existing = this.locks.get(key);

    // If lock exists and hasn't expired and is held by a different owner → deny
    if (existing && existing.leaseUntil > now && existing.owner !== owner) {
      return false;
    }

    // Acquire or renew
    this.locks.set(key, {
      owner,
      leaseUntil: now + ttlMs,
      acquiredAt: now,
    });

    return true;
  }

  /**
   * Release a lock. Only the owner can release.
   */
  async release(key: string, owner: string): Promise<void> {
    const existing = this.locks.get(key);
    if (existing && existing.owner === owner) {
      this.locks.delete(key);
    }
  }

  /**
   * Execute a function while holding a lock.
   * Automatically acquires before and releases after.
   * Throws if lock cannot be acquired after retries.
   */
  async withLock<T>(
    key: string,
    owner: string,
    fn: () => Promise<T>,
    ttlMs: number = 30_000,
    maxWaitMs: number = 10_000
  ): Promise<T> {
    const startTime = Date.now();
    const retryIntervalMs = 100;

    // Spin-wait with backoff
    while (Date.now() - startTime < maxWaitMs) {
      const acquired = await this.acquire(key, owner, ttlMs);
      if (acquired) {
        try {
          return await fn();
        } finally {
          await this.release(key, owner);
        }
      }
      // Wait before retry
      await new Promise(resolve => setTimeout(resolve, retryIntervalMs));
    }

    throw new Error(
      `[DistributedLock] Failed to acquire lock "${key}" for owner "${owner}" within ${maxWaitMs}ms`
    );
  }

  /**
   * Check if a key is currently locked.
   */
  isLocked(key: string): boolean {
    const entry = this.locks.get(key);
    return !!entry && entry.leaseUntil > Date.now();
  }

  /**
   * Get lock info for diagnostics.
   */
  getLockInfo(key: string): LockEntry | null {
    const entry = this.locks.get(key);
    if (entry && entry.leaseUntil > Date.now()) return entry;
    return null;
  }

  /**
   * Get all active locks (for admin dashboard).
   */
  getActiveLocks(): Array<{ key: string } & LockEntry> {
    const now = Date.now();
    const active: Array<{ key: string } & LockEntry> = [];
    this.locks.forEach((entry, key) => {
      if (entry.leaseUntil > now) {
        active.push({ key, ...entry });
      }
    });
    return active;
  }

  /**
   * Force-release a lock (admin override).
   */
  forceRelease(key: string): void {
    this.locks.delete(key);
  }

  /**
   * Clean up expired leases.
   */
  private cleanup(): void {
    const now = Date.now();
    let cleaned = 0;
    this.locks.forEach((entry, key) => {
      if (entry.leaseUntil <= now) {
        this.locks.delete(key);
        cleaned++;
      }
    });
    if (cleaned > 0) {
      console.log(`[DistributedLock] Cleaned ${cleaned} expired lease(s)`);
    }
  }

  /**
   * Shutdown cleanup interval.
   */
  destroy(): void {
    if (this.cleanupInterval) {
      clearInterval(this.cleanupInterval);
      this.cleanupInterval = null;
    }
  }
}

// Singleton
export const distributedLock = new DistributedLock();
