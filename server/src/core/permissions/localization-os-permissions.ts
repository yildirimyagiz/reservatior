/**
 * Localization OS Permission Model
 * Defines granular permissions for localization operations
 */

export const LocalizationOSPermissions = {
  // Country Management
  COUNTRY_CREATE: 'country.create',
  COUNTRY_READ: 'country.read',
  COUNTRY_UPDATE: 'country.update',
  COUNTRY_DELETE: 'country.delete',
  COUNTRY_ENABLE: 'country.enable',
  COUNTRY_DISABLE: 'country.disable',
  
  // Translation Management
  TRANSLATION_CREATE: 'translation.create',
  TRANSLATION_READ: 'translation.read',
  TRANSLATION_UPDATE: 'translation.update',
  TRANSLATION_DELETE: 'translation.delete',
  TRANSLATION_APPROVE: 'translation.approve',
  TRANSLATION_REJECT: 'translation.reject',
  
  // Content Management
  CONTENT_LOCALIZE: 'content.localize',
  CONTENT_UPDATE: 'content.update',
  CONTENT_DELETE: 'content.delete',
  
  // Exchange Rate Management
  EXCHANGE_RATE_UPDATE: 'exchange_rate.update',
  EXCHANGE_RATE_VIEW: 'exchange_rate.view',
  EXCHANGE_RATE_IMPORT: 'exchange_rate.import',
  
  // Language Management
  LANGUAGE_ADD: 'language.add',
  LANGUAGE_REMOVE: 'language.remove',
  LANGUAGE_SET_DEFAULT: 'language.set_default',
  
  // Currency Management
  CURRENCY_ADD: 'currency.add',
  CURRENCY_REMOVE: 'currency.remove',
  CURRENCY_SET_DEFAULT: 'currency.set_default',
  
  // Analytics Operations
  ANALYTICS_VIEW: 'analytics.view',
  ANALYTICS_EXPORT: 'analytics.export',
  
  // Integration Operations
  INTEGRATION_MANAGE: 'integration.manage',
  WEBHOOK_MANAGE: 'webhook.manage',
  
  // Admin Operations
  LOCALIZATION_ADMIN_ALL: 'localization.admin.all',
  LOCALIZATION_ADMIN_OVERRIDE: 'localization.admin.override',
  LOCALIZATION_ADMIN_AUDIT: 'localization.admin.audit',
} as const;

export type LocalizationOSPermission = typeof LocalizationOSPermissions[keyof typeof LocalizationOSPermissions];

/**
 * Role-based permission mappings
 */
export const LocalizationOSRolePermissions: Record<string, LocalizationOSPermission[]> = {
  // Translator - Basic translation operations
  translator: [
    LocalizationOSPermissions.TRANSLATION_CREATE,
    LocalizationOSPermissions.TRANSLATION_READ,
    LocalizationOSPermissions.TRANSLATION_UPDATE,
    LocalizationOSPermissions.CONTENT_LOCALIZE,
    LocalizationOSPermissions.COUNTRY_READ,
  ],
  
  // Localization Manager - Extended localization operations
  localization_manager: [
    LocalizationOSPermissions.COUNTRY_CREATE,
    LocalizationOSPermissions.COUNTRY_READ,
    LocalizationOSPermissions.COUNTRY_UPDATE,
    LocalizationOSPermissions.COUNTRY_ENABLE,
    LocalizationOSPermissions.COUNTRY_DISABLE,
    LocalizationOSPermissions.TRANSLATION_CREATE,
    LocalizationOSPermissions.TRANSLATION_READ,
    LocalizationOSPermissions.TRANSLATION_UPDATE,
    LocalizationOSPermissions.TRANSLATION_APPROVE,
    LocalizationOSPermissions.TRANSLATION_REJECT,
    LocalizationOSPermissions.CONTENT_LOCALIZE,
    LocalizationOSPermissions.CONTENT_UPDATE,
    LocalizationOSPermissions.EXCHANGE_RATE_VIEW,
    LocalizationOSPermissions.EXCHANGE_RATE_UPDATE,
    LocalizationOSPermissions.LANGUAGE_ADD,
    LocalizationOSPermissions.LANGUAGE_SET_DEFAULT,
    LocalizationOSPermissions.CURRENCY_ADD,
    LocalizationOSPermissions.CURRENCY_SET_DEFAULT,
    LocalizationOSPermissions.ANALYTICS_VIEW,
    LocalizationOSPermissions.ANALYTICS_EXPORT,
    LocalizationOSPermissions.INTEGRATION_MANAGE,
  ],
  
  // Admin - Full access
  admin: [
    LocalizationOSPermissions.LOCALIZATION_ADMIN_ALL,
    LocalizationOSPermissions.LOCALIZATION_ADMIN_OVERRIDE,
    LocalizationOSPermissions.LOCALIZATION_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasLocalizationPermission(
  userPermissions: string[],
  requiredPermission: LocalizationOSPermission
): boolean {
  if (userPermissions.includes(LocalizationOSPermissions.LOCALIZATION_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasLocalizationPermissions(
  userPermissions: string[],
  requiredPermissions: LocalizationOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasLocalizationPermission(userPermissions, permission)
  );
}
