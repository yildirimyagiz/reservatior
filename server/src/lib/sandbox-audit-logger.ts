/**
 * Sandbox Audit Logger
 * Comprehensive logging for all sandbox boundary crossings
 * Immutable audit trail for security compliance
 */

import { prisma } from './prisma';

export enum AuditEventType {
  // Tenant isolation
  TENANT_ISOLATION_BREACH = 'TENANT_ISOLATION_BREACH',
  CROSS_TENANT_ACCESS = 'CROSS_TENANT_ACCESS',
  
  // Network segmentation
  NETWORK_SEGMENT_VIOLATION = 'NETWORK_SEGMENT_VIOLATION',
  SEGMENT_TRANSITION = 'SEGMENT_TRANSITION',
  
  // File system
  FILE_ACCESS_DENIED = 'FILE_ACCESS_DENIED',
  FILE_OUTSIDE_SANDBOX = 'FILE_OUTSIDE_SANDBOX',
  FILE_UPLOAD = 'FILE_UPLOAD',
  FILE_DELETE = 'FILE_DELETE',
  
  // Permission
  PERMISSION_DENIED = 'PERMISSION_DENIED',
  PERMISSION_GRANTED = 'PERMISSION_GRANTED',
  
  // Quota
  QUOTA_EXCEEDED = 'QUOTA_EXCEEDED',
  QUOTA_RESET = 'QUOTA_RESET',
  
  // Rate limiting
  RATE_LIMIT_EXCEEDED = 'RATE_LIMIT_EXCEEDED',
  
  // Authentication
  AUTH_SUCCESS = 'AUTH_SUCCESS',
  AUTH_FAILURE = 'AUTH_FAILURE',
  TOKEN_EXPIRED = 'TOKEN_EXPIRED',
  
  // Data access
  DATA_READ = 'DATA_READ',
  DATA_WRITE = 'DATA_WRITE',
  DATA_DELETE = 'DATA_DELETE',
  
  // Admin actions
  ADMIN_ACTION = 'ADMIN_ACTION',
  CONFIG_CHANGE = 'CONFIG_CHANGE',
}

export interface AuditLogEntry {
  id: string;
  eventType: AuditEventType;
  userId?: string;
  orgId?: string;
  role?: string;
  ipAddress: string;
  userAgent: string;
  resource?: string;
  action?: string;
  details?: any;
  severity: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  timestamp: Date;
}

/**
 * Log audit event
 */
export async function logAuditEvent(entry: Omit<AuditLogEntry, 'id' | 'timestamp'>): Promise<void> {
  try {
    // Write to database (using LegalAuditLog for compliance)
    await prisma.legalAuditLog.create({
      data: {
        userId: entry.userId,
        contractType: 'AUDIT',
        contractVersion: 'SANDBOX_v1.0',
        action: entry.eventType,
        ipAddress: entry.ipAddress,
        userAgent: entry.userAgent,
        metadata: {
          resource: entry.resource,
          action: entry.action,
          details: entry.details,
          severity: entry.severity,
          orgId: entry.orgId,
          role: entry.role,
        },
      },
    });
    
    // Also log to console for immediate visibility
    console.log(`[Audit] ${entry.severity} - ${entry.eventType}`, {
      userId: entry.userId,
      orgId: entry.orgId,
      role: entry.role,
      resource: entry.resource,
      action: entry.action,
      ipAddress: entry.ipAddress,
      timestamp: new Date().toISOString(),
    });
    
    // For critical events, trigger alert
    if (entry.severity === 'CRITICAL') {
      await triggerSecurityAlert(entry);
    }
  } catch (error) {
    console.error('[Audit] Failed to log event:', error);
    // Fallback to console only
    console.log(`[Audit] ${entry.eventType}`, entry);
  }
}

/**
 * Log tenant isolation breach
 */
export async function logTenantIsolationBreach(
  userId: string,
  orgId: string,
  targetOrgId: string,
  ipAddress: string,
  userAgent: string,
  details?: any
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.TENANT_ISOLATION_BREACH,
    userId,
    orgId,
    resource: 'tenant',
    action: 'cross_tenant_access',
    ipAddress,
    userAgent,
    severity: 'CRITICAL',
    details: {
      targetOrgId,
      ...details,
    },
  });
}

/**
 * Log network segment violation
 */
export async function logNetworkSegmentViolation(
  userId: string,
  orgId: string,
  role: string,
  fromSegment: string,
  toSegment: string,
  path: string,
  ipAddress: string,
  userAgent: string
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.NETWORK_SEGMENT_VIOLATION,
    userId,
    orgId,
    role,
    resource: 'network_segment',
    action: 'segment_transition',
    ipAddress,
    userAgent,
    severity: 'HIGH',
    details: {
      fromSegment,
      toSegment,
      path,
    },
  });
}

/**
 * Log file access denied
 */
export async function logFileAccessDenied(
  userId: string,
  orgId: string,
  filePath: string,
  action: string,
  ipAddress: string,
  userAgent: string
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.FILE_ACCESS_DENIED,
    userId,
    orgId,
    resource: filePath,
    action,
    ipAddress,
    userAgent,
    severity: 'HIGH',
    details: {
      filePath,
      requestedAction: action,
    },
  });
}

/**
 * Log permission denied
 */
export async function logPermissionDenied(
  userId: string,
  orgId: string,
  role: string,
  requiredPermission: string,
  resource: string,
  action: string,
  ipAddress: string,
  userAgent: string
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.PERMISSION_DENIED,
    userId,
    orgId,
    role,
    resource,
    action,
    ipAddress,
    userAgent,
    severity: 'MEDIUM',
    details: {
      requiredPermission,
    },
  });
}

