/**
 * Identity OS Dashboard Configurations
 */

import { platformIntelligence, DashboardConfig } from '../platform-intelligence';

export const identityDashboards: DashboardConfig[] = [
  {
    id: 'identity-overview',
    name: 'Identity Overview',
    description: 'Overview of identity and access management metrics',
    osModule: 'IdentityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Users',
        metricName: 'identity.total_users',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Organizations',
        metricName: 'identity.active_organizations',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Sessions',
        metricName: 'identity.active_sessions',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'API Keys Active',
        metricName: 'identity.active_api_keys',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'User Registrations Trend',
        metricName: 'identity.registrations_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Session Activity',
        metricName: 'identity.session_activity',
        config: { chartType: 'area', timeRange: '24h' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Activity',
        metricName: 'identity.recent_activity',
        config: { columns: ['user', 'action', 'ip', 'timestamp'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'identity-authentication',
    name: 'Authentication',
    description: 'Authentication metrics and security events',
    osModule: 'IdentityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Successful Logins Today',
        metricName: 'auth.successful_logins',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Failed Logins Today',
        metricName: 'auth.failed_logins',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'MFA Enabled Users',
        metricName: 'auth.mfa_enabled',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'SSO Logins',
        metricName: 'auth.sso_logins',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Login Attempts Trend',
        metricName: 'auth.login_attempts_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Authentication Methods',
        metricName: 'auth.methods_distribution',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Security Events',
        metricName: 'auth.security_events',
        config: { columns: ['event_type', 'user', 'risk_level', 'ip', 'timestamp'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'identity-organizations',
    name: 'Organizations',
    description: 'Organization management metrics',
    osModule: 'IdentityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Organizations',
        metricName: 'orgs.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Organizations',
        metricName: 'orgs.active',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Teams',
        metricName: 'orgs.total_teams',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Roles',
        metricName: 'orgs.total_roles',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Organization Growth',
        metricName: 'orgs.growth_trend',
        config: { chartType: 'line', timeRange: '90d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Organizations by Type',
        metricName: 'orgs.by_type',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Top Organizations',
        metricName: 'orgs.top_organizations',
        config: { columns: ['name', 'type', 'users', 'teams', 'created_at'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'identity-access-control',
    name: 'Access Control',
    description: 'RBAC and permission metrics',
    osModule: 'IdentityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Roles',
        metricName: 'rbac.total_roles',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Total Permissions',
        metricName: 'rbac.total_permissions',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Role Assignments',
        metricName: 'rbac.role_assignments',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Permission Checks Today',
        metricName: 'rbac.permission_checks',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Role Assignments Trend',
        metricName: 'rbac.assignments_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Permission Usage',
        metricName: 'rbac.permission_usage',
        config: { chartType: 'bar' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Most Used Permissions',
        metricName: 'rbac.most_used_permissions',
        config: { columns: ['permission', 'usage_count', 'users', 'last_used'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  },
  {
    id: 'identity-devices',
    name: 'Device Management',
    description: 'Device registration and trust metrics',
    osModule: 'IdentityOS',
    refreshInterval: 300000,
    widgets: [
      {
        type: 'metric',
        title: 'Total Devices',
        metricName: 'devices.total',
        config: { format: 'number' },
        position: { x: 0, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Trusted Devices',
        metricName: 'devices.trusted',
        config: { format: 'number' },
        position: { x: 3, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'Active Devices',
        metricName: 'devices.active',
        config: { format: 'number' },
        position: { x: 6, y: 0, w: 3, h: 2 }
      },
      {
        type: 'metric',
        title: 'New Devices Today',
        metricName: 'devices.new_today',
        config: { format: 'number' },
        position: { x: 9, y: 0, w: 3, h: 2 }
      },
      {
        type: 'chart',
        title: 'Device Registrations Trend',
        metricName: 'devices.registrations_trend',
        config: { chartType: 'line', timeRange: '30d' },
        position: { x: 0, y: 2, w: 6, h: 4 }
      },
      {
        type: 'chart',
        title: 'Devices by Type',
        metricName: 'devices.by_type',
        config: { chartType: 'pie' },
        position: { x: 6, y: 2, w: 6, h: 4 }
      },
      {
        type: 'table',
        title: 'Recent Device Registrations',
        metricName: 'devices.recent_registrations',
        config: { columns: ['user', 'device_type', 'device_name', 'trusted', 'registered_at'] },
        position: { x: 0, y: 6, w: 12, h: 4 }
      }
    ]
  }
];

/**
 * Register Identity OS dashboards
 */
export function registerIdentityDashboards() {
  identityDashboards.forEach(dashboard => {
    platformIntelligence.registerDashboard(dashboard);
  });
  console.log(`[IdentityOS] Registered ${identityDashboards.length} dashboards`);
}
