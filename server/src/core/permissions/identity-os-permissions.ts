/**
 * Identity OS Permission Model
 * Defines granular permissions for identity and access management
 */

export const IdentityOSPermissions = {
  // Organization Management
  ORGANIZATION_CREATE: 'organization.create',
  ORGANIZATION_READ: 'organization.read',
  ORGANIZATION_UPDATE: 'organization.update',
  ORGANIZATION_DELETE: 'organization.delete',
  ORGANIZATION_MANAGE_SETTINGS: 'organization.manage_settings',
  ORGANIZATION_VIEW_ANALYTICS: 'organization.view_analytics',
  
  // Team Management
  TEAM_CREATE: 'team.create',
  TEAM_READ: 'team.read',
  TEAM_UPDATE: 'team.update',
  TEAM_DELETE: 'team.delete',
  TEAM_MANAGE_MEMBERS: 'team.manage_members',
  
  // Role Management
  ROLE_CREATE: 'role.create',
  ROLE_READ: 'role.read',
  ROLE_UPDATE: 'role.update',
  ROLE_DELETE: 'role.delete',
  ROLE_ASSIGN: 'role.assign',
  ROLE_MANAGE_PERMISSIONS: 'role.manage_permissions',
  
  // Permission Management
  PERMISSION_CREATE: 'permission.create',
  PERMISSION_READ: 'permission.read',
  PERMISSION_UPDATE: 'permission.update',
  PERMISSION_DELETE: 'permission.delete',
  
  // User Management
  USER_CREATE: 'user.create',
  USER_READ: 'user.read',
  USER_UPDATE: 'user.update',
  USER_DELETE: 'user.delete',
  USER_MANAGE_ROLES: 'user.manage_roles',
  USER_VIEW_ACTIVITY: 'user.view_activity',
  
  // Session Management
  SESSION_CREATE: 'session.create',
  SESSION_READ: 'session.read',
  SESSION_REVOKE: 'session.revoke',
  SESSION_VIEW_ALL: 'session.view_all',
  
  // Device Management
  DEVICE_REGISTER: 'device.register',
  DEVICE_READ: 'device.read',
  DEVICE_TRUST: 'device.trust',
  DEVICE_REVOKE: 'device.revoke',
  DEVICE_VIEW_ALL: 'device.view_all',
  
  // API Key Management
  APIKEY_CREATE: 'apikey.create',
  APIKEY_READ: 'apikey.read',
  APIKEY_UPDATE: 'apikey.update',
  APIKEY_DELETE: 'apikey.delete',
  APIKEY_MANAGE_SCOPES: 'apikey.manage_scopes',
  
  // SSO Management
  SSO_ENABLE: 'sso.enable',
  SSO_DISABLE: 'sso.disable',
  SSO_MANAGE_CONFIG: 'sso.manage_config',
  SSO_VIEW_LOGS: 'sso.view_logs',
  
  // Audit & Compliance
  AUDIT_VIEW: 'audit.view',
  AUDIT_EXPORT: 'audit.export',
  COMPLIANCE_VIEW: 'compliance.view',
  COMPLIANCE_MANAGE: 'compliance.manage',
  
  // Identity Graph
  IDENTITY_GRAPH_VIEW: 'identity_graph.view',
  IDENTITY_GRAPH_ANALYZE: 'identity_graph.analyze',
  
  // Admin Operations
  IDENTITY_ADMIN_ALL: 'identity.admin.all',
  IDENTITY_ADMIN_OVERRIDE: 'identity.admin.override',
  IDENTITY_ADMIN_AUDIT: 'identity.admin.audit',
} as const;

export type IdentityOSPermission = typeof IdentityOSPermissions[keyof typeof IdentityOSPermissions];

/**
 * Role-based permission mappings
 */
