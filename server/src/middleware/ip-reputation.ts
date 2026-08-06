/**
 * IP Reputation and Bot Detection Middleware
 * Checks IP reputation, detects bots, and blocks malicious traffic
 * Integrates with Security OS threat intelligence
 */

import { cacheSet, cacheGet } from '../lib/cache';

export interface IPReputationResult {
  reputation: 'CLEAN' | 'SUSPICIOUS' | 'MALICIOUS';
  score: number; // 0-100, higher = more suspicious
  threats: string[];
  isBot: boolean;
  botType?: string;
}

export interface BotDetectionResult {
  isBot: boolean;
  confidence: number; // 0-1
  botType?: 'SEARCH_ENGINE' | 'SCANNER' | 'SCRAPER' | 'SPAM_BOT' | 'DDOS' | 'UNKNOWN';
  reason: string;
}

// Known bot user-agents (search engines)
const SEARCH_ENGINE_BOTS = [
  'googlebot',
  'bingbot',
  'slurp',
  'duckduckbot',
  'baiduspider',
  'yandexbot',
  'sogou',
  'exabot',
  'facebookexternalhit',
  'twitterbot',
  'linkedinbot',
];

// Malicious bot patterns
const MALICIOUS_BOT_PATTERNS = [
  /bot/i,
  /crawler/i,
  /spider/i,
  /scraper/i,
  /scan/i,
  /curl/i,
  /wget/i,
  /python/i,
  /perl/i,
  /java/i,
  /go-http-client/i,
  /postman/i,
  /insomnia/i,
];

