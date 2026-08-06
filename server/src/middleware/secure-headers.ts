/**
 * Secure Headers Middleware
 * Implements security headers: HSTS, CSP, X-Frame-Options, etc.
 * Protects against clickjacking, XSS, MIME sniffing, and other attacks
 */

export interface SecureHeadersConfig {
  hsts?: {
    maxAge: number;
    includeSubDomains: boolean;
    preload: boolean;
  };
  csp?: {
    defaultSrc: string[];
    scriptSrc: string[];
    styleSrc: string[];
    imgSrc: string[];
    connectSrc: string[];
    fontSrc: string[];
    objectSrc: string[];
    mediaSrc: string[];
    frameSrc: string[];
    frameAncestors: string[];
    baseUri: string[];
    formAction: string[];
  };
  frameOptions?: 'DENY' | 'SAMEORIGIN' | 'ALLOW-FROM';
  xContentTypeOptions?: boolean;
  referrerPolicy?: string;
  permissionsPolicy?: Record<string, string[]>;
}

// Default secure headers configuration
const DEFAULT_CONFIG: SecureHeadersConfig = {
  hsts: {
    maxAge: 31536000, // 1 year
    includeSubDomains: true,
    preload: true,
  },
  csp: {
    defaultSrc: ["'self'"],
    scriptSrc: ["'self'", "'unsafe-inline'", "'unsafe-eval'", "https://cdn.jsdelivr.net"],
    styleSrc: ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com"],
    imgSrc: ["'self'", "data:", "https:", "blob:"],
    connectSrc: ["'self'", "https://api.reservatior.com", "wss://api.reservatior.com"],
    fontSrc: ["'self'", "https://fonts.gstatic.com"],
    objectSrc: ["'none'"],
    mediaSrc: ["'self'"],
    frameSrc: ["'self'"],
    frameAncestors: ["'none'"],
    baseUri: ["'self'"],
    formAction: ["'self'"],
  },
  frameOptions: 'DENY',
  xContentTypeOptions: true,
  referrerPolicy: 'strict-origin-when-cross-origin',
  permissionsPolicy: {
    geolocation: ["'self'"],
    microphone: ["'none'"],
    camera: ["'none'"],
    payment: ["'none'"],
    usb: ["'none'"],
    magnetometer: ["'none'"],
    accelerometer: ["'none'"],
    gyroscope: ["'none'"],
  },
};

/**
 * Build HSTS header value
 */
function buildHSTSHeader(config: SecureHeadersConfig['hsts']): string {
  if (!config) return '';
  
  let value = `max-age=${config.maxAge}`;
  
  if (config.includeSubDomains) {
    value += '; includeSubDomains';
  }
  
  if (config.preload) {
    value += '; preload';
  }
  
  return value;
}

/**
 * Build CSP header value
 */
function buildCSPHeader(config: SecureHeadersConfig['csp']): string {
  if (!config) return '';
  
  const directives: string[] = [];
  
  if (config.defaultSrc) directives.push(`default-src ${config.defaultSrc.join(' ')}`);
  if (config.scriptSrc) directives.push(`script-src ${config.scriptSrc.join(' ')}`);
  if (config.styleSrc) directives.push(`style-src ${config.styleSrc.join(' ')}`);
  if (config.imgSrc) directives.push(`img-src ${config.imgSrc.join(' ')}`);
  if (config.connectSrc) directives.push(`connect-src ${config.connectSrc.join(' ')}`);
  if (config.fontSrc) directives.push(`font-src ${config.fontSrc.join(' ')}`);
  if (config.objectSrc) directives.push(`object-src ${config.objectSrc.join(' ')}`);
  if (config.mediaSrc) directives.push(`media-src ${config.mediaSrc.join(' ')}`);
  if (config.frameSrc) directives.push(`frame-src ${config.frameSrc.join(' ')}`);
  if (config.frameAncestors) directives.push(`frame-ancestors ${config.frameAncestors.join(' ')}`);
  if (config.baseUri) directives.push(`base-uri ${config.baseUri.join(' ')}`);
  if (config.formAction) directives.push(`form-action ${config.formAction.join(' ')}`);
  
  directives.push('upgrade-insecure-requests');
  
  return directives.join('; ');
}

/**
 * Build Permissions-Policy header value
 */
function buildPermissionsPolicyHeader(config: Record<string, string[]>): string {
  const policies: string[] = [];
  
  for (const [feature, allowed] of Object.entries(config)) {
    policies.push(`${feature}=(${allowed.join(' ')})`);
  }
  
  return policies.join(', ');
}

/**
 * Get secure headers object
 */
