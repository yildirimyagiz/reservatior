import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/role_permission_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// RolePermission Providers

final RolePermissionServiceProvider = Provider<RolePermissionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RolePermissionService(dioClient);
});

// List Provider
final rolePermissionProvider = FutureProvider.autoDispose<List<RolePermission>>((ref) async {
  final service = ref.watch(RolePermissionServiceProvider);
  return service.getRolePermissions();
});

// Create Provider
final RolePermissionCreateProvider = FutureProvider.autoDispose<RolePermission>((ref) async {
  final service = ref.watch(RolePermissionServiceProvider);
  return service.createRolePermission(RolePermission());
});

// Update Provider  
final RolePermissionUpdateProvider = FutureProvider.autoDispose<RolePermission>((ref) async {
  final service = ref.watch(RolePermissionServiceProvider);
  final state = ref.watch(RolePermissionUpdateStateProvider);
  if (state['id'] != null && state['role_permission'] != null) {
    return service.updateRolePermission(state['id'], state['role_permission']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RolePermissionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RolePermissionServiceProvider);
  final state = ref.watch(RolePermissionDeleteStateProvider);
  if (state != null) {
    return service.deleteRolePermission(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RolePermissionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RolePermissionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RolePermissionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(rolePermissionProvider);
  final createAsync = ref.watch(RolePermissionCreateProvider);
  final updateAsync = ref.watch(RolePermissionUpdateProvider);
  final deleteAsync = ref.watch(RolePermissionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
