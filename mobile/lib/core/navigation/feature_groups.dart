import 'package:reservatior/shared/enums/member_role_key.dart';

class FeatureGroups {
  // Admin exclusive features
  static const List<String> adminOnly = [
    'system_settings',
    'user_management',
    'organization_management',
    'ai_configuration',
    'advanced_analytics',
    'compliance_reports',
    'integration_management',
    'security_settings',
    'audit_logs',
    'api_management',
    'properties',
    'budgets',
    'expenses',
    'payouts',
    'agencies',
    'agents',
    'tasks',
    'roles',
    'documents',
    'tenants',
    'leases',
    'vendors',
    'contacts',
    'facilities',
    'maintenance',
    'marketing',
    'cloud',
    'company',
  ];

  // Agent specific features
  static const List<String> agentFeatures = [
    'property_listings',
    'client_management',
    'showings',
    'deals',
    'commission_tracking',
    'marketing_tools',
    'crm_tools',
  ];

  // Client/Tenant features
  static const List<String> clientFeatures = [
    'property_search',
    'bookings',
    'reservations',
    'payments',
    'profile_management',
    'documents',
    'notifications',
    'support',
  ];

  // Financial features
  static const List<String> financialFeatures = [
    'financial_dashboard',
    'transactions',
    'invoices',
    'tax_management',
    'budget_tracking',
  ];

  // Common features available to all roles
  static const List<String> commonFeatures = [
    'dashboard',
    'messages',
    'calendar',
    'notifications',
    'profile',
    'settings',
  ];

  static List<String> getFeaturesForRole(MemberRoleKey role) {
    switch (role) {
      case MemberRoleKey.OWNER:
      case MemberRoleKey.ORG_ADMIN:
        return [...adminOnly, ...financialFeatures, ...commonFeatures];
      
      case MemberRoleKey.AGENCY_ADMIN:
        return [...agentFeatures, ...financialFeatures, ...commonFeatures];
      
      case MemberRoleKey.AGENT:
        return [...agentFeatures, ...commonFeatures];
      
      case MemberRoleKey.ACCOUNTANT:
        return [...financialFeatures, ...commonFeatures];
      
      case MemberRoleKey.VENDOR_MANAGER:
        return ['vendor_management', ...commonFeatures];
      
      case MemberRoleKey.MAINTENANCE:
        return ['maintenance_requests', 'property_maintenance', ...commonFeatures];
      
      case MemberRoleKey.TENANT_GUEST:
        return [...clientFeatures, ...commonFeatures];
      
      case MemberRoleKey.READ_ONLY:
        return ['dashboard', 'reports', 'view_only', ...commonFeatures];
      
      default:
        return commonFeatures;
    }
  }

  static bool canAccessFeature(String feature, MemberRoleKey role) {
    final allowedFeatures = getFeaturesForRole(role);
    return allowedFeatures.contains(feature) || commonFeatures.contains(feature);
  }
}
