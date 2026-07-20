export const DevAPIOSSPermissions = {
  API_KEY_CREATE: 'api_key.create',
  API_KEY_READ: 'api_key.read',
  API_KEY_UPDATE: 'api_key.update',
  API_KEY_REVOKE: 'api_key.revoke',
  API_USAGE_READ: 'api_usage.read',
  API_RATE_LIMIT_MANAGE: 'api_rate_limit.manage',
  API_DOCUMENTATION_READ: 'api_documentation.read',
  API_ADMIN_ALL: 'api.admin.all',
} as const;

export type DevAPIOSSPermission = typeof DevAPIOSSPermissions[keyof typeof DevAPIOSSPermissions];

export const DevAPIOSSRolePermissions: Record<string, DevAPIOSSPermission[]> = {
  developer: [DevAPIOSSPermissions.API_KEY_CREATE, DevAPIOSSPermissions.API_KEY_READ, DevAPIOSSPermissions.API_KEY_REVOKE, DevAPIOSSPermissions.API_USAGE_READ, DevAPIOSSPermissions.API_DOCUMENTATION_READ],
  admin: [DevAPIOSSPermissions.API_ADMIN_ALL],
};

export function hasDevAPIPermission(userPermissions: string[], requiredPermission: DevAPIOSSPermission): boolean {
  return userPermissions.includes(DevAPIOSSPermissions.API_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
