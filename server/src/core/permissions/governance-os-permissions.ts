export const GovernanceOSPermissions = {
  POLICY_CREATE: 'policy.create',
  POLICY_READ: 'policy.read',
  POLICY_UPDATE: 'policy.update',
  POLICY_DELETE: 'policy.delete',
  COMPLIANCE_RUN: 'compliance.run',
  COMPLIANCE_READ: 'compliance.read',
  AUDIT_CREATE: 'audit.create',
  AUDIT_READ: 'audit.read',
  AUDIT_UPDATE: 'audit.update',
  GOVERNANCE_ADMIN_ALL: 'governance.admin.all',
} as const;

export type GovernanceOSPermission = typeof GovernanceOSPermissions[keyof typeof GovernanceOSPermissions];

export const GovernanceOSRolePermissions: Record<string, GovernanceOSPermission[]> = {
  user: [GovernanceOSPermissions.POLICY_READ, GovernanceOSPermissions.COMPLIANCE_READ, GovernanceOSPermissions.AUDIT_READ],
  compliance_officer: [GovernanceOSPermissions.POLICY_CREATE, GovernanceOSPermissions.POLICY_READ, GovernanceOSPermissions.POLICY_UPDATE, GovernanceOSPermissions.COMPLIANCE_RUN, GovernanceOSPermissions.COMPLIANCE_READ, GovernanceOSPermissions.AUDIT_CREATE, GovernanceOSPermissions.AUDIT_READ, GovernanceOSPermissions.AUDIT_UPDATE],
  admin: [GovernanceOSPermissions.GOVERNANCE_ADMIN_ALL],
};

export function hasGovernancePermission(userPermissions: string[], requiredPermission: GovernanceOSPermission): boolean {
  return userPermissions.includes(GovernanceOSPermissions.GOVERNANCE_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
