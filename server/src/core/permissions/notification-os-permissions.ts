/**
 * Notification OS Permission Model
 * Defines granular permissions for notification operations
 */

export const NotificationOSPermissions = {
  // Notification Management
  NOTIFICATION_CREATE: 'notification.create',
  NOTIFICATION_READ: 'notification.read',
  NOTIFICATION_UPDATE: 'notification.update',
  NOTIFICATION_DELETE: 'notification.delete',
  NOTIFICATION_SEND: 'notification.send',
  NOTIFICATION_CANCEL: 'notification.cancel',
  
  // Channel Management
  CHANNEL_MANAGE: 'channel.manage',
  CHANNEL_CONFIGURE: 'channel.configure',
  CHANNEL_ENABLE: 'channel.enable',
  CHANNEL_DISABLE: 'channel.disable',
  
  // Template Management
  TEMPLATE_CREATE: 'template.create',
  TEMPLATE_READ: 'template.read',
  TEMPLATE_UPDATE: 'template.update',
  TEMPLATE_DELETE: 'template.delete',
  TEMPLATE_USE: 'template.use',
  
  // Rule Management
  RULE_CREATE: 'rule.create',
  RULE_READ: 'rule.read',
  RULE_UPDATE: 'rule.update',
  RULE_DELETE: 'rule.delete',
  RULE_ENABLE: 'rule.enable',
  RULE_DISABLE: 'rule.disable',
  
  // Preference Management
  PREFERENCE_VIEW: 'preference.view',
  PREFERENCE_MANAGE: 'preference.manage',
  PREFERENCE_UPDATE: 'preference.update',
  
  // Analytics Operations
  ANALYTICS_VIEW: 'analytics.view',
  ANALYTICS_EXPORT: 'analytics.export',
  
  // Bulk Operations
  BULK_SEND: 'bulk.send',
  BULK_SCHEDULE: 'bulk.schedule',
  
  // Integration Operations
  INTEGRATION_MANAGE: 'integration.manage',
  WEBHOOK_MANAGE: 'webhook.manage',
  
  // Admin Operations
  NOTIFICATION_ADMIN_ALL: 'notification.admin.all',
  NOTIFICATION_ADMIN_OVERRIDE: 'notification.admin.override',
  NOTIFICATION_ADMIN_AUDIT: 'notification.admin.audit',
} as const;

export type NotificationOSPermission = typeof NotificationOSPermissions[keyof typeof NotificationOSPermissions];

/**
 * Role-based permission mappings
 */
export const NotificationOSRolePermissions: Record<string, NotificationOSPermission[]> = {
  // User - Basic notification operations
  user: [
    NotificationOSPermissions.NOTIFICATION_READ,
    NotificationOSPreferences.PREFERENCE_VIEW,
    NotificationOSPreferences.PREFERENCE_UPDATE,
  ],
  
  // Agent - Extended notification operations
  agent: [
    NotificationOSPermissions.NOTIFICATION_CREATE,
    NotificationOSPermissions.NOTIFICATION_READ,
    NotificationOSPermissions.NOTIFICATION_SEND,
    NotificationOSPermissions.NOTIFICATION_CANCEL,
    NotificationOSPermissions.TEMPLATE_READ,
    NotificationOSPermissions.TEMPLATE_USE,
    NotificationOSPermissions.RULE_READ,
    NotificationOSPermissions.PREFERENCE_VIEW,
    NotificationOSPermissions.PREFERENCE_UPDATE,
    NotificationOSPermissions.ANALYTICS_VIEW,
  ],
  
  // Manager - Full notification management
  manager: [
    NotificationOSPermissions.NOTIFICATION_CREATE,
    NotificationOSPermissions.NOTIFICATION_READ,
    NotificationOSPermissions.NOTIFICATION_UPDATE,
    NotificationOSPermissions.NOTIFICATION_DELETE,
    NotificationOSPermissions.NOTIFICATION_SEND,
    NotificationOSPermissions.NOTIFICATION_CANCEL,
    NotificationOSPermissions.CHANNEL_MANAGE,
    NotificationOSPermissions.CHANNEL_CONFIGURE,
    NotificationOSPermissions.CHANNEL_ENABLE,
    NotificationOSPermissions.CHANNEL_DISABLE,
    NotificationOSPermissions.TEMPLATE_CREATE,
    NotificationOSPermissions.TEMPLATE_READ,
    NotificationOSPermissions.TEMPLATE_UPDATE,
    NotificationOSPermissions.TEMPLATE_DELETE,
    NotificationOSPermissions.TEMPLATE_USE,
    NotificationOSPermissions.RULE_CREATE,
    NotificationOSPermissions.RULE_READ,
    NotificationOSPermissions.RULE_UPDATE,
    NotificationOSPermissions.RULE_DELETE,
    NotificationOSPermissions.RULE_ENABLE,
    NotificationOSPermissions.RULE_DISABLE,
    NotificationOSPermissions.PREFERENCE_VIEW,
    NotificationOSPermissions.PREFERENCE_MANAGE,
    NotificationOSPermissions.ANALYTICS_VIEW,
    NotificationOSPermissions.ANALYTICS_EXPORT,
    NotificationOSPermissions.BULK_SEND,
    NotificationOSPermissions.BULK_SCHEDULE,
    NotificationOSPermissions.INTEGRATION_MANAGE,
  ],
  
  // Admin - Full access
  admin: [
    NotificationOSPermissions.NOTIFICATION_ADMIN_ALL,
    NotificationOSPermissions.NOTIFICATION_ADMIN_OVERRIDE,
    NotificationOSPermissions.NOTIFICATION_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasNotificationPermission(
  userPermissions: string[],
  requiredPermission: NotificationOSPermission
): boolean {
  if (userPermissions.includes(NotificationOSPermissions.NOTIFICATION_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasNotificationPermissions(
  userPermissions: string[],
  requiredPermissions: NotificationOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasNotificationPermission(userPermissions, permission)
  );
}
