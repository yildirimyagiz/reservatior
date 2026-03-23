import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/role_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Role Providers

final RoleServiceProvider = Provider<RoleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RoleService(dioClient);
});

// List Provider
final roleProvider = FutureProvider.autoDispose<List<Role>>((ref) async {
  final service = ref.watch(RoleServiceProvider);
  return service.getRoles();
});

// Create Provider
final RoleCreateProvider = FutureProvider.autoDispose<Role>((ref) async {
  final service = ref.watch(RoleServiceProvider);
  return service.createRole(Role());
});

// Update Provider  
final RoleUpdateProvider = FutureProvider.autoDispose<Role>((ref) async {
  final service = ref.watch(RoleServiceProvider);
  final state = ref.watch(RoleUpdateStateProvider);
  if (state['id'] != null && state['role'] != null) {
    return service.updateRole(state['id'], state['role']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RoleDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RoleServiceProvider);
  final state = ref.watch(RoleDeleteStateProvider);
  if (state != null) {
    return service.deleteRole(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RoleUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RoleDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RoleLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(roleProvider);
  final createAsync = ref.watch(RoleCreateProvider);
  final updateAsync = ref.watch(RoleUpdateProvider);
  final deleteAsync = ref.watch(RoleDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
