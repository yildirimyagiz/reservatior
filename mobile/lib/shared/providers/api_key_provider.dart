import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_key_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ApiKey Providers

final apiKeyServiceProvider = Provider<ApiKeyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiKeyService(dioClient);
});

// List Provider
final apiKeyListProvider = FutureProvider.autoDispose<List<ApiKey>>((ref) async {
  final service = ref.watch(apiKeyServiceProvider);
  return service.getApiKeys();
});

// Create Provider
final apiKeyCreateProvider = FutureProvider.autoDispose<ApiKey>((ref) async {
  final service = ref.watch(apiKeyServiceProvider);
  return service.createApiKey(ApiKey());
});

// Update Provider  
final apiKeyUpdateProvider = FutureProvider.autoDispose<ApiKey>((ref) async {
  final service = ref.watch(apiKeyServiceProvider);
  final state = ref.watch(apiKeyUpdateStateProvider);
  if (state['id'] != null && state['api_key'] != null) {
    return service.updateApiKey(state['id'], state['api_key']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final apiKeyDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(apiKeyServiceProvider);
  final state = ref.watch(apiKeyDeleteStateProvider);
  if (state != null) {
    return service.deleteApiKey(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final apiKeyCreateStateProvider = StateProvider<ApiKey?>((ref) => null);
final apiKeyUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final apiKeyDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final apiKeyLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(apiKeyListProvider);
  final createAsync = ref.watch(apiKeyCreateProvider);
  final updateAsync = ref.watch(apiKeyUpdateProvider);
  final deleteAsync = ref.watch(apiKeyDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
