import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';

class RolePermissionNotifier extends StateNotifier<Map<PermissionKey, bool>> {
  final Ref ref;
  
  RolePermissionNotifier(this.ref) : super({});

  Future<void> loadRolePermissions(String roleId) async {
    try {
      // Mock implementation - would integrate with actual API
      final mockPermissions = {
        PermissionKey.ORG_MANAGE: true,
        PermissionKey.USERS_MANAGE: true,
        PermissionKey.PROPERTIES_MANAGE: true,
        PermissionKey.LISTINGS_MANAGE: true,
        PermissionKey.BOOKINGS_MANAGE: true,
        PermissionKey.LEASES_MANAGE: true,
        PermissionKey.CONTRACTS_MANAGE: true,
        PermissionKey.FINANCE_MANAGE: true,
        PermissionKey.REPORTS_VIEW: true,
        PermissionKey.EXPORTS_MANAGE: true,
        PermissionKey.TASKS_MANAGE: true,
        PermissionKey.MESSAGES_USE: true,
        PermissionKey.NOTIFICATIONS_MANAGE: true,
        PermissionKey.MLS_MANAGE: true,
      };
      
      state = mockPermissions;
    } catch (e) {
      state = {};
    }
  }

  Future<void> updateRolePermissions(String roleId, List<PermissionKey> permissions) async {
    try {
      final permissionMap = <PermissionKey, bool>{};
      for (final permission in permissions) {
        permissionMap[permission] = true;
      }
      state = permissionMap;
    } catch (e) {
      // Handle error
    }
  }

  Future<List<PermissionKey>> getRolePermissions(String roleId) async {
    return state.keys.toList();
  }

  Future<void> updatePermission(String roleId, String permissionId, bool granted) async {
    try {
      final permissionKey = PermissionKey.values.firstWhere(
        (p) => p.name == permissionId,
        orElse: () => PermissionKey.REPORTS_VIEW,
      );
      
      final newPermissions = Map<PermissionKey, bool>.from(state);
      newPermissions[permissionKey] = granted;
      state = newPermissions;
    } catch (e) {
      // Handle error
    }
  }

  bool hasPermission(PermissionKey permission) {
    return state[permission] ?? false;
  }
}

final rolePermissionProvider = StateNotifierProvider<RolePermissionNotifier, Map<PermissionKey, bool>>((ref) {
  return RolePermissionNotifier(ref);
});

final rolePermissionListProvider = FutureProvider.autoDispose<List<RolePermission>>((ref) async {
  // Mock implementation
  return [];
});

final rolePermissionCreateProvider = StateProvider<RolePermission?>((ref) => null);
final rolePermissionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final rolePermissionDeleteProvider = StateProvider<String?>((ref) => null);
final rolePermissionLoadingProvider = StateProvider<bool>((ref) => false);
