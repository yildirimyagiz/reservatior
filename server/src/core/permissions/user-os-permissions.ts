export const UserOSPermissions = {
  USER_CREATE: 'user.create',
  USER_READ: 'user.read',
  USER_UPDATE: 'user.update',
  USER_DELETE: 'user.delete',
  USER_SUSPEND: 'user.suspend',
  USER_REACTIVATE: 'user.reactivate',
  PROFILE_READ: 'profile.read',
  PROFILE_UPDATE: 'profile.update',
  USER_ADMIN_ALL: 'user.admin.all',
} as const;

export type UserOSPermission = typeof UserOSPermissions[keyof typeof UserOSPermissions];

export const UserOSRolePermissions: Record<string, UserOSPermission[]> = {
  user: [UserOSPermissions.PROFILE_READ, UserOSPermissions.PROFILE_UPDATE],
  manager: [UserOSPermissions.USER_CREATE, UserOSPermissions.USER_READ, UserOSPermissions.USER_UPDATE, UserOSPermissions.USER_SUSPEND, UserOSPermissions.USER_REACTIVATE],
  admin: [UserOSPermissions.USER_ADMIN_ALL],
};

export function hasUserPermission(userPermissions: string[], requiredPermission: UserOSPermission): boolean {
  return userPermissions.includes(UserOSPermissions.USER_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
