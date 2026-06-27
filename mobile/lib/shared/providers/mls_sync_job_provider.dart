import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mls_sync_job_service.dart';
import 'package:reservatior/shared/repositories/mls_sync_job_repository.dart';
import 'dio_client_provider.dart';
import 'package:reservatior/shared/models/models.dart';

final mlsSyncJobServiceProvider = Provider<MlsSyncJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsSyncJobService(dioClient);
});

final mlsSyncJobRepositoryProvider = Provider<MlsSyncJobRepository>((ref) {
  final service = ref.watch(mlsSyncJobServiceProvider);
  return MlsSyncJobRepositoryImpl(service);
});

final mlsSyncJobListProvider = FutureProvider.autoDispose<List<MlsSyncJob>>((ref) async {
  final repository = ref.watch(mlsSyncJobRepositoryProvider);
  return repository.getAll();
});

final mlsSyncJobCreateProvider = StateProvider<MlsSyncJob?>((ref) => null);
final mlsSyncJobUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlsSyncJobDeleteProvider = StateProvider<String?>((ref) => null);
final mlsSyncJobLoadingProvider = StateProvider<bool>((ref) => false);
