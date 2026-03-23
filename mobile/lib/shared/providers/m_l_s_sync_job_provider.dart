import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/m_l_s_sync_job_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MLSSyncJob Providers

final MLSSyncJobServiceProvider = Provider<MLSSyncJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MLSSyncJobService(dioClient);
});

// List Provider
final mLSSyncJobProvider = FutureProvider.autoDispose<List<MLSSyncJob>>((ref) async {
  final service = ref.watch(MLSSyncJobServiceProvider);
  return service.getMLSSyncJobs();
});

// Create Provider
final MLSSyncJobCreateProvider = FutureProvider.autoDispose<MLSSyncJob>((ref) async {
  final service = ref.watch(MLSSyncJobServiceProvider);
  return service.createMLSSyncJob(MLSSyncJob());
});

// Update Provider  
final MLSSyncJobUpdateProvider = FutureProvider.autoDispose<MLSSyncJob>((ref) async {
  final service = ref.watch(MLSSyncJobServiceProvider);
  final state = ref.watch(MLSSyncJobUpdateStateProvider);
  if (state['id'] != null && state['m_l_s_sync_job'] != null) {
    return service.updateMLSSyncJob(state['id'], state['m_l_s_sync_job']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MLSSyncJobDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MLSSyncJobServiceProvider);
  final state = ref.watch(MLSSyncJobDeleteStateProvider);
  if (state != null) {
    return service.deleteMLSSyncJob(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MLSSyncJobUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MLSSyncJobDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MLSSyncJobLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mLSSyncJobProvider);
  final createAsync = ref.watch(MLSSyncJobCreateProvider);
  final updateAsync = ref.watch(MLSSyncJobUpdateProvider);
  final deleteAsync = ref.watch(MLSSyncJobDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
