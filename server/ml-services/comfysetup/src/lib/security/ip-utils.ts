import { Ratelimit } from "@upstash/ratelimit";
import { Redis } from "@upstash/redis";

const isRedisConfigured = !!process.env.UPSTASH_REDIS_REST_URL;

class MockRateLimit {
  async limit(identifier: string) {
    console.log(`[MockRateLimit] Allowed request for ${identifier}`);
    return { success: true, limit: 100, remaining: 99, reset: 0 };
  }
}

// Initialize Redis if configured, otherwise use mock
const redis = isRedisConfigured
  ? new Redis({
      url: process.env.UPSTASH_REDIS_REST_URL!,
      token: process.env.UPSTASH_REDIS_REST_TOKEN!,
    })
  : (null as unknown as Redis); // Cast for type safety in Ratelimit constructor, but we won't use it if not configured

// Create Rate Limiters
// If Redis is not configured, we return the mock implementation directly. 
// We cast it to 'any' to satisfy the export type which expects a Ratelimit instance or compatible interface.
export const ipRateLimiter = isRedisConfigured
  ? new Ratelimit({
      redis: redis,
      limiter: Ratelimit.slidingWindow(10, "1 h"),
      analytics: true,
      prefix: "@upstash/ratelimit",
    })
  : (new MockRateLimit() as unknown as Ratelimit);

export const generationRateLimiter = isRedisConfigured
  ? new Ratelimit({
      redis: redis,
      limiter: Ratelimit.slidingWindow(5, "1 m"),
      analytics: true,
      prefix: "@upstash/ratelimit/gen",
    })
  : (new MockRateLimit() as unknown as Ratelimit);

export async function checkIpReputation(ip: string): Promise<{isProxy: boolean, isHosting: boolean}> {
    // Mock implementation for MVP
    // In production, integrate with IPQS or similar service
    const isLocalhost = ip === "127.0.0.1" || ip === "::1";
    
    if (isLocalhost) {
        return { isProxy: false, isHosting: false };
    }
    
    // Simple blacklists could go here
    return { isProxy: false, isHosting: false };
}
