import { Elysia } from "elysia";

// ── Prod defaults (override via .env) ──────────────────────────────────────
// RATE_LIMIT_API:    max requests/min for general API endpoints   (default: 200)
// RATE_LIMIT_READ:   max requests/min for read-heavy endpoints    (default: 500)
// RATE_LIMIT_AUTH:   max requests/min for auth endpoints          (default: 10)
// RATE_LIMIT_HEAVY:  max requests/min for search/AI/ML endpoints  (default: 30)
// REDIS_URL:         optional — when set, uses Upstash/Redis instead of in-memory

const ENV = {
  api: Number(process.env.RATE_LIMIT_API) || 200,
  read: Number(process.env.RATE_LIMIT_READ) || 500,
  auth: Number(process.env.RATE_LIMIT_AUTH) || 10,
  heavy: Number(process.env.RATE_LIMIT_HEAVY) || 30,
  redisUrl: process.env.REDIS_URL || "",
};

const HEAVY_PREFIXES = ["/search", "/valuation", "/recommendations", "/ai/", "/ml/"];
const AUTH_PREFIXES = ["/auth/", "/login", "/signup", "/forgot-password", "/verify-email"];

function isHeavyPath(path: string): boolean {
  return HEAVY_PREFIXES.some(p => path.startsWith(p));
}
function isAuthPath(path: string): boolean {
  return AUTH_PREFIXES.some(p => path.startsWith(p));
}

// ── In-memory fallback store ───────────────────────────────────────────────
interface Entry {
  count: number;
  resetAt: number;
}
const memStore = new Map<string, Entry>();

function createMemLimiter(windowMs: number, max: number) {
  return (ip: string) => {
    const now = Date.now();
    const entry = memStore.get(ip);
    if (!entry || now > entry.resetAt) {
      memStore.set(ip, { count: 1, resetAt: now + windowMs });
      return { allowed: true, remaining: max - 1, resetAt: now + windowMs };
    }
    if (entry.count >= max) {
      return { allowed: false, remaining: 0, resetAt: entry.resetAt };
    }
    entry.count++;
    return { allowed: true, remaining: max - entry.count, resetAt: entry.resetAt };
  };
}

// ── Redis-backed limiter ───────────────────────────────────────────────────
let redisLimiter: {
  limit: (identifier: string) => Promise<{
    success: boolean;
    remaining: number;
    reset: number;
  }>;
} | null = null;

async function initRedisLimiter() {
  try {
    const { Redis } = await import("@upstash/redis");
    const { Ratelimit } = await import("@upstash/ratelimit");
    const redis = new Redis({ url: ENV.redisUrl });

    redisLimiter = new Ratelimit({
      redis,
      limiter: Ratelimit.slidingWindow(ENV.api, "60 s"),
      prefix: "ratelimit:api",
      analytics: false,
    });
  } catch {
    console.warn("[rate-limit] Redis unavailable, falling back to in-memory");
  }
}

if (ENV.redisUrl) {
  initRedisLimiter();
}

// Periodic in-memory cleanup
setInterval(() => {
  const now = Date.now();
  for (const [key, entry] of memStore) {
    if (now > entry.resetAt) memStore.delete(key);
  }
}, 300_000);

// ── Middleware ─────────────────────────────────────────────────────────────
export const rateLimitMiddleware = (app: Elysia) =>
  app.onBeforeHandle(async ({ request, set }) => {
    const ip =
      request.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ||
      request.headers.get("x-real-ip") ||
      "unknown";

    const url = new URL(request.url);
    const path = url.pathname;

    let limit: number;
    if (isAuthPath(path)) limit = ENV.auth;
    else if (isHeavyPath(path)) limit = ENV.heavy;
    else limit = ENV.api;

    let allowed: boolean;
    let remaining: number;
    let resetAt: number;

    if (redisLimiter) {
      const result = await redisLimiter.limit(`${ip}:${path}`);
      allowed = result.success;
      remaining = result.remaining;
      resetAt = result.reset;
    } else {
      const limiter = createMemLimiter(60_000, limit);
      const result = limiter(ip);
      allowed = result.allowed;
      remaining = result.remaining;
      resetAt = result.resetAt;
    }

    set.headers["X-RateLimit-Limit"] = String(limit);
    set.headers["X-RateLimit-Remaining"] = String(remaining);
    set.headers["X-RateLimit-Reset"] = String(Math.ceil(resetAt / 1000));

    if (!allowed) {
      set.status = 429;
      const retryAfter = Math.max(1, Math.ceil((resetAt - Date.now()) / 1000));
      set.headers["Retry-After"] = String(retryAfter);
      return { error: "Too many requests", retryAfter };
    }
  });
