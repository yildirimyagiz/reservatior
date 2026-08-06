/**
 * Security OS Bridge
 * Integrates sandbox audit logging with Security OS event bus
 * Enables real-time threat detection and automated response
 */

import { logAuditEvent, AuditEventType } from './sandbox-audit-logger';

export interface SecurityOSEvent {
  eventType: string;
  timestamp: Date;
  source: string;
  severity: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  tenantId?: string;
  userId?: string;
  ipAddress: string;
  userAgent: string;
  resource?: string;
  action?: string;
  details?: any;
}

export interface SOARPlaybookTrigger {
  playbookId: string;
  triggerEvent: AuditEventType;
  conditions: Record<string, any>;
  autoExecute: boolean;
}

/**
 * Publish event to Security OS event bus
 */
export async function publishToSecurityOSEvent(event: SecurityOSEvent): Promise<void> {
  try {
    // In production, send to Security OS via:
    // 1. NATS/Kafka message bus
    // 2. HTTP webhook
    // 3. gRPC stream
    
    const securityOSUrl = process.env.SECURITY_OS_URL || 'http://localhost:8080';
    
    // For now, log to console
    console.log('[Security OS Bridge] Publishing event:', {
      eventType: event.eventType,
      severity: event.severity,
      tenantId: event.tenantId,
      userId: event.userId,
      resource: event.resource,
      timestamp: event.timestamp,
    });
    
    // TODO: Implement actual Security OS integration
    // await fetch(`${securityOSUrl}/api/events`, {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify(event),
    // });
  } catch (error) {
    console.error('[Security OS Bridge] Failed to publish event:', error);
  }
}

/**
 * Map sandbox audit event to Security OS event
 */
export function mapAuditEventToSecurityOSEvent(
  eventType: AuditEventType,
  userId?: string,
  orgId?: string,
  role?: string,
  ipAddress: string,
  userAgent: string,
  resource?: string,
  action?: string,
  details?: any
): SecurityOSEvent {
  const severityMap: Record<AuditEventType, 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL'> = {
    [AuditEventType.TENANT_ISOLATION_BREACH]: 'CRITICAL',
    [AuditEventType.CROSS_TENANT_ACCESS]: 'CRITICAL',
    [AuditEventType.NETWORK_SEGMENT_VIOLATION]: 'HIGH',
    [AuditEventType.SEGMENT_TRANSITION]: 'LOW',
    [AuditEventType.FILE_ACCESS_DENIED]: 'HIGH',
    [AuditEventType.FILE_OUTSIDE_SANDBOX]: 'CRITICAL',
    [AuditEventType.FILE_UPLOAD]: 'LOW',
    [AuditEventType.FILE_DELETE]: 'MEDIUM',
    [AuditEventType.PERMISSION_DENIED]: 'MEDIUM',
    [AuditEventType.PERMISSION_GRANTED]: 'LOW',
    [AuditEventType.QUOTA_EXCEEDED]: 'MEDIUM',
    [AuditEventType.QUOTA_RESET]: 'LOW',
    [AuditEventType.RATE_LIMIT_EXCEEDED]: 'LOW',
    [AuditEventType.AUTH_SUCCESS]: 'LOW',
    [AuditEventType.AUTH_FAILURE]: 'HIGH',
    [AuditEventType.TOKEN_EXPIRED]: 'MEDIUM',
    [AuditEventType.DATA_READ]: 'LOW',
    [AuditEventType.DATA_WRITE]: 'MEDIUM',
    [AuditEventType.DATA_DELETE]: 'MEDIUM',
    [AuditEventType.ADMIN_ACTION]: 'HIGH',
    [AuditEventType.CONFIG_CHANGE]: 'HIGH',
  };
  
  return {
    eventType,
    timestamp: new Date(),
    source: 'sandbox',
    severity: severityMap[eventType] || 'MEDIUM',
    tenantId: orgId,
    userId,
    ipAddress,
    userAgent,
    resource,
    action,
    details: {
      ...details,
      role,
    },
  };
}

/**
 * Enhanced audit logging with Security OS integration
 */
export async function logAuditEventWithSecurityOS(
  eventType: AuditEventType,
  userId?: string,
  orgId?: string,
  role?: string,
  ipAddress: string,
  userAgent: string,
  resource?: string,
  action?: string,
  details?: any
): Promise<void> {
  // Log to internal audit system
  await logAuditEvent({
    eventType,
    userId,
    orgId,
    role,
    ipAddress,
    userAgent,
    resource,
    action,
    details,
    severity: mapAuditEventToSecurityOSEvent(
      eventType,
      userId,
      orgId,
      role,
      ipAddress,
      userAgent,
      resource,
      action,
      details
    ).severity,
  });
  
  // Publish to Security OS event bus
  const securityOSEvent = mapAuditEventToSecurityOSEvent(
    eventType,
    userId,
    orgId,
    role,
    ipAddress,
    userAgent,
    resource,
    action,
    details
  );
  
  await publishToSecurityOSEvent(securityOSEvent);
}

