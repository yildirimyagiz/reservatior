import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tenant_application_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// TenantApplication Providers

final TenantApplicationServiceProvider = Provider<TenantApplicationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TenantApplicationService(dioClient);
});

// List Provider
final tenantApplicationProvider = FutureProvider.autoDispose<List<TenantApplication>>((ref) async {
  final service = ref.watch(TenantApplicationServiceProvider);
  return service.getTenantApplications();
});

// Create Provider
final TenantApplicationCreateProvider = FutureProvider.autoDispose<TenantApplication>((ref) async {
  final service = ref.watch(TenantApplicationServiceProvider);
  return service.createTenantApplication(TenantApplication());
});

// Update Provider  
final TenantApplicationUpdateProvider = FutureProvider.autoDispose<TenantApplication>((ref) async {
  final service = ref.watch(TenantApplicationServiceProvider);
  final state = ref.watch(TenantApplicationUpdateStateProvider);
  if (state['id'] != null && state['tenant_application'] != null) {
    return service.updateTenantApplication(state['id'], state['tenant_application']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final TenantApplicationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(TenantApplicationServiceProvider);
  final state = ref.watch(TenantApplicationDeleteStateProvider);
  if (state != null) {
    return service.deleteTenantApplication(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final TenantApplicationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final TenantApplicationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final TenantApplicationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(tenantApplicationProvider);
  final createAsync = ref.watch(TenantApplicationCreateProvider);
  final updateAsync = ref.watch(TenantApplicationUpdateProvider);
  final deleteAsync = ref.watch(TenantApplicationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