/**
 * Log quota exceeded
 */
export async function logQuotaExceeded(
  orgId: string,
  resource: string,
  limit: number,
  usage: number,
  ipAddress: string,
  userAgent: string
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.QUOTA_EXCEEDED,
    orgId,
    resource,
    action: 'quota_check',
    ipAddress,
    userAgent,
    severity: 'MEDIUM',
    details: {
      limit,
      usage,
      percentage: (usage / limit) * 100,
    },
  });
}

/**
 * Log rate limit exceeded
 */
export async function logRateLimitExceeded(
  identifier: string,
  limit: number,
  window: number,
  ipAddress: string,
  userAgent: string
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.RATE_LIMIT_EXCEEDED,
    resource: identifier,
    action: 'rate_limit_check',
    ipAddress,
    userAgent,
    severity: 'LOW',
    details: {
      identifier,
      limit,
      window,
    },
  });
}

/**
 * Log authentication failure
 */
export async function logAuthFailure(
  emailOrPhone: string,
  reason: string,
  ipAddress: string,
  userAgent: string
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.AUTH_FAILURE,
    resource: emailOrPhone,
    action: 'authentication',
    ipAddress,
    userAgent,
    severity: 'HIGH',
    details: {
      reason,
    },
  });
}

/**
 * Log data access
 */
export async function logDataAccess(
  userId: string,
  orgId: string,
  resource: string,
  action: 'read' | 'write' | 'delete',
  ipAddress: string,
  userAgent: string,
  details?: any
): Promise<void> {
  const severity = action === 'delete' ? 'MEDIUM' : 'LOW';
  
  await logAuditEvent({
    eventType: action === 'read' ? AuditEventType.DATA_READ :
                 action === 'write' ? AuditEventType.DATA_WRITE :
                 AuditEventType.DATA_DELETE,
    userId,
    orgId,
    resource,
    action,
    ipAddress,
    userAgent,
    severity,
    details,
  });
}

/**
 * Log admin action
 */
export async function logAdminAction(
  userId: string,
  orgId: string,
  action: string,
  resource: string,
  ipAddress: string,
  userAgent: string,
  details?: any
): Promise<void> {
  await logAuditEvent({
    eventType: AuditEventType.ADMIN_ACTION,
    userId,
    orgId,
    resource,
    action,
    ipAddress,
    userAgent,
    severity: 'HIGH',
    details,
  });
}

/**
 * Trigger security alert for critical events
 */
async function triggerSecurityAlert(entry: Omit<AuditLogEntry, 'id' | 'timestamp'>): Promise<void> {
  // In production, send to:
  // - Security team email
  // - Slack webhook
  // - PagerDuty
  // - SIEM system
  
  console.log('[SECURITY ALERT]', {
    severity: entry.severity,
    eventType: entry.eventType,
    userId: entry.userId,
    orgId: entry.orgId,
    ipAddress: entry.ipAddress,
    timestamp: new Date().toISOString(),
  });
}

/**
 * Get audit logs for organization
 */
export async function getAuditLogs(
  orgId: string,
  limit: number = 100,
  offset: number = 0
): Promise<AuditLogEntry[]> {
  const logs = await prisma.legalAuditLog.findMany({
    where: {
      orgId,
      contractType: 'AUDIT',
    },
    orderBy: {
      timestamp: 'desc',
    },
    take: limit,
    skip: offset,
  });
  
  return logs.map(log => ({
    id: log.id,
    eventType: log.action as AuditEventType,
    userId: log.userId || undefined,
    orgId: log.orgId || undefined,
    role: log.metadata?.role,
    ipAddress: log.ipAddress,
    userAgent: log.userAgent,
    resource: log.metadata?.resource,
    action: log.metadata?.action,
    details: log.metadata?.details,
    severity: log.metadata?.severity || 'LOW',
    timestamp: log.timestamp,
  }));
}

/**
 * Get critical audit logs
 */
export async function getCriticalAuditLogs(
  hours: number = 24
): Promise<AuditLogEntry[]> {
  const since = new Date(Date.now() - hours * 60 * 60 * 1000);
  
  const logs = await prisma.legalAuditLog.findMany({
    where: {
      contractType: 'AUDIT',
      timestamp: {
        gte: since,
      },
    },
    orderBy: {
      timestamp: 'desc',
    },
  });
  
  return logs
    .filter(log => log.metadata?.severity === 'CRITICAL' || log.metadata?.severity === 'HIGH')
    .map(log => ({
      id: log.id,
      eventType: log.action as AuditEventType,
      userId: log.userId || undefined,
      orgId: log.orgId || undefined,
      role: log.metadata?.role,
      ipAddress: log.ipAddress,
      userAgent: log.userAgent,
      resource: log.metadata?.resource,
      action: log.metadata?.action,
      details: log.metadata?.details,
      severity: log.metadata?.severity || 'LOW',
      timestamp: log.timestamp,
    }));
}

/**
 * Elysia middleware for audit logging
 */
export const auditLogMiddleware = async ({ 
  userId, 
  orgId, 
  role, 
  path, 
  method, 
  headers 
}: any) => {
  const ipAddress = headers.get('x-forwarded-for') || 
                   headers.get('cf-connecting-ip') || 
                   'unknown';
  const userAgent = headers.get('user-agent') || 'unknown';
  
  // Log API access
  await logDataAccess(
    userId,
    orgId,
    path,
    method.toLowerCase() as 'read' | 'write' | 'delete',
    ipAddress,
    userAgent,
    {
      method,
      path,
    }
  );
};