/**
 * SOAR playbook triggers for sandbox violations
 */
export const SOAR_TRIGGERS: SOARPlaybookTrigger[] = [
  {
    playbookId: 'isolate-compromised-tenant',
    triggerEvent: AuditEventType.TENANT_ISOLATION_BREACH,
    conditions: {
      severity: 'CRITICAL',
      autoIsolate: true,
    },
    autoExecute: true,
  },
  {
    playbookId: 'block-malicious-ip',
    triggerEvent: AuditEventType.AUTH_FAILURE,
    conditions: {
      consecutiveFailures: 5,
      timeWindow: 300, // 5 minutes
    },
    autoExecute: true,
  },
  {
    playbookId: 'investigate-file-access',
    triggerEvent: AuditEventType.FILE_ACCESS_DENIED,
    conditions: {
      severity: 'HIGH',
    },
    autoExecute: false, // Requires manual approval
  },
  {
    playbookId: 'quota-escalation-review',
    triggerEvent: AuditEventType.QUOTA_EXCEEDED,
    conditions: {
      percentage: 90,
    },
    autoExecute: false,
  },
];

/**
 * Check if event triggers a SOAR playbook
 */
export function checkSOARTrigger(
  eventType: AuditEventType,
  details?: any
): SOARPlaybookTrigger | null {
  for (const trigger of SOAR_TRIGGERS) {
    if (trigger.triggerEvent === eventType) {
      // Check conditions
      let conditionsMet = true;
      
      for (const [key, value] of Object.entries(trigger.conditions)) {
        if (details && details[key] !== value) {
          conditionsMet = false;
          break;
        }
      }
      
      if (conditionsMet) {
        return trigger;
      }
    }
  }
  
  return null;
}

/**
 * Trigger SOAR playbook
 */
export async function triggerSOARPlaybook(
  playbookId: string,
  event: SecurityOSEvent
): Promise<void> {
  try {
    const securityOSUrl = process.env.SECURITY_OS_URL || 'http://localhost:8080';
    
    console.log(`[SOAR] Triggering playbook: ${playbookId}`, event);
    
    // TODO: Implement actual SOAR integration
    // await fetch(`${securityOSUrl}/api/soar/playbooks/${playbookId}/execute`, {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify({ event }),
    // });
  } catch (error) {
    console.error('[SOAR] Failed to trigger playbook:', error);
  }
}

/**
 * Knowledge graph node creation for sandbox entities
 */
export async function createKnowledgeGraphNode(
  nodeType: 'Tenant' | 'User' | 'Resource' | 'File' | 'NetworkSegment',
  nodeId: string,
  properties: Record<string, any>
): Promise<void> {
  try {
    const securityOSUrl = process.env.SECURITY_OS_URL || 'http://localhost:8080';
    
    console.log(`[Knowledge Graph] Creating node: ${nodeType}:${nodeId}`, properties);
    
    // TODO: Implement actual knowledge graph integration
    // await fetch(`${securityOSUrl}/api/knowledge-graph/nodes`, {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify({
    //     type: nodeType,
    //     id: nodeId,
    //     properties,
    //   }),
    // });
  } catch (error) {
    console.error('[Knowledge Graph] Failed to create node:', error);
  }
}

/**
 * Create relationship in knowledge graph
 */
export async function createKnowledgeGraphRelationship(
  fromNode: { type: string; id: string },
  toNode: { type: string; id: string },
  relationshipType: string,
  properties?: Record<string, any>
): Promise<void> {
  try {
    const securityOSUrl = process.env.SECURITY_OS_URL || 'http://localhost:8080';
    
    console.log(`[Knowledge Graph] Creating relationship: ${fromNode.type}:${fromNode.id} -> ${toNode.type}:${toNode.id} (${relationshipType})`);
    
    // TODO: Implement actual knowledge graph integration
    // await fetch(`${securityOSUrl}/api/knowledge-graph/relationships`, {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify({
    //     from: fromNode,
    //     to: toNode,
    //     type: relationshipType,
    //     properties,
    //   }),
    // });
  } catch (error) {
    console.error('[Knowledge Graph] Failed to create relationship:', error);
  }
}
