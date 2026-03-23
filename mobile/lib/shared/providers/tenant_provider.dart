import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tenant_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Tenant Providers

final tenantServiceProvider = Provider<TenantService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TenantService(dioClient);
});

// State Providers
final tenantCreateStateProvider = StateProvider<Tenant?>((ref) => null);
final tenantUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final tenantDeleteStateProvider = StateProvider<String?>((ref) => null);

// List Provider
final tenantListProvider = FutureProvider.autoDispose<List<Tenant>>((ref) async {
  final service = ref.watch(tenantServiceProvider);
  return service.getTenants();
});

// Create Provider
final tenantCreateProvider = FutureProvider.autoDispose<Tenant?>((ref) async {
  final service = ref.watch(tenantServiceProvider);
  final state = ref.watch(tenantCreateStateProvider);
  if (state != null) {
    return service.createTenant(state);
  }
  return null;
});

// Update Provider  
final tenantUpdateProvider = FutureProvider.autoDispose<Tenant?>((ref) async {
  final service = ref.watch(tenantServiceProvider);
  final state = ref.watch(tenantUpdateStateProvider);
  if (state['id'] != null && state['tenant'] != null) {
    return service.updateTenant(state['id'], state['tenant']);
  }
  return null;
});

// Delete Provider
final tenantDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(tenantServiceProvider);
  final state = ref.watch(tenantDeleteStateProvider);
  if (state != null) {
    return service.deleteTenant(state);
  }
});

// Loading Provider
final tenantLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(tenantListProvider);
  final createAsync = ref.watch(tenantCreateProvider);
  final updateAsync = ref.watch(tenantUpdateProvider);
  final deleteAsync = ref.watch(tenantDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
