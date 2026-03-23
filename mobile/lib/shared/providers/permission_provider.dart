import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/permission_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Permission Providers

final PermissionServiceProvider = Provider<PermissionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PermissionService(dioClient);
});

// List Provider
final permissionProvider = FutureProvider.autoDispose<List<Permission>>((ref) async {
  final service = ref.watch(PermissionServiceProvider);
  return service.getPermissions();
});

// Create Provider
final PermissionCreateProvider = FutureProvider.autoDispose<Permission>((ref) async {
  final service = ref.watch(PermissionServiceProvider);
  return service.createPermission(Permission());
});

// Update Provider  
final PermissionUpdateProvider = FutureProvider.autoDispose<Permission>((ref) async {
  final service = ref.watch(PermissionServiceProvider);
  final state = ref.watch(PermissionUpdateStateProvider);
  if (state['id'] != null && state['permission'] != null) {
    return service.updatePermission(state['id'], state['permission']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PermissionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PermissionServiceProvider);
  final state = ref.watch(PermissionDeleteStateProvider);
  if (state != null) {
    return service.deletePermission(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PermissionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PermissionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PermissionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(permissionProvider);
  final createAsync = ref.watch(PermissionCreateProvider);
  final updateAsync = ref.watch(PermissionUpdateProvider);
  final deleteAsync = ref.watch(PermissionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
