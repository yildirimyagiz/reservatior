import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_token_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ApiToken Providers

final apiTokenServiceProvider = Provider<ApiTokenService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiTokenService(dioClient);
});

// List Provider
final apiTokenListProvider = FutureProvider.autoDispose<List<ApiToken>>((ref) async {
  final service = ref.watch(apiTokenServiceProvider);
  return service.getApiTokens();
});

// Create Provider
final apiTokenCreateProvider = FutureProvider.autoDispose<ApiToken>((ref) async {
  final service = ref.watch(apiTokenServiceProvider);
  return service.createApiToken(ApiToken());
});

// Update Provider  
final apiTokenUpdateProvider = FutureProvider.autoDispose<ApiToken>((ref) async {
  final service = ref.watch(apiTokenServiceProvider);
  final state = ref.watch(apiTokenUpdateStateProvider);
  if (state['id'] != null && state['api_token'] != null) {
    return service.updateApiToken(state['id'], state['api_token']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final apiTokenDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(apiTokenServiceProvider);
  final state = ref.watch(apiTokenDeleteStateProvider);
  if (state != null) {
    return service.deleteApiToken(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final apiTokenCreateStateProvider = StateProvider<ApiToken?>((ref) => null);
final apiTokenUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final apiTokenDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final apiTokenLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(apiTokenListProvider);
  final createAsync = ref.watch(apiTokenCreateProvider);
  final updateAsync = ref.watch(apiTokenUpdateProvider);
  final deleteAsync = ref.watch(apiTokenDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
