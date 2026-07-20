/**
 * Agent OS Permission Model
 * Defines granular permissions for agent operations
 */

export const AgentOSPermissions = {
  // Agent Management
  AGENT_CREATE: 'agent.create',
  AGENT_READ: 'agent.read',
  AGENT_UPDATE: 'agent.update',
  AGENT_DELETE: 'agent.delete',
  AGENT_INVITE: 'agent.invite',
  AGENT_VERIFY: 'agent.verify',
  AGENT_SUSPEND: 'agent.suspend',
  AGENT_REACTIVATE: 'agent.reactivate',
  
  // Agent Profile
  PROFILE_MANAGE: 'profile.manage',
  PROFILE_READ: 'profile.read',
  PROFILE_UPDATE: 'profile.update',
  PROFILE_VIEW_ALL: 'profile.view_all',
  
  // Agent Performance
  PERFORMANCE_VIEW: 'performance.view',
  PERFORMANCE_MANAGE: 'performance.manage',
  PERFORMANCE_EXPORT: 'performance.export',
  
  // Agent Commission
  COMMISSION_VIEW: 'commission.view',
  COMMISSION_MANAGE: 'commission.manage',
  COMMISSION_CALCULATE: 'commission.calculate',
  
  // Agent Network
  NETWORK_VIEW: 'network.view',
  NETWORK_MANAGE: 'network.manage',
  NETWORK_ANALYZE: 'network.analyze',
  
  // Agent Training
  TRAINING_ASSIGN: 'training.assign',
  TRAINING_VIEW: 'training.view',
  TRAINING_MANAGE: 'training.manage',
  
  // Agent Communication
  COMMUNICATION_SEND: 'communication.send',
  COMMUNICATION_VIEW: 'communication.view',
  COMMUNICATION_MANAGE: 'communication.manage',
  
  // Agent Analytics
  ANALYTICS_VIEW: 'analytics.view',
  ANALYTICS_ADVANCED: 'analytics.advanced',
  ANALYTICS_EXPORT: 'analytics.export',
  
  // Trust Scoring
  TRUST_VIEW: 'trust.view',
  TRUST_MANAGE: 'trust.manage',
  TRUST_ADJUST: 'trust.adjust',
  
  // Admin Operations
  AGENT_ADMIN_ALL: 'agent.admin.all',
  AGENT_ADMIN_OVERRIDE: 'agent.admin.override',
  AGENT_ADMIN_AUDIT: 'agent.admin.audit',
} as const;

export type AgentOSPermission = typeof AgentOSPermissions[keyof typeof AgentOSPermissions];

/**
 * Role-based permission mappings
 */
export const AgentOSRolePermissions: Record<string, AgentOSPermission[]> = {
  // Agent - Basic operations
  agent: [
    AgentOSPermissions.PROFILE_MANAGE,
    AgentOSPermissions.PROFILE_READ,
    AgentOSPermissions.PROFILE_UPDATE,
    AgentOSPermissions.PERFORMANCE_VIEW,
    AgentOSPermissions.COMMISSION_VIEW,
    AgentOSPermissions.NETWORK_VIEW,
    AgentOSPermissions.TRAINING_VIEW,
    AgentOSPermissions.COMMUNICATION_VIEW,
    AgentOSPermissions.ANALYTICS_VIEW,
    AgentOSPermissions.TRUST_VIEW,
  ],
  
  // Team Leader - Extended operations
  team_leader: [
    AgentOSPermissions.AGENT_READ,
    AgentOSPermissions.PROFILE_READ,
    AgentOSPermissions.PROFILE_VIEW_ALL,
    AgentOSPermissions.PERFORMANCE_VIEW,
    AgentOSPermissions.PERFORMANCE_MANAGE,
    AgentOSPermissions.COMMISSION_VIEW,
    AgentOSPermissions.NETWORK_VIEW,
    AgentOSPermissions.NETWORK_MANAGE,
    AgentOSPermissions.TRAINING_VIEW,
    AgentOSPermissions.TRAINING_ASSIGN,
    AgentOSPermissions.COMMUNICATION_VIEW,
    AgentOSPermissions.COMMUNICATION_SEND,
    AgentOSPermissions.ANALYTICS_VIEW,
    AgentOSPermissions.ANALYTICS_EXPORT,
    AgentOSPermissions.TRUST_VIEW,
  ],
  
  // Manager - Full agent management
  manager: [
    AgentOSPermissions.AGENT_CREATE,
    AgentOSPermissions.AGENT_READ,
    AgentOSPermissions.AGENT_UPDATE,
    AgentOSPermissions.AGENT_INVITE,
    AgentOSPermissions.AGENT_VERIFY,
    AgentOSPermissions.AGENT_SUSPEND,
    AgentOSPermissions.AGENT_REACTIVATE,
    AgentOSPermissions.PROFILE_MANAGE,
    AgentOSPermissions.PROFILE_READ,
    AgentOSPermissions.PROFILE_UPDATE,
    AgentOSPermissions.PROFILE_VIEW_ALL,
    AgentOSPermissions.PERFORMANCE_VIEW,
    AgentOSPermissions.PERFORMANCE_MANAGE,
    AgentOSPermissions.PERFORMANCE_EXPORT,
    AgentOSPermissions.COMMISSION_VIEW,
    AgentOSPermissions.COMMISSION_MANAGE,
    AgentOSPermissions.COMMISSION_CALCULATE,
    AgentOSPermissions.NETWORK_VIEW,
    AgentOSPermissions.NETWORK_MANAGE,
    AgentOSPermissions.NETWORK_ANALYZE,
    AgentOSPermissions.TRAINING_ASSIGN,
    AgentOSPermissions.TRAINING_VIEW,
    AgentOSPermissions.TRAINING_MANAGE,
    AgentOSPermissions.COMMUNICATION_VIEW,
    AgentOSPermissions.COMMUNICATION_SEND,
    AgentOSPermissions.COMMUNICATION_MANAGE,
    AgentOSPermissions.ANALYTICS_VIEW,
    AgentOSPermissions.ANALYTICS_ADVANCED,
    AgentOSPermissions.ANALYTICS_EXPORT,
    AgentOSPermissions.TRUST_VIEW,
    AgentOSPermissions.TRUST_MANAGE,
  ],
  
  // Admin - Full access
  admin: [
    AgentOSPermissions.AGENT_ADMIN_ALL,
    AgentOSPermissions.AGENT_ADMIN_OVERRIDE,
    AgentOSPermissions.AGENT_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasAgentPermission(
  userPermissions: string[],
  requiredPermission: AgentOSPermission
): boolean {
  if (userPermissions.includes(AgentOSPermissions.AGENT_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasAgentPermissions(
  userPermissions: string[],
  requiredPermissions: AgentOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasAgentPermission(userPermissions, permission)
  );
}
