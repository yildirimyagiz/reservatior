import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_integration_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ApiIntegration Providers

final apiIntegrationServiceProvider = Provider<ApiIntegrationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiIntegrationService(dioClient);
});

// List Provider
final apiIntegrationListProvider = FutureProvider.autoDispose<List<ApiIntegration>>((ref) async {
  final service = ref.watch(apiIntegrationServiceProvider);
  return service.getApiIntegrations();
});

// Create Provider
final apiIntegrationCreateProvider = FutureProvider.autoDispose<ApiIntegration>((ref) async {
  final service = ref.watch(apiIntegrationServiceProvider);
  return service.createApiIntegration(ApiIntegration());
});

// Update Provider  
final apiIntegrationUpdateProvider = FutureProvider.autoDispose<ApiIntegration>((ref) async {
  final service = ref.watch(apiIntegrationServiceProvider);
  final state = ref.watch(apiIntegrationUpdateStateProvider);
  if (state['id'] != null && state['api_integration'] != null) {
    return service.updateApiIntegration(state['id'], state['api_integration']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final apiIntegrationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(apiIntegrationServiceProvider);
  final state = ref.watch(apiIntegrationDeleteStateProvider);
  if (state != null) {
    return service.deleteApiIntegration(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final apiIntegrationCreateStateProvider = StateProvider<ApiIntegration?>((ref) => null);
final apiIntegrationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final apiIntegrationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final apiIntegrationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(apiIntegrationListProvider);
  final createAsync = ref.watch(apiIntegrationCreateProvider);
  final updateAsync = ref.watch(apiIntegrationUpdateProvider);
  final deleteAsync = ref.watch(apiIntegrationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