// Suspicious user-agent patterns
const SUSPICIOUS_UA_PATTERNS = [
  /\.\./,
  /<script/i,
  /eval\(/i,
  /union\s+select/i,
  /<iframe/i,
];

/**
 * Detect if request is from a bot
 */
export function detectBot(userAgent: string): BotDetectionResult {
  const ua = userAgent.toLowerCase();
  
  // Check for search engines (allow these)
  for (const bot of SEARCH_ENGINE_BOTS) {
    if (ua.includes(bot)) {
      return {
        isBot: true,
        confidence: 0.95,
        botType: 'SEARCH_ENGINE',
        reason: `Known search engine bot: ${bot}`,
      };
    }
  }
  
  // Check for malicious bots
  for (const pattern of MALICIOUS_BOT_PATTERNS) {
    if (pattern.test(ua)) {
      return {
        isBot: true,
        confidence: 0.85,
        botType: 'SCRAPER',
        reason: 'Matches known bot pattern',
      };
    }
  }
  
  // Check for suspicious patterns
  for (const pattern of SUSPICIOUS_UA_PATTERNS) {
    if (pattern.test(ua)) {
      return {
        isBot: true,
        confidence: 0.7,
        botType: 'UNKNOWN',
        reason: 'Contains suspicious pattern',
      };
    }
  }
  
  // Check for missing or empty user-agent
  if (!ua || ua.length < 10) {
    return {
      isBot: true,
      confidence: 0.5,
      botType: 'UNKNOWN',
      reason: 'Missing or suspicious user-agent',
    };
  }
  
  return {
    isBot: false,
    confidence: 0,
    reason: 'Appears to be legitimate browser',
  };
}

/**
 * Check IP reputation (simplified - in production use threat intelligence API)
 */
export async function checkIPReputation(ip: string): Promise<IPReputationResult> {
  const cacheKey = `ip:reputation:${ip}`;
  const cached = await cacheGet<IPReputationResult>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  const threats: string[] = [];
  let score = 0;
  
  // Check if IP is private (should not appear in public requests)
  if (isPrivateIP(ip)) {
    return {
      reputation: 'SUSPICIOUS',
      score: 50,
      threats: ['PRIVATE_IP_IN_PUBLIC_REQUEST'],
      isBot: false,
    };
  }
  
  // Check if IP is in known malicious ranges (simplified)
  if (isKnownMaliciousIP(ip)) {
    score += 80;
    threats.push('KNOWN_MALICIOUS_IP');
  }
  
  // Check if IP is from VPN/Proxy (simplified)
  if (isVPNOrProxy(ip)) {
    score += 30;
    threats.push('VPN_OR_PROXY');
  }
  
  // Determine reputation
  let reputation: 'CLEAN' | 'SUSPICIOUS' | 'MALICIOUS';
  if (score >= 70) {
    reputation = 'MALICIOUS';
  } else if (score >= 30) {
    reputation = 'SUSPICIOUS';
  } else {
    reputation = 'CLEAN';
  }
  
  const result: IPReputationResult = {
    reputation,
    score,
    threats,
    isBot: false,
  };
  
  // Cache for 1 hour
  await cacheSet(cacheKey, result, 3600);
  
  return result;
}

/**
 * Check if IP is private
 */
function isPrivateIP(ip: string): boolean {
  const privateRanges = [
    /^10\./,
    /^172\.(1[6-9]|2[0-9]|3[01])\./,
    /^192\.168\./,
    /^127\./,
    /^::1$/,
    /^fc00:/i,
    /^fe80:/i,
  ];
  
  return privateRanges.some(range => range.test(ip));
}

/**
 * Check if IP is known malicious (simplified - in production use threat intel)
 */
function isKnownMaliciousIP(ip: string): boolean {
  // In production, query threat intelligence feeds
  // For now, return false
  return false;
}

/**
 * Check if IP is from VPN/Proxy (simplified)
 */
function isVPNOrProxy(ip: string): boolean {
  // In production, use commercial VPN detection service
  // For now, return false
  return false;
}

/**
 * Rate limit by IP
 */
export async function rateLimitByIP(ip: string, limit: number = 100, window: number = 60): Promise<{ allowed: boolean; remaining: number }> {
  const cacheKey = `ratelimit:ip:${ip}`;
  const cached = await cacheGet<{ count: number; reset: number }>(cacheKey);
  
  const now = Math.floor(Date.now() / 1000);
  const windowStart = now - window;
  
  let count = 0;
  let reset = now + window;
  
  if (cached && cached.reset > now) {
    count = cached.count;
    reset = cached.reset;
  }
  
  if (count >= limit) {
    return { allowed: false, remaining: 0 };
  }
  
  count++;
  await cacheSet(cacheKey, { count, reset }, window);
  
  return { allowed: true, remaining: limit - count };
}

/**
 * Elysia middleware for IP reputation and bot detection
 */
export const ipReputationMiddleware = async ({ 
  headers, 
  set 
}: any) => {
  const ip = headers.get('x-forwarded-for') || 
             headers.get('cf-connecting-ip') || 
             'unknown';
  
  const userAgent = headers.get('user-agent') || 'unknown';
  
  // Detect bot
  const botDetection = detectBot(userAgent);
  
  // Allow search engine bots
  if (botDetection.isBot && botDetection.botType === 'SEARCH_ENGINE') {
    console.log(`[IP Reputation] Allowing search engine bot: ${botDetection.reason}`);
    return;
  }
  
  // Block other bots
  if (botDetection.isBot && botDetection.confidence > 0.7) {
    set.status = 403;
    throw new Error(`Bot detected: ${botDetection.reason}`);
  }
  
  // Check IP reputation
  const reputation = await checkIPReputation(ip);
  
  if (reputation.reputation === 'MALICIOUS') {
    set.status = 403;
    throw new Error(`IP blocked: ${reputation.threats.join(', ')}`);
  }
  
  if (reputation.reputation === 'SUSPICIOUS') {
    // Apply stricter rate limiting for suspicious IPs
    const rateLimit = await rateLimitByIP(ip, 10, 60);
    
    if (!rateLimit.allowed) {
      set.status = 429;
      throw new Error('Rate limit exceeded for suspicious IP');
    }
    
    console.log(`[IP Reputation] Suspicious IP: ${ip} - ${reputation.threats.join(', ')}`);
  }
  
  // Apply normal rate limiting
  const rateLimit = await rateLimitByIP(ip, 100, 60);
  
  if (!rateLimit.allowed) {
    set.status = 429;
    throw new Error('Rate limit exceeded');
  }
  
  set.headers = {
    ...set.headers,
    'X-Bot-Detected': botDetection.isBot.toString(),
    'X-IP-Reputation': reputation.reputation,
    'X-Rate-Limit-Remaining': rateLimit.remaining.toString(),
  };
  
  console.log(`[IP Reputation] IP: ${ip}, Reputation: ${reputation.reputation}, Bot: ${botDetection.isBot}`);
};

/**
 * Add IP to blacklist
 */
export async function blacklistIP(ip: string, reason: string, ttl: number = 86400): Promise<void> {
  const cacheKey = `ip:blacklist:${ip}`;
  await cacheSet(cacheKey, { reason, blacklistedAt: Date.now() }, ttl);
  console.log(`[IP Reputation] Blacklisted IP: ${ip} - ${reason}`);
}

/**
 * Check if IP is blacklisted
 */
export async function isIPBlacklisted(ip: string): Promise<boolean> {
  const cacheKey = `ip:blacklist:${ip}`;
  const cached = await cacheGet(cacheKey);
  return cached !== null;
}

/**
 * Add IP to whitelist
 */
export async function whitelistIP(ip: string, ttl: number = 86400): Promise<void> {
  const cacheKey = `ip:whitelist:${ip}`;
  await cacheSet(cacheKey, { whitelistedAt: Date.now() }, ttl);
  console.log(`[IP Reputation] Whitelisted IP: ${ip}`);
}

/**
 * Check if IP is whitelisted
 */
export async function isIPWhitelisted(ip: string): Promise<boolean> {
  const cacheKey = `ip:whitelist:${ip}`;
  const cached = await cacheGet(cacheKey);
  return cached !== null;
}

/**
 * Get IP statistics
 */
export async function getIPStats(ip: string): Promise<{
  reputation: IPReputationResult;
  requestCount: number;
  lastSeen: Date;
}> {
  const reputation = await checkIPReputation(ip);
  const statsKey = `ip:stats:${ip}`;
  const stats = await cacheGet<{ count: number; lastSeen: number }>(statsKey);
  
  return {
    reputation,
    requestCount: stats?.count || 0,
    lastSeen: stats ? new Date(stats.lastSeen) : new Date(),
  };
}

/**
 * Update IP statistics
 */
export async function updateIPStats(ip: string): Promise<void> {
  const statsKey = `ip:stats:${ip}`;
  const stats = await cacheGet<{ count: number; lastSeen: number }>(statsKey);
  
  await cacheSet(statsKey, {
    count: (stats?.count || 0) + 1,
    lastSeen: Date.now(),
  }, 86400);
}
