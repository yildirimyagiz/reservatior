export const SecurityOSPermissions = {
  SECURITY_ALERT_READ: 'security.alert.read',
  SECURITY_ALERT_MANAGE: 'security.alert.manage',
  INCIDENT_CREATE: 'incident.create',
  INCIDENT_READ: 'incident.read',
  INCIDENT_UPDATE: 'incident.update',
  INCIDENT_RESOLVE: 'incident.resolve',
  SECURITY_SCAN_RUN: 'security_scan.run',
  SECURITY_SCAN_READ: 'security_scan.read',
  ACCESS_GRANT: 'access.grant',
  ACCESS_REVOKE: 'access.revoke',
  SECURITY_ADMIN_ALL: 'security.admin.all',
} as const;

export type SecurityOSPermission = typeof SecurityOSPermissions[keyof typeof SecurityOSPermissions];

export const SecurityOSRolePermissions: Record<string, SecurityOSPermission[]> = {
  user: [SecurityOSPermissions.SECURITY_ALERT_READ, SecurityOSPermissions.INCIDENT_READ, SecurityOSPermissions.SECURITY_SCAN_READ],
  security_analyst: [SecurityOSPermissions.SECURITY_ALERT_READ, SecurityOSPermissions.SECURITY_ALERT_MANAGE, SecurityOSPermissions.INCIDENT_CREATE, SecurityOSPermissions.INCIDENT_READ, SecurityOSPermissions.INCIDENT_UPDATE, SecurityOSPermissions.INCIDENT_RESOLVE, SecurityOSPermissions.SECURITY_SCAN_RUN, SecurityOSPermissions.SECURITY_SCAN_READ],
  admin: [SecurityOSPermissions.SECURITY_ADMIN_ALL],
};

export function hasSecurityPermission(userPermissions: string[], requiredPermission: SecurityOSPermission): boolean {
  return userPermissions.includes(SecurityOSPermissions.SECURITY_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
