/**
 * IP Extraction Middleware
 * Extracts real client IP from proxy headers (X-Forwarded-For, CF-Connecting-IP)
 * Required for legal audit logs and security tracking
 */

export interface IPExtractionResult {
  ip: string;
  trustChain: string[];
  source: string;
}

/**
 * Extract real IP from request headers
 * Priority: CF-Connecting-IP > X-Forwarded-For (first IP) > X-Real-IP > fallback
 */
export function extractRealIP(headers: Headers): IPExtractionResult {
  const trustChain: string[] = [];

  // Cloudflare header (highest priority)
  const cfIP = headers.get('cf-connecting-ip');
  if (cfIP) {
    trustChain.push(cfIP);
    return {
      ip: cfIP,
      trustChain,
      source: 'cf-connecting-ip',
    };
  }

  // X-Forwarded-For header (may contain multiple IPs)
  const xForwardedFor = headers.get('x-forwarded-for');
  if (xForwardedFor) {
    const ips = xForwardedFor.split(',').map(ip => ip.trim());
    trustChain.push(...ips);
    // First IP is the original client
    return {
      ip: ips[0],
      trustChain,
      source: 'x-forwarded-for',
    };
  }

  // X-Real-IP header
  const xRealIP = headers.get('x-real-ip');
  if (xRealIP) {
    trustChain.push(xRealIP);
    return {
      ip: xRealIP,
      trustChain,
      source: 'x-real-ip',
    };
  }

  // Fallback (should not happen in production with proper proxy setup)
  const fallbackIP = 'unknown';
  return {
    ip: fallbackIP,
    trustChain: [fallbackIP],
    source: 'fallback',
  };
}

/**
 * Validate IP address format
 */
export function isValidIP(ip: string): boolean {
  if (ip === 'unknown') return false;
  
  // IPv4 regex
  const ipv4Regex = /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/;
  // IPv6 regex (simplified)
  const ipv6Regex = /^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$/;
  
  return ipv4Regex.test(ip) || ipv6Regex.test(ip);
}

/**
 * Check if IP is from trusted proxy
 */
export function isTrustedProxy(ip: string, trustedProxies: string[] = []): boolean {
  if (!isValidIP(ip)) return false;
  
  // Default trusted proxies (localhost, private networks)
  const defaultTrusted = [
    '127.0.0.1',
    '::1',
    '10.0.0.0/8',
    '172.16.0.0/12',
    '192.168.0.0/16',
  ];
  
  const allTrusted = [...defaultTrusted, ...trustedProxies];
  
  return allTrusted.some(trusted => {
    if (trusted.includes('/')) {
      // CIDR notation check (simplified)
      return ip.startsWith(trusted.split('/')[0].split('.').slice(0, -1).join('.'));
    }
    return ip === trusted;
  });
}

/**
 * Extract user agent from headers
 */
export function extractUserAgent(headers: Headers): string {
  return headers.get('user-agent') || 'unknown';
}

/**
 * Elysia middleware for IP extraction
 */
export const ipExtractionMiddleware = async ({ headers, set }: any) => {
  const ipResult = extractRealIP(headers);
  const userAgent = extractUserAgent(headers);
  
  // Attach to request context
  return {
    clientIP: ipResult.ip,
    ipTrustChain: ipResult.trustChain,
    ipSource: ipResult.source,
    userAgent,
  };
};

/**
 * Sanitize IP for logging (mask last octet for privacy)
 */
export function sanitizeIP(ip: string): string {
  if (!isValidIP(ip)) return ip;
  
  if (ip.includes(':')) {
    // IPv6: mask last 4 segments
    const parts = ip.split(':');
    return parts.slice(0, 4).join(':') + ':****:****:****';
  }
  
  // IPv4: mask last octet
  const parts = ip.split('.');
  return parts.slice(0, 3).join('.') + '.***';
}

/**
 * Get geolocation hint from IP (basic country detection)
 * Note: For production, use a proper geolocation service like MaxMind
 */
export function getIPCountryHint(ip: string): string | null {
  // This is a placeholder - in production, integrate with MaxMind GeoIP2
  // or use Cloudflare's country header: headers.get('cf-ipcountry')
  return null;
}
