import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/offline_sync_queue_service.dart';
import 'package:reservatior/shared/repositories/offline_sync_queue_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final offlineSyncQueueServiceProvider = Provider<OfflineSyncQueueService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OfflineSyncQueueService(dioClient);
});

final offlineSyncQueueRepositoryProvider = Provider<OfflineSyncQueueRepository>((ref) {
  final service = ref.watch(offlineSyncQueueServiceProvider);
  return OfflineSyncQueueRepositoryImpl(service);
});

final offlineSyncQueueListProvider = FutureProvider.autoDispose<List<OfflineSyncQueue>>((ref) async {
  final repository = ref.watch(offlineSyncQueueRepositoryProvider);
  return repository.getAll();
});

final offlineSyncQueueCreateProvider = StateProvider<OfflineSyncQueue?>((ref) => null);
final offlineSyncQueueUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final offlineSyncQueueDeleteProvider = StateProvider<String?>((ref) => null);
final offlineSyncQueueLoadingProvider = StateProvider<bool>((ref) => false);
