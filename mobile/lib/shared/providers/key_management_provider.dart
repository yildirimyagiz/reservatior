import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/key_management_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// KeyManagement Providers

final KeyManagementServiceProvider = Provider<KeyManagementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return KeyManagementService(dioClient);
});

// List Provider
final keyManagementProvider = FutureProvider.autoDispose<List<KeyManagement>>((ref) async {
  final service = ref.watch(KeyManagementServiceProvider);
  return service.getKeyManagements();
});

// Create Provider
final KeyManagementCreateProvider = FutureProvider.autoDispose<KeyManagement>((ref) async {
  final service = ref.watch(KeyManagementServiceProvider);
  return service.createKeyManagement(KeyManagement());
});

// Update Provider  
final KeyManagementUpdateProvider = FutureProvider.autoDispose<KeyManagement>((ref) async {
  final service = ref.watch(KeyManagementServiceProvider);
  final state = ref.watch(KeyManagementUpdateStateProvider);
  if (state['id'] != null && state['key_management'] != null) {
    return service.updateKeyManagement(state['id'], state['key_management']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final KeyManagementDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(KeyManagementServiceProvider);
  final state = ref.watch(KeyManagementDeleteStateProvider);
  if (state != null) {
    return service.deleteKeyManagement(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final KeyManagementUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final KeyManagementDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final KeyManagementLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(keyManagementProvider);
  final createAsync = ref.watch(KeyManagementCreateProvider);
  final updateAsync = ref.watch(KeyManagementUpdateProvider);
  final deleteAsync = ref.watch(KeyManagementDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
