/**
 * Analytics OS Permission Model
 * Defines granular permissions for analytics operations
 */

export const AnalyticsOSPermissions = {
  // Query Operations
  QUERY_CREATE: 'query.create',
  QUERY_READ: 'query.read',
  QUERY_UPDATE: 'query.update',
  QUERY_DELETE: 'query.delete',
  QUERY_EXECUTE: 'query.execute',
  QUERY_SCHEDULE: 'query.schedule',
  
  // Dashboard Operations
  DASHBOARD_CREATE: 'dashboard.create',
  DASHBOARD_READ: 'dashboard.read',
  DASHBOARD_UPDATE: 'dashboard.update',
  DASHBOARD_DELETE: 'dashboard.delete',
  DASHBOARD_SHARE: 'dashboard.share',
  DASHBOARD_PUBLISH: 'dashboard.publish',
  
  // Metric Operations
  METRIC_VIEW: 'metric.view',
  METRIC_CREATE: 'metric.create',
  METRIC_UPDATE: 'metric.update',
  METRIC_DELETE: 'metric.delete',
  
  // Report Operations
  REPORT_CREATE: 'report.create',
  REPORT_READ: 'report.read',
  REPORT_UPDATE: 'report.update',
  REPORT_DELETE: 'report.delete',
  REPORT_SCHEDULE: 'report.schedule',
  REPORT_EXPORT: 'report.export',
  
  // Insight Operations
  INSIGHT_VIEW: 'insight.view',
  INSIGHT_GENERATE: 'insight.generate',
  INSIGHT_MANAGE: 'insight.manage',
  
  // Data Access
  DATA_ACCESS: 'data.access',
  DATA_EXPORT: 'data.export',
  DATA_IMPORT: 'data.import',
  
  // Advanced Analytics
  ADVANCED_ANALYTICS: 'analytics.advanced',
  PREDICTIVE_ANALYTICS: 'analytics.predictive',
  ML_MODELS: 'analytics.ml_models',
  
  // Integration Operations
  INTEGRATION_MANAGE: 'integration.manage',
  WEBHOOK_MANAGE: 'webhook.manage',
  
  // Admin Operations
  ANALYTICS_ADMIN_ALL: 'analytics.admin.all',
  ANALYTICS_ADMIN_OVERRIDE: 'analytics.admin.override',
  ANALYTICS_ADMIN_AUDIT: 'analytics.admin.audit',
} as const;

export type AnalyticsOSPermission = typeof AnalyticsOSPermissions[keyof typeof AnalyticsOSPermissions];

/**
 * Role-based permission mappings
 */
export const AnalyticsOSRolePermissions: Record<string, AnalyticsOSPermission[]> = {
  // Viewer - Basic analytics access
  viewer: [
    AnalyticsOSPermissions.QUERY_READ,
    AnalyticsOSPermissions.DASHBOARD_READ,
    AnalyticsOSPermissions.METRIC_VIEW,
    AnalyticsOSPermissions.REPORT_READ,
    AnalyticsOSPermissions.INSIGHT_VIEW,
  ],
  
  // Analyst - Extended analytics operations
  analyst: [
    AnalyticsOSPermissions.QUERY_CREATE,
    AnalyticsOSPermissions.QUERY_READ,
    AnalyticsOSPermissions.QUERY_UPDATE,
    AnalyticsOSPermissions.QUERY_EXECUTE,
    AnalyticsOSPermissions.QUERY_SCHEDULE,
    AnalyticsOSPermissions.DASHBOARD_CREATE,
    AnalyticsOSPermissions.DASHBOARD_READ,
    AnalyticsOSPermissions.DASHBOARD_UPDATE,
    AnalyticsOSPermissions.DASHBOARD_SHARE,
    AnalyticsOSPermissions.METRIC_VIEW,
    AnalyticsOSPermissions.METRIC_CREATE,
    AnalyticsOSPermissions.METRIC_UPDATE,
    AnalyticsOSPermissions.REPORT_CREATE,
    AnalyticsOSPermissions.REPORT_READ,
    AnalyticsOSPermissions.REPORT_UPDATE,
    AnalyticsOSPermissions.REPORT_EXPORT,
    AnalyticsOSPermissions.INSIGHT_VIEW,
    AnalyticsOSPermissions.INSIGHT_GENERATE,
    AnalyticsOSPermissions.DATA_ACCESS,
    AnalyticsOSPermissions.DATA_EXPORT,
    AnalyticsOSPermissions.ADVANCED_ANALYTICS,
  ],
  
  // Data Scientist - Full analytics capabilities
  data_scientist: [
    AnalyticsOSPermissions.QUERY_CREATE,
    AnalyticsOSPermissions.QUERY_READ,
    AnalyticsOSPermissions.QUERY_UPDATE,
    AnalyticsOSPermissions.QUERY_DELETE,
    AnalyticsOSPermissions.QUERY_EXECUTE,
    AnalyticsOSPermissions.QUERY_SCHEDULE,
    AnalyticsOSPermissions.DASHBOARD_CREATE,
    AnalyticsOSPermissions.DASHBOARD_READ,
    AnalyticsOSPermissions.DASHBOARD_UPDATE,
    AnalyticsOSPermissions.DASHBOARD_DELETE,
    AnalyticsOSPermissions.DASHBOARD_SHARE,
    AnalyticsOSPermissions.DASHBOARD_PUBLISH,
    AnalyticsOSPermissions.METRIC_VIEW,
    AnalyticsOSPermissions.METRIC_CREATE,
    AnalyticsOSPermissions.METRIC_UPDATE,
    AnalyticsOSPermissions.METRIC_DELETE,
    AnalyticsOSPermissions.REPORT_CREATE,
    AnalyticsOSPermissions.REPORT_READ,
    AnalyticsOSPermissions.REPORT_UPDATE,
    AnalyticsOSPermissions.REPORT_DELETE,
    AnalyticsOSPermissions.REPORT_SCHEDULE,
    AnalyticsOSPermissions.REPORT_EXPORT,
    AnalyticsOSPermissions.INSIGHT_VIEW,
    AnalyticsOSPermissions.INSIGHT_GENERATE,
    AnalyticsOSPermissions.INSIGHT_MANAGE,
    AnalyticsOSPermissions.DATA_ACCESS,
    AnalyticsOSPermissions.DATA_EXPORT,
    AnalyticsOSPermissions.DATA_IMPORT,
    AnalyticsOSPermissions.ADVANCED_ANALYTICS,
    AnalyticsOSPermissions.PREDICTIVE_ANALYTICS,
    AnalyticsOSPermissions.ML_MODELS,
    AnalyticsOSPermissions.INTEGRATION_MANAGE,
  ],
  
  // Admin - Full access
  admin: [
    AnalyticsOSPermissions.ANALYTICS_ADMIN_ALL,
    AnalyticsOSPermissions.ANALYTICS_ADMIN_OVERRIDE,
    AnalyticsOSPermissions.ANALYTICS_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasAnalyticsPermission(
  userPermissions: string[],
  requiredPermission: AnalyticsOSPermission
): boolean {
  if (userPermissions.includes(AnalyticsOSPermissions.ANALYTICS_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasAnalyticsPermissions(
  userPermissions: string[],
  requiredPermissions: AnalyticsOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasAnalyticsPermission(userPermissions, permission)
  );
}