export function getSecureHeaders(config: SecureHeadersConfig = DEFAULT_CONFIG): Record<string, string> {
  const headers: Record<string, string> = {};
  
  // HSTS
  if (config.hsts) {
    headers['Strict-Transport-Security'] = buildHSTSHeader(config.hsts);
  }
  
  // CSP
  if (config.csp) {
    headers['Content-Security-Policy'] = buildCSPHeader(config.csp);
  }
  
  // X-Frame-Options
  if (config.frameOptions) {
    headers['X-Frame-Options'] = config.frameOptions;
  }
  
  // X-Content-Type-Options
  if (config.xContentTypeOptions) {
    headers['X-Content-Type-Options'] = 'nosniff';
  }
  
  // Referrer-Policy
  if (config.referrerPolicy) {
    headers['Referrer-Policy'] = config.referrerPolicy;
  }
  
  // Permissions-Policy
  if (config.permissionsPolicy) {
    headers['Permissions-Policy'] = buildPermissionsPolicyHeader(config.permissionsPolicy);
  }
  
  // Additional security headers
  headers['X-XSS-Protection'] = '1; mode=block';
  headers['X-Download-Options'] = 'noopen';
  headers['X-Permitted-Cross-Domain-Policies'] = 'none';
  headers['Cross-Origin-Opener-Policy'] = 'same-origin';
  headers['Cross-Origin-Resource-Policy'] = 'same-origin';
  headers['Cross-Origin-Embedder-Policy'] = 'require-corp';
  
  return headers;
}

/**
 * Elysia middleware for secure headers
 */
export const secureHeadersMiddleware = async ({ set }: any) => {
  const headers = getSecureHeaders();
  
  set.headers = {
    ...set.headers,
    ...headers,
  };
  
  console.log('[Secure Headers] Applied security headers');
};

/**
 * Get CSP report-only header (for testing)
 */
export function getCSPReportOnlyHeader(config: SecureHeadersConfig = DEFAULT_CONFIG): string {
  return `Content-Security-Policy-Report-Only: ${buildCSPHeader(config.csp)}`;
}

/**
 * Nonce generator for CSP
 */
export function generateNonce(): string {
  return crypto.randomBytes(16).toString('base64');
}

/**
 * Get CSP with nonce for inline scripts
 */
export function getCSPWithNonce(nonce: string, config: SecureHeadersConfig = DEFAULT_CONFIG): string {
  const cspConfig = { ...config.csp };
  
  if (cspConfig.scriptSrc) {
    cspConfig.scriptSrc = [...cspConfig.scriptSrc, `'nonce-${nonce}'`];
  }
  
  if (cspConfig.styleSrc) {
    cspConfig.styleSrc = [...cspConfig.styleSrc, `'nonce-${nonce}'`];
  }
  
  return buildCSPHeader(cspConfig);
}

/**
 * Validate CSP configuration
 */
export function validateCSPConfig(config: SecureHeadersConfig['csp']): { valid: boolean; errors: string[] } {
  const errors: string[] = [];
  
  if (!config) {
    return { valid: false, errors: ['CSP configuration is required'] };
  }
  
  if (!config.defaultSrc || config.defaultSrc.length === 0) {
    errors.push('default-src is required');
  }
  
  if (config.scriptSrc && config.scriptSrc.includes("'unsafe-eval'")) {
    errors.push('unsafe-eval is discouraged in script-src');
  }
  
  if (config.objectSrc && !config.objectSrc.includes("'none'")) {
    errors.push('object-src should be set to none for better security');
  }
  
  return {
    valid: errors.length === 0,
    errors,
  };
}

/**
 * Get recommended CSP for different environments
 */
export function getRecommendedCSP(environment: 'development' | 'staging' | 'production'): SecureHeadersConfig['csp'] {
  if (environment === 'development') {
    return {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'", "'unsafe-eval'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'"],
      fontSrc: ["'self'"],
      objectSrc: ["'none'"],
      mediaSrc: ["'self'"],
      frameSrc: ["'self'"],
      frameAncestors: ["'self'"],
      baseUri: ["'self'"],
      formAction: ["'self'"],
    };
  }
  
  if (environment === 'staging') {
    return {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'", "https://cdn.jsdelivr.net"],
      styleSrc: ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com"],
      imgSrc: ["'self'", "data:", "https:"],
      connectSrc: ["'self'", "https://api.reservatior.com"],
      fontSrc: ["'self'", "https://fonts.gstatic.com"],
      objectSrc: ["'none'"],
      mediaSrc: ["'self'"],
      frameSrc: ["'self'"],
      frameAncestors: ["'self'"],
      baseUri: ["'self'"],
      formAction: ["'self'"],
    };
  }
  
  // Production - strictest
  return DEFAULT_CONFIG.csp;
}
