import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/offline_sync_queue_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// OfflineSyncQueue Providers

final OfflineSyncQueueServiceProvider = Provider<OfflineSyncQueueService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OfflineSyncQueueService(dioClient);
});

// List Provider
final offlineSyncQueueProvider = FutureProvider.autoDispose<List<OfflineSyncQueue>>((ref) async {
  final service = ref.watch(OfflineSyncQueueServiceProvider);
  return service.getOfflineSyncQueues();
});

// Create Provider
final OfflineSyncQueueCreateProvider = FutureProvider.autoDispose<OfflineSyncQueue>((ref) async {
  final service = ref.watch(OfflineSyncQueueServiceProvider);
  return service.createOfflineSyncQueue(OfflineSyncQueue());
});

// Update Provider  
final OfflineSyncQueueUpdateProvider = FutureProvider.autoDispose<OfflineSyncQueue>((ref) async {
  final service = ref.watch(OfflineSyncQueueServiceProvider);
  final state = ref.watch(OfflineSyncQueueUpdateStateProvider);
  if (state['id'] != null && state['offline_sync_queue'] != null) {
    return service.updateOfflineSyncQueue(state['id'], state['offline_sync_queue']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final OfflineSyncQueueDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(OfflineSyncQueueServiceProvider);
  final state = ref.watch(OfflineSyncQueueDeleteStateProvider);
  if (state != null) {
    return service.deleteOfflineSyncQueue(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final OfflineSyncQueueUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final OfflineSyncQueueDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final OfflineSyncQueueLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(offlineSyncQueueProvider);
  final createAsync = ref.watch(OfflineSyncQueueCreateProvider);
  final updateAsync = ref.watch(OfflineSyncQueueUpdateProvider);
  final deleteAsync = ref.watch(OfflineSyncQueueDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
