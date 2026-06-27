import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/enums/member_role_key.dart';
import 'package:reservatior/shared/enums/permission_key.dart';
import 'package:reservatior/shared/models/models.dart';
import 'role_provider.dart';
import 'role_permission_provider.dart';
import 'dio_client_provider.dart';

// User Role Data Model
class UserRole {
  final String id;
  final MemberRoleKey role;
  final List<PermissionKey> permissions;
  final String organizationId;
  final String userId;

  UserRole({
    required this.id,
    required this.role,
    required this.permissions,
    required this.organizationId,
    required this.userId,
  });

  factory UserRole.fromRole(Role role, List<Permission> permissions, String userId) {
    return UserRole(
      id: role.id,
      role: role.key,
      permissions: permissions.map((p) => p.key).toList(),
      organizationId: role.orgId,
      userId: userId,
    );
  }
}

// Role-based Navigation Item
class NavigationItem {
  final String title;
  final String route;
  final IconData icon;
  final List<PermissionKey> requiredPermissions;
  final List<MemberRoleKey> allowedRoles;

  NavigationItem({
    required this.title,
    required this.route,
    required this.icon,
    required this.requiredPermissions,
    required this.allowedRoles,
  });
}

// Role Management Provider - Integrates with existing API
class RoleManagementNotifier extends StateNotifier<UserRole?> {
  final Ref ref;
  
  RoleManagementNotifier(this.ref) : super(null);

  Future<void> loadUserRole(String userId, String organizationId) async {
    try {
      // This would integrate with your role service
      // For now, return a mock role
      final mockRole = UserRole(
        id: '1',
        role: MemberRoleKey.OWNER,
        permissions: [
          PermissionKey.ORG_MANAGE,
          PermissionKey.USERS_MANAGE,
          PermissionKey.PROPERTIES_MANAGE,
          PermissionKey.LISTINGS_MANAGE,
          PermissionKey.BOOKINGS_MANAGE,
          PermissionKey.LEASES_MANAGE,
          PermissionKey.CONTRACTS_MANAGE,
          PermissionKey.FINANCE_MANAGE,
          PermissionKey.REPORTS_VIEW,
          PermissionKey.EXPORTS_MANAGE,
          PermissionKey.TASKS_MANAGE,
          PermissionKey.MESSAGES_USE,
          PermissionKey.NOTIFICATIONS_MANAGE,
          PermissionKey.MLS_MANAGE,
        ],
        organizationId: organizationId,
        userId: userId,
      );
      
      state = mockRole;
    } catch (e) {
      // Handle error - set default read-only role
      state = UserRole(
        id: 'default',
        role: MemberRoleKey.READ_ONLY,
        permissions: [PermissionKey.REPORTS_VIEW],
        organizationId: organizationId,
        userId: userId,
      );
    }
  }

  bool hasPermission(PermissionKey permission) {
    return state?.permissions.contains(permission) ?? false;
  }

  bool canAccessModule(String module) {
    return hasPermission(PermissionKey.values.firstWhere(
      (p) => p.name == module.toUpperCase(),
      orElse: () => PermissionKey.REPORTS_VIEW,
    ));
  }

  String getRolePermissions() {
    return state?.permissions.map((p) => p.name).join(', ') ?? '';
  }

  bool canAccessRoute(String route) {
    final navigationItem = getAvailableNavigation().firstWhere(
      (item) => item.route == route,
      orElse: () => NavigationItem(
        title: 'mobile.auto.unknown'.tr(),
        route: route,
        icon: Icons.error,
        requiredPermissions: [],
        allowedRoles: [],
      ),
    );
    
    return (state?.role == navigationItem.allowedRoles.first) &&
           navigationItem.requiredPermissions.every((p) => hasPermission(p));
  }

  List<NavigationItem> getAvailableNavigation() {
    return _getAllNavigationItems().where((item) {
      return (state?.role == item.allowedRoles.first) &&
             item.requiredPermissions.every((p) => hasPermission(p));
    }).toList();
  }

