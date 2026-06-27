import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/services/role_service.dart';
import 'package:reservatior/shared/repositories/role_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/enums/member_role_key.dart';
import 'package:reservatior/shared/enums/permission_key.dart';
import 'dio_client_provider.dart';
import 'role_management_provider.dart';

final roleServiceProvider = Provider<RoleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RoleService(dioClient);
});

final roleRepositoryProvider = Provider<RoleRepository>((ref) {
  final service = ref.watch(roleServiceProvider);
  return RoleRepositoryImpl(service);
});

final roleListProvider = FutureProvider.autoDispose<List<UserRole>>((ref) async {
  final repository = ref.watch(roleRepositoryProvider);
  final roles = await repository.getAll();
  
  // Convert Role models to UserRole objects
  return roles.map((role) => UserRole(
    id: role.id,
    role: role.key,
    permissions: role.permissions.map((rp) => rp.permission.key).toList(),
    organizationId: role.orgId,
    userId: 'system', // Placeholder - would come from actual user-role relationship
  )).toList();
});

final roleCreateProvider = StateProvider<Role?>((ref) => null);
final roleUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final roleDeleteProvider = StateProvider<String?>((ref) => null);
final roleLoadingProvider = StateProvider<bool>((ref) => false);

// User role management provider
final userRoleProvider = StateNotifierProvider<UserRoleNotifier, UserRole?>((ref) {
  return UserRoleNotifier(ref);
});

class UserRoleNotifier extends StateNotifier<UserRole?> {
  final Ref ref;
  
  UserRoleNotifier(this.ref) : super(null);

  Future<UserRole> getCurrentUserRole(String userId) async {
    try {
      final repository = ref.read(roleRepositoryProvider);
      final roles = await repository.getAll();
      
      if (roles.isEmpty) {
        throw Exception('No role found for user');
      }
      
      final role = roles.first;
      return UserRole(
        id: role.id,
        role: role.key,
        permissions: role.permissions.map((rp) => rp.permission.key).toList(),
        organizationId: role.orgId,
        userId: userId,
      );
    } catch (e) {
      // Return default read-only role
      return UserRole(
        id: 'default',
        role: MemberRoleKey.READ_ONLY,
        permissions: [PermissionKey.REPORTS_VIEW],
        organizationId: 'default',
        userId: userId,
      );
    }
  }

  Future<void> loadUserRole(String userId, String organizationId) async {
    try {
      final userRole = await getCurrentUserRole(userId);
      state = userRole;
    } catch (e) {
      // Set default role
      state = UserRole(
        id: 'default',
        role: MemberRoleKey.READ_ONLY,
        permissions: [PermissionKey.REPORTS_VIEW],
        organizationId: organizationId,
        userId: userId,
      );
    }
  }

  Future<void> assignRoleToUser(String userId, MemberRoleKey roleKey, String organizationId) async {
    try {
      final repository = ref.read(roleRepositoryProvider);
      
      // Create a new role assignment
      final newRole = Role(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        orgId: organizationId,
        key: roleKey,
        name: roleKey.name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        org: Organization(
        id: organizationId,
        name: 'mobile.leftovers.default_org'.tr(),
        type: OrgType.AGENCY,
        region: Region.USA_NORTHEAST,
        defaultCurrency: 'USD',
        defaultLocale: 'en-US',
        taxReportingEnabled: false,
        complianceTracking: false,
        requiredInspections: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        aiChatbotSessions: [],
        aiFraudDetections: [],
        aiImageAnalyses: [],
        aiInvestmentAnalyses: [],
        aiLeadScores: [],
        aiLeadScoringModels: [],
        aiMarketAnalyses: [],
        aiModels: [],
        aiModelDeployments: [],
        aiPredictions: [],
        aiPredictiveMaintenance: [],
        aiPriceOptimizations: [],
        aiPropertyDescriptions: [],
        aiPropertyValuations: [],
        aiRecommendations: [],
        aiSentimentAnalyses: [],
        aiTenantScreenings: [],
        aiValuationModels: [],
        integrations: [],
        achievements: [],
        agencies: [],
        agencyRelations: [],
        organizationAgencies: [],
        agentAssignments: [],
        agentTeams: [],
        amenities: [],
        apiIntegrations: [],
        // ... diğer alanlar
      ),
      );
      
      await repository.create(newRole);
      print('Role assigned successfully');
    } catch (e) {
      print('Error assigning role: $e');
    }
  }

  Future<void> removeRoleFromUser(String roleId, String userId, String organizationId) async {
    try {
      final repository = ref.read(roleRepositoryProvider);
      await repository.delete(roleId);
      
      // Set default role
      state = UserRole(
        id: 'default',
        role: MemberRoleKey.READ_ONLY,
        permissions: [PermissionKey.REPORTS_VIEW],
        organizationId: organizationId,
        userId: userId,
      );
    } catch (e) {
      // Handle error
    }
  }

  Future<void> assignRole(String userId, String roleId, String organizationId) async {
    await assignRoleToUser(userId, MemberRoleKey.values.firstWhere((r) => r.name == roleId), organizationId);
  }

  Future<void> removeRole(String userId, String roleId, String organizationId) async {
    await removeRoleFromUser(roleId, userId, organizationId);
  }

  bool hasPermission(PermissionKey permission) {
    return state?.permissions.contains(permission) ?? false;
  }

  bool hasRole(MemberRoleKey role) {
    return state?.role == role;
  }
}

// Role assignment provider for admin users
final roleAssignmentProvider = StateNotifierProvider<RoleAssignmentNotifier, Map<String, MemberRoleKey>>((ref) {
  return RoleAssignmentNotifier(ref);
});

class RoleAssignmentNotifier extends StateNotifier<Map<String, MemberRoleKey>> {
  final Ref ref;
  
  RoleAssignmentNotifier(this.ref) : super({});

  Future<void> loadAllUserRoles(String organizationId) async {
    try {
      final repository = ref.read(roleRepositoryProvider);
      final roles = await repository.getAll();
      
      final userRoles = <String, MemberRoleKey>{};
      
      for (final role in roles) {
        if (role.orgId == organizationId) {
          userRoles[role.id] = role.key;
        }
      }
      
      state = userRoles;
    } catch (e) {
      state = {};
    }
  }

  Future<bool> assignRoleToUser(String userId, String organizationId, MemberRoleKey roleKey) async {
    try {
      final userRoleNotifier = ref.read(userRoleProvider.notifier);
      await userRoleNotifier.assignRoleToUser(userId, roleKey, organizationId);
      
      // Update local state
      final updatedState = Map<String, MemberRoleKey>.from(state);
      updatedState[userId] = roleKey;
      state = updatedState;
      
      return true;
    } catch (e) {
      print('Error assigning role to user: $e');
      return false;
    }
  }

  Future<bool> removeRoleFromUser(String userId, String roleId, String organizationId) async {
    try {
      final userRoleNotifier = ref.read(userRoleProvider.notifier);
      await userRoleNotifier.removeRole(userId, roleId, organizationId);
      
      // Update local state
      final updatedState = Map<String, MemberRoleKey>.from(state);
      updatedState.remove(userId);
      state = updatedState;
      
      return true;
    } catch (e) {
      print('Error removing role from user: $e');
      return false;
    }
  }

  MemberRoleKey? getUserRole(String userId) {
    return state[userId];
  }

  List<String> getUsersByRole(MemberRoleKey roleKey) {
    return state.entries
        .where((entry) => entry.value == roleKey)
        .map((entry) => entry.key)
        .toList();
  }

  }
