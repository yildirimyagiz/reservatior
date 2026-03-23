import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/analysis_job_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AnalysisJob Providers

final analysisJobServiceProvider = Provider<AnalysisJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AnalysisJobService(dioClient);
});

// State Providers for create/update/delete
final analysisJobCreateStateProvider = StateProvider<AnalysisJob?>((ref) => null);
final analysisJobUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final analysisJobDeleteStateProvider = StateProvider<String?>((ref) => null);

// List Provider
final analysisJobListProvider = FutureProvider.autoDispose<List<AnalysisJob>>((ref) async {
  final service = ref.watch(analysisJobServiceProvider);
  return service.getAnalysisJobs();
});

// Create Provider
final analysisJobCreateProvider = FutureProvider.autoDispose<AnalysisJob?>((ref) async {
  final service = ref.watch(analysisJobServiceProvider);
  final state = ref.watch(analysisJobCreateStateProvider);
  if (state != null) {
    return service.createAnalysisJob(state);
  }
  return null;
});

// Update Provider  
final analysisJobUpdateProvider = FutureProvider.autoDispose<AnalysisJob?>((ref) async {
  final service = ref.watch(analysisJobServiceProvider);
  final state = ref.watch(analysisJobUpdateStateProvider);
  if (state['id'] != null && state['analysis_job'] != null) {
    return service.updateAnalysisJob(state['id'], state['analysis_job']);
  }
  return null;
});

// Delete Provider
final analysisJobDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(analysisJobServiceProvider);
  final state = ref.watch(analysisJobDeleteStateProvider);
  if (state != null) {
    return service.deleteAnalysisJob(state);
  }
});

// Loading Provider
final analysisJobLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(analysisJobListProvider);
  final createAsync = ref.watch(analysisJobCreateProvider);
  final updateAsync = ref.watch(analysisJobUpdateProvider);
  final deleteAsync = ref.watch(analysisJobDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
