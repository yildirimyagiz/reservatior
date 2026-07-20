/**
 * Identity OS Metrics Collection
 * Defines key performance indicators and metrics for identity operations
 */

export interface IdentityOSMetrics {
  // Organization Metrics
  totalOrganizations: number;
  activeOrganizations: number;
  organizationGrowthRate: number;
  
  // User Metrics
  totalUsers: number;
  activeUsers: number;
  userGrowthRate: number;
  userEngagementRate: number;
  
  // Team Metrics
  totalTeams: number;
  averageTeamSize: number;
  teamActivityRate: number;
  
  // Role Metrics
  totalRoles: number;
  customRoles: number;
  roleAssignmentRate: number;
  
  // Session Metrics
  activeSessions: number;
  averageSessionDuration: number;
  sessionSuccessRate: number;
  
  // Security Metrics
  failedLoginAttempts: number;
  mfaAdoptionRate: number;
  securityIncidentCount: number;
  riskScore: number;
  
  // Compliance Metrics
  complianceScore: number;
  auditPassRate: number;
  policyViolationCount: number;
  
  // Access Metrics
  averageAccessTime: number;
  permissionRequestRate: number;
  accessDenialRate: number;
  
  // Device Metrics
  registeredDevices: number;
  trustedDevices: number;
  deviceTrustRate: number;
}

export interface IdentityOSMetricConfig {
  name: string;
  description: string;
  unit: string;
  category: 'organization' | 'user' | 'team' | 'role' | 'session' | 'security' | 'compliance' | 'access' | 'device';
  aggregation: 'sum' | 'average' | 'rate' | 'count';
  dimensions: string[];
}

