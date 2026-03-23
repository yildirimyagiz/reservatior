import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/rental_sync_job_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// RentalSyncJob Providers

final RentalSyncJobServiceProvider = Provider<RentalSyncJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RentalSyncJobService(dioClient);
});

// List Provider
final rentalSyncJobProvider = FutureProvider.autoDispose<List<RentalSyncJob>>((ref) async {
  final service = ref.watch(RentalSyncJobServiceProvider);
  return service.getRentalSyncJobs();
});

// Create Provider
final RentalSyncJobCreateProvider = FutureProvider.autoDispose<RentalSyncJob>((ref) async {
  final service = ref.watch(RentalSyncJobServiceProvider);
  return service.createRentalSyncJob(RentalSyncJob());
});

// Update Provider  
final RentalSyncJobUpdateProvider = FutureProvider.autoDispose<RentalSyncJob>((ref) async {
  final service = ref.watch(RentalSyncJobServiceProvider);
  final state = ref.watch(RentalSyncJobUpdateStateProvider);
  if (state['id'] != null && state['rental_sync_job'] != null) {
    return service.updateRentalSyncJob(state['id'], state['rental_sync_job']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RentalSyncJobDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RentalSyncJobServiceProvider);
  final state = ref.watch(RentalSyncJobDeleteStateProvider);
  if (state != null) {
    return service.deleteRentalSyncJob(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RentalSyncJobUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RentalSyncJobDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RentalSyncJobLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(rentalSyncJobProvider);
  final createAsync = ref.watch(RentalSyncJobCreateProvider);
  final updateAsync = ref.watch(RentalSyncJobUpdateProvider);
  final deleteAsync = ref.watch(RentalSyncJobDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
