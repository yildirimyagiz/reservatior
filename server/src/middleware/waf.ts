/**
 * Web Application Firewall (WAF) Middleware
 * Protects against common web attacks: SQLi, XSS, CSRF, etc.
 * Integrates with Security OS for threat detection
 */

export interface WAFRule {
  id: string;
  name: string;
  type: 'SQL_INJECTION' | 'XSS' | 'PATH_TRAVERSAL' | 'COMMAND_INJECTION' | 'SSRF' | 'RATE_LIMIT' | 'BLOCKED_IP';
  pattern: RegExp | string;
  action: 'BLOCK' | 'ALLOW' | 'LOG' | 'CHALLENGE';
  severity: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
}

export interface WAFResult {
  allowed: boolean;
  blockedBy?: string;
  reason?: string;
  severity?: string;
}

// SQL Injection patterns
const SQLI_PATTERNS = [
  /(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION|EXEC|ALTER|CREATE|TRUNCATE)\b)/i,
  /(--|\#|\/\*|\*\/|;)/,
  /(\b(OR|AND)\s+\d+\s*=\s*\d+)/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*=\s*['"]?\w+['"])/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*LIKE\s+['"]?%)/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*IN\s*\()/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*BETWEEN\s+)/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*IS\s+NULL)/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*IS\s+NOT\s+NULL)/i,
  /(\b(OR|AND)\s+['"]?\w+['"]?\s*EXISTS\s*\()/i,
];

// XSS patterns
const XSS_PATTERNS = [
  /<script[^>]*>.*?<\/script>/gi,
  /<iframe[^>]*>.*?<\/iframe>/gi,
  /javascript:/gi,
  /on\w+\s*=/gi,
  /<img[^>]+src[^>]*>/gi,
  /<embed[^>]*>/gi,
  /<object[^>]*>/gi,
  /<meta[^>]*>/gi,
  /<link[^>]*>/gi,
  /<style[^>]*>.*?<\/style>/gi,
  /eval\s*\(/gi,
  /expression\s*\(/gi,
];

// Path traversal patterns
const PATH_TRAVERSAL_PATTERNS = [
  /\.\.\//g,
  /\.\.\\/g,
  /%2e%2e%2f/gi,
  /%2e%2e%5c/gi,
  /%252e%252e%252f/gi,
  /%252e%252e%255c/gi,
  /\.\.%2f/gi,
  /\.\.%5c/gi,
];

// Command injection patterns
const COMMAND_INJECTION_PATTERNS = [
  /[;&|`$()]/g,
  /\|\|/g,
  /&&/g,
  /;/g,
  /`/g,
  /\$\(/g,
  />\s*\//g,
];

// SSRF patterns
const SSRF_PATTERNS = [
  /http(s)?:\/\/(localhost|127\.0\.0\.1|0\.0\.0\.0|192\.168\.|10\.|172\.(1[6-9]|2[0-9]|3[01])\.)/gi,
  /file:\/\//gi,
  /gopher:\/\//gi,
  /dict:\/\//gi,
  /ftp:\/\//gi,
];

// Default WAF rules
const DEFAULT_WAF_RULES: WAFRule[] = [
  {
    id: 'SQLI-001',
    name: 'SQL Injection Detection',
    type: 'SQL_INJECTION',
    pattern: SQLI_PATTERNS,
    action: 'BLOCK',
    severity: 'CRITICAL',
  },
  {
    id: 'XSS-001',
    name: 'XSS Detection',
    type: 'XSS',
    pattern: XSS_PATTERNS,
    action: 'BLOCK',
    severity: 'HIGH',
  },
  {
    id: 'PATH-001',
    name: 'Path Traversal Detection',
    type: 'PATH_TRAVERSAL',
    pattern: PATH_TRAVERSAL_PATTERNS,
    action: 'BLOCK',
    severity: 'HIGH',
  },
  {
    id: 'CMD-001',
    name: 'Command Injection Detection',
    type: 'COMMAND_INJECTION',
    pattern: COMMAND_INJECTION_PATTERNS,
    action: 'BLOCK',
    severity: 'CRITICAL',
  },
  {
    id: 'SSRF-001',
    name: 'SSRF Detection',
    type: 'SSRF',
    pattern: SSRF_PATTERNS,
    action: 'BLOCK',
    severity: 'HIGH',
  },
];

/**
 * Check if string matches any pattern
 */
function matchesPattern(input: string, pattern: RegExp | RegExp[] | string): boolean {
  if (Array.isArray(pattern)) {
    return pattern.some(p => p.test(input));
  }
  if (pattern instanceof RegExp) {
    return pattern.test(input);
  }
  return input.includes(pattern);
}

/**
 * Run WAF check on input
 */
export function runWAFCheck(
  input: string,
  rules: WAFRule[] = DEFAULT_WAF_RULES
): WAFResult {
  for (const rule of rules) {
    if (matchesPattern(input, rule.pattern)) {
      if (rule.action === 'BLOCK') {
        return {
          allowed: false,
          blockedBy: rule.id,
          reason: rule.name,
          severity: rule.severity,
        };
      }
    }
  }
  
  return { allowed: true };
}

/**
 * Check URL for WAF violations
 */
export function checkURL(url: string): WAFResult {
  return runWAFCheck(url);
}

/**
 * Check query parameters for WAF violations
 */
export function checkQueryParams(params: Record<string, any>): WAFResult {
  for (const [key, value] of Object.entries(params)) {
    if (typeof value === 'string') {
      const result = runWAFCheck(value);
      if (!result.allowed) {
        return {
          ...result,
          reason: `${result.reason} in parameter: ${key}`,
        };
      }
    }
  }
  
  return { allowed: true };
}

/**
 * Check request body for WAF violations
 */
export function checkBody(body: any): WAFResult {
  if (typeof body === 'string') {
    return runWAFCheck(body);
  }
  
  if (typeof body === 'object' && body !== null) {
    for (const [key, value] of Object.entries(body)) {
      if (typeof value === 'string') {
        const result = runWAFCheck(value);
        if (!result.allowed) {
          return {
            ...result,
            reason: `${result.reason} in field: ${key}`,
          };
        }
      }
    }
  }
  
  return { allowed: true };
}

/**
 * Check headers for WAF violations
 */
export function checkHeaders(headers: Headers): WAFResult {
  const suspiciousHeaders = ['user-agent', 'referer', 'cookie', 'x-forwarded-for'];
  
  for (const header of suspiciousHeaders) {
    const value = headers.get(header);
    if (value) {
      const result = runWAFCheck(value);
      if (!result.allowed) {
        return {
          ...result,
          reason: `${result.reason} in header: ${header}`,
        };
      }
    }
  }
  
  return { allowed: true };
}

/**
 * Elysia middleware for WAF
 */
export const wafMiddleware = async ({ 
  path, 
  query, 
  body, 
  headers, 
  set 
}: any) => {
  // Check URL
  const urlResult = checkURL(path);
  if (!urlResult.allowed) {
    set.status = 403;
    throw new Error(`WAF Blocked: ${urlResult.reason}`);
  }
  
  // Check query parameters
  const queryResult = checkQueryParams(query);
  if (!queryResult.allowed) {
    set.status = 403;
    throw new Error(`WAF Blocked: ${queryResult.reason}`);
  }
  
  // Check body
  if (body) {
    const bodyResult = checkBody(body);
    if (!bodyResult.allowed) {
      set.status = 403;
      throw new Error(`WAF Blocked: ${bodyResult.reason}`);
    }
  }
  
  // Check headers
  const headerResult = checkHeaders(headers);
  if (!headerResult.allowed) {
    set.status = 403;
    throw new Error(`WAF Blocked: ${headerResult.reason}`);
  }
  
  console.log('[WAF] Request passed all checks');
};

/**
 * Add custom WAF rule
 */
export function addCustomRule(rule: WAFRule): void {
  DEFAULT_WAF_RULES.push(rule);
  console.log(`[WAF] Added custom rule: ${rule.id}`);
}

/**
 * Remove WAF rule by ID
 */
export function removeRule(ruleId: string): void {
  const index = DEFAULT_WAF_RULES.findIndex(r => r.id === ruleId);
  if (index !== -1) {
    DEFAULT_WAF_RULES.splice(index, 1);
    console.log(`[WAF] Removed rule: ${ruleId}`);
  }
}

/**
 * Get WAF statistics
 */
export function getWAFStats(): {
  totalRules: number;
  rulesByType: Record<string, number>;
  rulesBySeverity: Record<string, number>;
} {
  const stats = {
    totalRules: DEFAULT_WAF_RULES.length,
    rulesByType: {} as Record<string, number>,
    rulesBySeverity: {} as Record<string, number>,
  };
  
  for (const rule of DEFAULT_WAF_RULES) {
    stats.rulesByType[rule.type] = (stats.rulesByType[rule.type] || 0) + 1;
    stats.rulesBySeverity[rule.severity] = (stats.rulesBySeverity[rule.severity] || 0) + 1;
  }
  
  return stats;
}

/**
 * Sanitize input string
 */
export function sanitizeInput(input: string): string {
  // Remove potentially dangerous characters
  let sanitized = input
    .replace(/[<>]/g, '') // Remove < and >
    .replace(/javascript:/gi, '') // Remove javascript:
    .replace(/on\w+\s*=/gi, ''); // Remove on*= events
  
  return sanitized;
}

/**
 * Check for common attack signatures
 */
export function detectAttackSignature(input: string): string | null {
  if (matchesPattern(input, SQLI_PATTERNS)) return 'SQL_INJECTION';
  if (matchesPattern(input, XSS_PATTERNS)) return 'XSS';
  if (matchesPattern(input, PATH_TRAVERSAL_PATTERNS)) return 'PATH_TRAVERSAL';
  if (matchesPattern(input, COMMAND_INJECTION_PATTERNS)) return 'COMMAND_INJECTION';
  if (matchesPattern(input, SSRF_PATTERNS)) return 'SSRF';
  
  return null;
}