export const IdentityOSMetricDefinitions: Record<string, IdentityOSMetricConfig> = {
  // Organization Metrics
  total_organizations: {
    name: 'Total Organizations',
    description: 'Total number of organizations',
    unit: 'count',
    category: 'organization',
    aggregation: 'count',
    dimensions: ['organization_type', 'status', 'time_period'],
  },
  active_organizations: {
    name: 'Active Organizations',
    description: 'Number of active organizations',
    unit: 'count',
    category: 'organization',
    aggregation: 'count',
    dimensions: ['organization_type', 'time_period'],
  },
  organization_growth_rate: {
    name: 'Organization Growth Rate',
    description: 'Percentage growth in organizations',
    unit: 'percentage',
    category: 'organization',
    aggregation: 'rate',
    dimensions: ['time_period'],
  },
  
  // User Metrics
  total_users: {
    name: 'Total Users',
    description: 'Total number of users',
    unit: 'count',
    category: 'user',
    aggregation: 'count',
    dimensions: ['organization_id', 'status', 'time_period'],
  },
  active_users: {
    name: 'Active Users',
    description: 'Number of active users',
    unit: 'count',
    category: 'user',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  user_engagement_rate: {
    name: 'User Engagement Rate',
    description: 'Percentage of engaged users',
    unit: 'percentage',
    category: 'user',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Team Metrics
  total_teams: {
    name: 'Total Teams',
    description: 'Total number of teams',
    unit: 'count',
    category: 'team',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  average_team_size: {
    name: 'Average Team Size',
    description: 'Average number of members per team',
    unit: 'count',
    category: 'team',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Role Metrics
  total_roles: {
    name: 'Total Roles',
    description: 'Total number of roles',
    unit: 'count',
    category: 'role',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  role_assignment_rate: {
    name: 'Role Assignment Rate',
    description: 'Percentage of users with assigned roles',
    unit: 'percentage',
    category: 'role',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Session Metrics
  active_sessions: {
    name: 'Active Sessions',
    description: 'Number of currently active sessions',
    unit: 'count',
    category: 'session',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  average_session_duration: {
    name: 'Average Session Duration',
    description: 'Average length of sessions',
    unit: 'minutes',
    category: 'session',
    aggregation: 'average',
    dimensions: ['organization_id', 'time_period'],
  },
  session_success_rate: {
    name: 'Session Success Rate',
    description: 'Percentage of successful sessions',
    unit: 'percentage',
    category: 'session',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Security Metrics
  failed_login_attempts: {
    name: 'Failed Login Attempts',
    description: 'Number of failed login attempts',
    unit: 'count',
    category: 'security',
    aggregation: 'count',
    dimensions: ['organization_id', 'time_period'],
  },
  mfa_adoption_rate: {
    name: 'MFA Adoption Rate',
    description: 'Percentage of users with MFA enabled',
    unit: 'percentage',
    category: 'security',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  security_incident_count: {
    name: 'Security Incident Count',
    description: 'Number of security incidents',
    unit: 'count',
    category: 'security',
    aggregation: 'count',
    dimensions: ['organization_id', 'severity', 'time_period'],
  },
  
  // Compliance Metrics
  compliance_score: {
    name: 'Compliance Score',
    description: 'Overall compliance score',
    unit: 'score',
    category: 'compliance',
    aggregation: 'average',
    dimensions: ['organization_id', 'compliance_framework', 'time_period'],
  },
  audit_pass_rate: {
    name: 'Audit Pass Rate',
    description: 'Percentage of passed audits',
    unit: 'percentage',
    category: 'compliance',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Access Metrics
  average_access_time: {
    name: 'Average Access Time',
    description: 'Average time to grant access',
    unit: 'seconds',
    category: 'access',
    aggregation: 'average',
    dimensions: ['organization_id', 'resource_type', 'time_period'],
  },
  access_denial_rate: {
    name: 'Access Denial Rate',
    description: 'Percentage of denied access requests',
    unit: 'percentage',
    category: 'access',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
  
  // Device Metrics
  registered_devices: {
    name: 'Registered Devices',
    description: 'Total number of registered devices',
    unit: 'count',
    category: 'device',
    aggregation: 'count',
    dimensions: ['organization_id', 'device_type', 'time_period'],
  },
  device_trust_rate: {
    name: 'Device Trust Rate',
    description: 'Percentage of trusted devices',
    unit: 'percentage',
    category: 'device',
    aggregation: 'rate',
    dimensions: ['organization_id', 'time_period'],
  },
};

/**
 * Metric collection helper
 */
export class IdentityOSMetricsCollector {
  private metrics: Map<string, number> = new Map();
  private dimensions: Map<string, Map<string, string>> = new Map();

  recordMetric(metricName: string, value: number, dimensions?: Record<string, string>): void {
    this.metrics.set(metricName, value);
    if (dimensions) {
      const metricDimensions = this.dimensions.get(metricName) || new Map();
      Object.entries(dimensions).forEach(([key, val]) => {
        metricDimensions.set(key, val);
      });
      this.dimensions.set(metricName, metricDimensions);
    }
  }

  getMetric(metricName: string): number | undefined {
    return this.metrics.get(metricName);
  }

  getMetricDimensions(metricName: string): Map<string, string> | undefined {
    return this.dimensions.get(metricName);
  }

  getAllMetrics(): Record<string, number> {
    return Object.fromEntries(this.metrics);
  }

  aggregateMetrics(metricNames: string[], aggregation: 'sum' | 'average' | 'rate'): number {
    const values = metricNames
      .map(name => this.metrics.get(name))
      .filter((val): val is number => val !== undefined);

    if (values.length === 0) return 0;

    switch (aggregation) {
      case 'sum':
        return values.reduce((a, b) => a + b, 0);
      case 'average':
        return values.reduce((a, b) => a + b, 0) / values.length;
      case 'rate':
        const total = values.reduce((a, b) => a + b, 0);
        return total / values.length;
      default:
        return 0;
    }
  }

  calculateSecurityScore(failedLogins: number, totalLogins: number, mfaEnabled: number, totalUsers: number): number {
    const loginSuccessRate = totalLogins > 0 ? (1 - failedLogins / totalLogins) * 100 : 100;
    const mfaRate = totalUsers > 0 ? (mfaEnabled / totalUsers) * 100 : 0;
    return (loginSuccessRate * 0.6 + mfaRate * 0.4);
  }

  calculateComplianceScore(auditPassed: number, totalAudits: number, violations: number): number {
    const auditRate = totalAudits > 0 ? (auditPassed / totalAudits) * 100 : 100;
    const violationPenalty = Math.min(violations * 5, 50);
    return Math.max(0, auditRate - violationPenalty);
  }

  reset(): void {
    this.metrics.clear();
    this.dimensions.clear();
  }
}