  bool hasRole(MemberRoleKey role) {
    return state?.role == role;
  }

  String getRoleDisplayName() {
    switch (state?.role) {
      case MemberRoleKey.OWNER:
        return 'Owner';
      case MemberRoleKey.VENDOR_MANAGER:
        return 'mobile.leftovers.vendor_manager'.tr();
      case MemberRoleKey.AGENCY_ADMIN:
        return 'mobile.leftovers.agency_admin'.tr();
      case MemberRoleKey.AGENT:
        return 'Agent';
      case MemberRoleKey.ACCOUNTANT:
        return 'Accountant';
      case MemberRoleKey.MAINTENANCE:
        return 'Maintenance';
      case MemberRoleKey.TENANT_GUEST:
        return 'Guest';
      case MemberRoleKey.ORG_ADMIN:
        return 'mobile.leftovers.organization_admin'.tr();
      case MemberRoleKey.READ_ONLY:
        return 'mobile.leftovers.read_only'.tr();
      default:
        return 'Unknown';
    }
  }

  }

// Role-based Navigation Items
List<NavigationItem> _getAllNavigationItems() {
  return [
    // Dashboard - Available to all roles
    NavigationItem(
      title: 'mobile.auto.dashboard'.tr(),
      route: '/admin/dashboard',
      icon: Icons.dashboard,
      requiredPermissions: [],
      allowedRoles: MemberRoleKey.values,
    ),
    
    // Properties Management
    NavigationItem(
      title: 'mobile.auto.properties'.tr(),
      route: '/admin/properties',
      icon: Icons.home_work,
      requiredPermissions: [PermissionKey.PROPERTIES_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Listings Management
    NavigationItem(
      title: 'mobile.auto.listings'.tr(),
      route: '/admin/listings',
      icon: Icons.list,
      requiredPermissions: [PermissionKey.LISTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.AGENT, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Bookings Management
    NavigationItem(
      title: 'mobile.auto.bookings'.tr(),
      route: '/admin/bookings',
      icon: Icons.calendar_today,
      requiredPermissions: [PermissionKey.BOOKINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Users Management
    NavigationItem(
      title: 'mobile.auto.users'.tr(),
      route: '/admin/users',
      icon: Icons.people,
      requiredPermissions: [PermissionKey.USERS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Organization Management
    NavigationItem(
      title: 'mobile.auto.organization'.tr(),
      route: '/admin/organization',
      icon: Icons.business,
      requiredPermissions: [PermissionKey.ORG_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Financial Management
    NavigationItem(
      title: 'mobile.auto.financial'.tr(),
      route: '/admin/financial',
      icon: Icons.attach_money,
      requiredPermissions: [PermissionKey.FINANCE_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ACCOUNTANT, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Reports
    NavigationItem(
      title: 'mobile.auto.reports'.tr(),
      route: '/admin/reports',
      icon: Icons.analytics,
      requiredPermissions: [PermissionKey.REPORTS_VIEW],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ACCOUNTANT, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Settings
    NavigationItem(
      title: 'mobile.auto.settings'.tr(),
      route: '/admin/settings',
      icon: Icons.settings,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Security Management
    NavigationItem(
      title: 'mobile.auto.security'.tr(),
      route: '/admin/security',
      icon: Icons.security,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // AI Configuration
    NavigationItem(
      title: 'mobile.auto.ai_models'.tr(),
      route: '/admin/ai-models',
      icon: Icons.psychology,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // AI Lead Scoring
    NavigationItem(
      title: 'mobile.auto.ai_lead_scoring'.tr(),
      route: '/admin/ai-lead-scoring',
      icon: Icons.trending_up,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Communications
    NavigationItem(
      title: 'mobile.auto.communications'.tr(),
      route: '/admin/communications',
      icon: Icons.message,
      requiredPermissions: [PermissionKey.MESSAGES_USE],
      allowedRoles: MemberRoleKey.values,
    ),
    
    // Documents
    NavigationItem(
      title: 'mobile.auto.documents'.tr(),
      route: '/admin/documents',
      icon: Icons.folder,
      requiredPermissions: [],
      allowedRoles: MemberRoleKey.values,
    ),
    
    // Integrations
    NavigationItem(
      title: 'mobile.auto.integrations'.tr(),
      route: '/admin/integrations',
      icon: Icons.integration_instructions,
      requiredPermissions: [PermissionKey.GOV_INTEGRATIONS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Analytics
    NavigationItem(
      title: 'mobile.auto.analytics'.tr(),
      route: '/admin/analytics',
      icon: Icons.insert_chart,
      requiredPermissions: [PermissionKey.REPORTS_VIEW],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ACCOUNTANT, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Billing
    NavigationItem(
      title: 'mobile.auto.billing'.tr(),
      route: '/admin/billing',
      icon: Icons.receipt,
      requiredPermissions: [PermissionKey.FINANCE_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ACCOUNTANT, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Compliance
    NavigationItem(
      title: 'mobile.auto.compliance'.tr(),
      route: '/admin/compliance',
      icon: Icons.gavel,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Inventory
    NavigationItem(
      title: 'mobile.auto.inventory'.tr(),
      route: '/admin/inventory',
      icon: Icons.inventory,
      requiredPermissions: [PermissionKey.PROPERTIES_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Location Services
    NavigationItem(
      title: 'mobile.auto.location'.tr(),
      route: '/admin/location',
      icon: Icons.location_on,
      requiredPermissions: [PermissionKey.PROPERTIES_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Marketing
    NavigationItem(
      title: 'mobile.auto.marketing'.tr(),
      route: '/admin/marketing',
      icon: Icons.campaign,
      requiredPermissions: [PermissionKey.MESSAGES_USE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Mobile Device Management
    NavigationItem(
      title: 'mobile.auto.mobile'.tr(),
      route: '/admin/mobile',
      icon: Icons.smartphone,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Projects
    NavigationItem(
      title: 'mobile.auto.projects'.tr(),
      route: '/admin/projects',
      icon: Icons.work,
      requiredPermissions: [PermissionKey.TASKS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.VENDOR_MANAGER, MemberRoleKey.AGENCY_ADMIN, MemberRoleKey.ORG_ADMIN],
    ),
    
    // Scraping
    NavigationItem(
      title: 'mobile.auto.scraping'.tr(),
      route: '/admin/scraping',
      icon: Icons.web,
      requiredPermissions: [PermissionKey.SETTINGS_MANAGE],
      allowedRoles: [MemberRoleKey.OWNER, MemberRoleKey.ORG_ADMIN],
    ),
  ];
}

// Provider instances
final roleManagementProvider = StateNotifierProvider<RoleManagementNotifier, UserRole?>((ref) {
  return RoleManagementNotifier(ref);
});

// Current user role provider - would be populated from authentication
final currentUserRoleProvider = FutureProvider<UserRole>((ref) async {
  // This would be replaced with actual user authentication
  // For now, return a default owner role
  return UserRole(
    id: '1',
    role: MemberRoleKey.OWNER,
    permissions: PermissionKey.values,
    organizationId: 'org_1',
    userId: 'user_1',
  );
});

// Role-based route guard provider
final routeGuardProvider = Provider<RouteGuard>((ref) {
  return RouteGuard(ref.read(roleManagementProvider.notifier));
});

class RouteGuard {
  final RoleManagementNotifier roleManager;
  
  RouteGuard(this.roleManager);
  
  bool canAccessRoute(String route) {
    final navigationItems = _getAllNavigationItems();
    final item = navigationItems.firstWhere(
      (item) => item.route == route,
      orElse: () => throw Exception('Route not found'),
    );
    
    if (item.requiredPermissions.isNotEmpty) {
      return roleManager.canAccessModule(item.requiredPermissions.first.name);
    }
    
    if (item.allowedRoles.isNotEmpty) {
      return item.allowedRoles.contains(roleManager.state?.role ?? MemberRoleKey.READ_ONLY);
    }
    
    return true;
  }
}
