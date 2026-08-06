/**
 * API Gateway Rate Limiting Middleware
 * Tenant-based rate limiting using Redis
 * Prevents abuse and ensures fair resource allocation
 */

import { cacheSet, cacheGet } from '../lib/cache';

export interface RateLimitConfig {
  requests: number;
  window: number; // seconds
}

export interface RateLimitResult {
  allowed: boolean;
  remaining: number;
  reset: number;
  limit: number;
}

// Default rate limits per tier
const RATE_LIMITS: Record<string, RateLimitConfig> = {
  FREE: { requests: 100, window: 60 }, // 100 requests/minute
  BASIC: { requests: 500, window: 60 }, // 500 requests/minute
  PRO: { requests: 2000, window: 60 }, // 2000 requests/minute
  ENTERPRISE: { requests: 10000, window: 60 }, // 10000 requests/minute
};

// API-specific rate limits (stricter than tier limits)
const API_RATE_LIMITS: Record<string, RateLimitConfig> = {
  '/auth/login': { requests: 5, window: 60 }, // 5 login attempts/minute
  '/auth/register': { requests: 3, window: 3600 }, // 3 registrations/hour
  '/auth/otp/send': { requests: 10, window: 60 }, // 10 OTP requests/minute
  '/property': { requests: 1000, window: 60 }, // 1000 property requests/minute
  '/api/ai': { requests: 50, window: 60 }, // 50 AI requests/minute
};

/**
 * Get rate limit config for tenant
 */
export function getTenantRateLimit(tier: string): RateLimitConfig {
  return RATE_LIMITS[tier] || RATE_LIMITS.FREE;
}

/**
 * Get rate limit config for specific API endpoint
 */
export function getAPIRateLimit(path: string): RateLimitConfig | null {
  // Find matching API limit
  for (const [apiPath, config] of Object.entries(API_RATE_LIMITS)) {
    if (path.startsWith(apiPath)) {
      return config;
    }
  }
  return null;
}

/**
 * Check rate limit for tenant
 */
export async function checkRateLimit(
  identifier: string,
  config: RateLimitConfig
): Promise<RateLimitResult> {
  const key = `ratelimit:${identifier}`;
  const now = Math.floor(Date.now() / 1000);
  const windowStart = now - config.window;

  // Get current usage
  const cached = await cacheGet<{ count: number; reset: number }>(key);
  
  let count = 0;
  let reset = now + config.window;

  if (cached && cached.reset > now) {
    count = cached.count;
    reset = cached.reset;
  }

  // Check if limit exceeded
  if (count >= config.requests) {
    return {
      allowed: false,
      remaining: 0,
      reset,
      limit: config.requests,
    };
  }

  // Increment count
  count++;
  await cacheSet(key, { count, reset }, config.window);

  return {
    allowed: true,
    remaining: config.requests - count,
    reset,
    limit: config.requests,
  };
}

/**
 * Elysia middleware for rate limiting
 */
export const rateLimitMiddleware = async ({ 
  headers, 
  path, 
  set, 
  orgId,
  userId 
}: any) => {
  // Get identifier (user ID or IP for anonymous)
  const identifier = userId || headers.get('x-forwarded-for') || 'anonymous';
  
  // Get tenant tier (from org context or default to FREE)
  const tier = 'FREE'; // TODO: Get from organization settings
  
  // Get API-specific limit if exists
  const apiLimit = getAPIRateLimit(path);
  const config = apiLimit || getTenantRateLimit(tier);
  
  // Check rate limit
  const result = await checkRateLimit(identifier, config);
  
  // Set rate limit headers
  set.headers = {
    ...set.headers,
    'X-RateLimit-Limit': result.limit.toString(),
    'X-RateLimit-Remaining': result.remaining.toString(),
    'X-RateLimit-Reset': result.reset.toString(),
  };
  
  if (!result.allowed) {
    set.status = 429;
    set.headers['Retry-After'] = (result.reset - Math.floor(Date.now() / 1000)).toString();
    throw new Error('Rate limit exceeded. Please try again later.');
  }
  
  console.log(`[RateLimit] ${identifier}: ${result.remaining}/${result.limit} remaining`);
};

/**
 * Rate limiting for anonymous requests (IP-based)
 */
export const anonymousRateLimitMiddleware = async ({ 
  headers, 
  path, 
  set 
}: any) => {
  const ip = headers.get('x-forwarded-for') || headers.get('cf-connecting-ip') || 'unknown';
  
  // Stricter limits for anonymous requests
  const config: RateLimitConfig = { requests: 20, window: 60 };
  
  const result = await checkRateLimit(`anon:${ip}`, config);
  
  set.headers = {
    ...set.headers,
    'X-RateLimit-Limit': result.limit.toString(),
    'X-RateLimit-Remaining': result.remaining.toString(),
    'X-RateLimit-Reset': result.reset.toString(),
  };
  
  if (!result.allowed) {
    set.status = 429;
    throw new Error('Rate limit exceeded for anonymous requests.');
  }
};

/**
 * Rate limiting for expensive operations (AI, heavy queries)
 */
export const expensiveOperationRateLimit = async ({ 
  userId, 
  orgId, 
  set 
}: any) => {
  const identifier = userId || orgId;
  const config: RateLimitConfig = { requests: 10, window: 60 };
  
  const result = await checkRateLimit(`expensive:${identifier}`, config);
  
  if (!result.allowed) {
    set.status = 429;
    throw new Error('Too many expensive operations. Please wait.');
  }
  
  return result;
};

/**
 * Reset rate limit (admin function)
 */
export async function resetRateLimit(identifier: string): Promise<void> {
  const key = `ratelimit:${identifier}`;
  await cacheDelete(key);
  console.log(`[RateLimit] Reset for ${identifier}`);
}