export const IdentityOSRolePermissions: Record<string, IdentityOSPermission[]> = {
  // User - Basic operations
  user: [
    IdentityOSPermissions.ORGANIZATION_READ,
    IdentityOSPermissions.TEAM_READ,
    IdentityOSPermissions.ROLE_READ,
    IdentityOSPermissions.USER_READ,
    IdentityOSPermissions.SESSION_CREATE,
    IdentityOSPermissions.SESSION_READ,
    IdentityOSPermissions.DEVICE_REGISTER,
    IdentityOSPermissions.DEVICE_TRUST,
  ],
  
  // Team Manager - Team and user management
  team_manager: [
    IdentityOSPermissions.ORGANIZATION_READ,
    IdentityOSPermissions.TEAM_CREATE,
    IdentityOSPermissions.TEAM_READ,
    IdentityOSPermissions.TEAM_UPDATE,
    IdentityOSPermissions.TEAM_MANAGE_MEMBERS,
    IdentityOSPermissions.ROLE_READ,
    IdentityOSPermissions.USER_CREATE,
    IdentityOSPermissions.USER_READ,
    IdentityOSPermissions.USER_UPDATE,
    IdentityOSPermissions.USER_MANAGE_ROLES,
    IdentityOSPermissions.USER_VIEW_ACTIVITY,
    IdentityOSPermissions.SESSION_READ,
    IdentityOSPermissions.SESSION_REVOKE,
    IdentityOSPermissions.DEVICE_REGISTER,
    IdentityOSPermissions.DEVICE_TRUST,
    IdentityOSPermissions.DEVICE_REVOKE,
  ],
  
  // Organization Admin - Full organization management
  org_admin: [
    IdentityOSPermissions.ORGANIZATION_CREATE,
    IdentityOSPermissions.ORGANIZATION_READ,
    IdentityOSPermissions.ORGANIZATION_UPDATE,
    IdentityOSPermissions.ORGANIZATION_MANAGE_SETTINGS,
    IdentityOSPermissions.ORGANIZATION_VIEW_ANALYTICS,
    IdentityOSPermissions.TEAM_CREATE,
    IdentityOSPermissions.TEAM_READ,
    IdentityOSPermissions.TEAM_UPDATE,
    IdentityOSPermissions.TEAM_DELETE,
    IdentityOSPermissions.TEAM_MANAGE_MEMBERS,
    IdentityOSPermissions.ROLE_CREATE,
    IdentityOSPermissions.ROLE_READ,
    IdentityOSPermissions.ROLE_UPDATE,
    IdentityOSPermissions.ROLE_DELETE,
    IdentityOSPermissions.ROLE_ASSIGN,
    IdentityOSPermissions.ROLE_MANAGE_PERMISSIONS,
    IdentityOSPermissions.PERMISSION_READ,
    IdentityOSPermissions.USER_CREATE,
    IdentityOSPermissions.USER_READ,
    IdentityOSPermissions.USER_UPDATE,
    IdentityOSPermissions.USER_DELETE,
    IdentityOSPermissions.USER_MANAGE_ROLES,
    IdentityOSPermissions.USER_VIEW_ACTIVITY,
    IdentityOSPermissions.SESSION_CREATE,
    IdentityOSPermissions.SESSION_READ,
    IdentityOSPermissions.SESSION_REVOKE,
    IdentityOSPermissions.SESSION_VIEW_ALL,
    IdentityOSPermissions.DEVICE_REGISTER,
    IdentityOSPermissions.DEVICE_TRUST,
    IdentityOSPermissions.DEVICE_REVOKE,
    IdentityOSPermissions.DEVICE_VIEW_ALL,
    IdentityOSPermissions.APIKEY_CREATE,
    IdentityOSPermissions.APIKEY_READ,
    IdentityOSPermissions.APIKEY_UPDATE,
    IdentityOSPermissions.APIKEY_DELETE,
    IdentityOSPermissions.APIKEY_MANAGE_SCOPES,
    IdentityOSPermissions.SSO_ENABLE,
    IdentityOSPermissions.SSO_DISABLE,
    IdentityOSPermissions.SSO_MANAGE_CONFIG,
    IdentityOSPermissions.AUDIT_VIEW,
    IdentityOSPermissions.AUDIT_EXPORT,
    IdentityOSPermissions.COMPLIANCE_VIEW,
    IdentityOSPermissions.IDENTITY_GRAPH_VIEW,
    IdentityOSPermissions.IDENTITY_GRAPH_ANALYZE,
  ],
  
  // Security Admin - Focus on security and compliance
  security_admin: [
    IdentityOSPermissions.ORGANIZATION_READ,
    IdentityOSPermissions.ROLE_READ,
    IdentityOSPermissions.USER_READ,
    IdentityOSPermissions.USER_VIEW_ACTIVITY,
    IdentityOSPermissions.SESSION_READ,
    IdentityOSPermissions.SESSION_REVOKE,
    IdentityOSPermissions.SESSION_VIEW_ALL,
    IdentityOSPermissions.DEVICE_READ,
    IdentityOSPermissions.DEVICE_TRUST,
    IdentityOSPermissions.DEVICE_REVOKE,
    IdentityOSPermissions.DEVICE_VIEW_ALL,
    IdentityOSPermissions.APIKEY_READ,
    IdentityOSPermissions.APIKEY_UPDATE,
    IdentityOSPermissions.APIKEY_DELETE,
    IdentityOSPermissions.APIKEY_MANAGE_SCOPES,
    IdentityOSPermissions.SSO_MANAGE_CONFIG,
    IdentityOSPermissions.SSO_VIEW_LOGS,
    IdentityOSPermissions.AUDIT_VIEW,
    IdentityOSPermissions.AUDIT_EXPORT,
    IdentityOSPermissions.COMPLIANCE_VIEW,
    IdentityOSPermissions.COMPLIANCE_MANAGE,
    IdentityOSPermissions.IDENTITY_GRAPH_VIEW,
    IdentityOSPermissions.IDENTITY_GRAPH_ANALYZE,
  ],
  
  // Auditor - Read-only audit access
  auditor: [
    IdentityOSPermissions.ORGANIZATION_READ,
    IdentityOSPermissions.TEAM_READ,
    IdentityOSPermissions.ROLE_READ,
    IdentityOSPermissions.USER_READ,
    IdentityOSPermissions.USER_VIEW_ACTIVITY,
    IdentityOSPermissions.SESSION_READ,
    IdentityOSPermissions.SESSION_VIEW_ALL,
    IdentityOSPermissions.DEVICE_READ,
    IdentityOSPermissions.DEVICE_VIEW_ALL,
    IdentityOSPermissions.APIKEY_READ,
    IdentityOSPermissions.AUDIT_VIEW,
    IdentityOSPermissions.AUDIT_EXPORT,
    IdentityOSPermissions.COMPLIANCE_VIEW,
    IdentityOSPermissions.IDENTITY_GRAPH_VIEW,
  ],
  
  // System Admin - Full access
  system_admin: [
    IdentityOSPermissions.IDENTITY_ADMIN_ALL,
    IdentityOSPermissions.IDENTITY_ADMIN_OVERRIDE,
    IdentityOSPermissions.IDENTITY_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasIdentityPermission(
  userPermissions: string[],
  requiredPermission: IdentityOSPermission
): boolean {
  if (userPermissions.includes(IdentityOSPermissions.IDENTITY_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasIdentityPermissions(
  userPermissions: string[],
  requiredPermissions: IdentityOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasIdentityPermission(userPermissions, permission)
  );
}
