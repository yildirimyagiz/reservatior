/**
 * Network Segmentation Middleware
 * Separates B2B and B2C traffic into isolated network contexts
 * Prevents cross-tenant data leakage and unauthorized access
 */

export enum NetworkSegment {
  B2B = 'b2b',
  B2C = 'b2c',
  INTERNAL = 'internal',
  PUBLIC = 'public',
}

export interface NetworkContext {
  segment: NetworkSegment;
  orgId?: string;
  userId?: string;
  role?: string;
  sourceIP: string;
}

// B2B routes (agent/agency only)
const B2B_ROUTES = [
  '/admin',
  '/api/agents',
  '/api/agencies',
  '/api/mls',
  '/api/ai/studio',
  '/api/commission',
  '/api/lead-management',
  '/client/agent-os',
];

// B2C routes (property owner/tenant only)
const B2C_ROUTES = [
  '/property',
  '/leases',
  '/financial-payouts',
  '/my-properties',
  '/ownership-verification',
  '/tenant-portal',
];

// Internal routes (admin/system only)
const INTERNAL_ROUTES = [
  '/system',
  '/admin/config',
  '/health/internal',
  '/metrics',
];

// Public routes (no authentication required)
const PUBLIC_ROUTES = [
  '/public',
  '/auth/login',
  '/auth/register',
  '/health',
  '/claim',
];

/**
 * Determine network segment from path
 */
export function determineNetworkSegment(path: string): NetworkSegment {
  if (PUBLIC_ROUTES.some(route => path.startsWith(route))) {
    return NetworkSegment.PUBLIC;
  }
  
  if (INTERNAL_ROUTES.some(route => path.startsWith(route))) {
    return NetworkSegment.INTERNAL;
  }
  
  if (B2B_ROUTES.some(route => path.startsWith(route))) {
    return NetworkSegment.B2B;
  }
  
  if (B2C_ROUTES.some(route => path.startsWith(route))) {
    return NetworkSegment.B2C;
  }
  
  // Default to B2C for unknown routes
  return NetworkSegment.B2C;
}

/**
 * Check if route is accessible from given segment
 */
export function isRouteAccessible(
  path: string,
  segment: NetworkSegment
): boolean {
  const routeSegment = determineNetworkSegment(path);
  
  // Public routes accessible from all segments
  if (routeSegment === NetworkSegment.PUBLIC) {
    return true;
  }
  
  // Internal routes only from internal segment
  if (routeSegment === NetworkSegment.INTERNAL) {
    return segment === NetworkSegment.INTERNAL;
  }
  
  // B2B routes only from B2B segment
  if (routeSegment === NetworkSegment.B2B) {
    return segment === NetworkSegment.B2B;
  }
  
  // B2C routes only from B2C segment
  if (routeSegment === NetworkSegment.B2C) {
    return segment === NetworkSegment.B2C;
  }
  
  return false;
}

/**
 * Elysia middleware for network segmentation
 */
export const networkSegmentationMiddleware = async ({ 
  path, 
  headers, 
  set, 
  role 
}: any) => {
  const sourceIP = headers.get('x-forwarded-for') || 
                   headers.get('cf-connecting-ip') || 
                   'unknown';
  
  // Determine segment from user role
  let segment: NetworkSegment;
  
  if (role === 'SUPER_ADMIN' || role === 'SYSTEM_ADMIN') {
    segment = NetworkSegment.INTERNAL;
  } else if (role === 'AGENT' || role === 'AGENCY_MGR' || role === 'AGENCY_ADMIN') {
    segment = NetworkSegment.B2B;
  } else {
    segment = NetworkSegment.B2C;
  }
  
  // Check if route is accessible from this segment
  if (!isRouteAccessible(path, segment)) {
    set.status = 403;
    throw new Error(`Forbidden: This route is not accessible from ${segment} network segment`);
  }
  
  // Set network context
  return {
    networkContext: {
      segment,
      sourceIP,
    },
  };
};

/**
 * IP-based network segmentation (for anonymous requests)
 */
export const ipNetworkSegmentationMiddleware = async ({ 
  path, 
  headers, 
  set 
}: any) => {
  const sourceIP = headers.get('x-forwarded-for') || 
                   headers.get('cf-connecting-ip') || 
                   'unknown';
  
  const segment = determineNetworkSegment(path);
  
  // Public routes accessible without authentication
  if (segment === NetworkSegment.PUBLIC) {
    return {
      networkContext: {
        segment: NetworkSegment.PUBLIC,
        sourceIP,
      },
    };
  }
  
  // Other segments require authentication
  set.status = 401;
  throw new Error('Authentication required for this network segment');
};

/**
 * Check if IP is from trusted network
 */
export function isTrustedNetwork(ip: string): boolean {
  const trustedNetworks = [
    '10.0.0.0/8',
    '172.16.0.0/12',
    '192.168.0.0/16',
    '127.0.0.1',
  ];
  
  // Simplified check - in production use proper CIDR matching
  return trustedNetworks.some(network => {
    if (network.includes('/')) {
      const [base] = network.split('/');
      return ip.startsWith(base.split('.').slice(0, -1).join('.'));
    }
    return ip === network;
  });
}

/**
 * Network segment transition logging
 */
export function logNetworkSegmentTransition(
  context: NetworkContext,
  fromSegment: NetworkSegment,
  toSegment: NetworkSegment,
  action: string
) {
  console.log('[Network Segment Transition]', {
    timestamp: new Date().toISOString(),
    userId: context.userId,
    orgId: context.orgId,
    role: context.role,
    sourceIP: context.sourceIP,
    fromSegment,
    toSegment,
    action,
  });
  
  // In production, write to audit log
  // await prisma.networkSegmentAuditLog.create({ ... });
}

/**
 * Get network segment statistics
 */
export async function getNetworkSegmentStats(): Promise<{
  b2b: { requests: number; activeConnections: number };
  b2c: { requests: number; activeConnections: number };
  internal: { requests: number; activeConnections: number };
  public: { requests: number; activeConnections: number };
}> {
  // In production, query Redis or metrics system
  return {
    b2b: { requests: 0, activeConnections: 0 },
    b2c: { requests: 0, activeConnections: 0 },
    internal: { requests: 0, activeConnections: 0 },
    public: { requests: 0, activeConnections: 0 },
  };
}

/**
 * Rate limiting per network segment
 */
export const networkSegmentRateLimit = async ({ 
  networkContext, 
  set 
}: any) => {
  const { segment } = networkContext;
  
  // Different rate limits per segment
  const limits: Record<NetworkSegment, { requests: number; window: number }> = {
    [NetworkSegment.B2B]: { requests: 2000, window: 60 },
    [NetworkSegment.B2C]: { requests: 500, window: 60 },
    [NetworkSegment.INTERNAL]: { requests: 10000, window: 60 },
    [NetworkSegment.PUBLIC]: { requests: 100, window: 60 },
  };
  
  const limit = limits[segment];
  
  // Check rate limit (reuse existing rate limit function)
  const { checkRateLimit } = await import('./api-gateway-rate-limit');
  const result = await checkRateLimit(`segment:${segment}`, limit);
  
  set.headers = {
    ...set.headers,
    'X-Network-Segment': segment,
    'X-RateLimit-Limit': result.limit.toString(),
    'X-RateLimit-Remaining': result.remaining.toString(),
  };
  
  if (!result.allowed) {
    set.status = 429;
    throw new Error(`Rate limit exceeded for ${segment} network segment`);
  }
  
  return result;
};
