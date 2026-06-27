import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/rental_sync_job_service.dart';
import 'package:reservatior/shared/repositories/rental_sync_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final rentalSyncJobServiceProvider = Provider<RentalSyncJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RentalSyncJobService(dioClient);
});

final rentalSyncJobRepositoryProvider = Provider<RentalSyncJobRepository>((ref) {
  final service = ref.watch(rentalSyncJobServiceProvider);
  return RentalSyncJobRepositoryImpl(service);
});

final rentalSyncJobListProvider = FutureProvider.autoDispose<List<RentalSyncJob>>((ref) async {
  final repository = ref.watch(rentalSyncJobRepositoryProvider);
  return repository.getAll();
});

final rentalSyncJobCreateProvider = StateProvider<RentalSyncJob?>((ref) => null);
final rentalSyncJobUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final rentalSyncJobDeleteProvider = StateProvider<String?>((ref) => null);
final rentalSyncJobLoadingProvider = StateProvider<bool>((ref) => false);
